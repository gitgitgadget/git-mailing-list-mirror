Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD6B2D8363
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 06:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759905955; cv=none; b=jlbOp9RXbQ5qNUqOWnAVGm2tH5tt9HoGZcq3M0YgHTcFxHok6q03u78jYp/o88Y2G6VPMaWwpQPjOtfyOOBLiDZDvNULYfAlNxLyj9dLFJvaLcBdI2sgTbKyUG+6+j41eu+JZJMMwGDEvtbbHNyMbQw23P3LE0B4agimazwIHOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759905955; c=relaxed/simple;
	bh=J8OOyWyk5Y2xDNzOaMXcYl4ZaIxCDKiwvWYC1/gGl4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6htoMKnKnJj+n2BHBiwr0O6PeI1bPMUNb/2m+9RARJHiQkEND7XanTcT3jk4mmPTLYopx8y2Fgu9BAVGFW22IOUx0QbqoXPuHK1nJtBrtr4F58uWh+YIlvp3SyCl90Kdr9unmhpocYn4ezmy/VDLVs1pI2Iu34sw47uLXFTw8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZPXZyUeb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JyeHmr0F; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZPXZyUeb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JyeHmr0F"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id CAED71D0025D;
	Wed,  8 Oct 2025 02:45:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 08 Oct 2025 02:45:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759905952; x=1759992352; bh=ZgJTBGjPh7
	IYnAMLP9nAZCuuswsc0gbqBUIFx+gZCC0=; b=ZPXZyUebvQGwqa2vBl26w9dfR+
	9sk7JDnktiYmHy4/dTob4OJ0qHPEyGKBGrOSMUI8Cy8cxoIDOeaPXXT4nr1vz/fj
	opQ+vDktN7zBCTdNyoAFR0yGv8Kb6tfrPCLBrSBqOXH9ICCni4jtTjvcpnOO3Wwd
	TK/HcFvf4N63XtNJnSQC46xLR4iS9XOnh0pmxDWcoAyV2B1k54pqXf2SSsBViioZ
	+odS/Itj9xKGYAT8BTa02UYSQNuRXhHmUZm1LlUDOIzIEodQSGqD7IkanOBrttdN
	g3I1mwvwLVJiQ4i1HKLT40mcEPo+FnBYUtqW7VY1JS9fehPkkQHBCEoWyy0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759905952; x=1759992352; bh=ZgJTBGjPh7IYnAMLP9nAZCuuswsc0gbqBUI
	Fx+gZCC0=; b=JyeHmr0FtNNSUwb+8Fz6tBzKDXL5w2FENLn3suWbYRQuzQwl+Pk
	J33Ok21kyDLk108Y1C8lSP3CDZNYRNL+K3juqG3cPbtwnh8PoN2CYCu0drkm9YDX
	1kvwBadsmIHN5tMUT1F1y1rAhByRMWw1u+Qv+V97gspTue9aqGLW/tBYaYh9Jx9+
	+IujjK8fyEA4J/gCZvHzUlkwCEecZyJNSaWhPGPhprCGw8/It+qm+25yiL69h7rP
	sulD+RwfCmYYLUakCyA13GAh7/jzEFBf4O12W824WIgu2opo/uabhL34pub3eU2T
	VInSGtjq6bvBi9vuhFsb5vI/ToIWtgehZcw==
X-ME-Sender: <xms:oAjmaKgwKVDQG7uwQFefel09tWBeb_hYpD4aGH-qg7AtLGPw_m5o9A>
    <xme:oAjmaMjRwTMPmIjKdV9JUVNRYsv3peXy6Fucm7gB2X2U3OAC1ZXAYtHN5uTcXOJvt
    n79Q08w6wwtYWKsoGnvtbNjiFUehJP7lCcFB9HqjMqGt10eXA3FjA>
X-ME-Received: <xmr:oAjmaCK_dTX697mUznc-sSwlwhEax-eo7KQbhaU1Rp7sJHcwCLH7o5XGx3Z68bFGZJ1hQg3d8WstOGWcvJGMzatP_cAjBWBY1XDowtMB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddviedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehrrghmshgrhiesrh
    grmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:oAjmaDFHL0ADS1EEwLH7bLBW6CzeLcH7AjkZvqfirN6mG5DUJVdWog>
    <xmx:oAjmaOSdfEPaEJuCakT_x3lATqg3wuzMfsAPDLZ6VzJJ8i3XFcHpew>
    <xmx:oAjmaHdTi--WJZS8CA7YKUW-s9t0dX_Woe-YCfa4RxU_C0OEe274nA>
    <xmx:oAjmaFrOxpcHqMejLPtv-XEKtMjIZEMMw2lNFi8NECRMvEZwFAD2bw>
    <xmx:oAjmaD-CtWxaNATVJkRuZVieEQ08dOk-34oeChmA8CtFwkaQk-98rZhG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 02:45:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8bf2c457 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 06:45:50 +0000 (UTC)
