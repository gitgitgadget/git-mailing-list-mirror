Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7472FC433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 00:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F24D613CC
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 00:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236026AbhDWAQT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 20:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbhDWAQT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 20:16:19 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD75C061574
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 17:15:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p9-20020a2574090000b02904e2cb6a90e7so22215909ybc.17
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 17:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=HsniEmwRooBYD7MoJ/7z6b+8W/fqfROnukrBtnUNlsw=;
        b=kQ3RMNB/HUWMgJwW/Oiul0KokxJZWgB6h6ir80zQssW3Rd7Zl6e7meifON1SqqIBpz
         F11DnWVHpjFq0bPbu7h9/frQFX5b4AOT50uftHiXskoHCmpOE0ghvl0u5gif5IaKK/JN
         QuViSMLyNCPRzUfNlf/c2onTjNHFWAgHbHulq/QSL/XRrOYSM0i7hzP2ST/i18AJFgE1
         Qab2ZuvASA02Y/39hIsTvZlkw1uUI8gyJBPR54UO/NC26JNJYEUKi9dk+1mpRGzW3v5x
         ZbwqdcKnXMrc35gqgEQLBQxs5dzlL2TMu8pPQiwGAkr5tsMTMRSrBU9DJqDiKY+otxNp
         IG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=HsniEmwRooBYD7MoJ/7z6b+8W/fqfROnukrBtnUNlsw=;
        b=Dd4HjpkXwnUl2yDW5aZvT67S3VkgmaMc2Gufxt9A+HakfYS1VScdUCViTeIpDB9vjI
         CXYW9uRBfnXxpVw+88i4gSOVzlNyLgO3/ZDAvm53NK/lpL3XZtmsZd1YNOvwMztm9LSu
         wVEcX1v7NTSs9eyNZyLALLeLki4InJKJJHA2rX1ojtdfWetRfl68xWetSXsVZqPnhxAc
         ExDE4lmn4J4JDalOvTPejR8ESJT4NZ2/jbz2ScUy1uPg7yNcEGPBwRsUCLrlLaZn74p8
         qzsGX1DWALvMGpSiFM4pcOgXOg5CA+ndEpbn9Y9B1FK00Hc5Pd+FF+WeNj6Kpq5rH/zo
         3UCQ==
X-Gm-Message-State: AOAM530ruPLxOQCm8uGmZz87fhhbZA7sOjPUiNNHM335U4juQLOqW+Ar
        /Pz68A+WHmb+1EhTMvRMK0BQgQcMeSLyzE6xKYxrDtuEac6zAhUIXWIfmWFnc6AfNM6lWTj4aeb
        1gsxtPXbWguzl63MBlJqGOUXsGbPwYtl67QrszGxg+HxBvz0/GTp+ZlpLsYxQhEML1+BT2tAZpw
        ==
X-Google-Smtp-Source: ABdhPJyTV+Y4RqZ5zTS5GmSUllmw9f7B+FGRTTm3tVq47q9A4MYK8GEUh8mWVP3dXLOvSGxNvCo73IHlK46/JC3mNn4=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:fe4e:1417:67a4:42aa])
 (user=emilyshaffer job=sendgmr) by 2002:a25:c4c5:: with SMTP id
 u188mr1747388ybf.425.1619136943103; Thu, 22 Apr 2021 17:15:43 -0700 (PDT)
Date:   Thu, 22 Apr 2021 17:15:35 -0700
In-Reply-To: <20210408233936.533342-1-emilyshaffer@google.com>
Message-Id: <20210423001539.4059524-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [RFC PATCH v2 0/4] share a config between submodule and superproject
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

With the second iteration, I bothered to make the tests pass (oops) -
and I'm actually fairly unhappy with what I found. Patches 2 and 3 of
this iteration clean up tests which were (accidentally) explicitly
checking that no child processes were invoked besides the ones they
expected, by way of strictly grepping traces (by test_cmp or by line
counting). I don't like those tests as they were - to me, they felt like
the brittle kind of white-box test - but I also got a stronger feeling
that adding an additional child process or two during every Git
invocation is a bad idea. I also saw a pretty significant increase in
test run time:

All tests successful.
Files=927, Tests=24148, 693 wallclock secs ( 8.71 usr  2.05 sys +
3254.41 cusr 1571.78 csys = 4836.95 CPU)
Result: PASS

real    11m33.029s
user    54m23.187s
sys     26m13.857s

vs before:

All tests successful.
Files=926, Tests=24138, 144 wallclock secs ( 8.14 usr  2.03 sys + 882.29
cusr 535.61 csys = 1428.07 CPU)
Result: PASS

real    2m24.116s
user    14m50.499s
sys     8m57.649s

And that's on a Linux machine; as I understand it, invoking child
processes can be even more painful on other operating systems.

If we could be assured that this extra step (finding the parent's gitdir
and checking that config) was only running when we know we're in a
submodule, I'd be less worried, I think. And there are a couple other
pieces in the big picture submodule plan I sent[1] around which would
require repos to answer "am I a submodule?"

So I think this series may need to be shelved pending an answer to that
question - whether we *should* let submodules know they are
submodules[2] to turn on more behavior, and if so, how we should
implement that.

 - Emily

[1] https://lore.kernel.org/git/YHofmWcIAidkvJiD@google.com
[2] https://lore.kernel.org/git/xmqqk0pbm6qt.fsf@gitster.g

Emily Shaffer (4):
  config: rename "submodule" scope to "gitmodules"
  t1510-repo-setup: don't use exact matching on traces
  t7006-pager.sh: more lenient trace checking
  config: add 'config.superproject' file

 Documentation/git-config.txt   |  21 +++++-
 builtin/config.c               |   9 ++-
 config.c                       |  28 +++++++-
 config.h                       |   5 +-
 submodule-config.c             |   2 +-
 submodule.c                    |  29 +++++++++
 submodule.h                    |   8 +++
 t/t1311-superproject-config.sh | 116 +++++++++++++++++++++++++++++++++
 t/t1510-repo-setup.sh          |   2 +-
 t/t7006-pager.sh               |  24 +++++--
 10 files changed, 230 insertions(+), 14 deletions(-)
 create mode 100755 t/t1311-superproject-config.sh

-- 
2.31.1.498.g6c1eba8ee3d-goog

