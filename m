Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20B919D89E
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 23:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775001481; cv=none; b=bp29AoHcscXZYddnFEFEtHyrgc61ft7BJcg26rDSCpTjq02Ub8ObCNRb7HNWLAzxwDl0Z2D8Q4XbOR2LczLSxl6awfYbJVEGNi3FEdxBbsqwh3kddluiUWX2ZVo48RCaeQjKNFoIEUu1Cjq9HGZlKDzEoW4banOuFWdNLPzqy2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775001481; c=relaxed/simple;
	bh=jw7qon9uMQg82L/povEFRhlxSz7Xbqp5MPyquXW+m4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e0lLGb6cm2F0Cc9lSVUVB+n8dPGf/CYFnUn3M3002kAED1y+5HnHqObBlvrrFnHC6BMcC/ajGqxcuxAasy6hr9+E5KYP/RyErguT+6KpQgS/JqyNlBGoXImqhmmhIew3ECWNZw1kbb4r0q4Ec8hPh2NQmFovewDLA0gZIeYEYkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=v5LDgm1c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W9F3PD8I; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="v5LDgm1c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W9F3PD8I"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 382D614001F2
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 19:57:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 31 Mar 2026 19:57:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775001479;
	 x=1775087879; bh=Q7s7RJpj/UNf+ZdSMJPm1kMziqMs3/vq6s7Ea1wbd80=; b=
	v5LDgm1cqvaXRoVRNxBWG7cdTdyqf2hoxc6wA0PEXR88NbT4veWVtKDu4N8ZAprA
	KIElihhh5bFA8FeJQVBQsVw+gS2Chf9+fCipHxYDUGFzXeVLcMINx65DvdZLeVxW
	J0ex64kNFLWjJcQx0fM8Har6aKdE/XfUJgIis20HcGBCNM0Qte2ojC/TGsSUFzsO
	wOd/oiRj2LycHUxPTxQp9cZfsNMf4kSTAo66YVa2mmed31ubR6/mDRb6rGMFa72Y
	Xg/0w/Ab963VNc6cFlyCIyaGGgAo6fPmr09haTsasKYHYHpD3ODfMHrUkZDTs6n4
	G9mVft8ZdlUC72q4RgmJCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775001479; x=
	1775087879; bh=Q7s7RJpj/UNf+ZdSMJPm1kMziqMs3/vq6s7Ea1wbd80=; b=W
	9F3PD8Iq3MAKS7lUzEtGEiTgSk69VigJtykxfZoiq6QjsfB/OiSiLc92vvfKjHCQ
	KXkBGmHmLGt0DHY1qrXJGXjnpCNB8GuciMz6+hLnKHwnPTRAToQaPwZVXD4qeKIl
	9LV2tjNttujprJplaY+XnXEbG50Ekubg1GPeoO836KXTSCmOyev0O8lO2SnQh+Ig
	BfO/AHWWAzm7VCVSj75jh3w6stLFNj01tZTWX6BC5NPbo69WCMAAsYHlyO5r4nfW
	IhT7mw+zTV3CnOujVu546XWJpwjsCGaWIyF22LyVJ7ZtASEdrU2aR9PfQRj7nSY0
	svQG+HIz6pjeOQ6Y6KQZw==
X-ME-Sender: <xms:h1_MaQEvUnrhr_LVqMhuVcgRf4qa0FVvjOly5yPCkXfQKxuc6ek1Mw>
    <xme:h1_MaQT-xMTgUb2_TBZnhlUeYOu_N2QNZMAVBqI2y8SxBIjn4QZuEtVXwvi-S5669
    fkVBDLRxhnby8R6PiCzJCuQhi4wrBdee0fLEiHzhCMUvExHefghsg>
X-ME-Received: <xmr:h1_Mafwq6uNu6a5T_SVdGKVSaHj28VMGsvl6w8Dz97f_DJNIuwwMKflCA-MKYkMdqtzcWgE-T-mM8TgIZ57ECMG-kn0ZRGDAamMFA_J5fqE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetke
    duheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:h1_MaXM2GP4aDEu7MthrI_we0CHw8FDxXG93oE6my5tGOKwbej2F5g>
    <xmx:h1_MaWN2Y35ZUqFW3fHkVod6qdY0YkPRJRygd7lAkrx5ArmSRQq0ow>
    <xmx:h1_MaRRHpeveu8rvlcSQ8qtmpxE3JLRtpe-epjSKKa5bJA1z5aLtuA>
    <xmx:h1_MaQBFqsD3GGyUc3jcrIyLWEcZOD_vz0zH8wcxOCgxe4edKiqzVw>
    <xmx:h1_MaaUIo-IYsKbnp7XBPMdTHfxo3SSFPzLs4tUN-jhfaFtbz73Ubc_O>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 31 Mar 2026 19:57:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 09ea9ae6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 31 Mar 2026 23:57:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 01 Apr 2026 01:57:47 +0200
Subject: [PATCH 2/6] treewide: use enum for `odb_for_each_object()` flags
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-pks-odb-cleanups-v1-2-89adba9ada68@pks.im>
References: <20260401-pks-odb-cleanups-v1-0-89adba9ada68@pks.im>
In-Reply-To: <20260401-pks-odb-cleanups-v1-0-89adba9ada68@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.0

We've got a couple of callsites where we pass `odb_for_each_object()`
flags, but accept an `unsigned` flags field instead of the corresponding
enum. Adapt these to accept the enum type instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c      | 2 +-
 odb.h      | 2 +-
 packfile.c | 2 +-
 packfile.h | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/odb.c b/odb.c
index 3f94a53df1..9a11c60048 100644
--- a/odb.c
+++ b/odb.c
@@ -922,7 +922,7 @@ int odb_for_each_object(struct object_database *odb,
 			const struct object_info *request,
 			odb_for_each_object_cb cb,
 			void *cb_data,
-			unsigned flags)
+			enum odb_for_each_object_flags flags)
 {
 	struct odb_for_each_object_options opts = {
 		.flags = flags,
diff --git a/odb.h b/odb.h
index 984bafca9d..09affaf6a5 100644
--- a/odb.h
+++ b/odb.h
@@ -522,7 +522,7 @@ int odb_for_each_object(struct object_database *odb,
 			const struct object_info *request,
 			odb_for_each_object_cb cb,
 			void *cb_data,
-			unsigned flags);
+			enum odb_for_each_object_flags flags);
 
 enum odb_count_objects_flags {
 	/*
diff --git a/packfile.c b/packfile.c
index ee9c7ea1d1..5d3b772973 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2299,7 +2299,7 @@ int has_object_kept_pack(struct repository *r, const struct object_id *oid,
 
 int for_each_object_in_pack(struct packed_git *p,
 			    each_packed_object_fn cb, void *data,
-			    unsigned flags)
+			    enum odb_for_each_object_flags flags)
 {
 	uint32_t i;
 	int r = 0;
diff --git a/packfile.h b/packfile.h
index 45b35973f0..3eb10d6b65 100644
--- a/packfile.h
+++ b/packfile.h
@@ -352,7 +352,7 @@ typedef int each_packed_object_fn(const struct object_id *oid,
 				  void *data);
 int for_each_object_in_pack(struct packed_git *p,
 			    each_packed_object_fn, void *data,
-			    unsigned flags);
+			    enum odb_for_each_object_flags flags);
 
 /*
  * Iterate through all packed objects in the given packfile store and invoke

-- 
2.53.0.1185.g05d4b7b318.dirty

