Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D29622338
	for <git@vger.kernel.org>; Sun, 22 Dec 2024 02:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734835679; cv=none; b=E7tTmMTlyvuBts+QfeDaHFwMYei03cFZ4EbNVAllo7+8hJxQeo5541r4XkW+27GodzKkjaGY6Ko3fTqqnP40y0p8Agc+PlKixkP3J6U4PzCPPkiuBBzf6nh1nkevulXXWxvJgtbbX2CBOamrjaqdVNiPUx2jE0p+xfNZWpsszkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734835679; c=relaxed/simple;
	bh=XHl1bf2/se6/7zsg0WgbYDb/wN161I6WlXib2HPr9rw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PCxCn1x1m1/jkHcN1P/5O9TPH/va80Pu5glUv/culRED9cTZsbqIHmYT7MYT/4Sihn5zVIxAbFpPwg2E90A1buoC+vZ/DIfkArECRr28LuQJZ5ex0ZDNQxRXurFLratwUL4SYJXwOfVRL6Z/PMW3jIWJ7P1SJrHNDzav72LKALk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=1xuUvZxB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=taRdfKPD; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="1xuUvZxB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="taRdfKPD"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id D399A1140164;
	Sat, 21 Dec 2024 21:47:55 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Sat, 21 Dec 2024 21:47:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734835675; x=1734922075; bh=geNtRWqLx6
	b/OllkbVqtKcLadJuQEQY4mgMhhTXCR0Y=; b=1xuUvZxBphr+7ZPDogDH20GtHi
	GfyX4GgV123inoF6YlhBM1dS45RTrx8dYs386jbgVZzTZIWD5xrTHz7drYjY4AtK
	Lj4KJXxEA6EP4s296C2fHR1Yww0j13vpfwDoTNJOXGfW3ZtdjanDfKGabHJIAAdq
	gbyovgOu7PT1cU9DsXN7zgL3H+Rxd73cKDNg+UyuLLHoOdPELb03okfyJXgb6Xgs
	8Jr8e+i20HnFJxcQLJDPTjvzQwz8XQFqxPH7U6thTnklEJCU0vsqkW7FBkZZeAhV
	E8D1C+gZ0CLBj3thgBeI50SSWXAskzX8OJZTtVC/WJaxpa9AHU+EyCU/vrZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1734835675; x=1734922075; bh=geNtRWqLx6b/OllkbVqtKcLadJuQEQY4mgM
	hhTXCR0Y=; b=taRdfKPD/kR0dbEccgPj7Fik7p+rkQYk9F0GVUnnDu4+OQHvop+
	/Py7VMGO7yiKtSbm9m1rs2D1BVIemIGhGC5vZEp20dxEzaZJSKL4kMPO5FUM7kZj
	931g9kMkjWORmthU1ayS0wE83kBcMsNYtBq/L3HPItmYXPfKFORA8Rm0B0KCG4QC
	HE7LSALWo0nd3YuJoIED32IqATi1GmRSIYQ4WCA+4TmaM0rcUowXyF7ST0zVOa1O
	l3p/9a22esXuLsXcmyWRPf9ExL5mmGJGnWpLrUfvde2uY/jwlNjuVrf+zqqPq4fd
	lJw1Bhe4HpfiqciigTqU4QBIlAJMn6qiaiA==
X-ME-Sender: <xms:231nZ4GhML7MlEMaM3uG92uVZCMw_Zn3sk2-iBUQbMfx0lEB4-jpYA>
    <xme:231nZxXGsLRWIVzvNrkqNXuuZnV7e1NcqcBlxoBDtpUHtKJKSORsnn_B5mtpm03VA
    t5BZdMgVRkvyy6dsA>
X-ME-Received: <xmr:231nZyKN94k13OAudF9herupMgtWe04N6vF2RyIzpruWHWrNGuvJukccm4jLcvN9uhuddFhGWIHKtQCYSPQSJ0Fon5MGkiReFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtiedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvggrughmohhnse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphhrohhlohhgihgtsehshhhorhhttghirhgtuhhithdrnhgvth
    drrghupdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:231nZ6EPbwM_UmLs0RaE6MD7_dDOwgD-xz0pS7LQDslsbs514NcQzw>
    <xmx:231nZ-URBIEm3N205gIwDgVp0J2mWJFLmPDLW-czrr3VVlrkN284fA>
    <xmx:231nZ9P40SzjXs5MCEqU4_IU3y5RP57hR2SSvqgv7F2HQeCm2jCl4A>
    <xmx:231nZ10VFor3D17VcA1vD2vmUlogg1rnoyK-0mDnQgZGO9N0syArbQ>
    <xmx:231nZ8wSgLINxCPXbge4Ms1D_0C-h29pk7WumHDBUqP_3Mnkf_te2T6l>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Dec 2024 21:47:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org, James Mills <prologic@shortcircuit.net.au>
Subject: Re: Git v2.46.0 and --allow-multiple-definition linker flag
In-Reply-To: <xmqqbjx4bgae.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	21 Dec 2024 18:30:33 -0800")
References: <CALGqR9+bH3nMrGqPQ18aqs-epSHRFQOtnd6Da55=KrtSu+Jrkg@mail.gmail.com>
	<xmqqbjx4bgae.fsf@gitster.g>
Date: Sat, 21 Dec 2024 18:47:53 -0800
Message-ID: <xmqq7c7sbfhi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> James Mills <prologic@shortcircuit.net.au> writes:
>
>> tcc: error: unsupported linker option '--allow-multiple-definition'
>>
>> I bisected the Git releases and traced the introduction of this new
>> flag to v2.46.0
>>
>> I can't find any details of this flag really or when this was
>> introduced in the GNU binutils and so far I haven't asked if the Tiny
>> C devs intend to support this option (yet).
>
> Would
>
>     $ make LINK_FUZZ_PROGRAMS=""
>
> help?
>
> The platform-specific tweak defined in config.mak.uname file assumes
> that you have glibc plus gcc or clang with usual binutils niceties
> once you claim that you are Linux.  It lumps all different variants
> of Linux into a single ball of wax and defines LINK_FUZZ_PROGRAMS
> Makefile macro, which is a bit unfortunate.

Having said that, I am not sure if the commit that introduced the
fuzz-all linkage rules, which is 8b9a42bf (fuzz: fix fuzz test build
rules, 2024-01-19), needed to do so in the first place.  With this
trivial patch at the end of the message applied on top of 8b9a42bf
(or more recent 'master', for that matter), "make fuzz-all" seems to
link things just fine.

Note that "make CC=clang fuzz-all" in the older code used to fail
due to something else from gcc+ (which recent build no longer makes
mandatory), but in today's code with gcc/clang/ld available locally,
the linker flag does not seem to be needed for "make fuzz-all".

Josh, do you offhand know what made us add the option?

Thanks.

diff --git c/Makefile w/Makefile
index c0cbed69d8..5af8935968 100644
--- c/Makefile
+++ w/Makefile
@@ -3848,7 +3848,6 @@ FUZZ_CXXFLAGS ?= $(ALL_CFLAGS)
 
 $(FUZZ_PROGRAMS): %: %.o oss-fuzz/dummy-cmd-main.o $(GITLIBS) GIT-LDFLAGS
 	$(QUIET_LINK)$(CXX) $(FUZZ_CXXFLAGS) -o $@ $(ALL_LDFLAGS) \
-		-Wl,--allow-multiple-definition \
 		$(filter %.o,$^) $(filter %.a,$^) $(LIBS) $(LIB_FUZZING_ENGINE)
 
 fuzz-all: $(FUZZ_PROGRAMS)
