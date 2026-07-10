Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298A93FC5AB
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 11:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783683615; cv=none; b=TY4hiSFJCzBbS1LsXYlBe8hHIfZmP+02uNl/hQb0Q6AUeH19W9YQgB3ZQQZUqdUzaAhIgf0J/naJQuoHYi1e0ZB0LQDVIo+fLgl9i1lVqaA/1zkxdZuTns4MG+Q3PMHwBchs5ro+TFFeiJvP8ExdxSefPivwLG7pvo587ztoq5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783683615; c=relaxed/simple;
	bh=NvBcLKW46sQygfbHhF9hpGOhLzRmY9qglO2y5pOJldk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qaQWxio8Pa/sxQU6IwPlQ7AR/LuqjRy9UMpIZUwzKt+5dw0wvCyRF0B6PooYfh6zNCU7IH5+gK8U4HtJlYbKRrdJm1C+TTCNXDqxLIxWywKtY57vp0a1vJ5+5NsZmPbbXCKlvj9TyqSPSQBWwh3+TrLv+XFGkviur3vTWaHxuW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHvaeONt; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHvaeONt"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84861fc51f5so648395b3a.1
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 04:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783683591; x=1784288391; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Cq1HYGt0bUp1CHNLgn4gXZ+fGOCRjN7usVWEibfwjNc=;
        b=FHvaeONtOUzo9ewjxawU5yacn4lsNeGSyxwKrhHUkchqgaJBrjZOhu7jMuZ9AP7Yzc
         Rm7j5qcr3r77V55T4XIj4gicTxfMesXNlOZSP25yd9D2JqNzl0ucwIIWO4g8dRvIU314
         gzmcV5gReT84QxV1wRN2Fg5gY6wgeiKkxxm8jAmE60AV/U2DH+lg6VNjZdZp3I98hLqk
         o9+TQ999ESm4LqxsxNZxoH4V5Jo8m0swVK117dkV9ARdQe8d3FDW1MWHlbWuOEUpirue
         xyNb4WKnrNcSAu7SRgOesdqqdKAlKawKZFTKz0jKBHf/zNd1Fa2sNf0s/vCnsvohedQZ
         MpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783683591; x=1784288391;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cq1HYGt0bUp1CHNLgn4gXZ+fGOCRjN7usVWEibfwjNc=;
        b=BUbiuqzH91TUNrBi4GrEopTspzHs8o24wAtgIMGhh9ICUnP61aJgZ3CsNIJQ/Gwn96
         fVtZCyhJtnwXCpaMFDkFSl2Jmqf98qKKELVn6OMiMuZRh1Fk+j20pcTRT2AdmDOFoiqZ
         NEbNpFSOIhdU4wNTs/PAsJh38zVQdXJs2p3PNV4viZN9l9rIy0bzXnoVkQZJwWRw34GX
         avckWyl7UlEFOwM1BDNMT9BLaP4Zx8j0Oj8FCmFVMdi3n+P0kSsu+iN5baxH4jhA/6Sf
         RsUg1IgEZfMDVnDGL0xaJ85XEnl0zeR4aOh5jhuoIpO4zcRmKPqqLnwiuWIUVo5PMXdJ
         2HVg==
X-Gm-Message-State: AOJu0YzTy/BmcBb1eC9fNp5dzhXOHtK2L2RmVA3qd+K+00Y0huL6ZsqM
	zEMxfbt6nnxpWlCKkh0Rbq4kGrPQQgYpRN6f4TSCOqlDg9gOMo04DOXvXx9xJw1e
X-Gm-Gg: AfdE7cl6p/IFRMLb50aCKhsKJt7gg+sLrXAlmL+wblbXmUVMUYac+uKskWhAwdaileZ
	mv1QkTrzvldFZ1nl7yLuvps18wZMxCnbQp7N+8BDlrmf3aR2TJ59ZrBpnV8USHqWGUJ5Tj3xuqX
	s6r5eaQWsxG/4lXpvoUC/97dWnaGEySlHVxcPJJcRe15Jxve2CR8M84wInIvg5Yhc/sAjHK6BuV
	8zeMjrcnb15p+qzzqTWeNKJUqGC98rvWvL4Lxp0CuplBohVTJ14ZH+JSWTIzryk9SVhUO05UsSJ
	ygRor0RkEGDpkWOwUhy7Agd0SA3XuXz4iAJn7o+DCe9o5hLulJYvRNHV+yTwA3fz/S4gfKSek/c
	KwRyQ4ZLtaDaNQzqsVhC2wRjPZCxhXctdU6t8HCZuaiicN9bRsOIjWX4EKc9qoQFA3LIBHaS/Y0
	6ZSQOv2bAwRaDEsgD3
X-Received: by 2002:a05:6a00:23c9:b0:847:8449:2bb6 with SMTP id d2e1a72fcca58-84842ebbe41mr11122194b3a.4.1783683590681;
        Fri, 10 Jul 2026 04:39:50 -0700 (PDT)
Received: from [127.0.0.1] ([172.185.47.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b6057dsm10300815b3a.7.2026.07.10.04.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 04:39:49 -0700 (PDT)
Message-Id: <8216769be9eec7489f1039e0211f3e6d3388247b.1783683577.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2174.v2.git.1783683577.gitgitgadget@gmail.com>
References: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
	<pull.2174.v2.git.1783683577.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Jul 2026 11:39:31 +0000
Subject: [PATCH v2 07/12] replay: die when --onto does not peel to a commit
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `peel_committish()` function calls `repo_peel_to_type()` to convert
the given object to a commit, but does not check the return value. When
the object exists but cannot be peeled to a commit (e.g., a tree or blob
OID is passed as --onto), the return value is NULL. Add an explicit NULL
check and die with a descriptive message in that case.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 replay.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/replay.c b/replay.c
index da531d5bc6..b38cd5efe4 100644
--- a/replay.c
+++ b/replay.c
@@ -36,12 +36,16 @@ static struct commit *peel_committish(struct repository *repo,
 {
 	struct object *obj;
 	struct object_id oid;
+	struct commit *commit;
 
 	if (repo_get_oid(repo, name, &oid))
 		die(_("'%s' is not a valid commit-ish for %s"), name, mode);
 	obj = parse_object_or_die(repo, &oid, name);
-	return (struct commit *)repo_peel_to_type(repo, name, 0, obj,
-						  OBJ_COMMIT);
+	commit = (struct commit *)repo_peel_to_type(repo, name, 0, obj,
+						    OBJ_COMMIT);
+	if (!commit)
+		die(_("'%s' does not point to a commit for %s"), name, mode);
+	return commit;
 }
 
 static char *get_author(const char *message)
-- 
gitgitgadget

