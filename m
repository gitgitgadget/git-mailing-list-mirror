Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FCB4915A9
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 09:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790589112; cv=none; b=mJPGxLCp0u2M+3NT3p7cazWw+NEQI2e0bkG404FhARw9M5dRFfZQ0AdxlxVV1l6V5Z8vN7awORnpbCajexTcelDxb4OHoAcFlzLKJ7bc0MA/bEc9WO69gHQD3jB7Nc+4Hs0hkbvbjBA9cDPtnRCE6YAwSK/j6C4VSJtMXszhqvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790589112; c=relaxed/simple;
	bh=kAakvSZB1DfHp6X6kD4pxxRsyBaPFzU1arh17IFtdtU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qP5IHG5i7/3+wJ6BoKZgaMkSlNUzuWKyGh/4Y6hr8YNGMgdX8g4r8+DWLrgGw/1TktLHlZ+8ELKXGLKOWI4NIMjhUOxISUWATmgZttVwXbc85ioNOGMjvLrUc/Sun2vIK/gcFYOqhKN7nuqVb8hvpwr/2c/fT1IQOx/uMbpS2uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BVVmHTpj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xzJhNiIr; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BVVmHTpj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xzJhNiIr"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 42393EC005A;
	Mon, 28 Sep 2026 05:51:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 28 Sep 2026 05:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790589110;
	 x=1790675510; bh=W0d2Z5VXq6etkEp9QSGVyASsKrEB3JDcDE/MxYeMN1A=; b=
	BVVmHTpjgCjFPhsj8tZ6PaF5OTjlQaClyfWJWpuGEdrO8SadcLttgS5a+ByhHPcS
	sl8TUrz+ju1atmsFn6zBd18YEP4Ibe8G3yyjpKiOjLadSTyFrHG6Ya3H+zfs/TNB
	HF5TzXArQxi0ih2upALHE++eZr+IBcp2gLxu/uhKxDQfr3vIWiEEXO2FhZGn3Ck6
	d+UUYloF95kjrWCELJB/JNOUeUHJ8COPvmSa3JtdM8rNIQlURzBs662zrCRnacGj
	uMTLId/ScDiTJSTV3OI6bDXAx4/z0/0ie3iJfQKzDRIxTqqnhgWQJVujAmwUvB3R
	/xdetAs0WYTot/hCQHvxdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790589110; x=
	1790675510; bh=W0d2Z5VXq6etkEp9QSGVyASsKrEB3JDcDE/MxYeMN1A=; b=x
	zJhNiIrP0wvoC/5eM6C2k1vNR6SEw6UZkrhEutqVtQKacBJ65VR/+GEnfcxsIxZy
	rNcBie/RL7q6EGjp8IqZcDUtVnI/vKWDmW+yKup4+d2Bk0p6VtzklMOr4xrRBQZ9
	irmvhj3VuixPl43HXKQ9e3TDvwDMNIc8ScWflDfckrIZAsLPbivIO1GfOE4GMAk1
	kcpQUcZYaNu0FMBApGWEfAFLuWzGcvMyXH8CdjKF71GgwTee+Y5H88VvZ8nXNhy5
	8nmfKPzxLHkDKQ7FluRzY4tikSSIRxkCupQ3nbnxiFOOShIhq5HymkrkfUpyz4Qp
	JfWjRxTGWnyYOGiUFYm6w==
X-ME-Sender: <xms:tji6ar_3d2FYcJR0NKGzAx3gGlfszGvllBrNkgfQbthvqY_TEeelDg>
    <xme:tji6avINkADJ2jYOijlOe9HEJZ6iBUqVX2mq5sMXbH8uqH4DNl-Rr77BbIRzZTpWQ
    KCeGY3DEaxy24m0SA_XuMFEPTU4lld9IWZjL0te7_qDtSgInpwH_DY>
