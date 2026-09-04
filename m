Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F4A330B3F
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 07:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788505412; cv=none; b=XNYzyYPqryM99EffxKX9BpyEuMEAgOa6boqhvSmmDfr3zKymJfzFcXU+TysWzomsKGcaOrlD6cC2F/mmrKJB57flpZhmpAt10we5kS1Stjyxt6b/LuR6DxFRzHGDMZYaczcIxNDF3cdgt1N+uhsUDZNqpQyoEOo24iiyU+/VT1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788505412; c=relaxed/simple;
	bh=D0hswkoYIt25MB6+f1TlUPxqGPHuMUaq7pl25qhaKhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rvU8LSdti4M5XQ8z4az0wuFvxv8NniYL+Fdh3lydWapXPv/zLUoD4Vm2r8OCrI6Yo2rkjoWCKlpF7jKHr4899SzOh+RbJiWS++gx+SwyBrx999lfZxs1qpLgyB/EtEZrXlBMsasyu7BqKoTSzeoyfSMUwqGniZKIQqzHzUHDKqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E/kyAiba; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U/Ga48Np; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E/kyAiba";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U/Ga48Np"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 769057A017C;
	Fri,  4 Sep 2026 03:03:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 04 Sep 2026 03:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788505409;
	 x=1788591809; bh=rh53c+u+rBba+073vmr0snaDYm/DHoDqRGu+hMQLebk=; b=
	E/kyAiba7/gkbbKL0uFbVMOO7ysrEuyDGcQSySFRmvzN282zyTIo9JA26b+vApCJ
	9QAZQ6VMTilunNTcVkldXpCtfTHZ+65BZ0FNZUo2JrWYvxIGAzqwxO2KT+9uLe3Z
	f0XdhEoaOP8/ijQ+e+GY2WZ/dbGJxeOBUyXtQ0BLCz83CwKOvFvEBVRaCEgJVzIS
	oyZWbVp2CsSrdfAQz4MLmZqOhhBdl3zJ9lRXBEs+Wp47UmqTIUvex4tuQCus+ZkR
	T4N9oYp+kvD+UCpg+KHr9cHW4ZwwLpDpP8R5pVLT7pDEXOLCdsY7SRniN3GBC+33
	h8iE3tB5ylF6tec4M35w+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788505409; x=
	1788591809; bh=rh53c+u+rBba+073vmr0snaDYm/DHoDqRGu+hMQLebk=; b=U
	/Ga48Np+Hl/cGIbFNsduBM1pnrkTHL8otxy2gGOaCtSKwzQTtAxZa3fzBFPSHWCu
	4lrfSEbHVz6MqSBxBNoynwvuRHNHOBPGop137xvrM+aHXO8B+vRzoYv9MMEutliG
	Dbzap7Yvd4wGFyroYuFITwOVdKEuCTBlnzhrdHKVS80gTz80MPNUzo9f+l12MurQ
	XDQsKxT8Um5AdkeOJhK2Kc0GgVyMhA5YWj3e2tpSxicZJzUcjWqTxlkDxo9GfJ+l
	4JPm7CD02Qlk0PO/bAUA6Mj0gY7oYvRFe0ViLaCZydC0jbK0RrFVK4iAUFvut/Ur
	bOO8/G++PxltAUZjd4otg==
X-ME-Sender: <xms:QG2aatuL9Du5aGv9Z4shYPhlu2pPzvIx4QVJ-DoOaiidpw9IypPkdg>
    <xme:QG2aakRcyu38htK2n2MdqKbjGQ3e1kyrE8W5P13PulzvbSIJRdP4qDLO0xgIce9aX
    hiEgn1sSAHZ1x2Uo6Alo_3ffwFvAvfqdRc5tVZ0qKVTA6TwVjsnXa4>
X-ME-Received: <xmr:QG2aarOW_8G2Rtvj1-i_0UzgTmhe14euJAyXWsnZHmBmuqJgqpskVxWi4v991M6L5Ourww>
X-ME-Proxy-Cause: dmFkZTGVxpEbTiL0a6QZDlLcuh66bBAYzjmWd/VRITNpyP+7M4QPWHV4ovO2BoYmtgdeBR
    5im2N8xIR9TaTMgncMXKz+wZMnbFNMXOUGm5WavG4qwnisKnGjZZK+hmbGaM8tQfC5YeRu
    AS6PzFnei6poirU4D/9LxF3JyasrR7GM2f6FRi39n+EEQ2nQl1KyV77jp6tSPIrFEMBuor
    6o8/horu7mW+//77cPyfkZ4L61Wc1qxn9NEKdGr33bOs1v4SD277xsMPlfoCkZ30dJEOl5
    3rUDQJtO1Jh/LzNlIpJ44yckB0w+tUTYNmMvKCsaBZSmhfNKyvH7zlqx+6nPvMOygy2dTH
    5KjsG3hz93rIolyZWX727uRRkTt6X0/CVu/bBraHFvjJ0W4att7IqO50znn1yM/7jk3lda
    Wlj86kLizCtq+RCUL4jxyjxhTgghN68jOIeyT+4OkBoRSW9L2Rjlg97PHVMT26IWtj2N4F
    YmMR/VFz9HxHhHoAe7ap1bnLjpraH9Ddq7gnbvEXv22hzyhCntyhblxD2G59IMRGmEoCK9
    QBChtCMbWHU/oajka6rqyHiW9royu0iWE2HINDdrlQYTvyoTm+j+O41NBwsDb1IZ3DF40t
    uMMN6OAU0i2r/j6Vny7zuX17beCTJoDYyQl0MIKn0/YptkeBcXRYm+BIK0FQ
