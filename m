Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A1C1D0F6B
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 08:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066382; cv=none; b=WZYpaqzXFWfaUhGNCWKy9bpTnDJk+Z4N7pB3EIsBNH9xbuD3cVcEI/G6MRatxkMGihbcnNQOs4ivQGbwXAC+Q6j+R7rvxmZGAachdfQABREUPy7AkZEeKv9kkk0CGJ5k0AM9kpqcAXZy9KopQ304MxuFZdvnKRgvb7upzAUImdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066382; c=relaxed/simple;
	bh=n0A7Jc9eGhxSM4IzpqM4TS3JdMe3whp3xtYH79sSuFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihb45M1gfRx5PJ3mtaijMmOsWct/gdZXv72/Tn+zWqAs7LGWKdNTI7ETPgqoqZ9G6jLt0ApNvKydbgOgcN62RPk9lSvPEnzPdRZoIOPzXz3NXJi1FobeNv3Rc3bM9CovV8L6ukZee7q3hQ1Eu1Pf0GgNirZwoNnutp6rFlDMB/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QjjLw7g+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b800QYPb; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QjjLw7g+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b800QYPb"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 805D913800F9;
	Wed, 16 Oct 2024 04:12:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 16 Oct 2024 04:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729066379; x=1729152779; bh=Y3q+0LDusJ
	XB3OB3K5AJ3qj6qWUbRw1RNRQDnKGedRE=; b=QjjLw7g+mYdn3Zt6mgpyCzyFyt
	+zfQ+W0ZuRmt7sEELtPp2B75EHdsxVJF2O7c5jOZJG2FJ0MW4vPRUtVp7iRxlov/
	14G77bhA+LKbiUrpDdBoi6yAENxjFfUBEOvcN1bx+OrpV/Y3DSKtF++9hq84jGsa
	0EHYAciJ4lFSAkulLln8igTDhZgUSJL83I8In+GXI5vqwTht7Lw8sWL5mwliP58Q
	5yD2YkqF3pXom1k8rBPmCnZvLbk1mdM+IweWEHxjknqnzwDmsY93XARkcF540V/m
	8g6tGdivzcfHYOMRzzujZZa3R33cnrJ6U+OZ9M22hCZDhLqxNjdAJ0NhOiqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729066379; x=1729152779; bh=Y3q+0LDusJXB3OB3K5AJ3qj6qWUb
	Rw1RNRQDnKGedRE=; b=b800QYPbBxO+wmQ/jftsIMPtaMweRnHPR+8WC0El6oom
	Ke4mbKF2AIw4e7khGqjmuOeFV8/iermRPCXcsdaLDOOhrnFdlKR17rWNz8+M8h0m
	EQPxnOdgsIuhJ1GGyRFYrv6zXJc2jo9b4vVRqFCvG5oNBRvWJdIbWi6GByuBz/vc
	9nM10MYcJq2hgCXs5my4AJhCGsH4bG08OJngcnoMADJ1r/wesq6jkUiqfADqLGyE
	piMuh48LLE0fvisbIY3tqbGSk+1e0OjPSBi7T7bEIyhKUMnlucKGlbicKgMvr4bW
	p+WElJsOjLXc5hjFOFKVPU+ijFGFL/3vpkKAhkxgqw==
X-ME-Sender: <xms:i3UPZ0uLRmJJEqm7k72Ux7fKdK_9Oh8uevY7lm1F24b72goij_f7ww>
    <xme:i3UPZxfNSPTyEySZwNnKdal-Ivd4ZYRAH0vgZNv0gBzRAZnJG7S-OIgE0B2jyjG8D
    AtXE3O5U_0mxvZ7nQ>
X-ME-Received: <xmr:i3UPZ_xU1mXulTqDNG4h_5cOzZvBnNu3M7NoILeJe3W5LV09LEHu8TkgDd1AixdmgWNdRHm69YgBp1fY9sdeInQp6Neb9UA2moFNhDudAFMYRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegledgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:i3UPZ3MD0BGQgCNiFerPhdwSOUW-r1c8_n_ihjkPbv844heP8yAjXg>
    <xmx:i3UPZ0-O8pxBv5wnGeQZcYTOzvvu-iToyNHL8z-lFw6RophRjXCIMg>
    <xmx:i3UPZ_Ut3PJcUGUxicRBt1jxuMfZnUr-XYecTYnIS0tfOiphwA7oow>
    <xmx:i3UPZ9dAg3_bC7BwBScQTMABsuXm3GjjWV1te4Kgd5FPqNju1QzfFw>
    <xmx:i3UPZzZ9_sMKyV4UQqoECs7WpZgFVDEvcJi4X1rW8X7hpbWuAZAVh49u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Oct 2024 04:12:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f9e4c3cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Oct 2024 08:11:41 +0000 (UTC)
Date: Wed, 16 Oct 2024 10:12:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 03/10] t/lib-gitweb: test against the build version of
 gitweb
Message-ID: <52d0b252a1ce73b0258301b836785b152c8ed066.1729060405.git.ps@pks.im>
References: <cover.1728906490.git.ps@pks.im>
 <cover.1729060405.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729060405.git.ps@pks.im>

When testing gitweb we set up the CGI script as "gitweb.perl", which is
the source file of the build target "gitweb.cgi". This file doesn't have
a patched shebang and still contains `++REPLACEMENT++` markers, but
things generally work because we replace the configuration with our own
test configuration.

But this only works as long as "$GIT_BUILD_DIR" actually points to the
source tree, because "gitweb.cgi" and "gitweb.perl" happen to sit next
to each other. This is not the case though once you have out-of-tree
builds like with CMake, where the source and built versions live in
different directories. Consequently, "$GIT_BUILD_DIR/gitweb/gitweb.perl"
won't exist there.

While we could ask build systems with out-of-tree builds to instead set
up GITWEB_TEST_INSTALLED, which allows us to override the location of
the script, it goes against the spirit of this environment variable. We
_don't_ want to test against an installed version, we want to use the
version we have just built.

Fix this by using "gitweb.cgi" instead. This means that you cannot run
test scripts without building that file, but in general we do expect
developers to build stuff before they test it anyway.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/lib-gitweb.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/lib-gitweb.sh b/t/lib-gitweb.sh
index 1f32ca66ea5..7f9808ec202 100644
--- a/t/lib-gitweb.sh
+++ b/t/lib-gitweb.sh
@@ -48,8 +48,8 @@ EOF
 		test -f "$SCRIPT_NAME" ||
 		error "Cannot find gitweb at $GITWEB_TEST_INSTALLED."
 		say "# Testing $SCRIPT_NAME"
-	else # normal case, use source version of gitweb
-		SCRIPT_NAME="$GIT_BUILD_DIR/gitweb/gitweb.perl"
+	else # normal case, use built version of gitweb
+		SCRIPT_NAME="$GIT_BUILD_DIR/gitweb/gitweb.cgi"
 	fi
 	export SCRIPT_NAME
 }
-- 
2.47.0.72.gef8ce8f3d4.dirty

