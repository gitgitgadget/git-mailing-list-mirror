Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFD338333C
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 05:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790833161; cv=none; b=KaddKZ9Tyx19OYnAq2RLU87c1vAQeJjscDVcCEG7idGkXnzFHB8wLCPwENFfZ3CxylXEqP6LHDWv20JqyW1CJqCkREO8+0BOyuuxnMd6CaroNWWlWW3j3hLd0nQsVR6Sd9LZWPfa9jtFynAtR+e73GaRuewZUgvTljYQAw0ced0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790833161; c=relaxed/simple;
	bh=G2+DhIgQeGaj635Lde7tOqbur5YH7EtWYv7CIE7xadM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kbn6kDeYETjkzS7LGOknZi5Ld0t8oyU+WBk4JVUjSgk8bN4iKjVAzeuKzPD5U4rsJcKmetV5VvBDjlcZyqpeyPZg6YCVBtJztZbpAO3O/OQXt2nT5gEEpEsy9YiyptD3KrQtI69+ASwtk+YxpCoc3EaEFAL3uLch8fPX21piqAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nc3Bz/H3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wpr0wLrD; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nc3Bz/H3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wpr0wLrD"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 56A82EC0179;
	Thu,  1 Oct 2026 01:39:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 01 Oct 2026 01:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790833155;
	 x=1790919555; bh=Q6pUASRlegOHV79RKrlOwgUvJwqwFneh0ZmvX56SV4c=; b=
	nc3Bz/H3o7cJ1S1Ui6URNJooNUZIjbvQs+xzndAjMTjlwaTYL8lrtdhlzd0T9TyM
	14IQoURf2PvEY3a7Vw4xdjSQGZvVgplFSQpJZNB9w5wmaB6IkVz3YRr+aClbpQ8E
	0AAeLbREFyV6BBx+FwAcmZUKZ3Gnka6qqAJZVxCpSd9Adh1rz9F0FDfMdtTfmGeR
	fOEC9Jn7/8ZRmH/dirrUs1Ru3k9PFZkorZwi3kC84nfi4e7TCaExnmfUSk8ANW2D
	NPba3Oy9wbCchb9GFUwzvNWLwISpM9OSSp3fW4ONWgsqUciSn6S1QG6rScim92in
	0WYo9Aa4mTMnQLFQVWCpDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790833155; x=
	1790919555; bh=Q6pUASRlegOHV79RKrlOwgUvJwqwFneh0ZmvX56SV4c=; b=w
	pr0wLrDVLlrND8cxETtjrMfL3RPT6yWWlp2WdLhba9UXc1GmpZCdH5Yq2oJXhHGu
	chMXXfas86kQ9Bxiwhe14K+UJRK/a2PK12PLQWX/XJQiZP0dFy3jrUIhPndUURZ3
	H9W4dWGWx19NrpHNWn+lk79Plda66zQg5amdnEdqVCCyAHdL+NIvH2c+xXVXtdbu
	g4bcjHgnH5du+l6N1J35tnlcgEDMPI7GcXEsNXYcdptPhBJCYDDamfd+Lqu4K60U
	k5upVd6TEVdTIxjAhxbj0G5PWIzwlGqadVhkLw3FJCO1K1RT3KwrmyX+LU7Sy+am
	y52XxwQeRpUaKuX9/0KsA==
X-ME-Sender: <xms:A_K9avvk1FM2pkS7e2g-rqJCwfsFziCTE9CuUB1Za1hI-f3bz9J3Vw>
    <xme:A_K9auQO45Hfv5wpd3XupmmVfmO7i8fHywwq8DA65-IomVFUCtZYKs4oJxaeWLSLk
    0nb3IF8goiLLTm4c61x3rsQaworMejQe6EhtYQ45bODWldkXDwBVYE>
X-ME-Received: <xmr:A_K9atNkfzwHNfvlFk-ww5r2j1ADldKLUEgJWcGeBCbgwL-HVN69Up6aQTDNEcbTwN5zDQ>
X-ME-Proxy-Cause: dmFkZTFHNP9zdtymB+5Pv/ix3oOma4BJzGx/6KOsGD/4foUsxFnLyRbWSgEWUzyN+Q9Y4l
    jh/8wyCazdga2BjYXVopjn0YdiAowCCarxWoCZoxGqmN1hP03e4Xblftn8OOR6jcrTV8il
    +1hks+yZoslbx4ptANuv5uKfDFptqTZk9kLLfxWKRX3U7DYdAkc4fWyQbmFdJEWOnOfCwd
    yGRqIRHKRcVsBsP9DAwJxUAXqWhmmzlnnSkjcX7dsvRZpZvP6rkt/qwc414ZZuAF896jRM
    gMdkXu497sluuetqyIuh+DSIZ2mX8XgOXLTIM832GvIpOuTuLU/5MXxdyHkjftqPVo2cCQ
    4UxOVFPKGMI+qa97rWa/VkFQ/MkHC79OHV2NqrjvfQJi3DA29gi/z+8U+V9WQIbz4pN5oN
    eVHx2OpNSKM9Nu06mBI6wYt1yWaa8ENylyDQQWmm/Roddkd4rGSD9aYseN2iQoa+tFCxRO
    iAPwzfqUT5Aijou6V22h2OKFKkpHgTWPLQiO/qVhNK6pRueZxTXe+JK0bgsgHdcZyKeg4t
    oXsBr6WqMuOOSHj0BdefSPebkTxRIoQrKPVvJ8NoLH92v+mvCxVyY6uWQPYB1ltRnj3WPl
    /nq15ShH3XUhj4/qq1f40RcPO0fTGNJRmq3tlP7o9ccNjsB2ihaMDVyjSehQ
X-ME-Proxy: <xmx:A_K9arbN7XEdqf7tI5_unHqIGeGRndsr8O8rk8G4eCteNd126TAF-Q>
    <xmx:A_K9avwtxSgw7w_P77i6oLTIaJlcqh-ztAaA5842iJwlHjvsh4WIYA>
    <xmx:A_K9auLiwYprvEVOJhnjxAamOoif4_CVGxOWQA2ADMwoYHu3BULgAg>
    <xmx:A_K9aho5zw2FaT-k5UJ2LEWmUHmkMRd3uVTfI_HjcZ2AKJS9mhnkLg>
    <xmx:A_K9aulQU4X6cu9FunIyAzgVPMnhuie87ynr-mUY-UCgM75j2XEbnwCX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 01:39:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0d404c32 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Oct 2026 05:39:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 01 Oct 2026 07:39:01 +0200
Subject: [PATCH v2 2/3] t/helper: fix segfault in "dump-reftable -t"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-pks-reftables-fix-timezone-format-v2-2-a4fd1f7cd21a@pks.im>
References: <20261001-pks-reftables-fix-timezone-format-v2-0-a4fd1f7cd21a@pks.im>
In-Reply-To: <20261001-pks-reftables-fix-timezone-format-v2-0-a4fd1f7cd21a@pks.im>
To: git@vger.kernel.org
Cc: Josh McKinney <git-bugs@lists.joshka.net>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
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
2.56.0.353.g0856645cf6.dirty

