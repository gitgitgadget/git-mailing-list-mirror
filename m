Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3C6C2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 22:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1152A2076E
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 22:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlfcwkSS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbgKXWwa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 17:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbgKXWw3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 17:52:29 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F55C0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 14:52:29 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id l22so198497vsa.4
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 14:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ouvuJJQrY+brd0CdbUErG4oeMdXYBizDgUBlHgzl8w=;
        b=BlfcwkSS9ZKu4KXs/cER8xXDEF7Tkuq8iYzhuXbB5Ye/RJ58Qpik3womrF81HWf02l
         j0qisk0Kfd/0GD7MhUGoAd0WbEfMoWJDzN8YSG6nOrclK7VXp3BJEq/o4MsBXBFYAM/R
         A+eUNaok4lI7WDAkdrqiG2RqS5pgXxa98UFAqoa0qV7CcNcvsic5YFOhQ2qOydsKNDa0
         O/inIzdMev2+4smN5IedkUerU5dY8nB9VdBKEA58tPJIAt4AY1+v+BgrbTZHTRqXQv9d
         U+OZAWoT103fFa76Gmt3aDlcikH9zNVlzS1SoSoFVBEq5TX/pHmdkm6ZPsVOK4wp02/K
         8awQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ouvuJJQrY+brd0CdbUErG4oeMdXYBizDgUBlHgzl8w=;
        b=dibxNvLjbk4KpT/tlggl1vbixf0D4cE9QqJxPJoYw6Jz+8SQn+Aige/os9YBqhX9+7
         IsCChOCcWu1mD7tLYYLFeC35PrrYbIw2N13QkC7mHD5LwpovD7yug0ZOU4VBunp7vxTU
         qe/mboTx2+HgJokP7j593S+jkCN6WM5OOxgzpbST2jwXbELVpLzchYwNINZR2Daw64Td
         cyDA4yGSqLjbjF9QbxIYDKUHe5X3d0nzSsfxIp2ChQtE0KsYj51nRE6R327lZRoYyhf0
         h2Z6CgCpNJ7wUQQvA/FsKCuwomVxm69bVcdy2XHrvMndZ5Rwqjoktiup+pcpkTIir1jN
         9zqg==
X-Gm-Message-State: AOAM5326YqRc39yasUrfBjKXYtfW2Ozqi49qpp5kwrrWrvhB+PHjOkoo
        /FWZ6w+cDhqRJHYrKNsCN40M62AUhKsCIPJjijE=
X-Google-Smtp-Source: ABdhPJw3bOkcbFJwSeLyxeQ8Kj/PAQHjGwrG0HT6No/EY5yEfeIDN2O69GimcTK0WDHoX9VOCW1XMibYVMLKODNajnw=
X-Received: by 2002:a05:6102:2362:: with SMTP id o2mr356083vsa.5.1606258348767;
 Tue, 24 Nov 2020 14:52:28 -0800 (PST)
MIME-Version: 1.0
References: <20201122164641.2091160-1-felipe.contreras@gmail.com>
 <X7y5Wxu1eY4k6753@coredump.intra.peff.net> <xmqqlfeqjzi1.fsf@gitster.c.googlers.com>
 <CAMP44s0PwJ8qEuCCpavshpm0GqV8p37rF8McR2=gdCk2kj+JiQ@mail.gmail.com> <xmqqo8jmgyrd.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqo8jmgyrd.fsf@gitster.c.googlers.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 24 Nov 2020 14:52:19 -0800
Message-ID: <CA+P7+xr8_s0Fq_TGjDjHEPpGJ8Br5x7omY1fsg0HjcXjutyRkg@mail.gmail.com>
Subject: Re: [PATCH] refspec: make @ a valid refspec
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>, Git <git@vger.kernel.org>,
        Brandon Williams <bwilliams.eng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 24, 2020 at 2:45 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> >> I too find that "@ is a shortcut for HEAD" looks ugly both at the UI
> >> level and at the implementation level [*1*], but as long as we have
> >> it, it is good to try to be consistent and allow "@" everywhere
> >> where one would write "HEAD" in places where it is syntacitically
> >> infeasible---at least we would be consistently ugly that way ;-).
> >
> > Beauty is in the eye of the beholder.
>
> Using "@" is rather "illogical" than "ugly", and at that point it is
> not so subjective.
>
> @-mark leads a suffix that applies some "magic" to what comes before
> it (e.g. next@{1}, maint@{2.weeks.ago}, and master@{-1}).  Making @
> a synonym for HEAD means '@' sometimes means a ref and most of the
> time means the introducer of magic that applies to a ref.
>
> Worse yet, @{4} does not refer to HEAD@{4} but refers to the 4-th
> previous commit the current branch pointed at, so a mnemonic for the
> end user to remember the distinction between the two is that a bare
> "@" is different from HEAD, which is a total opposite X-<.
>

However, @{0} *does* refer to what is currently checked out, which
would be head.. So in a sense @ meaning "the current branch" and
applying @{0} would always be HEAD, no?

I think it sort of works, but yea it is a bit messy.

Thanks,
Jake
