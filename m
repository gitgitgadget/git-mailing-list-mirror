Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0BCB660
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 06:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738217870; cv=none; b=Bj4jTP9/t1u5DQJbwzoYH3m50b0xnHRqpZYI1ZXDcaBGapoL1jUPgZJpQWltZtK3GBXKYOMNaVAq8UN3POYnCrDL37PNTvl0bidIUkfOI6oF9aKY8CJZJ0IvhcoAuez765lzOnrwgS+MQorJvw7mtwm3Yzdze3jfsBLQvch/1mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738217870; c=relaxed/simple;
	bh=+bJiA1fhrUGwjRyYvLhCGGvPXj3XomyUo1grLlJNA84=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=nE4/VHOr3W2r0pAucF6ncPxQohWZjxX4+a6AiMsrOHRDsw9uaWDSSCaxtKi4PASVoeLvfOUMRkb9Y1UvmSBCNjwxHynRadNMms9GqQDgs7IAYQwQxOULnjE4dZ+YMug6TTAxhD1l69XRz2zfSHApn5rRljqxVCRI0kBEXKe+Eso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SI3EswM5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tSx8Towa; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SI3EswM5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tSx8Towa"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3594025400EC;
	Thu, 30 Jan 2025 01:17:47 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 30 Jan 2025 01:17:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738217867;
	 x=1738304267; bh=KCeZQJdqo7cdI5Yk+h5woukNnol6OGnoY9YSWv6G4EA=; b=
	SI3EswM5VuJU/n55drNPzCtWAT+HBI34It602PlQfQfDarBn/37+5VitmbEf4sTr
	/NGwg4i1rrJhxVhgRO9TjKWgIIJaRqekdpu9J1tQifsAgoxIyJj9S0qgEKqy6ty6
	nAwX3muzfTaRwtQvAKboRZcqfx72iUFTAyOR96FTg+MEbsb7UW0g4Mk/nGiUYdvg
	R0aVdLh7aC3vtlosjQB9a2cB/wdGyQ+r030ElTA1X5lIONLqtBo7yOvIuBWtXTKX
	SAT9O59yd7Wo17DSKbepFl9dddsqVqrE9r2nr6St48l2Jfb/1s5ON6iBkd4kRbsw
	zIzi/QPcr5brxkpGIJAUTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738217867; x=
	1738304267; bh=KCeZQJdqo7cdI5Yk+h5woukNnol6OGnoY9YSWv6G4EA=; b=t
	Sx8TowamceIcUOoINRoy4vEnaDLjBjq2Cli9v8t8vxQPeYdtqyEV5G2C+dnLr/C2
	8YtEjAqte/IQeP/Q+MtwwLfuk56BA76Zf7EGzlonsaEP+f745VxIeavZMXLyrKps
	K36codoAI+8NeZXVSDEkJAI+Jerc4XpGlhsXmos0teMA4fDXFw2W631wRdxf16wQ
	CJfoRA6JbN5xzR/LOloeYvzlrsXgU2JjNcE0Ok34SM0lZPHBbkeEIIsmpGrDDBle
	Y01wudMhho0w2MhFjUTuz6eQXC4+I+S1QMExcOZEr3RpljL3swjy1Zi231Ds3tjH
	nHkHVzXX0qnjppnC2limw==
X-ME-Sender: <xms:ihmbZ0-f0NUfMq4pW9xvl1cuz9sQQ4-Iwh8pSmKdAEJTc95jTbcl1g>
    <xme:ihmbZ8vqvh_lDUWcu89Isj5PEZzGS1oPZqzO4mjHLEWZJcAuZKuYlNnTkt1lelScu
    0TRwOkMjiM34n7rMA>
