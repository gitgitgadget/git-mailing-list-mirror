Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED05E440A34
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 14:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787668223; cv=none; b=GLnqPMwTn4myuRekhQ9NS6hMGJ7VEJzY+06LX9gnbUQojSkp1r33l7TIseGVfm7b5RVFk7aLQNet/kI9BBJmwHNU1VkmC1odz4Z8ksMDD+poVI9GSkcjBxkZjBBpIOk6R94x4sAvOnqupaQwGSwGFcrhSffzgrNDLrF4JdKUtr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787668223; c=relaxed/simple;
	bh=xDGruBd6yISN+wRxQk4y9wkE3kF340g4IpVWX2IDl+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B4v0B4LS2EPA9iDKrJpFs2FCAwDBVOf8RqcrVy8vNtvb+9atj26cX1cA0/DmemZBqCXc/YLwqi9H1PwsyL+LY7MGzn84/12zfJk1O/FbOrb2HaRc+lRgKE+QVWwsyX7HWR+yvqGg1XP3WFBTBsODMuXUSAQB34O8xEufKRwKm/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GUT3EPui; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DLdBs5Rm; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GUT3EPui";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DLdBs5Rm"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 03BB57A008E
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 10:30:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 25 Aug 2026 10:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787668219;
	 x=1787754619; bh=Jnn9dozYyWRiL+aM3FcrPAi5yW0UY9DYfuqEuQj1lM0=; b=
	GUT3EPui3492JvNYbCX6g1Gz5IHZdFgljYyKdO1sgWWM+ThrmVF2hd2nELqGQxU3
	Byp0rE0T0547OrcErlOyRtdYWcxyuL/yiYNJi2bhPjmOYo2XZw1PutGOrqoako2J
	4DpOSP7BFTTdVu4cTP+S6tjAtmPtpnDQDZ0I8zXQK0QuGty8CfgG+vWwPw//+8aS
	S1jxRHmDByudJ8dxiuHbdQomulmgAqU01oo7PH2F79QRM0Hv3EaR/Q5gl75NLU9y
	BYxpnRxJ1dg5LefTrt6zdAaDe8JbpeRWqOWvI27JMMepuNbFyHm4dZ/ums3htYEK
	ITS2IP4kp9RvG+IDsLXO0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787668219; x=
	1787754619; bh=Jnn9dozYyWRiL+aM3FcrPAi5yW0UY9DYfuqEuQj1lM0=; b=D
	LdBs5Rm2N39E4zar31vvw/w4PD5B6DCwJtVbvMRsocytAVA9Rbfs8VKdsnlhx8zI
	eh0iH6dRh1GEOHCdR/gdnPwKhc2cnoBxRgNYxHRTZUwMpzWfi/kaI9fdSQyDVKFn
	qJcajTChpNF1mcPyZJ62o5Bpgsym35RoRFDaL3jbNX0U4hnuIJV7oRU8D47gHvv6
	AeAn8yrU6MvMMweMgaafwvLAr0u069FB2eUD1Ib7TKax8FibVUsGXvahtsesyBwF
	ogUWMUdUteth3MN6RBJnEomw8oT2S2hmC0YMeVP+JKdByooPNRYnj6a3R4zO206d
	8WGIQ0cIcDROgLoyMT8rQ==
X-ME-Sender: <xms:-6aNapsartZd9FV6T76Lwk2NxHnMCVWzIMYvClbQKAK4nb0a3YEw_A>
    <xme:-6aNapaqjGsl62J_bqvey8vTi9E4UGZVCLZZ19THBtXD_pIQGjGVrPmF-QmlhaAE_
    OKnI_qqmEU0DepX8KWMS9T687-MvrH3praFmXPiQbrawt7WxHipyw>
X-ME-Received: <xmr:-6aNaibRkf6EnRlPbMmWoK_9dFHi4BI8ny9Ik-bVmYuLor8ybEacSuCRYEpx292Kb6KeRt6LZWFmdwz-Y9nkj2PrduuV21U6byic6cTBuw>
X-ME-Proxy-Cause: dmFkZTF7di7P9fqeVtKyfLKbViZD7TBnl4srwz5Ve7VQBJmvFG7KMshIDpaCixvYPMRY1h
    MToVw8leZsp6NRTEnNkzR2GbnzhIeSkDMXyz6tF1rPG3WCmPgAfOp7w9ECiJnWNm3qggyf
    pLU70w6A34nyTdJBsTiO7P4+tQsyhOcfD6IbKuN50FcBA4BTbgRys6YYiGRQNZVpKGXBR8
    +Yz6NjycNLVfAEeHhUraj08VjNvG7b1J92ThlgvTW+tWd3AIJZcCqdUSRypwuSKWRIkp/w
    B5AADDwhd0O4ES96La8mcFBQZ+myORW03YyVssffHdRAHA1X5QkXTM5vsOoGZqFrWVlOAC
    /83VmsWOTPTARuoLNQexFrGyFTATETzNEimp1wjs8Oe4/yGT2ZiucXUlzZzmPsYbQhnC2/
    4RPnOh0CMq7RxjxvzvlyJpkhT2dYIXBvLx+Dh3exXfJbjzmfhkGuru1fnM9DYTBKaA7WqK
    71kgzf/Ua2j+tzJYfSuKXQbHWvWAhXmWqK8+++1Sf5Lg1aaqlvnkQniQsebo1EGRc86d/5
    ZLxPoVHGS3wz0sV/yqu4rbbp9zj8jtsnEAIyA1Q3erPVWsbY0H1YSBC7iGL9Rk2oCEtO6i
    eLY2bb7yE6aw/y3/wayEceHeY7KKL9/vu084tPT+bt8tgjXvaT6bPnAie7XA
