Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E03181B83
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 09:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318276; cv=none; b=ZbDD+1f2SaEZTiU8z8UJ7Wla3vET+0xK3KZFupEN/hEiQMbp2r7Q4Zzxo+vFIQqig+G4DDmDNO0deL5gF3nJiMbhLxFYVRX5CuFB7Bd9eHDt19mwUmo1abbI2OQlgIpJo3jIbYvrevyS1Gyvgd+iKW86fjXRgkgpTPs6Og5agFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318276; c=relaxed/simple;
	bh=9wQt4BHiI/bt4NyKITEtRjgp3D8b62VJEnSMyDCYMkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=raCos67MGaMi1y7SSQ313AmOfW2Y+T+0qEh1FlvtTbpblm3ZrooPFcXG7TUfblSIzLuS/VRAjYogK7Z5iVXOlob3oceKs6Ywn4eOp/TBO/UKfV+IwZlIk11AgM3A3sV7ObT1gS2OvTQncwXQbSY/7hMOqalPkuXbHWpsZ0387lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IQcQ7KvJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lPtKRjjV; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IQcQ7KvJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lPtKRjjV"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A1BE61151ACA;
	Thu, 22 Aug 2024 05:17:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 22 Aug 2024 05:17:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724318274; x=1724404674; bh=jJaGu/U2tT
	ESezbyhYQIMT3CF0nv9IjwY5IFbxYDrss=; b=IQcQ7KvJna8yD+BEZT/snQXqc6
	e8WfMqHkmUvTAxtSiF4ASoCKqzx31UhBkP3X1Vom7hcMQcS3EXiH2prtvpwUcTqC
	oqx+uZ1xVtHspvIi2kpZL97bCq35Wdh7V2IbMi2pg0V4ZAwHzq/v+UPXdSJuf53U
	fc+qNVmXp3h//qXaFp3m8+VOS3vGI3nXyVxjGulpD/7p9CKI8Dz76V2ck8ebCYNN
	PhaMb6tYlKpf3EuQDdiBhG0vCYwS/AKtKBsLLuyGTg4XOpYYlOcfR76vOGwwZebb
	gqKQE105yLIVP62l3uGeWoFAOPo7ZKPfP2IiuYgOY5dgu4irBG0orHVg7kzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724318274; x=1724404674; bh=jJaGu/U2tTESezbyhYQIMT3CF0nv
	9IjwY5IFbxYDrss=; b=lPtKRjjVNW5+2/Y+5w19kbfN34ul5OmXd7GI1sWiFwoL
	TYqojm8fB7awgCM0YKdCH6uw1aVtxgECGKNi66wFXgujnys1wsb2i7sOsa02wo6l
	nTCK3/2J3QGie1PlzWueViWaYwyEs6JjeV40rV/IgebhbdN5wkFfSliZxxXwk8vj
	9yzEW3yvveC1X1DgDXV1DGsjPnuvgacBCAIyv/MJ0jvHZrbNaBHqstUSc1rNxarD
	aoTF987d+uqGvL2ScnrzEAiFlPFHn1kYGZBaLo1pIVW7iJABdIRv9tcFUBCdIjqW
	fzgvd0y4r9qUhuoF5TmzLZiGhwNMaomjALDSwgt/Xw==
X-ME-Sender: <xms:QgLHZr6Z7-ECxvOQ2KRVY25QDI8HeryqYPRVixvddnrd5w1P_A587g>
    <xme:QgLHZg5GQz4xYLj-wp1P4xVK5viovl2KVYRI_9_qgZB-tHhrqdnhfe5CbtLTi7SXB
    2zCm2xbFnFC-xhI0g>
X-ME-Received: <xmr:QgLHZifA3aMyNJ2fu9DSCWik9AP-I9yZoFt27eFrZ2q7C0sN_IhBG_yMufd10DN4qf15y56MmiJKSEksX5hU29XsbwmAswsFmghTIGmrxqNgfVM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:QgLHZsJG5TqP9XEIh_7Sn7gP2aUi1XoH7AOfopTRWFiscK01q-ITGw>
    <xmx:QgLHZvIwTcR37QQHBz5yo9igiKDAjZBjr10zSHtURE-VaCXdHq9HMg>
    <xmx:QgLHZlzf1Wr4NTOVZla6lq60xx5ZbWM2eCMxHBrabX-WGvSA4Xp9MQ>
    <xmx:QgLHZrJTKsdeps_BzxyVPOhBQQUQ19P-Eee4-DMyzK9DpVXOiUnjiQ>
    <xmx:QgLHZmWqHl1zd1nWjzuGSaIjPBtstdPODySYZaoAmazpI3TxsnMQvvmL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 05:17:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fffbd242 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 09:17:19 +0000 (UTC)
Date: Thu, 22 Aug 2024 11:17:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 14/20] builtin/fetch-pack: fix leaking refs
Message-ID: <aac84c5a2b7822983822f4b9dcfd65af0e808208.1724315484.git.ps@pks.im>
References: <cover.1724159575.git.ps@pks.im>
 <cover.1724315484.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724315484.git.ps@pks.im>

We build several ref lists in git-fetch-pack(1), but never free them.
Fix those leaks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch-pack.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index af329e8d5cf..fe404d1305b 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -46,7 +46,7 @@ static void add_sought_entry(struct ref ***sought, int *nr, int *alloc,
 int cmd_fetch_pack(int argc, const char **argv, const char *prefix UNUSED)
 {
 	int i, ret;
-	struct ref *ref = NULL;
+	struct ref *fetched_refs = NULL, *remote_refs = NULL;
 	const char *dest = NULL;
 	struct ref **sought = NULL;
 	int nr_sought = 0, alloc_sought = 0;
@@ -228,19 +228,20 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix UNUSED)
 	version = discover_version(&reader);
 	switch (version) {
 	case protocol_v2:
-		get_remote_refs(fd[1], &reader, &ref, 0, NULL, NULL,
+		get_remote_refs(fd[1], &reader, &remote_refs, 0, NULL, NULL,
 				args.stateless_rpc);
 		break;
 	case protocol_v1:
 	case protocol_v0:
-		get_remote_heads(&reader, &ref, 0, NULL, &shallow);
+		get_remote_heads(&reader, &remote_refs, 0, NULL, &shallow);
 		break;
 	case protocol_unknown_version:
 		BUG("unknown protocol version");
 	}
 
-	ref = fetch_pack(&args, fd, ref, sought, nr_sought,
+	fetched_refs = fetch_pack(&args, fd, remote_refs, sought, nr_sought,
 			 &shallow, pack_lockfiles_ptr, version);
+
 	if (pack_lockfiles.nr) {
 		int i;
 
@@ -260,7 +261,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix UNUSED)
 	if (finish_connect(conn))
 		return 1;
 
-	ret = !ref;
+	ret = !fetched_refs;
 
 	/*
 	 * If the heads to pull were given, we should have consumed
@@ -270,11 +271,14 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix UNUSED)
 	 */
 	ret |= report_unmatched_refs(sought, nr_sought);
 
-	while (ref) {
+	for (struct ref *ref = fetched_refs; ref; ref = ref->next)
 		printf("%s %s\n",
 		       oid_to_hex(&ref->old_oid), ref->name);
-		ref = ref->next;
-	}
 
+	for (size_t i = 0; i < nr_sought; i++)
+		free_one_ref(sought[i]);
+	free(sought);
+	free_refs(fetched_refs);
+	free_refs(remote_refs);
 	return ret;
 }
-- 
2.46.0.164.g477ce5ccd6.dirty

