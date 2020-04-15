Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8338C3815B
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 22:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4CC22076C
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 22:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcWb+IM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725800AbgDOWyY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 18:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387503AbgDOWyW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 18:54:22 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66681C061A0C
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 15:54:21 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id j16so15005712oih.10
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 15:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=44s34athB54EhfG2PMBuRacsNI7PuUAX6EwbNLZR734=;
        b=HcWb+IM1zhgpUg+E8HSzY/TQDG7S8rUGHcYyox+KslQkF5zpBYQCvrzivYHYsWV7wW
         NsbXWBHBxafb3LNcHR/yLQqQh5Izs2XWrerPuYJjYQh6mzhIJgnPgqeMa+/ZkgZdCXXy
         /qVGiU/hpwqp29WgTBsxLBkbSTikyugxFPip2Hqjkfq6mneh/ryThMHSeSg+jOmipirU
         SLGOBvJHqrGR7WoloxXy0Eh0VAKtIMWECU5HdKFUEbEfHCT8xhvhGAszIxsi7uNGil9+
         hQh//rHu2sJAwn/Sz8vacb1Tc1EE2VDAYz/piA161/dGZjpFs89K6glIYX2emv1WbcJM
         n6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=44s34athB54EhfG2PMBuRacsNI7PuUAX6EwbNLZR734=;
        b=kb+4bJ8KPC4ZahF7xnAA6GG32dxUNXVdTjpwg27mu8PcW+kJ2UW2WATVxsr5T4j9ss
         nooOb7rUBS6lFvfumyDxezgWukhBuvNITuPcH22uHNryjudrcNIny8YqHhUBvcEyRn1T
         MkXifMcz1OPxEH2NlH0VLRQ6s6jWSnGyTTbXTQyou+Ny7kkiOZU7aHS6RIVaBE43/+kO
         BXbgGVB9C/Qk/B3IMeE4L7CR5ujyZqJ1UF158/68FsyJ1FJCDbz2i8eKFB6SMb2gdCJ/
         wT0BfT1i4/K4nM7l8hXUpVhytCdtPyWgxgzeoXDKesB+7kZHAGdm6/sbji0nR43pUM5G
         TowA==
X-Gm-Message-State: AGi0PuafThhRtLi5iwi8I1nCGPO8uhqVZHR5YQmPOMuwWQyjbyIa6LM0
        +lMKpaL6MYDKDjTcwGHO0tlLDLQMVt8eJI+SgUI=
X-Google-Smtp-Source: APiQypJ/4hj1Rpg/1d1ruzhXbr6rzQRdO3hA1VKJFivI6ie/WeMBAg+jnr1XbDfRSEm+h78+cEr0V+tE/3HZv2Xp77I=
X-Received: by 2002:aca:f346:: with SMTP id r67mr1159892oih.39.1586991260454;
 Wed, 15 Apr 2020 15:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BHGubUX5o9KsQaoh_UFjFh2PaMkkJhCao+5LGnFc0dQNg@mail.gmail.com>
 <20200415205442.GC216285@google.com>
In-Reply-To: <20200415205442.GC216285@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 15 Apr 2020 15:54:09 -0700
Message-ID: <CABPp-BE+bC8aECT4Ak_kSObXV-euq7vCnYeUYBEjYmW4Pko=rw@mail.gmail.com>
Subject: Re: Is fetch.writeCommitGraph (and thus features.experimental) meant
 to work in the presence of shallow clones?
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 15, 2020 at 1:54 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Hi,
>
> Elijah Newren wrote:
>
> > I was building a version of git for internal use, and thought I'd try
> > turning on features.experimental to get more testing of it.  The
> > following test error in the testsuite scared me, though:
> >
> > t5537.9 (fetch --update-shallow):
> >
> > ...
> > + git fetch --update-shallow ../shallow/.git refs/heads/*:refs/remotes/shallow/*
> > remote: Enumerating objects: 18, done.
> > remote: Counting objects: 100% (18/18), done.
> > remote: Compressing objects: 100% (6/6), done.
> > remote: Total 16 (delta 0), reused 6 (delta 0), pack-reused 0
> > Unpacking objects: 100% (16/16), 1.16 KiB | 1.17 MiB/s, done.
> > From ../shallow/
> >  * [new branch]      master     -> shallow/master
> >  * [new tag]         heavy-tag  -> heavy-tag
> >  * [new tag]         light-tag  -> light-tag
> > error: Could not read ac67d3021b4319951fb176469d7732e6914530c5
> > error: Could not read ac67d3021b4319951fb176469d7732e6914530c5
> > error: Could not read ac67d3021b4319951fb176469d7732e6914530c5
> > fatal: unable to parse commit ac67d3021b4319951fb176469d7732e6914530c5
> >
> > Passing -c fetch.writeCommitGraph=false to the fetch command in that
> > test makes it pass.
>
> Oh!  Thanks for checking this.  At $DAYJOB this was the week we were
> going to roll out features.experimental.  Time to roll that back...
>
> How did you go about the experiment?  Does Taylor's patch make it pass?

Yes, Taylor's patch makes the experiment pass.  My experiment was
pretty simple; modify the code so that features.experimental defaults
to true:

diff --git a/repo-settings.c b/repo-settings.c
index a703e407a3..b39bc21b99 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -8,6 +8,7 @@ void prepare_repo_settings(struct repository *r)
 {
        int value;
        char *strval;
+       int feature_experimental;

        if (r->settings.initialized)
                return;
@@ -51,7 +54,10 @@ void prepare_repo_settings(struct repository *r)
        }
        if (!repo_config_get_bool(r, "fetch.writecommitgraph", &value))
                r->settings.fetch_write_commit_graph = value;
-       if (!repo_config_get_bool(r, "feature.experimental", &value) && value) {
+       feature_experimental = 1;
+       if (!repo_config_get_bool(r, "feature.experimental", &value))
+               feature_experimental = value;
+       if (feature_experimental) {
                UPDATE_DEFAULT_BOOL(r->settings.pack_use_sparse, 1);

UPDATE_DEFAULT_BOOL(r->settings.fetch_negotiation_algorithm,
FETCH_NEGOTIATION_SKIPPING);
                UPDATE_DEFAULT_BOOL(r->settings.fetch_write_commit_graph, 1);

(based on 2.26.0; Stolee has since made pack_use_sparse default to
true anyway) and then run the test suite and see what breaks.  For the
tests that fail, check if the failure is expected based on different
defaults and the code still functions correctly with the new defaults
(and update the test manually if so), or whether the test failure
represents some potentially scary problem.  This was the only bug
exposed by this little experiment.

> (I'm thinking it would be nice to have a
> GIT_TEST_EXPERIMENTAL_FEATURES setting that uses test_config_global at
> test init time.)
