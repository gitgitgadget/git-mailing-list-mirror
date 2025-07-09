Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC8F2D8389
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 11:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059875; cv=none; b=qb4L/XsPiCk+6q2QB2ekhw1kkRwDTJBr6mwvWoOFa05oYHWf7P7aQJzSTD/fySG7LSZIE3mUFjM+H8Mcq8Y+UZ3VjVSbSXj7tvJXvjlPjSWjrVG7cvmVQyDuQecc2RjPr3K04KYLW6cg80ou3pbmzZW4y6OJusDZ2f56Dn53EqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059875; c=relaxed/simple;
	bh=81JZxQ4efyrU+h0hQX2KEDSExEDZ1fU0o2pZqGpYA7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P9l46oFdVMpv41XkmrFKvm4ndXoVTmsJ4dSzjsyGeit9hcKRb4KUyLBGmi5cmRB9cVzmNMLrgUK9D+vB3+klhSmswkptG5hcpWxA+po7lLjY69RQpilz/D7K1iN0WcrwsvWJVJSSjHBp1J+8evv0786ghDJ5WPT/tAfJfCvz5JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tk+GiP+K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q2U5JWKw; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tk+GiP+K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q2U5JWKw"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2FD481400330
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 07:17:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 09 Jul 2025 07:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752059873;
	 x=1752146273; bh=Qe7C2irQtbUXniBmkj+psGbtFTJvlnHIX4HeqXwpVmQ=; b=
	tk+GiP+KMuApCx0tqhKQF5dvOcgSkowgBUJ2oDSaV4BJApj9mf6hoiZltnUQ5gEQ
	jIvmBz3/4LGvj1EKwIYUt7lFmN4ZLuT+GLuIrbzGleJQY2yhC1Cz4GtSLdKSMMWs
	IOClLSO7kqdorc2msBgrQ13NLW9RkRZVJP3DvbEJCguCnbH/6nY0KIpi9VxAE7co
	j3Yuo9017mrUfV4V8N/2rzGLat6lnfkmTk4mTrl2rcCDD3LmjQAnRfZRfdcXsIQi
	cfTIUEB6e+7d7+Y1DVJnWXfCDLuBQwgGCcxBSOOAOX0lanmFJcfEDtD4beplSQe7
	E6YBKbAz7P3k6Ruk1oCm0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752059873; x=
	1752146273; bh=Qe7C2irQtbUXniBmkj+psGbtFTJvlnHIX4HeqXwpVmQ=; b=Q
	2U5JWKwpGboLQMkkWRFMRzB+UamJnGUSCdPb52Bmjz9uQPt5KzAZgEBbZOggpIeV
	bgvTnWvVv2LCKustohR36+yW7iewdt4j8b1T0qOD5g7ZQ3tE15e8Zq1wohFu1jbv
	0AF3+NC3V74UAx5VsHMOZaJs+iag/moKAg6Io08bFzQMKok+h3HtTb0qGNdztbym
	iWxbPKj4rogfGuEV1gwDq4EMI3sOEqHm2g7c9zWUC43mcAb22+VRhzBGc2fWxCIi
	p2jW9gdRLaMmdJ2EO+nQ7YdSrJjWXXPqUc9qFdvLFRoXXGIAuly6i5BpvzJO4Yf/
	Mu5xse6QLewv9BDYU5e9A==
X-ME-Sender: <xms:4U9uaAyDQcUrNDUAlXVhebj80UvjqyrpK5q94XEmtKtSqi0XlWvhBw>
    <xme:4U9uaGT_04tDTAP--xWJFEyiNmYBLylXgi_XtLDrEz1RmOvaTVGdzoNDgEsJDA8qm
    BzLZuV6yKgyq5L8Zg>
X-ME-Received: <xmr:4U9uaLsWXZFP1gpmlwiMHlOyKC_bBcNobC8azBU3Gi_mtQ64hPgirtEumIB2kSriprD7r-mVyT02_eGSyBBIbmcdBJznMdaeEC8A-iew6znvBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:4U9uaAull0YWD29BJtzAMFrK8mRr00dF6JJScqcH0_tB2LMPD43ORw>
    <xmx:4U9uaJwUqL5H0LmDTlIeiSE6HTbkngX_ydC8yhypHHsAiSGsj7DTXQ>
    <xmx:4U9uaOj344YywFs0GE5eP2XbpwHjoJ--lv4rlbuekcUV0HnP60NIZg>
    <xmx:4U9uaFCdPtITXAm0j01sW_7jid-0N09vt-dNpXKN3uTVXADz20X8DA>
    <xmx:4U9uaLoi8tbgC0mQNyIQfwXqIGhGTD3iURlox3oaAIKJBt4NShUEaFsc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 9 Jul 2025 07:17:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f0087dd2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 9 Jul 2025 11:17:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Jul 2025 13:17:21 +0200
Subject: [PATCH 11/19] object-file: inline
 `for_each_loose_file_in_objdir_buf()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-pks-object-file-wo-the-repository-v1-11-62627b55707f@pks.im>
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
In-Reply-To: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The function `for_each_loose_file_in_objdir_buf()` is declared in our
headers, but it is not used anywhere else than in the corresponding code
file itself. Drop the declaration and inline the function into its only
caller.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 31 ++++++++-----------------------
 object-file.h |  5 -----
 2 files changed, 8 insertions(+), 28 deletions(-)

diff --git a/object-file.c b/object-file.c
index fc061c37bb5..5a936f17148 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1388,26 +1388,6 @@ int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 	return r;
 }
 
-int for_each_loose_file_in_objdir_buf(struct strbuf *path,
-			    each_loose_object_fn obj_cb,
-			    each_loose_cruft_fn cruft_cb,
-			    each_loose_subdir_fn subdir_cb,
-			    void *data)
-{
-	int r = 0;
-	int i;
-
-	for (i = 0; i < 256; i++) {
-		r = for_each_file_in_obj_subdir(i, path, the_repository->hash_algo,
-						obj_cb, cruft_cb,
-						subdir_cb, data);
-		if (r)
-			break;
-	}
-
-	return r;
-}
-
 int for_each_loose_file_in_objdir(const char *path,
 				  each_loose_object_fn obj_cb,
 				  each_loose_cruft_fn cruft_cb,
@@ -1418,10 +1398,15 @@ int for_each_loose_file_in_objdir(const char *path,
 	int r;
 
 	strbuf_addstr(&buf, path);
-	r = for_each_loose_file_in_objdir_buf(&buf, obj_cb, cruft_cb,
-					      subdir_cb, data);
-	strbuf_release(&buf);
+	for (int i = 0; i < 256; i++) {
+		r = for_each_file_in_obj_subdir(i, &buf, the_repository->hash_algo,
+						obj_cb, cruft_cb,
+						subdir_cb, data);
+		if (r)
+			break;
+	}
 
+	strbuf_release(&buf);
 	return r;
 }
 
diff --git a/object-file.h b/object-file.h
index 622e2b2bb7d..eca323f9736 100644
--- a/object-file.h
+++ b/object-file.h
@@ -98,11 +98,6 @@ int for_each_loose_file_in_objdir(const char *path,
 				  each_loose_cruft_fn cruft_cb,
 				  each_loose_subdir_fn subdir_cb,
 				  void *data);
-int for_each_loose_file_in_objdir_buf(struct strbuf *path,
-				      each_loose_object_fn obj_cb,
-				      each_loose_cruft_fn cruft_cb,
-				      each_loose_subdir_fn subdir_cb,
-				      void *data);
 
 /*
  * Iterate over all accessible loose objects without respect to

-- 
2.50.1.327.g047016eb4a.dirty

