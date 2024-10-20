Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A75A193419
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 13:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729431824; cv=none; b=seq98KiobLqEEsPeOEx7a1XSyEIf+zR0vZBEZg1+wnS0fwB0pX5R24npMC1Rag7l7MwtkIfoNe7EBg9UII3f2U9IZcYIgQY3UR53QFrDb44CAFPLZRlrjkPs4qNTptntUidWCAPCKRZ3cEUNIbLvDQfxyGBHuSsX4SIlTYBxLNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729431824; c=relaxed/simple;
	bh=8/c/yA7Z4chcFAC86FyGgWEKtP39z4MIdZaXvM2xvd8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oGCcXxgy/stB3EWEvPWXHv/jsEM9jH2x/y7ULQTq/bh/8zCqgSHt591smvsvR/gX4K2vzDJeF5szcEDgzHoxgAu3CyrOvVFzRmtvCr5cvtrz5KcA1hsCDyL/ldHGgEJNSrTwAgjraaGM51CAXIiXjrOsGJs9imti/Pjrcot9BhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0duO3aU; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0duO3aU"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c984352742so3907300a12.1
        for <git@vger.kernel.org>; Sun, 20 Oct 2024 06:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729431819; x=1730036619; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CiRsSr9N+34ulobRz7mRSLnLQayzsrwlctft/WmYog0=;
        b=K0duO3aU5PQnaJuD4wIXcD0Y2DnR1koU/iV5Tn70kVR4E13F/sfIVdrEadvSE0ZI1u
         jm2iZH3yaJ/yV9osljGoFYoDPaw/pAyvYlgIgaJYyUmLtzM8Xe1eq53krLvMiOUth8WO
         5hQIQlLiigQNh/qWc9+l7T9trrfRNyt8uXnMUzjVV8yxPh6Vijp7NjfVjuwooR8kkRAQ
         WqblKUdviGT5DQQT8B5iuQER7m189ohSqNUq/feomiUPY642BVRv89l2Y0Jfdf76PsRh
         YTcFOL+o96uKAlVSPyaWAKIGdJ9fBU2cwKp5nLVolFWUE+q8km6yrjkXjqirffmAaZPQ
         Tz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729431819; x=1730036619;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CiRsSr9N+34ulobRz7mRSLnLQayzsrwlctft/WmYog0=;
        b=JokU6oalk/gM1xxayOJjSRQ3fZiAIFlrgiyaNt+vMFyBUCJ/tRU/6I8NJQGjXlxWi2
         pVrzbQl5Oq7XDFooDPcMqPSPXoKlX/8Pboj+ICb7POG781BSLcs0bZKNNw1zcJihnpYY
         uW9HMEB8xk4yj703V9MxZloe/mUq1masgTzC/bd/x4HcZh9zquuJu7ZS0wxQQ5QgCRe0
         hkcQ7hVhycghq3K89kN6lnMvdV2Ou0kgZFcK+cJMvqHfy/COiTEnu8hD/AaSv1O0/NJ6
         wA1fZvMf41FvaAcDd8Rut1Rp7YVjRK0ChFtYEf3iKl4wrcDlPMFTYq0z8I0P4UCnuBsv
         mx6w==
X-Gm-Message-State: AOJu0YzY4nQMZni/dumLL9P0jI0BVux/p9+/8P8Hp5fFmcfou4SHba6j
	HhsHxX5HMUqwcOJUf0LgL4kmu7PT4vDNAnSMiiwvnajy5dvHkMhlEavSNg==
X-Google-Smtp-Source: AGHT+IEaI3ytqAcanX8jeQcydv19aO9rCXTIGzktbuDDSj5R/7eW9Gx7Q2rSNgF7MlDMwWNVR73Ftw==
X-Received: by 2002:a05:6402:845:b0:5c8:a01c:e511 with SMTP id 4fb4d7f45d1cf-5ca0ac86021mr7627303a12.10.1729431819233;
        Sun, 20 Oct 2024 06:43:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb6696b53bsm897607a12.17.2024.10.20.06.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 06:43:37 -0700 (PDT)
Message-Id: <6e89fb219b55316c6c67a6a4b87b6928ff5b6f93.1729431810.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
References: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
	<pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 20 Oct 2024 13:43:18 +0000
Subject: [PATCH v2 05/17] revision: create mark_trees_uninteresting_dense()
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

