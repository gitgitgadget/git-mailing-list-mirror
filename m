Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAAEC47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 06:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C8DD610C9
	for <git@archiver.kernel.org>; Mon, 31 May 2021 06:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhEaG7L (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 02:59:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61240 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbhEaG67 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 02:58:59 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C4300B3CBC;
        Mon, 31 May 2021 02:57:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=os7kjTgbQgMl
        IZ1T5HOFNw28VA03PHq6snRp/fn2rlM=; b=mLF1fn3AL9Q2S6eSazUTq8LDHpY4
        Ji/fem5mGa/c9TQhxjyfS5PuND5aIXNAAbZITgkRAKFQNObFH0XByRhTL057RKtR
        MPq9CrOdqdQu9KBg1WIpwhH+PLztMduFpdIRRRDfsMsbYNbaS1qOv3R64mspWkny
        wLv3h81r/Qw62U0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BAA0BB3CBB;
        Mon, 31 May 2021 02:57:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3E0F0B3CB8;
        Mon, 31 May 2021 02:57:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Andy AO via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Derrick Stolee <stolee@gmail.com>, Andy AO <zen96285@gmail.com>
Subject: Re: [PATCH] describe-doc:fix a obscure error description in the git
 log documentation
References: <pull.1030.git.git.1622440856607.gitgitgadget@gmail.com>
        <YLSGasYc4wVoOfYt@danh.dev>
Date:   Mon, 31 May 2021 15:57:17 +0900
In-Reply-To: <YLSGasYc4wVoOfYt@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcuG6p24g?=
 =?utf-8?B?Q8O0bmc=?= Danh"'s message of
        "Mon, 31 May 2021 13:47:06 +0700")
Message-ID: <xmqqmtsbv19u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 70685C02-C1DD-11EB-9185-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> Please use your real name and wrap your commit message at 50
> characters for subject line and 72 characters for body.

Very good suggestions.  Thanks for raising these issues.

> The default option is documented correctly as short.
> Please check out builtin/log.c:decorate_callback and
> builtin/log.c:parse_decoration_style.
>
> Below command print nothing in my machine:
>
> 	git log --decorate -1 >/tmp/default
> 	git log --decorate=3Dshort -1 >/tmp/short
> 	cmp /tmp/default /tmp/short
>
> I'm curious about your config and/or command invocation.
> From the code, I can't guess which scenario that's different.

You two are thinking about two "defaults", I think.  If a --decorate
option you give does not say which kind of decoration you want, by
default, you see the short output.  The above shows that.

If you do not give any --decorate option, the command behaves as if
you gave --decorate=3Dauto, which is what the patch author wanted to
say, I think.

> I think you meant:
>
> 	git log -1 >/tmp/no-decorate

Yes, and this (with redirection to file), I think you do not get any
decoration---that is what you get from --decorate=3Dauto, i.e.

	git log --decorate=3Dauto -1 >/tmp/auto-decorate

I think the default discussed in the paragraph the patch touches is
"what happens if you do not say what kind, i.e. "--decorate" not
"--decorate=3D<what kind>", so "the default is 'short'" is correct,
but at the same time, "even if you do not say --decorate, you'll see
short decoration when on a terminal" is worth mentioning somewhere.
