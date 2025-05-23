Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA8B2DCC08
	for <git@vger.kernel.org>; Fri, 23 May 2025 15:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748012470; cv=none; b=pHByZsSivNa40CxTK8sKoJNzrHgAW5XRs+xXpvemzJWgDRSMVzLVaBsvKg/4j1CS+hXCVCJbODsGkfKtxMD+mUJdl9eYCxdG/VsJ0vIxwNM7XXX4HBmIRKsIwpsjF5zLDICt0u+gNNm/kiJVI8MVCH2ZCXYVMU4Sm24ITyrWuD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748012470; c=relaxed/simple;
	bh=W/7isK1XkMvgzV7lTU8naj4g3jDxQZF7ThZbyow7uBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KH4GaaJaCfz0PVWCmkYLgmcGGI4ZZfT+IS4pD4mVWe+B/kxpAgHVpbog4Vpo67qpkGjqRwNckWo+EllU1vIzZUXxi/S1cRt6ZF6XFBeAmscsJQg0hInNeK2WNaJ8xA+OhStOA/9vlczecjpfyqOntgu+uFgV4TT+eM0ORXqhmjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uWF3S1k5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P6T3gLCB; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uWF3S1k5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P6T3gLCB"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CE068114018D;
	Fri, 23 May 2025 11:01:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 23 May 2025 11:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748012465;
	 x=1748098865; bh=GVeRoZ2xr1DecS6vEztPZjSmtWdWg50ATRRQMN1g37c=; b=
	uWF3S1k5HsJ6mKTOI1yc3ZofNbQ91ONe4XvQBwiYII9ykpmIWQQf0oEkP+HoWCCH
	aWcJQrmhSFUuoRHL2nsDuIiD+aKnGvUR3qBI9IvSEPPyaFYw6LG1zcCujRKYWG+2
	/xGke5rBXB4rVumI5LmUMzNa3GFfF9rUb1np9nrRUy9oRYM/1XQsV0an97rbAQvi
	50esdxpj/Sa7FoIaOeZhlbywDyRkdauhZTCajjzDxD7Sin1lyYQg4RBrkfSHs7Kl
	jXyS73o1AeISUgI5WCRE/zCrQ6Uk0l8BJj9a29VV8r4SuUnilEerbcpDmQ/j8vpu
	OPgzO36/DakMnrcDFXuI2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1748012465; x=
	1748098865; bh=GVeRoZ2xr1DecS6vEztPZjSmtWdWg50ATRRQMN1g37c=; b=P
	6T3gLCBl0FvgvUV08kJQUmmeh4JyiTFJSksuIARXenR+LAvVbR0AnwFIrcQBYDqu
	EYsosRRFJhtyRB5daUbhbEih3ezCge6cJrWKtmdt80XAejwhaQ4RfWCG/syh9Rpe
	PNnX8yQtI/u/qF3B6mwVC4LCtkVWWAvydXfEY8tE8dU1gYiPDdm+dEJApOADYilP
	N6BSxCxwexIAaEDoUxh1Y0ja5x7sjerBNUHFJXCD7sSlF8hgnwuMXines32W6kzI
	SIJymznA1LHYqjd95JVU2F72T9nYK/iXo7bUJu/IoLzv4huvb9qqZAEcOcU1XY1B
	W3JiPDxA8U1Ni7v4XwrgQ==
X-ME-Sender: <xms:sY0waLRV2irDncURdL4yzWzXXknpahNygApigpECE8reTYuOMTQG2Q>
    <xme:sY0waMxR3MmW2eOj8MX8G63z9hCm2Mle6i0DfeL6Uh1D9Gx5dQAxB89jgbEgtXkKL
    oBilD2QCBOZmrjuMQ>
