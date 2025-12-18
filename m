Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB63332143D
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 06:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766039312; cv=none; b=C4YBE57GMUXj6a/iOFSWq+8ymAc2gxXu45XsSJfPYhq8K6cPWo/ef10n5Gfg6XcAvYcoukyammS2vEFnk+cIionFa7l1g/YvTVPaXAK2Iu+On6I+51K21CZMqIHjhsGXQNT2OwQ0JWPJ8qYrEfvyO/eV9hR29GOxYWiCA+LBHpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766039312; c=relaxed/simple;
	bh=qmPKie+CGiyK33dFSbsKjhavzvzPRsOG41a7IH+poqU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o9YiFMwQu8CNJt1VtEByqM9dRc1cOmZY5td0QL2n997CNohbi8dQ/rXJuW8SDVO/PJL+IujkOeKRvjcyqer+2XrVMqVjPblpHwdLxOe8t1BeOM1v9jcFn7na+CLtcbeJ0yPIVYm35jXdzQ/sxLZbROTF6V6DqJV/Lfq62JOIdrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gclgByWL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y1+E5Iak; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gclgByWL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y1+E5Iak"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id E03AC1D000AA;
	Thu, 18 Dec 2025 01:28:29 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 18 Dec 2025 01:28:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766039309;
	 x=1766125709; bh=xs5ISlp9IkD+fQZf5FRtvZm0JSPmADK9sVNgakmGca8=; b=
	gclgByWLFgXwTnyjlK394OcNoMw41vlZcDjzWdJLfIlZfmlYCeuiFTasL8e69pxE
	QTc1gomyJKp4zcG70MKGy18HNE3qtcAIi9vw0Dl6OKYm6AIJPEc3q0R3cE+Vm6wR
	IyTu0FX54td5975pPPv8Hkzkr1CxxhC+Ibizm0In/dfxC94XIonBsh2zHNxb8mlX
	1K1V4OxJTaSHScWOAhIYcmo9c/WD6gEPtgQIqjTc+7HBF2y8zv6otHK55A0ErN4W
	DxjUVUmklfvO2YVG0Bboiaxk5dd3AJ3L+1RSLjRYauT1hGyprlilcnjmeLcswV7e
	mgz8PwY5wcPHhFZQ8MSrGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766039309; x=
	1766125709; bh=xs5ISlp9IkD+fQZf5FRtvZm0JSPmADK9sVNgakmGca8=; b=Y
	1+E5IakSisTbJ3Ir0eSEMkidTmoppgF6Z88ia2TKafe1HKusv5kO4aSx+NRqtTxf
	gYN71UpvdNePApWjFASIqrYfSqh7C+A9I/shMTlbnrcL7buybqV+zG/EuoIWNlfa
	xV6krp9YXl23BuaU/SBoVbLr6qz62KBvcI6qpNCP1RYi5JBVh7RA5RxcIBOuxSw1
	n2EDak6qMZYkFM96awiK6NW4k+L53KQT4b6Fm+wLVqDd5WyOpDxIROwrN/UCbQOt
	b1NL8ubw4mHXgNhvPHXuK2mNrDzA22DiIan3jb7pTIHKC/DTQPmk62WHef9oeaWR
	zOLvBf59C+ES67LajUZxA==
X-ME-Sender: <xms:DZ9Daf2UGrQrZ2BSZ_l3qEYjdCtg-kSlukyjrQUJo_6xVHtzoMYTZg>
    <xme:DZ9DaVi1OgKmg2GfvHgflbsNge0K4d7SHTqFGQrS8JPLIwTHdxEe_i1l3VkkrpZ8-
    ODv9MY4gmK5_hR4H27MOaVSIVuCn4SJc0EEPqTKtTP3Kmt7ug-G6TY>
X-ME-Received: <xmr:DZ9DadROimMDp9c8R5heTZ5YRX7I3Hibs5Vpp6_2iR9Sd8UY_HdL2g_ZsCdeuJaFeYV7P8CFcXCtHHBOQ_5T3D9vQ1YXogk1JjBibMsFTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprghplhgrthhtnhgvrhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:DZ9DaeiL8BAUvB90gMPrZ96vcRptU60MN90bRkfebCTFYCIeKbSfRg>
    <xmx:DZ9DaV59X-iK9tecNIk16yJZQGpzykKgdVSRNpzX_WUGmA2PsyDGCw>
    <xmx:DZ9DaTBWhNyfI5mzUmxBgRzxhmrxFr1a7BsrVsdsqKwDnGIjwFpUMw>
    <xmx:DZ9DaUbc2ku3j48lehvGFx4uoLhLarKa_QytQPyc62wFGBksoHTJjg>
    <xmx:DZ9DaeJTnVUvP_oFXTfkFV3KJQhItYM2jkuFpCgHZ7UWSs6rzfBkq7uu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 01:28:28 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7dc86662 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Dec 2025 06:28:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 18 Dec 2025 07:28:12 +0100
Subject: [PATCH 2/8] packfile: always declare object info to be OI_PACKED
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-b4-pks-odb-read-object-info-improvements-v1-2-81c8368492be@pks.im>
References: <20251218-b4-pks-odb-read-object-info-improvements-v1-0-81c8368492be@pks.im>
In-Reply-To: <20251218-b4-pks-odb-read-object-info-improvements-v1-0-81c8368492be@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Aaron Plattner <aplattner@nvidia.com>
X-Mailer: b4 0.14.3

When reading object info via a packfile we yield one of two types:

  - The object can either be OI_PACKED, which is what a caller would
    typically expect.

  - Or it can be OI_DBCACHED if it is stored in the delta base cache.

The latter really is an implementation detail though, and callers
typically don't care at all about the difference. Furthermore, the
information whether or not it is part of the delta base cache can
already be derived via the `is_delta` field, so the fact that we discern
between OI_PACKED and OI_DBCACHED only further complicates the
interface.

Drop the OI_DBCACHED enum completely. There don't seem to be any callers
that care about the distinction.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.h      | 1 -
 packfile.c | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/odb.h b/odb.h
index 014cd9585a..73b0b87ad5 100644
--- a/odb.h
+++ b/odb.h
@@ -330,7 +330,6 @@ struct object_info {
 		OI_CACHED,
 		OI_LOOSE,
 		OI_PACKED,
-		OI_DBCACHED
 	} whence;
 	union {
 		/*
diff --git a/packfile.c b/packfile.c
index c88bd92619..79ad9d7179 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1656,8 +1656,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 			oidclr(oi->delta_base_oid, p->repo->hash_algo);
 	}
 
-	oi->whence = in_delta_base_cache(p, obj_offset) ? OI_DBCACHED :
-							  OI_PACKED;
+	oi->whence = OI_PACKED;
 
 out:
 	unuse_pack(&w_curs);

-- 
2.52.0.351.gbe84eed79e.dirty

