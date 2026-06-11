Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A079240BCC3
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 13:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781184439; cv=none; b=gq7c2avOjMhHsPHLnvUhTN/4VnWSv81q7VCF88Re+2BkVaoyEIpeAPanIy+/jAl+kuO6v5nOMns6fGOvo0Ta9z5GiRYosZMZoC2RD2/UxN8rHtSDiLnuXsCREmBBILRPYFB+I6196Iupnh9TJC45wc1YjZMlllSW/uhI8d0+pSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781184439; c=relaxed/simple;
	bh=6V7XRFTTcj8oAKfhC8ESYqljldLEXfbxhLAya1LyEIw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N2a6xrDGpbXYXHa5VrcjZR6iyE+cOejMny3EKN9xk/za0OWlzWn77EnutGhQNeTQQC17jdknYOUbIEbPy67EEgeDGALHLphEqGdCbXiCjibS5T6ucMwNjnOzi9KiqKY4FgIJIYLvO0/GnaaelpP/B6F17/Jk3aK78HDPeVEoF38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vOBL827o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZFXvX/MN; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vOBL827o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZFXvX/MN"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 04A60140006E;
	Thu, 11 Jun 2026 09:27:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 11 Jun 2026 09:27:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781184437;
	 x=1781270837; bh=QOagea45WFwkEw3TA4VGqLhkkfvJGoU2fM0PGf0tULM=; b=
	vOBL827oCTzMTSnXsuaInwtZujhzbINknLW0neIrPOjYEU9Pthp96wIRb7jphQ1L
	pocb/csAaU/+8NP1rTdtru9G2TejPfE/TAHXoDthgxFCUUXvLvGN3MnpmWW6yS9X
	26EyNP7eI80Ipbnxw4yBBGJHvwlYrR/UmZA1kl8oxMvCRk5eYhHn4C7vP8ODZWwG
	1x2b0if/pcWHRmKEOyzf+iP63hrAe20zbOvqTcnMvv39o1pUZTP3EuA+NLqkBlms
	rCX6voxl4eMK6xfiG7Ng71I4zs99tLIyneaohi1jTyZGqCk/HhIiNDknXHxWtIsu
	gzwRl51pfcjgHQSa5aSdkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781184437; x=
	1781270837; bh=QOagea45WFwkEw3TA4VGqLhkkfvJGoU2fM0PGf0tULM=; b=Z
	FXvX/MN3rx5sofhkNbJsQVclbuXx/Z7INJiQ+rUtw3pPIyKq3Kg0V8MBs+GPDvRf
	0XMLDFyHXWtlUs7lByWurHnM2QJxWxKSokzpQdik5bI/Amzag9HblZNJIHApDf65
	MXaQpeADEBBRpCYhDtymimlgPXLPzJmeqBkM6gKAH7Io3vSHrSGVxjqlxx6i2jev
	cWxbIYVPORr1Acttve87dYEfAiyQaC8+YIgS0li8HLXKiNZBUvPOBV8dCITY6aV5
	830M2DzR8iziWuMpNcwVfaL3tGHBJa8hwccXNXkUwO0rSE1NpPSHp77oa0Lv/54o
	wkA977Gch51+TzGigyBNQ==
X-ME-Sender: <xms:tLcqaku0EDMtUbSngCHc8ZNbFXSBAQQo5Vyqo1mX12L-KecYO51dfA>
    <xme:tLcqai9Q3YT41eDM_UdzWLYLenPpUBs4ITi_QbcluL2qRNcMOaPbLFwbH4cLwjht9
    ZUBZUbiwIErP1PhA1K7tmcmGYzGHtpT_-FhQkxhmjRvu72Ai__1>
