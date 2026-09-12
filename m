Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5342130567B
	for <git@vger.kernel.org>; Sat, 12 Sep 2026 22:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789252468; cv=none; b=bI8CZEba6Y/yahhWuf4o4cz7vmEWGj5ueUXQsOD37T50atcMp1llJyn08AwiEsdUdpUQkTa1lQioLTTjVxzTeeS9EiGr+rrqhmrDFQdp64y6cEvU1HpIYjKly5oNiSy+lXaRFxQkIhO2W+g5wC18Jwwrsom1bfP5JcOVfRwbprs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789252468; c=relaxed/simple;
	bh=C0usAEGo6TuJwYm+CLZhujGoTIQX1kJVmb08Gv8B9j4=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=HoIu5nzPjFLJTLnVEg/UP/YOMFhwxHf+qlBI3gCLmguEPd2D6zWR+8KExzHUTFzarUZj5JYTwTwVUOSne+nwf6mMcnoSIGY78oX9zq1jNxa/f5Grw0zzXHtB38rgmip9113I30UylcQNpn5ntLYJg1c7JEd7SLmw702dT5AkVOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JytaPH9C; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JytaPH9C"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb766bfd8so12437121cf.3
        for <git@vger.kernel.org>; Sat, 12 Sep 2026 15:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789252466; x=1789857266; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zducX81VGmMOc0hQAW3NBB4l7qTPFkUWIVsZNdtynfA=;
        b=JytaPH9CfZZX4FY2QZsJRqEx0tY3pz2/3WNt6VW2dBrSs2d3cHAcggglZyU0BnQN3/
         aC7zasEQ8CwSQWwy+kMSj0QlOmwFeXjfC17l/yoVaZY7N1k5g9cK0SiQCBOoPDomiIgw
         9LPhc/hrcuv3+Tx4Xx2TViiFksbYIVZa8ht/vv22xnWK9kQWxx907ZAFB36Mriu5lxMX
         sSF5tVP9RmcSBQ+FHTiLx+KYI93EcP1nK6ez/xMTs/vmXoF09KxJY7iKV/3FbUyz7C3X
         4Z9cPumlxIsCANTCmCMyYgtK67Kmz/tFXk7Feh+DLyN71r65rOt2+aWnBLcFKqB7rA99
         pwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789252466; x=1789857266;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zducX81VGmMOc0hQAW3NBB4l7qTPFkUWIVsZNdtynfA=;
        b=TKxIdhFDeC1jTgkYvmI217xEONMfCxLVclHEGpG3iwVsvnZ/Efg3BjFjR4lCyDP5GP
         JmW/L8I3wy9fId8y0ewfWn9fWSBJKI01Y0bNWZu5bxkTcamFopuvk+DWh7Nex5VH89Ja
         wU74eIsrvkeTaw/xZURAKKPRy5JPFlfLcoMmFsOOhoq8fw8DD7UjAtRTPqTf8SN1bxp6
         LfDMYnFffJ6XfqxV3SelkJbpwzuuwLtlz9lRrsIvSeYTr9skYAVyMOepJLQP64+xHjmg
         76rlvzdATKlNh7qcoaxawZJ0bRBJFT3C2jQmq8phaKcgAWMsYH9JY0GpkovAAVWx8L2D
         YK4g==
X-Gm-Message-State: AFuF++k80isjW/P4MYayc8cQluzqtEjCMQv9wtzWTM9hByc2HmZosmPC
	1pMrB9KYBCAfoGxb9C/ul2Nu9o8TD3XsxxTpIdw+yFi+XJXKWmFGLpPIGVcYrA==
X-Gm-Gg: AYBFou20k0iKZQWAN0e0jAoWA3ZdNPTispUSN/hp7SLZpTvQmnMI5mWkfEE0UF9Wy/f
	bfZmWnkhGAIVU6eChiwA93kMoNnCD+HrGtZX0sB1TRVpB2bPG5tDBzyNdl/mpgNRl1j0yKQBi/a
	LCiz8TUnI+mxaFModDyhlbc3SejcdIRDSwy/Njteye52/q3c2v2zHjjMnBiEaPd0FMHw83LzOMJ
	madv0gJR0cmCuzDusYut1bMomwlOPr05yMggkPggN7bDbZvYA12CAWGOCSaqBXbI8P4wAOdmjGd
	+qzuaFzx5/WcYBsb/gSTG26f2QfGFORxhUJwoZ1U6rQzuhHpddGPwbWLfxnY5uWuJYprtObs+SA
	sx3UY3rPPA3uQ6vdN+YJOsBBEGo3/kM6RhaH4kw8blyzayWCUbgFYyWDNy6pMSuLoEdYXejlwyu
	epVKzw4eizE6RtNi7YR58ds/itINYzjfKQxpJcCRSKTVciKfBAoGEkr9fTQKMKMP4++XaaC+2ro
	vk=
