Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2703911AA
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 08:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782118180; cv=none; b=cr0e/IgXKMc7kGxV+e1d4z+OE2JtqO8MyZyzTL94OgSmh8TZTUBeAFy7968KNeYSPxGR9w01VFug8gJcoZ+7LW89gVS/1m6hU2L9AYr3FcpOo6URcT+ajAOiwmAD05yUzdhrvU4ikWZ7uSOw3l2dP3IXBWMloe0jTx2MWLA7Zy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782118180; c=relaxed/simple;
	bh=xFmm+2sKCxPRqJOGTlvIwl1Xkm7yrPlMtGK8KLrSRbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XKCJWRQfYiKn1FvYFRLrPDL0hdQF4d47ELZQf2cPcf0RJ8H7svY+YkwFI6LojGfVOoG7Yzypm1nOhPJ/ez6CJIykOoYt0jOcZ6k2oHnbsopHOhtF95wp24fsCYVasF+DITC0qswtLPEFMz2UhZv4iNfbe+qOvyzsD3HWHtfkWJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O9sUcpIS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JmxXCW8K; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O9sUcpIS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JmxXCW8K"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 83E8E7A00F3
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 04:49:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 22 Jun 2026 04:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782118178;
	 x=1782204578; bh=8C4BgYaCb4sBbJjCGV2unTq1+1QcltbgxNBiF/YQN7o=; b=
	O9sUcpISQZzHDBE+wDpkCYzGdZajJ8aP3x2gY+DIYlnR+KZ3Ur44GFWduoyUBu0T
	h5qDdniOVX9R6nJxlEIX+xA7ztfRL0WmCwasqm13WThc1FKvpksHBDatNW/hOqGO
	3PBUlS6FSfoxu1rD92NzVpnNXvj8DPXcist0zn9LWQnKqi6YU35p/V4H1zBguh8j
	fvvRfBsixlnaYoAW6nELJnwpZaOo3DBUNEq7y6EBw5p+qG24i88GXuRFZO3zgii6
	nsy/dyjILxgpXoS9QkjZiJlBABLtCxalVL+4fDlg+bpGBcF/uwz0AIv4amQs2yHp
	PLbWwjEi6C7d6ksblK9jvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782118178; x=
	1782204578; bh=8C4BgYaCb4sBbJjCGV2unTq1+1QcltbgxNBiF/YQN7o=; b=J
	mxXCW8KptEBkJuBW0aYtCzM8d+alhG9GIYVj5zxfo8SE21NesYsKUoFg4vdDhO0a
	mwyzGhQpt7ZglMZt20en7+BSClTgKHUzXz92QqYm64QylpuP/Yxpjbi1kG1FdQlQ
	+bTzc0Y0r4HN+kZok+PQXkhiYaWWxDEXz3ZMPg3ViVnVzvaChoY8d6wi2cymN1BR
	5vOMqpR8yj0Hdv9YNkHiuylQg8wrmUcA3fB9q1JnTIRtf9O2r53/wg8HQRmOZidt
	We4J81Agu65WbL4bb8kqc+A9gvkISWU2vzL3CuswiSceWdeCok+pAg5mPqrhK/QR
	G0yqgWR023s5Scm7vnIKw==
X-ME-Sender: <xms:Ivc4ah7I40K2wsTxQBDbSV51eupWDHBSYE0FeE9_5lJe4PXqYEpW4A>
    <xme:Ivc4al09D0f8kpzRtKoOtieKUDa_QdzucFrkYBdny0NGjdwXtNQOx3iD_0V0CVMXP
    6PCVUgbumHSBZxFpSeCYksiCIETEQIYe_51SwZUPgIACDTK-3JqKg>
