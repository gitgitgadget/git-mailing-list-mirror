Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E42A2E266C
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 06:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781765698; cv=none; b=Dl0O+myz2bue54UOQak3xti/7qXgc+v30El7sL+ZJA0cFboz/ob91SCLC+s+iMoABPreFF1+0BLVXIek2OJlUH9YNw9lsi0nQ4E5oOudqynD7AppywmTVSotYb2ky5g+lPTi+O3eyp9bY5pQV8v2Jxe72tdUdQCVX95qZU56U0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781765698; c=relaxed/simple;
	bh=uadQIWDLxg4Oi6fFUm1rM4IFonwNUjV3yuN+NmlxswI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t2LIgS7zSLWIo63LPOy8rSJNoCrsowDYVftGez4ZYFkrd8/yd6zHCFT4Z00ML0p9KiVNiiNWMP3xuMzEJtuiwamlzaYuguTI8aRnkzzlB9ggwMFeVIJWkZ1ET6Nm9SZLaDyKAP7lWseLhqkbO8CX7RAGPy99OZUCj23KNnx5NTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IEY5bX3f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kuOzh4PN; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IEY5bX3f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kuOzh4PN"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 963907A0179;
	Thu, 18 Jun 2026 02:54:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 18 Jun 2026 02:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781765696;
	 x=1781852096; bh=cZKQ64nSOPLF7kj1+LQLmrQAW9mvzOdGluhaiolkOrk=; b=
	IEY5bX3fiqjfhAleE9RrJS3l9frZhfjCQLl47G1zkBdn4QtbsSEknHbpyaZfCycy
	3L6ClTTTiXd9aIVMkshEC9YTZ3nhTReKVgWXpaWx6dGLHiJIkOY3z8bOLKFp3jKc
	aoAE7umhU7HV2xU70I04YFI3qZmAgI7FJT7W4A8X45B2R65iqtZi+xb30kPXSc9c
	P7NtBzsIdH08UdnN13TTHznZBpvkexB31B38xGFWpTRNU6a4YWrFY0SHuDPcuF7C
	BhHWI11UiVT06ckcCPPJvPOJScckIhp5bGI6SQc9xKjnbxKp3nmT/e85PoT9iQnf
	vkIamCYKAMplUQEIQCtAXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781765696; x=
	1781852096; bh=cZKQ64nSOPLF7kj1+LQLmrQAW9mvzOdGluhaiolkOrk=; b=k
	uOzh4PNAbf7yjHPaIrik0ih0O+RtNxPzRyHYE5F+XrIE9mb0oRnhnqhRBuwjhPWT
	rvFlV4hTjUi6oalcrKt7x96IZiY9CqJARlUmShC5VIfPGptDxBZlXUEhsAEJulhP
	ml+czMxfXrN26wxi+3t7sQPomSTroX0mBRQwvzYEyZf5zLLg5pGTt3qwYMB1490+
	WI+QAhZ6NBtLbKorXjcUfcQF/vLAY/SXmQbrvzVXN0f9RydiRCJAhWK0NeoI0+zI
	cAbM/LaXZe4iGer2QgKuX2pzHIEWGWZtwV1XWS4um/gcUrhut9bPtrSJ7KJ4yJ5T
	FW0Dp+dDvD/4XxXMXcFQg==
X-ME-Sender: <xms:QJYzavmqmuVhzBLiTas9KRuck11NL5StgwBIyB2Qq4zWy7LkrTWgtg>
    <xme:QJYzap1CMadGONVILC8N5_2YdVdc1Lse_drM_nriVzgFPG3_-VV7NeKzdEj-gJmxC
    XDqdSIa6A27kchMHtylv5b1mgcq2BEB-2Lp4zrxjzydHZ5dhkQ9>
X-ME-Received: <xmr:QJYzaqp4eG6Q_RTA0VLvmOuIzQHY77WSQ-lfYrO7H360OtbYCYq4GByIft45yZBLU70Wh0skjvjeYx6bJT3MAPPoLZI6geGWzXD-MRZ1sw>
X-ME-Proxy-Cause: dmFkZTF16Vc6Fi1Shyw28T76WpwZkHTVN+Wgz1OywlP32cWG0esYkIUzg//AHXodpv0DlG
    u1rxNG2Tba1tiQ2E35sJwpObqQCxjhpgtPWrjmWmzcltiQ1xq9rJOKaiFotv8ZgCAHr434
    3495Cq1kMuEQUE7F8vP58Y2zjk3OGK2suizKtlnYnTc3icPVoq2O+qvWiKSgoFBrivxRdt
    h3pQI4mgWTqH37zjWDXdU8k0MS+Bhb5fpE1yDBumZqvgfhkGr+1EIYzYY0NUY5XuQVshV/
    U5UJdmjP0HeOOxxozXhJ2QXPFMR1xqQafK2jirx91x5Yz+9aDkfmzWEJ11IJ+ZReG6iTDe
    GkzGOhF8DgUS1J0dm+pkc7xHHkFYEvlYnoGiS74FOxu745NA9g8ZTaPEY40URs/4FgOiOQ
    NhLFocbgHE5ypq3eJXjxs5tswjQEgZkvkkT31IbXGUxaIx+22ceKdoKH4lAw/gA6QR7tYy
    FE/P7NoJN01BVPEYsVvPA+tDlW7+ghN+ClzMKDEtEB8PXGnUiL4vUEM1E2+Q2sujXea1+d
    u7NKvTHvHDAo5ymALQCUqEaTIJTYX6kjUv/93hmajhwO+uXxzY5oJqa/q7OgjdJJnd2ecs
    05WqXqnB2VOdSQnxviY7WQiGhPodZP8shaD1w3tCM/VcT5ve/eIQbL1YuNcw