X-Received: by 2002:a05:622a:4d92:b0:530:ea12:caad with SMTP id d75a77b69052e-530ea12d0bfmr65528241cf.50.1789252461445;
        Sat, 12 Sep 2026 15:34:21 -0700 (PDT)
Received: from [127.0.0.1] ([20.102.95.147])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f45cd5dsm55071716d6.14.2026.09.12.15.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 15:34:20 -0700 (PDT)
Message-Id: <pull.2223.git.1789252459520.gitgitgadget@gmail.com>
From: "Jiri Kuncar via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 12 Sep 2026 22:34:19 +0000
Subject: [PATCH] pull: avoid crash of invalid merge head
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
Cc: Jiri Kuncar <jiri@kuncar.dev>,
    Jiri Kuncar <jiri.kuncar@gmail.com>

From: Jiri Kuncar <jiri.kuncar@gmail.com>

Adds NULL guards for lookup_commit_reference() to avoid segfaults.

Those invalid references are possibly caused by parallel fetches or
gc racing on the same repository.

This effectively treats failed lookup as "not up to date" so caller
falls to a normal merge, which reports the broken object instead of
crashing.

Signed-off-by: Jiri Kuncar <jiri.kuncar@gmail.com>
---
    pull: avoid crash of invalid merge head

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2223%2Fjirikuncar%2Fjk%2Fpull-null-merge-head-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2223/jirikuncar/jk/pull-null-merge-head-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2223

 builtin/pull.c  | 10 +++++++++-
 t/t5520-pull.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index db3ee0aab3..80e79daeb9 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -800,8 +800,12 @@ static int get_can_ff(struct object_id *orig_head,
 
 	orig_merge_head = &merge_heads->oid[0];
 	head = lookup_commit_reference(the_repository, orig_head);
-	commit_list_insert(head, &list);
+	if (!head)
+		return 0;
 	merge_head = lookup_commit_reference(the_repository, orig_merge_head);
+	if (!merge_head)
+		return 0;
+	commit_list_insert(head, &list);
 	ret = repo_is_descendant_of(the_repository, merge_head, list);
 	commit_list_free(list);
 	if (ret < 0)
@@ -820,12 +824,16 @@ static int already_up_to_date(struct object_id *orig_head,
 	struct commit *ours;
 
 	ours = lookup_commit_reference(the_repository, orig_head);
+	if (!ours)
+		return 0;
 	for (size_t i = 0; i < merge_heads->nr; i++) {
 		struct commit_list *list = NULL;
 		struct commit *theirs;
 		int ok;
 
 		theirs = lookup_commit_reference(the_repository, &merge_heads->oid[i]);
+		if (!theirs)
+			return 0;
 		commit_list_insert(theirs, &list);
 		ok = repo_is_descendant_of(the_repository, ours, list);
 		commit_list_free(list);
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 27f38ab3c8..7a3eadddd3 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -888,4 +888,30 @@ test_expect_success 'git pull --rebase against local branch' '
 	test_cmp expect file2
 '
 
+test_expect_success 'pull does not crash when a merge head does not resolve' '
+	test_when_finished "rm -rf up dn" &&
+	git init up &&
+	(
+		cd up &&
+		test_commit base &&
+		git switch -c sideA &&
+		test_commit a &&
+		git switch -c sideB base &&
+		test_commit b
+	) &&
+	git clone up dn &&
+	(
+		cd dn &&
+		git -c fetch.unpackLimit=1000 fetch origin \
+			"+refs/heads/*:refs/remotes/origin/*" &&
+		git commit-graph write --reachable &&
+		oid=$(git rev-parse refs/remotes/origin/sideA) &&
+		obj=.git/objects/$(test_oid_to_path "$oid") &&
+		test -f "$obj" &&
+		chmod u+w "$obj" &&
+		>"$obj" &&
+		test_must_fail git pull --no-rebase origin sideA sideB
+	)
+'
+
 test_done

base-commit: fa7f9290efe2bd22dd736689597b474b93798e11
-- 
gitgitgadget
