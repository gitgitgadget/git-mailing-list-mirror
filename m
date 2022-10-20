Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FCFC433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 18:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiJTS2X (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 14:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiJTS2R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 14:28:17 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9861F524D
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 11:28:15 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso3139015wma.1
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 11:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkJEMJFGS4hSCnUT3RbeMHEA6CGfHK7Uqd4sKFLXPuo=;
        b=R88CEdwwl9lu+hMckfG3e9Z8qXt0w1fuG7ekQpqDQRv1vzFOBuXrJuDYXkp/QBkQB1
         UWjaIG+dsRP3tX00pDCfvFkE/1UtdVbL0VUVdzPd8yvVykvLdmbsInQ04IfDt6PJ+eg/
         ZbWUNWa290lL+Jt2HUwmCd+bRZQTWyTwIBoQBw8X98r7RoXNVb3UUvYp94ErpQMb8v7V
         7xGSHihkwD78X3+XZ1k3wS/6uUcSE4jhTl2Fr4tEbitxH4Y80jN0vSLhcQIlqtUJm1GW
         n1JYbtV+REYwMeDCHwMVgUot97L2I0zZzJQGZ3rL28HflEu1qf9eYvOZ2OI58+31Ng1d
         Ma6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bkJEMJFGS4hSCnUT3RbeMHEA6CGfHK7Uqd4sKFLXPuo=;
        b=MlRGvhQLDJiTEfNv9GxTsCYpl/gyV0k7IBRMZBSVlEIX/eHu4HTmstshM0kGx5xccd
         SFhuh7xMwPmsLyyVobabuGMz9mPtnG2O98zLKhSzaaraAP60Kaw36xfGfmUDZfrP2fBa
         QjXerouyYL1eSo4+oue38IUUIDwzMbbBktl6keLNZSxE9vL2k7CEQFGkeHak1+dkETLG
         g/7CgNS+s6q9EnXqW5Nx8wBDrFijrUkR6iJu1qKDbvIR6dqDPAR/RFkC6varA9pGF1Az
         UemwA2woTvXVqzz/nCU1eAsuY1GOK4keLJcOB1V+6pWU35zj8NvG7kbPC/Dt1reKXtIi
         Ux5g==
X-Gm-Message-State: ACrzQf0DqQ5o6iDbh46l+uLyyOfFCKxiIc60ZRa2TapyLuXXo9K2PkBB
        wmslu8mD5dLPcinDx6zk5eUd52RKkCk=
X-Google-Smtp-Source: AMsMyM5iu8/zD3vS0GP83H3vRikzxtgOLuKs0OaFCkvi/1Ve6sTxdNSRDuuHHhZD5N8OM6Yv3PtZcw==
X-Received: by 2002:a05:600c:4ec6:b0:3c6:c469:d295 with SMTP id g6-20020a05600c4ec600b003c6c469d295mr31498211wmq.117.1666290493953;
        Thu, 20 Oct 2022 11:28:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z9-20020a5d44c9000000b0022917d58603sm17227473wrr.32.2022.10.20.11.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 11:28:13 -0700 (PDT)
Message-Id: <804dab9e1a7fa1cea9355bac92ada16332f1194e.1666290489.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1373.v3.git.1666290489.gitgitgadget@gmail.com>
References: <pull.1373.v2.git.1665600750.gitgitgadget@gmail.com>
        <pull.1373.v3.git.1666290489.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Oct 2022 18:28:04 +0000
Subject: [PATCH v3 3/8] api-trace2.txt: elminate section describing the public
 trace2 API
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Eliminate the mostly obsolete `Public API` sub-section from the
`Trace2 API` section in the documentation.  Strengthen the referral
to `trace2.h`.

Most of the technical information in this sub-section was moved to
`trace2.h` in 6c51cb525d (trace2: move doc to trace2.h, 2019-11-17) to
be adjacent to the function prototypes.  The remaining text wasn't
that useful by itself.

Furthermore, the text would need a bit of overhaul to add routines
that do not immediately generate a message, such as stopwatch timers.
So it seemed simpler to just get rid of it.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/technical/api-trace2.txt | 61 +++-----------------------
 1 file changed, 7 insertions(+), 54 deletions(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index 431d424f9d5..9d43909d068 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -148,20 +148,18 @@ filename collisions).
 
 == Trace2 API
 
-All public Trace2 functions and macros are defined in `trace2.h` and
-`trace2.c`.  All public symbols are prefixed with `trace2_`.
+The Trace2 public API is defined and documented in `trace2.h`; refer to it for
+more information.  All public functions and macros are prefixed
+with `trace2_` and are implemented in `trace2.c`.
 
 There are no public Trace2 data structures.
 
 The Trace2 code also defines a set of private functions and data types
 in the `trace2/` directory.  These symbols are prefixed with `tr2_`
-and should only be used by functions in `trace2.c`.
+and should only be used by functions in `trace2.c` (or other private
+source files in `trace2/`).
 
-== Conventions for Public Functions and Macros
-
-The functions defined by the Trace2 API are declared and documented
-in `trace2.h`.  It defines the API functions and wrapper macros for
-Trace2.
+=== Conventions for Public Functions and Macros
 
 Some functions have a `_fl()` suffix to indicate that they take `file`
 and `line-number` arguments.
@@ -172,52 +170,7 @@ take a `va_list` argument.
 Some functions have a `_printf_fl()` suffix to indicate that they also
 take a `printf()` style format with a variable number of arguments.
 
-There are CPP wrapper macros and `#ifdef`s to hide most of these details.
-See `trace2.h` for more details.  The following discussion will only
-describe the simplified forms.
-
-== Public API
-
-All Trace2 API functions send a message to all of the active
-Trace2 Targets.  This section describes the set of available
-messages.
-
-It helps to divide these functions into groups for discussion
-purposes.
-
-=== Basic Command Messages
-
-These are concerned with the lifetime of the overall git process.
-e.g: `void trace2_initialize_clock()`, `void trace2_initialize()`,
-`int trace2_is_enabled()`, `void trace2_cmd_start(int argc, const char **argv)`.
-
-=== Command Detail Messages
-
-These are concerned with describing the specific Git command
-after the command line, config, and environment are inspected.
-e.g: `void trace2_cmd_name(const char *name)`,
-`void trace2_cmd_mode(const char *mode)`.
-
-=== Child Process Messages
-
-These are concerned with the various spawned child processes,
-including shell scripts, git commands, editors, pagers, and hooks.
-
-e.g: `void trace2_child_start(struct child_process *cmd)`.
-
-=== Git Thread Messages
-
-These messages are concerned with Git thread usage.
-
-e.g: `void trace2_thread_start(const char *thread_name)`.
-
-=== Region and Data Messages
-
-These are concerned with recording performance data
-over regions or spans of code. e.g:
-`void trace2_region_enter(const char *category, const char *label, const struct repository *repo)`.
-
-Refer to trace2.h for details about all trace2 functions.
+CPP wrapper macros are defined to hide most of these details.
 
 == Trace2 Target Formats
 
-- 
gitgitgadget

