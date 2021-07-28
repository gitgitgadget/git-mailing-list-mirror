Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEFBC4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 01:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB46A60551
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 01:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbhG1BiL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 21:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbhG1BiL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 21:38:11 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44386C061757
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 18:38:10 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id p21so968036edi.9
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 18:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kfVt8V5LsLKAT5At0hLs+aI1cfdGQ5XIpIIOROx+Srk=;
        b=wLn+ZBWnIrOsQNnAiqoPjhYLfJ43MRSKQabIaGwSoQa7d3V34Flztx9XV1BzXF/oO6
         exVqRz+T4GEzfQh+KS222VeOXOwZChNHuCZ9i880kUUqHEalYvG4jtDAbARtznxKKCf6
         898kLTg3afDfdR2JE2NCnPBvGrTrpoSb3QO448EKxZvqxeMLFRg1DcB6dwnIg4jnUMLl
         2wVQ33RGeViLBhS2kWsXdZd2K0FGEkkKeEOpdyVtuuMYGi4ii5SIFuNkbuv9qr82kjBQ
         zT6x4SUr3Sps8H55mvxOfHb7H+GurpK8IkOdLonjoggOPSHR4Tp0R+TYoQXjRTsBhyWM
         E6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kfVt8V5LsLKAT5At0hLs+aI1cfdGQ5XIpIIOROx+Srk=;
        b=LIQb1mQ+dXJGoaqUyCLjC8tNdeGylQly2R+QJZLWxfcmLjr5rNjX0w7Y5azdsO3O2o
         B+u6mVOoNAqh0akdUUwFMoStmxI7rvMf/uE8uflfkxFrUQim704xTA9hyUkED9ubh9D4
         HSar3fvB5KspVdTUcd5uNvB50uFZOJLlbkM5XAbWDS11X3f3GuF4jmWl6LxEL2BMG9+j
         rBQEJ5aXKJkqV+CtK8clfd32QxgyUG1nmXQTANBilrjTLpXuPYlROca6lmLpSUSWUEzG
         cInYxcnBVUarIj70xRTtQlrFXbEEmcxplYxtSeviK7ODA4pCkOUi6TlBbZfPqAjbQblj
         Tfag==
X-Gm-Message-State: AOAM531C38BZeNBnGJk2BDQfaiJHQDiWplDmjokK8vdANpZqfOz3M41S
        2anDgD9inI525Q/fHXwBW9BK+ng2NF0DE0HovJlR2Q==
X-Google-Smtp-Source: ABdhPJxwh1H3vDBCUzo8trSkb2VxFtGUCOVJiyf9iBZ0R9qMw4pEWCv+8i5j4bDsWmnXGUAALQ44cLHKzb2yPJyukwM=
X-Received: by 2002:a50:9503:: with SMTP id u3mr30591089eda.135.1627436288858;
 Tue, 27 Jul 2021 18:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <fdfd283aeee311ebbfb50024e87935e7@oschina.cn> <CAMKO5Cs1HP7JNmJLYKti0kajGmD4XK+Boc3WRV2Dpph5a3b5Xw@mail.gmail.com>
 <xmqqv94vb5z6.fsf@gitster.g>
In-Reply-To: <xmqqv94vb5z6.fsf@gitster.g>
From:   Jerry Zhang <jerry@skydio.com>
Date:   Tue, 27 Jul 2021 18:37:58 -0700
Message-ID: <CAMKO5CvM-FUMTxGeaiYY--PvXPRYESbA7r_-=A3668Vd7AHqxQ@mail.gmail.com>
Subject: Re: git apply --3way behaves abnormally when the patch contains
 binary changes.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "lilinchao@oschina.cn" <lilinchao@oschina.cn>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 27, 2021 at 6:08 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jerry Zhang <jerry@skydio.com> writes:
>
> >>         # 2. based on left_bin branch, make any change, and commit
> >>         git checkout -b right &&
> >>         cat bin.png bin.png > bin.png &&
> >>         git add bin.png &&
> >>         git commit -m "update binary file" &&
> >>
> >>         # 3. make patch
> >>         git diff --binary left..right >bin.diff &&
> >>         # apply --3way, and it will fail
> >>         test_must_fail git apply --index --3way bin.diff
> >> '
> >> "
> >>
> >> But  "git apply --index --3way bin.diff" will not faill on Git version 2.31.0.
> > Are you sure? I checked out to "commit
> > a5828ae6b52137b913b978e16cd2334482eb4c1f (HEAD, tag: v2.31.0)" and
> > rebuilt and ran your test snippet and it still failed.
>
> Isn't it just because the reproduction recipe is simply wrong?
>
> It says
>
>     * be on left branch and have a binary file
>     * be on right branch and have a modified binary file
>     * create a patch to take left to right
>
> Notice that we have a patch and we are still on the right branch.
> Of course, applying the patch to take us from left to right would
> fail from that state, but I _think_ the intent of the reproduction
> recipe was, after all of the above, do this here:
>
>     * switch to left branch and attempt to apply the patch.
>
> And the patch is meant to take us from left to right, and we are on
> pristine left, the application ought to cleanly succeed, no?
>
> "git apply bin.diff" would probably work correctly but I do not know
> offhand what the code after your change does with --3way enabled.
>
> We refuse to merge binary files, so I would not be surprised if we
> failed the 3way in this case (even though we _could_ fast-forward,
> it may not be worth complicating the --3way logic---nobody sane
> would say --3way when it is unnecessary) but after 3way fails, do we
> still correctly fall back to "straight application" like we do for
> text patches with your change?  Before your change, we would have
> first attempted the "straight application", which would succeed and
> wouldn't have hit "3way will refuse to merge binaries" at all.
Ah yep it's exactly as you say. I'll add the fix and a couple of test cases
into a new patch.
>
> So, I do not think it is implausible that we are seeing a legit
> regression report.
>
> Thanks.
