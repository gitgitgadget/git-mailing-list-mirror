Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79AD1AC43A
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734079750; cv=none; b=B6U8W2tYa9X/m0cCiUG6/omEIhzd8YA32nosDbBw9Yo7eGd3pFOApiKm9dhwcLHXtcrR3+PperB1y+SGRd4iztzOaWGCdb8UBD8GMYxWRMqeacjDRVZIxlaytP+n1MAQ/ukwNjCkqaEONw9iJZfJg1peHv7ZvS9Oa/TTS2+NZgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734079750; c=relaxed/simple;
	bh=1/KnOb5YzzedQzkWemHvhRjFUFijL1cT4r2FtXBNCOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MdAAAsZCIetStrEWw4qjaHpxFiRtSDkp6V9bk6QHFk5/IsZxTca+qnL57WQ7ukRSJftLDPZ1C3AyZEs7dahsRv627rkT84JTm42wZPf4rOV/FC3595JAsb/CE1Sk3vivSsAfOmsVryWubbz4070AeS0xVrFfojzSjOh5TeD2qGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FvIyjw7+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OKV1IVWg; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FvIyjw7+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OKV1IVWg"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 0B3171140203
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 03:49:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 13 Dec 2024 03:49:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734079747;
	 x=1734166147; bh=rjKltvnOK71IJhzU4YvGb9kMyVBHEFi/dJ6PKbGj2yg=; b=
	FvIyjw7+a3vz7TSjBq8xtDhi2upqNuNxkiAEBQt8pdjvwGCLKitJg9+88rTUaIs+
	SjWREOJApfoqc9PweUL3b7qtGE3zT/SaDjE+j6kLyF/pVQ3LRla85yQ8a3OlrW+a
	FdjStW81j8I8ItoWyfVGX/in20JruMpXvBGlgcySLrFY904Rdw6+iXvDMk9RIE7d
	jeNnGqbokPw+M2CTHrouAf5QnjYDwDF6BbmYUvLv/N6KIGuEhGnXXEFDvxWmpneX
	VmyKsreUQsxzjUB7C4pliWDz2wujkpZEGtQ7r0sF4x3mvKR+/roSvQJb5xbEfq4U
	+iHH4lRX9aQ1UPM2RAc9sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734079747; x=
	1734166147; bh=rjKltvnOK71IJhzU4YvGb9kMyVBHEFi/dJ6PKbGj2yg=; b=O
	KV1IVWgMP4yHOYUJwYauSHmjzd6pBvLJLyGx4zim07wS+KGRPcMR25Gz/jfzdL9B
	aq6Xc4t0NR2buYKX313FdPByTtDiO21SvM8hUJks96iwz7O6nFjOfl78yv4tIlDX
	LbAbJxbzlw82tk+3/TD/RaP8XosQ1ZL+o3Ne220Y3W6NzlpByboeBnBLwxFTNC9H
	D5C+4250gx02fT811uXg9YjWC3/CsYn1jaHaiVZeVpCdSB//brLvK7w1Tqw1pAPz
	0JjQ1DvnpwSZgaK9Ux55UGc0XAVad6ZTwO7COPk55FCofL0YzofrbmEZF36yCzP4
	q7nvTAEoA1XD6uhA6khpA==
X-ME-Sender: <xms:A_VbZ5GcfHwt6VwkcGc0nsetiW-J1rGfA8WKTRQfg98ndHsBUEnfbA>
    <xme:A_VbZ-ULW1FHRO0ICkR1iMu1aRWRGg-dEfcx2RNoQKbsClF_PVL_5W7-8b6p_i6hn
    OI6UdVAzeDwr1LjWw>
