Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0209F22E3E7
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 02:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765421591; cv=none; b=s6W85qJ8LRLwMChfA04MPAh9YdoFN5jqhYAnkOUc/d8vMjaa/GBYupr5ectkwtcipv7wNiWaouE/8piRgmUmQyaQa2OXVhpvOZA9ktpLOXMBFrITr01eqvWW2cRnc1ReNmGCbJcfgzCv2c/oPfrORP2s8J4fjPOifzTptlTK6WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765421591; c=relaxed/simple;
	bh=HrvhzLXVD0KzOZzAvkAPR7qzev4h03SdkTP+MDT7CN8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r9G/TjooOsR9RMdfwKSiWYBMiZilIV5G7jd8WO7aStSJIn9Df3vlxDfo07x7nCvwBc7tETtxy5iqevkY07fgRAF1HcFsO8QLBkaxC+Y5vtkfYRCfzykdbPNCSdBUjW3uoMyhXLu85J/e/hmpI0TuvINHhtaWNRufyFK5qzuQ+bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FYIMlzv+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gxOGSzwC; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FYIMlzv+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gxOGSzwC"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1220C7A00B1;
	Wed, 10 Dec 2025 21:53:09 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 10 Dec 2025 21:53:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1765421588;
	 x=1765507988; bh=QjTVaYnb0OdBy6ytEUE+3M8u4okNRL2AH/q7UZy4XQI=; b=
	FYIMlzv+wKCftCY1ZYeld0UFIjNPJea4q9qp5dQYVa/aBSBmZ1Z3/xy/G89oDr5l
	UIBxYNnhAxe6t8i7HoDnQ2i7B8h0V/yjTKWrT0s/WqV1pQCFbu9UrYrk33b4+6jY
	jUByP0UR5SQE6melMpLf42vSdRbG/he79S4alG2Rtlxne7E4EyARe/NqSW9xbDIg
	LyzTHsmJt9izyp9YTHmO2xTGqWLdlOfLm2nshIZ4UsVEN/X4IZMseOiJ18Xb07Cw
	9kSIow9hVpoksxDB0Tz06FPpfXB8Awng3RbspQj4gJHF566BLEwODZ6M/cIxXCy2
	ffxp6YFXk/3DEQcpQWEc1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765421588; x=
	1765507988; bh=QjTVaYnb0OdBy6ytEUE+3M8u4okNRL2AH/q7UZy4XQI=; b=g
	xOGSzwCtS3ZzPAla15zqlymIgzvaRDgUhXksgPMcHTHaxPK2c65Jrdyn9m0rY6sq
	oxXT2IztEsCmdm96WjEUVLJNZVrD7M9jbmBvSw6TsrtFdywXzWpJ1xyvyb4ryv5a
	kYeGMJcY/AqDSOFTmGanztr5twY2SqDSl7M4d8S3vuieSMKbs7xtsO2lGZ0ks4Sa
	FBoiqRI3J2CCrSQNT2bvyhXRABJKtxOdLkaE02bo2iCfDKaX20M5FABUhqVTRsEb
	s6clZ1cvASWP42hiXDDL37JhUNUwX6M+WES4CQ+cbmxDr/w1wyw/DZKO86cGuG5g
	6/fuoRmBPV3pmZw4v2PFg==
X-ME-Sender: <xms:FDI6aVuTUCMOlabnOdzAz5pJzBQJqq3G1FXBivwsfWVaIaUrsxSE0Q>
    <xme:FDI6aVVmw0pfcBmBDKcTthhP38CBhUrKg7CT6dQG_GbdRTq5gOeC1aCSYCn9welms
    F4ZiVuvZyf83Z95KR-ZcSnk3PcwfJ8Utm-69h8lJN3RJnI2ytNnzA>
