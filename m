Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4714D3C108E
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 09:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784280750; cv=none; b=WghBIdCIyfJzzK63htqPWsQIQkqjIem/zsJFnjbYeoYC5vwEE39J47NiutDr3npWuK1vxiFCaDzO6avkfo+Aq7i+7zQWoyRft5K4ZSoyYEBl9gYjE98ORdijyZDN/oR/ai8n7C0/cduJidXyex6rS5Ux0k2AHS1YCCy9lEmrO20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784280750; c=relaxed/simple;
	bh=rvPgHJHKsP6nNgKpcbcnP2GDIxtc8JlFnkRcVSvfD8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uoNGr4EDXeRUGAdzY73jVSvbsPd57Mh/xJ+kkpKUVVa+BeEHDmz9Wz7Po/zVEWONK9UAslts0ujK5f48cJF2osrjA+B6WvKIKByIy21jthI89SrEbgi4icjt266byknRcZA2g7L5K3r5MqGGlS5rKs2zCZN08Zi6UfQB3O7n424=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SoEO2Dgq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SPV6yB3a; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SoEO2Dgq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SPV6yB3a"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 81A1F7A0097;
	Fri, 17 Jul 2026 05:32:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 17 Jul 2026 05:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784280748;
	 x=1784367148; bh=HLcOSjjut4aQk0Jmuj264uMRYing/4I8uz7llfQXhFs=; b=
	SoEO2DgqD4IjnmQ+5+IPkxuXnsPbWiZOcqjznhZQEXnLb0QyD+bbPlDtoaZSzFFI
	DauBIEXcxXrIdhM6+KtSGBrqdDrEXMejeCvBTyhxWG8l4ruNcZFaWBeqhb5kL3dd
	Y1KqyeAO9QtKmsAsQeP/A/0Bb+hNyqwHCb3QLg3EnPr8Bc/4qS9W0tGcrum/pMql
	otDu0IkBv1DrRQ/t2rJR3AgMC7Zsmzmku92cN8MOlgoiCujeg5Kac9DwsLrLZBxO
	admIokLCFNrpAdXAo7SpmCGs91ymP8D4TglFCQfGqTatOwLqgQgzrTnk1y7pT1/k
	+qKN4Zs71W+0Nzl/EOGPWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784280748; x=
	1784367148; bh=HLcOSjjut4aQk0Jmuj264uMRYing/4I8uz7llfQXhFs=; b=S
	PV6yB3aYUO+0Y5jAcR4VxmpNALdpHeTNDHfhjBuRAYCUyWwuKmRna2ChcubdNWV9
	jxSJw9sgERJDd4m0YU6Rs/Vqcv11z2bkHNX9pp6j3Yr3Upy2EIfUZPjlU7G2u8tH
	/LPa8MZJ4+uKFaYi4m4WfKjZ6+Osiprhfb1TxfNHBoATe8Dvx6XKlKayAxJ/No2v
	nQdnpnA7gZTzyvg+xjA//C4W0K44s4cfbS+sgZThgQQRZ8xsCApicdLAW1WqUXKU
	8dkw/JvhQQBy74w+6+o3n5kA8AzmTW2shLIaN86FysgQBiQukMaUZ/kBiJLCxJMO
	sf4AkgzRcG7euQqQzK5mA==
X-ME-Sender: <xms:rPZZahyKljLNxOSgnC2SFNCg_B4-q5UE1XCt_2p6sroZcnqCleLz1A>
    <xme:rPZZanSVkTywyMViMfazEoUsNgGxIkUk_SXw9WHes_SZpyQHGg7BYjy_pPkNHyzzB
    8aBUYihuZiO2sjqOBXJRNIO8zVo0cTtnvtLFANCJ4_D43bs2Gg>
