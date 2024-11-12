Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D561213EC1
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431020; cv=none; b=dTr+ojMYH7tfF4CCcwZxWExN3xl2kFAUqui5u7AVNNzecNI9WezAm4p+ngCG9XDj7/1znVdLW4ZqOdgUpXJhkoSOI/rEEg3ChPwdta4tqAZwzsaSUvGeiVFw8n9j9GYunbJEe7eIlmJ1EMUPZ1y2ZHmwpVy1GAC+aHsh/wyitjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431020; c=relaxed/simple;
	bh=LSQPlANZzosOh8UOFnnOOXWJeNsAwvG+PKn82z57Ky8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NXBBeMQ5U/nS/7MjCIpc7IYvsiv0vPLOplwlh03Ikp2opeXh+FMw9TtHd6zNZTVmoWaDsvTbzbWeJms/cfOVWWau+KbINX6Kx1q8yTWjXCijibefQkxHg+CHy315oZl8dMsZzDx5K8/84v+CADhQqR6Q5R+YVf1vLYEj7ALfjtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ApaNMnB/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C/zs2cSb; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ApaNMnB/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C/zs2cSb"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9868025400D8;
	Tue, 12 Nov 2024 12:03:37 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 12 Nov 2024 12:03:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731431017;
	 x=1731517417; bh=gj1LLOSIiq22b5YPpDU1ivYUNXnRvSgCm4h371ivbQA=; b=
	ApaNMnB/EyIygPBYjdkDVwO5Mpij/qBCtAr1tCiIDmge3F8BL3JHxQpRdW5+ZZSd
	Hif7aaVwVxIaxHgPThCD7QY4yGwDsLhALANAYwmgmLOTwFG9WGnJO/0vXaWc/Hax
	AdtJ/52Tweb5mygzNtJ6/3PAjd4aaa3V0RpVXj0Vm3NITrdZA/rlfgJw2CGJEddg
	JdlY+kcqnnpsdSyoHTXFiRSc5Fmxk6INzUjFpFt0srMANQn6NLqP8mWw4bbpn0YB
	QMf1qoWUAvJLo/9pWfNVwQxQLVTlsZ9QJGf7u7GgbbaFBjK2Y41C6+aVoMQcPgrU
	V8FaZaUz/EIRC/VtLojO1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731431017; x=
	1731517417; bh=gj1LLOSIiq22b5YPpDU1ivYUNXnRvSgCm4h371ivbQA=; b=C
	/zs2cSbOrBiVcKeAYADH582gTK3QZ1ly478LFBjMzSNOmKFaPySW6Vjb0LslMBaF
	iL6916dbUtTi09AdJ3TqpU3rIme0yWVfy6O9ZVoDPNRmd+0a0vuyrLGfWHAARj10
	pn44qFYtM8TtD03QPKL+O3EOO8h8xjcb5gBsvvlRHYcuto5fJi4jdvgGM4s6QYMK
	whKQNSSgGZ8A4PucLMWNDYqEF3GZmllwk5MPz0QdU0vYz31DNl3yqS/8mi6bVRQF
	TFqBFzH5oXgR/UhMPgOJ7qTKjybBtwFy3QJuAfMAaNp7jxXLNeJF+34E34M5CDV4
	21DrAMtox4PfOQnygfxoA==
X-ME-Sender: <xms:aYozZ40mt8NtD0b5O9gu0xsoDvwbHh9Lcw5nwu5jQrnaLzSKJZvYjg>
    <xme:aYozZzE0kPkHenWGG9WZri_8A8jxu_U5HFnPcpncrwJV4vAaO6sPCDSkzQLrtYh5y
    Yogs0PLB-h2oEJi7A>
X-ME-Received: <xmr:aYozZw6X1mPbb2hwqp35y6Htj4Qdb-BaIgPMBaG4KZzSwWV7iBJ9GWq0m-rBpJGV11vqc3Nrw4ofa1Ki-l8tjOnhTI8sc5FSX-IycIgSyFwQLjY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepgeduhefhvddujeeguefgjeelvddtfeeiueffleeigfeg
    ffeltdelieekueegjeevnecuffhomhgrihhnpehgihhtfhhorhifihhnughofihsrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhs
    sehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehphhhilhhlihhp
    rdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtii
    esghgvnhhtohhordhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhn
    vggtohdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvg
    hsrdhplhhushdrtghomhdprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:aYozZx1R4PcQsHbuv0MjRVZWiwAfMtGkwNX_bzorbl6pjGZ10Hmlbw>
    <xmx:aYozZ7FbYjyjbiVWc2n6TJUKvNxCz0jj4DJ7wP8RaFJ6cHcs3vDbIQ>
    <xmx:aYozZ6-sVJpAPemShTNLDPGgjJaDeq9H8SD-R8tnofjn6yfRZ1nRcg>
    <xmx:aYozZwlSJC-chMj1o_eLC5LY7iAbi4ELQChWQIQJGyD1M6JIcuL4XQ>
    <xmx:aYozZyDzz25hlMxq9zCDWZ50vibrZbHrIMqZRWd-bOdMH2thfFIaNm7I>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 12:03:35 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id db0bef87 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 Nov 2024 17:02:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 12 Nov 2024 18:02:51 +0100
Subject: [PATCH RFC v6 08/19] Makefile: refactor GIT-VERSION-GEN to be
 reusable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-pks-meson-v6-8-648b30996827@pks.im>
References: <20241112-pks-meson-v6-0-648b30996827@pks.im>
In-Reply-To: <20241112-pks-meson-v6-0-648b30996827@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

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
index 78e8631f677bbebe8f18d83191f0fd014465563e..671f853512a8cfafe85dc18ec5bf85e52018ca69 100755
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
index 28f5e96c4def70f2eed3675cfad665022ad91704..96b4a860f5d560344b680403574302761184af04 100644
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
index d2ec6cfc78f092f6299a624d5382d71fcb4d0644..689b76578ad1e39b09e0dcd62bfc0508cc081364 100644
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
2.47.0.251.gb31fb630c0.dirty