X-ME-Proxy: <xmx:QG2aahZK0rCCkCAynd-Tze_9FENZhJrBA6TBrNRlNrSlR9xrBLQTKQ>
    <xmx:QG2aatxiTCB0TaNDRmvrr0zSQVQJSEZvxfaLvJoMv7baqR_9UYAiDg>
    <xmx:QG2aakKmVGeKUWIhwU7CKAjkuPhjr9talrMR0a-2mEv3SSJaqwjapA>
    <xmx:QG2aavqoVDDhWA0dxxjHMtK-cEafrVRgUwmEPJ6b4KAh8aPid2mSCw>
    <xmx:QG2aavlto9Gnf35t4BF2TKVomM2oGR4TkFZ4AzKGytNcyrMhRdpOhyBr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 03:03:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3700c580 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Sep 2026 07:03:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 04 Sep 2026 09:03:05 +0200
Subject: [PATCH v2 1/2] rerere: extract logic to determine whether entries
 are stale
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-b4-pks-maintenance-rerere-gc-heuristic-v2-1-b1691121fe1c@pks.im>
References: <20260904-b4-pks-maintenance-rerere-gc-heuristic-v2-0-b1691121fe1c@pks.im>
In-Reply-To: <20260904-b4-pks-maintenance-rerere-gc-heuristic-v2-0-b1691121fe1c@pks.im>
To: git@vger.kernel.org
Cc: Thomas Bachem <mail@thomasbachem.com>, 
 Derrick Stolee <stolee@gmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2

When garbage collecting rerere entries we need to figure out whether any
given entry is stale before pruning it. In a subsequent commit we're
about to introduce a second caller that wants to determine staleness,
but the logic is not currently reusable.

Extract the logic to compute staleness by introducing two new helper
functions `rerere_gc_cutoffs()` and `rerere_id_is_stale()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 rerere.c | 44 +++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/rerere.c b/rerere.c
index 3d3bd0db16..073422dbf3 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1173,22 +1173,44 @@ static void unlink_rr_item(struct rerere_id *id)
 	strbuf_release(&buf);
 }
 
-static void prune_one(struct rerere_id *id,
-		      timestamp_t cutoff_resolve, timestamp_t cutoff_noresolve)
+static void rerere_gc_cutoffs(struct repository *r,
+			      timestamp_t *cutoff_resolve,
+			      timestamp_t *cutoff_noresolve)
+{
+	timestamp_t now = time(NULL);
+
+	if (repo_config_get_expiry_in_days(r, "gc.rerereresolved",
+					   cutoff_resolve, now))
+		*cutoff_resolve = now - 60 * 86400;
+	if (repo_config_get_expiry_in_days(r, "gc.rerereunresolved",
+					   cutoff_noresolve, now))
+		*cutoff_noresolve = now - 15 * 86400;
+}
+
+static bool rerere_id_is_stale(struct rerere_id *id,
+			       timestamp_t cutoff_resolve,
+			       timestamp_t cutoff_noresolve)
 {
 	timestamp_t then;
 	timestamp_t cutoff;
 
 	then = rerere_last_used_at(id);
-	if (then)
+	if (then) {
 		cutoff = cutoff_resolve;
-	else {
+	} else {
 		then = rerere_created_at(id);
 		if (!then)
-			return;
+			return false;
 		cutoff = cutoff_noresolve;
 	}
-	if (then < cutoff)
+
+	return then < cutoff;
+}
+
+static void prune_one(struct rerere_id *id,
+		      timestamp_t cutoff_resolve, timestamp_t cutoff_noresolve)
+{
+	if (rerere_id_is_stale(id, cutoff_resolve, cutoff_noresolve))
 		unlink_rr_item(id);
 }
 
@@ -1206,18 +1228,14 @@ void rerere_gc(struct repository *r, struct string_list *rr)
 	DIR *dir;
 	struct dirent *e;
 	int i;
-	timestamp_t now = time(NULL);
-	timestamp_t cutoff_noresolve = now - 15 * 86400;
-	timestamp_t cutoff_resolve = now - 60 * 86400;
+	timestamp_t cutoff_noresolve;
+	timestamp_t cutoff_resolve;
 	struct strbuf buf = STRBUF_INIT;
 
 	if (setup_rerere(r, rr, 0) < 0)
 		return;
 
-	repo_config_get_expiry_in_days(the_repository, "gc.rerereresolved",
-				       &cutoff_resolve, now);
-	repo_config_get_expiry_in_days(the_repository, "gc.rerereunresolved",
-				       &cutoff_noresolve, now);
+	rerere_gc_cutoffs(r, &cutoff_resolve, &cutoff_noresolve);
 	repo_config(the_repository, git_default_config, NULL);
 	dir = opendir(repo_git_path_replace(the_repository, &buf, "rr-cache"));
 	if (!dir)

-- 
2.55.0.1007.g17ff1f9808.dirty

