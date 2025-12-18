Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2282EB874
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 06:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766039308; cv=none; b=mUqCpsJRFPgDfEGnZg8GzqrbY0rhSDmMIba07Zb1mCTO+EzT8EABW/a32bSP67iwCishg3u6qunC+forgBDGLrkN6AK8ENfDWASid6IHFfwl3EfRo5mz1E5WT6ZWGKLYAXREnDqWrS6GZTCMygZXTNqdKXZOoP8wxRCByGD7Njo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766039308; c=relaxed/simple;
	bh=Q/4ytM07GSjJJhDKbQ5pAGNHe5MFY/3YVhkjVBRD3PE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ObZaFMaf7buP6UnKSMR5wG5M1QTtJziDtNl/TMq9e4OGJ/fSpT4+deUN+xpgcVcZNg42eSWiIImoPn8kQ2x9X7hE9l9Ral0jiCIpHFSeeTvYICkEfSi7VUvTxAELALOXbTV21wSqwU4wQN5bHMkcZr8sLvr2uDPMwyvnKgXXhiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qJmA9VdX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SCl2HbNA; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qJmA9VdX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SCl2HbNA"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id B5DA91D000A7;
	Thu, 18 Dec 2025 01:28:25 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 18 Dec 2025 01:28:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766039305;
	 x=1766125705; bh=54mj5Aygw1jiewZJMyYvO52F4IzJZQDnQCsoxFvPi4o=; b=
	qJmA9VdXd0anC7EB4M4hKlz0i1JlcIQi/G8qBdg8EGAPA6wij+xQJs27jaNn54Yl
	aLchz3el5rkCpKOgjApONvJ+bJcNZx5miiirAryQNLRvYXjJv8gC/NiKl8xs+8fx
	rLfehQ5wcyQ4KEAHzhNbyfT6hi2iPQatVt1QbSqFha+DcX+HPpktU+pzQ6zIUrcC
	zdkpWBxX+9m0EZEZ8KVFgQYyaH5aSaez1h8qVOEnRQ0zo4S1wwDx03pFv1YZpYSl
	mHOeUn6PeO+yRQGTEhFR+V2q4PSG3frbN+lenovfcnZgivFDLe58dtpry7NCXLv9
	RHCcd9Uiw0FKOcPhgcbuDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766039305; x=
	1766125705; bh=54mj5Aygw1jiewZJMyYvO52F4IzJZQDnQCsoxFvPi4o=; b=S
	Cl2HbNATue3y35uUcvqpbIUwbvADEMntbdU4XsGCzYBqtPwnR7/6SaQFWy0JKKVo
	38KuRXjyI00TDUbzEFjcRHcNnMSk8mwQoL3mBDSJYndnqR6Jlb8zy5hSoRpYzfxk
	UWG0WZfSJ1g51NjEa8plnYhm2Sy7oQWZwAyWHA3HN5hLaR/0cwe6jxjjfHZ7WYp6
	/RUpzvIkpbM5FCQH4F/eRbp1+o+d6pfziKH9qm1pAmgSaZh91Gpl2jAog0h3xzt4
	cthSzS1Ymn795DEfZO/6tTziINnahtOKnzqIipJXzsy1DmB5OUYTwLvVyPPleaxC
	UAORCkG7SSAgd5Iar/FZw==
X-ME-Sender: <xms:CZ9DaRE39erke44uGcQmEsbV4KCl4-9ecsrD2VqhuAMRTiVCplpxEg>
    <xme:CZ9DadyvX43QG-2E2y6W_qM_jb7248qWwA7xS4Kcd39LPBOn1E0kIVdeZ4aEtz8lU
    _r2xHoS6_p_K-0a9ocYNA-qBiPAadPZ7sDc6WxdFnP1kaqJMA4W>
X-ME-Received: <xmr:CZ9DaQiRC0VVRh6sAj9E8yvYX2z6ThdgMMsmFyBQ8_mpm8JGRZidwNwrety6e7GuXq4iru_HXeiMBahEzZGB0LLySvnHoN8bHUKbgq9XMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrphhlrghtth
    hnvghrsehnvhhiughirgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:CZ9DaQx0ZFZUb_DwEE4DXvb8ZARcmKP7q7Yt0ayXa6jGNLUwJvLpUA>
    <xmx:CZ9DabKsedbmpesdOsKIj6UgQz9tBECdSLhhg3j6QP5_Q1oj5h-Ksw>
    <xmx:CZ9DafT0nz1DOrp3wnb4arnyMLkOuePZH4zD91e20GGB9XWvyH0XRw>
    <xmx:CZ9DabqN8clMPbkOn88QaCyRbZOTBYHcKPBFC6dDAeb-tXivLqPs8A>
    <xmx:CZ9DaYa-FYPe43k7t5mP2T54UOk3PLQqWw7aRv5BS6QxhmT1NwL_YQsd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 01:28:24 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2e37e326 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Dec 2025 06:28:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 18 Dec 2025 07:28:11 +0100
Subject: [PATCH 1/8] object-file: always set OI_LOOSE when reading object
 info
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-b4-pks-odb-read-object-info-improvements-v1-1-81c8368492be@pks.im>
References: <20251218-b4-pks-odb-read-object-info-improvements-v1-0-81c8368492be@pks.im>
In-Reply-To: <20251218-b4-pks-odb-read-object-info-improvements-v1-0-81c8368492be@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Aaron Plattner <aplattner@nvidia.com>
X-Mailer: b4 0.14.3

There are some early returns in ``odb_source_loose_read_object_info()`
in cases where we don't have to open the loose object. These return
paths do not set `struct object_info::whence` to `OI_LOOSE` though, so
it becomes impossible for the caller to tell the format of such an
object.

Nobody seems to care about this right now, but it's a bug waiting to
happen. Fix this by always setting `whence` on success.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/object-file.c b/object-file.c
index af1c3f972d..716b325669 100644
--- a/object-file.c
+++ b/object-file.c
@@ -439,12 +439,21 @@ int odb_source_loose_read_object_info(struct odb_source *source,
 	 */
 	if (!oi->typep && !oi->sizep && !oi->contentp) {
 		struct stat st;
-		if (!oi->disk_sizep && (flags & OBJECT_INFO_QUICK))
-			return quick_has_loose(source->loose, oid) ? 0 : -1;
+
+		if (!oi->disk_sizep && (flags & OBJECT_INFO_QUICK)) {
+			status = quick_has_loose(source->loose, oid) ? 0 : -1;
+			if (!status)
+				oi->whence = OI_LOOSE;
+			return status;
+		}
+
 		if (stat_loose_object(source->loose, oid, &st, &path) < 0)
 			return -1;
+
 		if (oi->disk_sizep)
 			*oi->disk_sizep = st.st_size;
+
+		oi->whence = OI_LOOSE;
 		return 0;
 	}
 

-- 
2.52.0.351.gbe84eed79e.dirty

