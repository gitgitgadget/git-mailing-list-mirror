Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F61C1F462
	for <e@80x24.org>; Mon, 17 Jun 2019 19:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfFQTyr (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jun 2019 15:54:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50505 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727419AbfFQTyr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jun 2019 15:54:47 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2EFCA151FCF;
        Mon, 17 Jun 2019 15:54:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4ubLARnfypcvbIi85DsdPtfTPeY=; b=mUSp7z
        jVmgpn5mCJQmWNe4Nc47R4ySRVtwGtPh8DXaNwkxoLID3syW4kTforCWlecRn46i
        //rOWeeuTYBf8q1Qtex9HXtl/8lD/OlYkWBWe3laPHJAlEH+qkqwqON0TY7oyQjD
        PB7nf8d1RdR9O4LaQljkjBIMQOUNK0EvH+sYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yMzyPr65VqgUTS0ER3u7gD5/RG9Kjf0q
        541pmQJSXjxB5vD+eXP+roLTLUk4byFndXZX5LKf9NlNJVn/YREHzkNfMQDOeqj1
        JQvVgEIjFf0TAM+2zs0Ve4uSHhq8561ksgi0aXF1gbwB5kcmYfN9GGmPwn1+K/rb
        SlGsX+c9Nak=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 268D1151FCE;
        Mon, 17 Jun 2019 15:54:45 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 751BB151FCD;
        Mon, 17 Jun 2019 15:54:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: js/gcc-8-and-9, was Re: What's cooking in git.git (Jun 2019, #04; Fri, 14)
References: <xmqqh88ruc1b.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1906171940201.44@tvgsbejvaqbjf.bet>
Date:   Mon, 17 Jun 2019 12:54:43 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1906171940201.44@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 17 Jun 2019 19:41:21 +0200 (CEST)")
Message-ID: <xmqqpnncrnr0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C0C7B75A-9139-11E9-91CA-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Fri, 14 Jun 2019, Junio C Hamano wrote:
>
>> * js/gcc-8-and-9 (2019-06-13) 4 commits
>>  - config: avoid calling `labs()` on too-large data type
>>  - winansi: simplify loading the GetCurrentConsoleFontEx() function
>>  - kwset: allow building with GCC 8
>>  - poll (mingw): allow compiling with GCC 8 and DEVELOPER=1
>>
>>  Code clean-up for new compilers.
>>
>>  The 'kwset' one may want to be discussed a bit longer.  Perhaps
>>  merge the other three earlier to 'next' and then to 'master'
>>  separately?
>
> Or just take the kwset one with an adjusted commit message because it may
> turn out that the kwset update will be blocked for a while because of
> licensing issues?

Sorry, but I do not understand why you'd want to "take" one that you
suspect may be blocked for a while.  I'd rather see us unblock the
other ones that are unproblematic, without taking them hostage,
which was what I meant.

