Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B751C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 22:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15C0860184
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 22:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbhG0WoW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 18:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbhG0WoW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 18:44:22 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45289C061757
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 15:44:21 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h8so578144ede.4
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 15:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qYdGX85E/Fx2YxAvdaMDNTSaC39l1PToGayGRRXztYk=;
        b=aJ2K/2y7sNXVWnCndMnax0WoohRXGmD9uP/FSEuLofatEtPPvsh2M9FUPHxvtunfRV
         yr6YZAkgltpKqx+jZj/jYWvbqbLi4i6cO12O5GpaIpl1XR4BY7n58sM33JEaVgwVmK2H
         heE1MJ76EZFSV+VCrRUo/nVbUaASr6vEzvS7CvDL2gEGGLN80U5Ohlt75mZRoQ9IruL7
         gKZUK6hJR8z1+iAkK3Qjs+geMBo/MniHnnKonxA9uzWsrXyTHHsXHxaTnowrEy/XCOZU
         VJIgkCDB8odMzgFX88/RCzNEpDC+sM0s6sePAEgiFFrPbnXRtVmajLJ8/vmvx4zMi0fJ
         tvag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qYdGX85E/Fx2YxAvdaMDNTSaC39l1PToGayGRRXztYk=;
        b=MVMUdGpQ6/sOf4/rqejMGt7zBwK66XGzrWCsGYhm7tpOAsBeqWIbGo60H0YPtzB49D
         0VDVyXkStyhU3FnHfIMVyw2mXVvR6Q3EqFaZRwglqVikmQJkitvIy/frkmMkLGy1iy+w
         ry/J0o8XFN7WkRIq4CokDo7DNzvds1oEbP6RVCeyuMaVyxQdsl+K28AtOHoZES+pLqgV
         awZ00jhCjJ+UWuL2mDqBs5KAP1QFRlHfh2/c8gdFT5UGRKnLE9ffPZ76CWHDkuYCS5xH
         hkfOLl4xwD9T1i2/nYO0f4XTbP3kcPLDKJnprBOpwjd6u3NJu2uXWz5OHiya+z/kvSI4
         lXfQ==
X-Gm-Message-State: AOAM531ckSlDS96BCQdhzR1ZvzWEZQokI9GH4NmCH4YYR9Qk00MrLYG/
        Cvb7E9bEhu8EA80wt+xU41LgoIea88prlIkqW+3Dew==
X-Google-Smtp-Source: ABdhPJxSFACic88TEjfLWuIYFl7q7pi/H1ik9XNs66txe2EgoMSanvkoZDj4KKo894OHYNSgooLETfV6VtZWLq68vyQ=
X-Received: by 2002:aa7:c04e:: with SMTP id k14mr29897756edo.193.1627425859692;
 Tue, 27 Jul 2021 15:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <fdfd283aeee311ebbfb50024e87935e7@oschina.cn>
In-Reply-To: <fdfd283aeee311ebbfb50024e87935e7@oschina.cn>
From:   Jerry Zhang <jerry@skydio.com>
Date:   Tue, 27 Jul 2021 15:44:08 -0700
Message-ID: <CAMKO5Cs1HP7JNmJLYKti0kajGmD4XK+Boc3WRV2Dpph5a3b5Xw@mail.gmail.com>
Subject: Re: git apply --3way behaves abnormally when the patch contains
 binary changes.
To:     "lilinchao@oschina.cn" <lilinchao@oschina.cn>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 27, 2021 at 7:07 AM lilinchao@oschina.cn
<lilinchao@oschina.cn> wrote:
>
> I see the latest change about `git apply --3way` is 923cd87, but it doesn't seem to have been fully tested
> (in t4108-apply-threeway.sh).
> On latest Git version 2.32.0, consider test case below:
> "
> test_expect_success 'apply binary file patch with --3way' '
>         # 1. on new branch, commit binary file
>         git checkout -b left &&
>         cat "$TEST_DIRECTORY"/test-binary-1.png >bin.png &&
>         git add bin.png &&
>         git commit -m "add binary file" &&
>
>         # 2. based on left_bin branch, make any change, and commit
>         git checkout -b right &&
>         cat bin.png bin.png > bin.png &&
>         git add bin.png &&
>         git commit -m "update binary file" &&
>
>         # 3. make patch
>         git diff --binary left..right >bin.diff &&
>         # apply --3way, and it will fail
>         test_must_fail git apply --index --3way bin.diff
> '
> "
>
> But  "git apply --index --3way bin.diff" will not faill on Git version 2.31.0.
Are you sure? I checked out to "commit
a5828ae6b52137b913b978e16cd2334482eb4c1f (HEAD, tag: v2.31.0)" and
rebuilt and ran your test snippet and it still failed.

This was the message from the failure on 2.31.0
"error: the patch applies to 'bin.png'
(e69de29bb2d1d6434b8b29ae775ad8c2e48c5391), which does not match the
current contents.
Falling back to three-way merge...
warning: Cannot merge binary files: bin.png (ours vs. theirs)
Applied patch to 'bin.png' with conflicts.
U bin.png"

Versus the message on 2.32.0
"warning: Cannot merge binary files: bin.png (ours vs. theirs)
Applied patch to 'bin.png' with conflicts.
U bin.png"

So the failure messaging is different but it returns 1 both times. Is
there a difference between how we're testing?

I did have to modify your test to add
test_expect_success 'apply binary file patch with --3way' '
       # 1. on new branch, commit binary file
       git checkout -b left &&
+       git reset --hard &&

If this behavior is important I'd urge you to add this test to the suite.
>
>
