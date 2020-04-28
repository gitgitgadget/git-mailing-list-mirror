Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2207C83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 09:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BA85206D7
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 09:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t0R5EPpC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgD1Jbs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 05:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726951AbgD1Jbs (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Apr 2020 05:31:48 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D52C03C1A9
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 02:31:47 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id e17so13309875qtp.7
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 02:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rlze13npESNSA5v/azSNO7Lr1dzcbp9aMHzyr3qjhJA=;
        b=t0R5EPpCx/6wLBYBopmxuc+7DEqb8GFgpIINonkSc+Q8stxEPB+XtHaIOMTJIOK1sJ
         oB/YZeM/D+rse5KOdLvumPuKUF6/negm74tz8rNnkFt5yNIC+BWN9+8QP2/VT/Fwx1Kp
         pplltjWuG6ZRGoT3BvvPV1P1FElzDbTBkt9SuEfC1vLIpJt1R1a05bQfXNgw9bdnDzNs
         TmLnATGDWlARHImV6g554uOCBIm4V/UQCXG43yl2U/xQEXCm2jsW2IzTsb6sSjVv7vYb
         k/DzduV0mTlkf9MeOdoXDwFVGLY23zVY61d5Lq9YBu6lUVGWWeUgOG1CJkgZWSybfGoQ
         BcbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rlze13npESNSA5v/azSNO7Lr1dzcbp9aMHzyr3qjhJA=;
        b=neie5WuJ06vhPSqk5NivOHL5v3QBia1Ww1eLSK8gxTyJokJLI4anAaGaMo2H2NHhHq
         lZNzWQh6SVxOY0Etqg8U+s+IsdQxiUGHsR0VYsILhvskx38OPj4RmukHDdu+T2CXc8rX
         nIS013E34Ey+F00H6VqrbMzgbOmeQ/A44ZltJWkdNuRoLugHTTQR9FEwcpZv4FdIFsa3
         lI8NHvfEBP1bQPSEaKWf63y0Lj2GlTSTxC5Xc+3n0a1WE8o5qQULng/cZmBJhINmxJNb
         LldA6/hJcGWUkgkA14X+ivPxvZ44dEN5pBhADpcqDqKE4YMGYsYII4suDsavl/DKsAhB
         A1rg==
X-Gm-Message-State: AGi0PuZg1V0rcN5Cf6M5xwctTfANm+TYPLjGgaOOpKSwKqFTnhA1DwN2
        iN9QZz0x56NRKMkOhVi7+WN8m4Uu
X-Google-Smtp-Source: APiQypKr2cNCvsS8CHIgcbkrjWWWxtRhrgdvkl1Ku+Dx3en/R345oO4wOfAVpPR1/6JQGpP2HcxWwA==
X-Received: by 2002:ac8:4cce:: with SMTP id l14mr27562932qtv.31.1588066306588;
        Tue, 28 Apr 2020 02:31:46 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id w42sm13466093qtj.63.2020.04.28.02.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 02:31:45 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH] rebase: save autostash entry into stash reflog on --quit
Date:   Tue, 28 Apr 2020 05:31:31 -0400
Message-Id: <353a67567a90aea8a90bce1de05d005c61b3b670.1588066252.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a03b55530a (merge: teach --autostash option, 2020-04-07), the
--autostash option was introduced for `git merge`. Notably, when
`git merge --quit` is run with an autostash entry present, it is saved
into the stash reflog. This is contrasted with the current behaviour of
`git rebase --quit` where the autostash entry is simply just dropped out
of existence.

Adopt the behaviour of `git merge --quit` in `git rebase --quit` and
save the autostash entry into the stash reflog instead of just deleting
it.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---

Notes:
    This patch is based on 'dl/merge-autostash'.

 Documentation/git-rebase.txt |  3 ++-
 builtin/rebase.c             |  1 +
 t/t3420-rebase-autostash.sh  | 20 ++++++++++++++++++++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index f7a6033607..7d0c89a184 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -256,7 +256,8 @@ See also INCOMPATIBLE OPTIONS below.
 --quit::
 	Abort the rebase operation but HEAD is not reset back to the
 	original branch. The index and working tree are also left
-	unchanged as a result.
+	unchanged as a result. If a temporary stash entry was created
+	using --autostash, it will be saved to the stash reflog.
 
 --apply:
 	Use applying strategies to rebase (calling `git-am`
diff --git a/builtin/rebase.c b/builtin/rebase.c
index bc4fc69906..71aec532b1 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1556,6 +1556,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		goto cleanup;
 	}
 	case ACTION_QUIT: {
+		save_autostash(state_dir_path("autostash", &options));
 		if (options.type == REBASE_MERGE) {
 			struct replay_opts replay = REPLAY_OPTS_INIT;
 
diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index b97ea62363..ca331733fb 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -184,6 +184,26 @@ testrebase () {
 		git checkout feature-branch
 	'
 
+	test_expect_success "rebase$type: --quit" '
+		test_config rebase.autostash true &&
+		git reset --hard &&
+		git checkout -b rebased-feature-branch feature-branch &&
+		test_when_finished git branch -D rebased-feature-branch &&
+		echo dirty >>file3 &&
+		git diff >expect &&
+		test_must_fail git rebase$type related-onto-branch &&
+		test_path_is_file $dotest/autostash &&
+		test_path_is_missing file3 &&
+		git rebase --quit &&
+		test_when_finished git stash drop &&
+		test_path_is_missing $dotest/autostash &&
+		! grep dirty file3 &&
+		git stash show -p >actual &&
+		test_cmp expect actual &&
+		git reset --hard &&
+		git checkout feature-branch
+	'
+
 	test_expect_success "rebase$type: non-conflicting rebase, conflicting stash" '
 		test_config rebase.autostash true &&
 		git reset --hard &&
-- 
2.26.0.159.g23e2136ad0

