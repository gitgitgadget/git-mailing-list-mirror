Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A70C43334
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 08:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbiGVIUF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 04:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234977AbiGVITr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 04:19:47 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6098B9E7A8
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 01:19:43 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id y24so3979631plh.7
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 01:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wq/W1UaogW21+AR8mEKJDM9cWneyVeoWVkCtYHnDQ5Q=;
        b=oj1jAaIhcySC2zvLwmYD9zDUBzdltD9LXNpA5epulPwr6Hyi8ChKe06Pz3d8G0nfvH
         rYqzJZSyia4IDhC0jh0gB3nbpndn3M1F6KTTY6FecFsd6GOM8kkBFe+g10C0adeMF8Ev
         HOCVOLnkqpBlG6C04bEPotjDeherJ6O9/FMZDjEPvyTkZ6ukP+W6X6OVdH6IA9X8jejJ
         m4H5a6tLrT+4MOOwSMl+qzq4wcL9kOMHG/HScpsd0Hz/DNVpWY+upR3KJn9XnfQN4ONv
         9meIKWVKDEYVTFvnrr3EXC7nwvGYMtpp7sYT2S5porB3eVH2hfrgmwDforFdx+UxYfjq
         K83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wq/W1UaogW21+AR8mEKJDM9cWneyVeoWVkCtYHnDQ5Q=;
        b=cc6sA5c2vWRdM6hcZvfnUGALFSX+o/9tCG7uF4xhUE+93idIpW2Bplo+6FcFUSZcE9
         KYUjzqQoBj5/N+mAIt3jy6By7OwcgOlCrTnJ4rSmlNC9+fWSU1+Yh/lWiwMxgTmjEzMi
         h4lFjUH4O6TdJo0edSemd/b7UM9xZSvt1o0RHB2MbJAg6/tR7dQPkhSEW4Q/fVt+9HgP
         GCBQ61X0hVi/t2O3YFqW6DMvzKZGOkofJ76ldGDSyXN3tbpu1Qi/9FEWA6x855JMwCPw
         wMq+uLaDdGwvrNPwP1pDnKTPyURJD8uxjYZ5eatep/A+bAaYNdCCQ/V8Gtcaq1jsztwj
         hStw==
X-Gm-Message-State: AJIora8lKi113KWfmptRYz7V8BznMmYGrkIcwfu1h2bYvHkA0iBYifC7
        Q8cGMW1KWi+p1A0cXitCiIbyZOpcn8Q=
X-Google-Smtp-Source: AGRyM1ssSYyxGrrK8wuZTSm5TDcvd2kPfMC+AJg2zGfiu5UvWaldk15ooLD7kJJocQhVa9/+tRnmqw==
X-Received: by 2002:a17:90b:4a04:b0:1ef:c318:ef9c with SMTP id kk4-20020a17090b4a0400b001efc318ef9cmr15796477pjb.67.1658477981889;
        Fri, 22 Jul 2022 01:19:41 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.102])
        by smtp.gmail.com with ESMTPSA id q9-20020aa78429000000b00528d580cb45sm3188734pfn.127.2022.07.22.01.19.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jul 2022 01:19:41 -0700 (PDT)
From:   "tenglong.tl" <dyroneteng@gmail.com>
X-Google-Original-From: "tenglong.tl" <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@jeffhostetler.com, git@vger.kernel.org,
        gitster@pobox.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v1 1/2] api-trace2.txt: print config key-value pair
Date:   Fri, 22 Jul 2022 16:19:31 +0800
Message-Id: <32f8b9ae6bb6aff0ce55ee494c4c0d40c672752b.1658472474.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.37.1.1.g8cbb44ffc4.dirty
In-Reply-To: <cover.1658472474.git.dyroneteng@gmail.com>
References: <cover.1658472474.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

It's supported to print "interesting" config key-value paire
to tr2 log by setting "GIT_TRACE2_CONFIG_PARAMS" environment
variable and the "trace2.configparam" config, let's add the
related docs in Documentaion/technical/api-trace2.txt.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 Documentation/technical/api-trace2.txt | 32 ++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index 77a150b30e..ddc0bfb9c9 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -717,6 +717,7 @@ The "exec_id" field is a command-unique id and is only useful if the
 {
 	"event":"def_param",
 	...
+	"scope":"global",
 	"param":"core.abbrev",
 	"value":"7"
 }
@@ -1207,6 +1208,37 @@ at offset 508.
 This example also shows that thread names are assigned in a racy manner
 as each thread starts and allocates TLS storage.
 
+Print Configs::
+
+	  Dump "interesting" config values to trace2 log.
++
+The environment variable `GIT_TRACE2_CONFIG_PARAMS` and configuration
+`trace2.configparams` can be used to output config values which you care
+about(see linkgit:git-config[1). For example:
++
+----------------
+$ git config color.ui auto
+----------------
++
+Then, mark the config `color.ui` as "interesting" config with
+`GIT_TRACE2_CONFIG_PARAMS`:
++
+----------------
+$ export GIT_TRACE2_PERF_BRIEF=1
+$ export GIT_TRACE2_PERF=~/log.perf
+$ export GIT_TRACE2_CONFIG_PARAMS=color.ui
+$ git version
+...
+$ cat ~/log.perf
+d0 | main                     | version      |     |           |           |              | ...
+d0 | main                     | start        |     |  0.001642 |           |              | /usr/local/bin/git version
+d0 | main                     | cmd_name     |     |           |           |              | version (version)
+d0 | main                     | def_param    |     |           |           |              | color.ui:auto
+d0 | main                     | data         | r0  |  0.002100 |  0.002100 | fsync        | fsync/writeout-only:0
+d0 | main                     | data         | r0  |  0.002126 |  0.002126 | fsync        | fsync/hardware-flush:0
+d0 | main                     | exit         |     |  0.002142 |           |              | code:0
+d0 | main                     | atexit       |     |  0.002161 |           |              | code:0
+----------------
 == Future Work
 
 === Relationship to the Existing Trace Api (api-trace.txt)
-- 
2.37.1.1.g8cbb44ffc4.dirty

