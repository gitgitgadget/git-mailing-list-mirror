Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD423BED5C
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 08:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781081560; cv=none; b=h6ldy+JaMnR9vSy7RWtGIs6c+VarNdu0mw7ECD4pAbUKwPJyFjuXP9GbqvA4LAuOEnKLoFjeto5g306WAxupVwQw8b1oDed9iUpHBPuOHlRKqzj+it3OdRTLY7H2D4iU1N9iSjMnpdIICtpcUaw066vy/DO+HhaMn5ScS6Sdq5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781081560; c=relaxed/simple;
	bh=6V7XRFTTcj8oAKfhC8ESYqljldLEXfbxhLAya1LyEIw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dyor3JBSP78ZfH5R2KX2EU0psip1V/iGqmkarqXt321FyfqaaPiR2QO2J3UzwFI3JK/FdxoMTyDKbeVrPdiXYq6M4PMGS9KXNWF0sVDN127VYNzfCfUkag61HJa01AQBJ3xlxowQVa9hkpy3FHiy/iuOiAYgH43tDCaJmmM1TWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UWPrFLCP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KdE5+6zv; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UWPrFLCP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KdE5+6zv"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 95D681D00097;
	Wed, 10 Jun 2026 04:52:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 10 Jun 2026 04:52:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781081557;
	 x=1781167957; bh=QOagea45WFwkEw3TA4VGqLhkkfvJGoU2fM0PGf0tULM=; b=
	UWPrFLCPpqeqisl4JYQQBV/ZCVOJj7VNt4Z+sn/u9+OzwEjLR5wApuTW/KiMmIm+
	GTlyX8EQYwLYRIbmcpybz+T37MF+rOuTJm5neCAhkZd7Jcl974wCl96hUFw0I5pr
	hK8OdG9xwx6E0PEbN1fd2om5Pg0W5Cl4V+rdgHddOUUSIskCxekaxTP+oNmfsJVn
	ED5rdPYj/+fCBr/KuAifOu0ftriQV/pp5Y9Ixf4dikPZ90OXNEynX4mJEikmi7Zu
	SFihA5PBBpDh+8Rmn09ec9fuNxYw2EftzCwAz1gkRXrvn5yBr9OMOjvI7KXe9uUn
	EozMxSOvHV/LabcHUQY/hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781081557; x=
	1781167957; bh=QOagea45WFwkEw3TA4VGqLhkkfvJGoU2fM0PGf0tULM=; b=K
	dE5+6zvHIoucKxG0Exyjt2MJrgwNHkWvGWGUm2oqfrDS7VBHgRxzvUI31BKYzNBu
	d4pWmeebVgFBzTP9Tq2a+1/sLvkDxd4TyUqfoXXWD4QqtVbeFf4c55oPXQW/DehM
	T24PtIu5grnYukJX4ersYEGCaEnRU/yhmZVI96CVOUtCepr/HeeBfI5pngi1OkQs
	wI0grXiWjPeZ29/lyX9SovWQ2xG2wtAE25TVxl1KvAZGVY+5XgxGGAvmV6YaXoP4
	4TF46O0ULX3wi3l1BizzSx2VJ52W9lokMpuBp+Bg3jxrJpx3tR9I560qRBujHtsO
	ecBZXvAqID8TGpkh1EG/A==
X-ME-Sender: <xms:1SUpaokp7JplcNeniSsCWwOJ-qG_d_H-CrZ2tibFyCjocM1fbelQsA>
    <xme:1SUpapXvy8E9xF9Niivh1_EQBoq6KeU0gDd_VYdC-7zk2zwDZanTfSLkV5Hl9A57R
    bUBIy6TedXC4Ef4kiI_S8OSf1Fm8ml4fChjeJ6IbhY04jHxgi64aA>
X-ME-Received: <xmr:1SUpamudhgXUTcLlfLemM38VotoKlcOOiReWJbS7RfOmg7H7pRiqGcQO0tDhwJ_q-9oVmJQ5rbMh1Irwox_MH2JsAZ5z0x6SyOTOoPQf3Q>
X-ME-Proxy-Cause: dmFkZTF+2VdknJdj8ZOu+QNsFFL2Cp4b8MqxYtg2L4k2lvcdsh9YrzSboE6bPt4KoDjGwC
    6qElUpuMdHcBesalKO5yqWKug91R08Ywpa4ms3332VV8ZUZovufNOt6cKxX+PDS4N5TOlh
    UkArHXbI5L+hKOXl+CtfdlZZjrWx66Fz//JhA/5xtF3/vAXeWCf3FpCs+sPLHHPIfvphj3
    vnmi+RddKNPLB2ik3E4aLRriPZHJaWRwXmwXbswq7zGuiiduIG4/L0Ut90WbLe4URCzcUF
    VVeXIIybjrzhYBZ2WLlFI1H1Mz/pN6DdD+zzryFnw/IR2vHeFP0fSf5P1EeJPM80Et84j5
    xKxNVF/pWNYPrcqyMVONFwFN9l0Mn0UOGfZAKMbCyhBysCxfA7iDdgK+eWUKU5J7y27e5R
    kqZqAmDzm2zCbYq8hbQX4dgXCtb/Tm2AajhDG0iqWqKxjGHXOx3EqRSM2/A9PWnDWNWP3n
    3BoWHM7z+A+Xj6bTilRXr5+Kkj+YhyZRWRTS/vD+feqyZOzpyaCfHiw+Ew1CrzwWzC5AQ4
    alIk6FQhqp6EaPoxE/39BL2QCGo3/hfmMZO1ufgo+BCHltGNRTiGPa4EPdHox9nTk4+3I8
    ioZZWYYkAbYDYznjTcf92wX+UKeavfmuo/+KEbf81p3bgtz3mswc9zZzpakA
X-ME-Proxy: <xmx:1SUpakaCXzj1NNFCZM-wCdlSNtxUFYsRzlSfwgtWNfd2BpQHIBvRxA>
    <xmx:1SUpatWjdvKNXIPkWTGUIouLZAwgrOBfMjDxnhAQplIhsbEWgwWI5Q>
    <xmx:1SUpahRhgokCma-6IGmTj3Abt0V2R2ccPwpnmLnNrtdoZ34nc7n4fw>
    <xmx:1SUpajOo7s74DrkIGkbfVydXbBuW6kEf7IoT2q6LWLTq74_HJx3X_g>
    <xmx:1SUpasqckjcRYOJBlNUUblRTfexaZtHP7L8Rsd0sVF3y2zRGYldhuw6h>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 04:52:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3f9be27d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Jun 2026 08:52:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Jun 2026 10:52:21 +0200
Subject: [PATCH v4 01/10] read-cache: split out function to drop unmerged
 entries to stage 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-b4-pks-history-drop-v4-1-70d5f0ae8c25@pks.im>
References: <20260610-b4-pks-history-drop-v4-0-70d5f0ae8c25@pks.im>
In-Reply-To: <20260610-b4-pks-history-drop-v4-0-70d5f0ae8c25@pks.im>
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

