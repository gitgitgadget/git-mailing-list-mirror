Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA9019538A
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 10:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530924; cv=none; b=QxAb0HM/hIshFGlZhIF3tTBHjydh1nIy+WBOf5uIjrXU7zWGp3b9v8uGh7SBrA1QOFNk6jbuLz6lQHOcUHrBeWuCq1sTJFciCbJ70KxqJHyY94NfDlnK89DD1KryCbDR7AKa9hdAoOWS7PEKaO+8zBVtuCtrpP8A3GidzBgkzVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530924; c=relaxed/simple;
	bh=BvhyX2pIjwJdN5DI6FFPqgJLrLe8VcaT1j6XjwJCZdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIohei5MOHLz4JHTHZv41F8U6p3Ue5Phg51yubaq5Pf17dVvPxxvV0AGEuBqBw+j0u9kbkWnipm5BXHh4qQzW7xUPb7sLJ3UfRvYgShjLGfg/nSLr03jDWD7PzexCm/GpgWzV/JCNwf2d7OA4AWmN7r6db6P7VAxrOjJj5ScDrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MPJ4QxM3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QZ3ZvMCz; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MPJ4QxM3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QZ3ZvMCz"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A3F8E114029C;
	Thu,  5 Sep 2024 06:08:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 05 Sep 2024 06:08:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725530921; x=1725617321; bh=6H96m48SNj
	sEadvOmjTzNk/LklRhDlWQ96GodTyN23o=; b=MPJ4QxM3TjOrubuPAXvB0+S0E5
	EkPDg9H3lgyvb+QdxWXX8usXw8MM0c9qVQx7uAh2V+t2+DDdvrdZjlBJWucwMjEZ
	e1c9WcO/FD3BeAtpcaTdja9jOEQS4IEUUs5VdWqa6mUPp/OTPSPViQHuvpjc8+ng
	aH4+crz4aEpSIaqKZ6huyzh7fXvPmDiwQGFcB+V0CU4sp2TExO79z0isBtlrPGmc
	dC9qhcmXxZlfvu7Dgs9CyCAz8GVoEQKyDh9ukOE2C8Q55EhK6FST8hv8a78uwwN9
	ogFvBe9drgbv0V1Qt7HG8q+1ywdlTQvKTDY83+qB8A4Hs+bw8OvFBy20jkHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725530921; x=1725617321; bh=6H96m48SNjsEadvOmjTzNk/LklRh
	DlWQ96GodTyN23o=; b=QZ3ZvMCzcLWEFBo3pxbGWmmdPpeGUMEUMs9kfVo9BvBy
	JdJ7If7Cyw6pTF/j3x6JvreAopfB+hH3twwZIspmxTo5sz6y5+uo9xT3kVEkZXwD
	aeaAxOpp2qXRJDQXYiPWmrvllt5iXXxWqBiYmNjpPaf7y9oCOuAPAohJ8x7QNywY
	8hz8BTFYDRAyGL4y2PJJwLhBwfYpN0yb5WdHI1E7HPkdCIeHa7fFLRbdQ2GFWL6Q
	ji8ooV8JGIgwyH0FGGRwS+oBZkoKPls5wcCsBMtSczMdyXn02ANVriHD6/PPFZAU
	yZ1lMaz94HXQIZk4lZzeZxuO2OY1HxlodTfMHt+bVQ==
X-ME-Sender: <xms:KYPZZrGpg0PdoUcXqfDFJgwoUlpLcCOG6nIFVXCsx3FHaYKlx_voyQ>
    <xme:KYPZZoVipj7YIAoJ3pOECpektoHGcOA5c_o9ZEuu8d82KnejL1WxtpK3_OdoKuV0Z
    pncrWnycvgd2LTSDg>