X-ME-Received: <xmr:rPZZao_QeylKjp1iCCu2lmHbs3tVYD4Vu_FWElPAwWlT1_vMjUtSF0FsgI_2NVxsi0-3hokL4traUI4mmgdLoKfbsGEM4-royOpp0i3EeVA>
X-ME-Proxy-Cause: dmFkZTGNHhUECtWbI7dGTPFNitkS7LxgjgJ4w9ttpCQibr0d0pgAOmcVCqLeCbbV7wL1OE
    61pGVn8/ErNozdgmjBCJ22JUEuhEdV43SljPiIS68IvSIIEx2/IT6MCkhIkJCPTcQTmu9o
    2Qdy2OioKaWgpjp2RsgJ++fMJvWUuDUVquHnVN8kVLLylFlUQTFByQkM3aEyZv+j9jYhcI
    TKigCUrRA+8Y1aLWnthCzkuv+IxGUWyKW49IWIb9XdP9KobKSZZLxL1izlSkhLpchPtJY2
    DckpFY149y2mp922DWSqIc7sogOMMiGU8oJ5EHDRxShwxMLqGszhZwCopB+raiMyjqIIMp
    PCaf6NOQeHM1yukp0LvwoLjzqzCTboNzunaOz8GGrV/FD9cPXzbVI8nZvfROEBX4zDI/cc
    4RGTBgb/oX8TP6mcd2O6t6O6BfKCjZeju3Rsxst8C40J74zxn0Lk8TE+9u6vBCeabtxFSy
    A8POZIypsbpVb7VMI42q+7peEk1ASUQF1rr03vrfAvWjKGTDZQZUSiMnD78SARfiqInH2p
    3sFdkAB69helESmMKGbh7cOR42SC6qls/Tm6HQYtz3lQys6CgQIHcRMBds5mZ4EumMT9hj
    jxcMx36gQQxeMZls5/TG/dmxVsOnaJolrAdFSC44U5BK+2ZZYKT1Sg/pX8cg
X-ME-Proxy: <xmx:rPZZauqPxlSw1SD5g4tdqOJE4MZ8oZ7ue-78ZZAHkCGYr9bwQiRduw>
    <xmx:rPZZalkAVv8EFGOkG9rL0_lCozOPm63l1kpfbeDQGuMrf-GY-omOfg>
    <xmx:rPZZalIHkhkPqikp37_SC6ATo0Kpsr8jPXBWnQHuNQLk1QOPPoeQZQ>
    <xmx:rPZZaqx87czuJmXseJOaUEvkwSsmfws2U39mC9Kk81_DKu2WqKdY_A>
    <xmx:rPZZatjGb4XNQ-kz9n5LAwv-eNhPs7SFNNYEbSuOQAMoJrFetIugOOMy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 05:32:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a2c554e8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Jul 2026 09:32:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 17 Jul 2026 11:32:12 +0200
Subject: [PATCH 4/9] odb: lift object existence check out of the "loose"
 backend
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-pks-odb-move-loose-object-writing-v1-4-46446a3cb5b7@pks.im>
References: <20260717-pks-odb-move-loose-object-writing-v1-0-46446a3cb5b7@pks.im>
In-Reply-To: <20260717-pks-odb-move-loose-object-writing-v1-0-46446a3cb5b7@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

Before writing a new loose object we first check whether the object
already exists in any of the sources attached to the object database.
This results in a couple of issues:

  - We have a layering violation, where the source needs to be aware of
    objects stored in any of the other sources.

  - Every backend would have to reimplement this check, which feels
    somewhat pointless.

  - It is not possible to easily write an object into a source in case
    the same object already exists in another source.

Refactor the code and lift up the object existence check from the
"loose" backend into the generic ODB layer. No callers need adjustment
as none of them write via a specific source, but via the ODB layer.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c              | 7 +++++++
 odb/source-loose.c | 8 ++------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/odb.c b/odb.c
index 4adbdf8a64..bfeca76f4e 100644
--- a/odb.c
+++ b/odb.c
@@ -997,6 +997,13 @@ int odb_write_object_ext(struct object_database *odb,
 
 	hash_object_file(odb->repo->hash_algo, buf, len, type, oid);
 
+	/*
+	 * We can skip the write in case we already have the object available.
+	 * In that case, we only freshen its mtime.
+	 */
+	if (odb_freshen_object(odb, oid))
+		return 0;
+
 	if (compat) {
 		const struct git_hash_algo *algo = odb->repo->hash_algo;
 
diff --git a/odb/source-loose.c b/odb/source-loose.c
index d4715da6d1..04af1a54a3 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -595,16 +595,12 @@ static int odb_source_loose_write_object(struct odb_source *source,
 
 	hdrlen = format_object_header(hdr, sizeof(hdr), type, len);
 
-	/*
-	 * Normally if we have it in the pack then we do not bother writing
-	 * it out into .git/objects/??/?{38} file.
-	 */
-	if (odb_freshen_object(source->odb, oid))
-		return 0;
 	if (write_loose_object(loose, oid, hdr, hdrlen, buf, len, 0, flags))
 		return -1;
+
 	if (compat_oid)
 		return repo_add_loose_object_map(loose, oid, compat_oid);
+
 	return 0;
 }
 

-- 
2.55.0.407.g700c83d4f3.dirty

