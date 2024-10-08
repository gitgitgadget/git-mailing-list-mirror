Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307631DFD80
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 14:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728396733; cv=none; b=s+n/fwbu3bdRxhFf72hr2obKzK92sRcfDp2JWEEY6cnwCm7vrMLm+Nl0JuPO9dhCcC4w8StRJT++vRGApkoonnZMmv7aXsVI3H+oD0bOj3K8MumDD7n2h+ql8i+D3PNMO5roBqnQi4TqNVZihhzj2YT8g+0QP8mx8V5V7musd94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728396733; c=relaxed/simple;
	bh=8/c/yA7Z4chcFAC86FyGgWEKtP39z4MIdZaXvM2xvd8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Wrz+tjHVIOD0Uhgy1NMNtzPs00aohAYYtpDyIJe/AlmGPxVQg2PpaJ1QAKSwuRLl3oL/1h1w31hDbORhhiu4XPT25egYQZDcwZmFcYLqi5e4bnvly+FAUA3mDT6zcsWOj2xcgxmcoE6r4FHyTP0q18I1uRhdn+0mOGgITEARKUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPjCICX0; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPjCICX0"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c883459b19so6651029a12.2
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 07:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728396730; x=1729001530; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CiRsSr9N+34ulobRz7mRSLnLQayzsrwlctft/WmYog0=;
        b=cPjCICX0ND+0CXmyyDV5gAAp9jc9VE5crWDOjX2ARO1+0Ghd+5O727lHQ7kSs/veGk
         LoaAspR60DrL67W81qyDpQsoCN9Wvt4kk7x/b8qloMYJxV5m9aMXXCTV8UquNqid7IyT
         aVZVocXUGK/Brabg4G4KdagwTMYYq0ZC3GiXtNJzOZQM/DHS7VY8xO2M5bv2wQUKK9nn
         NdEOsYvJyoJRSnze8D7oztZ9e04GsBXgpQvHpUD/67yjMCWFMAc1df8ShBTea7L36CdG
         BrZTVFg2sSqShPwFaZpZKn3h2kZaT2f6EwO56iK2EJWsTYcSYfETXErA3c9QxfBqul0G
         CrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728396730; x=1729001530;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CiRsSr9N+34ulobRz7mRSLnLQayzsrwlctft/WmYog0=;
        b=IurLnr01g457YadigpfecRr1KYbLNOVy/5DR0ZnEctsTVPAZxiTa1iQ/sKdm3sC552
         z+HLr6iGLa15KRo6KDKqgbjDP/JM/C8jb37ccOTSdmJQBhTmktla8dH9GRxh2cNlZJsT
         4oouWlu9qh0pqS7xdM3uDw8FwfxWrme9Pp2EM/WBbH3uTjDXvkVIndZG827tPUwihSb5
         oXGfPbUAgapD0G6LH/Ir7DqGCarIoZGZ+AfadoqIWFCIYn3uqO7Gq28DCl4AeIbglqW7
         h+mEfi2yutTd/LuW2Y/4+zXB1MnytbccmX9BK19YiDV2la16mh3XSyOmZ5t7zt6ML5B1
         tSnQ==
X-Gm-Message-State: AOJu0YzxfBwXNcHLxnRbkPszQf+uiQBI0loEIvVOsZnVkdyJsfmRZQj7
	k+s4NxH36nYFCZ0+oAeS0mtdLX9D3C6aR7L0DfiS20RrRKBXukYuYnV5XQ==
X-Google-Smtp-Source: AGHT+IHdyxgrIvZJO1bq0O8x5SVr4As+IXvRs5UVUwK3Yd1TwFPLEYATMSnCv+/fJ4/j9e3Xr/N67g==
X-Received: by 2002:a17:907:94cd:b0:a99:8629:603a with SMTP id a640c23a62f3a-a998629621bmr4927766b.57.1728396729937;
        Tue, 08 Oct 2024 07:12:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99384f8258sm481489466b.16.2024.10.08.07.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:12:09 -0700 (PDT)
Message-Id: <cd98447f7c8a3ee6b7566b12e00eaecd6e8c0c38.1728396724.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
References: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Oct 2024 14:11:51 +0000
Subject: [PATCH 05/17] revision: create mark_trees_uninteresting_dense()
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    christian.couder@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The sparse tree walk algorithm was created in d5d2e93577e (revision:
implement sparse algorithm, 2019-01-16) and involves using the
mark_trees_uninteresting_sparse() method. This method takes a repository
and an oidset of tree IDs, some of which have the UNINTERESTING flag and
some of which do not.

Create a method that has an equivalent set of preconditions but uses a
"dense" walk (recursively visits all reachable trees, as long as they
have not previously been marked UNINTERESTING). This is an important
difference from mark_tree_uninteresting(), which short-circuits if the
given tree has the UNINTERESTING flag.

A use of this method will be added in a later change, with a condition
set whether the sparse or dense approach should be used.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 revision.c | 15 +++++++++++++++
 revision.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/revision.c b/revision.c
index 2d7ad2bddff..bdc312f1538 100644
--- a/revision.c
+++ b/revision.c
@@ -219,6 +219,21 @@ static void add_children_by_path(struct repository *r,
 	free_tree_buffer(tree);
 }
 
+void mark_trees_uninteresting_dense(struct repository *r,
+				    struct oidset *trees)
+{
+	struct object_id *oid;
+	struct oidset_iter iter;
+
+	oidset_iter_init(trees, &iter);
+	while ((oid = oidset_iter_next(&iter))) {
+		struct tree *tree = lookup_tree(r, oid);
+
+		if (tree && (tree->object.flags & UNINTERESTING))
+			mark_tree_contents_uninteresting(r, tree);
+	}
+}
+
 void mark_trees_uninteresting_sparse(struct repository *r,
 				     struct oidset *trees)
 {
diff --git a/revision.h b/revision.h
index 71e984c452b..8938b2db112 100644
--- a/revision.h
+++ b/revision.h
@@ -487,6 +487,7 @@ void put_revision_mark(const struct rev_info *revs,
 
 void mark_parents_uninteresting(struct rev_info *revs, struct commit *commit);
 void mark_tree_uninteresting(struct repository *r, struct tree *tree);
+void mark_trees_uninteresting_dense(struct repository *r, struct oidset *trees);
 void mark_trees_uninteresting_sparse(struct repository *r, struct oidset *trees);
 
 void show_object_with_name(FILE *, struct object *, const char *);
-- 
gitgitgadget