X-ME-Received: <xmr:KYPZZtLIV0nehwPFeglO63Wlb4fOOQkZwu5NnJQWaBaLiC4hlqDjZUAEwxCN06s6jLjXAiy5lBKZZZ1DM_PxZT9UeTiwvd_r2cavwA7woKh3f00>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehledgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepnhgvfihr
    vghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegt
    rghlvhhinhifrghnsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:KYPZZpGZSJtzCf3mCumBQsEBUSzTTq3A04Cui2z9RLU_PoEeWC1j9g>
    <xmx:KYPZZhVt0eOc8tPUwz6Hm28eSnX3zhrvT1Gje9zwW-JA2rp_O6lJQg>
    <xmx:KYPZZkPsbm66k6E69TSC54PxPEi286DPEx_MWYVVno78x1_3v30xWA>
    <xmx:KYPZZg1c4AdHzJ52S5jHDYJRjaO0skCrjh4Eq7tcXJ8wOapejSpVRg>
    <xmx:KYPZZjLdYhsiYoG3ErzjHl49ehy54hgBqvyx2MHzb5jw1cQW15lEHKn2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 06:08:40 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 05fcb5b6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Sep 2024 10:08:28 +0000 (UTC)
Date: Thu, 5 Sep 2024 12:08:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Toon claes <toon@iotcl.com>
Subject: [PATCH v2 01/22] t/test-lib: allow skipping leak checks for passing
 tests
Message-ID: <fa62d0106a5d46678e594864ab36f4a656284878.1725530720.git.ps@pks.im>
References: <cover.1724656120.git.ps@pks.im>
 <cover.1725530720.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725530720.git.ps@pks.im>

With `GIT_TEST_PASSING_SANITIZE_LEAK=check`, one can double check
whether a memory leak fix caused some test suites to become leak free.
This is done by running all tests with the leak checker enabled. If a
test suite does not declare `TEST_PASSES_SANITIZE_LEAK=true` but still
finishes successfully with the leak checker enabled, then this indicates
that the test is leak free and thus missing the annotation.

It is somewhat slow to execute though because it runs all of our test
suites with the leak sanitizer enabled. It is also pointless in most
cases, because the only test suites that need to be checked are those
which _aren't_ yet marked with `TEST_PASSES_SANITIZE_LEAK=true`.

Introduce a new value "check-failing". When set, we behave the same as
if "check" was passed, except that we only check those tests which do
not have `TEST_PASSES_SANITIZE_LEAK=true` set. This is significantly
faster than running all test suites but still fulfills the usecase of
finding newly-leak-free test suites.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/README      |  3 +++
 t/test-lib.sh | 11 ++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/t/README b/t/README
index 44c02d81298..8dcb778e260 100644
--- a/t/README
+++ b/t/README
@@ -386,6 +386,9 @@ GIT_TEST_PASSING_SANITIZE_LEAK=check when combined with "--immediate"
 will run to completion faster, and result in the same failing
 tests.
 
+GIT_TEST_PASSING_SANITIZE_LEAK=check-failing behaves the same as "check",
+but skips all tests which are already marked as leak-free.
+
 GIT_TEST_PROTOCOL_VERSION=<n>, when set, makes 'protocol.version'
 default to n.
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 54247604cbc..64bd36531c1 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1558,8 +1558,16 @@ then
 		passes_sanitize_leak=t
 	fi
 
-	if test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check"
+	if test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check" ||
+	   test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check-failing"
 	then
+		if test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check-failing" &&
+		   test -n "$passes_sanitize_leak"
+		then
+			skip_all="skipping leak-free $this_test under GIT_TEST_PASSING_SANITIZE_LEAK=check-failing"
+			test_done
+		fi
+
 		sanitize_leak_check=t
 		if test -n "$invert_exit_code"
 		then
@@ -1597,6 +1605,7 @@ then
 	export LSAN_OPTIONS
 
 elif test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check" ||
+     test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check-failing" ||
      test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
 then
 	BAIL_OUT_ENV_NEEDS_SANITIZE_LEAK "GIT_TEST_PASSING_SANITIZE_LEAK=true"
-- 
2.46.0.519.g2e7b89e038.dirty

