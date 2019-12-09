Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE57C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 08:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18FAC206D3
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 08:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZYBfqC4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfLIIQE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 03:16:04 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:35824 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfLIIQD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 03:16:03 -0500
Received: by mail-il1-f194.google.com with SMTP id g12so11968645ild.2
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 00:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aL8F5ScfIWCpPVHv8Um8NLU93FPfY99nzbG1ql9qqcY=;
        b=jZYBfqC4biKq8W0r3Gp+K18tECCXD82RKOfrF25r3vvHcoNp7KSxPQ7OiFibln5CIG
         Q6AArDJ21SHOMNvnkmHqWNT0KE2W39osv8hiyroIm62a3S5jYzFQ/1SQMMdpDyxqnxQl
         fMNKsFndZHctbZYdkj9x/1f8MABFGjsR7/e15/a6haNIfIzB2CKCNrDZbnVD2hExWKW6
         0+tNkSjTg5ROHNxFU83tAxAQ3jb3H+ZwoAYjtZ3tA0Vrs4JF6v9axgBrSj+u8cFiG1oT
         y83wp0Rr5Tolq7ueek08JmMewhv54Zg5RenEBOQODglqJ3Ao7VSmIypA6rR3APfjfqG0
         U8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aL8F5ScfIWCpPVHv8Um8NLU93FPfY99nzbG1ql9qqcY=;
        b=kKTHa3ytGTsRqT7M6CL8swcEqAhEARFKdlEtRg1d6/xL+GiY2RFYMHPEArkPLq/Zfj
         KIxTy9outYd9Pdw0NRVH0kCQ/I7ClQzDD5wOviJskvdQ00DVnbiclrLw96ZYTBgqYYvS
         AlagrPTdUz4ofiEgt4vgk/42+2un2sShSKaDUVIelBpqVoCdfa0NCaEvXnpaSmqatt/e
         CLPKdMLvHDGH0PJpEybfojEDwyeOy159C2866E9Tq792zp/ZFjoYDY0vBbQO1bm7WG7k
         a/V/J1X20QI4ZXXDlCf/KUPTZsX7paeEGayJFaAfDtcRZdnNUHgqoV1J4W+l+X/9EBOs
         7pQQ==
X-Gm-Message-State: APjAAAV3k5Z6o7d+mHNN5ZrOx3mPRmKeBiIQ82w40HJMISf3ecFKQxLy
        KbUljbX5s8aQNYb5MjAx6RZhS1j+vq4gxJWHNlTsKZTMDsw=
X-Google-Smtp-Source: APXvYqyfQSpHV4V6N4JG5u+uhQH2UrasUUHvWxlrKOiJewai4/NVLZ1RoYads6PS7tAEk6NkRSuRdFrvlHfsNODdRSo=
X-Received: by 2002:a92:3c08:: with SMTP id j8mr3518444ila.127.1575879363124;
 Mon, 09 Dec 2019 00:16:03 -0800 (PST)
MIME-Version: 1.0
References: <20191208172813.16518-1-mirucam@gmail.com> <nycvar.QRO.7.76.6.1912082003420.31080@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1912082003420.31080@tvgsbejvaqbjf.bet>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Mon, 9 Dec 2019 09:15:52 +0100
Message-ID: <CAN7CjDC7V+4ZR=1vy=BitVNUakKpuZVpvdf_BsDL2X6fjAjc7g@mail.gmail.com>
Subject: Re: [Outreachy] [PATCH] bisect--helper: refer branch.buf before strbuf_release(...)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

El dom., 8 dic. 2019 a las 20:12, Johannes Schindelin
(<Johannes.Schindelin@gmx.de>) escribi=C3=B3:
>
> Hi Miriam,
>
> welcome to the Git project!
>
Thank you! :)

> On Sun, 8 Dec 2019, Miriam Rubio wrote:
>
> > From: Tanushree Tumane <tanushreetumane@gmail.com>
>
> Is this really a patch authored by Tanushree, or is this a fix written by
> you, intended to fix a patch authored by Tanushree?
>

This is really a patch authored by Tanushree.

> If it is the latter, please use a completely new commit message and take
> the authorship yourself.
>
> > Move `error("...%s...", branch.buf);` before `strbuf_release(&branch);`
> > to release string buffer `branch` and the memory it used.
>
> This describes the "what?", but the patch already does that. The commit
> message should be more about the "why?".
>
> In this instance, I believe that the commit message should read more like
> this:
>
> -- snip --
> bisect--helper: avoid free-after-use
>
> In 5e82c3dd22a (bisect--helper: `bisect_reset` shell function in C,
> 2019-01-02), the `git bisect reset` subcommand was ported to C. When the
> call to `git checkout` failed, an error message was reported to the
> user.
>
> However, this error message used the `strbuf` that had just been
> released already. Let's switch that around: first use it, then release
> it.
>
> Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> -- snap --
>

Ok! Thank you for your advice with the message.

> >
> > Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> > Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> > Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> > ---
> >  builtin/bisect--helper.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> > index 1fbe156e67..3055b2bb50 100644
> > --- a/builtin/bisect--helper.c
> > +++ b/builtin/bisect--helper.c
> > @@ -169,11 +169,12 @@ static int bisect_reset(const char *commit)
> >
> >               argv_array_pushl(&argv, "checkout", branch.buf, "--", NUL=
L);
> >               if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
> > +                     error(_("could not check out original"
> > +                             " HEAD '%s'. Try 'git bisect"
> > +                             " reset <commit>'."), branch.buf);
> >                       strbuf_release(&branch);
> >                       argv_array_clear(&argv);
> > -                     return error(_("could not check out original"
> > -                                    " HEAD '%s'. Try 'git bisect"
> > -                                    " reset <commit>'."), branch.buf);
> > +                     return -1;
>
> The patch looks good.
>
Great :). I'll change the commit message and I'll resend the patch.

> Thanks!
> Johannes
Thanks,
Miriam
>
> >               }
> >               argv_array_clear(&argv);
> >       }
> > --
> > 2.21.0 (Apple Git-122.2)
> >
> >
