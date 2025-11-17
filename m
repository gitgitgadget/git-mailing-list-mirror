Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4002B325715
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 22:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763417088; cv=none; b=T3lcegAwmzOX8HB1Ncp5yechzxBIDceR7CBcE9uhSxL9PtBeMyBypkRrgRKt/SnxYi8xPKtOpLjhsZdLsgDGUvZ1iqbUetxEitKDwOSMf98ktD/aEu8I0W/q1+Onq5mgXSNXWCEr7b4cd0IR1AZMKIb1kV4QbpomwaoCfrqIPy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763417088; c=relaxed/simple;
	bh=8+i/VbqSBlk6lBWdqTm5xdAK1AaoGqy7A5lv2x7KikY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NsVwaO6esOZorb3Nc7zBhRVPZ07xW9P4H62+Mn6XT/8OjH3YtsAYy+e/VUadSWhm8RRvb6xAaR5sz9jsKi4yiFdPd1JacFGX5YKh+JC1LGAwBbnwA6109JFgb/1/rmdpdUpzWxTIniRE7aRFaZnlmxr/1aqKO1o5HvxmKR4vFbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Zd7IisC+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jTw35fHG; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zd7IisC+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jTw35fHG"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 5743EEC01C2;
	Mon, 17 Nov 2025 17:04:45 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 17 Nov 2025 17:04:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763417085; x=1763503485; bh=0QXwaJZVb+
	1U4FOhgq1LaZPmg8CErGlhbywk1X2hDcg=; b=Zd7IisC+fT04a59HF7bs8wXaAt
	OLLoXpbc199XgGXDnT6OMVNNNFkId3ftPUHZHArHy3xnp4W78QNECXdk9cpweL4l
	ugy3d2L/ezE1U+ht8w318WchfmRrcR5A7ScuAKdZEHjFQqdbZn2Jv1TednF5bxbk
	Fu6iAYL0puXOsqOY/Xt4cWdfSSRmN/iMEo99qyzeg+IPgvJRdEi9qnLBW85LPXSI
	mBG0rfOKbUslqDKiHOdSzCRo8KrfrYKbj5jPxjz6Z3MZmQ/5WLdiJb4FO6aA9eUd
	ugETr4j5tkqEz1xmyIPb2gxiQKP2ZV7g3AHXJX1vkYtXMSbqlGSE9zeCZnZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763417085; x=1763503485; bh=0QXwaJZVb+1U4FOhgq1LaZPmg8CErGlhbyw
	k1X2hDcg=; b=jTw35fHGLzWfTtzOst5bf/Z3xyvvnuSqXQr/vyCBXq8V4XR80gi
	VwpLJzSCQ8yn/QQRxGljPX+GA2FiLLH/kmwEk5evmzRNMzAD6w/FP2ZMcnRgCJQ8
	F7MydAkdguB2Xxg3/K+WAaVbwLyMYKIROmcaWS5qnEiQKv51vnbV12MK3ifZRcEY
	+/hqOCTiZg7fLhPqCn3uC36FTZbVJboPUGSKfscWrw8pbC9wV35Wpyu2YAQRIgCr
	xdc1BIGDMNnRBJShqF+Mjodjc4WVjnF6dGkdb5EECw3kRPlxUuvt/vBtHTxAZZ9I
	Yyfkbe0+bFA30CPmDo0qgYzg8yZofwXgcUw==
X-ME-Sender: <xms:_ZsbafO9suuCRocG1uaoB1vVUgKNHwfrYiIanBAqOhzlAnl83xao7g>
    <xme:_ZsbaQ_z9SqCq7pSjx6JCZhDXkSK9G1wnJCQO4_vFY0n5u9LvwbnAsuz524-f982O
    yb8hzFm_aUEdyktBnwbrfs5HGkxiEpkiPOhehNEBNcJiBJAOXsneA>
