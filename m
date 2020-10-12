Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8FAC433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 20:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD1C7208D5
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 20:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NUN4TqoJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgJLUgn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 16:36:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64195 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgJLUgn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 16:36:43 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 568CF8DC65;
        Mon, 12 Oct 2020 16:36:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=6xERvslu59+ix7njduaeheehFD0=; b=NUN4Tq
        oJQsU831GgFTCEQu9Xqc/iJ7sDW3hMseu3Oq36cqF4rcX8Axa2sYNvY4CZH0Ix77
        L05GVY/VvEDd/MFAd4ioosNMF4hvJrN72/7SwmyTepiwVMNPabInVIsHMwKH5lro
        07ntDqh7RxcU9aLSIphGH4T297KcKteUy4NTA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YzpeMP/iXWHts4qKhAACj8gK9v8XrvxL
        wa5k6cym3hHsKsDmWwRkExvch+PRNVWfJezgu3usPrl2MHlWBkwQWt1GG27xsZuv
        pUpDTFc+ms3NFzN3R19WYvHVLIaEDM+71LmltEUBWGmB4F+FlbBTpI55Y82DqZVr
        VcAsietdiE8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F4818DC64;
        Mon, 12 Oct 2020 16:36:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D01868DC63;
        Mon, 12 Oct 2020 16:36:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        git@vger.kernel.org
Subject: Re: Patchwork now does the right thing with GGG submissions
In-Reply-To: <20201012193850.GE3740546@google.com> (Jonathan Nieder's message
        of "Mon, 12 Oct 2020 12:38:50 -0700")
References: <20201012180034.tu4rmeoadhy5j4w7@chatter.i7.local>
        <20201012193850.GE3740546@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Mon, 12 Oct 2020 13:36:39 -0700
Message-ID: <xmqq362jnpuw.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A22CBE86-0CCA-11EB-942D-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Konstantin Ryabitsev wrote:
>
>> Just FYI, I made the necessary tweaks to patchwork to make it properly
>> assign "From" for gitgitgadget submissions:
>>
>> https://patchwork.kernel.org/patch/11832689/
>
> \o/ Thanks much for this.
>
> For the curious, any links to the change behind the scenes that made
> that happens?  Does it use Sender[1] or a different field?  Does the
> change live in [2] or [3]?
>
> Sincerely,
> Jonathan

It is curious that I sometimes see you respond to Konstantin on this
list, but the message you are responding to is not found.  What is
going on?

A question to Konstantin is what is so special about GGG?  Did you
make patchwork to pay attention to the in-body "From:" and other
in-body header lines (in which case it benefits not just GGG but
everybody).  If you added a support to ignore everything before the
scissors that would deserve an extra gold star ;-)

For example, how does

https://lore.kernel.org/git/xmqqy2kwiimi.fsf@gitster.c.googlers.com/

appear in patchwork?

> [1] https://lore.kernel.org/git/xmqqiml4bsra.fsf@gitster-ct.c.googlers.com/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/mricon/korg-helpers.git/
> [3] https://github.com/getpatchwork/patchwork
