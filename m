Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFDB1D14EA
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 15:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882174; cv=none; b=dQtRBQbazU4UhBzfWzaDEEnCbUFaBxhnrauzuYcX2ITDS14xXhFMHzg7+InQvttV+e/djquRWlbRipDEhp7GBxrJK/zpv/x2JfQEsv9pXJRUSo5Ln7jWQlPy42j7StPlR/7TgIl9iL/4fAQqkauOuyHlm5TA5S1kdPWLTynDIQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882174; c=relaxed/simple;
	bh=ZHikQOgNCMLy9BqMi9xwV6zKQ/P9jM9unmrS2+4ws0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8+JRcm0JeQN2eh7suPE4y8bk+JK2BSDgbdpdRIknkezva9qlIgBDI6p3WSNVlFvUel4j7CjSYgc+H7Vzq5ydrStYvlGx+XGGYNaANIMNtlLPedt3IGd6UeGz3V8kOch2LBKHjdVjcx8Ei07s93hMNgdrvApaEIbG3b2xVEadgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AbRZGEW8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YNs4fKCV; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AbRZGEW8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YNs4fKCV"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A5CC91140109;
	Wed,  2 Oct 2024 11:16:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 02 Oct 2024 11:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727882171; x=1727968571; bh=XgZAUMGLQE
	USrjffpURbdvHtxQmHZwfZl22PufOVwD4=; b=AbRZGEW83Dw0S3j0G0fRH7hoTO
	08i81wFilS5T/PHfMFWsHQneWrIzaamah2pHQWrFlfBrF5CH4JOKxNwdLj/5RpxW
	7nkolfbPUM7xTO6qg/JvqQevh49GkwnRy1YsrcUDQnzsCdU453q9tMHk7cVXOUkB
	3JUQnyT64Tmnaz/ho0uNXT+4AMGpCTNZf4enR7jCcnGzJKxa1UF7wh8XKwLYVNf0
	VQS+H3jjY6TWyf1amK76B/BeyakmGXzlQ27/8IqbajX/mMnbEKlMVAsJ+kq9y6nz
	d+Bhy4630sQwtEih0p9CEDAVgfuwTO7Vy4YNvEezt1wpAMf0Fd55IOeOtg0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727882171; x=1727968571; bh=XgZAUMGLQEUSrjffpURbdvHtxQmH
	ZwfZl22PufOVwD4=; b=YNs4fKCVFW7rFHlR45q1X3xIoL53zGLsK4tLyz8ImWP4
	crxKvXBsJNo0IsDIAEbwQ3WNifPPZBDpfoNYE+RA4SMy6eQDGwEsrwBH2cmVWmkR
	JlokpP0hOSczn8PSPtvFojIMSwZSedZ0DqUWFerzePPBys5U3nAcUJJnfvUZTLQT
	I6xRDPr+G7pMYTvDQP5XeE3++wa3p9VGY0GFTOQLGVYdeksdSq7Rxz07g+3tuCjY
	W7a5Ykt+fT/mTSyLizDObB74Rmm5xdoMn4Qntp47LNfWjH31isx4cOpBlF94N+X+
	DuYMx0J1qqX4VH0L5ozlRxxHOJmAXY1FdcJm5kcTlQ==
X-ME-Sender: <xms:u2P9ZjPgGgzJYrqaIGvvLsHCssmB-n0gPvaQXHaRI4NNrEkCWLwsCA>
    <xme:u2P9Zt9j2X0vkrma-HPZxwID5obdyltApGuLTS8kotobAy7aDVg9yjei6Ht7SIWKf
    04CNK9djbyfDs0E0A>
X-ME-Received: <xmr:u2P9ZiQ4PlA6EbjhihNYGV2u1m47t5wTI3kSmEn-K4F9C60IQ9-6Jsv14dN5-B3PjybJdVpWgA1ilxYrYjEkx_g4gTHm59j5G8ablgQhTOaFN0o0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:u2P9ZnurAU90BiU5oCtYOMz-OLSaQZZDGi2r9iiNTl8diIOgrb75aQ>
    <xmx:u2P9ZrdJbh8sD7yPyq-soZ483cbWk7IhO5G-rew49gWp1eLSpOjLKw>
    <xmx:u2P9Zj1pyp81mLSVbc9asbHiRIS6Y_TlMaQGW_APt14f6TSrdRFKUw>
    <xmx:u2P9Zn8ulUDBThhFc5jhbNe9ehgRV_3F0llAUB2tJ6_sDzFbXJYO0Q>
    <xmx:u2P9Zso2Pprj8yjyy7mfuD5gQeI69BBMo34S5xktimpd59xIsYqQEpnV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 11:16:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a50febc5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 15:15:20 +0000 (UTC)
Date: Wed, 2 Oct 2024 17:16:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>
Subject: [RFC PATCH 11/21] Makefile: extract script to massage Perl scripts
Message-ID: <ccfa97bd3db21f8868070503651e40e80ccb17b4.1727881164.git.ps@pks.im>
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

Extract the script to inject various build-time parameters into our Perl
scripts into a standalone script. This is done such that we can reuse it
in other build systems.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile         | 10 +---------
 generate-perl.sh | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 9 deletions(-)
 create mode 100755 generate-perl.sh

diff --git a/Makefile b/Makefile
index de6426a684..f582ccdc98 100644
--- a/Makefile
+++ b/Makefile
@@ -2580,15 +2580,7 @@ endif
 PERL_DEFINES += $(gitexecdir) $(perllibdir) $(localedir)
 
 $(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
-	$(QUIET_GEN) \
-	sed -e '1{' \
-	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
-	    -e '	r GIT-PERL-HEADER' \
-	    -e '	G' \
-	    -e '}' \
-	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
-	    $< >$@+ && \
-	chmod +x $@+ && \
+	$(QUIET_GEN)$(SHELL_PATH) generate-perl.sh $(GIT_VERSION) GIT-PERL-HEADER "$(PERL_PATH_SQ)" "$<" "$@+" && \
 	mv $@+ $@
 
 PERL_DEFINES := $(subst $(space),:,$(PERL_DEFINES))
diff --git a/generate-perl.sh b/generate-perl.sh
new file mode 100755
index 0000000000..b9e04d6f42
--- /dev/null
+++ b/generate-perl.sh
@@ -0,0 +1,22 @@
+#!/bin/sh
+
+if test $# -ne 5
+then
+	echo "USAGE: $0 <GIT_VERSION> <PERL_HEADER> <PERL_PATH> <PERL_SCRIPT> <OUT>" >&2
+	exit 1
+fi
+
+GIT_VERSION="$1"
+PERL_HEADER="$2"
+PERL_PATH="$3"
+PERL_SCRIPT="$4"
+OUT="$5"
+
+sed -e '1{' \
+    -e "	s|#!.*perl|#!$PERL_PATH|" \
+    -e "	r $PERL_HEADER" \
+    -e '	G' \
+    -e '}' \
+    -e "s/@@GIT_VERSION@@/$GIT_VERSION/g" \
+    "$PERL_SCRIPT" >"$OUT"
+chmod a+x "$OUT"
-- 
2.47.0.rc0.dirty

