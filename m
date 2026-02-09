Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA36237E31D
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 15:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770650723; cv=none; b=IuHRcEvu+rTMoSKyuef/jWPgYcafSpoS330EdlbYM6La3/djPQFur7WNQKRzAfpUhA49aTNK/ynXI7hyB71bNe0inF8tTv3o3fG3k7Tp7wFNL/uABQtvhafHGoCD8/juEhXmapQuh2YcMyZzKsxteKHLLBKUyyBKsa6twG2e7Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770650723; c=relaxed/simple;
	bh=XY5ldasO+mMdKrugym32lJ2PUpLuFIYaM1iKlK9d04Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbHsHjdwKOh42mpTeCqZOGsimOP/CQXGIw28zOFLjvh4/DzwNTJ292HDfplsQ8UjqQTFL1MxHumw0ucPNoM7skRno0cGeW4xzPNk5ljZAbvoFlY/0DBaVikcheWAggIMQqsuEE2p0lCDg3ftkBoSWgaLlQguOjzXadKE8ddoT88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JJCdASiz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cCPrWNRN; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JJCdASiz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cCPrWNRN"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1B7397A01A0;
	Mon,  9 Feb 2026 10:25:21 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 09 Feb 2026 10:25:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770650721;
	 x=1770737121; bh=E36cdBdczLWauaVnnlcD52EOtI6/n/C9dSfoKOrz+sM=; b=
	JJCdASizYzgU35ZBADaYoj1bdwNo5JAKsHAFfZnmE/6juIOrVPucdGKTR0DY6QQC
	3bP7eJZWA2clG7KRmMxHrVcpMOHcx05ommzV/2bvyYoYghYGV1+JwYEO5GAdx41a
	nZ3qavLYxhyq1uHlM5ECF5fqu5fSt46JxIm9gdyDXLDY+y8lMhkyFoCeY/mFTcaJ
	eIw2OjWioFDG4KKP6Ak8wySRxjsI1xmh0tFkunyLnRv0p/OlaqZiRMEhotu+mHsr
	dazrTERVGFzvtyk5di78PPhoti99WQ5qSRBsxfrqeMPhoSiBcAAgxL1cyIr32Bov
	TTfLuJypDzJWputYF0aKQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770650721; x=
	1770737121; bh=E36cdBdczLWauaVnnlcD52EOtI6/n/C9dSfoKOrz+sM=; b=c
	CPrWNRNpEO+rVO3MxuGB+bX6y83QL46GHM1uBQHhMgHDP04z6XMLky6+6T6PZmd5
	nwWH6WENm1+Gkkkb8N5G+WZ4UtLzGxQPm9reZ1D79XEK3IR6NeI+FMKsuvhkoMLq
	LnZg0FxET+uq1hHs61ShZa73U17vKpqTVnrHkUbNXrVBh/Va/odvGhsagfuT1EOa
	22BnGQ06wu8cGcxeoHDw9F6w9LUevBbtXPYi2iYC9V+f2L4jslK/KYaRkb5xCBw3
	t0wGQEqXtqyp/hmPIOBeyM9qAIi0BuUo+eIyo5oGI14hi8XQPtBqGhgbH2njUWAe
	Ue1MZugwb/JIz+Co67fmw==
X-ME-Sender: <xms:YfyJaeeAbee-Bvu80yioo45Q_fYvnSXbdQ-XjXisknZHuwR19r8PeQ>
    <xme:YfyJafMsknW0ZkOhLjRzkR3ZrwIHNMby0wBnF1iU7Nm1QJ1512qdMLNBcLmze2OWu
    iPQty0tv0XwcEulpLxvV1DgsVXp9Moi0GW5WRR_5jzMZzsyApXWxw>
