Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2541A94A
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 00:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728348826; cv=none; b=swklzSU7SziS3gb7jkXHM8A3tJTeeV5yE7qBGeA8cd2ilZjVXk47TZvp3nyLKzDBRog0F+wnuEtgThCZWwt9aSiXNKNFiCDisGJAYYuXipt2eLoE7aNZ4/IjVCBCsaR614KgEaB3HUBYceQLMnrkEzDMhARatfc510y75xmwjrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728348826; c=relaxed/simple;
	bh=JnFh+ImPrT/HpVrQT4kVpQNWYJJZSYcdv8IOL9Y5Xyo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=quN7dl2AYQKv1CdrPSZB+IhleyiFeY/c78iV+W04ynuiAO6B2uELLBLCW55Z82NkK3xAVd9a87JMfaRdG4vM0ZOrvgzvJb0qZanBhMd+kbCt6Lqq55Ac9JMXdB2l9GSL40tZwrpZxuP3/EV72QJXyCiRblzuUQZFBSSndsyg6dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sp5EX73h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wx562C2r; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sp5EX73h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wx562C2r"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id A3BBE1380461;
	Mon,  7 Oct 2024 20:53:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 07 Oct 2024 20:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728348823; x=1728435223; bh=q57pyzOfM+
	HD2m3qFuzjqDWf6DUwxmpYrYp6+t9od6M=; b=sp5EX73hTpNAU5UW7iPwzP1I7L
	V5p9YxUt5KNTKiIA7L9C5BCZYysT4ZSCiOHLphY4HhnY+L5YW0fOANUqQ7wxX7lw
	WOUHiVv8iVWHvW0Vf2qDTsO0+uHMJKOHEBdWQn1fETBZK+ocKg9s5zxP9y7DTMIn
	d6RjGJoAo+PdZiVj7vTsVDNfHZfSJjvwFHU2bX7YU/OkSpA4rlCsH0yXBbb4nWG9
	BfL7fgygjuNzUpeQ9ZjwmuMIgrTCWOtC00scaxzG7TbaU7IIbtIiiSIBjBd/L8Jz
	7QmHhk+n/txjCAebJgmHr5lZGgfSGZwWgOpfKsCDI6lYKSGMm5kUOamuxh3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728348823; x=1728435223; bh=q57pyzOfM+HD2m3qFuzjqDWf6DUw
	xmpYrYp6+t9od6M=; b=Wx562C2r1scJU8WBShJ9ES0YCaK3+b7G0yqlgDoTvc9i
	rfS9WZqGruDUL1a1p0gv9GOQBfVjPE3a9LjvoMEu8cUcstv5zXezAS7KlpFYq2DC
	kXv8Dc8C7GTrX6q5FIWRjMKJGuJLCFlSckpnhwIrw4Vw8GSgLVb8T7kMlgiGzD0M
	ifU6nYid10P4xi48HUrd12Ffmo26iZC8oNEAnYLkazGfq3slPPuNY1Bj6yiY9Mwt
	6qvG/DRRO4W3RhFJmCn5Eo78R0NMcGSf7q85s1RTLIsYj07HlQUvpARuiZ75xtGa
	9ZqxhVFwGKGaQ5rz8cxjb246JuxEWTUTO98smpnxWQ==
X-ME-Sender: <xms:l4IEZ4_NCR7K-MnE6CgHkIBubSSS4oowGRitHKvrZZUWcew3yXKBCw>
    <xme:l4IEZwscpWLHITjxhRtvEQCO45VDNfG8I1z-A6e_Ob-SL6CfasE3f-7UIewpvKdD2
    k7zMxqT21aaAJIclw>
