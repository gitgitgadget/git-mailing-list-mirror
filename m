Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E80C364CD
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 09:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709111441; cv=none; b=vFoD+Eyd1p4UPL94vwVLZ3ykozy/uSRKcY317TWwUWMyXwCujN8z7H9yZ/Dd+TPIZQ129DH4RQ+nfXK9DpySJoUeGxsHo15OLHBknQrW3FVDFUl91DSdX5aaevcbJRqFrXlYNKsCUT1x0CpZDwDu+UconmFyLrD7AzVdgX8RWDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709111441; c=relaxed/simple;
	bh=YX2b/HpFvoS4hx88tT7ps0/MlEN8vmi9lrcsmQiZ/as=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSDqLTnx7h7w07AvlLmPv2nkjZGkYTCh+K2/7aHMutEJaSzPU03w+YMGkCM3/KWHAZofV+Sq5U+uj0eKWexJfjpIZnG9HKrcVAJAWHaAL6U5OqOVpwjLwbKhRYDiaparHyTrAjHjEPK661pqAbLcxOg6664MfekLiWl3TKJYewQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJ1r4MxL; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJ1r4MxL"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3e8c1e4aa7so538213466b.2
        for <git@vger.kernel.org>; Wed, 28 Feb 2024 01:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709111437; x=1709716237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lJ1Gv+jWWK8pEcgHOwLBnJrbfniIK5oRGlITTCt+e4=;
        b=jJ1r4MxLIhKdWORCzdeNJGE8DeA1uPYeSShQQXnfhWlviuy9ralCIhXEII7ME7+5lQ
         TVsmR3lXistq0IpcJlf2sWiBaLq3QyG6xJ5H5lLDvVJTiEda3sqV/pR+kha0m+fPatNL
         5N969uU22JCt5//w8id3tGT1oq157LH230OAHbRk9uP00fEloqc4aDs43W8HJFP0cpMT
         xo4pcSyYguEZfOIbDHF8RYKDzExCumGlXFGKyk2hDwqWeAL2u6yhMrhp5M0P0WHkPXOU
         6mMLQGY5qH1my7H+lVUfFIYoqeHrH0PnXr4zY8kCUDE1j5Uqj83d8fA+vdJiTGRo91oN
         W8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709111437; x=1709716237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4lJ1Gv+jWWK8pEcgHOwLBnJrbfniIK5oRGlITTCt+e4=;
        b=a6fa33qYjQ+f7tcvf5OVMkwzrIqvMBn3t3MYnHd7zNI7hK+cSh9Bt1wrc7znyh6ezQ
         F3uiPiGoAL8v00TmFPRo8Mz+nUmz7vZ0GQoWuvkTlNqF0gHpZPqnRRiVK5Zj1DNgS8W/
         wN21AHq1i198hlP+L2FHb7peDa7TivRLb0Uaa65Eb3dWvIN0CGaH2IS4nUYqWqRzIA5p
         gmpW9RcSqpYXzKMzqlxKTuqck6TVyDjIn1z+XzJpP5T25J2TA25du6pmY4YXmKuVAioJ
         Bcb1p7i2pgLnSx8d/kYc9GCeeLvWngywT4EhLWCEKqXTwd5kf3i66+M0C+pt7ORwOXk0
         9KTg==
X-Gm-Message-State: AOJu0Yw1/n8Zh8bhdxfs+N10iDhGQXJtK+Pp7/I2tjyyyJrgdlF6VwYn
	t+9plWm2mxmFiC2ViiUSwfsyPa00EsclJC46QbBPUBtxcVybME4ZD4xfsFLZ
X-Google-Smtp-Source: AGHT+IEBT4CcoN3JaoGy3rJSoG4RoSe87fRoAqWUNQb+fijWBiQ1Fpg9a3oNcJcocU3K6pLjrAKGKw==
X-Received: by 2002:a17:906:33cf:b0:a3d:2243:29da with SMTP id w15-20020a17090633cf00b00a3d224329damr8044699eja.36.1709111436539;
        Wed, 28 Feb 2024 01:10:36 -0800 (PST)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:6663:1f17:4c2c:ac43])
        by smtp.gmail.com with ESMTPSA id wr2-20020a170907700200b00a3e881b4b25sm1602173ejb.164.2024.02.28.01.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 01:10:35 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	John Cai <johncai86@gmail.com>,
	Linus Arver <linusa@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] revision: fix --missing=[print|allow*] for annotated tags
Date: Wed, 28 Feb 2024 10:10:11 +0100
Message-ID: <20240228091011.3652532-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.44.0.297.g8ee07f1da4
In-Reply-To: <20240214142513.4002639-1-christian.couder@gmail.com>
References: <20240214142513.4002639-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 9830926c7d (rev-list: add commit object support in `--missing`
option, 2023-10-27) we fixed the `--missing` option in `git rev-list`
so that it works with missing commits, not just blobs/trees.

