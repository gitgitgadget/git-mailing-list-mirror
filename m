Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC953C83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 18:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 846AA208E0
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 18:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PSkSUyoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgD1SKa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:10:30 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63807 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbgD1SKa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 14:10:30 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7708BCEB6D;
        Tue, 28 Apr 2020 14:10:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o3kLek8kfIb9aXH1mhEYLFScIG8=; b=PSkSUy
        oZpkVvGnlytQmzyf4VOw4H6ERk5P/3/x6IqwrhgkWRUbZ+9jHyqfDz9+x2CWmLLM
        rk2L9hpXdh9sjrAA6Eeez32O/FA8E39Xmtgr+6UDo9lcZlyugeRNIW4HXIhW7Jio
        m6wZG0lfRFaK3ePLJi/ET7/4EjEA7aLhc4jAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MpEvn8VjlwAp8JXlJTgMs+6VuaqZJM3N
        b1FWsg2jHbls16RYY5lNhPoRXjZh92VD25cEm0cfM1rROAmL/hP75diguNlblOGC
        agYPB5IZu81CvAx2KOzaws0UJ5eK7O9z5UE2l9nisk/ivp5NDd0+aPg1TOwvdugu
        ssXql9b3RE8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 704EFCEB6C;
        Tue, 28 Apr 2020 14:10:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BC868CEB6B;
        Tue, 28 Apr 2020 14:10:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 05/11] completion: add test showing subpar completion for git switch --orphan
References: <20200425022045.1089291-1-jacob.e.keller@intel.com>
        <20200425022045.1089291-6-jacob.e.keller@intel.com>
        <xmqqv9lk5wqy.fsf@gitster.c.googlers.com>
        <CA+P7+xpEMb-A1cOkOxdWf0pM=5o8Cyn9=5HLZPtFNMcLUaypsg@mail.gmail.com>
        <xmqqo8rb4lyj.fsf@gitster.c.googlers.com>
        <CA+P7+xoBnS8huHiU+QM8x6LRiSDRYVVS2pduv6i_qrwb1ZS7fg@mail.gmail.com>
Date:   Tue, 28 Apr 2020 11:10:24 -0700
In-Reply-To: <CA+P7+xoBnS8huHiU+QM8x6LRiSDRYVVS2pduv6i_qrwb1ZS7fg@mail.gmail.com>
        (Jacob Keller's message of "Tue, 28 Apr 2020 10:32:02 -0700")
Message-ID: <xmqqsggn32i7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 88D4D202-897B-11EA-BE9F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

>> And that same "is this really helping?" reasoning applies equally to
>> the "--orphan" option.
>>
>> I dunno.
>>
>
> Fair enough, new branches based on previous branches makes sense.

I actually do not have a strong opinion either way.  I just wanted
to say that it would be good to make it consistent across "checkout
-b", "switch -c" and "checkout/switch --orphan".

It would be nice if "checkout -B" and "switch -C" pair offered
existing branches, as the intention of using the capital letter is
clear---the user wants to overwrite an existing one.

On the other hand, I am OK if "checkout -b", "switch -c" and
"--orphan" offered either:

 (1) nothing, as your patch does, or

 (2) all branches, except for the currently checked out one.

It would be preferrable if they did the same thing.

Thanks.