X-ME-Received: <xmr:YfyJaUiDjftcjWnJWX2zwCCMoKv3CbM2UTHUApT75rNV0qGu-6wJ9AUQPiBbfOY4mzlugeu162t2kbG6T3-yCzL8Z_3wjwz82nJPN1KIyXc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvghvrghnrdhmrg
    hrthhinhesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgdoghhi
    thhhuhgssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:YfyJaa2js46MY2ZUKQ4pVgCu8c0pVGI4VfOIQS7jwweTdnxPelQkqw>
    <xmx:YfyJaWhUR74-IkaIpXyYSV3G11OHbuzIlI6ldEc-Izoz4RvvtB-fqw>
    <xmx:YfyJaSeuqmjTmZ5sMbjxYV2Gkts-DONQI18BhKBPPz-YIMOcBGMi1w>
    <xmx:YfyJaRlEAs8wMvD-2ar0Ezyiu6nFuOK57kZQryEI-Pw8ko3mrKoMvg>
    <xmx:YfyJaYCTshyvuA8_YTbbvKqZ4aF1ZUvzAuiUgRQy7Ghkk1TahFvC0jhO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 10:25:20 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3bad4f0d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Feb 2026 15:25:19 +0000 (UTC)
Date: Mon, 9 Feb 2026 16:25:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Evan Martin <evan.martin@gmail.com>
Subject: Re: [PATCH] meson: regenerate config-list.h when Documentation
 changes
Message-ID: <aYn8XKv2hH2HX2xO@pks.im>
References: <20260207215924.28863-2-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260207215924.28863-2-ben.knoble+github@gmail.com>

On Sat, Feb 07, 2026 at 04:59:17PM -0500, D. Ben Knoble wrote:
> The Meson-based build doesn't know when to rebuild config-list.h, so the
> header is sometimes stale.
> 
> For example, an old build directory might have config-list.h from before
> 4173df5187 (submodule: introduce extensions.submodulePathConfig,
> 2026-01-12), which added submodule.<name>.gitdir to the list. Without
> it, t9902-completion.sh fails. Regenerating the config-list.h artifact
> from sources fixes the artifact and the test.
> 
> Teach the meson build to depend on the Documentation files that
> generate-configlist.sh reads by having it use the output of
> generate-configlist-deps.sh as a list of dependency files, since Meson
> does not have (or want) builtin support for globbing like Make.
> 
> Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> ---
> 
> Notes (benknoble/commits):
>     I considered having generate-configlist.sh write its own dependency
>     list, which Meson also supports… idk though. Input welcome :)

I think that would actually be the better approach, also because the
list of files with `run_command()` would only be computed at setup time.
I guess it could look something like the below patch -- please feel free
to reuse it at will.

Thanks!

Patrick

diff --git a/generate-configlist.sh b/generate-configlist.sh
index 75c39ade20..2c93ffc58a 100755
--- a/generate-configlist.sh
+++ b/generate-configlist.sh
@@ -2,10 +2,11 @@
 
 SOURCE_DIR="$1"
 OUTPUT="$2"
+DEPFILE="$3"
 
 if test -z "$SOURCE_DIR" || ! test -d "$SOURCE_DIR" || test -z "$OUTPUT"
 then
-	echo >&2 "USAGE: $0 <SOURCE_DIR> <OUTPUT>"
+	echo >&2 "USAGE: $0 <SOURCE_DIR> <OUTPUT> [<DEPFILE>]"
 	exit 1
 fi
 
@@ -36,3 +37,9 @@ EOF
 	echo
 	print_config_list
 } >"$OUTPUT"
+
+if test -n "$DEPFILE"
+then
+	printf "$OUTPUT: %s\n" "$SOURCE_DIR"/Documentation/*config.adoc \
+	    "$SOURCE_DIR"/Documentation/config/*.adoc >"$DEPFILE"
+fi
diff --git a/meson.build b/meson.build
index dd52efd1c8..03ad7a2152 100644
--- a/meson.build
+++ b/meson.build
@@ -718,11 +718,13 @@ endif
 
 builtin_sources += custom_target(
   output: 'config-list.h',
+  depfile: 'config-list.h.d',
   command: [
     shell,
-    meson.current_source_dir() + '/generate-configlist.sh',
+    meson.current_source_dir() / 'generate-configlist.sh',
     meson.current_source_dir(),
     '@OUTPUT@',
+    meson.current_build_dir() / 'config-list.h.d',
   ],
   env: script_environment,
 )