Date: Wed, 8 Oct 2025 08:45:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] doc: add some missing technical documents
Message-ID: <aOYImjMXcFkdwar5@pks.im>
References: <https://lore.kernel.org/git/bcb3b3a3-bb13-4808-9363-442b5f9be05f@ramsayjones.plus.com/>
 <20251002221233.541844-1-ramsay@ramsayjones.plus.com>
 <20251002221233.541844-2-ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002221233.541844-2-ramsay@ramsayjones.plus.com>

On Thu, Oct 02, 2025 at 11:12:13PM +0100, Ramsay Jones wrote:
> Commit bcf7edee09 ("meson: generate articles", 2024-12-27) added the
> generation of the 'howto' and 'technical' documents to the meson build.
> At this time those documents had a '*.txt' file extension, but they were
> renamed with an '*.adoc' extension by commit 1f010d6bdf ("doc: use .adoc
> extension for AsciiDoc files", 2025-01-20), for the most part. For the
> meson build, commit 87eccc3a81 ("meson: fix building technical and howto
> docs", 2025-03-02) fixed the meson.build files, which had not been
> updated when the files were renamed.
> 
> However, the 'Documentation/Makefile' has not been updated to include
> all of the recently added technical documents. In particular, the
> following are built by meson, but not by the Makefile:
> 
>     commit-graph.adoc
>     directory-rename-detection.adoc
>     packfile-uri.adoc
>     remembering-renames.adoc
>     repository-version.adoc
>     rerere.adoc
>     sparse-checkout.adoc
>     sparse-index.adoc
> 
> In order to ensure that both build systems format the same technical
> documents, add the above documents to the TECH_DOCS variable in the
> Documentation/Makefile.

I was wondering whether we also want to have a change like the
following:

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 6fb83d0c6e..666b0b6fbd 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -524,15 +524,20 @@ lint-docs-manpages:
 lint-docs-meson:
 	@# awk acts up when trying to match single quotes, so we use \047 instead.
 	@mkdir -p tmp-meson-diff && \
-	awk "/^manpages = {$$/ {flag=1 ; next } /^}$$/ { flag=0 } flag { gsub(/^  \047/, \"\"); gsub(/\047 : [157],\$$/, \"\"); print }" meson.build | \
+	{ \
+		awk "/^manpages = {$$/ {flag=1 ; next } /^}$$/ { flag=0 } flag { gsub(/^  \047/, \"\"); gsub(/\047 : [157],\$$/, \"\"); print }" meson.build && \
+		awk "/^articles = \[$$/ {flag=1 ; next } /^\]$$/ { flag=0 } flag { gsub(/^  \047/, \"\"); gsub(/\047,$$/, \"\"); print }" technical/meson.build; \
+	} | \
 		grep -v -e '#' -e '^$$' | \
 		sort >tmp-meson-diff/meson.adoc && \
-	ls git*.adoc scalar.adoc | \
+	ls git*.adoc scalar.adoc technical/*.adoc | \
+		xargs -n1 basename | \
 		grep -v -e git-bisect-lk2009.adoc \
 			-e git-pack-redundant.adoc \
 			-e git-tools.adoc \
 			-e git-whatchanged.adoc \
-			>tmp-meson-diff/actual.adoc && \
+			-e api-.*.adoc | \
+			sort >tmp-meson-diff/actual.adoc && \
 	if ! cmp tmp-meson-diff/meson.adoc tmp-meson-diff/actual.adoc; then \
 		echo "Meson man pages differ from actual man pages:"; \
 		diff -u tmp-meson-diff/meson.adoc tmp-meson-diff/actual.adoc; \

This builds on our existing linting rule and would catch any discrepancy
in man pages that we have in "Documentation/technical/" that isn't
listed in Meson.

This check isn't quite complete, there's two things missing:

  - We have an equivalent check in "Documentation/meson.build" that we
    might want to extend to also cover articles.

  - We don't have a check to ensure that our Makefile and Meson are in
    sync.

But regardless of that, the above check surfaces one more missing
article:

    $ make lint-docs-meson
        GEN doc.dep
    make: *** Deleting file 'doc.dep'
    tmp-meson-diff/meson.adoc tmp-meson-diff/actual.adoc differ: byte 3877, line 206
    Meson man pages differ from actual man pages:
    --- tmp-meson-diff/meson.adoc	2025-10-08 08:42:49.864991169 +0200
    +++ tmp-meson-diff/actual.adoc	2025-10-08 08:42:50.072988794 +0200
    @@ -203,6 +203,7 @@
     git-worktree.adoc
     git-write-tree.adoc
     hash-function-transition.adoc
    +large-object-promisors.adoc
     long-running-process-protocol.adoc
     multi-pack-index.adoc
     packfile-uri.adoc
    make: *** [Makefile:526: lint-docs-meson] Error 1

Patrick