X-ME-Received: <xmr:ihmbZ6CywH8UDNFZvmNNBp-iIeOw3EO-TEz2uzF5SCiN9C4CGlBJF1to7BC-Rq0VCKRc2_9ceY35ZqrtYw-sCxJUcMxyb9edd8rU_-02UaXJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhufffkf
    ggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepteeuueehhf
    fhiedtueehtddtieekfedtudehtdehfefhgeffveeggedthfehuedvnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:ihmbZ0c66zVW1Sw3KON6dJ5YydPQ0KgjY42Qj73oFL7DUm1PWk_RaA>
    <xmx:ihmbZ5NeO9M0fgGoHkEy1KoprSqmLKpcmtfb6ET3XLCnYlY8X1EOgw>
    <xmx:ihmbZ-nyqXE8yafpCsIgDJ50W46WHsIxNfMSTMOxRIDKYLGql70xMA>
    <xmx:ihmbZ7tUA4VGcQNZWNMCU5wYTtTLCv3eQSOhz1HX9K-Pl1EmxG1ceA>
    <xmx:ixmbZyaLbs9DRHnKpYHETFnm3iFPNQ7xCgrvD_3u_oTBcIb8qOlyHJmQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 01:17:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 69b1f0ee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Jan 2025 06:17:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/2] Plug two memory leaks exposed via Meson
Date: Thu, 30 Jan 2025 07:17:37 +0100
Message-Id: <20250130-b4-pks-memory-leaks-v2-0-fc29dc7d4b19@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIEZm2cC/32NQQ6CMBBFr0Jm7Zi2QLSuvIdhUeogEy2Q1jQS0
 rs7cgCX7+f9/zdIFJkSXKoNImVOPE8C5lCBH930IOS7MBhlWqWNxb7B5ZkwUJjjii9yAsbV+ky
 tG8hrkOYSaeDPvnrrhEdOb7H3k6x/6f+9rFHhyVIjgqVe+asoRw7QlVK+nX73mbMAAAA=
X-Change-ID: 20250129-b4-pks-memory-leaks-2a318e5afec1
In-Reply-To: <20250129-b4-pks-memory-leaks-v1-0-79e41299eb0c@pks.im>
References: <20250129-b4-pks-memory-leaks-v1-0-79e41299eb0c@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

Hi,

I've had the need to play around with the memory leak sanitizer today
and for the first time used it with Meson. Interestingly enough, a test
run with Meson flags two memory leaks that our Makefile doesn't. I
haven't found the time yet to figure out why that is, but this small
patch series fixes both of these leaks.

Changes in v2:
  - Add an explanation why t0301 only fails sometimes.
  - Fix commit messages to properly point out the `-Db_sanitize=leak`
    option.
  - Link to v1: https://lore.kernel.org/r/20250129-b4-pks-memory-leaks-v1-0-79e41299eb0c@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (2):
      unix-socket: fix memory leak when chdir(3p) fails
      scalar: free result of `remote_default_branch()`

 scalar.c      | 4 +++-
 unix-socket.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

Range-diff versus v1:

1:  94205fa36f ! 1:  63fd407649 unix-socket: fix memory leak when chdir(3p) fails
    @@ Commit message
         with the original directory that we need to chdir(3p) back into, but
         then the chdir(3p) into the socket's parent directory fails, then we
         won't release the original directory's path. The leak is exposed by
    -    t0301, but only via Meson with `meson setup -Dsanitize=leak`:
    +    t0301, but only when running tests in a directory hierarchy whose path
    +    is long enough to make the socket name length exceed the maximum socket
    +    name length:
     
             Direct leak of 129 byte(s) in 1 object(s) allocated from:
                 #0 0x5555555e85c6 in realloc.part.0 lsan_interceptors.cpp.o
2:  a4b4b31084 ! 2:  9248925ca0 scalar: free result of `remote_default_branch()`
    @@ Commit message
     
         We don't free the result of `remote_default_branch()`, leading to a
         memory leak. This leak is exposed by t9211, but only when run with Meson
    -    via `meson setup -Dsanitize=leak`:
    +    with the `-Db_sanitize=leak` option:
     
             Direct leak of 5 byte(s) in 1 object(s) allocated from:
                 #0 0x5555555cfb93 in malloc (scalar+0x7bb93)
    @@ Commit message
         ever gets assigned the allocated string and free that one to plug the
         leak.
     
    +    It is unclear why the leak isn't flagged when running the test via our
    +    Makefile.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## scalar.c ##

---
base-commit: da898a5c645ce9b6d72c2d39abe1bc3d48cb0fdb
change-id: 20250129-b4-pks-memory-leaks-2a318e5afec1

