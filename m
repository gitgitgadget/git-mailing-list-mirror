Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45285C38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 19:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07EB8208E4
	for <git@archiver.kernel.org>; Thu,  7 May 2020 19:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myQridF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgEGTrw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 15:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726326AbgEGTrv (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 15:47:51 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA84C05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 12:47:51 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id v192so1951147vkd.3
        for <git@vger.kernel.org>; Thu, 07 May 2020 12:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tk1VEtULGblIbn6Al9TuvZAoZ1Iv8Ywv8JGIu+jF2eg=;
        b=myQridF2QtfrJbA9I2shlAVQhxciPl4Gqs+R+fBllitqkolSQH0qf7v0Avu3bk1bX+
         Zlb23TvGtjkICbKxyb2CYky5IcDNG9tUycrXK2SO3e1kCfIDpyVEJ043FSHBCOdsEBzt
         sSXg6T//Ay62zJIA9WxYxDAKipaX/5IliXkVNLm28ivINu+jwWVCS0VrYER+FoRVAPYa
         R0Nha/0OAvcdYhAC0ui3MM0U5wRShglSn1fmyPHq90uW/8UJxpMNCVW47qZ5T9xskh7m
         6f0ppa+I5ArbzvqJqa4wrrgy9e6R8kL8qm31Vlp7Jwn7LrVY+QwEJvocGQywM51J/oxW
         qiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tk1VEtULGblIbn6Al9TuvZAoZ1Iv8Ywv8JGIu+jF2eg=;
        b=HPTHlg9VsMLtWPyXiv6bOS0Gbo/OUHLXoZtJv02eBMvAC+CANmbh+XUJ2PBO8ii9/i
         WyFfOZV+/AT2DvWx6EFGuxb/0CCbIswBaW1U0jVlBGy44ZPpSnyYbmp10GARtCXwqowJ
         17Sb/BQISSQ+HEArwc5W4TUahZhlz7/v3KYM/Xc9c/jYr4DjFkVu1kKtjNegKOuT2mth
         V5FRZxFnxs44+qNXiCTs4fDtzSopXV/RvFoNcieBbqR1CRRMwvDxQwItIIa9J+Xcyx7J
         M0VtxtKeFEFBbqjTMONBWJ3gs8o8gNO/LrVwQluDKeDAq/qP0G/dKKAX21L3LOLc5XPh
         j1sw==
X-Gm-Message-State: AGi0PuYVR+3NR0xxqqZy/r7BaEqhlg2JvOn+64/L3xOglI+8PoOVApIy
        USZSXkrlJG/GFAhNlLKpBMHGwfmkILpQuhxrCdVgKQHCXtY=
X-Google-Smtp-Source: APiQypI6nlxMYk1wHYDBUhmgVHrceb2lR0Bv6HlbKsMfpAlVavQALN54Red9ERQyqJlfD9H9R3aVCG7aB8cpiGxXlq8=
X-Received: by 2002:a1f:9605:: with SMTP id y5mr12981201vkd.75.1588880870344;
 Thu, 07 May 2020 12:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAGqZTUujRh-f-83A8NYokbxLGZ-bnvGrtguzJsMdg9EX04NsGg@mail.gmail.com>
 <20200507194224.GB25306@coredump.intra.peff.net>
In-Reply-To: <20200507194224.GB25306@coredump.intra.peff.net>
From:   clime <clime7@gmail.com>
Date:   Thu, 7 May 2020 21:47:39 +0200
Message-ID: <CAGqZTUv_d37_kZAL7KUk_sv4mhga=PHJY1jYft6QS95s2jDGjg@mail.gmail.com>
Subject: Re: tags sorted by their depth, *committerdate, and taggerdate
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 7 May 2020 at 21:42, Jeff King <peff@peff.net> wrote:
>
> On Wed, May 06, 2020 at 08:16:35PM +0200, clime wrote:
>
> > I have some very specific requirements to get annotated tags sorted in
> > a certain way. I would like them to be sorted:
> > - primarily by their depth (i.e. how far they are from current HEAD
> > and if they are not reachable then they should not be displayed).
> > - secondarily by committerdate of the commit they are associated with
> > - ternarily by taggerdate
>
> There's no way to compute the depth with for-each-ref or similar. In
> fact, I'm not even sure of a way to do it for all tags with a single
> command. So I'd probably script something like:
>
>   git for-each-ref \
>     --format='%(*committerdate:unix) %(taggerdate:unix) %(refname)' \
>     refs/tags |
>   while read cdate tdate ref; do
>     depth=$(git rev-list --count --ancestry-path $ref..HEAD)
>
>     # if depth is 0, then either $ref isn't an ancestor of HEAD, or $ref
>     # points to the same commit as HEAD. Not sure if you want to salvage
>     # the latter case, but you could compare rev-parse output on the
>     # two.
>     if test "$depth" = 0; then
>       continue
>     fi
>
>     echo "$depth $cdate $tdate $ref"
>   done |
>   sort -k 3rn -k 2rn -k 1n
>
> But it's kind of expensive (we'd walk over the history near HEAD
> multiple times, once per tag).
>
> It seems like git-describe should be able to do a better job of the
> traversal, but I had trouble convincing it to do so.
>
> > Is something like that possible?
> > Is something like that possible even with git 1.7.1?
>
> You'd need v1.7.2 for --ancestry-path. You could just use "$ref..HEAD"
> without it, and instead do:
>
>   git merge-base --is-ancestor $ref HEAD
>
> to cover the case where they aren't reachable from HEAD. But of course
> that's an extra traversal per tag.
>
> I'm not sure why you need to use such an antique version of Git.
>
> > If this isn't possible, I am thinking I could write some simple
> > utility in C to do it but can I rely on certain binary format of
> > commit and tag objects? Has the format changed at some point since git
> > 1.7.1? Is there a git library I could use for it? Or is the format
> > documented somewhere?
>
> Doing better would require a custom traversal of the commits. You could
> look something with libgit2 (which is in C, but has bindings to some
> other languages).

Thank you, Jeff. I didn't actually expect somebody would respond to my
crazy demand.

I probably could drop support for that version, it is in centos:6 but
that is soon going to be eoled.

Thank you also for the scripts. I would like to be the operation as
fast as possible so I am actually considering libgit2 now.

Thank you very much again for your advice
clime

>
> -Peff