X-ME-Proxy: <xmx:QJYzamcqjMeEitcJjJm1RIprdLv4DBadK9ZKQcrRwmA5EcQOIEdnfw>
    <xmx:QJYzaprN-_rFTVv585oKNYaiEEG6piUBEjJzVZsH586HlbB4WB8l8Q>
    <xmx:QJYzanE0fXwXJaeXKyadY9dqdoaBOL4MZ6w8pwzTeD4C5y5xjkQG_w>
    <xmx:QJYzapvtg1x9cGOhAi5fc83eJhJKxoZ2ramyInTxhnZJdHiWw40W0A>
    <xmx:QJYzattKMQx1Ck7--YY9zRmk7T9E__f64n5CXSuXV9h2XP5g0bSpJOsm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 02:54:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9441d257 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Jun 2026 06:54:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 18 Jun 2026 08:54:36 +0200
Subject: [PATCH v3 7/8] refs: fix recursing `get_main_ref_store()` with
 "onbranch" config
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-b4-pks-refs-avoid-chdir-notify-reparent-v3-7-2a5669e8f486@pks.im>
References: <20260618-b4-pks-refs-avoid-chdir-notify-reparent-v3-0-2a5669e8f486@pks.im>
In-Reply-To: <20260618-b4-pks-refs-avoid-chdir-notify-reparent-v3-0-2a5669e8f486@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

When we have an "onbranch" condition we need to ask the reference
database whether HEAD currently points at the configured branch. This
unfortunately creates a chicken-and-egg problem:

  - The reference database needs to read the configuration so that it
    can configure itself.

  - The configuration needs to construct a reference database to fully
    parse all of its conditionals.

The way we handle this is by simply excluding "onbranch" conditionals
when we haven't yet configured the reference database.

The mechanism for this is broken though: to verify whether or not we
have configured the reference database we check whether its format is
set to `REF_STORAGE_UNKNOWN` in `include_by_branch()`. But typically,
the format _is_ already known at that time because we set it up during
repository discovery in "setup.c".

The consequence is that we have recursion:

  1. We call `get_main_ref_store()`.

  2. We don't yet have a reference store, so we call `ref_store_init()`.

  3. We parse the configuration required for the reference store.

  4. We eventually end up in `include_by_branch()`.

  5. We have already configured the reference storage format, so we end
     up calling `get_main_ref_store()` again.

We still haven't finished (1) though, so `get_main_ref_store()` will now
call `ref_store_init()` a second time. The end result is that we have
constructed the same reference store twice.

Of course, as both reference stores would be assigned to `refs_private`,
we leak one of those two instances. This never surfaced as an actual
leak though because the pointer is kept alive by the "chdir_notify"
subsystem.

For now, we can fix the issue by explicitly unsetting the reference
storage format before constructing it. This makes the mentioned check
trigger as expected, and consequently we won't end up constructing a
second reference database at all. Ultimately, this means that we
consistently stop evaluating "onbranch" conditions when constructing the
main reference database.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index d3caa9a633..e69b9b8ac8 100644
--- a/refs.c
+++ b/refs.c
@@ -2351,15 +2351,31 @@ void ref_store_release(struct ref_store *ref_store)
 
 struct ref_store *get_main_ref_store(struct repository *r)
 {
+	enum ref_storage_format format;
+
 	if (r->refs_private)
 		return r->refs_private;
 
 	if (!r->gitdir)
 		BUG("attempting to get main_ref_store outside of repository");
 
-	r->refs_private = ref_store_init(r, r->ref_storage_format,
-					 r->gitdir, REF_STORE_ALL_CAPS);
+	/*
+	 * When constructing the reference backend we'll end up reading the Git
+	 * configuration. This means we'll also try to evaluate "onbranch"
+	 * conditions.
+	 *
+	 * We cannot read branches when constructing the refdb, so it is not
+	 * possible to evaluate those conditions in the first place. To gate
+	 * their evaluation we check whether or not the reference storage
+	 * format has been configured -- we thus have to temporarily set it to
+	 * UNKNOWN here so that we don't end up recursing.
+	 */
+	format = r->ref_storage_format;
+	r->ref_storage_format = REF_STORAGE_FORMAT_UNKNOWN;
+	r->refs_private = ref_store_init(r, format, r->gitdir, REF_STORE_ALL_CAPS);
 	r->refs_private = maybe_debug_wrap_ref_store(r->gitdir, r->refs_private);
+	r->ref_storage_format = format;
+
 	return r->refs_private;
 }
 

-- 
2.55.0.rc0.786.g65d90a0328.dirty

