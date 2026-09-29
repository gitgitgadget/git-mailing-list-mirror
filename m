Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020604BF930
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 09:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790675815; cv=none; b=UVYVNddZNlEz4FZ7Vt8yvV67HZLhvI3nWcxMkF4i+ckSieOXOkeBVyAnrK5oXqpzrr22Sz3JLTo3afsZkzKHVPWvnzGmeChyS6P+WYHmTgf0qnP/GkCBWqjzZkq7lQ4DdC0fUN7571lM+3corxEW/es+rLmiF/XL8OB/sxlp8RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790675815; c=relaxed/simple;
	bh=KyuSAzGz/D1rib68IgnvZZ1Aiug50qnjf+d+f5oQcvM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VV4AJ26qVxRTMcvwo6QQBd4zvmPVwa/Y+B9DDp1U7PgEsW8qf2ay6oKW0eW4Uhn0dbSgXX/LbbXIahERcppwTm+HMgffcKXIGW1qkeKE0OZzrPyZOXTYIG1XS8vYBhIm3eyJvt7LAZ4xCewIgkuMSELL3XG5a9kFleL5GwsGBLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EKgkE9q9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vh1dpalw; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EKgkE9q9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vh1dpalw"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 16DFC7A00BE;
	Tue, 29 Sep 2026 05:56:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 29 Sep 2026 05:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790675812;
	 x=1790762212; bh=ZEdL0K80mf/sjfS3PCa9flvVXM8cMmaomTNPv2HUxgQ=; b=
	EKgkE9q9lBk4S1G6dT3Fi0j4N0z/wQs3sw0CYIh24/EGWbSh5LBP6bjZUogmiJyL
	ayUhzSownjO/6MXjYIMachtreWWnNpp/Vt7kj2SNUteZvceHF/ra+pTHUS4Lbgi+
	6YP81ZMs2xne8Avh35vOVtaTqg/xMBphgnbcWPzbF2+0YJOyGDdw8IyBXbiY/n8g
	ldiCu2IL3RSEem7NVX8cbZ+BpfmSbmF17rLRezzLyk/+3Ktz8roDTFimMi89U82q
	Lph7u2l8VslzoKXMogsSuyymCkAbRf9TN7sfdyR65GDuhSo8SUlQJpqkQ3IOfYeN
	b44/Acf2caNzD3FHzbSi7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790675812; x=
	1790762212; bh=ZEdL0K80mf/sjfS3PCa9flvVXM8cMmaomTNPv2HUxgQ=; b=V
	h1dpalwTPZyxyOD9W8nyg6ISLM5Dtt/HXayE1xCyAHZnYqEy5wpbGaQWGA3p9lvH
	7Wky8xgAPtVGvBvfe63XY8obrAHaMph3anaQSgO5+E0vaK1dkiNlg3VbStBkcXgq
	0vAk/X6PU78B9Pod4ZsIan9n5g8bHy+iB6EpQwCo8xVGkILFlXK/EjIHgJoe16ri
	suSQoGxhGqdQR0lymtzFyT0GOH3KFymjLk7TdxDfJLb8VShAV+Rs3U+ZB5Myu84K
	dYGsl5/VVF0Utkz3fmuleJGYJY8e6OykXYL4GurRAJgwgc+RpCW3lGUzohNhFgeG
	yRDDRRz3tb0hnIyLqZnxg==
X-ME-Sender: <xms:ZIu7ajAqFxQlW12gkfVosqPV2Fj39ChpW5ExINjTGh0qOsMc_ltYjQ>
    <xme:ZIu7ahSazsrJFQWY5n6X08mmH-5sB4qj3IAFr0rS81WbxVnnewgHL_6tQV1-XmeJG
    1IsTm6pFBxHEm-83RWJnLYcymNgTd8MQPUTXhJTMWrv_EIU_iXkFsM>
