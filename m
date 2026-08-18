Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493E633F8A5
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 22:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787092452; cv=none; b=dv3fkZJe2ZDZxL7lm3zXwtlfvs1kqkalAVnA74jvNTL5bC6Mn04Wwl0lT/jr2Dlnka4V5d6z1W5phuV70CxGoMSmldjR2k8MoIhxI6CUDwmdWG1SRwjQu8PrjhKCLUU3D8hmHOYBhLE5d09x15mjzsfpBnd9fh542AqTQHHLPME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787092452; c=relaxed/simple;
	bh=ZbIzJgk+cWmN6PhOGt/hXHhdM8QzjhEleKGLj8bJaFA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Mr0UKn94Y0D07FmamOcZuOUymNvALS4XXtWmgynni6t0BbjlcWy7tXRn6++fPLtfFAFDKlA/X4+nYbR3DmEYiEcDC7WqayPQmO/w7nck+Bt/EOqH0q3JtWass1Ulz0/QumaVYg3U9Z+EeLkdOB0aXQzdX8fY5F/8e2uCDdjTbgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bp/v1qLR; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bp/v1qLR"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cbb7926836eso214023a12.3
        for <git@vger.kernel.org>; Tue, 18 Aug 2026 15:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787092451; x=1787697251; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wgIZU+QISZ7Z7iNGfvYoRHMBqT3Wn0EnpOsRHUPw43E=;
        b=Bp/v1qLRBXff1RZFvMku+3kF81gV0WI8O9Jwpj3xzps9+av+76uR+29ac/tCspX49v
         J8O+DovX6xM40SALi43qxWX60NaxjH46ZZPPci8Y8kcUr9xi0IJNZr6tkrE2Kw3BRbwG
         LCzTsrByKIQPemqnJYW7XaL+L8pmsJ+aFSGRiwxcR2QgfMtRK2m2b5QVMyhhlIbtPaZe
         PJptsM6SvkbAHCgGnq7GI8+Eh1dZ8RNwwEf0qS/dol4SHQSmGH7s990i9+2wg9G2DkOj
         oFaTNOnjxRwehjKfd68Q+SMgxyDUkOn9yGhirLCNb03NHiyOiUGiJiomxBhWJvjwBZqc
         ZkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787092451; x=1787697251;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wgIZU+QISZ7Z7iNGfvYoRHMBqT3Wn0EnpOsRHUPw43E=;
        b=EhXjMMfB/NRS8Eka6m3HxIdpRKKu75i45ukzrZEe6N0hKOwES0lTmj8TI71lqsh+qz
         CvHQRw+0vI1yEzzQWRaGJDc197SG11d3NKOX8P/TouDYJVkMnveZAxP1ErCwC3NMrmws
         hf04SvjERL1cls7tcPoKuANvZSB18jkbQYiH+KysERyb77qHuhAAYYh/o38gcpCy4vGK
         RgAwbRzxOLUQ3h68Q3aK4gqt/gzyvIr5YFtwIOIHxwKlCH95Vrd+DyeogGuKgnzwbgFL
         IoglXXocn3H4PbnpHIiL0RkgIQGNQOWmysZlMkb8d/LedJrQ00ERDjZxEfzaf1krwaSO
         ISxw==
X-Gm-Message-State: AOJu0Yyh99PdYuwAMs8fczVVG/93Sd/O+2EBmsVY6HNW3i+cyBGY57b4
	b60vPOrZzxJREVgPMRA57aGwwhMrtlBy4EVbSqLAaUZJVyqR34MzEg2cuVb6+A==
