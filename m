Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67BE801
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 00:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728432646; cv=none; b=UaqTc2+RlQNpPrRVQliI07fj2+0w2ZKkfpvzKAjE0XO+fWQ719mYW9/ZHtgI1f8fSIU+vBA3N7tuLGogG2Vr6q7IOnaLc4eLNwS+oYjVzO7hecBYzv/T7x7Vg0tSqqYHGdr8OyCqDWlZ7PXo09EZyYVwLk26z8cCLqNz2yaPaaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728432646; c=relaxed/simple;
	bh=aIeV/ln6avvN6u4RwlvxG0B+FWIBuzDwToh45jJB58A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pD8sDpb8FLR5NnLJ1rhzScz/mfNkuDISn7cIGZ/tUlddyiu2skMAQE9q0K5EC0mrUecpQMkO1dZQfQ/wh5mU0S3Q7YaAnNfUdKb5SF0GDFWfRPQ79fsDH5R/kKIaNqKCThdKyxxwdBaCYGFfX8NFsGPQFA8rhWwoBsYp3hAJo5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IQY3mQ+J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JYNz93iY; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IQY3mQ+J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JYNz93iY"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DD8D911401E3;
	Tue,  8 Oct 2024 20:10:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 08 Oct 2024 20:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728432642; x=1728519042; bh=6fbylkP4bt
	9t6fbFqQRqA11GfjS8Dp0Bear+OhCc44Y=; b=IQY3mQ+JF6ijBpKDcj9yEHT1FI
	Dmgeh/jqpDmU92wSKBx1sXw3MvzYssOM0lZdPL1M6OATFuIs63oI7aAF6fIigbtT
	x5C4Wqy7bnZ9bDczkaGFDhFDEpUmre2XmD8R+IkR2BneiNIvKq+5FfcaLsKQhv/I
	MGLsY4LIW56i6bRWulQszPJkC9g7OCh9/iO3ZLlf9FgPhSVF7cL1BhEUCL6VFqt6
	UkEQBrSp0PIEqAdkhgfRIBFfnLX2yAGPPVRetVfLBGmOZyFT6PBtldtHdRIPJXHJ
	deF+BglKJROlWjM1fyS8A9slXmAsYCM8v4Q9P+ExrnxUoLnhVLlFfwfRatXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728432642; x=1728519042; bh=6fbylkP4bt9t6fbFqQRqA11GfjS8
	Dp0Bear+OhCc44Y=; b=JYNz93iYIo9vvwibW4opJ0oESq/qz0qp9YmorAPb3cgk
	XqCkWDyWlq07yVFyVILKuGoktyFJg82sZm891indUOhVxZBoMRj9f+X+LWeXyIUx
	uDiAqzAseHAloDHhb6dv1PFw6nlFMuaenYWMYAb/rE5LzdrgXa+wdmal+g+Ig0A3
	eY/D86s1a8hVFg0F24I9dH25L3dCwKvJo0x0ilUipzrtmtWawsGa3aGQ9/K2Symu
	M4/Qb1HSwqLtnnS/UlhjRteaGL4SlXob2ZRaLOfQi95UWSEzVhinOcIpZ6jk0g+G
	uvVSpRiuT90kOoezowl18rhz5aJbCLnsNXS7ByuEqQ==
X-ME-Sender: <xms:AsoFZx1KrC758coyPYX9AxpLzYwqTn14cHazkUAfvdqJqeLQoQ7HwQ>
    <xme:AsoFZ4G4o2rJ4ZEMO6JTqj6JwxwzXEJG54HGBxfNhiI4uK5Y3L6Jwu9jvUt_XNTqG
    wIdZL6SPJoWRxTUsA>
X-ME-Received: <xmr:AsoFZx7NxWvF0mrEa_UxslfBBdNXntd5EAkMYOIKncUwHZHgn-VemC7PP9ZTjfDRIDz-bc3GAmyjX86WdKg9K4TT3eWb1swL9VTJgFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefvddgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvrggumhhonh
    esghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtghomhdprhgtph
    htthhopehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvghmihhl
    hihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopegvmhhrrghsshesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepmhhhsehglhgrnhguihhumhdrohhrghdprhgt
    phhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprh
    gtphhtthhopehpshesphhkshdrihhm