X-ME-Received: <xmr:A_VbZ7Im8PRmXrX614zHjnZFNKBV0WkP6Npv6JQFPooighh3bvJKaj_ZO99y03d2Kl_-L0_I6cHn47Ae3yl2uuQuo-zeYxgJKaE2vXSLuNsEr7I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeeigdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:A_VbZ_HR_1nppHXQny6-qcMbGMikLSh0bMvKEPAJkPgDIfsM1gjZSw>
    <xmx:A_VbZ_Wt-uz-I_08EqApTW4gtpd3Y1NHmhEPJ40zjTV5zViT0pfsiQ>
    <xmx:A_VbZ6PLyHOS1vACIxtvwUeIf5cCZm4fQujNevP86VTX2pswf-TIYA>
    <xmx:A_VbZ-23VDqN7SA_WW0wDT9EUj-WAsbol666S3F_Icn5BU-XyPC7cQ>
    <xmx:A_VbZ2fKip83wZF3rTlgEyvyZKGmFdufAH6J2bawvW7HWVSOMgrgq4Jp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 13 Dec 2024 03:49:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 55aa45d8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 13 Dec 2024 08:47:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 13 Dec 2024 09:48:36 +0100
Subject: [PATCH 07/10] Documentation: refactor "api-index.sh" for
 out-of-tree builds
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-b4-pks-meson-docs-v1-7-0c7895952cd3@pks.im>
References: <20241213-b4-pks-meson-docs-v1-0-0c7895952cd3@pks.im>
In-Reply-To: <20241213-b4-pks-meson-docs-v1-0-0c7895952cd3@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The "api-index.sh" script generates an index of API-related
documentation. The script does not handle out-of-tree builds and thus
cannot be used easily by Meson.

Refactor it to be independent of locations by both accepting a source
directory where the API docs live as well as a path to an output file.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/Makefile               |  2 +-
 Documentation/technical/api-index.sh | 19 +++++++++++++++----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 31c17f7d655e1dcbdde315115609b798363e7328..44f68e7a53843dc5ea24085d5f48b592d34aec41 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -372,7 +372,7 @@ user-manual.xml: user-manual.txt $(ASCIIDOC_DEPS)
 
 technical/api-index.txt: technical/api-index-skel.txt \
 	technical/api-index.sh $(patsubst %,%.txt,$(API_DOCS))
-	$(QUIET_GEN)cd technical && '$(SHELL_PATH_SQ)' ./api-index.sh
+	$(QUIET_GEN)'$(SHELL_PATH_SQ)' technical/api-index.sh ./technical ./technical/api-index.txt
 
 technical/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
 $(patsubst %,%.html,$(API_DOCS) technical/api-index $(TECH_DOCS)): %.html : %.txt \
diff --git a/Documentation/technical/api-index.sh b/Documentation/technical/api-index.sh
index 9c3f4131b8586408acd81d1e60912b51688575ed..296488557434b7fff60ab25f4246a4dc270729c0 100755
--- a/Documentation/technical/api-index.sh
+++ b/Documentation/technical/api-index.sh
@@ -1,6 +1,17 @@
 #!/bin/sh
 
+if test $# -ne 2
+then
+	echo >&2 "USAGE: $0 <SOURCE_DIR> <OUTPUT>"
+	exit 1
+fi
+
+SOURCE_DIR="$1"
+OUTPUT="$2"
+
 (
+	cd "$SOURCE_DIR"
+
 	c=////////////////////////////////////////////////////////////////
 	skel=api-index-skel.txt
 	sed -e '/^\/\/ table of contents begin/q' "$skel"
@@ -18,11 +29,11 @@
 	done
 	echo "$c"
 	sed -n -e '/^\/\/ table of contents end/,$p' "$skel"
-) >api-index.txt+
+) >"$OUTPUT"+
 
-if test -f api-index.txt && cmp api-index.txt api-index.txt+ >/dev/null
+if test -f "$OUTPUT" && cmp "$OUTPUT" "$OUTPUT"+ >/dev/null
 then
-	rm -f api-index.txt+
+	rm -f "$OUTPUT"+
 else
-	mv api-index.txt+ api-index.txt
+	mv "$OUTPUT"+ "$OUTPUT"
 fi

-- 
2.47.1.668.gf74b3f243a.dirty

