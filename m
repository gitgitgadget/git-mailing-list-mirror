Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ABE405AA3
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 22:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959945; cv=none; b=guquhQZxWV48LdIEpGdqymz0tVV/8at6ePahOXmcR9DujyNHgSKcRfLgJZNcvxdHvkfSFd699zR5Yh5UwWYDieuYWF3i474cseT9xHwbQ9jezfrg4PDKjy7TS6ptc8K56ntnvYBUarSuZ5WczOo+bptiglSi+n4oer2OCZfqjjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959945; c=relaxed/simple;
	bh=lgexwyKSTJ6yWHnW18/3r3hc4u/h2gw/BPVBnU+l0qk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VHvs8oRu280fBad8L5nHf0T2+qUOJVI5Kv/8yoXZKghyQVBU8+HcfZoZfCAg23FldiZ8lOSHzAneJwowNLE9eDy4hGYAJdgFnqnG+Gd2lgUoZj/HSfHZkzCn3oVfPGF5yJvh3vGsE//2R3ugCb9BkRJlCe8BqhuYgasVoshifng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e35UtkL/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X6wvGPUl; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e35UtkL/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X6wvGPUl"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id EA8C51D00177;
	Thu, 19 Mar 2026 18:39:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 19 Mar 2026 18:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1773959943; x=1774046343; bh=Epenbkvr31B2VtaElj9KgI9+RuzvglAt
	Fm/7PcvX/8g=; b=e35UtkL/HWJZwKebL9B6113ABQka//c1HC6O/MrOO56x78ch
	/yEjKieqh6dNS7ElVZC9H1jUrEraKF+d+JJ1/ofKWjLZKtt2d7HkqFJNyYDg/y3D
	fBPuLZs8rQUBPIfqxBytorjZDgLdh2+7JyUizvF2eIoN6wgaL9f8qlcX5isbyFoJ
	z6wsHTW0J6558rgitpkapxBvz8gpURl1nAdxYIPNiw3KQ2M1z+ZKHyqw7hYhc5Rx
	5/dEWLAFgLieNgLUAvwvzBhqbGgJj2DtuzUB5kcC/K2cCG9nqLX3wYv2VTsoT5AZ
	fVEclFNL/k+tTwomUK/Ktjga37t24gDGEp4CBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773959943; x=
	1774046343; bh=Epenbkvr31B2VtaElj9KgI9+RuzvglAtFm/7PcvX/8g=; b=X
	6wvGPUl6NvI5xi8toHbUk+rz5aITl/yiBkuDMiqOTga6uoVQ3Grc8Hl61utD3Iwx
	+yaCH+bquzjVvlVr2rRtcFBdYNfa6RWt0VL/OfvhU2ifqNpRn/SIpq5LNlNsOeXj
	75srl30uudLR/AKJfQZrI0yt8h0jEb+l+Rt+GXGUbE7UFUNigdA6hd8omIxZ7bsI
	m0vBLOZcBa1QtKPLGrMIvqRH9IYfJ61MSu6FF9gC7ZE+kYbWYq+TP2/EuVyD3jsB
	XKMNfIIBxS1Il6nmdYgvK9I33JwbEVhK9zqFb0m+K19qwi6dbelft/l3UwKgCTmT
	C3kNy1Xhu/eR6xXtFE+iA==
X-ME-Sender: <xms:B3u8aZGD3XT8KUnp1zda8Wq9ZrCGmHh0dUILyJIKO8TT060_rV-y0w>
    <xme:B3u8aUXqxKaZN1_kLLFhpRX8Ah0e6fFg5P1B4TPgbppHJsDVTnSN70B0frHbT_Hwh
    mfMx6JgOr08XFgj8FE9IbeOts-qlSH3CFss4OmBkSDh-eQXpVA>
X-ME-Received: <xmr:B3u8aYyzNu6jwJt6HQBfI6_QIG8j990WIECrmjylORSliQ_geNZth7DCyC9Ai6D2hVsqJN-0YuHHobWyHFdf1xrSEpm8T-gAHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdekvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkfgggtgesthdtredttdertd
    enucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosgho
    gidrtghomheqnecuggftrfgrthhtvghrnhepledvfedtfedtkeefueevlefgleetieeuff
    ffkefhgfekveehkefhgfetjefhffegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtg
    hpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:B3u8aaODhKfm41cTJf2sAa6BT_x0dFlhV9TiXpnjvhE4ju9vP69UMQ>
    <xmx:B3u8aR78uv8cmfZgSeWPOImVDbg1afW5TbEYI8mN_eWEXoAj5kqZdw>
    <xmx:B3u8aTM4YO7OuQFZj-Mlb4DvZRL_f457eJKHzczvK-WIwg02bGb4Pw>
    <xmx:B3u8aXlyDtaAghaCfnVqeoz7kP2JP_BFbsMEPwZlGKsnZ60c1WbLqg>
    <xmx:B3u8aUeueA8w-MLtPGwSuQgNag66aS-OJeqLwDOxWLl2CHHe5ZWBsSBs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 18:39:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] cocci: strbuf.buf is never NULL
Date: Thu, 19 Mar 2026 15:39:02 -0700
Message-ID: <xmqq4imbigvt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

We recently noticed one old code from 19 years ago protecting
against an ancient strbuf convention that the .buf member can be
NULL for an empty strbuf.  As that is no longer the case in the
modern codebase, let's catch such a construct.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * Comes directly on top of my recent rerere.c clean-up patch.

 contrib/coccinelle/strbuf.cocci | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/contrib/coccinelle/strbuf.cocci b/contrib/coccinelle/strbuf.cocci
index 5f06105df6..13f0ad2679 100644
--- a/contrib/coccinelle/strbuf.cocci
+++ b/contrib/coccinelle/strbuf.cocci
@@ -60,3 +60,10 @@ expression E1, E2;
 @@
 - strbuf_addstr(E1, real_path(E2));
 + strbuf_add_real_path(E1, E2);
+
+// In modern codebase, .buf member of an empty strbuf is not NULL.
+@@
+struct strbuf SB;
+@@
+- SB.buf ? SB.buf : ""
++ SB.buf
-- 
2.53.0-816-g44373249a2

