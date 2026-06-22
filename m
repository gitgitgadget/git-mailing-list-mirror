Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AC93385BC
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 08:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782118183; cv=none; b=bB911r6cyw0Qb0oPmxPnKldMHoqCFXlVVq2AEEe8nNMvVz96x/o7nh52TzHCExrNkXZd28sdTcEceC5b0z7IiFckyykc9jRXvuGiFu0Fq93UH/lH+L/myLMGq1hNKhTuJNvf8vhUje9JfoZnybJx18E8bTGQuJCHaCStuQfvBWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782118183; c=relaxed/simple;
	bh=7LsvhsL2WRoliffsEJOLHkuB5qjm/eNRhmXg0RAN49M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DfSloNR/ivWmwssuggJzlaGLXZ3o3OGFwjrqbO7adN8FmaR4ZSY8QiM8fIB0QNt5HCLkbnzhVpjcxWHHWwlaX0YN7VBjMiv4YY8C+Vg2vGBugR8jjS8+5Dyshd7IkJopsYB1MXkCygBlh51GOC0VR0xZ0iQp2Dwje9XHIBZ6L+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nq2o6qcl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iV82h+L5; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nq2o6qcl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iV82h+L5"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 7BC871D00071
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 04:49:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 22 Jun 2026 04:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782118181;
	 x=1782204581; bh=4GJ/BjjMm1G6ehWPIefp1K/En033vFw+K2fnDmrgNPw=; b=
	nq2o6qclIN82gDiJYFsmcLI2G6O1W8y3oxmpprS0q9KDSpjx+FaS4kefsmlXsaPT
	9HfbBgrNXJcDHxzeeRnAoxUZ7BsjS92eiVqruU6x3/5xszH3cisFC7Z4KY3wRYNC
	EJLfp2FTvBLNsPvcmFNLO0m35yl85ZxXx6zlk8J31jN+nMdswqa6e+0Y5pQyjOz0
	HHdvrtQYFoEfurHqcZq8pxvLhhATOMv5RXPtMeOiDFhBDQFy+GfI9g0GzNqpndxr
	/6QyGR/XR8ojPboSZ4Km2J98/GUJvN29bwAIt3qjROrXYjYUt10bFJNS6N7BNTF6
	zyZ+nFA5nRpPZyo5e2r0fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782118181; x=
	1782204581; bh=4GJ/BjjMm1G6ehWPIefp1K/En033vFw+K2fnDmrgNPw=; b=i
	V82h+L5idFFoxL9XthbyXORGb8uZNEFHiYgW2r/es7SjxzoU7leG8ecRDpHre2NG
	nVqBYNj7GDoFs0PlCFOiiQIrIEsfK/C7ND6WZhv1jgwtw7NZSXk0Q3NtCHmW3TZM
	pyjP3DB6Vx+tx4fM322GaZnNiWwEuxpc92HmJIeFFAYgY55xLkOU4lvhZgHVkLNK
	LziWLgOgomNSF3TFrxcbJaZuq5ii7ifWD2FZt+JRofpMSop6NmAf5DLyHGohbWKL
	LHfGhllN5+wTEJ274PFjiH/JlSlCnCba+56ytRKheKaPrVJrAATyv9lQ3Fzl8yhE
	g/PjTA1pDmH0qSRDzA+pA==
X-ME-Sender: <xms:Jfc4arIQpyfuQ6QSFJKGbx52qKvuynKNCkAyOSscTadQleCi_tT1Hw>
    <xme:Jfc4amEc2mE3-CKYQ4gxDxfCeyGISTGDGMrMOXn6rNo11_scqVkaoDQcxcktOgijT
    7oaf-urlZNSkf9Zu-5YPOarhfCN6odcv7N-v4BwKfqJ-nWS57DHOg>
