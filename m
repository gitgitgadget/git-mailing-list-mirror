Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B838B2116FB
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741273739; cv=none; b=ojHhrAxt9hNH5VvZv2B7pOIKLrGa6mpaDuAV1OL5/SXgYu98fMD/Nc2I+VSi3TtbEzbxwDwVHd7rv7nh48urghSi8wrh0fT0MC3bZT0muWIIQj71i1gnp78KKgVLF50F3XVTVYoS+ThOUPk5GuKKt5NJWTXxFfNR73t8QVJ3tZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741273739; c=relaxed/simple;
	bh=EIUWgnF6nPkecTSJyHi4Lgk+3OGi40/RNEs5Ej9rMOM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p0IvnLxzq5YivyNoa8hhkURCfRP6ePl5sOkTDXFD3bDyv2OVNpB/3V1RXslSesjnikkh5DEp4Z2pDBa7wllih/MwkQF7pGLMrGu0Ie0EflwsShY9A1Xns3//D9kX1xhYLxdx9fgPtfK9e/K1e7QUV9M5Ih+b5DLeqkF9jb8vBjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RIYRbkbD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FDJPsZ5O; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RIYRbkbD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FDJPsZ5O"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id C118B11401E3;
	Thu,  6 Mar 2025 10:08:56 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 06 Mar 2025 10:08:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741273736;
	 x=1741360136; bh=CHW07G9lowZ+RQKpucrknjTSmezbfl09mEXkRp5IoDo=; b=
	RIYRbkbDHKd481UqtLh2a4dEeW8JI28ne1nrn93ppJ+sxcX0HMqKZPNxcnrJLaBm
	A51XgWLbV+C/B1wHuqOmoOtNGTql2ayICaiMuibFR972+NVyH2o8eX/9fxk/yRVc
	jwIZCn3gKVK2V9DHU3g4rWShAovd7oftgyWI4LR4jgcWxgBClSFITWlz7uZbv/zf
	IEzmNRGy9WnlupDRbds/7ickWuNgRQS7MxCZAW4FF3sLUuNa05rYyrCfYd7h2PJ1
	9c+b8hn5kfzAq56PW8phnNYld/tWDCldLRXoa2Z7FcB5MrAS+y1Y2ejK+aRlwTzN
	jr6w8Q+uEl0lVAC0bys/7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741273736; x=
	1741360136; bh=CHW07G9lowZ+RQKpucrknjTSmezbfl09mEXkRp5IoDo=; b=F
	DJPsZ5O/9n6wE5sjec5dBF3l7qm8jDoASNaAGvg6QRVpGtlmNlA/Af5XPRen8Xfl
	w0Id6pQLxEQ6KIfLqVQMgzR30f95zEkyKzH97YFbuVhPhSCdmWTlTth6DT/FGo94
	l5P0VKdI2xcLYxn8mGG3qCawxgBVugjZV96BrCbLifduxZAQNl/4OhCpL/8hqPbB
	U1FitAbtXDlY4AofH7FM77mjaCadFR9zO3LEKeYV5FySKZrgSkAw6G0YMssZLt0o
	/OaeiUw8uUSlyrFcG+LffwuVkeFLyz4lV8Eba+Bq8pxUpX276U3suK8Bwbnsnpf+
	sx5KyFq/iBENDDoo6kAPA==
X-ME-Sender: <xms:iLrJZ6QYA7H3hYMDGMhiYnkCYFIPrykSVVFlFE3Szyc_NduJhDc-bQ>
    <xme:iLrJZ_zxml0d3MM782cKkG9AGZHtIdjmmOl5sCthbhzPGn7g1Zh-imlYxsLYMOW8P
    0vc5l8tk4sy4HlbmQ>
