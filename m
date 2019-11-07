Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 398261F4C0
	for <e@80x24.org>; Thu,  7 Nov 2019 18:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfKGS4f (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 13:56:35 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:53320 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfKGS4f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 13:56:35 -0500
Received: by mail-pg1-f201.google.com with SMTP id u11so2524579pgm.20
        for <git@vger.kernel.org>; Thu, 07 Nov 2019 10:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OPAC+BNouLyr3u6pXKuFPXN4CdGYa+0ukWTqcm53bTk=;
        b=lxUcRAGuSvCqbrWC6Trsa/Pl15V4Zut3DURA9R1hFHi/sS3VPBJrJ5NP/aiHExSpj/
         7VqwHF3N+U5NnvfDz7XJ8DPJXfvikQ9yD1slo8BNoVrxKiCDiva5lKRipyth+w5bBUm3
         Mwr45wEtKxbycmG+fjwzvj70vXlY8KFoGesAkwBrWAh9PUWtLTvTmhzntCb7nGHffITh
         iBJpYWPeaDOjtVw9K42gsduiux4xhgvV6Bieg9SV6hFKgrevPME6c/vHTdmIPSWVZVKJ
         ZnsUSS9MplIPWgieW3RWQxuEQxvSEc73CPXmh9vwsLHNeIj7e6Pe5r+ic6VJVnI63Qc9
         ZZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OPAC+BNouLyr3u6pXKuFPXN4CdGYa+0ukWTqcm53bTk=;
        b=myr4utNZWOY1jOSIROGNgPcVpMaK1a1nQeeGM9dgx75aPPVgpA3x4+yIZN4OaQxFX1
         jFOcNCtrt/OClqDKSvga08W+N5d+4WVeHbhc1A0gcCcyeM1VGKvioqfLPRYEfONsRCGB
         wfmTOw+HK2RLLSfuXQeLuEGt39VJWUyg5SgZAFXRvhG26KGbmj8ubgGHs8ai1FXZ3h+J
         nuj7XuDtCCn3MVBuPquDxS4E30eADqMwneu5JEoqu6GFwpl6hOh8GboHbLIWpMvUqr7Q
         PPHlz7eKfJQYj0Js7jUF3Cft9zu3Ry+j6EUyHNK1vjyOwPXFc/srauLBLjoY0xy/yv04
         lHMQ==
X-Gm-Message-State: APjAAAXhGTzNMHUjqYQI33uO++VRq23IOkx8Gm8TbuZoc+decJL1NP6u
        5IJwfKkC2TGMhFhJ3pZrI3/BxJrjsSBsCot6brpH
X-Google-Smtp-Source: APXvYqw3FnW92a4CwXNmkYCHX0t0HN5cUj17A4DShxvO1cwqBkHmvMDwtWDMtMfhtzIPfMPQQ3LS8kEKoc7cBLxczWMG
X-Received: by 2002:a63:fe15:: with SMTP id p21mr6238617pgh.26.1573152993865;
 Thu, 07 Nov 2019 10:56:33 -0800 (PST)
Date:   Thu,  7 Nov 2019 10:56:30 -0800
In-Reply-To: <CAPNHn3qj7v=xu1ogG4q9NrHvp1zfZFvUWQKJqf0DJcavxgsz6Q@mail.gmail.com>
Message-Id: <20191107185630.253388-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CAPNHn3qj7v=xu1ogG4q9NrHvp1zfZFvUWQKJqf0DJcavxgsz6Q@mail.gmail.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: Re: [PATCH v7 1/1] Implement rev-list --bisect* --first-parent
From:   Jonathan Tan <jonathantanmy@google.com>
To:     workingjubilee@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org,
        christian.couder@gmail.com, johannes.schindelin@gmx.de,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > > @@ -964,7 +981,12 @@ int bisect_next_all(struct repository *r, const char *prefix, int no_checkout)
> > >
> > >       bisect_common(&revs);
> > >
> > > -     find_bisection(&revs.commits, &reaches, &all, !!skipped_revs.nr);
> > > +     if (skipped_revs.nr)
> > > +             bisect_flags |= BISECT_FIND_ALL;
> > > +     if (revs.first_parent_only)
> > > +             bisect_flags |= BISECT_FIRST_PARENT;
> > > +
> > > +     find_bisection(&revs.commits, &reaches, &all, bisect_flags);
> > >       revs.commits = managed_skipped(revs.commits, &tried);
> > >
> > >       if (!revs.commits) {
> >
> > I don't see how revs.first_parent_only is ever set in this function. If
> > it's never set, undo this change, since this code is never executed.
> 
> In this function, 

(1)
> we call bisect_rev_setup() using the revs struct we
> made,

(2)
> which then calls setup_revisions() on the revs,

(3)
> which appears to
> call handle_revision_opt() with that struct again,

(4)
> which finally is
> allowed to set revs->first_parent_only = 1; in revision.c.
> 
> So unless I am horribly misreading something, we do set it.

Thanks for performing this analysis. Working backwards:

(4) handle_revision_opt() in revision.c sets revs->first_parent_only
only if argv[0] is "--first-parent".

(3) setup_revisions() calls handle_revision_opt() in a loop over its
argv parameter.

(2) bisect_rev_setup() initializes rev_argv (with ARGV_ARRAY_INIT, a
blank array). Then, it pushes "bisect_rev_setup", an OID in
"bad_format", some OIDs in "good_format", and possibly some paths. Then
it calls setup_revisions() with rev_argv as the argv parameter. Notice
that there is no "--first-parent" sent at all.

> > > +test_expect_success '--bisect-all --first-parent returns correct order' '
> > > +     git rev-list --bisect-all --first-parent E ^F >actual &&
> > > +
> > > +     # Make sure the entries are sorted in the dist order
> > > +     sed -e "s/.*dist=\([0-9]\).*/\1/" actual >actual.dists &&
> > > +     sort -r -n actual.dists >actual.dists.sorted &&
> > > +     test_cmp actual.dists.sorted actual.dists
> > > +'
> > > +
> > > +# NEEDSWORK: this test could afford being hardened against other
> > > +# changes in the same file.
> > > +test_expect_success '--bisect-all --first-parent compares correctly' '
> > > +     cat >expect <<-EOF &&
> > > +     $(git rev-parse tags/e5) (tag: e5, dist=4)
> > > +     $(git rev-parse tags/e4) (tag: e4, dist=4)
> > > +     $(git rev-parse tags/e6) (tag: e6, dist=3)
> > > +     $(git rev-parse tags/e3) (tag: e3, dist=3)
> > > +     $(git rev-parse tags/e7) (tag: e7, dist=2)
> > > +     $(git rev-parse tags/e2) (tag: e2, dist=2)
> > > +     $(git rev-parse tags/e8) (tag: e8, dist=1)
> > > +     $(git rev-parse tags/e1) (tag: e1, dist=1)
> > > +     $(git rev-parse tags/E) (tag: E, dist=0)
> > > +EOF
> > > +
> > > +git rev-list --bisect-all --first-parent E ^F >actual &&
> > > +     sort actual >actual.sorted &&
> > > +     sort expect >expect.sorted &&
> > > +     test_cmp expect.sorted actual.sorted
> > > +'
> >
> > I think these 2 tests can be combined, since the latter also checks the
> > dists. Also, correct the indentation of the latter test.
> 
> I understand they are similar tests, but... Is there a tangible
> reason for combining them? Especially when their logic can
> live and breathe completely separately, compacting tests
> reduces the resolution of the information we can extract from failure.
> 
> I would rather simply drop one and preserve 1 test = 1 data point.

In general, I agree that 1 test should represent 1 data point, and the
reason for that being (as you said) the resolution of the information we
can extract from failure. But here, the resolution is diminished if we
don't combine the tests. Here, if either test fails, because of the
postprocessing we've had to do on the output, we lose signal. But if we
had the combined test, we wouldn't.