X-ME-Received: <xmr:ZIu7ahoON8VcaPYUGOqyS8vs9ojemv8bcmmtqTA1wN5k7xL6kaA3uA>
X-ME-Proxy-Cause: dmFkZTG4aXpc9ptqwgmTCsTGv15JPi0zeDt1tTY13FmcpwnyHX/7kc2+aJBj63Z2ynY+7s
    /jX2iThIYSsBoq/qlkfchCu+2R6lu8vi3fvFNzHAPABvPuRk3IaYF+dOckvbV/tX/Z5TQt
    8nfPZr5xGh3IvYFX8rzQYWNlrlAHm+h7oc43T3SIKL4ndLBFoFxt7Lpn6oR8AlJqwTCkUH
    0Yx0ut+/awF1nP8Dkf0ooDARYWrI8/JRIufKAoIAT+A2yQWeq3THC1EFu3HUl+BeV1kNi9
    YiYFbu/fDlUB0Mc49PCkjpvCDlmx15uLyeVDT7o0GaBNwOiE5VzTDJ+obtzSI9tfQUC6DM
    B4IGLzRnMXTnwVY/jcNyzJKC1IdQtRHL66PfaMpZdtG/yZTRDMiFh83+ycrFeoB5oX15j3
    7wU4yu2/6b2OOSMqhsqhU4jeJgorUU1RRDm9k2GYCy8YblBxP9iGm4fJ0ozUHPiAfH2e8f
    wwb3UR5o4flBglMHe0PgOKRUCvIGtMalYoUF0MGB9Lo9YGvmJSur3hlB8z5F1kLr6VVjEK
    NWEcGb/2EhdLzVCYOSerW+EOmSErDT7qu70XquoE2ZKhOxQFTzfGwRloCworlkwlisdhh0
    IBOM+NG5ye9sbHwWznCfURLxYiG5+LKz/WFfVR0iSrXfDqojokQD8iMA8aTA
X-ME-Proxy: <xmx:ZIu7ajzepQVeKnPdkH7gMuI0bGy9bEJ20y2sWH-VgGJvOeh4cJFYrQ>
    <xmx:ZIu7amKRbMKDAr2Qum5Wa5QTzE3Yg0xF82dUv3T2HbK1yOxjln2g0g>
    <xmx:ZIu7alKzXrjCwYQRvbbb3hA0T1ffnCizt0s_aF-pp-UvFHZmilGgsw>
    <xmx:ZIu7arsT8G4Az8sOWVHcQwGTPYg4tWrgOGZhgihWduOf_eNtJAz3jg>
    <xmx:ZIu7al0uil2RKI4XYxxvbe7Hp4kVr_WIK230zvBXn4Wx26ZMDCrP7DiA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 05:56:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8113d687 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 29 Sep 2026 09:56:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 29 Sep 2026 11:56:30 +0200
Subject: [PATCH 2/3] t/helper: fix segfault in "dump-reftable -t"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-pks-reftables-fix-timezone-format-v1-2-3df105a95ed1@pks.im>
References: <20260929-pks-reftables-fix-timezone-format-v1-0-3df105a95ed1@pks.im>
In-Reply-To: <20260929-pks-reftables-fix-timezone-format-v1-0-3df105a95ed1@pks.im>
To: git@vger.kernel.org
Cc: Josh McKinney <git-bugs@lists.joshka.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

The `test-tool dump-reftable` command can be used to dump the on-disk
contents of reftables. The "-t" subcommand specifically can be used to
dump a single table from disk.

When trying to use this subcommand though one will quickly realize that
it is broken, as it always segfaults. The root cause of this segfault is
that we try to detect the hash algorithm via the merged table's hash ID.
But that hash ID is not the same as Git's understanding of a hash ID,
and consequently we fail to look up the correct algorithm. This will
then lead to a segfault later on when we try to dereference a NULL
pointer.

This breakage went undetected until now because this particular
subcommand is not used anywhere in our test suite. So the obvious way to
fix the bug is by just removing the code outright. But in the next
commit we're about to add a user.

Fix the issue by properly converting between the two hash IDs.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-reftable.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index fc49fafc34..57758936b0 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -103,7 +103,16 @@ static int dump_table(struct reftable_merged_table *mt)
 	if (err < 0)
 		return err;
 
-	algop = &hash_algos[hash_algo_by_id(reftable_merged_table_hash_id(mt))];
+	switch (reftable_merged_table_hash_id(mt)) {
+	case REFTABLE_HASH_SHA1:
+		algop = &hash_algos[GIT_HASH_SHA1];
+		break;
+	case REFTABLE_HASH_SHA256:
+		algop = &hash_algos[GIT_HASH_SHA256];
+		break;
+	default:
+		die("unknown reftable hash function: %d", reftable_merged_table_hash_id(mt));
+	}
 
 	while (1) {
 		err = reftable_iterator_next_ref(&it, &ref);

-- 
2.56.0.rc2.329.gd58861e689.dirty

