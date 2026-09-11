Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9574766B3
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 13:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133255; cv=none; b=PXpUnoquA55bWeX8zOXmRjFgN6BkIkscOdvgeDmC6POhsW485JVlzQ2vAyuI0k1PrKdXt12aFwZQv64tGaSTuXmzlfaGAEG7h6XpmC2BFyDVlCrY+LdoKTnjo/32OKWjP98H5fq7qyw5bzNk3zzPg8gU7A0Zk8RaY/S/BD7m2RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133255; c=relaxed/simple;
	bh=lSFs63FiGic00bUuLCGgm+QcyUowKikqjUvC+X2wU5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=quzcoBrzxQN66YiCWsx4yLcxQFu5QyXIh5v9NnVuHrbArNimuKj9wSD/u9CFDDdIGOcwI1hDCvx6F4zNA9OM0ZKoBOqwQ23Ol/1ahwJp2LmlYHFm9r9cBqR9o/JQZ6cmoi48U+gWAEFNJzVJcavIk8r+cnHasMGcUuzmyOFbFFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=se02o0qK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EWdQ2QB9; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="se02o0qK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EWdQ2QB9"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id AC616EC0207;
	Fri, 11 Sep 2026 09:27:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 11 Sep 2026 09:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789133253;
	 x=1789219653; bh=VbOhh6QG1vb1uFKRp0OBMiREf/eGQLyMfN0tMm7B8VA=; b=
	se02o0qKL0IYUi8jROcM027mJ9m+Yse0CP3mqxea1fni1soBoHtK1JMXHYvo8Jv6
	vB66LSbuSP27+5+Cvy8jrXe0lYqpZvCYsdcbj5PBdYfHM81HPXY/OA0SADOCoYSE
	viUkC38B/DoWJNZf9Jqr1+pvYnSd2KVnuqOAY+DtKA9HhU6Os2Ayc6AU4UZX44Z2
	3Rdh0E/hYscoiAsf1y5NL1nrsUYA5jjHAA7mdxqnH1lYqk+HxQICYQGf7Xm9eEo9
	KoBIvqZQL7EnpR+YX0sQAwd8QaSQ1cHV6zTQO7azkO64vL3XV9iI2zr5IBcxdXZm
	TqaQbCVI1B7jETUxWBlWJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789133253; x=
	1789219653; bh=VbOhh6QG1vb1uFKRp0OBMiREf/eGQLyMfN0tMm7B8VA=; b=E
	WdQ2QB9OBHiXbF56MxGXyc/AETFCcxSpjPj0wQGtMM7HnxkgOWUDwmfIdPWDqv2I
	uXNwqyWZZAcBDqbPwu3T41p8mqtoE3kJaXmN2w15yFDNzoUpMj73U/U1uwOlbfE+
	a/XPnG96tbBhya9FgL45spmEZV9vwxRMsXSuTQSgkTbuCLPcSiIN0YHqaJdk2MGX
	T3Orddj3WkqFwGuQY8vQ7WzkPTEpLq3hBSNnJMe8EO0cxDBSSCF1JLY0outsDO2s
	D/AcJNppfRjzHftPaxBw2EIRrrBY0lAEKYV0/7Wc2CI0QCIw2etP41QtNfEpdqki
	KEuS/mwCTQDvVIFqCxnww==
X-ME-Sender: <xms:xQGkavRf3dSgkfJ3R7LeHysgYChm-Gng-aQ8kFLoz6b8XwVXdP8trg>
    <xme:xQGkaoMKOUViznLxqS--u0zPQ12FemCE4KrjEYRwhtgtZ51XUjl4gLtScQgsBNVeK
    G1FvTAcoH0xvmTz8tAjmP71k9CZApMzjj_zqAzBReoF761excQJmA>
