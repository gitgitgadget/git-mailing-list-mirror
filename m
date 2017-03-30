Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 294AF20969
	for <e@80x24.org>; Thu, 30 Mar 2017 01:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933279AbdC3BUh (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 21:20:37 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36173 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933121AbdC3BUg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 21:20:36 -0400
Received: by mail-pg0-f48.google.com with SMTP id g2so22875273pge.3
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 18:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AFU/KDNCTkxyU/dEEm6d+8e4LC31f8Adxqs+lsFulpo=;
        b=kX6aNeGQjMYx3zlbHDzRvA4bcot0KJKuXCrOooxMDoCKTqZZcmqU8mkxjMa+lKTjmK
         egprKUUBz+u/fE8zotOj5dTsg5MuHv0C3HxeWISdctYP47sMY2i631UAxJxDE+bQinCH
         8jWKGa89+t/2wkG+R4bK1Fs7nALQEquHY+udxp/Fw/1CgYiUezHlgpwr1wim6ZTz2Evs
         WNikmUpyCq/wNGzDs6Ocfhji5XHh88ZrOI0BnY6pEytDq/SSUD44UnNu1m8yLW0YYRkg
         PN1PKtA4M01UzxRkVOKm+3rAdcJM4QcLw6qCm4LYBRRIqKDJrTAYvNHdQq/WicCiJnLt
         PGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AFU/KDNCTkxyU/dEEm6d+8e4LC31f8Adxqs+lsFulpo=;
        b=Lzh8ZIDfn3RwxbsVG0qjj1tjkKPYZipF1GPQRCG2vToCBb3Gka02pTAFAcqpMeQxKS
         AvjCdDYffG7OKEM4WfF1D35fK4ybUWf7qhpBn7wqX14X9HNqJ44LM/3066Azz6JwV2Wz
         jp3Uq+p5qbwOVnKAdV91AhMT5Mb2kz8gHQwKR6oE8pjSu3Z/lyRGIkHgvUk2ZPC1mtOw
         SNPOr7typs1IEKp6003Zi1gxNm0wa9nCnn3B9Vyb7tJAIH6JBmzJqT7igVgiNkujvoN8
         zy6ypNOQ5qb66qDKAu5Y+ibi0mQSZEDJ0vp9+x3cRnVUcEgm5/y+TqmdDghPh9dquuik
         rLUg==
X-Gm-Message-State: AFeK/H2pwb3drwOs1W4oRmqzlryOEG3yfe5lg7yIgkzb/h2A0mrMkmmSKs5bOKyz4sKFZDPO
X-Received: by 10.99.132.72 with SMTP id k69mr3337444pgd.97.1490836834225;
        Wed, 29 Mar 2017 18:20:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:cc96:1eab:fd67:9864])
        by smtp.gmail.com with ESMTPSA id f81sm526973pfe.61.2017.03.29.18.20.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 29 Mar 2017 18:20:33 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [RFC PATCH] change default for status.submoduleSummary to true
Date:   Wed, 29 Mar 2017 18:20:25 -0700
Message-Id: <20170330012025.22122-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.511.g2abb8caf66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A user complained about the workflow with submodules:
> Re submodules pain, I've seen a lot of people get confused about
> how and when to commit submodule changes. The main thing missing
> in the related UIs is some way to summarize the subproject commit
> diff in a human readable way. Maybe last log message would be better
> than just sha?

We could advise all the confused users to turn on
status.submoduleSummary.  However there is no downside from turning
it on by default apart from a slight change in behavior and bit
longer output of git-status and the help in git-commit.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 Maybe we can merge this early after 2.13, so we have a longer time frame
 in which people may react to this change of a default?
 
 Thanks,
 Stefan

 Documentation/config.txt | 2 +-
 builtin/commit.c         | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1df1965457..34d4735414 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2984,7 +2984,7 @@ This variable can be overridden with the -u|--untracked-files option
 of linkgit:git-status[1] and linkgit:git-commit[1].
 
 status.submoduleSummary::
-	Defaults to false.
+	Defaults to true.
 	If this is set to a non zero number or true (identical to -1 or an
 	unlimited number), the submodule summary will be enabled and a
 	summary of commits for modified submodules will be shown (see
diff --git a/builtin/commit.c b/builtin/commit.c
index 4e288bc513..833a651013 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1388,6 +1388,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 
 	s.ignore_submodule_arg = ignore_submodule_arg;
 	s.status_format = status_format;
+	s.submodule_summary = -1;
 	s.verbose = verbose;
 
 	wt_status_collect(&s);
@@ -1650,6 +1651,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	status_init_config(&s, git_commit_config);
 	status_format = STATUS_FORMAT_NONE; /* Ignore status.short */
 	s.colopts = 0;
+	s.submodule_summary = -1;
 
 	if (get_sha1("HEAD", oid.hash))
 		current_head = NULL;
-- 
2.12.2.511.g2abb8caf66