X-Gm-Gg: AR+sD10sWclCZ5a7AMPEEud09ADykiJ3/ae2L4SHgufczQzYXroNEKfiHZ2AtXF76yu
	YpnK+hWSEd/kAgQaozbxSonisoxJvj7w7/GORpCrujpNRYLk25sPalLpaU/XaXZdZje7K/JMxdh
	D9AS+62vILJTrsrv9iKUni/4JZhLI2MDa3Kff9eoQLdiP2IQTMq9XGHctkzkYM443Osw8JqpI8q
	fg3UCUdaZBDDEK7KoUH2GXx6gFKVZ2OWhj1EJnHckBSfm9p9Gc3N2kHKtjkob+ZJIOkNWVXkotv
	KXXf8N762ACLVqWBQGBnKrTTKczTfve5SUA6p2iiCwYfx0lJVDTe7Wm57v6BoE0XELsw1CfzJHX
	azj+kHdqkvVRko/xrBQltnLer03i2fFT1hYOeTAdGEWlSWQo4zuIaH3pv0jdue+mrOxGoO51nx7
	n7BScGZfEiT1xJS4J1lI7A1GKZ/5dWhlEX5BNv6Cq2ak1eeYOoTuZov4z0j9dobXJi
X-Received: by 2002:a05:6a21:3382:b0:3c8:f342:132c with SMTP id adf61e73a8af0-3cd0193a7b4mr571372637.11.1787092450467;
        Tue, 18 Aug 2026 15:34:10 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.247.233])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf143775sm253141eec.23.2026.08.18.15.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 15:34:09 -0700 (PDT)
Message-Id: <321af575e0a9e0c22c70c1809f6fbf0265b05d4c.1787092446.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 18 Aug 2026 22:34:05 +0000
Subject: [PATCH 1/2] replay: fail gracefully when a merge input is unreadable
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

When objects involved in the merge cannot be read, the merge machinery
will return early with result.clean = -1, and result.tree left as NULL.
pick_regular_commit() tested only "if (!result->clean)", ignoring the
case where "clean < 0".  That causes the code to try to use
result->tree, resulting in a SIGSEGV.

Handle clean < 0 explicitly; the merge machinery will already have printed
messages such as "Could not read <object>" and "collecting merge info
failed for trees...", so we don't need to add much detail beyond the
fact that the merge failed.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 replay.c                 |  7 +++++++
 t/t3650-replay-basics.sh | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/replay.c b/replay.c
index 463c900d6c..33e21b2032 100644
--- a/replay.c
+++ b/replay.c
@@ -327,6 +327,13 @@ static struct commit *pick_regular_commit(struct repository *repo,
 	merge_opt->ancestor = NULL;
 	merge_opt->branch2 = NULL;
 
+	if (result->clean < 0) {
+		error(_("merge of %s onto %s failed"),
+		      oid_to_hex(&pickme->object.oid),
+		      oid_to_hex(&replayed_base->object.oid));
+		return NULL;
+	}
+
 	if (!result->clean)
 		return NULL;
 
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index 3353bc4a4d..d66b8edb95 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -565,4 +565,39 @@ test_expect_success '--onto with --ref rejects multiple revision ranges' '
 	test_grep "cannot be used with multiple revision ranges" err
 '
 
+test_expect_success 'replay fails without segfault when objects are missing' '
+	test_when_finished "rm -fr unreadable" &&
+	git init unreadable &&
+	(
+		cd unreadable &&
+
+		test_write_lines l1 l2 l3 l4 l5 l6 l7 l8 >f &&
+		git add f &&
+		git commit -m base &&
+		git branch base &&
+
+		test_write_lines l1 l2 l3 l4 l5 l6 l7 CHANGED >f &&
+		git commit -am side &&
+		git branch side &&
+
+		git switch -c onto base &&
+		test_write_lines CHANGED l2 l3 l4 l5 l6 l7 l8 >f &&
+		git commit -am onto &&
+
+		# The replay works while every object is readable.
+		git replay --onto onto base..side &&
+
+		# Removing the onto tree makes parse_tree() fail during the
+		# incore merge, driving clean < 0 with a NULL result tree.
+		onto_tree=$(git rev-parse onto^{tree}) &&
+		obj=$(test_oid_to_path "$onto_tree") &&
+		mv .git/objects/${obj} saved-tree &&
+
+		# Ensure replay gracefully handles the missing object
+		test_must_fail git replay --onto onto base..side 2>err &&
+		test_grep ! "[Ss]egmentation" err &&
+		test_grep "Could not read\|collecting merge info failed" err
+	)
+'
+
 test_done
-- 
gitgitgadget