X-ME-Received: <xmr:l4IEZ-AqA7PUUcTmFEuuWznDoJHhLpKLU_dUCS8YoJjmxcBXHNNBw-tXTnZktrEOl_ru0BjcG_3DGiiJdIu7iEcQTPdAldhU7_IzPh4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeftddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefh
    tddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhsse
    hpkhhsrdhimhdprhgtphhtthhopehlvghvrhgrihhphhhilhhiphhpvggslhgrihhnsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:l4IEZ4ftQRxdXcZRZYyaRb4lh_KmUBc0l6ICpXMfvjvqoU0UprpeGQ>
    <xmx:l4IEZ9MwMYrYOknak6MwqF7xHIk3w34IzPb_0ec8Gp6m_8A7_Sb2NQ>
    <xmx:l4IEZyn4OYaUx4jENVHGd9S-7ZDHM_Lm0JKovIE2vIzOKKivcKcroQ>
    <xmx:l4IEZ_sQDQItA0lZdpGqaW6C3OeJyVmSqCWomuRET0b90C5xUsxnOA>
    <xmx:l4IEZw2Yu3C1-LuANEQGEKRESWr_rk7LE285QwlQZN9pbPC78_5kUZJE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 20:53:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Philippe Blain
 <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] Makefile: fix dependency for $(UNIT_TEST_DIR)/clar/clar.o
In-Reply-To: <pull.1810.git.1728323033680.gitgitgadget@gmail.com> (Philippe
	Blain via GitGitGadget's message of "Mon, 07 Oct 2024 17:43:53 +0000")
References: <pull.1810.git.1728323033680.gitgitgadget@gmail.com>
Date: Mon, 07 Oct 2024 17:53:41 -0700
Message-ID: <xmqqldyz76ui.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> The clar source file '$(UNIT_TEST_DIR)/clar/clar.c' includes the
> generated 'clar.suite', but this dependency is not taken into account by
> our Makefile, so that it is possible for a parallel build to fail if
> Make tries to build 'clar.o' before 'clar.suite' is generated.
>
> Correctly specify the dependency.
>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>     Makefile: fix dependency for $(UNIT_TEST_DIR)/clar/clar.o
>     
>     Hi Patrick,
>     
>     I tried building v2.47.0 and stumbled onto this small issue. It
>     reproduces for me from a fresh clone on my old 2009 Mac with make -j -l
>     2.5, it's a little curious that no one ran into this yet.

I suspect that nobody tells make to build clar.o (and nothing else).

Instead, the t/unit-tests/bin/unit-tests target is what is typically
built, which is part of $(CLAR_TEST_PROG) that has clar.suite as one
of its dependencies.

    $ make
    $ rm -f t/unit-tests/clar.suite t/unit-tests/clar/clar.o
    $ make -j1 t/unit-tests/bin/unit-tests
    GEN t/unit-tests/clar.suite
    CC t/unit-tests/clar/clar.o
    LINK t/unit-tests/bin/unit-tests

What is possible to happen from the broken dependencies is when I
did not remove clar.o in the above experiment.  We may rebuild
clar.suite and then link clar.o that is outdated without realizing.

>     I found it best to declare the dependency directly on clar.o, instead of
>     adjusting the dependencies of CLAR_TEST_OBJS on the line above, since it
>     is really only this clar.c that includes clar.suite
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1810%2Fphil-blain%2Fclar-build-dep-fix-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1810/phil-blain/clar-build-dep-fix-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1810
>
>  Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Makefile b/Makefile
> index 2dde1fd2b8b..b615de74811 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3911,6 +3911,7 @@ $(UNIT_TEST_DIR)/clar-decls.h: $(patsubst %,$(UNIT_TEST_DIR)/%.c,$(CLAR_TEST_SUI
>  $(UNIT_TEST_DIR)/clar.suite: $(UNIT_TEST_DIR)/clar-decls.h
>  	$(QUIET_GEN)awk -f $(UNIT_TEST_DIR)/clar-generate.awk $< >$(UNIT_TEST_DIR)/clar.suite
>  $(CLAR_TEST_OBJS): $(UNIT_TEST_DIR)/clar-decls.h
> +$(UNIT_TEST_DIR)/clar/clar.o: $(UNIT_TEST_DIR)/clar.suite
>  $(CLAR_TEST_OBJS): EXTRA_CPPFLAGS = -I$(UNIT_TEST_DIR)
>  $(CLAR_TEST_PROG): $(UNIT_TEST_DIR)/clar.suite $(CLAR_TEST_OBJS) $(GITLIBS) GIT-LDFLAGS
>  	$(call mkdir_p_parent_template)
>
> base-commit: 777489f9e09c8d0dd6b12f9d90de6376330577a2