X-ME-Received: <xmr:tji6amZkc5VkKpU00qL04m6cqVodf3UsbRf1sscBvAoKl2-zE3TXqg>
X-ME-Proxy-Cause: dmFkZTFf3wbZ+K2hbzfSgpgETsMz+NBy3J6MpFvFZYdyyTeL1iI2BFDj1IOSxm4OYKC0H3
    1Aperekeoh01XU/Affr9YDGewK0XTpFuAvdOqXRnkn1hAQOMt6Cmug4wAR/cLjxT0+YYyY
    V0ix31kC1wU9qb1Fc8l0wzUB6/ndZQ/KZS4bdHqUX1yu2WFUdfLdGcye3K8VFjVWdme6dj
    VB+FbRki+xZ7UJmHTn7m2FhlNqt4gn7r8JRqnyPx9S2V0Cn7eSTMCsJkqZ9Q8z0sAb/7of
    tUBRJGNrdn5okkLUJRR2FTKTF+T7dMnEgQWAA9cfkQE6WEt+aDQyOttxx4ijBJAJTShyNK
    Wz187Mbm6eiDFcxWq1pw5otGNgFNUSPZhtGPQ+bXD7K7+ZPwrbnNwGZSogSei81S9Utxz+
    3+Gl6/xHi7CN5dD/IM3BYsfUANO66vHkiLZnF2RiHINKQSrDsof1pCQifiMA48kZlxm/Ha
    SeGUo2/KvOc6mVzgeh2JaY8E9HjPjqsSC8UI4isRIAS+hQHb8Tshj31b5qgcgEIRvOjJdY
    n2Sf6H4m5+Cw9hTSSafYwFdp7hF3tK0xn2aZ4qku0X7S/tD6k5zluiocv8qaFNUrc0Po0M
    L3MDR5TIAZxCKNSdt9OAXSOeLww8f0m8a7bhu4iS6PVpWtoiBT85lzSkTVXQ
X-ME-Proxy: <xmx:tji6ahLnJzn8fZP_nn_PbKc2-s1jsYE4gucSMje2-paqyrUbMJe13w>
    <xmx:tji6akAKkTq6FzRFUVuv7Y_6NdSu-OHm8FzWzezpoafmhbrSWuHbig>
    <xmx:tji6ampeiDx4eGkksz3yEMvHOzyCfZUben0rK5CMvdlVdy2j-luUbg>
    <xmx:tji6avh4bq5hFeEtgemwlyi3uGr-JSBrBEiVp2RwqrXtmEsHKGn1Mw>
    <xmx:tji6aln1-91Q2eS0CIJkRzTjySwIxdCqy8Ew3hVzWygCDgNs388a5IYb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 05:51:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 33570931 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Sep 2026 09:51:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 28 Sep 2026 11:51:02 +0200
Subject: [PATCH v2 1/7] path: drop useless
 `safe_create_leading_directories_1()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-pks-create-repository-stateless-v2-1-a03612f703fa@pks.im>
References: <20260928-pks-create-repository-stateless-v2-0-a03612f703fa@pks.im>
In-Reply-To: <20260928-pks-create-repository-stateless-v2-0-a03612f703fa@pks.im>
To: git@vger.kernel.org
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

The function `safe_create_leading_directories_1()` is being called by
both `safe_create_leading_directories()` and its `_no_share()` variant.
It is ultimately the exact same as the former of these functions though
and is thus quite useless.

Drop the function and inline it into its callsites directly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 path.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/path.c b/path.c
index c3a709a928..69b06c9464 100644
--- a/path.c
+++ b/path.c
@@ -829,8 +829,8 @@ int safe_create_dir_in_gitdir(struct repository *repo, const char *path)
 	return adjust_shared_perm(repo, path);
 }
 
-static enum scld_error safe_create_leading_directories_1(struct repository *repo,
-							 char *path)
+enum scld_error safe_create_leading_directories(struct repository *repo,
+						char *path)
 {
 	char *next_component = path + offset_1st_component(path);
 	enum scld_error ret = SCLD_OK;
@@ -884,15 +884,9 @@ static enum scld_error safe_create_leading_directories_1(struct repository *repo
 	return ret;
 }
 
-enum scld_error safe_create_leading_directories(struct repository *repo,
-						char *path)
-{
-	return safe_create_leading_directories_1(repo, path);
-}
-
 enum scld_error safe_create_leading_directories_no_share(char *path)
 {
-	return safe_create_leading_directories_1(NULL, path);
+	return safe_create_leading_directories(NULL, path);
 }
 
 enum scld_error safe_create_leading_directories_const(struct repository *repo,

-- 
2.56.0.rc2.329.gd58861e689.dirty

