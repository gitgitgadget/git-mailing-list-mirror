Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A05C4332F
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 18:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240847AbhLUSF5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 13:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240819AbhLUSFz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 13:05:55 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F71C061401
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 10:05:54 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id i22so28530418wrb.13
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 10:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zia31FE1XXB+wrIB/bIExMhGXsofgWrEwBEylqoR5lA=;
        b=VtBTP6UFCE9TJVVb1nYXyc0R16SGaGobAzVcDQK2hwZlgDgi5oH0/kr+VLpyCElKe3
         S/k1wdc0pR9cl6cxkrpObO22fZ+/qpAdb1ct1NbC1vz7PRJrwDgMXeuyybjRyVKwUyz9
         85paAkF2CXOZtbAFyr+5YYxWbf/DimuMWOjKDcWf87ep/R9uQGwYy4i+rqBFdaJurxWb
         YtFX7xVj72yTCpN3nxhNBg3aAQmlxXfIjK9rwHcUQjm363kIo5zTFBOZeoeqemeUb3Dl
         CdRvi8V0vvEtnbOma1EzdOsU82tKtKwQ15D8D85U2rZkrIEFW+z249DmUn+SEKFd+W8K
         Jhhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zia31FE1XXB+wrIB/bIExMhGXsofgWrEwBEylqoR5lA=;
        b=FOFJVF0TszTpyKXfgRSlkPG6fZzrhyLtA4Iqy1qxmRHHmMQval9D4NeQ20+r1vtTsq
         5nNkRdEmlPPmWXqepXUiOy/w6NQW5Yuwk4hcMdOLxAxzN9hxwJQ5jdulgmOIKy9gsUxs
         s5oWQa/T5dZgOPcYtw3ZThaAE56dfpZTuuOxzcXi+gLEQT9WUP8Tp+HUYfWnhAm3+SDh
         Hp75m/ghyblJ14ZiA6FIablas8V6cfbGflRALEWd3d5xjvVVQCEFr6+YCO8TlSJOLlQu
         UWEMAykYryk+xVHm9CW3iDx0YzK68pXz9f399aRB+Uk2XdE3F6ngASMpuzuczFE21aij
         BOBQ==
X-Gm-Message-State: AOAM5327zv7CyQ4FvDluw1dPJFBfBxpsdhRcNmTFmk/l9lZA+ysBBeOV
        eZah2ZP5uyGZWYvv4lCaUyjuZnurEVw=
X-Google-Smtp-Source: ABdhPJxQKeNtJmDBhGqwCgQ9Lp7cUgFODqQ1d7YCMU5Lghju30fUjzoo+7QQO+zad1ziSyi4/kJiCQ==
X-Received: by 2002:adf:b1d5:: with SMTP id r21mr3627398wra.520.1640109953149;
        Tue, 21 Dec 2021 10:05:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 9sm1797376wrz.90.2021.12.21.10.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 10:05:52 -0800 (PST)
Message-Id: <1e7eef7705e2f7b4a456056e4335d82267680214.1640109948.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Dec 2021 18:05:43 +0000
Subject: [PATCH 4/9] merge-ort: mark a few more conflict messages as omittable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Neeraj Singh <nksingh85@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

path_msg() has the ability to mark messages as omittable, designed for
remerge-diff where we'll instead be showing conflict messages as diff
headers for a subsequent diff.  While all these messages are very useful
when trying to create a merge initially, early use with the
--remerge-diff feature (the only user of this omittable conflict message
capability), suggests that the particular messages marked in this commit
are just noise when trying to see what changes users made to create a
merge commit.  Mark them as omittable.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index a18f47e23c5..fe27870e73e 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2420,7 +2420,7 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 		 */
 		ci->path_conflict = 1;
 		if (pair->status == 'A')
-			path_msg(opt, new_path, 0,
+			path_msg(opt, new_path, 1,
 				 _("CONFLICT (file location): %s added in %s "
 				   "inside a directory that was renamed in %s, "
 				   "suggesting it should perhaps be moved to "
@@ -2428,7 +2428,7 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 				 old_path, branch_with_new_path,
 				 branch_with_dir_rename, new_path);
 		else
-			path_msg(opt, new_path, 0,
+			path_msg(opt, new_path, 1,
 				 _("CONFLICT (file location): %s renamed to %s "
 				   "in %s, inside a directory that was renamed "
 				   "in %s, suggesting it should perhaps be "
@@ -3825,7 +3825,7 @@ static void process_entry(struct merge_options *opt,
 				reason = _("add/add");
 			if (S_ISGITLINK(merged_file.mode))
 				reason = _("submodule");
-			path_msg(opt, path, 0,
+			path_msg(opt, path, 1,
 				 _("CONFLICT (%s): Merge conflict in %s"),
 				 reason, path);
 		}
-- 
gitgitgadget

