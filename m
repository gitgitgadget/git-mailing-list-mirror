Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71851C433E7
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 18:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B79222261
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 18:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVfYnKaa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbgJRSi5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Oct 2020 14:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgJRSi5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Oct 2020 14:38:57 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387DCC061755
        for <git@vger.kernel.org>; Sun, 18 Oct 2020 11:38:57 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id t25so10765247ejd.13
        for <git@vger.kernel.org>; Sun, 18 Oct 2020 11:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WWFbZmCng5heUtHkOQFaoVdbonxly7trJU72KXtxni8=;
        b=AVfYnKaa9WiTkRcZJ4+PIOVuMMztB5Y3jI9s4jgF0C0J4YUhHBOILuqKvqlyb8xkKs
         OJs5dK4HJuw7UAajNJvX3ecQRogDdukllHR+deWmm1dLPRX58V0hdaUzxt2caxwoVw/Q
         2v2I/qNrOGh5DLQUU9/UkCd6WPFZFMOqq8hnSKUeS0/rI4zmuMSbNfjEfgmwtu7zRYgW
         K2FlB1tD+Az3accPqzvU1kPFXCI+zD5165OSKLYIlizpqVctk1TOmKy+diE2V89YiJHN
         9P9g918d1uDP0yG0ZJ19ZfQG0ag9h/VJT4vEyAS/N5iUvkLF2WcKbtNHVyDXnctZt9+F
         YjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WWFbZmCng5heUtHkOQFaoVdbonxly7trJU72KXtxni8=;
        b=T55GloDEqr7TNXsotN2K9E2VtlQ95ftfsl+ho6Fz5O2Ig/zx5WFLEmqsTewE6qA1pv
         27qU/KPOSk/wKOR63Gr92bply3S7BDJC5lAWGuWls3qTaBPH54wSNuPU+lhwCdHvkpIn
         F9h3nSH9ZWZ3+F58sCNLvbc5uPbhWfjGP8cKobWh5UuHf5IjjIwWgrNW/0Sg6TihgXdu
         I8bBUmveUOj/t9eZHuy07Cpo1vMsE8a6VX5bkMeg4hOv//gQXf53VLqdEvGFndxd/yA0
         E4YVHm3eUDXghkgI/QaTS204ieYx4GW6RBM0BRfhviF6t0/JwtNJ+hWJ8d4p5hfXF1cA
         niiA==
X-Gm-Message-State: AOAM530vDCr0z78K/LkN++Bc0KbqQNprZfwOvATXbjosvkOIZKaUYHF6
        +mMiHvvZ2uyMPaKBmoLYJf2ZJ4Xjxjy0cVBgAAM=
X-Google-Smtp-Source: ABdhPJyPuburzHOiEMyoqfQ5eoon9kfDuHQ71ZYcexSmP62JldVKxOFWFBCZDvdc8qUqLa0gjGQNE7CtJQkak+HL144=
X-Received: by 2002:a17:906:1fc7:: with SMTP id e7mr14497607ejt.283.1603046335748;
 Sun, 18 Oct 2020 11:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201018061052.32350-1-caleb.tillman@gmail.com> <20201018130219.GA6749@konoha>
In-Reply-To: <20201018130219.GA6749@konoha>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 18 Oct 2020 20:38:44 +0200
Message-ID: <CAP8UFD1Ux7uu637_0NF4TCPJq4++KARkRm+g26ou9AdZb06OcA@mail.gmail.com>
Subject: Re: [Outreachy-Microproject][PATCH 1/1] t0000: replace 'test -[def]'
 with helpers
To:     Shourya Shukla <shouryashukla.oo@gmail.com>,
        Caleb Tillman <caleb.tillman@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shourya and Caleb,

On Sun, Oct 18, 2020 at 4:12 PM Shourya Shukla
<shouryashukla.oo@gmail.com> wrote:
>
> Hello Caleb,
>
> I have some comments.
>
> First of all, I notice that this is a v2 of this PATCH:
> https://lore.kernel.org/git/20201018005522.217397-1-caleb.tillman@gmail.com/
>
> So, I think that the subject of the mail should reflect the same. I
> believe that you have used 'git format-patch' to generate this mail
> therefore what you can do is:
>
> 'git format-patch -v2 @~n', where 'n' is the number of commits which you
> want to include in the patch. So in your case it will be:
> 'git format-patch -v2 @~1' and a patch mail will be generated.

Yeah, using "-v2" is definitely needed. It will put "[PATCH v2]" or
"[PATCH v2 1/1]" in the subject.

> Also, you need not put the '[Outreachy-Microproject]' tag in the
> subject, '[OUTREACHY]' will suffice.

I am ok with '[Outreachy-Microproject]' even if it's a bit longer.

> Now, coming to the meat of the patch.
>
> > The test_path_is* functions provide debug-friendly upon failure.

s/debug-friendly/debug-friendly output/ would be more clear.

> This commit can be redone to be even more better. This does not exactly
> reflect what has been done. I understand that yes 'test_patch_is_*'
> functions are better and why they are better. But where did you replace
> them, this is left unanswered.

There is "t0000" in the subject which is enough.

> This is one example of how the commit messages can be, not too verbose
> and not too short, somewhere in the middle:
> https://lore.kernel.org/git/20200118083326.9643-6-shouryashukla.oo@gmail.com/

I am not sure it is a very good example. I would be ok with the commit
being a bit more verbose though.

> > Signed-off-by: Caleb Tillman <caleb.tillman@gmail.com>
> ---
> > Outreachy microproject, revised submission.
> >  t/t0000-basic.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> > diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> > index 923281af93..eb99892a87 100755
> > --- a/t/t0000-basic.sh
> > +++ b/t/t0000-basic.sh
> > @@ -1191,7 +1191,7 @@ test_expect_success 'writing this tree with --missing-ok' '
> >  test_expect_success 'git read-tree followed by write-tree should be idempotent' '
> >       rm -f .git/index &&
> >       git read-tree $tree &&
> > -     test -f .git/index &&
> > +     test_path_is_file .git/index &&
> >       newtree=$(git write-tree) &&
> >       test "$newtree" = "$tree"
>
> The change is fine but I feel you can easily find files in which you can
> do the same type of change but in a large quantity. This way you will
> get an even better idea of how the tests work at Git. To find such
> files, one way can be to look here:
> https://github.com/git/git/tree/master/t

We actually don't want that for most microprojects. On
https://git.github.io/Outreachy-21-Microprojects/ we ask it to be done
on only one test script.

> Here if you try finding files which had commits over 11-12+ years ago,
> you will find some ancient relics to modernise too! Great that you took
> Taylor's advice ;)

No need to find a really old test script for this microproject as I
think some 'test -[def]' uses have been introduced not too long ago.

Thanks both,
Christian.
