Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33251A2550
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 15:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731339069; cv=none; b=UR/94pUSLYMQsY61xDzKlPzXyJr6GLbiCzQ9a5p4rhasJhkMt07lhwNymRaE28/timnRyM4TuGgDdheCuMM8Wcze9lK/en/8j2eDFJHbYvFnjOkRdQns3dbk0ntXPw93EAPHZxhnxRnueYH9XwAoGAsHiuNv8gb1OtYXJ29Vwh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731339069; c=relaxed/simple;
	bh=8VUWfI6r6NrnKNUf3B4l+KRiQ8Igs5derCtDYf8rhiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPG0bYhaeJpAVBQZRIZK2vWFZt22wR2MtFtDpmOPmBMBSEj3Ty6e/8K+snc1dn7L1L5tqPmQkHSMojzY+s1nGsBW1n58OPAD+m/n7H8DjCRhaxFX2bF/erALNm5q+5NjMnaVIcwiHH/49gGnmSBK8qhsjfb8hwbbhwlWfmuFMc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=49WKONUs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PLgX/akL; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="49WKONUs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PLgX/akL"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 146CC13801D4;
	Mon, 11 Nov 2024 10:31:06 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 11 Nov 2024 10:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731339066; x=1731425466; bh=IRi73Un5Ym
	T8Id58vlYsZTVOCXDpZCsdlqip9f4W9qg=; b=49WKONUs3b4A/Zt86JS+mqInEY
	Ym24nzX+427vym9//mk+25WzGQJLPJP06X2yjvvI+YMKa3bUC4bOsV6e7paRrp46
	55iELDeYs95yWGtXyGuGXTul/GBazKFlcttJrJeqxMQ6QGAkdRYmnf2Gh+r47q3m
	QuLuzUkzdJ04m7YVP80zyLN9wl/SRwAAwCdW2oWxqeb98p1/xlsplH+EUtJtpR7+
	yGqB2AtKc/E+0qoO55fB3a62/rKVAY049h4Hy/+dhQtf7XqkAj4ti1A0IyGWUEyb
	kq55hmgJlLebjtCgDInGmnrxvm3moa8EbQv7QVGZfo/KAVv0nPEZHarI+IQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731339066; x=1731425466; bh=IRi73Un5YmT8Id58vlYsZTVOCXDpZCsdlqi
	p9f4W9qg=; b=PLgX/akLR4OCbPbOyaW+AR4GEhl01VmIyMMP95OfaSe6z7y/203
	LLTvg1Vijvbc98RwJWMddMUBe8Vq2lZNVD1oXeb6z/y11Mw//IEYecApG386V32x
	1pFEZElCIbRy/z0l2NyWn3CxHZMT+6skdcIOlqA3I6ulRIOnjN3ls3Uw82zOUPYb
	RhxkWQJy9WAlgf+0efiTJO5wlgoeGeYxZsybjkdrHnTar8w6tL6VsnSs5yjAzMv3
	Zi5/+Zc6YES28uxBFARa1P+M12ycwYNA9YqS5LoPn+XsnDrszk6uuYSZMUBQsYhJ
	mSXbOPgkGXsRw51JZ2pLLmAxGck4BB690fQ==
X-ME-Sender: <xms:OSMyZxyGAd9TATFzmzcDaE1zRtiZPP9X1CVM8nlVkLxTeoY0zbFuwA>
    <xme:OSMyZxRe6YNrGvyQnYuyLIIosfB52B94UXavPZHj7QjrdHkosKTbFnETXnglf43L2
    fSmhd5rQ1y1YDXdYQ>
X-ME-Received: <xmr:OSMyZ7Ves96jETn87nc6QIzhMyWPXEb4I0Psq4oWDnhOOGPu2CAGb_jWWdpvJJu7yIdRrYcvSL0IK1CHsILfRZ5cn5fi3CgCM-9OGm6eLu6YJ7Se>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevudetudfgjeegudffteevtdfgkeegffehgfeljeetteeh
    ledtvdefieduudeuteenucffohhmrghinhepghhithhfohhrfihinhguohifshdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshes
    phhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehr
    rghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhhvihgusehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsuh
    hnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepvghstghhfigr
    rhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguud
    dvfeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:OSMyZzhdNYPUVIRlNkBpH4Q3cW11dnmr1H01Anb9TZwJe3fRdDiANA>
    <xmx:OSMyZzDFXIt-EOprurlZekcYE6US1aywPsg0rwmPPNweDYKo1aZ9HQ>
    <xmx:OSMyZ8Kxz5i6IQQ7Ddd-bnGtZT5VEhNds37baABEI3NSytN0f2HYfg>
    <xmx:OSMyZyCNmDdEIBLyDnkC38hJdaldV5snJoE3_XOS30zSzlBFUSGltQ>
    <xmx:OiMyZ31e-_NoU5ewOGxy1mIMxSi7_viLVWM84nH6Ye3pPd7M9G34-4Bx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 10:31:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 81f7cae0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 15:30:29 +0000 (UTC)
