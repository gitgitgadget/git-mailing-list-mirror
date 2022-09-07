Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B67ECAAD3
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 08:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiIGI1f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 04:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiIGI12 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 04:27:28 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC33AB401
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 01:27:20 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id ay12so8310196wmb.1
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 01:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=IEU+nj59wmjbCHiON6xmWoLa/T5gI739UJqe4MhHj2M=;
        b=qxZE2aWGWwvi/qSNTmlQUulVcaR/QbiPkt8NrrVyHFd4HrpDizmAe4yTtSX2P+CC3v
         l6QuaTPRdJuAMQQOoUaY+1a//3E8Xouf0RNCUx0hwZoIJPgyOQz+R/SvlrQEYUab2oK1
         QboOXnj/+8hzvc2rq0eal7ba5h98cPit+ZvOmnLsOEBzYFH5+L+e86MkKKsW96qc3U/3
         QMO2j/tpC4wcnSA2iY+vilUbP4OEA3qs5QTQFsM8Q/Uj9/QSxYGjWJgGPnJCtNYANOpS
         onLpxONc6VERIgkrrs0p3ivAiBratZdfV7F1Q58xlP7Ely6G9Sn3hktJ1wWILEfPejkq
         5PHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=IEU+nj59wmjbCHiON6xmWoLa/T5gI739UJqe4MhHj2M=;
        b=KnDioFY9NHCnBnqukebT3QZUIVhreDK6DH3wmDf/fSf5C7XqeB7pYxdiKURn6MM8EL
         tk6uG7iLazr3qFU2YRF/X7jWpLi+VFamFEZGEFgDGOxqZ6AVWBTVtnPhRY8z9UIXVM3Z
         w7Lzg6/k5Q0AD6vl9MQ3103Da0h9eArjuzkAkM5NnPKUv5QvdALTixG2R/zPg3rpLVEu
         IgIiX+xHpGszsTMT8wdW33lXtEJIsXB3vcbmk4gpt74b26J9f/ABepAWSpuyRLbvHgFa
         zuk01i1To6bfdVRD4dZL7LWT2knlON9tmKLrtXJPcyaBtYsQjxm4cUtQLgTXA14BJbi9
         XSCg==
X-Gm-Message-State: ACgBeo3RyRmiveGggD+Q2wwwHR5q6wNPWmYPI6gbfFz1Atbn4UHKbsAT
        ZUbDvNolO6KxiJZmjxxk45A7HkSEYW+02w==
X-Google-Smtp-Source: AA6agR6dHc35iETbBHrlRbMbQB6pzwOGwkYjxw2rVjehdxm+L2Zqba/AD58DRiiNloGBAuOUbDo/Yg==
X-Received: by 2002:a05:600c:3d12:b0:3a5:f600:4fe9 with SMTP id bh18-20020a05600c3d1200b003a5f6004fe9mr16092683wmb.98.1662539238718;
        Wed, 07 Sep 2022 01:27:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003a3170a7af9sm19532096wmq.4.2022.09.07.01.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 01:27:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 7/9] log docs: de-duplicate configuration sections
Date:   Wed,  7 Sep 2022 10:27:03 +0200
Message-Id: <patch-v4-7.9-6465a98ec0a-20220907T082419Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1490.g9adf4224da0
In-Reply-To: <cover-v4-0.9-00000000000-20220907T082419Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20220831T083759Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20220907T082419Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/log.txt |  4 ++++
 Documentation/git-log.txt    | 30 ++----------------------------
 2 files changed, 6 insertions(+), 28 deletions(-)

diff --git a/Documentation/config/log.txt b/Documentation/config/log.txt
index 5250ba45fb4..bc63bc3939c 100644
--- a/Documentation/config/log.txt
+++ b/Documentation/config/log.txt
@@ -7,6 +7,10 @@ log.date::
 	Set the default date-time mode for the 'log' command.
 	Setting a value for log.date is similar to using 'git log''s
 	`--date` option.  See linkgit:git-log[1] for details.
++
+If the format is set to "auto:foo" and the pager is in use, format
+"foo" will be the used for the date format. Otherwise "default" will
+be used.
 
 log.decorate::
 	Print out the ref names of any commits that are shown by the log
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 410095e9a4f..2a66cf88807 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -209,36 +209,10 @@ i18n.logOutputEncoding::
 	Defaults to the value of `i18n.commitEncoding` if set, and UTF-8
 	otherwise.
 
-log.date::
-	Default format for human-readable dates.  (Compare the
-	`--date` option.)  Defaults to "default", which means to write
-	dates like `Sat May 8 19:35:34 2010 -0500`.
-+
-If the format is set to "auto:foo" and the pager is in use, format
-"foo" will be the used for the date format. Otherwise "default" will
-be used.
-
-log.follow::
-	If `true`, `git log` will act as if the `--follow` option was used when
-	a single <path> is given.  This has the same limitations as `--follow`,
-	i.e. it cannot be used to follow multiple files and does not work well
-	on non-linear history.
-
-log.showRoot::
-	If `false`, `git log` and related commands will not treat the
-	initial commit as a big creation event.  Any root commits in
-	`git log -p` output would be shown without a diff attached.
-	The default is `true`.
-
-log.showSignature::
-	If `true`, `git log` and related commands will act as if the
-	`--show-signature` option was passed to them.
-
-mailmap.*::
-	See linkgit:git-shortlog[1].
-
 include::includes/cmd-config-section-rest.txt[]
 
+include::config/log.txt[]
+
 include::config/notes.txt[]
 
 GIT
-- 
2.37.3.1490.g9adf4224da0

