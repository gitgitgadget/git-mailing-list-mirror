Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5B13BF672
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 06:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788158786; cv=none; b=p63MzLtPOMlymI6FoYCl7wxXroE1W99nbBbyB/A3iayGGb6rHZNvDBiquMwXLOM2t+Rmcf6JbbnQGOESlKdKeIP45UzdF6/WCU0dYMTPpp8TCXp8uoYBjzz661mmNg6DoXsSQMs3DrA0LzKy7vWVQxY/N5Uc1+LRcUGjpoUi6iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788158786; c=relaxed/simple;
	bh=N1QRJzQUUS1hHXhH329+mfZptUi6pgrje1AVJKquSzU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VNLZ2FbMQFi2grqjAX3wSY926FOlG0Cg/ehfjAovj79NkLNKL6SAeHED1izHlRN7YFseBCM5sWzYd9W+5T8b2KJmxmSHd2pMMqKJWQU+QXlbJp7GMBGlR4bx2qf9Y4RktnnpOAbSVSF6xUXSOf+fKWU+ccyWIGcaXTGSiAA6jpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f7NnlyZP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eNOmS2Qf; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f7NnlyZP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eNOmS2Qf"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BACFB7A0115;
	Mon, 31 Aug 2026 02:46:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 31 Aug 2026 02:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788158784;
	 x=1788245184; bh=XzqzdvzR0ODC8NbnePdVMLV9Vb6htVV2Zby/bkaX9KA=; b=
	f7NnlyZPYENhfq29SnbYKv15qfXGOR4WRF+HY4HYqDQ3U+ANhOSMFoqcGyokc2Ni
	Yg1vfahtlAMBFlkWaN+TK4MTmvKCa7c3LzWTzrMj93fYf2k77yjfXrpx3KLWrxr5
	HpR11lmGm/6DBk1aMepvvNQWx1bxNlicb83LJUNsT1WNgEZvU3JoApzUxQR4xvjT
	YIeEgTBS61crr56a4Oy7lPM5Fo+szqusdKJkBNeevqiyICP5URK02v9YXiZ6s4dj
	X4wrUIEKCgK3KkNpyrapV2+QS49KolQLKrURA3kJWpX8dGvd8w/Xx372o8/r3FWV
	G+YiplGP2rin2nnfmuSi3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788158784; x=
	1788245184; bh=XzqzdvzR0ODC8NbnePdVMLV9Vb6htVV2Zby/bkaX9KA=; b=e
	NOmS2QfBRbPkWBJn8mQ52TVaGhSBojhvSVlQNSNU6ZFkBh/Vhc2SUspnsxAKCZW9
	pIgG/LJvS5cm3sNe5RII9cuzb6245F4wiymBdhFSpjQ5eghMRsdaytmsfdL93/cl
	alq7f2bS6YCpU2jF5qEOJ/GMO+1mDhLZn/NMSRFzJu9DVSxn99ETc3T4xIjg5fXp
	NrSUR/qd7lVTy7LdXtb9vVoAWKmjJ2/7Gprobt+sBlaeyTegPjhZwUOi1axF6HE0
	SqReVd2pkbZwZP/mL7gX8nP+6+rcMKxWc0hr7Ot3BpSbPUjVKthVZmVTagUbi9J2
	l6KnRn1Hyyc1Em9iT5SBA==
X-ME-Sender: <xms:QCOVav7ugcSsZZ6gWAiukzOLhKn0R9c67T91TLk8Lk0Utelr7pFLQg>
    <xme:QCOVaq6Vxtac-j8aboxBJAfXjkTompRg-mwFbsUaGEYccq3Tl7L4Lh_2Og9KM_D4v
    sAT67-iUu1vbO6J0yGwiKPwvqvboC8_1oxgRciHs8GYFqmHSD52OCY>
X-ME-Received: <xmr:QCOVakEFufFpKMlPaJzTy0HJNdhtxk6WE0ggjOFrnUfICEcil17JtDjIPEWmZPPBamQ9vA>
X-ME-Proxy-Cause: dmFkZTEYVf0dL7UGrcJrZICBDSB3LjjfPaqozSE//v2Uk+wmrGGsN1vPAxnqAgkLBIQ8YH
    jkGm/0q2QCpTLzGMeN0PR1MeaTkM5EPaoEuoMhHzPGrgkrrahxb2HsmJ1bVk4UiWR43FR+
    opCeq8ZwOupZwyvgFz/5EO1rlWMX9ymY395FZ4JB8b6N4ddSX0Lf/ccWyhtowb9unYs78i
    q65B8tbD9ISvvMC186S9fuYl1A66bWAlIet37pjlPsFSIH2y9YQw83JMBRERaOog6/NRAV
    yj9dTKgCGRxgJt3f7+n8VX5/0i3r6oQenmQAn+SILo/sIBIqcd93oq/gzZ6ziXimOnALTZ
    CNpun9eDgs/eir4x0tkZe9ItvR8dXTQf46431dDew4pakdGaScL4wpp59gT7AqgAA5Ii7s
    DyGcF37FXiI+c1EFTHw4Yp0kkSP1JkTx2+cvcGC6QUO+JEvvvS2LdvhP3BJrAWxtqVmnM2
    ernQ+SUHkETUuuxvlXEPV7SkQYkKHRahBrbRGLo553zQb9Tvd2P9WiUyNQTNIQ3z+Sr6/9
    ICgx/s14ge+5ljuujA4v66DI63kW1pmg4DT4w9FYM5v2hnlfO2cGXmQ4rvpBvsohFh4x6+
    edD/mId7zNeEE+IrtqKdb+HbVY9QCRF9BHQwBnpf2xbC1mIGfKP1ZN2tqp9A
X-ME-Proxy: <xmx:QCOVarTrRYS4n1rC7ApOJd__w7SK9BeIBcjzsIUmgq2-mYJDeTY_fA>
    <xmx:QCOValuRP2-cX0yBH28W009Ss8OGDoA9cKHQa6SWKwWlzc1x6TkmBQ>
    <xmx:QCOVaiyRJAJN8BPtdPWG4g-u79u1bSQ0B-l1AEn1GygYziaH9sTLGQ>
    <xmx:QCOVan4KJJy_V_ujm5ryQNlmJTCEJnZzK52xmMBSrm4MQmxtySSkag>
    <xmx:QCOVatopzzgHifgUa642uIvUyvE9Gv8FZr6auDfsTHLyH1mk89Dwgmyp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 02:46:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e18de361 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 06:46:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 31 Aug 2026 08:46:15 +0200
Subject: [PATCH v2 01/10] builtin/fsck: use `fsck_obj_buffer()` when
 checking loose objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-pks-odb-source-fsck-v2-1-f9b16ef4957b@pks.im>
References: <20260831-pks-odb-source-fsck-v2-0-f9b16ef4957b@pks.im>
In-Reply-To: <20260831-pks-odb-source-fsck-v2-0-f9b16ef4957b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
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
2.55.0.979.g7e5102b832.dirty

