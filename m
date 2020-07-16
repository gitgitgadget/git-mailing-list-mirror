Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE8AC433E0
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 06:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92A612067D
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 06:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ofmhkja2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgGPG2V (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 02:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgGPG2V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 02:28:21 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462A4C061755
        for <git@vger.kernel.org>; Wed, 15 Jul 2020 23:28:21 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x9so3432637plr.2
        for <git@vger.kernel.org>; Wed, 15 Jul 2020 23:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qUXFwk9THhCXpN6QhpfMoPRJ/f2k8cJjqKVWigKCiZc=;
        b=Ofmhkja2CdVMz+ElYCH9GhvZPtufGLgvhZCCroj0P2zkmwNVmmf5d5EfXvkjkOHXMg
         MmDatywClVpIRngFQ5U7PKhfiennj/gQHVsmUMVtUPGqvRnhCSqViiyHI+2utO1fXACr
         A88FDlSzcgR/rhh/THIRLTIGRu42TnRb5QhqV+nlkACz8ms4ZQ6l8KHhsZcmRk6rRE7g
         2XFPgZOlkrnCsmGsODJnG5rDmlUFAvrlsU7eVaSfoVEznh/Z+4WJ3THLbU+KOU/IbHf1
         9O+AiPzIosDeZY8WUfA7VVQcChXb058YycdNyY0KQdfJeB6q8qi2LhSd7xDrfuzn6cu8
         Eu1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qUXFwk9THhCXpN6QhpfMoPRJ/f2k8cJjqKVWigKCiZc=;
        b=MScbYepmVZrYNAU+j9AGTBqZdO2ez14WAycwN6MdKKiiQJzetPck0crJlfo4UefFBO
         +4iQzv88SyAV1pBK/ToX6grBAPsojaWobrppOQlqHXbYyndaP5wJgmgxxqqOq3GdPGyI
         dHLB2cA7OxxzNsV6GJR9TjthakZ5J95qsQCl3ikYRycp5emZ4AGk6v3aop3R1okIZuE4
         Ur4nmfJM90YbdMu+8Z1UA9qSRTedH181XJ/MVS9g/mZoXtxm0v5BEPo83MXzkL5RHgaK
         /uYE+TVfK1I5JwSp6DOl/p8OwHTYRTWltyq9VKAAqpc2jMZR9KYS72rAirAOoLtqGUnZ
         xYDA==
X-Gm-Message-State: AOAM533eazDnl/CBts9b5qFgx2bTq/fOlpevgGkpjt9D2V0n4awqInyS
        71lUPgbdpo9L4EUOz+0KBPQ=
X-Google-Smtp-Source: ABdhPJzCydj0kIGRhrq8bKXdzDb4OdYdIpxNC1t1I+MeV02mxFU41zgezeekYRXN2duCyDrr5UFfNg==
X-Received: by 2002:a17:90a:de0c:: with SMTP id m12mr3404731pjv.228.1594880900794;
        Wed, 15 Jul 2020 23:28:20 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id y27sm4084649pgc.56.2020.07.15.23.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 23:28:20 -0700 (PDT)
Date:   Wed, 15 Jul 2020 23:28:18 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>, delphij@google.com,
        Huan Huan Chen <huanhuanchen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 2/2] repository: allow repository format upgrade with
 extensions
Message-ID: <20200716062818.GC3242764@google.com>
References: <pull.675.git.1594677321039.gitgitgadget@gmail.com>
 <0bede821-139a-d805-934a-142004abaa4c@gmail.com>
 <nycvar.QRO.7.76.6.2007141420300.52@tvgsbejvaqbjf.bet>
 <xmqqzh82ktgm.fsf@gitster.c.googlers.com>
 <xmqqpn8wkben.fsf@gitster.c.googlers.com>
 <20200716062054.GA3242764@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716062054.GA3242764@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we officially permit repository extensions in repository
format v0, permit upgrading a repository with extensions from v0 to v1
as well.

For example, this means a repository where the user has set
"extensions.preciousObjects" can use "git fetch --filter=blob:none
origin" to upgrade the repository to use v1 and the partial clone
extension.

To avoid mistakes, continue to forbid repository format upgrades in v0
repositories with an unrecognized extension.  This way, a v0 user
using a misspelled extension field gets a chance to correct the
mistake before updating to the less forgiving v1 format.

While we're here, make the error message for failure to upgrade the
repository format a bit shorter, and present it as an error, not a
warning.

Reported-by: Huan Huan Chen <huanhuanchen@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Apologies again for the trouble, and thanks for your patient help.

 cache.h                  |  1 -
 setup.c                  | 12 +++++++-----
 t/t0410-partial-clone.sh |  4 ++--
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index 126ec56c7f3..654426460cc 100644
--- a/cache.h
+++ b/cache.h
@@ -1042,7 +1042,6 @@ struct repository_format {
 	int worktree_config;
 	int is_bare;
 	int hash_algo;
-	int has_extensions;
 	char *work_tree;
 	struct string_list unknown_extensions;
 };
diff --git a/setup.c b/setup.c
index 87bf0112cf3..3a81307602e 100644
--- a/setup.c
+++ b/setup.c
@@ -455,7 +455,6 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
 	if (strcmp(var, "core.repositoryformatversion") == 0)
 		data->version = git_config_int(var, value);
 	else if (skip_prefix(var, "extensions.", &ext)) {
-		data->has_extensions = 1;
 		/*
 		 * record any known extensions here; otherwise,
 		 * we fall through to recording it as unknown, and
@@ -553,13 +552,16 @@ int upgrade_repository_format(int target_version)
 	if (repo_fmt.version >= target_version)
 		return 0;
 
-	if (verify_repository_format(&repo_fmt, &err) < 0 ||
-	    (!repo_fmt.version && repo_fmt.has_extensions)) {
-		warning("unable to upgrade repository format from %d to %d: %s",
-			repo_fmt.version, target_version, err.buf);
+	if (verify_repository_format(&repo_fmt, &err) < 0) {
+		error("cannot upgrade repository format from %d to %d: %s",
+		      repo_fmt.version, target_version, err.buf);
 		strbuf_release(&err);
 		return -1;
 	}
+	if (!repo_fmt.version && repo_fmt.unknown_extensions.nr)
+		return error("cannot upgrade repository format: "
+			     "unknown extension %s",
+			     repo_fmt.unknown_extensions.items[0].string);
 
 	strbuf_addf(&repo_version, "%d", target_version);
 	git_config_set("core.repositoryformatversion", repo_version.buf);
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 51d1eba6050..6aa0f313bdd 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -42,7 +42,7 @@ test_expect_success 'convert shallow clone to partial clone' '
 	test_cmp_config -C client 1 core.repositoryformatversion
 '
 
-test_expect_success 'converting to partial clone fails with noop extension' '
+test_expect_success 'convert to partial clone with noop extension' '
 	rm -fr server client &&
 	test_create_repo server &&
 	test_commit -C server my_commit 1 &&
@@ -50,7 +50,7 @@ test_expect_success 'converting to partial clone fails with noop extension' '
 	git clone --depth=1 "file://$(pwd)/server" client &&
 	test_cmp_config -C client 0 core.repositoryformatversion &&
 	git -C client config extensions.noop true &&
-	test_must_fail git -C client fetch --unshallow --filter="blob:none"
+	git -C client fetch --unshallow --filter="blob:none"
 '
 
 test_expect_success 'converting to partial clone fails with unrecognized extension' '
-- 
2.28.0.rc0.105.gf9edc3c819

