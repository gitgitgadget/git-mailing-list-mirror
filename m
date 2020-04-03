Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E501C2BA1B
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 20:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4301920737
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 20:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bL5Gh/S6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgDCUsZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:48:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51309 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbgDCUsY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 16:48:24 -0400
Received: by mail-wm1-f65.google.com with SMTP id z7so8477008wmk.1
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 13:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gHLUv+fjEqgeGWZDf3A027RgdcePiiwTZ2oCeiPzawA=;
        b=bL5Gh/S6hoxJT39bTBrhQ62Dd9bbSutQDtdSogRLYXrWLzQ4zDYLgcRVtL0HIbumX9
         8HKrAknC0o8xMCmEdsAtOupAM+WiOvDc6bKlE5Truqm3DquW3gMw09OaGfjlGZghKoMx
         ESBqWPMZ3onkDqR6t7N6aqTgRQrgxx+xOZbJTp6vThF/50lHWmywU/GkkApOMLiwcW6l
         DIbzX1ENZE2NAEiIHNb3HLN36dBJ4z6weVuaIQC/Vu++9YaHq1HTpoiYDtwgcbVVjZYr
         JMlxocpC41Sy1+hjHz35tWf8K2+TvX5ZoPl/jHkkXwTTjCYQYRznzGEuBN7ENZehKOrZ
         ddtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gHLUv+fjEqgeGWZDf3A027RgdcePiiwTZ2oCeiPzawA=;
        b=ELo00pBB4U0Xgr7Sy4YkPOvQ+nmQinex4Cgmd4Ip+j+FAyx5FRbxn2utaQ3/7CO0oC
         /3k00hx3nK3tNt9rzfnewy2droFGVp9/MyHq7xbreAms0l3mbJhwgNPqAEVFAkv7exdB
         SRJEXB7D1ZlPJRGo4quUhVcgi/DDTTSCKtcR3XuEWfiPt5xG2Mj0RE2ysE1CUnI7N3r1
         ixUPEL6vEFBuv0huN81anagQRa5W7IFbKffjyyfVZSeh/FSj5J4Y9ZDVhs7fC9boqch6
         9YTHr5ibHstbY5O8dC+9SUABgAqh3gxLE9IIgMbiodOrtuO4/NmrJRe1sRbVBdkIRq2H
         qKfA==
X-Gm-Message-State: AGi0PuY9yf//LW0XLrS0LHW5/AdY86UWS8IYb9fKPCvtizMQookYuIRq
        vZkyghtB7Mh1EjJigVwu5CvXKF4h
X-Google-Smtp-Source: APiQypLX1PgTSwrJflOrmed7UsBnBb1eE8rCNgml7nNahw/BvxHmrHwoEr10FnsB5v8iIx+jzV7nZQ==
X-Received: by 2002:a1c:6503:: with SMTP id z3mr170594wmb.92.1585946902731;
        Fri, 03 Apr 2020 13:48:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 61sm14306554wrn.82.2020.04.03.13.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 13:48:21 -0700 (PDT)
Message-Id: <9104ae46371a08967805f6ce27586ccade37972a.1585946894.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.597.git.1585946894.gitgitgadget@gmail.com>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Apr 2020 20:48:08 +0000
Subject: [PATCH 09/15] job-runner: load repos from config by default
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@google.com, stolee@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'git job-runner' command was introduced with a '--repo=<path>'
option so a user could start a process with an explicit list of
repos. However, it is more likely that we will want 'git
job-runner' to start without any arguments and discover the set of
repos from another source.

A natural source is the Git config. The 'git job-runner' does not
need to run in a Git repository, but the config could be located in
the global or system config.

Create the job.repo config setting as a multi-valued config option.

Read all values for job.repo whenever triggering an iteration of
the job loop. This allows a user to add or remove repos dynamically
without restarting the job-runner.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/job.txt |  7 +++++++
 builtin/job-runner.c         | 20 ++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/config/job.txt b/Documentation/config/job.txt
index efdb76afad3..2dfed3935fa 100644
--- a/Documentation/config/job.txt
+++ b/Documentation/config/job.txt
@@ -4,3 +4,10 @@ job.pack-files.batchSize::
 	part of `git run-job pack-files`. If not specified, then a
 	dynamic size calculation is run. See linkgit:git-run-job[1]
 	for more details.
+
+job.repo::
+	Store an absolute path to a repository that wants background
+	jobs run by `git job-runner`. This is a multi-valued config
+	option, but it must be stored in a config file seen by the
+	background runner. This may be the global or system config
+	depending on how `git job-runner` is launched on your system.
diff --git a/builtin/job-runner.c b/builtin/job-runner.c
index 135288bcaae..bed401f94bf 100644
--- a/builtin/job-runner.c
+++ b/builtin/job-runner.c
@@ -20,6 +20,9 @@ static int arg_repos_append(const struct option *opt,
 
 static int load_active_repos(struct string_list *repos)
 {
+	struct string_list_item *item;
+	const struct string_list *config_repos;
+
 	if (arg_repos.nr) {
 		struct string_list_item *item;
 		for (item = arg_repos.items;
@@ -29,6 +32,23 @@ static int load_active_repos(struct string_list *repos)
 		return 0;
 	}
 
+	config_repos = git_config_get_value_multi("job.repo");
+
+	for (item = config_repos->items;
+	     item && item < config_repos->items + config_repos->nr;
+	     item++) {
+		DIR *dir = opendir(item->string);
+
+		if (!dir)
+			continue;
+
+		closedir(dir);
+		string_list_append(repos, item->string);
+	}
+
+	string_list_sort(repos);
+	string_list_remove_duplicates(repos, 0);
+
 	return 0;
 }
 
-- 
gitgitgadget

