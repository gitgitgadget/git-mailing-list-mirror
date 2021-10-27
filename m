Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AA0C433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD87C61073
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240902AbhJ0IaD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 04:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240904AbhJ0I3u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 04:29:50 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BB2C0613B9
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 01:27:25 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so1641955wmz.2
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 01:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dZbBihr8P478PPKLNmEh1kp6VSl3WRtsE74oahy/YaE=;
        b=oiKez90CJpX6HzlDM8VJJv0okebx0ba+VEPhCunPjSEPoZLFB8cYLaSxF5l0gw9uru
         Sw9W+YDYohnxGBeOHkD5hzvWcVjkVJbVt9pZb1gY4iYiQQahKCjtinzGoDYDDGYMciTo
         jECXn7wis+2qFybfZrBkkUY/Ai79Cy9sZ8BMk9AQt2zQvPCNC+sdAbWv2QwSbxg9yoru
         PFFg5O3yDShr91KsjtHLaDTnqO1CSW+nsd4y5uQTWWwF758GiUCSO0NC+prUI/I3KajD
         CsHZoI76p5Z/tVKAr3ayy4CsKriD9soGgPISZaQ4oBQb0AaSJpjhBgB6Iu9+Jrte8FHD
         EZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dZbBihr8P478PPKLNmEh1kp6VSl3WRtsE74oahy/YaE=;
        b=QRwu9c81vvtzGJwIdjrDlxS3T1hBE6QDfd71KJVvAiRn+JgEWbMYGp6lItnxgtQa8D
         /cY/QzNeZ1nAp/rmWM80JoWzIXTY4067SyX0g/zBpHcH+fcW22stJOuCuc7UkyNDstFX
         E6Z5NrS55b651MhvL/zWH2QxU/EKhvmZEbQ7xgoHj0fKUfFEXAN1a6w/OuiY3M8823+e
         L8T3CMJG3vYphhrj7T+tw20Y/DLf3ssP+rTWaP/kop2d12EEpSNA4Zrn/SuGy0WTsDA9
         4Lm16d6yQBZwh3pB3yGf1g8JC51DEb3RTukQO9bTLvuKQJ5EZu2aylQ6IqflJ0M219gL
         RCZQ==
X-Gm-Message-State: AOAM530uEnQPh/f6XzQyM5G16e8fYE/NySVVFMDv75yprU8dG4dVvfsG
        gz3HvX5elZD3vhZZHBwyNQ3s57KczQQ=
X-Google-Smtp-Source: ABdhPJwMS4CbnhWvfHs1mvPBy6lvmkcoaZTX7+YckHUXaqoS9hwFtThjVjdjmicrGsWGzl19tqafKw==
X-Received: by 2002:a05:600c:4fd1:: with SMTP id o17mr4308976wmq.110.1635323244139;
        Wed, 27 Oct 2021 01:27:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 10sm3140024wme.27.2021.10.27.01.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 01:27:23 -0700 (PDT)
Message-Id: <fe04ae7ec66e66c50f63e7e4ab836f9856c76683.1635323239.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v6.git.1635323239.gitgitgadget@gmail.com>
References: <pull.1005.v5.git.1633604349.gitgitgadget@gmail.com>
        <pull.1005.v6.git.1635323239.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 08:27:10 +0000
Subject: [PATCH v6 06/15] scalar: let 'unregister' handle a deleted enlistment
 directory gracefully
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When a user deleted an enlistment manually, let's be generous and
_still_ unregister it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c          | 46 ++++++++++++++++++++++++++++++++
 contrib/scalar/t/t9099-scalar.sh | 15 +++++++++++
 2 files changed, 61 insertions(+)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index fc55404230d..dc84ce0d5b2 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -268,6 +268,24 @@ static int cmd_register(int argc, const char **argv)
 	return register_dir();
 }
 
+static int remove_deleted_enlistment(struct strbuf *path)
+{
+	int res = 0;
+	strbuf_realpath_forgiving(path, path->buf, 1);
+
+	if (run_git("config", "--global",
+		    "--unset", "--fixed-value",
+		    "scalar.repo", path->buf, NULL) < 0)
+		res = -1;
+
+	if (run_git("config", "--global",
+		    "--unset", "--fixed-value",
+		    "maintenance.repo", path->buf, NULL) < 0)
+		res = -1;
+
+	return res;
+}
+
 static int cmd_unregister(int argc, const char **argv)
 {
 	struct option options[] = {
@@ -281,6 +299,34 @@ static int cmd_unregister(int argc, const char **argv)
 	argc = parse_options(argc, argv, NULL, options,
 			     usage, 0);
 
+	/*
+	 * Be forgiving when the enlistment or worktree does not even exist any
+	 * longer; This can be the case if a user deleted the worktree by
+	 * mistake and _still_ wants to unregister the thing.
+	 */
+	if (argc == 1) {
+		struct strbuf src_path = STRBUF_INIT, workdir_path = STRBUF_INIT;
+
+		strbuf_addf(&src_path, "%s/src/.git", argv[0]);
+		strbuf_addf(&workdir_path, "%s/.git", argv[0]);
+		if (!is_directory(src_path.buf) && !is_directory(workdir_path.buf)) {
+			/* remove possible matching registrations */
+			int res = -1;
+
+			strbuf_strip_suffix(&src_path, "/.git");
+			res = remove_deleted_enlistment(&src_path) && res;
+
+			strbuf_strip_suffix(&workdir_path, "/.git");
+			res = remove_deleted_enlistment(&workdir_path) && res;
+
+			strbuf_release(&src_path);
+			strbuf_release(&workdir_path);
+			return res;
+		}
+		strbuf_release(&src_path);
+		strbuf_release(&workdir_path);
+	}
+
 	setup_enlistment_directory(argc, argv, usage, options, NULL);
 
 	return unregister_dir();
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index 16f2b72b126..ef0e8d680d5 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -14,4 +14,19 @@ test_expect_success 'scalar shows a usage' '
 	test_expect_code 129 scalar -h
 '
 
+test_expect_success 'scalar unregister' '
+	git init vanish/src &&
+	scalar register vanish/src &&
+	git config --get --global --fixed-value \
+		maintenance.repo "$(pwd)/vanish/src" &&
+	scalar list >scalar.repos &&
+	grep -F "$(pwd)/vanish/src" scalar.repos &&
+	rm -rf vanish/src/.git &&
+	scalar unregister vanish &&
+	test_must_fail git config --get --global --fixed-value \
+		maintenance.repo "$(pwd)/vanish/src" &&
+	scalar list >scalar.repos &&
+	! grep -F "$(pwd)/vanish/src" scalar.repos
+'
+
 test_done
-- 
gitgitgadget

