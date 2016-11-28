Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0E221FF76
	for <e@80x24.org>; Mon, 28 Nov 2016 09:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932430AbcK1Jhv (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 04:37:51 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34280 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932422AbcK1Jhp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 04:37:45 -0500
Received: by mail-pg0-f68.google.com with SMTP id e9so12654931pgc.1
        for <git@vger.kernel.org>; Mon, 28 Nov 2016 01:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=waNQIBPkbk2rQUW8hz7qidgB1wPbqySizUaJbGHL8rg=;
        b=SEAk5f2FMtEpu0OMzg7RioOlMe0HP5zwwlY7wIfUW4DiViA+4Ak758H7qBeHQLu2LI
         /7XxMz8xp5p7L9+cRdV3srwNiRplx3AtDWLFkplcAfSHKjUKialTfNIt+9DnWJ4oePNj
         GRlpRpXy76Xlm9F0Ne9LPXrNjsyS45iPdEuC+FAuywIglXjMBmLhwNVPsa1DWZRcJeWn
         v/1i14AdLj5ZKAGG1FrcsXNKBMr/3Vvb00KAP0Q8H1bOFNLkmVTaICw+VXjzjyYbXkG9
         qvWF0OIPi3Sk6+sNn/gDsM4ATpqlzjzpznKMEACUnArcgKdygK8Hbq4dQTOEY46+XRI0
         Gmgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=waNQIBPkbk2rQUW8hz7qidgB1wPbqySizUaJbGHL8rg=;
        b=KuAGXs/IvTzVk5WfU6+ZQnBEacBpMpWUHMqbPAZ+N1oiFaL26Xv+uJOSOPuSzFIEMD
         lyNHbjBUpiEfF6oljsQRUSEi45p/7WR+lJuJkpW09OTwll2sWOCoJ9zCD3sFcy8jF7Qd
         XpG0yk8oS9mAzV6EJUurA5cfd9EgZZ9AdsRTNATzNiZPNbwq+zoQHw84tMmD9RkmeW4J
         Os0K5DkC/qlamQIqlwA29hYbmWtsSnzMy7wxfanUeUYovHl+f9/gfWUwfLDM+Z4Iy92f
         8MNj75pW0Yr+WyUeqmxgdEpjGsRGxE2D70Uo8rF31w8WBDMjI/taZn5dO5pS2ypQjztN
         btkQ==
X-Gm-Message-State: AKaTC00WygNPgqi6+7hSY0AM25b6sW+i4m4HmYaZoVX9bZv7q6FEJH54g48V9rM/dtDUrw==
X-Received: by 10.98.214.157 with SMTP id a29mr20480094pfl.162.1480325864195;
        Mon, 28 Nov 2016 01:37:44 -0800 (PST)
Received: from ash ([115.73.175.91])
        by smtp.gmail.com with ESMTPSA id n25sm85747752pfi.33.2016.11.28.01.37.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Nov 2016 01:37:43 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 28 Nov 2016 16:37:38 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, rappazzo@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 5/5] worktree list: keep the list sorted
Date:   Mon, 28 Nov 2016 16:36:56 +0700
Message-Id: <20161128093656.15744-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161128093656.15744-1-pclouds@gmail.com>
References: <20161122100046.8341-1-pclouds@gmail.com>
 <20161128093656.15744-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It makes it easier to write tests for. But it should also be good for
the user since locating a worktree by eye would be easier once they
notice this.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/worktree.c       |  2 +-
 t/t2027-worktree-list.sh | 19 +++++++++++++++++++
 worktree.c               | 14 ++++++++++++++
 worktree.h               |  2 ++
 4 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index d7d195c..9a97e37 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -447,7 +447,7 @@ static int list(int ac, const char **av, const char *prefix)
 	if (ac)
 		usage_with_options(worktree_usage, options);
 	else {
-		struct worktree **worktrees = get_worktrees(0);
+		struct worktree **worktrees = get_worktrees(GWT_SORT_LINKED);
 		int path_maxlen = 0, abbrev = DEFAULT_ABBREV, i;
 
 		if (!porcelain)
diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
index 98b5f34..465eeea 100755
--- a/t/t2027-worktree-list.sh
+++ b/t/t2027-worktree-list.sh
@@ -117,4 +117,23 @@ test_expect_success 'broken main worktree still at the top' '
 	)
 '
 
+test_expect_success 'linked worktrees are sorted' '
+	mkdir sorted &&
+	git init sorted/main &&
+	(
+		cd sorted/main &&
+		test_tick &&
+		test_commit new &&
+		git worktree add ../first &&
+		git worktree add ../second &&
+		git worktree list --porcelain | grep ^worktree >actual
+	) &&
+	cat >expected <<-EOF &&
+	worktree $(pwd)/sorted/main
+	worktree $(pwd)/sorted/first
+	worktree $(pwd)/sorted/second
+	EOF
+	test_cmp expected sorted/main/actual
+'
+
 test_done
diff --git a/worktree.c b/worktree.c
index ead088e..eb61212 100644
--- a/worktree.c
+++ b/worktree.c
@@ -160,6 +160,13 @@ static void mark_current_worktree(struct worktree **worktrees)
 	free(git_dir);
 }
 
+static int compare_worktree(const void *a_, const void *b_)
+{
+	const struct worktree *const *a = a_;
+	const struct worktree *const *b = b_;
+	return fspathcmp((*a)->path, (*b)->path);
+}
+
 struct worktree **get_worktrees(unsigned flags)
 {
 	struct worktree **list = NULL;
@@ -191,6 +198,13 @@ struct worktree **get_worktrees(unsigned flags)
 	ALLOC_GROW(list, counter + 1, alloc);
 	list[counter] = NULL;
 
+	if (flags & GWT_SORT_LINKED)
+		/*
+		 * don't sort the first item (main worktree), which will
+		 * always be the first
+		 */
+		QSORT(list + 1, counter - 1, compare_worktree);
+
 	mark_current_worktree(list);
 	return list;
 }
diff --git a/worktree.h b/worktree.h
index 2e68d4a..d59ce1f 100644
--- a/worktree.h
+++ b/worktree.h
@@ -15,6 +15,8 @@ struct worktree {
 
 /* Functions for acting on the information about worktrees. */
 
+#define GWT_SORT_LINKED (1 << 0) /* keeps linked worktrees sorted */
+
 /*
  * Get the worktrees.  The primary worktree will always be the first returned,
  * and linked worktrees will be pointed to by 'next' in each subsequent
-- 
2.8.2.524.g6ff3d78

