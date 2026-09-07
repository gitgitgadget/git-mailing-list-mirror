Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB83411F95
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 08:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769559; cv=none; b=n8n2rCXcuReR5GAOJ8czwihj8i2Ke9tZyoosIyawfC4tErGCKuQfUZbVNfK+QAyfaTybZPfa1Zt7mrwQDLXagnUNPQZj3Cn/nZ3xseG11rPunl3nd20YFX6FjeoysHCRwpOTH4BxyD1Y96jS3hR94f0HYBuDBj1CRLEG7oF+y08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769559; c=relaxed/simple;
	bh=x19lgMulFwsxVboJ9cfeRarSXuytjJqfXlPp/e4/1dw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t/HYchgPX9p58dxcPPsc+CRCoxF97iLskghfdtoh1A/rAj2KvNCyLF989IzGUALszAkSMPveZEVzPlgR0NippQFzeXGTpZ85mviT9YdLMhhNlA8bhY3yXD9vWDgNi7YlhpttUZe9xcUKxELiLSV2k/SA9DL4VotwEufQ7DXU/0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GvnKXGlG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LfwGGPNf; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GvnKXGlG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LfwGGPNf"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 4A729EC01C2;
	Mon,  7 Sep 2026 04:25:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 07 Sep 2026 04:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788769556;
	 x=1788855956; bh=Zy76zppifvZ2IKeDIs4UvW3e+jPAcuXwzPXDU/7OHhs=; b=
	GvnKXGlGBX2Kh9omSdN8nK6DYZlp0WNNyQa//VCXG5psdcMuC9OMxeUkIMkaHbux
	pJoNP/iVEwDUvTP4h+gfTvvOlK021vC0qJybs8OlwKgTPL8QEVYzRBgVY0fBc9br
	DPa92zvKPIHkpskkuo5iDnEQLw8MxhxqR6QtbevShmTrn2srezPNZSEOnIixqHRB
	6Ii1ztCQcYzqzmy4ILKwQmQ5GFByy1l01rKllB7oR1QArWwM9wP7B3cpkVq9QYdR
	i+Kl7xAQE3gQnEqlD6RV7WjbkaNe76StI/vDjH6FDFEt6jtn+tAfBB51ioUsPeX+
	YjOvKh61k0L1paFmkhU52A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788769556; x=
	1788855956; bh=Zy76zppifvZ2IKeDIs4UvW3e+jPAcuXwzPXDU/7OHhs=; b=L
	fwGGPNfroAe1rUyr7Im1nJA+bJitzXPtETkL85rXgx6NejOZyA5UWqY6IuIurJHl
	be58wLBi78rkTyB0hJ21WYo6/iEkb3Uz05gTE4tOvmSUlKM18TiTRLmKvK25cn7y
	MptAlo6kg8sc4O2YeOw7GN0PtYTPODAUv1S2yZOObpo+TwEx71ZrKhuCCSCURh5w
	SbU90QDzWRZ+4rE0SCdaWihRLAJUI6aB7oxlN7kjWN3sKZkCdcIRarGh1Xz7Bul+
	Q4wJcgla4dH+TY7ZzAK8d81yJnKEm2Ob3JWgy33foPV/EsIPK8DC8974CS9YtCPq
	PyU+exxkusI+zM9qGQUxg==
X-ME-Sender: <xms:FHWeakxtKDcsGHc800q7vUEtb0dM3YcLdIMGssBUmLRKILorTkr2Gw>
    <xme:FHWeavSRp9vaaTpxSp9vK4yd1pHDEIhJng7DiLvqIRdRvgw-wJyAE-fvfch4Xj40f
    3I4hC-KjtFbjHcYU_SyVCDhY7kaGu1XUZYQtaXp0bs6wggxlVbUNMs>
