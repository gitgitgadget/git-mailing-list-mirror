Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B3FC433FE
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 01:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 830B923BC7
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 01:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgLJB4z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 20:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbgLJB4u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 20:56:50 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF518C0613CF
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 17:56:07 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id q75so3687767wme.2
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 17:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q3Qwv1BNNm13Llj2smw810AX1mscfbkR3+o7HJhNMLg=;
        b=MFoVdj8XWOko0Ul5SPVisGzZnz0VkDyqw8CETOQ9BXtzyJ5hIXpbj38TWhAy94XI60
         yIBhZohWiQ066ZWBCf4/nJQL/TrWn3IG1DhNAN4lOCCha5ooRbR+p7tdKirY/uKcRx2w
         SineK/VwALxAuKqZsG9hNYSvffM0kQzedxQrzMyg2Ss78Rei6ARbJrNIHj0ga4dgzbgP
         MrSr7D3zjLiu9k6abdFkzazVK2Chtt2Lm6eculYSQfCh3++jxT4ohPMNTGd+oGgK5j4A
         CzBa54kUgnOo6Fd3O9tbwdNypVL/WAWtNcT+oDvWQyoQQKtMT80kuSl07CKCaE0BqzcN
         /mZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q3Qwv1BNNm13Llj2smw810AX1mscfbkR3+o7HJhNMLg=;
        b=tfk16EMVi+Gjdl3oTR/vLgnIUpl6enkMkjS9tfxAgBq7zXxZRoDLLVd3E40uYDQAhI
         SAG4zFw8qASH2saNrem0xyQ8otLcCHOMWwXST1nfvnQauJa6s1kX4qQrYZED5FEfMWL6
         kCfcnBjRlRjGmDSsdVKGLzKIytq8RX0ByjX243f26FV5Z+WHIyXWpnooXslMZmtmM5PT
         D3Iqc0zdNs1mAhNx9AoCokcV9xO9scG5z9CG4SxIJ0MyOjjNP+ecc4lRaeUUojayV0jq
         lbsGORlFQ6MVzs+z1ys14H5HC6S7vp/pXpd0tfttm8VfMlyEOCOAClQ+EDfirNHZYd6D
         n1Zw==
X-Gm-Message-State: AOAM5305gvedoFFKaJygDO/MvxuqyLa5zfrrR1ouBDLgj1MEEq6xbC2K
        NmzwD2ngdoqGh+asI6JZFUkr+1aJadfUktFkzbY=
X-Google-Smtp-Source: ABdhPJw9CAam56aC7Mc9sjNTGWSk4bn+cN/BBaSdAw0TA5AH2JUr5SzB5EKfDbY+EKpXUQrkJqpACmNSAFh7/MsjR3s=
X-Received: by 2002:a05:600c:210e:: with SMTP id u14mr5623408wml.48.1607565366448;
 Wed, 09 Dec 2020 17:56:06 -0800 (PST)
MIME-Version: 1.0
References: <20201209065537.48802-1-felipe.contreras@gmail.com>
 <20201209065537.48802-2-felipe.contreras@gmail.com> <X9EI8c9yeX136ewm@coredump.intra.peff.net>
In-Reply-To: <X9EI8c9yeX136ewm@coredump.intra.peff.net>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 9 Dec 2020 19:55:55 -0600
Message-ID: <CAMP44s19FKYT5LNUxbGZP3czFmhe9t5B-FAfH+V2btNvMNW31g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Add project-wide .vimrc configuration
To:     Jeff King <peff@peff.net>
Cc:     Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Aaron Schrab <aaron@schrab.com>,
        Denton Liu <liu.denton@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 9, 2020 at 11:27 AM Jeff King <peff@peff.net> wrote:
>
> On Wed, Dec 09, 2020 at 12:55:36AM -0600, Felipe Contreras wrote:
>
> > +augroup git
> > +     au BufRead,BufNewFile */Documentation/*.txt set filetype=asciidoc
> > +
> > +     au FileType c setl noexpandtab tabstop=8 shiftwidth=0 cino=(s,:0,l1,t0
>
> I had to read up on a few of these settings, and I'm still slightly
> puzzled:
>
>   - I generally leave shiftwidth=8, but reading the documentation says
>     that 0 is equivalent to "1 tabstop". So that should be equivalent.

Yes. It is.

If you read the help of tabstop [1] it says there are four main ways
of using tab, and we are using the fourth one: "always set 'tabstop'
and 'shiftwidth' to the same value, and 'noexpandtab'."

Other projects use a different tabstop, and expandtab (mode 2),
however, I have *never* found a use case where it made sense to have a
different shiftwidth than tabstop. And it gets tedious to *always* do
ts=X sw=X, when you can just do sw=0 in your ~/.vimrc, and ts=X per
project.

>   - I've been using "(0" for years for my git work (which indents to
>     align new lines with the unclosed parenthesis). I'm not quite sure
>     what "(s" means. The documentation says "1s" would be "one
>     shiftwidth". Is just "s" the same?

Yes. If you read CodingGuidelines it says there are two schools of
thought when it comes to splitting long logical lines. The first
example is "(s", the second one is "(0".

The reason why I prefer "(s" is that this is more commonly used in the
Linux kernel. However, it's not quite the same in vim (when there's
more than one parenthesis). I've planned to contact vim developers
about that, but I haven't yet. Just for that reason it might make
sense to use "(0" for the project.

>   - I also have ":0", which doesn't indent case labels. Matches our
>     style.
>
>   - I didn't have "l" set myself. I never noticed because it only
>     matters if you open a case with an extra brace, which is relatively
>     rare. For non-vim folks, it is preferring:
>
>         switch (foo) {
>         case 0: {
>                 break;
>         }
>
>     to:
>
>         switch (foo) {
>         case 0: {
>                         break;
>                 }
>
>     which seems consistent with our style. So I think that is worth
>     doing.
>
>   - t0 is specifying not to indent function return types when they
>     appear on a separate line. But our style is not to put those return
>     types on a separate line, anyway. Do we need this?

Right. I recall at some point it was annoying me that types were auto
indented magically at wrong times. Testing "ts" that doesn't seem to
happen anymore, but it also doesn't seem to be working at all.

Do you see some difference from "t0" and "ts" with:

  void
  main(void) { }

Cheers.

[1] https://vimhelp.org/options.txt.html#%27tabstop%27

-- 
Felipe Contreras
