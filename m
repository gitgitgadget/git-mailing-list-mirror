Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F9A1D0E2C
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 15:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882205; cv=none; b=iR+2GsP7rDFg5jkD4HqjaHVD8E0EmfeKZyceJ7KWJJvfc4Gu1sJU71bHAvE9v2WcTlyleoE7iSe9ZYuWkMCqDJcae/8FOwv0C9MR3/VjCmhgii6d/8lvmE53wdWxRm5/171Sj7/4HKf3ydhSV9/vwOF+WM64BWNdeoCYULt8A60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882205; c=relaxed/simple;
	bh=8mLAAdaSmnqL8IIom6k+zH8Lgp21ZT75b8cfNJmOD/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zzsch7LmiO5QryRnfusOZMEB/Ao/HFBfsmz4+adG8eda/zlvPxnsetTJsgGtb9oKtP2drSJyvxbdf2TftrS2DSKHMXSV89a1NqYRFOSSqoZS1ISkRy5vv94a9eD+fu98Zi+HjNdMjTnW2+TYTmYj5PP/TB/l1oStQV3s2TRvIUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PvjUgyFF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QT8ddnN7; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PvjUgyFF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QT8ddnN7"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 3FA6413801F8;
	Wed,  2 Oct 2024 11:16:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 02 Oct 2024 11:16:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727882203; x=1727968603; bh=iOAo1ociDj
	bEq6ThWeb6q+NethTOJp5ixfHprP6OKWw=; b=PvjUgyFFHHBk3+ObgDYzf3uouI
	fx/2COyc2U4A/XBWz26pKNFEHnvDPilevUuCAcolZRxepFPFtbfe98/81u+lTNV9
	86grJ9OjiBNHQoYWjkcBGVzQ7YIBpNr1pYBAlLjqcnFXVJbEetbe5m03dA6akm85
	yk9x1fSpK/0AQOn9jttzSXEc8P87/shbIOYTCZWPukmbFPL0iIqU7ySDOqLi2nyK
	DbH2UjQ2b1nFbLy8PNYvmKJIljvN8oy2PPXQodzRX1tl5MympoCa8V+DlaNzhHyn
	9XGjhNx2K4ZUYjFvAnpdEogLrojaIFSpkIKdttdIGFmlpMXNtuNA6A411xYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727882203; x=1727968603; bh=iOAo1ociDjbEq6ThWeb6q+NethTO
	Jp5ixfHprP6OKWw=; b=QT8ddnN7eZePIGYHedJ1UlE/5Tc5FCXXJtcfoyb4uvM/
	kGUiIg3LsKrN4FW1RHX61eXT2ztmvaFRSfT02bfMGL4Fv2929/xrF0NF4Xsv3etq
	KAQk6hT3JNJHiGv6ciLY7hg1hWdHiot+0qFS4FhAnsTCGpvO79ivAQPuUjp3ieuw
	JBhP3weZXKERfJwnwm4/S9mvqtoCBPLVUoEeAOBz5yBTL9EWB5tNZaCKiOTpwmkT
	WFG2LWSw4iyxWy5jLDSY5lND+hJ4S6F60GXJ5QpVOnvqfHUlfrbb1fZE4NsYHjMy
	1ovY1UH0xzUg1leWnX+I89QgWNfAgIFO1r5Xc5t0sw==
X-ME-Sender: <xms:22P9ZqcIh_froWf13qA1JISHQWRtumO1Blz1OhlwYioyZJbGD1ocaA>
    <xme:22P9ZkPVLspQ_usR0GQOH5DXgK7UnWUNbCFCLks-ZUin44dlXeVS0bbMaRxQKAog9
    nSKju-m3Gsop4bMxw>
X-ME-Received: <xmr:22P9ZrhXr9Qv_e9Nz7uWx7SvG732mUhrLvCxjnSPx3aW109QSjOMlOiVZXLZ1m33bjZpxRgNqC5HKOMwYcYKD6O42q9-6yqDQpizfo0VJYaP9pDP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:22P9Zn8V-8ndOb4oI3HCTt6lv1_tjHx7Bby9AyrTOQxt3Xd3kiHUrQ>
    <xmx:22P9ZmsFkMQNcx-ce-jXnBcAtBZZliozbMzZnzQHoYuQAZxUIWfRpg>
    <xmx:22P9ZuEMu19CHkd9WtYK5VKBauWEEDrt0pidGvgJkmvbJMC64ix40Q>
    <xmx:22P9ZlMzQEBd7b5qjNsYMA_f1ccSkDRmmpgKoO_h89nW2y0HP3MfdQ>
    <xmx:22P9Zv40MMSOda5qjqK0jkZQOBO5S18XNM9-yEV8QSLf8zQXypjKZshY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 11:16:42 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 71b2bb40 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 15:15:52 +0000 (UTC)
Date: Wed, 2 Oct 2024 17:16:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>
Subject: [RFC PATCH 20/21] t: allow overriding build dir
Message-ID: <c5ae59ce905512aaf4d02d744da90eea982eb065.1727881164.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727881164.git.ps@pks.im>

Our "test-lib.sh" assumes that our build directory is the parent
directory of "t/". While true when using our Makefile, it's not when
using build systems that support out-of-tree builds.

Allow such build systems to override the location of the build directory
with an environment variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/test-lib.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index e36a21ddf7..6f862621af 100644
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
@@ -514,6 +514,7 @@ unset VISUAL EMAIL LANGUAGE $("$PERL_PATH" -e '
 		PERF_
 		CURL_VERBOSE
 		TRACE_CURL
+		BUILD_DIR
 	));
 	my @vars = grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
 	print join("\n", @vars);
-- 
2.47.0.rc0.dirty