X-ME-Received: <xmr:FHWearVqVKZCPUFUvOaiMKe2q8KRQ72pDu5RdhBhWEtbBUCCh9gkdg>
X-ME-Proxy-Cause: dmFkZTEwvxJlV6Jz13oBxJt7noT8UN5psTEHhqB/3tw7UoTKpjaK2+mALA0HPmwRij01Of
    9dhkywfQIRbK2A+Xx4pCej5z0Gc93ipNYqmboXKnoPEk3WYQJpGgieQC7XVSephhp3ISUQ
    MGPQReALAhsabXqC5ji5VIhD+T7uSCVMY9pTeV/uetc1YYgICxCXWOLmIHyOzA4rmsTv63
    RvJ28rY1ACH2APQTAMTiF9nZLr3Bx2tUEcPRAPymckl5dw3hztQ59ZNl4zkY0VdNdjkdmK
    j4h5EE6Go6yjD9p15Napv4T5sL9npJ/MGabKj3GpZukVYVeSOOrfPMqzPjvLax4PBRxll3
    pFFjfZHQ0uExJs90Om9V/yAONprMAKxWVS93MGfikPIEszc3RHy8Nblq9Dvd7LBA9KXwrd
    M8DD5xqnMrJvD0G0JIbVbv0YChRYR+li9xwvN1Gw9H/QAaOB73dEtJhS6ObHbzHsxnyQY4
    jjQL7mF05ahjrHvoG1eekkx1dMl5meR7MXSY5fPPHh8tKdTC4bUEUHwCQRnrnilDBfqxe1
    Xd7WHFit+QhCEyZ+eHXZSlRW6tYAtiLFYq4ORlydNFhIqm7moC58MpyKug1mE+YVfiwlSb
    9W7MNLqKWYRAuMqM+QDeuUVpxAZk1NwiLEVU3cTDlqZ/i/++QzR2rL/ltnYw
X-ME-Proxy: <xmx:FHWeahYbzNcSkGOSepV0y8EBT1WXDPpX7RDD-FL3fE85TlC1RTvm4A>
    <xmx:FHWeah2CxvsT_REUTgHgHTzEaorW1Gx6X16YSyv1XmrJl3xNX7Iu3Q>
    <xmx:FHWeajjCvfMvW0ie9-AXyn2-4JL-TEiyZr9gdxpEtLJLNdwy3uQ1LQ>
    <xmx:FHWealYV1Wd5OII-MwT6SS1Z09RpoRy--vvVNxOlumJVRTPl7skuHA>
    <xmx:FHWeaugBa5nEqmY8AgJiKBW5wnoXDuLx0-zIqApi8gqV4DSu-kPB1oR->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 04:25:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f0b8891c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 08:25:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 07 Sep 2026 10:25:40 +0200
Subject: [PATCH v3 3/9] builtin/clone: move around `setup_reference()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-pks-odb-write-alternates-at-creation-time-v3-3-735d0b5b3e00@pks.im>
References: <20260907-pks-odb-write-alternates-at-creation-time-v3-0-735d0b5b3e00@pks.im>
In-Reply-To: <20260907-pks-odb-write-alternates-at-creation-time-v3-0-735d0b5b3e00@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

In a subsequent commit, `setup_reference()` will start to call
`copy_alternates()`. Prepare for this by moving the function further
down so that we can avoid adding a declaration.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index bdcbd7aa1b..ac5843d7b9 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -179,16 +179,6 @@ static int add_one_reference(struct string_list_item *item, void *cb_data)
 	return 0;
 }
 
-static void setup_reference(void)
-{
-	int required = 1;
-	for_each_string_list(&option_required_reference,
-			     add_one_reference, &required);
-	required = 0;
-	for_each_string_list(&option_optional_reference,
-			     add_one_reference, &required);
-}
-
 static void copy_alternates(struct strbuf *src, const char *src_repo)
 {
 	/*
@@ -228,6 +218,16 @@ static void copy_alternates(struct strbuf *src, const char *src_repo)
 	fclose(in);
 }
 
+static void setup_reference(void)
+{
+	int required = 1;
+	for_each_string_list(&option_required_reference,
+			     add_one_reference, &required);
+	required = 0;
+	for_each_string_list(&option_optional_reference,
+			     add_one_reference, &required);
+}
+
 static void mkdir_if_missing(const char *pathname, mode_t mode)
 {
 	struct stat st;

-- 
2.55.0.1007.g17ff1f9808.dirty