X-ME-Received: <xmr:_ZsbaTQF1sTVLyRS-7_1-qoM9sEK_z3gz8V43cWTCBeWKxoarhI69hwJg3Ieu_LYK6kUQMiGS0H7eKi9GEVBzQgvkYNO6_1uz94P>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudelieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_ZsbaSn93NTaAoYkazZsh02Spq9LdMMwiP14_CAaUE7WDmW7bRdstA>
    <xmx:_ZsbaTTWl8oXV2F14-sC5gaeuLlXjPLrfR7s3amiq6AUks9HYVDs7Q>
    <xmx:_ZsbaQM6n4vWcgiE6aQ7IVtGt_U-uX4f7blSzD5NmfBXjSezkZlCWA>
    <xmx:_ZsbacV4mR1c661PtB278Q8yTx1H1YoRBPDPoymtQK64pB1YpxSz8A>
    <xmx:_ZsbaQrCul-JenIwrQsV_M18VK0674vk-oKZz1ZOdPPUyFMnqbFgRG7l>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Nov 2025 17:04:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] make strip: include `scalar`
In-Reply-To: <pull.2004.git.1763409086322.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Mon, 17 Nov 2025 19:51:26
	+0000")
References: <pull.2004.git.1763409086322.gitgitgadget@gmail.com>
Date: Mon, 17 Nov 2025 14:04:43 -0800
Message-ID: <xmqq7bvoiadg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When Scalar was made a canonical part of Git in 7b5c93c6c68 (scalar:
> include in standard Git build & installation, 2022-09-02), it was added
> to all relevant Makefile targets except for the `strip` target.
>
> Let's correct that.

The motivation makes perfect sense.

> diff --git a/Makefile b/Makefile
> index 7e0f77e298..62f7f7bf56 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2565,7 +2565,7 @@ please_set_SHELL_PATH_to_a_more_modern_shell:
>  
>  shell_compatibility_test: please_set_SHELL_PATH_to_a_more_modern_shell
>  
> -strip: $(PROGRAMS) git$X
> +strip: $(PROGRAMS) git$X scalar$X
>  	$(STRIP) $(STRIP_OPTS) $^

I wonder why the original names git$X here explicitly, instead of
using say $(OTHER_PROGRAMS) that covers both of these.  I know that
the undocumented INCLUDE_DLLS_IN_ARTIFACTS knob uses OTHER_PROGRAMS
by throwing in non-programs like DLLs to it, so that artifacts-tar
target would include them, but perhaps instead of working around the
misdesign of that target, wouldn't it be better to correct its use
of OTHER_PROGRAMS and use it here instead?

The change (including the "strip scalar, too!" part) should look
like this, I think.

Also do we need a matching change to CMake and meson?

 Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git c/Makefile w/Makefile
index 70d1543b6b..a63a4adbc7 100644
--- c/Makefile
+++ w/Makefile
@@ -682,6 +682,7 @@ LIB_OBJS =
 LIBGIT_PUB_OBJS =
 SCALAR_OBJS =
 OBJECTS =
+OTHER_ARTIFACTS =
 OTHER_PROGRAMS =
 PROGRAM_OBJS =
 PROGRAMS =
@@ -2499,7 +2500,7 @@ please_set_SHELL_PATH_to_a_more_modern_shell:
 
 shell_compatibility_test: please_set_SHELL_PATH_to_a_more_modern_shell
 
-strip: $(PROGRAMS) git$X
+strip: $(PROGRAMS) $(OTHER_PROGRAMS)
 	$(STRIP) $(STRIP_OPTS) $^
 
 ### Target-specific flags and dependencies
@@ -3697,10 +3698,11 @@ rpm::
 .PHONY: rpm
 
 ifneq ($(INCLUDE_DLLS_IN_ARTIFACTS),)
-OTHER_PROGRAMS += $(shell echo *.dll t/helper/*.dll t/unit-tests/bin/*.dll)
+OTHER_ARTIFACTS += $(shell echo *.dll t/helper/*.dll t/unit-tests/bin/*.dll)
 endif
 
 artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRAMS) \
+		$(OTHER_ARTIFACTS) \
 		GIT-BUILD-OPTIONS $(TEST_PROGRAMS) $(test_bindir_programs) \
 		$(UNIT_TEST_PROGS) $(CLAR_TEST_PROG) $(MOFILES)
 	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) \