X-ME-Received: <xmr:sY0waA10vCuBtqTET-D3qh5obqMZW3vdGyNndx_BUblzEzY52hNA55JqFS1Lh3JDebJMdIuAd1-TRvuHi4MXUQAIYee8Wzi4Rgx1ky0yyJ_qOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeludeiucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhgg
    tggugfgjsehtkeortddttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrh
    guthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpefguedukeekffdtfeel
    leelffffffevveejieeffffffeejffefgfetueetgfefheenucffohhmrghinhepghhith
    hhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:sY0waLCDYHZ3fpbG3jgO79BawuzgfA4mnLdQ5yYlJrderLO1eqqfIg>
    <xmx:sY0waEj261-S0uzcEa49KFOWaiu458zp9J5hocvDmBq_SX91hed4jw>
    <xmx:sY0waPooA9Ik_h80vlig_bzeHCbkJI5sDQ1BZz_s1wZ-J-tjz-I_pA>
    <xmx:sY0waPifPkcZ2jfIiOpC5pS9_1wYSb70iTYcZisZxkdcCFACSm280A>
    <xmx:sY0waDOGHMefic-ZsOw3DH7zoFjyqedMJG7fwiWl0d4hAF1jMu5CJpLu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 May 2025 11:01:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bb849f47 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 23 May 2025 15:01:02 +0000 (UTC)
Date: Fri, 23 May 2025 17:00:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 0/4] meson: parse TAP output generated by our tests
Message-ID: <aDCNqRAoGygwnAbq@pks.im>
References: <20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im>
 <aC2xp4Cdb0j6OX-G@pks.im>
 <xmqqcyc2aqy7.fsf@gitster.g>
 <xmqqfrgx8xkw.fsf@gitster.g>
 <aDBH7G-oKKxAXWBp@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aDBH7G-oKKxAXWBp@pks.im>

On Fri, May 23, 2025 at 12:03:24PM +0200, Patrick Steinhardt wrote:
> On Wed, May 21, 2025 at 02:26:23PM -0700, Junio C Hamano wrote:
> > So the four patches are now sitting somewhere in 'seen'.  Is it the
> > one that causes this failure, I have to wonder?
> > 
> > 
> > https://github.com/git/git/actions/runs/15169816296/job/42656836511#step:4:2113
> > 
> > It is curious that only osx-meson is affected.
> 
> Ah, interesting. Seems like macOS has since updated to a newer version
> of Meson, so it now uses the TAP parser. And there are some tests that
> only execute on macOS and that cause us to emit output to stdout/stderr,
> which will thus break the TAP format.
> 
> I'll have a look and will send a newer version soonish.

Okay, the problem actually isn't the TAP format -- Meson copes with the
broken output, but I'll fix it regardless in the next version of this
patch series. The problem is that we have a test that unexpectedly
passes on macOS:

    ▶  868/1023 - git grep .fi a                             UNEXPECTEDPASS

The test in question is this one:

    test_expect_failure !CYGWIN 'git grep .fi a' '
        git grep .fi a
    '

The test passes if '.' matches a NUL byte, which we expect to only
happen on Cygwin. 064eed36c7f (config.mak.uname: only set NO_REGEX on
cygwin for v1.7, 2025-04-17) mentions that this behaviour was probably
imported from FreeBSD, which makes me wonder whether macOS eventually
also inherited the same code given its BSD lineage.

I think we probably want something like the below patch to fix this. We
could also have a prereq, but that prereq would look almost the exact
same as the test. It does make me question the value of the test itself
as the behaviour is completely platform specific.

Patrick

diff --git a/t/t7815-grep-binary.sh b/t/t7815-grep-binary.sh
index b7d83f9a5de..55d5e6de17c 100755
--- a/t/t7815-grep-binary.sh
+++ b/t/t7815-grep-binary.sh
@@ -63,7 +63,7 @@ test_expect_success 'git grep ile a' '
 	git grep ile a
 '
 
-test_expect_failure !CYGWIN 'git grep .fi a' '
+test_expect_failure !CYGWIN,!MACOS 'git grep .fi a' '
 	git grep .fi a
 '
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 6ce8570226c..fef522327f2 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1636,6 +1636,9 @@ fi
 # Fix some commands on Windows, and other OS-specific things
 uname_s=$(uname -s)
 case $uname_s in
+Darwin)
+	test_set_prereq MACOS
+	;;
 *MINGW*)
 	# Windows has its own (incompatible) sort and find
 	sort () {

