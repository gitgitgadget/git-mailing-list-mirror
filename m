Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476F3C433E0
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 21:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CE1B2074B
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 21:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pq5TZZZ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgFHVLi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 17:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgFHVLh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 17:11:37 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5A6C08C5C2
        for <git@vger.kernel.org>; Mon,  8 Jun 2020 14:11:36 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id y5so11816332qto.10
        for <git@vger.kernel.org>; Mon, 08 Jun 2020 14:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=apiGP0L3BeISO+jqlFhGULKukF4N5wGzNg63WijSyj4=;
        b=Pq5TZZZ0vG4RSpUJpeH7zKFkmD8cMaa2yKtUrRFdU5ruoZpMP9Ti4lkZWavm7DST5v
         F1CNxBqtoQRvDns6gQ966v5429klyVOYIrZM3KUeJI6ucVNqhVgHSGrahTZxS/1sMOxZ
         0fyKUujliGLTN+p/oHsz928tO8DBFy6pnHwWshvBg3eUifllls00RyUwrEtVcC1PBvic
         KJg6e7JRlNjbqoQBYwF3V04uGT0GUhxlvNOV6T25bTn4WrbRpGJgVTuIucCIyF/ik2Si
         HaKi1ROfDPSRpokQyx3aOGMcAmXbiBflCNkYMwTo99G6fLmLeZvGKBdL+yMAF9JSDzkZ
         EvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=apiGP0L3BeISO+jqlFhGULKukF4N5wGzNg63WijSyj4=;
        b=EQpjqJK4UgJ21fJC+LPqBYRhw6sMzGUuOUFXRUVy4kk0uzgwy/BQGMUyx64T1NqWl3
         8jGoMFOTnuF32Le1Y41B429j8ms1EosyMdfPBCbT4fwH0E14V6Bi3GCjNQiWOJb6cSR3
         rDK5HoeT6m2voEmvvqO5RpO2RRXWbKHt0CjpzmJQlKwI2lkCZCrqj7D/IeEytDfbrdeu
         pSV7L/1D3LOHhEwhWIAp3uWfftvxu93qj2vHEBsCx9FGmQbHhmx81G0RhWFGwLQp8k+d
         9VnYaVfJ7eLSKOW8kqzajEH5NiloHGHnC2xe2X+RBbRBWJNDNbpYqLi//PIdthZbWMnI
         dNCg==
X-Gm-Message-State: AOAM533XESeO9e7CW3I3n2+tUTBlS6/NZRJH9awVo82n5ZREU4qH864i
        3HIGEiq6MwQHjC+N66Uc7qeYKSoQtB3X8D+AXjbKq4bO8rJx94410xViSQqO1xM4PwpHv8GZC2M
        Oxq2Grvw5CuQ832W/y9+n+SczfpjkRGuWfh1ekdip4RO7q53neHU4zERofgka1qLcLAZoJ4f+sQ
        ==
X-Google-Smtp-Source: ABdhPJxUNsOoKB7Cvb1yVDTd6u8mrdVVZQfdDdmowFNGwyVsj030G8uEgUYEjXPg0AfrnnNVO7DOoQ/3TXVVEWzrmD4=
X-Received: by 2002:a0c:e385:: with SMTP id a5mr655169qvl.81.1591650695179;
 Mon, 08 Jun 2020 14:11:35 -0700 (PDT)
Date:   Mon,  8 Jun 2020 14:11:32 -0700
In-Reply-To: <20200528234939.145396-1-emilyshaffer@google.com>
Message-Id: <20200608211132.194267-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH v2] docs: mention MyFirstContribution in more places
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>, Jeff King <peff@peff.net>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While the MyFirstContribution guide exists and has received some use and
positive reviews, it is still not as discoverable as it could be. Add a
reference to it from the GitHub pull request template, where many
brand-new contributors may look. Also add a reference to it in
SubmittingPatches, which is the central source of guidance for patch
contribution.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---

Since v1, only the tiny nit - took Philippe's advice to refer to a
"step-by-step" tutorial, instead of an "interactive" tutorial.

Thanks.
 - Emily

 .github/CONTRIBUTING.md         | 3 +++
 Documentation/SubmittingPatches | 5 +++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/.github/CONTRIBUTING.md b/.github/CONTRIBUTING.md
index e7b4e2f3c2..c8755e38de 100644
--- a/.github/CONTRIBUTING.md
+++ b/.github/CONTRIBUTING.md
@@ -16,4 +16,7 @@ If you prefer video, then [this talk](https://www.youtube.com/watch?v=Q7i_qQW__q
 might be useful to you as the presenter walks you through the contribution
 process by example.
 
+Or, you can follow the ["My First Contribution"](https://git-scm.com/docs/MyFirstContribution)
+tutorial for another example of the contribution process.
+
 Your friendly Git community!
diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 4515cab519..ecf9438cf0 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -3,8 +3,9 @@ Submitting Patches
 
 == Guidelines
 
-Here are some guidelines for people who want to contribute their code
-to this software.
+Here are some guidelines for people who want to contribute their code to this
+software. There is also a link:MyFirstContribution.html[step-by-step tutorial]
+available which covers many of these same guidelines.
 
 [[base-branch]]
 === Decide what to base your work on.
-- 
2.27.0.278.ge193c7cf3a9-goog

