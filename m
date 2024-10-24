Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E681DD0DC
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 12:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729773642; cv=none; b=ok1PiNUYiD1fiIzpZIPY1SfP2OHP/jDo2fHof7J2j2jORwLVKioSh+gwSJrYGHEKkZjskvJDnWbFnQVy0MiONjiGjKiLThTgLu8OvbINbpsrTcJ5X8zDdXrw75aUkRKvTQuQhNgvPTY61FqWR4wet3V85t0tLatq6LfVDSFKBTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729773642; c=relaxed/simple;
	bh=kosaii5aZD2WgfKHThiFlqdrv62DV7/42RwdIauvxgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rj6qCOA55WQiSXuj6qH+iSFTirPBO6s0Ldv+tPhOk9H6Toggm5y4yWo3o4auL7DLNFrK1+1laMiDi+d5arWm0iqePKJIERrkb91I7kOLpK9PC3aqpJ6mL0NyUg36crNpX4fIPpiJNZdvf8PByT7NvvkdiIiiDPwO4qwf0M9cvVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gqDABgNb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X/MxXTDM; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gqDABgNb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X/MxXTDM"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1FEB42540153;
	Thu, 24 Oct 2024 08:40:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 24 Oct 2024 08:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729773639; x=1729860039; bh=DD2gkmeVmo
	4p7zmSxdaJgIEP12PHlwZM+TjrgVR4CLs=; b=gqDABgNb3OOfbXYNRoT6C5tBiq
	NKV1nI81Wpedz7BhToQBiXBZZvOoz2vKwAvbl+0vDoZxltehIgsQT3EB1+aAgILf
	r7R3OLlO1MlEyYKsuDtpoJZy0dmtYzbXwPJPEIPEik1N5UumMseGUDYChWMpPA6N
	i5JeHz8JUaArH7zy7Pq/CgSMYH/cRYs6JBdT7ctoz7croklLTCOFhblexfS3bFes
	9fmEuaXAbnztZzaP90RbCy5v+G0zJwDG+z+j8K+8SSfF8k3gJAgfshCgHB2HL/AW
	Vu9qTRpWqc1MSi/pgKHr3oqBKfrRsrID6YfdNvSt0qulA/qREbw6KOKX6bHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729773639; x=1729860039; bh=DD2gkmeVmo4p7zmSxdaJgIEP12PH
	lwZM+TjrgVR4CLs=; b=X/MxXTDMLY9FFwnmFGZnNozxv/pVtQXq3czdK5E3Ujex
	9vjCqupS3DSikR3yhGP8Pn/aY43zmudvthJZ3bl28sjNT+fji+U3lVzBDJVU85/V
	J8G7Cnf8p14DxXvg/pBLyJHphwrKEXw3dd1uo8yQmu+bfTKD1lS/f8tRk4klrvtm
	eB9R57G2CTlcS+/KffcclD7+mxbcq0OnN3VT/rmWHFB8ixq+9eLjFlV+GHA7oPA0
	4k/jr/0gjZnLkZ9DdpXvF4R5j4V2mudmeVdOL3lZIgyjAw+T1cAnhKe53F63P8hO
	L76XVGoyhecneiwIcIBzInG4wpWGBDu2jt8LP/3HDA==
X-ME-Sender: <xms:R0AaZyOh09IgT3eSWwmf-PIe_2aAjXO8T1G0eV1e3NPXKt5I8MEZAQ>
    <xme:R0AaZw8qGxUYrP1UN3SlRpm0rMNBDuz-uDyzVLCTR5_h2PW6GVQ9f2KxJBJHJvift
    WVWInfnjoCs_L4wtw>
X-ME-Received: <xmr:R0AaZ5S6jiPI33y0lV3ou4Kg2ye-LeoFTbmDeQRhRUFCQmeIjM8AkgoK3g7h9Rxei9nX9nhwSfP54tNgYWamX9Zs7aBos6s2RJEgbaDVsRFIS4HD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejtddgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepieenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhi
    phdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehrrghmshgrhiesrh
    grmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgv
    sehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvg
    hnthhoohdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:R0AaZyvVufzep3-Dp5B4tavYfLCouw4Fiq316joIWdWjKfWZqmkcHA>
    <xmx:R0AaZ6cpjJrlR-HpMyJhrw8aWSmW95XszRztou6gHu3uTxT5zMKRlw>
    <xmx:R0AaZ21i9HPiBIQ1hjXpXjH0fgUWAUbgz4xHFGGVUxWDG4t_vHABPQ>
    <xmx:R0AaZ-9nlaQqWFUZb_rXOx-Pt1m-udLy6qe63MtkydMw89CnAyLVLQ>
    <xmx:R0AaZwtWbzOcKOHoUqOcCVQCu40P9QxcGHODsMCpSpxG8c05Rt5vVlTw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 08:40:38 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c94fba3a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Oct 2024 12:40:41 +0000 (UTC)
Date: Thu, 24 Oct 2024 14:40:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [RFC PATCH v4 16/19] t: allow overriding build dir
Message-ID: <205b038f9616cd8585618f51a444619d1e8490f2.1729771605.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729771605.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729771605.git.ps@pks.im>

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
index 677424ced06..096af9be6b1 100644
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
@@ -513,6 +513,7 @@ unset VISUAL EMAIL LANGUAGE $("$PERL_PATH" -e '
 		PERF_
 		CURL_VERBOSE
 		TRACE_CURL
+		BUILD_DIR
 	));
 	my @vars = grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
 	print join("\n", @vars);
-- 
2.47.0.118.gfd3785337b.dirty