X-ME-Received: <xmr:xQGkaiM0_TcX3jWx7lKuEOPofQ9A0kAILT8Xb-BwjW-zDwan0xNp5A86w3mp_jCM-70l8g>
X-ME-Proxy-Cause: dmFkZTFhKNTY4gaJzL8unHorI0O2mIjovbOSn/bb4FfWdQC69pOMNnSpJupj+k3b5RRAEh
    CKbErTW3WczRhRJwwrJkvaRsvQIzXEXE2C+BN/DKoL4Gbfz/Eo1tEu7eUCGtvI2UYkaIkN
    pdzF4Cl414GlPSVfplCLhQTY1vxDPnsAjpUCtDjPcnIgviIidiwFFMtURzMpzxs3Vu7cEM
    3nEkQWJ43K7d/I7qMYYZ6hxKZuNC1lSeitb76YKd6w//fOV1p7l3EElcNKMWcMdULICz/K
    NpH5skcEvh10Ou1QeaUv5hQYKlpJ4gF4a0EGGL8oCdZIc9NRujjRUNoZU+qfCLCaHmP9Rd
    VjefPGwqrG0KMO3gmwmgIAqKzPORwhhM/xLf+JWD78tJd5jbYRIMlZszLdPHvD/xYaH3Jx
    pHUb3koZW6dzX/NjXnwOsUZhOAFtZjYRjuDmvyhM2imwMUVleRHYG7yKUUZjNMWM0oIfZM
    QZvpRTyDb8AuZWn3pIeHPHsFegjW6LXXwmT2k+lOi9iLj1mUGkVMDSs/ceAdCbyMteHRH2
    RcQ0Go1rSv4BvoR2QKKQ80m3Jq+njqTM6qybBGL0JtibocuYtt4kLnfXURKixqrfWYnHqE
    97EiqVCmxQluPotAm4VLoaj01QJ8SyLYCVnlWrSwKRhu1V70H0TanOkq1D/Q
X-ME-Proxy: <xmx:xQGkaosotaYQ3T-xgzKzZkXUdm48htxB-dOAwEcrUavi7_XDmozxFw>
    <xmx:xQGkasWgFBLLW44ldMnCeHLg4-odFbiuKpVostvxXr_1pFISu5a1wQ>
    <xmx:xQGkagvzZlGgJYRD6ogrHR5-u8Z1-KpVK2UUDBP4bujJqjt_ZWVsdw>
    <xmx:xQGkaoVnKC24qFLVobkwtMIHgpz7FPGgzyBaR5kiJSYAh1XKOR_Eww>
    <xmx:xQGkaoPWyLIEfcNRsF1nYb3ygOl5GC--Dfs2CWhmLBm-Womh9VVvprgt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 09:27:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a26964d8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Sep 2026 13:27:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 11 Sep 2026 15:27:25 +0200
Subject: [PATCH v3 01/10] builtin/fsck: use `fsck_obj_buffer()` when
 checking loose objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-pks-odb-source-fsck-v3-1-ef2fdc085e38@pks.im>
References: <20260911-pks-odb-source-fsck-v3-0-ef2fdc085e38@pks.im>
In-Reply-To: <20260911-pks-odb-source-fsck-v3-0-ef2fdc085e38@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

When checking loose objects we manually parse the object buffer we have
read from the on-disk file, mark the object and then call `fsck_obj()`.
The exact same steps are also performed by `fsck_obj_buffer()`.

Stop open-coding this logic and call `fsck_obj_buffer()` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 892c5661d9..3c4127f4d8 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -722,7 +722,6 @@ static int fsck_loose(const struct object_id *oid, const char *path,
 		      void *cb_data)
 {
 	struct for_each_loose_cb *data = cb_data;
-	struct object *obj;
 	enum object_type type = OBJ_NONE;
 	size_t size;
 	void *contents = NULL;
@@ -751,21 +750,7 @@ static int fsck_loose(const struct object_id *oid, const char *path,
 	if (!contents && type != OBJ_BLOB)
 		BUG("read_loose_object streamed a non-blob");
 
-	obj = parse_object_buffer(data->repo, oid, type, size,
-				  contents, &eaten);
-
-	if (!obj) {
-		errors_found |= ERROR_OBJECT;
-		error(_("%s: object could not be parsed: %s"),
-		      oid_to_hex(oid), path);
-		if (!eaten)
-			free(contents);
-		return 0; /* keep checking other objects */
-	}
-
-	obj->flags &= ~(REACHABLE | SEEN);
-	obj->flags |= HAS_OBJ;
-	if (fsck_obj(data->repo, obj, contents, size))
+	if (fsck_obj_buffer(oid, type, size, contents, &eaten, data->repo))
 		errors_found |= ERROR_OBJECT;
 
 	if (!eaten)

-- 
2.55.0.1074.ge7621b4bad.dirty

