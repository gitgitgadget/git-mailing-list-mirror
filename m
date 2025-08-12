Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75DE2FE564
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 17:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755020167; cv=none; b=F5x/57frF7lDdmDDAJaHaYUN35oaaW+w5dIguu/sTBYFGBwfDUiKmr1uhZncyNsTdDbxntreQtaVMSHeCJhlBW0kGfhT7mmZIHrdyrrksjzdb4/uFmhtBeqq66oEGukp38MUzAREq8C0Lo+8CdFdhTA/lsct5WXUjqn5xhzU5s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755020167; c=relaxed/simple;
	bh=qhL14prUcflfp8ffb0wH0CyXeTCZUGlMMQV+TbyjYcE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U0DtM3E5I2Dql8/0a+X5Ie/5H+JM1ir9EmzFQ+srw02HOdSWPX9KGu4Rs6NrDuBA52dXAEdc3tFGLfq+OZW+0JDN7LYw4OMv/Czqabh9jt9n4v8rlg4SsVTOr4aWaziNOY3cZlZCMlTsMmh8x7daKhvGlSvUjel48ICQIcY01PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ndg6w+8c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BJ8iWLXT; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ndg6w+8c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BJ8iWLXT"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 03431EC017D;
	Tue, 12 Aug 2025 13:36:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 12 Aug 2025 13:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755020160;
	 x=1755106560; bh=2nwUXqnRcCqyvPpT9p9d3QuEsqglchcx9calTNZJ1sE=; b=
	Ndg6w+8c+AX8OEwx3Cg5DB1UwEIyCfvF3d/F+ovHighkCFKo0LDL+8qq8apV3yFW
	r7W/u4S2LUfUrnjvno1FqpUD9mxpzBEnvXc59PPsz09LSSgjaGDbTWVt19cFMwBA
	3oKbRBXHKojm846DuNywzl3f2IrK6rsmz9jmAT0UNpInuzY7p7izve/iEjSDE4VN
	URa4Z5WYuTu2Q0+p2CMgvgKCJQ1y4Mtr5WJbea3IRH5DbmTUDLiXJ8bOk8IPEnc0
	2fa8Q/5YMIpExQnTAOLBsZp9c95txPJNufJEmgieTys0dHbelampyq02uMtOfxZM
	KyDNlxoMIe23EUoJuc3qZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755020160; x=
	1755106560; bh=2nwUXqnRcCqyvPpT9p9d3QuEsqglchcx9calTNZJ1sE=; b=B
	J8iWLXToK/3kPJbVHfL+bqzmF5l8kB8DrcnbauxIpNz6n22ahWIt3/kxQOpFOBKZ
	QJAGiOZosAnyQ9QVWHgVnI6n+qMs3Mlg4O6Xf1H5OL4n9NfGeYXUeBzjQfFrzs0e
	NgAZUms/C5dOkV5g2wAEUPehL977v4+ydnGi7Ecb4sQs1O9x0iENVNu0UdcT5MsZ
	9583t3DTwrUmfOXsfFmMU6/t+r8Mx/UX3pika4MgsTKFYoyk5dzWKR4dUn70t8qa
	DnMCVvHtg8itIWT2TW5z6NURK3gE43ec9j8XZgAzrDdorFM9PhwyiBz5IvaOfZWP
	s8fs2le1yoGIKhop0u4IA==
X-ME-Sender: <xms:gHubaDjKDj4VudKv-zeGBvVKEjIzCqFW_7AWwHWRhK8nUnr1oG6PPQ>
    <xme:gHubaNlF3py6iKDoAhe1Kpapwwjs9z8PX3pWNeB9o0g5vMQwxszm7yn1PDpJX_75H
    iFrnzKTWV3mtlPvQg>
