Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DAA20E022
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 13:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733491544; cv=none; b=Bc3xgrrQq/8aa5CG5hZkE2/6d1YPxVRjNS2Ide2vn+i1gEPdRX94YpcChXKou3H7hKA6zUNZSiHJYk28eOwEv+10s/f7YN3q/+xNHIkbkP2ojQZCpWq72wLJryzukO4uhP5yryVx09O8m7ybjfpHNyw3fnJYNh4auaPQ4lpO9aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733491544; c=relaxed/simple;
	bh=0eZlWTbiTVyg+BqeYQ/8ycXhJhAMrXapkurJKoAm290=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n/Zr+5uORyGy6em/aA63D8dedmJVI8YlB5XdpjtzgPaIHyCmeGUE9Ux8b509fwd8ylYe2u/R4+uNFHb86AGcLZmfrMGD0iTeDSXsFOEzljD515LvnsX0/EPAcfQ9Gd57f2BJjTzj/iJT7Mm17Z8rr742rtpd7yQpzZVC8TqY2UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RsVM6StJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cCGByRtA; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RsVM6StJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cCGByRtA"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 67B29254017F;
	Fri,  6 Dec 2024 08:25:41 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 06 Dec 2024 08:25:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733491541;
	 x=1733577941; bh=9tr0q0jlgfimcVWS6KIHHktYxBimB4GL1nmB1NpNiZo=; b=
	RsVM6StJ5qae9Fi/KrihuJyEjkpJrRXWJoU5iwee8gMc+Z3dK8RFeYq0ckrwFvwl
	/oRQ8bu00CCdMy7TBSYy5iWzaFFbMwm8g7KzFFqEvPn7y4SbHL9w1qM8zmyaMc8B
	HFEdo2PLk2HvvPggJ5MxjDm1aQLyuT6G5OFbzn1BR9GGpToM60x/42Wirc0AHcAH
	P0ii2ZJr3VryPzLmZVNQ5hqMy4mFZWeoi7DEpjExWlYZ7TQrLmuM5nO08z9JSAff
	k+x3ks8fTGtOof8nXn9TRNbYCwhf0b18LSgNG7j/2nTwgb+69XPn0FOEBYYnrEhG
	Py9hzA0/CeSXjMUwONcz8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733491541; x=
	1733577941; bh=9tr0q0jlgfimcVWS6KIHHktYxBimB4GL1nmB1NpNiZo=; b=c
	CGByRtAwwIwR3ERKDoEOMnBiQqghkuRGIxM7MSzvD1WeKSuxCAN2wRY4BBmvTczb
	aVkzUAAq9gKHsL7eU14joZFHIoZtr9B0Ez7iUIUTuIpKrJ4rFSSozVhG/UIQLkRQ
	pDRCTQ/SrxO0L+3AaN5Pp3B/CnKEQc7Q05i6J+kzPtWD3QYeSFQ5hyrKr8t1VLOm
	HXhvIwdg4D2ORi/CpFrbM2PoSQIjBbE4XTShBh0iGt95XwMihf6IBbZ/47tiqxEi
	bn9nYE/pZ0zCMXlqXSmx/4p5pV447F2FMuoamPH/Os2OktL8Tsm0X1SxYVB4LRkV
	3Ahnt+7ajCF45T0sjXFyQ==
X-ME-Sender: <xms:VftSZ_Ftj2AEelQHcMPu76AsM1PXXfDkSGsvd541blAeHx5tRzVjkA>
    <xme:VftSZ8Vx-pmezySFPcSFJQx2eZryMHGcoEwdJ0nxFwoMFcyD_8xxs3-kHo2lEFGsf
    FYnLFdyQXZLLNfa-Q>
X-ME-Received: <xmr:VftSZxLH1UBMk1TvZ9_IEbuopSaYNcUK5-4XZZuj7i7FaXsTIJarE4lB50I_9KNiFMXiimtGg1WwQgBRwc5uLOU_KPmFleKJXLM4S3MOigfM3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdr
    tghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsuhhn
    shhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepvghstghhfigrrh
    htiiesghgvnhhtohhordhorhhg
X-ME-Proxy: <xmx:VftSZ9FaWxGB-SrOeya9DABJoppTgCL9WKPyeeeMIQl03XiirPmS0A>
    <xmx:VftSZ1U1bapXpvDFkwJSY17o2xt999B7V02Mk1qE8HZ1GSkLLm3RIw>
    <xmx:VftSZ4OvrA_7e5kV73osl8yaUCCqBwwiNiuZb3BJ8qsaNuLO-e6_bw>
    <xmx:VftSZ03-l6u-HnqPgwWhbSLBC0_LzbmDlSC0OUbvQohkuJ5CQGBrGA>
    <xmx:VftSZwOpKTqcYr4jfR4uWSvZXQeR9tH1AyKFSjyJ0VaAU1pDl8CXlkC3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 08:25:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8a8cf274 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 13:24:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Dec 2024 14:24:57 +0100
Subject: [PATCH v11 22/26] t: allow overriding build dir
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pks-meson-v11-22-525ed4792b88@pks.im>
References: <20241206-pks-meson-v11-0-525ed4792b88@pks.im>
In-Reply-To: <20241206-pks-meson-v11-0-525ed4792b88@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>, 
 Johannes Sixt <j6t@kdbg.org>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Our "test-lib.sh" assumes that our build directory is the parent
directory of "t/". While true when using our Makefile, it's not when
using build systems that support out-of-tree builds.

In commit ee9e66e4e7 (cmake: avoid editing t/test-lib.sh, 2022-10-18),
we have introduce support for overriding the GIT_BUILD_DIR by creating
the file "$GIT_BUILD_DIR/GIT-BUILD-DIR" with its contents pointing to
the location of the build directory. The intent was to stop modifying
"t/test-lib.sh" with the CMake build systems while allowing out-of-tree
builds. But "$GIT_BUILD_DIR" is somewhat misleadingly named, as it in
fact points to the _source_ directory. So while that commit solved part
of the problem for out-of-tree builds, CMake still has to write files
into the source tree.

Solve the second part of the problem, namely not having to write any
data into the source directory at all, by also supporting an environment
variable that allows us to point to a different build directory. This
allows us to perform properly self-contained out-of-tree builds.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/test-lib.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index fe688a3fce7a7bbbe92bf721ee483cabd87e4654..62dfcc4aaf959d0cf066d07663d939e14f92485c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -35,7 +35,7 @@ else
 	# needing to exist.
 	TEST_DIRECTORY=$(cd "$TEST_DIRECTORY" && pwd) || exit 1
 fi
-GIT_BUILD_DIR="${TEST_DIRECTORY%/t}"
+GIT_BUILD_DIR="${GIT_BUILD_DIR:-${TEST_DIRECTORY%/t}}"
 if test "$TEST_DIRECTORY" = "$GIT_BUILD_DIR"
 then
 	echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?" >&2
@@ -522,6 +522,7 @@ unset VISUAL EMAIL LANGUAGE $("$PERL_PATH" -e '
 		PERF_
 		CURL_VERBOSE
 		TRACE_CURL
+		BUILD_DIR
 	));
 	my @vars = grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
 	print join("\n", @vars);

-- 
2.47.0.366.g5daf58cba8.dirty