X-ME-Received: <xmr:Jfc4apWm62KAQZPEON0YL8kPMivSX5IJ32R_3afDshO81R7gPXJUw9Vm-uJmlqdxrPxUR8uZUhWwfFW-4KB4KI7vjYvD0krmxQCgHYa2yA>
X-ME-Proxy-Cause: dmFkZTEOnajbKOjPDvzPIuSD6qi/CT4lxSKsp/grLoo+rkJBbIcbiK4GoLKyEODVuxYFKg
    Ua9MbapOYi58Bwzv0rDKaK6aGXCi6K3Uz/d7bTlu9te/pFqeZJ5TRoWQGRmLd1dVxgWmZn
    Vgb5EZZVJvJ7qbDwBkxlUt+c3nBAZJfAOe1r5YwrQDC5mIEpZTlaU1wiLGLBIVUJjiNYCX
    2PYvpXpc1EhP64Lnq4+sbRWpC+xDeUMiWDfLVCnHJN89DHIvNVfAIOZrKlZEA9lL6kicKx
    eUU1+iMrHMbXepB5nnaTwyeDj8GM+uEqMUbUnRU83HO6B8ETa8cKoDaUfnYHdN+vdmxeH/
    H4Q353l2t1O9jLy9EDzT+zEvc/nT1bMa5BxWn0/XOzRsd3mvTDIo1L0TExDNBIz2vrh/ke
    8Wslwybi2AqWhxJ8ZxLml57R5zl2Pjo0vQFVpRtg3IHNtB5pRR4tyTAa9KrTA6bvuNpRXl
    1vD1lAn5SM7mTOIlMm2hzYHFv/ZNUCkzwKyfK7F8n/B76M02HBLzpwIy51Zg4mrMJHW2Bw
    G7Y4Aua/V+N6WluaEHQ4I/h8CU91iEeodFq2QdKGBNKVc9jwWXdoxO01Xx2S4uC3HH93Fk
    +Sg15gx0uBGCIDuJHF948LOwyuolctlKIOVI6wgmXM7QRfJ9JEsujyxDFnyQ
X-ME-Proxy: <xmx:Jfc4aphM0QWx2q-WqRlysRVdVvvARKiv5h3P59wYjAE8uENsPRphCQ>
    <xmx:Jfc4aiQiM5IB4TxxOz5dja8taGYI9FeJcim90cTRNkGEfWGzdDr8kQ>
    <xmx:Jfc4akHOTKN6pspCPB9zPFRRUyqbrrn1gupdrP_Z7ZOAgASHhObFxw>
    <xmx:Jfc4ailB7Rn5Ew9suGrjGMxPBTzQfWBRTNK2fE538TlP0mD4kQLb4Q>
    <xmx:Jfc4agrykTN8QdFVaRl0YpfM5R3fnl85u4fSmkzNI4-19ZhyHmRtSLiK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 22 Jun 2026 04:49:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 631114c9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 22 Jun 2026 08:49:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 22 Jun 2026 10:49:28 +0200
Subject: [PATCH 2/3] odb/source-packed: support flags when iterating an
 object prefix
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-pks-connected-generic-promisor-checks-v1-2-25eba2698202@pks.im>
References: <20260622-pks-connected-generic-promisor-checks-v1-0-25eba2698202@pks.im>
In-Reply-To: <20260622-pks-connected-generic-promisor-checks-v1-0-25eba2698202@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Callers of `odb_for_each_object()` can specify an optional object name
prefix so that we only yield objects that match it. This is incompatible
though with passing flags at the same time, as we don't yet know to
handle them.

Loosen this restriction by calling `should_exclude_pack()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-packed.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/odb/source-packed.c b/odb/source-packed.c
index 3afc4bf01f..6f31f0ff94 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -148,6 +148,7 @@ static int for_each_prefixed_object_in_midx(
 	const struct odb_for_each_object_options *opts,
 	struct odb_source_packed_for_each_object_wrapper_data *data)
 {
+	bool pack_errors = false;
 	int ret;
 
 	for (; m; m = m->base_midx) {
@@ -171,6 +172,20 @@ static int for_each_prefixed_object_in_midx(
 			const struct object_id *current = NULL;
 			struct object_id oid;
 
+			if (opts->flags) {
+				uint32_t pack_id = nth_midxed_pack_int_id(m, i);
+				struct packed_git *pack;
+
+				if (prepare_midx_pack(m, pack_id)) {
+					pack_errors = true;
+					continue;
+				}
+
+				pack = nth_midxed_pack(m, pack_id);
+				if (should_exclude_pack(pack, opts->flags))
+					continue;
+			}
+
 			current = nth_midxed_object_oid(&oid, m, i);
 
 			if (!match_hash(len, opts->prefix->hash, current->hash))
@@ -198,6 +213,8 @@ static int for_each_prefixed_object_in_midx(
 	ret = 0;
 
 out:
+	if (!ret && pack_errors)
+		ret = -1;
 	return ret;
 }
 
@@ -260,9 +277,6 @@ static int odb_source_packed_for_each_prefixed_object(
 	bool pack_errors = false;
 	int ret;
 
-	if (opts->flags)
-		BUG("flags unsupported");
-
 	store->skip_mru_updates = true;
 
 	m = get_multi_pack_index(store);
@@ -275,6 +289,8 @@ static int odb_source_packed_for_each_prefixed_object(
 	for (e = packfile_store_get_packs(store); e; e = e->next) {
 		if (e->pack->multi_pack_index)
 			continue;
+		if (should_exclude_pack(e->pack, opts->flags))
+			continue;
 
 		if (open_pack_index(e->pack)) {
 			pack_errors = true;

-- 
2.55.0.rc1.745.g43192e7977.dirty

