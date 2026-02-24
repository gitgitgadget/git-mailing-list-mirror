Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F6536B07C
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 09:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771927095; cv=none; b=rohmMpHVThTtn/YiTLLTDcyJqcJ5i7NTmIDJE+RAHCIcxrL6mcVeseqXhHUB0jyXJgsPb7fseEDvlRcnO4lLAoHEPX1YPbRt0nL4Q1Ecq+bOINt+8k7jbmr9As6oyoGqlmNTYd3IRL5U5ZxOnlyA+vLWeND7J/QpeGqk0K9tbqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771927095; c=relaxed/simple;
	bh=VrWJ8iYfgLTErlp2WshO4UUrm2BvI3Kt2iU2RJyOstU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKBL/Jk+ZGgFkrVYjGW84ZjfgqXFVRTHI3iNvYX/iAguavkdmRfffA4XzA1AONVvLqg9UlAFlY5Sg65nay2wIBng12JfNASzI2yCU4q3wt9giuonKw33At/meqP8bRpdKLiiN7HMAwD9i3fd/FMoVsfvojfeG/km4FWC8GdiROA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=caXwWnvn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TR4ytMMP; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="caXwWnvn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TR4ytMMP"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D74901400107;
	Tue, 24 Feb 2026 04:58:12 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 24 Feb 2026 04:58:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771927092;
	 x=1772013492; bh=ZZhUsHrfbkPnO2jElhMCQMm1rOcd/QA/QRzsVMWtCvw=; b=
	caXwWnvnEEEqpEEDmwbE8pz+sp7VHAcQPxL8HzWWnfw3huAd/koyA4Vqyhv2IDLe
	ySqpJ2j4BP3sjAZVJNmLaAg523Lh+DnT1yXKsXY6NYvpTBgRff7x4vEW7c0sws7j
	SHAeUmXB1Pht7LZIT72KdB4W2E8SG9ffBQ/V7GnQAkYQ0ehBjIEqztduD3VHNXCB
	TqHcfZR+OpaGnDzLFmVX4tLew0akFto8GL6TqNr8/RW/TTiac/TSHVA9/9T3CAyF
	/N8qcTV2pKdGnQHXb4HDEErwuLX2J4YNrmu10XupTzCzcdumAAZUBPcmzup2tily
	RQTgbM5orXivYpiasaEUSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771927092; x=
	1772013492; bh=ZZhUsHrfbkPnO2jElhMCQMm1rOcd/QA/QRzsVMWtCvw=; b=T
	R4ytMMPtqd+ae5a1JaE2CrOXXtdqF8AIDjC9kFCODP3kyPR0ic8F9h+qT9apbHkU
	qKhu1Un6/zF6qmbwOjP+jUUh5mNXjY/aDzoclUVNORsWPJ3tMUD5kPYUUagrKyT1
	HsrqSP/BGt0pACOpnT0UAmPO8Nwkb00ZkSmTqcMdqsRhaShdYE40/vVbzb7EIEAa
	nw4nzY8AdBQHWXbWdNWYT+t0vN7z4COyQuGd2SyuSVgPHp9uesaYNbQDZdtkhC8U
	DG600TR2XPSFuLp4lwLYF0qZNNeYiggRQtvbVagfvjAITnHu9Ix7se4N13oA4Fiu
	ubDqxSXaU5TyjV4ZKIj9g==
X-ME-Sender: <xms:NHadadvYFaAfv8ST2d0NdBH9pm2oihEtiq3UjO2LurpCZ-NLSm9Q2Q>
    <xme:NHadabbMkqsxEAE7m8j9EVALKWMByIiqsD2kfYoSPPH5wayth-UZl3My0Avb41g2W
    8ZGAmGU9X3A1eJTmh8SgbYZ5qzNTL3nDOX6Fdz6vXJgTgNdotDZ3w>
X-ME-Received: <xmr:NHadaVDdtP5se6pn7BNzi6aeg-oMNnCUvTo1LOwzWBUsavIPtLcF7B3K9G71EGFjseHT3DNg52FwUZ0YtFdW1fO9fKy0IGIW7mbRofEB0-10Vg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeelkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilh
    hlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihth
    hoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvodhgihht
    hhhusgesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrtghnrghrtgesgihiphhlih
    hnkhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdp
    rhgtphhtthhopegvvhgrnhdrmhgrrhhtihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:NHadaT_ROWkPDc7k14LBxIwfzVgA6g-_0m2_g5oVsKiiTx8QwBqcnQ>
    <xmx:NHadaRSutxD66T4RffE0q5FVTWcwAkpS5umh8bbJF82cOiHQg_pkcQ>
    <xmx:NHadaXX91m5ZVw0MM68wH0R9aEXBLrlETQtA1-QOM7-ZZSRbrqHygQ>
    <xmx:NHadabRBw-oSCU2Zqw5EpYbmFe4kaoBm1r36Tsp10VPf_g9BmE51Qw>
    <xmx:NHadadn7LyGpQRCuMIMoiUDbo6IJ1paPYeqfziBEtDuu0OZdRAvSP1vy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 04:58:10 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 83265f5b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Feb 2026 09:58:09 +0000 (UTC)