X-ME-Received: <xmr:Ivc4auEZfabJod8SjGj3MFAxtCx_wwPFl1Hs5mi3BTnZezK2aYJo_Zyzk2z0BM4Tg_riCsUOSufv13VhnCd1wz6qWeZIXNaPzM4I5OxGAA>
X-ME-Proxy-Cause: dmFkZTGddb0btqHhhK9rF38XptAkNU6EWpEqiMeDmxi+3SvzuY3QdT9VGNWhXGy9knGVYg
    2nzTr95OpwVTNsKveiPSdiPnFOY6TMi1RL1WIWIM3+TWE4DETx8fsz/jSuzzGpbqSGcOZU
    ee6+iA65lN4FSxzlw3tz48UYC/Xt2u04s2ZhfS0OJzdv7/s3buBDD/+75Tv6ojArozg6w8
    HBroU3fiFB+nxXdUSBcAMz2GwboV1QcVN//uBFMuABVUDoq5qB8URVaImIfl99X1yq/vJu
    gUtPvPUneB0cbcvjV+GvVDkVrLNmkOhpzFOZ2C1w3CSPE7AfNikrQQgoc8orACUbZCFLA7
    vXy9a38SV3ILyZCHb7u6ARfuUqditeptWzEYYtoDR0ily5hOZ2dwAbO9pi42+lAY8Mu87/
    QhyVbMHxhb2nclFgpuI6UFS8y6X82VEMGUTZe8D23e8PHo2uo8oFQV9fGFVP4XZ3lSXqCu
    SNn96IcjtY1Cjz1aM1EtKrS2rRq3Xk8ML+lC0CRkPjN6IV+ozQy7qv0BbTzsqs8cwyFqcP
    uBDfB0kLB6MMR3OumQhlG7NQj+ySdKHM/ZkHfHPrxnWioeuBpLRIRz66ocxGt/tZGF785e
    kOBs6i90Snwh0sveeTZ11IH2cxUFsQxcR6+KsyNRBT7mZHd7k03a1WkvyUpw
X-ME-Proxy: <xmx:Ivc4avSrZaqFPLZr8P4UkMzq_3upWZ_iYA_sAMd0RTL-Q2BmOiYX9g>
    <xmx:Ivc4alBk3KPbiT16Yr6JhxSh_OOgD-SEzbqWtW_cKuCy0UzX7dIH8Q>
    <xmx:Ivc4av2CYWLEe_-r5ewtiVWVk9SxbrrGGxw0kXm0pSGGO_NWSOCxww>
    <xmx:Ivc4ajUdb7UncjX_p8fRLpvrnFq3kNDkIUJUcBPxz2e_6BoMQDycZQ>
    <xmx:Ivc4ambgrNvL7lr--ftOs1VP-s-xIrQkQUePMKolMyYCoI3UNUfWN_pw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 22 Jun 2026 04:49:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e9ff34f2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 22 Jun 2026 08:49:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 22 Jun 2026 10:49:27 +0200
Subject: [PATCH 1/3] odb/source-packed: extract logic to skip certain packs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-pks-connected-generic-promisor-checks-v1-1-25eba2698202@pks.im>
References: <20260622-pks-connected-generic-promisor-checks-v1-0-25eba2698202@pks.im>
In-Reply-To: <20260622-pks-connected-generic-promisor-checks-v1-0-25eba2698202@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The caller can pass flags that allow them to filter out specific kinds
of objects when iterating objects via `odb_for_each_object()`. This only
works for "normal" iteration though, as we `BUG()` when the user passes
flags and specifies an object prefix.

This limitation will be lifted in the next commit. Prepare for this by
extracting the logic that skips certain kinds of packs so that we can
easily reuse it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-packed.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/odb/source-packed.c b/odb/source-packed.c
index 42c28fba0e..3afc4bf01f 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -126,6 +126,22 @@ static int match_hash(unsigned len, const unsigned char *a, const unsigned char
 	return 1;
 }
 
+static bool should_exclude_pack(struct packed_git *p, enum odb_for_each_object_flags flags)
+{
+	if ((flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
+		return true;
+	if ((flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY) &&
+	    !p->pack_promisor)
+		return true;
+	if ((flags & ODB_FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS) &&
+	    p->pack_keep_in_core)
+		return true;
+	if ((flags & ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS) &&
+	    p->pack_keep)
+		return true;
+	return false;
+}
+
 static int for_each_prefixed_object_in_midx(
 	struct odb_source_packed *store,
 	struct multi_pack_index *m,
@@ -306,17 +322,9 @@ static int odb_source_packed_for_each_object(struct odb_source *source,
 	for (e = packfile_store_get_packs(packed); e; e = e->next) {
 		struct packed_git *p = e->pack;
 
-		if ((opts->flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
-			continue;
-		if ((opts->flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY) &&
-		    !p->pack_promisor)
-			continue;
-		if ((opts->flags & ODB_FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS) &&
-		    p->pack_keep_in_core)
-			continue;
-		if ((opts->flags & ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS) &&
-		    p->pack_keep)
+		if (should_exclude_pack(p, opts->flags))
 			continue;
+
 		if (open_pack_index(p)) {
 			pack_errors = 1;
 			continue;

-- 
2.55.0.rc1.745.g43192e7977.dirty

