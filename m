Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D92823AC
	for <git@vger.kernel.org>; Fri, 19 Jul 2024 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721381689; cv=none; b=J6kqIO264zh7WdC7vdiDPEeOOUy+7zZFkYYe1O1LTniTMmCsR3RtpFgbxP0tyAhK1KaRZGL+HCPV8O6F5cazo2ZtARfCLyVHKQdKasASmDYF6im9QE4mLMcrkk+iHKKxtEt5W5rWbZsRPNLAwZpnwFP6OQeFyCrsU/vb2PSn/Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721381689; c=relaxed/simple;
	bh=TjSN7yTcwVnhg/UltJvfFsZtAVP6pazxVdH2J0Z3Ewc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qfkRkPkBBDbe1RVJRR2Hq858a7+LQO0F5KKK/i2TpD/Og2lpGfkTjL6imYKKcE9UZlgMLUXBBuccCV0KzN+pej2GiMHEn/tYymF+aUFNxrMqabLZfwX+Gbpok61HeuI5Cit0R0T5dOLCtAkaatmwTUlSbdCs6ePuxEWyfR+Mxz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FYiiUNOb; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FYiiUNOb"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5b9794dad09so845763eaf.3
        for <git@vger.kernel.org>; Fri, 19 Jul 2024 02:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721381685; x=1721986485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5WW247HvliBN1OPdIEqEvhUQIe570PBOqHpe+L/N9Y=;
        b=FYiiUNObnlO0WviCg8Jzp6FtQi+UhAYHqdx1up6QGPmIQG+xG8epMrl5ZusCp4Xz+S
         Fr62z0UslzofjiD0Qbw6atwNboNE70SlLvno4hgUmTDcfMGv0xZA1ESADj0JNVAtN3LF
         RK6NnWEMBm8jHgINAfs4syEQnoCLc0NIedd1Y7jX64uxaXyYE/l8dkVtDJoqBlB7zuF9
         kcA5MCbVUouw/QfHKrRBG2EzTRuc7qw5tQf1VovoAW5kf3oi39R8FVsHsriRgWej64Yj
         7Pf/zxC52J552xg7JdFJjRPz9JlVBbZHbnr3fIinIRnjAmbiqKUSO/t8cs5qeB6f9SAx
         4ymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721381685; x=1721986485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5WW247HvliBN1OPdIEqEvhUQIe570PBOqHpe+L/N9Y=;
        b=W2V/PtCjBnYGMDmbXu+QtLuQNeIHYPS0WWy1ieyNH0Hu2PtLnahLPh2hOPLMGdOl3f
         V2hTKWSntRoBhoxZjKfwOwVpXE1k7APnJRgj9m/3mIEZTUCt3sdro6ovubcjn5g9yUeL
         YRWrEL1l8pC+9sN9LwwGiVWa3ZNLP7PTNPQxJeGa+sXZwMuczNhJ9R37l9zIXv+sILeq
         FxoI9gUagbUpYi6s2bA9kno7t8wFI3ciHmIoLpvuwE/GDCDguk22j3jDnAlbSH7RKIJU
         cNUI2SHft3FjsnZ4SRmJtaVVC5yBUJnmiCCuLsXBFY9g96LoMIZB7GQo5KhVW4JI/4Gu
         klFg==
X-Gm-Message-State: AOJu0YwXtwPQFzRECyqojXjPlG6aQk2vqFvismzdL8LTEFFsr8n9aAvY
	dp0wNRjFh5oa157EBeES8HizKbDywdLBuDYVw6wAmydLa3vtCLcOqViauw+4yRciNoRjV2y2Wgv
	E
X-Google-Smtp-Source: AGHT+IEyzJ63E1vCsMoOGRZcObVhkkPHhXYV+6IiKltqi9fDtShSKshQisBUh+JPGFy+ySrabsWe5w==
X-Received: by 2002:a05:6870:30a:b0:25e:281e:190f with SMTP id 586e51a60fabf-260ee83a452mr4512393fac.23.1721381685526;
        Fri, 19 Jul 2024 02:34:45 -0700 (PDT)