X-ME-Received: <xmr:tLcqav0ar0pdcbkQl0-ySL7bEzkYfK1JIqDuKPqQbButLpZV9n4qFa26RrVfGCOTukSJaLvy10rKKT3XSCeBrSA4ACRetMR9kNzMl9XjGeZ5>
X-ME-Proxy-Cause: dmFkZTGTxPIFhuBoiEsDDhB9RSHDCXHbFJ5VnVZDD4bec7nRzrCcE+c/MFsVjwohVHwftl
    cVFao0kG58zAIws/O0Ei+RCSGpQ0XKAQJ897zbTpVEbAIBEUeVlBXzfOFp55wWFPDBC63b
    ++i23VB0mlc+JXzPK3+XAmANc+ZYYAp9T+MNk3HVd/hzScgiy84HRbrCh3vZt+7kXlIWUj
    ICMm9WiiSqqEB0XslkAYhBOOtsaSDKKRXTT8LmcdFGr003K4VIXcWEJk40SYS0wk41aqac
    5QeQLlxVantr78Np3u7bywp17Vc7XJmbCgEqW3Tgiuxa+RRmWIgUhEXLaBmgiHi/rb6RY9
    f9YlP0dC0s9NDqHveN17LHzCivK4Qv0bse6MlfM73A8hvZ9rtHIYeSLB0PBMyC/J59AQ0x
    ggLGN/EU2AEIBjFRqp2cqUfIzm5g5IT0rvLJGmE4WLxhKg3xQzpWsxqblcwW4Rbb2DhwYf
    YgbPXPM/URP66tTQx9jdf6BR4bxuy+Y/1KeKE7k5nLVV5j+IKChX0S/PvlXFbJRvVZ67+G
    pdwoHn2CoGp64lWE8RDylCVsDqjFxeZgOKp0X4B1r1LiQhpx0SsQbRunDNkgF8PaKHTWyX
    mSGGyEgXDWihBtgL1g1WweemukuUpqZ77YlyGygJveqzP+TmKErpghHByzow
X-ME-Proxy: <xmx:tLcqanAlBmqXLVQM0rvQb4o9tDnfNcxtjLdPQiy23TeVlJ2VUEf6vw>
    <xmx:tLcqarfYuaNfC5hrhfoTY1-2p0uQI2AWOujB_VPq2dBKDIwnYICkgA>
    <xmx:tLcqak7x-iA0ED5vjfu1UlP4E-qvyBVVjRr7WUXL80SzLT_ic72ssw>
    <xmx:tLcqauUsUOAK8sEFpjevJt4y70sl8z_jgC1PfCp9uTfbv-QQw3ZWaA>
    <xmx:tbcqapSPIofNLybkUOyWwF4CS7x-G_1LJRnLEeV6zjmn4WaxdwWNZbVo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 09:27:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id aa96f9a7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jun 2026 13:27:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 11 Jun 2026 15:27:04 +0200
Subject: [PATCH v5 01/10] read-cache: split out function to drop unmerged
 entries to stage 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-b4-pks-history-drop-v5-1-34d35725559c@pks.im>
References: <20260611-b4-pks-history-drop-v5-0-34d35725559c@pks.im>
In-Reply-To: <20260611-b4-pks-history-drop-v5-0-34d35725559c@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2

In `repo_read_index_unmerged()` we read the index and then drop any
unmerged entries to stage 0. In a subsequent commit we'll want to
perform this operation on arbitrary indexes, not only the one of the
given repository.

Prepare for this by splitting out the functionality into a new function
that can act on an arbitrary index.

While at it, fix a signedness mismatch when iterating through the index
cache entries.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 read-cache-ll.h |  1 +
 read-cache.c    | 12 +++++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/read-cache-ll.h b/read-cache-ll.h
index 2c8b4b21b1..71b87615eb 100644
--- a/read-cache-ll.h
+++ b/read-cache-ll.h
@@ -309,6 +309,7 @@ int write_locked_index(struct index_state *, struct lock_file *lock, unsigned fl
 void discard_index(struct index_state *);
 void move_index_extensions(struct index_state *dst, struct index_state *src);
 int unmerged_index(const struct index_state *);
+int index_state_unmerged_to_stage0(struct index_state *istate);
 
 /**
  * Returns 1 if istate differs from tree, 0 otherwise.  If tree is NULL,
diff --git a/read-cache.c b/read-cache.c
index 21829102ae..799a5bc719 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3403,13 +3403,15 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
  */
 int repo_read_index_unmerged(struct repository *repo)
 {
-	struct index_state *istate;
-	int i;
+	repo_read_index(repo);
+	return index_state_unmerged_to_stage0(repo->index);
+}
+
+int index_state_unmerged_to_stage0(struct index_state *istate)
+{
 	int unmerged = 0;
 
-	repo_read_index(repo);
-	istate = repo->index;
-	for (i = 0; i < istate->cache_nr; i++) {
+	for (unsigned int i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
 		struct cache_entry *new_ce;
 		int len;

-- 
2.54.0.1189.g8c84645362.dirty