Date: Mon, 11 Nov 2024 16:30:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>, David Aguilar <davvid@gmail.com>
Subject: [RFC PATCH v5 08/19] Makefile: refactor GIT-VERSION-GEN to be
 reusable
Message-ID: <065d03468f07203f2a6b80aceec145936c2d0371.1731335939.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1731335938.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1731335938.git.ps@pks.im>

Our "GIT-VERSION-GEN" script always writes the "GIT-VERSION-FILE" into
the current directory, where the expectation is that it should exist in
the source directory. But other build systems that support out-of-tree
builds may not want to do that to keep the source directory pristine,
even though CMake currently doesn't care.

Refactor the script such that it doesn't write output to a file anymore
but so that it instead writes the version to stdout. This makes it
easier to compute the same version as our Makefile would without having
to write the "GIT-VERSION-FILE".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 GIT-VERSION-GEN                     | 12 +-----------
 Makefile                            |  3 ++-
 contrib/buildsystems/CMakeLists.txt | 12 ++++--------
 3 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 78e8631f677..671f853512a 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -1,6 +1,5 @@
 #!/bin/sh
 
-GVF=GIT-VERSION-FILE
 DEF_VER=v2.47.GIT
 
 LF='
@@ -28,13 +27,4 @@ fi
 
 VN=$(expr "$VN" : v*'\(.*\)')
 
-if test -r $GVF
-then
-	VC=$(sed -e 's/^GIT_VERSION = //' <$GVF)
-else
-	VC=unset
-fi
-test "$VN" = "$VC" || {
-	echo >&2 "GIT_VERSION = $VN"
-	echo "GIT_VERSION = $VN" >$GVF
-}
+echo "$VN"
diff --git a/Makefile b/Makefile
index 2afad000762..461f0216bf6 100644
--- a/Makefile
+++ b/Makefile
@@ -592,7 +592,8 @@ include shared.mak
 #        Disable -pedantic compilation.
 
 GIT-VERSION-FILE: FORCE
-	@$(SHELL_PATH) ./GIT-VERSION-GEN
+	@printf "GIT_VERSION = %s\n" $$($(SHELL_PATH) GIT-VERSION-GEN) >$@+
+	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else cat $@+ >&2 && mv $@+ $@; fi
 -include GIT-VERSION-FILE
 
 # Set our default configuration.
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index d2ec6cfc78f..689b76578ad 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -83,16 +83,12 @@ if(NOT SH_EXE)
 			"On Windows, you can get it as part of 'Git for Windows' install at https://gitforwindows.org/")
 endif()
 
-#Create GIT-VERSION-FILE using GIT-VERSION-GEN
-if(NOT EXISTS ${CMAKE_SOURCE_DIR}/GIT-VERSION-FILE)
-	message("Generating GIT-VERSION-FILE")
-	execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/GIT-VERSION-GEN
-		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
-endif()
+execute_process(COMMAND "${SH_EXE}" "${CMAKE_SOURCE_DIR}/GIT-VERSION-GEN"
+	WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
+	OUTPUT_VARIABLE git_version
+	OUTPUT_STRIP_TRAILING_WHITESPACE)
 
 #Parse GIT-VERSION-FILE to get the version
-file(STRINGS ${CMAKE_SOURCE_DIR}/GIT-VERSION-FILE git_version REGEX "GIT_VERSION = (.*)")
-string(REPLACE "GIT_VERSION = " "" git_version ${git_version})
 string(FIND ${git_version} "GIT" location)
 if(location EQUAL -1)
 	string(REGEX MATCH "[0-9]*\\.[0-9]*\\.[0-9]*" git_version ${git_version})
-- 
2.47.0.229.g8f8d6eee53.dirty

