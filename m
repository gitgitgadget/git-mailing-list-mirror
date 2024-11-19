Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8434B1CC8BA
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 11:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732017076; cv=none; b=qa59WJw0BhMPCWz8tnzTFMHupeYYyThqcoY6PxM7NZhaXbXmugOhNZrRMuohJoQmb8qFo9q+IaQ8s1GYtTO+vx34H+JUbzpVske2jrj48O0dIGtpugjQiwm3MMS8Ku/Zt1xZjFagGchVO+mtJbMFwWpAair+B4N+mQKagV+8l2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732017076; c=relaxed/simple;
	bh=JOG+2goF4QaDZP0IukZ/1oiIAn9CDdHDYwgk0lP1n0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u3j3lrOD/6V0n0AInFAGt80jzGNEm3U3UT2JFSrCaCMXCL3hMEhIuWWSVERftyd9Nr8sBqid2cukqtVRuTZYmeB4Wxm6P8iwQu2FDNXzfUoe+U/pI1t+KpKm88NWtNhMSi7RfzhOI6p8nsdMRsTg7i8ywQObwbiE79qDb2rSR/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=5N11c55N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U1cAlfMV; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="5N11c55N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U1cAlfMV"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DEFF41140126;
	Tue, 19 Nov 2024 06:51:13 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 19 Nov 2024 06:51:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1732017073;
	 x=1732103473; bh=jZ7Qz3xLxaxgjcvMjW8mKYfLl1e0wkVuI9ZgNauzOzE=; b=
	5N11c55NFrVsYFVu3P2L9zSVwjxb3yH+/7moISBtNIiNjyTRjubmbGALks/jYiKh
	wT3YNf9x+lTllf2tzaVskBOj35/5GxSt47Pg0QuJol0fUB+HBf9WxSjUtJz0fpck
	XSKrDuKbhdI9kwlkM8l0vZOAHRoWCcZyRfS/cLcw369IAgIFaxpZGzmL5XGX6enM
	/H+vu2kvrZHKKT3vuMtYv8d7kNowJfIfxlCNQqhCiha0tiOBrL76exx3e5+phh5B
	BHhWQ/yvck8rC31649y2KXtZrafUCv3wjgogC39IRJ0FyaWUP0VdPsq2sRUSjgYF
	NmnvUw+3Zh+vx1jSj3Yu0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1732017073; x=
	1732103473; bh=jZ7Qz3xLxaxgjcvMjW8mKYfLl1e0wkVuI9ZgNauzOzE=; b=U
	1cAlfMVTMZH+g0wsidwUwrNuCabiymTwpJSpQCA0sjaveibw9qBI1kjhPDSjIbG2
	jLAkcHehdkc5mvDFJKGF/f/4C3ogXdRYsfAaJ3HbsPcsC1EQ7ljwYGlndyDcrEcc
	dM5tvyuCaMybOjv1rfmu99u7lZggv6B94H1pKG54L0zBZ28wY7dMaUUZOMlF/7jI
	GPWr8q4iHTGbqP/j1HFEcZorKEGGlMG24dhuPut1REkezV/ZNOYIGaF6RP6Qp6Vx
	ry0Fzd/UAqtV345rC5ZkWUtl1LXr4mcNt/H0zQpwngLqgP4/1r12H0EmN0dFOzXx
	oJkhMex4i2Uw1wXTzzLlA==
X-ME-Sender: <xms:sXs8Z3BDNdB8NJofiwk-URC-v-oQsfU8gvbjM9G6ezdkumdr9PNFzQ>
    <xme:sXs8Z9hyehSF233dbuECJWtYrh_D1XmksxOiUPJBuTtIN08N1xOPCatVNtz2Q3St8
    gA1pYEu6Kd06Looyg>
X-ME-Received: <xmr:sXs8ZylO0eHH00QveU1ILH1tnc4XHFFZMs8bNoidbx5JadORyQ5uxGJAFr-ZUrmFkWdF5mT_7xaan0SfMyslmgTR2k9oiezsvIfxNY1GRmlnXCc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedvgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrph
    hluhhsrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphht
    thhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomhdprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprhgtphht
    thhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:sXs8Z5yJBhMDcT8CXIn7rJCKYwxNitmMTwJ_tPRipgH_iWZNOfgfNg>
    <xmx:sXs8Z8SDflmxoYW0tRoGCUSmqvSIDEc5mM02XVXvNqS0fJwXXaAhdQ>
    <xmx:sXs8Z8bO1ra4ZZEXmFegkoQSmm5mg9AqsfECSX2HMVLd-fdD_EOAdg>
    <xmx:sXs8Z9R_YZwt92NjIRwbjKoRnKRoiW_cXm44xybJwytIm3JAisdbyw>
    <xmx:sXs8ZxKPXXsIDbWiM2uc6s5hUo7J5eScSZXdAB1pSLa-aIUI_JeDGJ8p>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Nov 2024 06:51:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3a7e06b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 Nov 2024 11:50:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Nov 2024 12:50:57 +0100
Subject: [PATCH v8 20/23] t: allow overriding build dir
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-pks-meson-v8-20-809bf7f042f3@pks.im>
References: <20241119-pks-meson-v8-0-809bf7f042f3@pks.im>
In-Reply-To: <20241119-pks-meson-v8-0-809bf7f042f3@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>, 
 Christian Couder <chriscool@tuxfamily.org>
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
index ceb926c4258db853eeb50b2259a7f521501cf719..cce0069287af48a607bc24fa474006a47014ea49 100644
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
2.47.0.274.g962d0b743d.dirty

