Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53A3E95A67
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 06:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344543AbjJHGqL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 02:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344508AbjJHGpp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 02:45:45 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79624F0
        for <git@vger.kernel.org>; Sat,  7 Oct 2023 23:45:43 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40572aeb6d0so33080205e9.1
        for <git@vger.kernel.org>; Sat, 07 Oct 2023 23:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696747541; x=1697352341; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6ik6pKCVqX6lRViQ1Zuzbpmny3ZEhqa0vXRwCe9Ljc=;
        b=AIZHBI7UPAKp8N0K/jW7s8FiVavMd24nntCTWpaNlJtjh4m7ioKcWfQJXSFRAmxMol
         Jp32CRZoBVTvpw0te6O9l5OCaueMtrofJkfFvcBqXUqJO+LnFYh3YIsF6mvLsX3Ke90b
         rQlDF/D9OMGDLHtC5+/yRdBsSqopiQ7YXMQ+p5NHDqs6tji/LxZISSMOcIf3BVUC02IK
         FzqM13ln5IDPnFV4GIm2R9Wkso+SZ8XbV9JUuWVJokckIfSlgy6l+cjCTKXjnDG7LFMh
         smsDNorGqFQakHoa+IFXVuWKZ4c/qqjsGr8pcmrzweEHJ/P7LtYCAcs9AwVLM4mr25Kp
         xxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696747541; x=1697352341;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6ik6pKCVqX6lRViQ1Zuzbpmny3ZEhqa0vXRwCe9Ljc=;
        b=KtCPTt5IzYgSDKClIsegfvh82qzLWL4QkJpmpYLZlbbQwo8zsct+Df8qEV01H3HTwl
         sH2KQetxUiHNEXLo7QqIW8oFQTivIep3ammBpztQ5/azHZQzdiZvnOKK6LDpZxT5CTz6
         biX48fwpVB7HAC22wSMxpzJdJX8Xdgu4dSmh31SP14TTl+m88GB1r163r+aOmkWJ6X/V
         9qJ0GbF71golthbcmGGGQuTKt2hKbWTmJa2c8fVv19ebk8IavYpWXAabWRO/qn4ntG4t
         Mmvz7ybK5psR7yi/CspL/zRpOcLe5s0QQfPAm7nlLb8YfFPqaZNH2stSo4RAkukyvyiB
         96qw==
X-Gm-Message-State: AOJu0YwZRaiO3pjbWoTaXudhkLYN9QHFAgBAACc2wFHAQKvbUf70KziC
        CZ/ZkyEe2hy8zCCM512jMpq0N2JVn2Q=
X-Google-Smtp-Source: AGHT+IGgy3uLeSB8+5BYi1RX8f5jp0mjs0xF40b8EYQ3jj45SDKZIUiFBRIioJ5hM/mJifKPOyP0eQ==
X-Received: by 2002:a1c:7711:0:b0:405:959e:dc7c with SMTP id t17-20020a1c7711000000b00405959edc7cmr11229906wmi.30.1696747541693;
        Sat, 07 Oct 2023 23:45:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v11-20020a5d6b0b000000b00324853fc8adsm5963484wrw.104.2023.10.07.23.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 23:45:41 -0700 (PDT)
Message-ID: <db943adfe9442c5e33a91fa59f572f8638e49fe3.1696747529.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
References: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Oct 2023 06:45:19 +0000
Subject: [PATCH 17/25] documentation: add missing hyphens
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Diff best viewed with --color-diff.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/config.txt        | 2 +-
 Documentation/config/pack.txt   | 2 +-
 Documentation/config/status.txt | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 99affec5a01..b1dba1ae853 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -118,7 +118,7 @@ are:
 	pattern, the include condition is met.
 +
 The .git location may be auto-discovered, or come from `$GIT_DIR`
-environment variable. If the repository is auto discovered via a .git
+environment variable. If the repository is auto-discovered via a .git
 file (e.g. from submodules, or a linked worktree), the .git location
 would be the final location where the .git directory is, not where the
 .git file is.
diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
index 6308f21e03d..f50df9dbce8 100644
--- a/Documentation/config/pack.txt
+++ b/Documentation/config/pack.txt
@@ -87,7 +87,7 @@ pack.indexVersion::
 	larger than 2 GB.
 +
 If you have an old Git that does not understand the version 2 `*.idx` file,
-cloning or fetching over a non native protocol (e.g. "http")
+cloning or fetching over a non-native protocol (e.g. "http")
 that will copy both `*.pack` file and corresponding `*.idx` file from the
 other side may give you a repository that cannot be accessed with your
 older version of Git. If the `*.pack` file is smaller than 2 GB, however,
diff --git a/Documentation/config/status.txt b/Documentation/config/status.txt
index f0336938cbc..2ff8237f8fc 100644
--- a/Documentation/config/status.txt
+++ b/Documentation/config/status.txt
@@ -62,7 +62,7 @@ of linkgit:git-status[1] and linkgit:git-commit[1].
 
 status.submoduleSummary::
 	Defaults to false.
-	If this is set to a non zero number or true (identical to -1 or an
+	If this is set to a non-zero number or true (identical to -1 or an
 	unlimited number), the submodule summary will be enabled and a
 	summary of commits for modified submodules will be shown (see
 	--summary-limit option of linkgit:git-submodule[1]). Please note
-- 
gitgitgadget

