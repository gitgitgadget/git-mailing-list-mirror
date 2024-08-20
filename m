Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED98643AB2
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 14:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162563; cv=none; b=s8Hz6PsnjYCo70VdjLe9z5uOeN86Re0hNk4z1PaVqR6RxJKKOUf8fLK343HgRrIntF+iOkoTFDbICmPYEyXdAOzLnyKLC95upUqEtABjYg7LzEhyG6bouoSDhJ9hEm+HClogmcNj4BstCHzV1FSJmO9rCePZs0REZ3dd9N12RkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162563; c=relaxed/simple;
	bh=2sO44VBFtc3edaE6aHAOPRtbX9MmUgEiJqBvmhe/UAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUGbDVee4wAQ4b4vkqnJP3OBiTLxyurqYyDXXyUPA5OINED7zlnsTlXQziAZfiD3zouBUeuoY4nSOMT5S9kFV8HRzloVxAdQcIDrUTyo1BvOaRycWSaGsIXW7ASbt2Ej379Z24QE4ebDxaSLpfZODXZxKJ0Wr9rfj89gElyizog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MxrBk7vf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eYjvMVec; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MxrBk7vf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eYjvMVec"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 102BC138D828;
	Tue, 20 Aug 2024 10:02:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 20 Aug 2024 10:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724162560; x=1724248960; bh=6ZUCMkF8dV
	kBFqjnHaACZjxH675BaDrcIJ2Y9pzFMX0=; b=MxrBk7vfeVLjKcfJ9MRhvFW+wk
	KXZR25Yd+XZEekVmOvkY5VAzKZ/oxS+akic+FZgucZRRl8O/V25XdwDBU1eM0Nx2
	PyzNiEh1OEj6IH99mzUOadSppLFvtFPtaAUDAJCHTsylpORK1N0tovV0Zfe1B2PT
	WlmtooFOl+fYNy+IWUShOwsDmkjgBdtUca2yLqrRwMFLDNgXf96e9PXfAKVvmz4Z
	QzaoY5DijT6GsUoW3GoXhoy7YHox3APdOWOyqRybOlPk/ky96QW9QKo6rmAq1SXI
	CMoXfp2+yAbz/a3oJGQm626pW8ZDPKYEhkyi0Qt6HRV0gl+Hbjaxl6XmpsLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724162560; x=1724248960; bh=6ZUCMkF8dVkBFqjnHaACZjxH675B
	aDrcIJ2Y9pzFMX0=; b=eYjvMVecwtWJEymZmcY74s3P+YA0kqoJVHk89cKavjju
	imlBsNNvcZX8gUO0gseIOdV88NywFOJBnhoi8mRHeYqjIVKfY3VhatMvApI2O+RZ
	H0hMx8BzOfwpD9LJOxh8wlRMm6hhgLluoc/2ScezjOb/YzQjjf+2Id3a8oZZvu1t
	8Mw0/kA3g5olzuU02/TK5TzetvuSZG09aa3V8Ds0Z/n8E01+oNdtKOhThwSMBOOn
	JgK1TbrJzHK/fEB0xwIh0vOZs/bumAWl7KiNEaGT0AjPENvYSggUTfRQjj6xqtL4
	odbaEChrFKZ0A10+DREorB/H+rRV0bFA466mnVwC+g==
X-ME-Sender: <xms:_6HEZhsJ1Jn18zHxjcmD9_o5lx-PFA--QiWbdgXrB9V0ORcntvhBww>
    <xme:_6HEZqc-UBZQq_S2kw2AuOFlOrL84cDb36AsEIpjJnSw7JoZi30bbY724PACsWBDS
    cB8nIst6EVlnyhzdw>
X-ME-Received: <xmr:_6HEZkwPySODiKxLrM3WXDbUsUHbmFUkCJyhN1oqoO2qeqrduhNNXecdU7MWGBU3J-A-ChSo-teSnVRswQkq9B17C89una-F9GvcIYOIMzmjDn4nHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhr
    ghdruhhkpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtth
    hopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopegvthhhohhmshhonhesvggufigr
    rhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrh
    hiughgvgdrtghomhdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hsphgvtghtrhgrlhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:_6HEZoM3TSf5oQ0FTJuqP9EcxB6Otog3qVGT5wor-Ey71W5NzYLpLw>
    <xmx:_6HEZh8ZyB6-PEGb7pzVTO2tLEbOyQ3s3UwtUdtntdj3A9uP4YCIRg>
    <xmx:_6HEZoUoP20DkivCRiPLeRAEdNpQbY9hxLWpuwsKD5_f8FNpk3TJew>
    <xmx:_6HEZidQhWX1qm2A1kDQU_Zgl8EIDUJ587Ei26fYZsmz7dG_jY8U-g>
    <xmx:AKLEZgY_e_lkUzl3oyZ4V8B_E-n-DJ0lgoku1pfau7BuyNSVwXe7QVl7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Aug 2024 10:02:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d32f0777 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Aug 2024 14:02:06 +0000 (UTC)
Date: Tue, 20 Aug 2024 16:02:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v6 09/13] Makefile: do not use sparse on third-party sources
Message-ID: <c91dd7327e36e02f268122c1e85c3c50c74b3b43.1724159966.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1724159966.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724159966.git.ps@pks.im>

We have several third-party sources in our codebase that we have
imported from upstream projects. These sources are mostly excluded from
our static analysis, for example when running Coccinelle.

Do the same for our "sparse" target by filtering them out.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 8c4487dd0c6..81a47b61327 100644
--- a/Makefile
+++ b/Makefile
@@ -3252,7 +3252,8 @@ t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS) $(REFTABLE_TEST_LIB)
 check-sha1:: t/helper/test-tool$X
 	t/helper/test-sha1.sh
 
-SP_OBJ = $(patsubst %.o,%.sp,$(OBJECTS))
+SP_SRC = $(filter-out $(THIRD_PARTY_SOURCES),$(patsubst %.o,%.c,$(OBJECTS)))
+SP_OBJ = $(patsubst %.c,%.sp,$(SP_SRC))
 
 $(SP_OBJ): %.sp: %.c %.o $(GENERATED_H)
 	$(QUIET_SP)cgcc -no-compile $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) \
-- 
2.46.0.164.g477ce5ccd6.dirty

