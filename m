Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2D335B14E
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 12:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962405; cv=none; b=n7ldFvFlR8v0rBWomSC6X3+f9ZaWxMEmOTJjLcK3WAGXYLbAq3B5HV/XZmHRWWqAmMQAx9mujbBwzDI2abRuJVJ6n2FcZz3TbK6Ztb8WuepSJ8pNDvZSi5pdfitgEZTY9jAcPdp2Bi50FP7Y/KqpT7FZAmQ43cD8hlpqHo26wYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962405; c=relaxed/simple;
	bh=ka5F7aFMAypwkRALcGF1My5BLKhjxeQU6YbJdvcYw2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kSFEcYT7a6wUJiaQS2wEkD8yVYx2aejFJs0npFvxxrdKagY4GfffnFKB8pdn8UnUwjzpQKRFPRCsBo4bBYP0DOMe6W/NtKS5KSHWYsUdABodxoMNg/h1rr3DRQ2GrC5HamNR2uRgdUAUYkVmrm2FXhBQqUGiwJwfuj44096Cgh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B4c/6909; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gbrPA4or; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B4c/6909";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gbrPA4or"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A24907A0170;
	Fri,  9 Jan 2026 07:40:03 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 09 Jan 2026 07:40:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767962403;
	 x=1768048803; bh=YmvGaZel2yPSLieQU6Wq3JZ9KY5szaebGGsCA6vElRE=; b=
	B4c/6909n6ry/Igz5JGfEPPlFEDjtACl285YhivCGQtSA6Yp1HqGHNybIEC1BUyV
	6UE1gfWiWJuJETM4OxYgU3rTaNWfmALoz+hL969Ffu0AcV2T+8ligT3+bh/harZC
	tgOJinUJtDppaKbHz9xXJmcT7R5aaMYHFHvl1qmA8rHsaGMTumNhoZpCnlK+u5KR
	OaeqYhIoORa4QJew4RVyAAFI+Vb2h+PpkBot5FoW7skq/E3RtXc3/WCAcCmswPCK
	AWjCsoYjYMKnUhgsBog5kPx2S/Td6TLvF+d6jnVFht6NjLRipsmGag4V1UV58k15
	3EOB6avR6IWO+Zr63Zqnvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767962403; x=
	1768048803; bh=YmvGaZel2yPSLieQU6Wq3JZ9KY5szaebGGsCA6vElRE=; b=g
	brPA4or+X7L2oJiyMRhIcKDT0yXahDyh5AZCYLKD8MGFwmGvwjl5DdBgtEnH5GsO
	3x/lhYfPk6FgYpXjl489j9dbS8NtxnAiUzhSFkIJtKqFEMzdLec4dY2xqJIh96k9
	2CM9coRyb48VkYxOkx0J8hUWMaIWtXrRLPqCAcuM4fehANovsjANOpUjJovSH8Nl
	70GpTKq03N4+DY5WSo5r2d3T38oSAetvin7RVICYZC3vy4wCjbv5IdZHTnGrecha
	Sn+4DSFjyneC2a1a81WXHpKypwu+QUsxNoXv7P0G01NTCBvHVT5j37hrmy2ISD7+
	e723L21OwFFWhW6lE8fNQ==
X-ME-Sender: <xms:I_dgaX2u8KglY4NvKf7eLlsBz16v0DftWcfLxlilcBarspTgpICVxQ>
    <xme:I_dgadiQTB74Dw49RRjVLRf3937nyiHw8BXmmZmc0tHYKNayv8THt3jsY6LdApBTG
    zjk8k93Mhm7YanMa0RNqSVkYM1t1Sn-4ORP6JeEK5KjhdUAg-qVo68>
X-ME-Received: <xmr:I_dgaVTEWbxt0E5aR8p_KIXmdONIJDBbVWXgBkwvlj9xrPggtqlJL-Es5tMILRosRLVaRFAc3iNRuPVjt-pxLQ7IGWTa3bTSrvQNwEle2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:I_dgaWiT1pZ2A3gb6qyUcIdvG8FqaNQdzeyyBQvDIi0g1sHYeMJpLw>
    <xmx:I_dgad6uDYAeWVQmk1jnn0Q8jLVOowSUI6jWSw0HmQe044FXX8i5uw>
    <xmx:I_dgabBpKJQB6CSG2ZwtKJw9edDtwt-Z7jnYWJ7BYz3Cfybkrhfupw>
    <xmx:I_dgacYpPOAEN0NGz815WMIYmwfD2aP-mV5d3whcgaUSkCy3ieZ7CQ>
    <xmx:I_dgaZ-2r66TtFBuXKXE5phL-hyaMYhMwL3vr_m9yZrGzbQZX8PZnqq8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 07:40:01 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 855fb71d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 12:40:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 Jan 2026 13:39:39 +0100
Subject: [PATCH 10/17] refs/files: introduce function to perform normal ref
 checks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-pks-refs-verify-fixes-v1-10-3587dba18294@pks.im>
References: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
In-Reply-To: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

In a subsequent commit we'll introduce new generic checks for direct
refs. These checks will be independent of the actual backend.

Introduce a new function `refs_fsck_ref()` that will be used for this
purpose. At the current point in time it's still empty, but it will get
populated in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c               | 7 +++++++
 refs.h               | 8 ++++++++
 refs/files-backend.c | 2 ++
 3 files changed, 17 insertions(+)

diff --git a/refs.c b/refs.c
index 739bf9fefc..4fc1317cb3 100644
--- a/refs.c
+++ b/refs.c
@@ -320,6 +320,13 @@ int check_refname_format(const char *refname, int flags)
 	return check_or_sanitize_refname(refname, flags, NULL);
 }
 
+int refs_fsck_ref(struct ref_store *refs UNUSED, struct fsck_options *o UNUSED,
+		  struct fsck_ref_report *report UNUSED,
+		  const char *refname UNUSED, const struct object_id *oid UNUSED)
+{
+	return 0;
+}
+
 int refs_fsck_symref(struct ref_store *refs UNUSED, struct fsck_options *o,
 		     struct fsck_ref_report *report,
 		     const char *refname UNUSED, const char *target)
diff --git a/refs.h b/refs.h
index d91fcb2d2f..61c56cca36 100644
--- a/refs.h
+++ b/refs.h
@@ -655,6 +655,14 @@ int check_refname_format(const char *refname, int flags);
 
 struct fsck_ref_report;
 
+/*
+ * Perform generic checks for a specific symref target. This function is
+ * expected to be called by the ref backends for every symbolic ref.
+ */
+int refs_fsck_ref(struct ref_store *refs, struct fsck_options *o,
+		  struct fsck_ref_report *report,
+		  const char *refname, const struct object_id *oid);
+
 /*
  * Perform generic checks for a specific symref target. This function is
  * expected to be called by the ref backends for every symbolic ref.
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 72c1db849e..e59794f5da 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3833,6 +3833,8 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 					      "has trailing garbage: '%s'", trailing);
 			goto cleanup;
 		}
+
+		ret = refs_fsck_ref(ref_store, o, &report, target_name, &oid);
 	} else {
 		ret = files_fsck_symref_target(ref_store, o, &report,
 					       target_name, &referent, 0);

-- 
2.52.0.542.g9473a8513b.dirty

