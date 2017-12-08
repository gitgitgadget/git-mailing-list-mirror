Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96AF820C3A
	for <e@80x24.org>; Fri,  8 Dec 2017 18:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751994AbdLHSXT (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 13:23:19 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55295 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750910AbdLHSXT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 13:23:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A499FD265A;
        Fri,  8 Dec 2017 13:23:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Jdv0RURGxlW56EAkYXXgm9iRdXk=; b=wue6mf
        gzaRPbkfBNSEWey9GMyCZnKkYlKI0XfzY8RF1dJlrucYcss/gHPw7LXhJoYPL9n0
        jStZstePldhxMjxH+0Va9acKB/PnscMrTIHY8q8dfx4tAxmSi169lExAp2M5Rqwe
        KRIZ386T47wi3qBR7xamaaYPTjtdCjeqwRRZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aqaIMj9/5fzjtF6lQaWy7F9ZcKL5vHXs
        2raEeRvKCzY07eZplV/NQLGwpAqDucd2gq51wYY4ADl3amwywGYvcNyXOXvM3sjz
        l220GVTu9uxSuLugBlS7++ExJru/aSKvwCEvHG0rxsLDQRBOJOKXlZT1LVOdZHZ9
        Ire3v28N8gI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B3B2D2659;
        Fri,  8 Dec 2017 13:23:18 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 10DCAD2658;
        Fri,  8 Dec 2017 13:23:17 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v7 00/16] Parial clone part 3: clone, fetch, fetch-pack, upload-pack, and tests
References: <20171208155851.855-1-git@jeffhostetler.com>
        <xmqqtvx185kq.fsf@gitster.mtv.corp.google.com>
        <67f80ac5-6530-094f-bd10-01ef8b5a6b97@jeffhostetler.com>
Date:   Fri, 08 Dec 2017 10:23:16 -0800
In-Reply-To: <67f80ac5-6530-094f-bd10-01ef8b5a6b97@jeffhostetler.com> (Jeff
        Hostetler's message of "Fri, 8 Dec 2017 13:10:39 -0500")
Message-ID: <xmqqh8t184ff.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DCF25882-DC44-11E7-B5B2-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> On 12/8/2017 12:58 PM, Junio C Hamano wrote:
>> Jeff Hostetler <git@jeffhostetler.com> writes:
>>
>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>>
>>> This is V7 of part 3 of partial clone.  It builds upon V7 of part 2
>>> (which builds upon V6 of part 1).
>>
>> Aren't the three patches at the bottom sort-of duplicate from the
>> part 2 series?
>>
>
> oops.  yes, you're right.  it looks like i selected pc*6*_p2..pc7_p3
> rather than pc*7*_p2..pc7_p3.  sorry for the typo.
>
> and since the only changes in p2 were to squash those 2 commits near
> the tip of p2, only those 3 commits changed SHAs in v7 over v6.
>
> so, please disregard the duplicates.
>
> would you like me to send a corrected V8 for p3 ?

Nah.  I just wanted to make sure that I am discarding the right ones
(i.e. 1-3/16 of partial-clone, not 8-10/10 of fsck-promisors).

Thanks for an update.

