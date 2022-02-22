Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76988C433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 02:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239125AbiBVCXk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 21:23:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbiBVCXj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 21:23:39 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC1425C50
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 18:23:15 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id qx21so38025345ejb.13
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 18:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rdUQrItxDF52zqn9q5CUADWm7xUq5O2ZA3N3myuNXIA=;
        b=G3b50kEhOzl1Ec1RZBDJb3e8Gbm8V2peaVYi3LlOsY17onKLVw3hBMxtq12sk7cnjq
         sP3Pvwnvz6vFb1d2+cuW7BgEZDoWwvw9x0VaN0xxtqXwBulh3eY9v1jS5tlfZZuCOttk
         TS8NokrO47vsA+wyoqfdbGuF11C4dTXyftw26FfasQNc+H/UYTFJ1UXcbth9W6F4hcbH
         F9EvHQGbCXHNEW9lwPONmNR0EZtj6lt4dBIYT8b3cIWI+tn1TQF4OgEjshtC500SbR8A
         9PwHhKjgL1rqL2wUz08iyaBzG4OkJ2IBBBtyoEb6Ttndty4QJAeQ/XPHmsaSybbkhbee
         VDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rdUQrItxDF52zqn9q5CUADWm7xUq5O2ZA3N3myuNXIA=;
        b=BbHkgi16x4gbkGfN+0soBivm9ml7JmxJoScQoM6Ietrujd07ADwjcd56ShtZB7vA6p
         /JyBENa2Yit5oE7Jawzg//qGkzJmdaI5/Mcxt5RayF2O+L3Zs9winGHjUibNlX0G/6rU
         77HmNtQIxmckjnoHC8dcu9WExfm3NhvV36SN855LKay6z90Ct/HeZwndXSZe96na18Nj
         wVC1mFBAir8PasNZkFB1YnwwvHxj3QrUtVTyiZeO0mKqyM5HV1kj3+J6B8Tek0VTz0l/
         63uPZxpDyobmhn15vQBJDvp2OhhlcBTjrOSmRUJmEM3ja005W+J49gUyJbGg8qBSrYqx
         9dQg==
X-Gm-Message-State: AOAM531PTZV4iab+TCXTvDtwiYrIsVekmL7KF1r6vVIjcEbBLfCj3Dtb
        WVUraBwmoHEYfOoop9dBFX+TF/h270bxdFUEYtY=
X-Google-Smtp-Source: ABdhPJyTRSW2+o6lBGFwHZThfqnWYt8BbpmImMqIQbzncgYBEMP/8htcGBaPUf77tqhw68pa7Qrnhcf8xd+GInFjzfw=
X-Received: by 2002:a17:906:2f94:b0:6cf:e4f7:13a with SMTP id
 w20-20020a1709062f9400b006cfe4f7013amr17240544eji.269.1645496593733; Mon, 21
 Feb 2022 18:23:13 -0800 (PST)
MIME-Version: 1.0
References: <pull.1153.git.1645333542011.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2202212100080.4418@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2202212100080.4418@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 21 Feb 2022 18:23:02 -0800
Message-ID: <CABPp-BH_fJYWSySh_-Pk5w2j7U2q4CAXi_mEextmmd4YBXOiGg@mail.gmail.com>
Subject: Re: [PATCH] Provide config option to expect files outside sparse patterns
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Jeff Hostetler <jeffhostetler@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 21, 2022 at 12:34 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> In addition to Stolee's feedback...
>
> On Sun, 20 Feb 2022, Elijah Newren via GitGitGadget wrote:
>
> > diff --git a/config.c b/config.c
> > index 2bffa8d4a01..68e877a1d80 100644
> > --- a/config.c
> > +++ b/config.c
> > @@ -1520,6 +1520,11 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
> >               return 0;
> >       }
> >
> > +     if (!strcmp(var, "core.expectfilesoutsidesparsepatterns")) {
> > +             core_expect_files_outside_sparse_patterns = git_config_bool(var, value);
> > +             return 0;
> > +     }
>
> The `core` section is already quite crowded (for which I am partially
> responsible, of course).
>
> Maybe it would be a good idea to introduce the `sparse` section, using
> `sparse.allowFilesMatchingPatterns` or `sparse.applyPatternsToWorktree =
> false`?

That's a fair point.  At one point Stolee wanted to change from
core.sparse* to sparse.* -- but by that point we already had users and
would have had to deal with a bit of a migration story (and wondering
what to do if people had both old and new config variables set
inconsistently).

I'm not sure if it's optimal to try to keep the sparse settings
together (thus put new ones under core), or try to avoid filling core.
I guess if we moved towards sparse.* now, it might be an easier
migration story if we only have two options to move.  And besides,
we're already split between multiple sections with
extensions.worktreeConfig, core.sparseCheckout{,Cone}, and
index.sparse already...so maybe adding one more section would be par
for the course.  ;-)

So, I'm leaning towards sparse.expectFilesOutsideOfPatterns, but I'd
like to hear Stolee's thoughts too.