X-ME-Received: <xmr:gHubaJghIJ4Y0mAlMu5-iN7QrvqcbrD4PZV4AJ3GMmQvMpMhXoDD2qUvu5Rr5UphgcL1y53XRXugM4Lzj_Kaccu2V9Iv0p8ZNEEJev4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeehleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeetvdefudfhgfefhffgkedtjefgteffgefgueegieelvdelieduleffhfek
    tefggeenucffohhmrghinhepmhgrkhdruggvvhdptghotggtihgpghgvnhgprghllhdrsg
    huihhlugdptghotggtihgpghhlohgsrdgsuhhilhgunecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomh
    dpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhu
    nhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopegsvghnrdhknh
    hosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgdoghhi
    thhhuhgssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphhhihhl
    lhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:gHubaB2ysUHOFrBHLDmSwNo3gku3A-vt9gMV19JmkZI7lysEqkQHyA>
    <xmx:gHubaCJEuElltg1TMPx2m8hP-bzHmh9r0APUNvDu6uDnck90NXUKNA>
    <xmx:gHubaBzq3a9yJr8MpozZXPjb1SoSJeXwkXUFCKSRU_lLt1cj8lvo9Q>
    <xmx:gHubaAXRCuoZnZLyy7R18GMESot5wxygn64QJAiOETrqEhbfz-_oVw>
    <xmx:gHubaDesXqbIHQ1GcbkrMVqjv1xbxhZarcTS0m2c4_kieev40vRkM5UT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Aug 2025 13:36:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Ben Knoble <ben.knoble@gmail.com>,  "D. Ben Knoble"
 <ben.knoble+github@gmail.com>,  git@vger.kernel.org,  Patrick Steinhardt
 <ps@pks.im>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 0/4] clean up some code around editors
In-Reply-To: <CAPig+cTpMFfg8iTncgekq6wyfHOPidhHposLi11D3fXyfnNQRw@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 11 Aug 2025 20:16:45 -0400")
References: <20250811221706.67168-1-ben.knoble+github@gmail.com>
	<6BCA1E93-7409-41FA-81FB-0CB75A3A55FB@gmail.com>
	<CAPig+cTpMFfg8iTncgekq6wyfHOPidhHposLi11D3fXyfnNQRw@mail.gmail.com>
Date: Tue, 12 Aug 2025 10:35:59 -0700
Message-ID: <xmqq1ppgv3wg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Aug 11, 2025 at 6:59 PM Ben Knoble <ben.knoble@gmail.com> wrote:
>> > Le 11 août 2025 à 18:17, D. Ben Knoble <ben.knoble+github@gmail.com> a écrit :
>> > ﻿Changes from v2:
>> > - shuffle setup code and use more helpers in 1/4
>> > - insert 2/4 to stop abusing --exec-path
>> > - improve environment-cleansing idioms in {2 => 3}/4
>>
>> Some of this shuffling turned out to be unportable, which CI caught (but running the test locally didn’t??). Fortunately it pointed me at test_env and I’ll either use it or go back to the subshells.
>
> To catch it locally, you can run:
>
>     make test-lint-shell-syntax
>
> in the "t" directory. Alternatively, `make test-lint`, `make test` or
> `make prove` would also have caught the problem.

Among these three `make test` can be run from the top-level.  The
other two cannot.

"make test" is a bit too heavy-weight to use as an initial sanity
check for tests that are being newly developed, and I am wondering
if something like this can be added as a first-line sanity checking
tool.  The idea is a simple "make" to build, while DEVELOPER=Yes is
set, would trigger the common linting any developer who is working
on new things needs to pay attention to.



 Makefile | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git c/Makefile w/Makefile
index e11340c1ae..7f21afeaf9 100644
--- c/Makefile
+++ w/Makefile
@@ -1471,6 +1471,7 @@ include config.mak.uname
 
 ifdef DEVELOPER
 include config.mak.dev
+all:: check-developer
 endif
 
 GIT-VERSION-FILE: FORCE
@@ -3350,6 +3351,10 @@ check:
 		exit 1; \
 	fi
 
+# We may want to take over 'make check' for this, but for now...
+.PHONY: check-developer
+check-developer: check-docs check-tests check-builtins check-headers
+
 COCCI_GEN_ALL = .build/contrib/coccinelle/ALL.cocci
 COCCI_GLOB = $(wildcard contrib/coccinelle/*.cocci)
 COCCI_RULES_TRACKED = $(COCCI_GLOB:%=.build/%)
@@ -3942,6 +3947,10 @@ build-unit-tests: $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG)
 unit-tests: $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG) t/helper/test-tool$X
 	$(MAKE) -C t/ unit-tests
 
+.PHONY: check-tests
+check-tests:
+	$(MAKE) -C t/ test-lint
+
 .PHONY: libgit-sys libgit-rs
 libgit-sys libgit-rs:
 	$(QUIET)(\