X-ME-Proxy: <xmx:-6aNalWye5FTydZujZl1HYg864vIDoDRISIPxVndWIj-_rsxAzVv0g>
    <xmx:-6aNap1BZNFEdvumE2Khttb0CZ55XxWqHWzkN9aqCV-l2vJ_dqYhNg>
    <xmx:-6aNasbqCZ_jylA87DgdPxj2J4WgUCoTxWmdrCGqLjcAJYeakIy6hw>
    <xmx:-6aNasrjrdEVAkNZPoapowps23UplGQ2OpPg-awbmPtdx7hLt2XpWQ>
    <xmx:-6aNagdBRfgr1HDmJfbnAEEI0u4nUJyMRnlFqZW6zApLOC1r6nWX8tLq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 25 Aug 2026 10:30:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 76179461 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 25 Aug 2026 14:30:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Aug 2026 16:30:04 +0200
Subject: [PATCH 02/10] builtin/fsck: merge `fsck_obj_buffer()` and
 `fsck_obj()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-pks-odb-source-fsck-v1-2-b756de0bf24f@pks.im>
References: <20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im>
In-Reply-To: <20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The interfaces of the functions `fsck_obj()` and `fsck_obj_buffer()` are
somewhat similar to one another. The only difference between those two
is that `fsck_obj()` takes an already-parsed object as input, whereas
`fsck_obj_buffer()` parses the buffer and then calls `fsck_obj()`.

Furthermore, `fsck_obj()` has no callers other than `fsck_obj_buffer()`.

Refactor the code by merging those two functions. This makes it obvious
which function does what, and it allows us to get rid of the early in
`fsck_obj()` in case `SEEN` is set as the only caller unconditionally
clears that bit before calling it anyway.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c | 47 ++++++++++++++++++++---------------------------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 3c4127f4d8..bed8481893 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -401,14 +401,27 @@ static void check_connectivity(struct repository *repo)
 	}
 }
 
-static int fsck_obj(struct repository *repo,
-		    struct object *obj, void *buffer, unsigned long size)
+static int fsck_obj_buffer(const struct object_id *oid, enum object_type type,
+			   unsigned long size, void *buffer, int *eaten, void *cb_data)
 {
+	struct repository *repo = cb_data;
+	struct object *obj;
 	int err;
 
-	if (obj->flags & SEEN)
-		return 0;
-	obj->flags |= SEEN;
+	/*
+	 * Note, buffer may be NULL if type is OBJ_BLOB. See
+	 * verify_packfile(), data_valid variable for details.
+	 */
+	obj = parse_object_buffer(repo, oid, type, size, buffer, eaten);
+	if (!obj) {
+		errors_found |= ERROR_OBJECT;
+		err = error(_("%s: object corrupt or missing"),
+			    oid_to_hex(oid));
+		goto out;
+	}
+
+	obj->flags &= ~REACHABLE;
+	obj->flags |= HAS_OBJ | SEEN;
 
 	if (verbose)
 		fprintf_ln(stderr, _("Checking %s %s"),
@@ -417,6 +430,7 @@ static int fsck_obj(struct repository *repo,
 
 	if (fsck_walk(obj, NULL, &fsck_obj_options))
 		objerror(repo, obj, _("broken links"));
+
 	err = fsck_object(obj, buffer, size, &fsck_obj_options);
 	if (err)
 		goto out;
@@ -442,32 +456,11 @@ static int fsck_obj(struct repository *repo,
 	}
 
 out:
-	if (obj->type == OBJ_TREE)
+	if (obj && obj->type == OBJ_TREE)
 		free_tree_buffer((struct tree *)obj);
 	return err;
 }
 
-static int fsck_obj_buffer(const struct object_id *oid, enum object_type type,
-			   unsigned long size, void *buffer, int *eaten, void *cb_data)
-{
-	struct repository *repo = cb_data;
-	struct object *obj;
-
-	/*
-	 * Note, buffer may be NULL if type is OBJ_BLOB. See
-	 * verify_packfile(), data_valid variable for details.
-	 */
-	obj = parse_object_buffer(repo, oid, type, size, buffer, eaten);
-	if (!obj) {
-		errors_found |= ERROR_OBJECT;
-		return error(_("%s: object corrupt or missing"),
-			     oid_to_hex(oid));
-	}
-	obj->flags &= ~(REACHABLE | SEEN);
-	obj->flags |= HAS_OBJ;
-	return fsck_obj(repo, obj, buffer, size);
-}
-
 static int default_refs;
 
 static void fsck_handle_reflog_oid(struct repository *repo,

-- 
2.55.0.822.g20453c30eb.dirty