Date: Tue, 24 Feb 2026 10:58:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	"D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Evan Martin <evan.martin@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] build: regenerate config-list.h when Documentation
 changes
Message-ID: <aZ12Lk85bSajirCY@pks.im>
References: <aZv54vN9DdGsvre/@szeder.dev>
 <8AB2DD1B-FAFA-4510-82FA-BBD76B442676@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8AB2DD1B-FAFA-4510-82FA-BBD76B442676@gmail.com>

On Mon, Feb 23, 2026 at 04:41:48PM -0500, Ben Knoble wrote:
> > Le 23 févr. 2026 à 01:55, SZEDER Gábor <szeder.dev@gmail.com> a écrit :
> > ﻿On Sat, Feb 21, 2026 at 09:07:17AM -0500, D. Ben Knoble wrote:
> >> diff --git a/Makefile b/Makefile
> >> index 7f37ad8f58..6f926ffb1f 100644
> >> --- a/Makefile
> >> +++ b/Makefile
> >> @@ -2688,9 +2688,10 @@ $(BUILT_INS): git$X
> >>    cp $< $@
> >> 
> >> config-list.h: generate-configlist.sh
> >> +    @mkdir -p .depend
> >> +    $(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh . $@ .depend/config-list.h.d
> >> 
> >> -config-list.h: Documentation/*config.adoc Documentation/config/*.adoc
> >> -    $(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh . $@
> >> +-include .depend/config-list.h.d
> > 
> > This breaks the build when something disappears from
> > Documentation/config/:
> > 
> >  $ git checkout origin/seen
> >  HEAD is now at 57edfa3ce8 Merge branch 'ty/setup-error-tightening' into seen
> >  $ ls -l Documentation/config/hook.adoc
> >  -rw-rw-r-- 1 szeder szeder 3828 Feb 23 07:50 Documentation/config/hook.adoc
> >  $ git grep hook.adoc
> >  Documentation/git-hook.adoc:include::config/hook.adoc[]
> >  Documentation/howto/meson.build:  'rebuild-from-update-hook.adoc',
> >  Documentation/meson.build:  'git-hook.adoc' : 1,
> >  $ make V=1 config-list.h
> >  /bin/sh ./generate-configlist.sh . config-list.h .depend/config-list.h.d
> >  $ git checkout 0aabf70f60
> >  Previous HEAD position was 57edfa3ce8 Merge branch 'ty/setup-error-tightening' into seen
> >  HEAD is now at 0aabf70f60 build: regenerate config-list.h when Documentation changes
> >  $ ls -l Documentation/config/hook.adoc
> >  ls: cannot access 'Documentation/config/hook.adoc': No such file or directory
> >  $ git grep hook.adoc
> >  Documentation/howto/meson.build:  'rebuild-from-update-hook.adoc',
> >  Documentation/meson.build:  'git-hook.adoc' : 1,
> >  $ make V=1 config-list.h
> >  GIT_VERSION=2.53.0.119.g0aabf70f60
> >  make: *** No rule to make target 'Documentation/config/hook.adoc', needed by 'config-list.h'.  Stop.
> >  $ grep hook.adoc .depend/config-list.h.d
> >  config-list.h: ./Documentation/config/hook.adoc
> 
> Indeed. This might arise while bisecting, which was my original
> motivation. Thoughts on a path forward? At least this issue (to me) is
> clearer than a spurious test failure :)

For Meson this case works alright. So maybe we just drop the changes to
the Makefile and call it a day?

An alternative would be to have the following patch on top:

diff --git a/generate-configlist.sh b/generate-configlist.sh
index 39ac8845ab..e28054f9e0 100755
--- a/generate-configlist.sh
+++ b/generate-configlist.sh
@@ -41,7 +41,12 @@ EOF
 if test -n "$DEPFILE"
 then
 	QUOTED_OUTPUT="$(printf '%s\n' "$OUTPUT" | sed 's,[&/\],\\&,g')"
-	printf '%s\n' "$SOURCE_DIR"/Documentation/*config.adoc \
-		"$SOURCE_DIR"/Documentation/config/*.adoc |
-		sed -e 's/[# ]/\\&/g' -e "s/^/$QUOTED_OUTPUT: /" >"$DEPFILE"
+	{
+		printf '%s\n' "$SOURCE_DIR"/Documentation/*config.adoc \
+			"$SOURCE_DIR"/Documentation/config/*.adoc |
+			sed -e 's/[# ]/\\&/g' -e "s/^/$QUOTED_OUTPUT: /"
+		printf '%s:\n' "$SOURCE_DIR"/Documentation/*config.adoc \
+			"$SOURCE_DIR"/Documentation/config/*.adoc |
+			sed -e 's/[# ]/\\&/g'
+	} >"$DEPFILE"
 fi

What it does is to also create an empty target for all of the
dependencies. Which is in fact what GCC/Clang also do when you pass -MP:

    $ cat main.c
    #include "foo.h"
    int main()
    {
        puts("foobar");
        return 0;
    }

    $ clang -MMD -MP main.c
    $ cat main.d
    main.o: main.c foo.h
    foo.h:

Patrick
