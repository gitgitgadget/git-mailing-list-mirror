Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB45C433FE
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 09:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 133FA610E5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 09:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237917AbhJFJmz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 05:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237637AbhJFJmw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 05:42:52 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA768C06174E
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 02:41:00 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r18so6928197wrg.6
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 02:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2wY/yU7YkB1IJ4uBKj0xrL7w0ddrQxRtHFaRXE1KXeM=;
        b=NsYzsE7WQA3n5RfnHiS7z65KCpUVdI8jZ4k18ueTdu3rgY8Q2p6IIoAVbH6w8816MK
         Ar7egFigpGSCHKwoeYoKnv1NBCdE6I/i8Ivnainnymblp3hfIk4J4T35hc4kI2qgPDcy
         eOngXuG7O85YZv2FwbkKAHMVnLOaEGESP5F6/8eQfj6SrLhSbsvh3dUktGhhOCsEJRnG
         bLyvS+3IhY+TIm71cOQxBrxTsHtA7jlWoQ7LcO4Ef0Ua1UgWCL3/D7u/NAGH0dSotY2E
         dBesMYgl2hgijEhnrfSMsIbp6bbVG+U2BgIMzyKLeJ6iW07ZoatQRXWl2YwEtgUCqgQX
         IPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2wY/yU7YkB1IJ4uBKj0xrL7w0ddrQxRtHFaRXE1KXeM=;
        b=5F40P6DZrVDv7y0E7muYfVu3lccXWjY0gHM5jwj6+W9wwCp50dX75kMIW34nx2AuiL
         HsyldeCFNJNZ16XrOj4ovhBH8vQDT4bdpI1ABuZev/+QH/TVrESK5Ohk7A9COLLU74K9
         D40QsLO2M/oi33yFZ3gIdBOOOj12PjafyYPNJ4RytB5HE4UDNUhQ9su2XtUcdyzYHDd4
         28UlJ3WS+q88leFzarxQv1XcJgnA3pX81R9HY0Q7UIhQ4iUxLQ6qHyzeRTBBf/P6p15A
         py2Hbt2O0Acyo6ALCKGNNhBg9gpIV6e12tidJ10aE0Crrtg6u61auPSku8CyrVfqww+l
         zkuQ==
X-Gm-Message-State: AOAM531TgcdhRK3Do3jaiAo3IxSHxoCapQNuEM/uYyGpWptwgnyA24hr
        iiI736bbxeFpWp/i4p+fZzf583qyGLql3Q==
X-Google-Smtp-Source: ABdhPJwAGUtBcRu90Lt+SWux7BUwavPYlkD6tJLXM6MZFmwsfR/CaLpLMATSGdohEd5VmVFohE35SA==
X-Received: by 2002:a1c:3807:: with SMTP id f7mr826588wma.117.1633513258960;
        Wed, 06 Oct 2021 02:40:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x10sm4741868wmk.42.2021.10.06.02.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 02:40:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] unpack-trees: don't leak memory in verify_clean_subdirectory()
Date:   Wed,  6 Oct 2021 11:40:47 +0200
Message-Id: <patch-1.2-e5ef1be2aa9-20211006T093405Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1441.gbbcdb4c3c66
In-Reply-To: <cover-0.2-00000000000-20211006T093405Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20211006T093405Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix two different but related memory leaks in
verify_clean_subdirectory(). We leaked both the "pathbuf" if
read_directory() returned non-zero, and we never cleaned up our own
"struct dir_struct" either.

 * "pathbuf": When the read_directory() call followed by the
   free(pathbuf) was added in c81935348be (Fix switching to a branch
   with D/F when current branch has file D., 2007-03-15) we didn't
   bother to free() before we called die().

   But when this code was later libified in 203a2fe1170 (Allow callers
   of unpack_trees() to handle failure, 2008-02-07) we started to leak
   as we returned data to the caller. This fixes that memory leak,
   which can be observed under SANITIZE=leak with e.g. the
   "t1001-read-tree-m-2way.sh" test.

 * "struct dir_struct": We've leaked the dir_struct ever since this
   code was added back in c81935348be.

   When that commit was written there wasn't an equivalent of
   dir_clear(). Since it was added in 270be816049 (dir.c: provide
   clear_directory() for reclaiming dir_struct memory, 2013-01-06)
   we've omitted freeing the memory allocated here.

   This memory leak could also be observed under SANITIZE=leak and the
   "t1001-read-tree-m-2way.sh" test.

This makes all the test in "t1001-read-tree-m-2way.sh" pass under
"GIT_TEST_PASSING_SANITIZE_LEAK=true", we'd previously die in tests
25, 26 & 28.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1001-read-tree-m-2way.sh | 2 ++
 unpack-trees.c              | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
index 1057a96b249..d1115528cb9 100755
--- a/t/t1001-read-tree-m-2way.sh
+++ b/t/t1001-read-tree-m-2way.sh
@@ -20,6 +20,8 @@ In the test, these paths are used:
 	rezrov  - in H, deleted in M
 	yomin   - not in H or M
 '
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 
diff --git a/unpack-trees.c b/unpack-trees.c
index a7e1712d236..89ca95ce90b 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2156,9 +2156,10 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 	if (o->dir)
 		d.exclude_per_dir = o->dir->exclude_per_dir;
 	i = read_directory(&d, o->src_index, pathbuf, namelen+1, NULL);
+	dir_clear(&d);
+	free(pathbuf);
 	if (i)
 		return add_rejected_path(o, ERROR_NOT_UPTODATE_DIR, ce->name);
-	free(pathbuf);
 	return cnt;
 }
 
-- 
2.33.0.1441.gbbcdb4c3c66

