Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC86614F7A
	for <git@vger.kernel.org>; Sat, 20 Jul 2024 05:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721453338; cv=none; b=tHedvTmpAVrXBB0+dVouAHj0yWUiIU4d2fsFdfICUm9RUp/69nUmuPDX72KRd0df2FlsG16AM82bkuiraJhqVa8xLybtGuMsEbdlb34H8OYqooXoHjxGQdkRhy6P4aYpL72sQmKTDBOs86gdaOs0e+/5mVWdV2iUl07VLH+4jh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721453338; c=relaxed/simple;
	bh=TjSN7yTcwVnhg/UltJvfFsZtAVP6pazxVdH2J0Z3Ewc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FxrbbUkGoieVY5BCg7+3Ci/e0Vfj2L/W3Id/IvxrwkNbr+yMkE/genb7T91UbJhhmX6a5TEN9bwX4vFwbeVKlln0kF1s9JYOSfax3dLwbhFOWwgIxCL/x6PGnw2C/GslXjDxcHuyRjQDYFK6qhwxdRnvk6FGUwdT1Sa7GvQtHDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UCdeBrgf; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UCdeBrgf"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d96365dc34so1498154b6e.2
        for <git@vger.kernel.org>; Fri, 19 Jul 2024 22:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721453335; x=1722058135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5WW247HvliBN1OPdIEqEvhUQIe570PBOqHpe+L/N9Y=;
        b=UCdeBrgfWE7gO5XKhh27tf/jCeaxTsGo4iU3VsO4TOlRgrHpnv7W789YY3S/E2xgw+
         ndFi6Roh2WJgCM+r/lE186bfLOeRepDzrbMZ/Yzgn1iiggLFxyzvKlW5EKtSRpxIirum
         Ohhw1TlmpyCgjSafRnI22SSBxwK2tR2BFmXpm4uCwSLrKHKCfGidtQdf7nMRf8wiGRrz
         cpwcGeKJzpxtY7vEwCDEvjh+YbeNE5j7CHYgt/IE+nMxTqRtVTgz/42QcTlC2pV6RJsD
         lpToUXCgspmn0t/+032PZx3X0BwuffvRQPwYn6sUKKEtCeXjkvF/K91ZixIlW4vKdKku
         py6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721453335; x=1722058135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5WW247HvliBN1OPdIEqEvhUQIe570PBOqHpe+L/N9Y=;
        b=qgNsaqCwtz9V7R1jUh/kf1GYTdqjTOSg2k1wwZOYKZNTW4yRzJ+Wqbut7YnoueG5gk
         03BVWNr0E6PoDRYDVuorzNqHU0sqIrGhy7l5HfaIFnRLUAm6pSGwM8OkuuH2RFdWuYdx
         LZAQrDJlCiw53x1vhMtMc3zR51KeKbuuEv5zON2rF3Rf5xCGaVHhCl1O+d80C2YS7Ca8
         YCtOGSFgCbGvDihZ5WRUyuXB5sLj+MeXIlyrCXgYi6r+lV8DZktNPfpmPQbflQEmOwRi
         VIyZJ5b0Op3qDv1bGMVXBlVX8RbFjaVT09vl+PaC1sXeL0K0RcjuoMWZiaHMM7GOxjKL
         dYSQ==
X-Gm-Message-State: AOJu0YzKLq/BUN1Sagr26J7I8R8HTg0KUyOVchcBc5mcQvxUqXdIDzju
	/wGYyT5i52CVTaeJFCwvt6zr2sECX7IeJoM9hcA73/NSdbn+YM4NYMtcMx7aOmt1RgyXvpQaRZA
	u
X-Google-Smtp-Source: AGHT+IFMSlbTxMCZA1AhSh0jQfBYSUOQ2YQV3SDpfnoTsHFLjb5GZxvmSr+ysiYEt0Sm99dVDnDGNA==
X-Received: by 2002:a05:6870:b91:b0:260:ffaf:811b with SMTP id 586e51a60fabf-2638dfafe3fmr537149fac.11.1721453335206;
        Fri, 19 Jul 2024 22:28:55 -0700 (PDT)
Received: from localhost.localdomain ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70cff491088sm2013070b3a.41.2024.07.19.22.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 22:28:54 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: Han Young <hanyang.tony@bytedance.com>,
	C O Xing Xin <xingxin.xx@bytedance.com>
Subject: [PATCH 1/1] revision: don't set parents as uninteresting if exclude promisor objects
Date: Sat, 20 Jul 2024 13:28:45 +0800
Message-ID: <20240720052845.89111-2-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240720052845.89111-1-hanyang.tony@bytedance.com>
References: <20240719093435.69238-1-hanyang.tony@bytedance.com>
 <20240720052845.89111-1-hanyang.tony@bytedance.com>
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