X-ME-Received: <xmr:iLrJZ33IEaQERnL9zT3l4N7IM-hbkTdReBxmpDYQ6mz3JTJIT5VtwYVPk6OI9A6ao_6n1m_6UM64HdELd73Uy_Y49nihup8dGledCcSa03A8bw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdektdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeefhfeugeelheefjeektdffhedvhfdvteefgfdt
    udffudevveetgeeuuedtkefhgeenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgt
    phhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhht
    hhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehshhgvjhhirghluhhose
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:iLrJZ2AX0lOaZBqNq2vvT-qU72OAxnK3XCc5GfG2MdyS8oa8n1_nNQ>
    <xmx:iLrJZzj4N3rkJG0SxD0gFnD3vRYq4cG5ho5EcpHF_XngZUx8e4lqzg>
    <xmx:iLrJZyqcXTfN8G0poX1o_t-PxLYFehijM0K6HZNHyOIp_RA-bivogg>
    <xmx:iLrJZ2jLfoL-OMtfdwh3UjJ8bEnbsW3KSD4DF6hQk3mno8fouNVUcA>
    <xmx:iLrJZzjz1BKB6Ik9O7m7mr4al5pKXfna9GbV07SZHcKUZ4InESA0y-TR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 10:08:55 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 74a449b1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Mar 2025 15:08:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Mar 2025 16:08:47 +0100
Subject: [PATCH v5 16/16] refs: reuse iterators when determining refname
 availability
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250306-pks-update-ref-optimization-v5-16-dcb2ee037e97@pks.im>
References: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
In-Reply-To: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

When verifying whether refnames are available we have to verify whether
any reference exists that is nested under the current reference. E.g.
given a reference "refs/heads/foo", we must make sure that there is no
other reference "refs/heads/foo/*".

This check is performed using a ref iterator with the prefix set to the
nested reference namespace. Until now it used to not be possible to
reseek iterators, so we always had to reallocate the iterator for every
single reference we're about to check. This keeps us from reusing state
that the iterator may have and that may make it work more efficiently.

Refactor the logic to reseek iterators. This leads to a sizeable speedup
with the "reftable" backend:

    Benchmark 1: update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD~)
      Time (mean ± σ):      39.8 ms ±   0.9 ms    [User: 29.7 ms, System: 9.8 ms]
      Range (min … max):    38.4 ms …  42.0 ms    62 runs

    Benchmark 2: update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD)
      Time (mean ± σ):      31.9 ms ±   1.1 ms    [User: 27.0 ms, System: 4.5 ms]
      Range (min … max):    29.8 ms …  34.3 ms    74 runs

    Summary
      update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD) ran
        1.25 ± 0.05 times faster than update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD~)

The "files" backend doesn't really show a huge impact:

    Benchmark 1: update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD~)
      Time (mean ± σ):     392.3 ms ±   7.1 ms    [User: 59.7 ms, System: 328.8 ms]
      Range (min … max):   384.6 ms … 404.5 ms    10 runs

    Benchmark 2: update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD)
      Time (mean ± σ):     387.7 ms ±   7.4 ms    [User: 54.6 ms, System: 329.6 ms]
      Range (min … max):   377.0 ms … 397.7 ms    10 runs

    Summary
      update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD) ran
        1.01 ± 0.03 times faster than update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD~)

This is mostly because it is way slower to begin with because it has to
create a separate file for each new reference, so the milliseconds we
shave off by reseeking the iterator doesn't really translate into a
significant relative improvement.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 8eff60a2186..6cbb9decdb0 100644
--- a/refs.c
+++ b/refs.c
@@ -2555,8 +2555,13 @@ int refs_verify_refnames_available(struct ref_store *refs,
 		if (!initial_transaction) {
 			int ok;
 
-			iter = refs_ref_iterator_begin(refs, dirname.buf, NULL, 0,
-						       DO_FOR_EACH_INCLUDE_BROKEN);
+			if (!iter) {
+				iter = refs_ref_iterator_begin(refs, dirname.buf, NULL, 0,
+							       DO_FOR_EACH_INCLUDE_BROKEN);
+			} else if (ref_iterator_seek(iter, dirname.buf) < 0) {
+				goto cleanup;
+			}
+
 			while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
 				if (skip &&
 				    string_list_has_string(skip, iter->refname))
@@ -2569,9 +2574,6 @@ int refs_verify_refnames_available(struct ref_store *refs,
 
 			if (ok != ITER_DONE)
 				BUG("error while iterating over references");
-
-			ref_iterator_free(iter);
-			iter = NULL;
 		}
 
 		extra_refname = find_descendant_ref(dirname.buf, extras, skip);

-- 
2.49.0.rc0.416.g627208d89d.dirty

