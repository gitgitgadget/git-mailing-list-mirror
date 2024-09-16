Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41471487E9
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726476613; cv=none; b=lF2er6FRR0fLX3NUxdXP6J79bmltO9qChp97NcOWZdcXKSDd99agGmQfz6JlctqZONK7/5SOpBsauelkJWKOh6F1CXVIdOLJQL/TXl72VP0Whp3fFn0t3iXnF013Jk7OakxW1+0gTREb5NBsqjtmubzZvY70dh/SVLyeB4lG/vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726476613; c=relaxed/simple;
	bh=/STtET+KUmqG4GjATQWlsDESGU9dQ6HIy94rOw+cBLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHA/G1hDBW9cYQX9T+LbRNj0hxVbmOnmViY+Jgz/m5kF+PzuWiskznkqNWSYIbQ7Gbypl3pJteHhzjZqA4eJj74uuOqXTg+hJIH2acNxI8BUU6A00RSFhH6qViwEbzHG2nB6CVJQFqJsAZ5GFNxCuj1WGeWaRst8pJNGFBlwS4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dNpNsIti; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lt6TTC0b; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dNpNsIti";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lt6TTC0b"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 00EDD1380299;
	Mon, 16 Sep 2024 04:50:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 16 Sep 2024 04:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726476610; x=1726563010; bh=0W/wlWW8bu
	/G1k/BYueYGbAG/1sFPUmDbzP1uL3q4bs=; b=dNpNsItiYolXCpu27+tB8laliD
	4kdrYQVR7x2vq0muEkD3emP5kXpv06xhj2acTSieFXNPLkJgGkFBAcz8yLNh0ErD
	ln6JSqKMKsnECoszIbiIRouLTkd4k7mnkzf2UxyUD3W0dxz3Vo/QKzyboIW+Dnco
	QjWOUBX/5rwVJiLty9tXF/3BtSvj2A2yyxTH8U8DlYHUol8sXfFT7MGBRGMTV+jI
	pKESyNRbybv4mwb5UbCUivGgWBvRPZuETw47hdIJGqKr6VslgZ8A0Z4FA//YLx4q
	rBPFVT7im4Irt7LM0o8ysjERNKQ2LJNau3M6vPzdMZ1n3qA7bG12cexALXQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726476610; x=1726563010; bh=0W/wlWW8bu/G1k/BYueYGbAG/1sF
	PUmDbzP1uL3q4bs=; b=Lt6TTC0bCmj2K6kZ8r4IhapPbTdw9qp/d2cqilgRCeFp
	YbcCS5CgfqPhHaM/24yNpvL6BugWz3gb5KcLAsrsIJL0wsPXnLXJ5Tkb8Gl7C+93
	J8xsaIP2SuLfefEP5taH6zi6jK0t4qQEpN0e9wWkVdog47qW1R4VeyVzRqaGnpcg
	pB7n1D4+Km00QmAE/09qWyMLi8Lpo+IMaKcuDqTNp9SSfBpRyPHWyaRo08ddT0KL
	zR+8rYBsS+Ylqg03h0AFtyojRBXKj/lzIC1l/b9N4Xs3kviHHNs7n8UBmMVpbY7j
	h2YO2bLlkC0DiODUxH9/O1g+rRrysBe/LXhIbySV8w==
X-ME-Sender: <xms:QvHnZmhmua71nPcYG3JPhuOqyEe6p9nwXQIyJujodwPmhUDwpHJTuA>
    <xme:QvHnZnAmyNahcVvrVjtdhQYKcyzUNW0518ap-Y33Hv9ds6T0yzbsTtHB3XkOXuRVr
    eEtmsDM-85TJBTlSQ>
X-ME-Received: <xmr:QvHnZuFVYcxr6c6Fwl8c9yK9x0S5ZOhL6AEyMu0fhsBTzZZ4Wlcx-Way62RbcvJH7tfuiXtvWs9yKXyHYp0jIUdBucpHNIShRIV1Em1ABPXR5rPq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    mhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:QvHnZvQi6QYwXkotnsoxWDvHs6vBFD72OANt-d-abQf-DKOKHvAT5Q>
    <xmx:QvHnZjze3nN3Vuebw1PKkf5GiCNbjcVaULBwHuTUGQHJMV7Y0yGJkw>
    <xmx:QvHnZt4jxfm5olBj3XxwfQE1vG6SXFi9Sd3sOdjFLEuepNaxS55HOw>
    <xmx:QvHnZgxLb35rRXbPBYLa8gs1N9YO8SFItKRFX-7_sQ-9oXM38l2e-A>
    <xmx:QvHnZj_nbpoi9y_Rs3sXc0BeIfuBQAs3Hgsi6fXSc93LErSRwsgnKPWk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Sep 2024 04:50:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 89cc8d16 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Sep 2024 08:49:52 +0000 (UTC)
Date: Mon, 16 Sep 2024 10:50:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v2 3/6] Makefile: stop listing test library objects twice
Message-ID: <4ba503520e6d306b7330fc3f3a4b4ee0748abf82.1726476401.git.ps@pks.im>
References: <cover.1725881266.git.ps@pks.im>
 <cover.1726476401.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726476401.git.ps@pks.im>

Whenever one adds another test library compilation unit one has to wire
it up twice in the Makefile: once to append it to `UNIT_TEST_OBJS`, and
once to append it to the `UNIT_TEST_PROGS` target. Ideally, we'd just
reuse the `UNIT_TEST_OBJS` variable in the target so that we can avoid
the duplication. But it also contains all the objects for our test
programs, each of which contains a `cmd_main()`, and thus we cannot link
them all into the target executable.

Refactor the code such that `UNIT_TEST_OBJS` does not contain the unit
test program objects anymore, which we can instead manually append to
the `OBJECTS` variable. Like this, the former variable now only contains
objects for test libraries and can thus be reused.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index bdea061971a..4ed5f1f50a8 100644
--- a/Makefile
+++ b/Makefile
@@ -1356,7 +1356,6 @@ UNIT_TEST_PROGRAMS += t-strvec
 UNIT_TEST_PROGRAMS += t-trailer
 UNIT_TEST_PROGRAMS += t-urlmatch-normalization
 UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
-UNIT_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
 
@@ -2715,6 +2714,7 @@ OBJECTS += $(XDIFF_OBJS)
 OBJECTS += $(FUZZ_OBJS)
 OBJECTS += $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
 OBJECTS += $(UNIT_TEST_OBJS)
+OBJECTS += $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
 
 ifndef NO_CURL
 	OBJECTS += http.o http-walker.o remote-curl.o
@@ -3852,9 +3852,7 @@ $(FUZZ_PROGRAMS): %: %.o oss-fuzz/dummy-cmd-main.o $(GITLIBS) GIT-LDFLAGS
 		-Wl,--allow-multiple-definition \
 		$(filter %.o,$^) $(filter %.a,$^) $(LIBS) $(LIB_FUZZING_ENGINE)
 
-$(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o \
-	$(UNIT_TEST_DIR)/test-lib.o \
-	$(UNIT_TEST_DIR)/lib-oid.o \
+$(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o $(UNIT_TEST_OBJS) \
 	$(GITLIBS) GIT-LDFLAGS
 	$(call mkdir_p_parent_template)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
-- 
2.46.0.551.gc5ee8f2d1c.dirty