Unfortunately, such a command was still failing with a "fatal: bad
object <oid>" if it was passed a missing commit, blob or tree as an
argument (before the rev walking even begins). This was fixed in a
recent commit.

That fix still doesn't work when an argument passed to the command is
an annotated tag pointing to a missing commit though. In that case
`git rev-list --missing=...` still errors out with a "fatal: bad
object <oid>" error where <oid> is the object ID of the missing
commit.

Let's fix this issue, and also, while at it, let's add tests not just
for annotated tags but also for regular tags and branches.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---

This is a follow up to cc/rev-list-allow-missing-tips which is in
'next' and scheduled to be merged to 'master'. So it depends on that
branch.

 revision.c                  |  8 +++++++-
 t/t6022-rev-list-missing.sh | 24 ++++++++++++++++++------
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/revision.c b/revision.c
index 0c7266b1eb..8f0d638af1 100644
--- a/revision.c
+++ b/revision.c
@@ -419,15 +419,21 @@ static struct commit *handle_commit(struct rev_info *revs,
 	 */
 	while (object->type == OBJ_TAG) {
 		struct tag *tag = (struct tag *) object;
+		struct object_id *oid;
 		if (revs->tag_objects && !(flags & UNINTERESTING))
 			add_pending_object(revs, object, tag->tag);
-		object = parse_object(revs->repo, get_tagged_oid(tag));
+		oid = get_tagged_oid(tag);
+		object = parse_object(revs->repo, oid);
 		if (!object) {
 			if (revs->ignore_missing_links || (flags & UNINTERESTING))
 				return NULL;
 			if (revs->exclude_promisor_objects &&
 			    is_promisor_object(&tag->tagged->oid))
 				return NULL;
+			if (revs->do_not_die_on_missing_objects && oid) {
+				oidset_insert(&revs->missing_commits, oid);
+				return NULL;
+			}
 			die("bad object %s", oid_to_hex(&tag->tagged->oid));
 		}
 		object->flags |= flags;
diff --git a/t/t6022-rev-list-missing.sh b/t/t6022-rev-list-missing.sh
index 78387eebb3..127180e1c9 100755
--- a/t/t6022-rev-list-missing.sh
+++ b/t/t6022-rev-list-missing.sh
@@ -10,7 +10,10 @@ TEST_PASSES_SANITIZE_LEAK=true
 test_expect_success 'create repository and alternate directory' '
 	test_commit 1 &&
 	test_commit 2 &&
-	test_commit 3
+	test_commit 3 &&
+	git tag -m "tag message" annot_tag HEAD~1 &&
+	git tag regul_tag HEAD~1 &&
+	git branch a_branch HEAD~1
 '
 
 # We manually corrupt the repository, which means that the commit-graph may
@@ -78,7 +81,7 @@ do
 	done
 done
 
-for missing_tip in "HEAD~1" "HEAD~1^{tree}" "HEAD:1.t"
+for missing_tip in "annot_tag" "regul_tag" "a_branch" "HEAD~1" "HEAD~1^{tree}" "HEAD:1.t"
 do
 	# We want to check that things work when both
 	#   - all the tips passed are missing (case existing_tip = ""), and
@@ -88,9 +91,6 @@ do
 		for action in "allow-any" "print"
 		do
 			test_expect_success "--missing=$action with tip '$missing_tip' missing and tip '$existing_tip'" '
-				oid="$(git rev-parse $missing_tip)" &&
-				path=".git/objects/$(test_oid_to_path $oid)" &&
-
 				# Before the object is made missing, we use rev-list to
 				# get the expected oids.
 				if test "$existing_tip" = "HEAD"
@@ -109,11 +109,23 @@ do
 					echo $(git rev-parse HEAD:2.t) >>expect.raw
 				fi &&
 
+				missing_oid="$(git rev-parse $missing_tip)" &&
+
+				if test "$missing_tip" = "annot_tag"
+				then
+					oid="$(git rev-parse $missing_tip^{commit})" &&
+					echo "$missing_oid" >>expect.raw
+				else
+					oid="$missing_oid"
+				fi &&
+
+				path=".git/objects/$(test_oid_to_path $oid)" &&
+
 				mv "$path" "$path.hidden" &&
 				test_when_finished "mv $path.hidden $path" &&
 
 				git rev-list --missing=$action --objects --no-object-names \
-				     $oid $existing_tip >actual.raw &&
+				     $missing_oid $existing_tip >actual.raw &&
 
 				# When the action is to print, we should also add the missing
 				# oid to the expect list.
-- 
2.44.0.297.g8ee07f1da4