X-ME-Received: <xmr:FDI6aRGDkRIJjylmGaqWHtvRTMajjnMvHm7izIJyZAhC7YB1VJGYDGXI-MjQNbMgoqUe25nVd2g3MdGRQDnjhlf2Enn_CSsilg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtoheptg
    grrhgvnhgrshesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepkhhojhhirdhnrghkrghmrghruhesghhrvggvrd
    hnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:FDI6aX0-A7uNvbPtMwRMQVtvAxeLmk4sXKk43HK_liZ_1c1l3SySjA>
    <xmx:FDI6aTOm18DGWHWf2bz7uFZxX_cqF5Vg0N-JpFm5AWpXp9P52YXOiQ>
    <xmx:FDI6aW7vI1DB2yJvQlOhDZrHPVwY9SjFIq1SsJIsO_1j4rM-XGKk2A>
    <xmx:FDI6ad0NC9wI8RziAvMPskKs9dq9CQG0sO9ycyLGVBQQmmPljayNpA>
    <xmx:FDI6aU29viL_ORmSs74BQg33njGL3tMmll2BqsS8et6xiLNC-HhrXQk7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Dec 2025 21:53:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,  Git
 List
 <git@vger.kernel.org>,  Koji Nakamaru <koji.nakamaru@gree.net>
Subject: Re: [PATCH] config.mak.uname: use iconv from Homebrew on macOS
In-Reply-To: <1b3509d7-e421-4136-a62c-de86213d65b2@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Wed, 10 Dec 2025 18:56:35 +0100")
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
	<16efc726-34be-44f5-aa92-4e82b663ab3d@web.de>
	<qnb77j3b5m6rfbzr3qhmwalo5lha4gqslvzqsfuq6zur74ze7j@wqriu4w7wbzw>
	<1b3509d7-e421-4136-a62c-de86213d65b2@web.de>
Date: Thu, 11 Dec 2025 11:53:07 +0900
Message-ID: <xmqq7buthgq4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

>> Slightly off topic, but should another patch that adds a `NO_HOMEBREW`
>> Makefile flag similar to `NO_FINK` or `NO_APPLE_PORTS` be added to help
>> drive this?
>
> Sounds like a it could be useful to someone.

Hmph, how?  When you personally use fink or homebrew or whatever,
but are building binaries for others?

I am looking at relevant parts of Makefile

# Define NO_FINK if you are building on Darwin/Mac OS X, have Fink
# installed in /sw, but don't want GIT to link against any libraries
# installed there.  If defined you may specify your own (or Fink's)
# include directories and library directories by defining CFLAGS
# and LDFLAGS appropriately.
#
# Define NO_DARWIN_PORTS if you are building on Darwin/Mac OS X,
# have DarwinPorts installed in /opt/local, but don't want GIT to
# link against any libraries installed there.  If defined you may
# specify your own (or DarwinPort's) include directories and
# library directories by defining CFLAGS and LDFLAGS appropriately.

and notice that /opt/local/ is mentioned for DarwinPorts.  The patch
that started this thread talks about defaulting ICONVDIR to that of
Homebrew if available, but the new code checks /opt/homebrew and
then /usr/local/ (and let it override it).  Should the log message
be talking about DarwinPorts as well?


    As a workaround, set the default libiconv location to
    /opt/homebrew when the user has one from Homebrew, or
    to /opt/local when the user has one from MacPorts.

or something along the line?

By the way, for macOS newbies (like me), I wonder if a patch like
the attached may help?

Thanks.


----- >8 -----
Subject: [PATCH] Makefile: help macOS novices by mentioning MacPorts

Since Aug 2006, the DarwinPorts project renamed themselves as
MacPorts.  Those who are not intimately familiar with the Opensource
ecosystem around macOS from olden days, the name DarwinPorts may not
ring a bell, even when they are using MacPorts.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git c/Makefile w/Makefile
index 7e0f77e298..be027218a5 100644
--- c/Makefile
+++ w/Makefile
@@ -95,7 +95,8 @@ include shared.mak
 # and LDFLAGS appropriately.
 #
 # Define NO_DARWIN_PORTS if you are building on Darwin/Mac OS X,
-# have DarwinPorts installed in /opt/local, but don't want GIT to
+# have DarwinPorts (which is an old name for MacPorts) installed
+# in /opt/local, but don't want GIT to
 # link against any libraries installed there.  If defined you may
 # specify your own (or DarwinPort's) include directories and
 # library directories by defining CFLAGS and LDFLAGS appropriately.


    