X-ME-Proxy: <xmx:AsoFZ-21DPoPSCN-ABWrB7y9s7BJYfMkT8hyvSA8qLLzLoNRS1cBkg>
    <xmx:AsoFZ0EonFtOlcURd8DGImiVH9sZQkSrQ-ABgHLl2h3Nz-1DqOZJXg>
    <xmx:AsoFZ_8lekjUSxXbm0p6wM6f4gH4rwDPAvGoc50BzKINq8KK4nA5sA>
    <xmx:AsoFZxnZ1jVh7i_hNK_xmrikX06dHaG2TDNRFSkud9ZtN06dcL-itw>
    <xmx:AsoFZ4GwdcJqdHSztJa0jTY5fc2rE6vZYtJKPRohUER9Q7zW9TQ_Q8Ml>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 20:10:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  calvinwan@google.com,  spectral@google.com,
  emilyshaffer@google.com,  emrass@google.com,  mh@glandium.org,
  sandals@crustytoothpaste.net,  ps@pks.im,  sunshine@sunshineco.com,
  phillip.wood123@gmail.com,  allred.sean@gmail.com
Subject: Re: [PATCH v4 5/5] Makefile: add option to build and test libgit-rs
 and libgit-rs-sys
In-Reply-To: <2ed503216f8e14d7b516c488caf3c76ffcb15697.1728429158.git.steadmon@google.com>
	(Josh Steadmon's message of "Tue, 8 Oct 2024 16:19:35 -0700")
References: <cover.1723054623.git.steadmon@google.com>
	<cover.1728429158.git.steadmon@google.com>
	<2ed503216f8e14d7b516c488caf3c76ffcb15697.1728429158.git.steadmon@google.com>
Date: Tue, 08 Oct 2024 17:10:41 -0700
Message-ID: <xmqq1q0qxhj2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Josh Steadmon <steadmon@google.com> writes:

> From: Calvin Wan <calvinwan@google.com>
>
> Add libgitrs, libgitrs-sys, libgitrs-test, and libgitrs-sys-test targets
> to their respective Makefiles so they can be built and tested without
> having to run cargo build/test.
>
> Add environment variable, INCLUDE_LIBGIT_RS, that when set,
> automatically builds and tests libgit-rs and libgit-rs-sys when `make
> all` is ran.
>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  Makefile   | 16 ++++++++++++++++
>  t/Makefile | 16 ++++++++++++++++
>  2 files changed, 32 insertions(+)

After 

    $ make INCLUDE_LIBGIT_RS=YesPlease

running either

    $ make INCLUDE_LIBGIT_RS=YesPlease distclean
    $ make distclean

leaves

    $ git clean -n -x
    Would remove contrib/libgit-rs/libgit-sys/libgitpub.a

behind.  We'd need to add a bit more to the Makefile, it seems.



 Makefile | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git i/Makefile w/Makefile
index 41ad458aef..2acb5353d1 100644
--- i/Makefile
+++ w/Makefile
@@ -392,6 +392,9 @@ include shared.mak
 # INSTALL_STRIP can be set to "-s" to strip binaries during installation,
 # if your $(INSTALL) command supports the option.
 #
+# Define INCLUDE_LIBGIT_RS if you want your gostak to distim
+# the doshes.
+#
 # Define GENERATE_COMPILATION_DATABASE to "yes" to generate JSON compilation
 # database entries during compilation if your compiler supports it, using the
 # `-MJ` flag. The JSON entries will be placed in the `compile_commands/`
@@ -771,6 +774,9 @@ PROGRAM_OBJS += shell.o
 .PHONY: program-objs
 program-objs: $(PROGRAM_OBJS)
 
+# libgit-rs stuff
+LIBGITPUB_A = contrib/libgit-rs/libgit-sys/libgitpub.a
+
 # Binary suffix, set to .exe for Windows builds
 X =
 
@@ -3708,6 +3714,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) po/git.pot po/git-core.pot
 	$(RM) git.res
 	$(RM) $(OBJECTS)
+	$(RM) $(LIBGITPUB_A)
 	$(RM) headless-git.o
 	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS)
@@ -3892,5 +3899,5 @@ contrib/libgit-rs/libgit-sys/partial_symbol_export.o: contrib/libgit-rs/libgit-s
 contrib/libgit-rs/libgit-sys/hidden_symbol_export.o: contrib/libgit-rs/libgit-sys/partial_symbol_export.o
 	$(OBJCOPY) --localize-hidden $^ $@
 
-contrib/libgit-rs/libgit-sys/libgitpub.a: contrib/libgit-rs/libgit-sys/hidden_symbol_export.o
+$(LIBGITPUB_A): contrib/libgit-rs/libgit-sys/hidden_symbol_export.o
 	$(AR) $(ARFLAGS) $@ $^
