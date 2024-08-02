Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16371BF31C
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 07:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722583924; cv=none; b=L5ny3q4S4xDOL+hyzQ5Qz0kZbZRoC3ZaQOSABK3DDmW5Qs7ZmmLE1V3HuM2vy7MtLLznB9QdSbdk682C99MEIoYVsezj5OwK2KZpOAx048EdLEeV6d/HcmSvWFY1N8NEE6EiKwuc6zMqa91cWz3HeUhipPhc1u/3qwWTfmTkYy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722583924; c=relaxed/simple;
	bh=TjSN7yTcwVnhg/UltJvfFsZtAVP6pazxVdH2J0Z3Ewc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NhRslZKZOebMEI2hxbtt+DCkF7ImfjR2Re8ynNCtAOwE+i+cqeNItQbnlAAeHwnt/XDsfzQNNvTgWYdasloURB6P8lHDC7fOCFoiROgQI7PD/C/2L9RLolhUpY0dGBsCtEGnBqDXD+5uokD6Gejj0PIURE56l+WJTAXEsToLz3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TVKQMpwN; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TVKQMpwN"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7b0c9bbddb4so3221234a12.3
        for <git@vger.kernel.org>; Fri, 02 Aug 2024 00:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722583922; x=1723188722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5WW247HvliBN1OPdIEqEvhUQIe570PBOqHpe+L/N9Y=;
        b=TVKQMpwNc4oS+qGKtJcVHzS13LrKNf23YZ+oI6INetE28EGQJRoUuMseA//XAew8Mo
         CrQqpqFjGM3wP2Ja2v24u6cltQURGq4ikNKw2TA6uAkzvTAgC13nKUoMJPREtX8bvvB+
         k454nRA8aqM7eOgCrXRcWk5yjSqaV1RQqp01U10PQG/IgS0MN31eOlxwVQQRfSmhsJSv
         TIprjxz+ZFPJVHsWKL9iPzj8wq64G86lVOQ/a/TaLNiFCmq8AwB6+e+E9qXOdlrvKGJm
         GV50R/y2ASj5nECW6k8TH1QgRCC2PfLpDldB4o2xcoObDxh63iJKiBjEj5zd39duyMdS
         nyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722583922; x=1723188722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5WW247HvliBN1OPdIEqEvhUQIe570PBOqHpe+L/N9Y=;
        b=OiUHujRA58YnFXeBf7z43y/bEtrIV5+mN0W0mgeqiBsivk8fqncd2xEzho9f42JrHS
         ziwrrFssx9FPD8pKuTd5q4dRNCgJbpLx2We7EvZsIlJwZrsafwmddMWD+omU6Fy46pn8
         4bY/Gu0uIY73UrIQEGVW7ynhMn5u11NZMnd+rn8DH6qcgihOshWlauz6YlIX9DniQ0Ni
         4gRnj18eY2eEBX2y9px/980AxJc82Gl/hIqCyA5KICPtuU3PKMAi/USG0YuvDuW6gKKO
         NgFwVzoaZvDY0YC9gua5WfyOx4Sf9XHybQEB8wirs/B0ZuBWnBMtAnWcsi3QjZaHA9DL
         CaKA==
X-Gm-Message-State: AOJu0YzbDeFDHPEGvUyo7nQRXmnGzuRZjmpaQIKi9+d8DDwBBOIs3wwy
	I89WgwJdb5kWbsFdv9/QBDNCp54TCYe1AxaecI52VoWz+mb/fuLOUV7tVXWTXNYJ4rItgmrCN/O
	u
X-Google-Smtp-Source: AGHT+IHn6/qE64jId9AqKf4LcK66+00U0hTOSudIel7S8lcJ14gN+sUVCKWUh6BmtYekv8J/i+h2bA==
X-Received: by 2002:a05:6a21:3392:b0:1c0:e629:3926 with SMTP id adf61e73a8af0-1c6995805e4mr3738448637.16.1722583921340;
        Fri, 02 Aug 2024 00:32:01 -0700 (PDT)
Received: from localhost.localdomain ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec01cbesm887410b3a.12.2024.08.02.00.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 00:32:00 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: Han Young <hanyang.tony@bytedance.com>,
	C O Xing Xin <xingxin.xx@bytedance.com>
Subject: [PATCH 1/1] revision: don't set parents as uninteresting if exclude promisor objects
Date: Fri,  2 Aug 2024 15:31:43 +0800
Message-ID: <20240802073143.56731-2-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802073143.56731-1-hanyang.tony@bytedance.com>
References: <20240802073143.56731-1-hanyang.tony@bytedance.com>
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