Received: from localhost.localdomain ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70cff552816sm831558b3a.139.2024.07.19.02.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 02:34:45 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: Han Young <hanyang.tony@bytedance.com>,
	C O Xing Xin <xingxin.xx@bytedance.com>
Subject: [PATCH 1/1] revision: don't set parents as uninteresting if exclude promisor objects
Date: Fri, 19 Jul 2024 17:34:35 +0800
Message-ID: <20240719093435.69238-2-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240719093435.69238-1-hanyang.tony@bytedance.com>
References: <20240719093435.69238-1-hanyang.tony@bytedance.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In revision.c, `process_parents()` recursively marks commit parents 
as UNINTERESTING if the commit itself is UNINTERESTING.
`--exclude-promisor-objects` is implemented as 
"iterate all objects in promisor packfiles, mark them as UNINTERESTING".
So when we find a commit object in a promisor packfile, we also set its ancestors 
as UNINTERESTING, whether the ancestor is a promisor object or not.
This causes normal objects to be falsely marked as promisor objects 
and removed by `git repack`.

Stop setting the parents of uninteresting commits' to UNINTERESTING 
when we exclude promisor objects, and add a test to prevent regression.

Note that this change would cause rev-list to report incorrect results if 
`--exclude-promisor-objects` is used with other revision walk filters. But 
`--exclude-promisor-objects` is for internal use only, so we don't have to worry
about users using other filters with `--exclude-promisor-objects`.

Signed-off-by: Han Young <hanyang.tony@bytedance.com>
Helped-by: C O Xing Xin <xingxin.xx@bytedance.com>
---
 revision.c               |  2 +-
 t/t0410-partial-clone.sh | 22 +++++++++++++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index 1c0192f522..eacb0c909d 100644
--- a/revision.c
+++ b/revision.c
@@ -1164,7 +1164,7 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
 	 * wasn't uninteresting), in which case we need
 	 * to mark its parents recursively too..
 	 */
-	if (commit->object.flags & UNINTERESTING) {
+	if (!revs->exclude_promisor_objects && commit->object.flags & UNINTERESTING) {
 		while (parent) {
 			struct commit *p = parent->item;
 			parent = parent->next;
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 2c30c86e7b..4ee3437685 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -22,6 +22,17 @@ pack_as_from_promisor () {
 	echo $HASH
 }
 
+pack_commit() {
+	HASH=$(echo $1 | git -C repo pack-objects .git/objects/pack/pack --missing=allow-any) &&
+	delete_object repo $1 &&
+	echo $HASH
+}
+
+pack_commit_as_promisor() {
+	HASH=$(pack_commit $1) &&
+	>repo/.git/objects/pack/pack-$HASH.promisor
+}
+
 promise_and_delete () {
 	HASH=$(git -C repo rev-parse "$1") &&
 	git -C repo tag -a -m message my_annotated_tag "$HASH" &&
@@ -369,7 +380,16 @@ test_expect_success 'missing tree objects with --missing=allow-promisor and --ex
 	git -C repo rev-list --exclude-promisor-objects --objects HEAD >objs 2>rev_list_err &&
 	test_must_be_empty rev_list_err &&
 	# 3 commits, no blobs or trees
-	test_line_count = 3 objs
+	test_line_count = 3 objs &&
+
+	# Pack all three commits into individual packs, and mark the last commit pack as promisor
+	pack_commit_as_promisor $(git -C repo rev-parse baz) &&
+	pack_commit $(git -C repo rev-parse bar) &&
+	pack_commit $(git -C repo rev-parse foo) &&
+	git -C repo rev-list --exclude-promisor-objects --objects HEAD >objs 2>rev_list_err &&
+	test_must_be_empty rev_list_err &&
+	# commits foo and bar should remain
+	test_line_count = 2 objs
 '
 
 test_expect_success 'missing non-root tree object and rev-list' '
-- 
2.46.0.rc0.107.gae139121ac.dirty

