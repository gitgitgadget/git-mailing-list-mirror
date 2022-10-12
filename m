Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6D6C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 18:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiJLSwn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 14:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiJLSwi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 14:52:38 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D07E070A
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 11:52:37 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j7so27542494wrr.3
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 11:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkJEMJFGS4hSCnUT3RbeMHEA6CGfHK7Uqd4sKFLXPuo=;
        b=Gv+RktFXz4tycKgrh9PelIgo40vZ0pRQ/tlQM9gTR4s4GFxHLDW2c1EA+2TewIEJiQ
         a7WBbpnBfOqBAAY7Z89epL2HCMQKZIpB2oKvoeoNkjfOo8xkzzomt5Z0EkgzdXAmQsHA
         f0t11eDO2V0kRLkFNVENrdWfKRmKyJFo2Pox5VYxky8rSOs1Hn//BKAOa4Xyh+MAtzEk
         WsHngbfkgkzPVhqNGH8zQpyySQ+dYnoBJiALPM1pCMX4wp2heOL6UwLfee4mdOrTGKap
         SvYylhJJe5nNyvhpB43P/eSv7n/lswFX3ykMMGfb4uGPXAiyJTvBPPqjTmUp6lWcQCEg
         i+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bkJEMJFGS4hSCnUT3RbeMHEA6CGfHK7Uqd4sKFLXPuo=;
        b=pj44x7ka1jFxf4sBWdaRwGAOzDLXhLmaSHvZRQPI46z9ahEUFw7s3UGpzXjTtUh7WM
         Wm1fZxae9i9+1+rS09OvHMuIP4sPFPNX+N9ehTFf4ZhAZOnHRosZWNojWCl1ZaXjqsLx
         76AQGqGM97xQ7ugrnsTr9P9K5qBlI8nl1g7qLDdF05z0AGIV4siMxXyAArgCI5vaidKh
         qODjN06IUDVxJCcWA60ZYSEvIfpISZzQECRFFiozcIUUtd+yIvrqLKU092IYaZ9WAcYd
         sOrYEHrrjrJN7L12f41PPonZ9ua3uDEXDvp+VzIiD3Ael02oDnahhfCwjaa+eBjfGKlp
         IhQg==
X-Gm-Message-State: ACrzQf1C5lAgPzCddQCxAtb2H1UuOPUFiWlbsvxBcQitfFogj85Go2wO
        0vvhm1iVeuBU5lP+SXQRnI5np6Qrvxw=
X-Google-Smtp-Source: AMsMyM5gEa25Q9ToOnuRsNNW/tpIdfIVCR72JVWnlpZmEv9cz9VtB2VInevDZzi9roebGq2OKWkQTQ==
X-Received: by 2002:a05:6000:184e:b0:22e:4649:b3c9 with SMTP id c14-20020a056000184e00b0022e4649b3c9mr20319513wri.671.1665600755296;
        Wed, 12 Oct 2022 11:52:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c510900b003a540fef440sm2773512wms.1.2022.10.12.11.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 11:52:34 -0700 (PDT)
Message-Id: <804dab9e1a7fa1cea9355bac92ada16332f1194e.1665600750.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1373.v2.git.1665600750.gitgitgadget@gmail.com>
References: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
        <pull.1373.v2.git.1665600750.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Oct 2022 18:52:26 +0000
Subject: [PATCH v2 3/7] api-trace2.txt: elminate section describing the public
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

