Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A34C433EF
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 22:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241064AbiGNWR7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 18:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241065AbiGNWR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 18:17:57 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5489171703
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 15:17:56 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d16so4348052wrv.10
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 15:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=x2LZOsZX4TWelNAptPXsNE1WsPOedvxYu3YfuOw16Ew=;
        b=XR7xA7bLLZhNFeOBrkOZdVX1Fe6EQUA+0FZ/nsXrn4pOd0t7U3lcgebTkNWwZ9VoIw
         BCNqw5M3Cd26DceA9Mmta9KGSoG4djlQdTv7zv5Vfbc3R3LXvSLSBBbJye/+kD0hoaG3
         obsSVVaD85dX07XX9eWJ3lkCxPlN9IakyVQj4c672HFYJ++Oy9pq8nDe7uWD5dQzI8Qq
         N7ysI0xbuUYvk9SlvnLjfgUJqfH0KC9N1CLbzMVy8EDZo91gIcQ+12PBqBwIudLpNXQJ
         oB7/PXbx5XEvfGqXTcnzxrV29Sbr2MDGcBxgUxg1Kaeb8PLYIbZArsG+zOw+YkvGyUaz
         8Wxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=x2LZOsZX4TWelNAptPXsNE1WsPOedvxYu3YfuOw16Ew=;
        b=GnLM+QSGqWCCRm1QLcw5QdS+tmTmVSkNF4m+KkwD4u7L+fO6JY25cegXXUgNQUT3wK
         MHzO8xOwDXfWauiSFE3WNARRz8O1uKOP/2Uey1fac8UujYllqkVPkjtT6nnyywceyPQQ
         nrQY8uMPWAUm/dweUSfLxswqbrpJCUSPtv56D9K3V7dQYcfo6QhU2I5QJhmrecSjdcS1
         2ahuq1g4PfDaL/U4bI0/GPnZRT+qG8erhgIrD7YJ+hdeAIG+gdImMU4lMNhMpGU+Hu6+
         wKblQb55qRDojO7KcHs6knQeFvrM5YasweyZ94oHettWVRtTqzhOdrP6v0nWMVDPwG2q
         d4xw==
X-Gm-Message-State: AJIora+w331MgukEUUVqC6p0WRg9kQcaeemkYdshe+F8y0dVF0TPgOQa
        4hrs+308aPGlVRbaDkyHx4VO7mzgK6g=
X-Google-Smtp-Source: AGRyM1uoocA7KCGeJXZR1PqCv0R6ejOEKW+K/IBji9OOnXp9MhhIA0aR9Su9OaymsuFbMy1L3saKcA==
X-Received: by 2002:adf:f48e:0:b0:21d:6562:4717 with SMTP id l14-20020adff48e000000b0021d65624717mr9521343wro.428.1657837074502;
        Thu, 14 Jul 2022 15:17:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c1d1300b003a300452f7esm3548259wms.28.2022.07.14.15.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 15:17:54 -0700 (PDT)
Message-Id: <pull.1291.git.git.1657837073372.gitgitgadget@gmail.com>
From:   "Julian Prein via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 14 Jul 2022 22:17:53 +0000
Subject: [PATCH] hooks--pre-commit: detect non-ASCII when renaming
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Julian Prein <druckdev@protonmail.com>,
        Julian Prein <druckdev@protonmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Julian Prein <druckdev@protonmail.com>

Currently the diff-filter that is used to check for non-ASCII characters
in filenames only checks new additions.

Extend the diff-filter in the pre-commit sample to include `CR` as well.
This way non-ASCII character in filenames are detected on a rename/copy
as well.

Signed-off-by: Julian Prein <druckdev@protonmail.com>
---
    hooks--pre-commit: detect non-ASCII when renaming

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1291%2Fdruckdev%2Fpre-commit-renames-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1291/druckdev/pre-commit-renames-v1
Pull-Request: https://github.com/git/git/pull/1291

 templates/hooks--pre-commit.sample | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-commit.sample
index e144712c85c..95c327832da 100755
--- a/templates/hooks--pre-commit.sample
+++ b/templates/hooks--pre-commit.sample
@@ -28,7 +28,7 @@ if [ "$allownonascii" != "true" ] &&
 	# Note that the use of brackets around a tr range is ok here, (it's
 	# even required, for portability to Solaris 10's /usr/bin/tr), since
 	# the square bracket bytes happen to fall in the designated range.
-	test $(git diff --cached --name-only --diff-filter=A -z $against |
+	test $(git diff --cached --name-only --diff-filter=ACR -z $against |
 	  LC_ALL=C tr -d '[ -~]\0' | wc -c) != 0
 then
 	cat <<\EOF

base-commit: bbea4dcf42b28eb7ce64a6306cdde875ae5d09ca
-- 
gitgitgadget
