Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DAD28725F
	for <git@vger.kernel.org>; Sun, 14 Dec 2025 07:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765696401; cv=none; b=suJug7Jkhc8TEQ6Ctb4Q4QUiqfIMClNq6xkHnDymQJV/tsPbj+e3YV2ejllBUrPIVpv42t1eUkyr9ZRp7PCpBOAl+QJvhcsdRgSq2PhHXIBTQcQbIU7ceQLpmBNfUkWofKwtvzZEKi/Om79zR0jUgTwMCJpso4ww1HPHlBtn+v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765696401; c=relaxed/simple;
	bh=ka5Ra+vRAh+HwR27DE5958GL/UYDZd1bYfazqBNBRjw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iTj5fQqOh25+RNOM93PcGAu0vR50mCjBalIyRtIc7h/cVbjagw5sYOMMypT+VvwhaKi/I7zlLM8iH5RmLInPIAa+G3Dqy2fZ18S/+Fp2IhcGSH2cm6Q5vZDz4TBlwmVfDuJuhRmc0SkaGG2IswIkeDq/EPzO0LuBXVigsLuTPK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bfAuqlgP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PpZWGoo5; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bfAuqlgP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PpZWGoo5"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C70B77A0078;
	Sun, 14 Dec 2025 02:13:16 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sun, 14 Dec 2025 02:13:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1765696396;
	 x=1765782796; bh=cCbEfHYMiZ4TvV4apnCwRqhPDhGTnlQZxYKjpnozKfY=; b=
	bfAuqlgPT33rrz/ziKHiZviURYYl9HsCP7Y331W1V4SN8MnpjtLQBjWTUfMF+ean
	ANcPxlnI4mzev0+L7A1lOprx/FI+yIxzkjaARPq7S38OOd8mStSb62J6jPNJFT3Z
	QbqTGx8cTXPf2r8CHGO1ndIuDWQJXzIGd6p4sd+ErO/KZJwAlWoDRWv+RFcsZL1w
	m7X3FgbuPp2wHM9J5S0b0uToEysbx88ZCqJD88blnK7Xsz46gySUOz3xyxhS1ex/
	62zUXbN4R5cVhEyabtmWZL4jBUlmWi2PZEN74ZfHntWe1gPITEgFkfONwvNqqlz6
	O3CWpr4uUjikfR4EzDUkxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765696396; x=
	1765782796; bh=cCbEfHYMiZ4TvV4apnCwRqhPDhGTnlQZxYKjpnozKfY=; b=P
	pZWGoo5+6ze5HxVIQLzcwocl8O+DfRxfGy7Y6k+jt3WC/CWo1GzQxu8hxtmR9u9O
	mzii7f4aWDlVtvxb5JYdsh+f/TLhWLqlRoSNJq6REbUl7urz5UFB2QdIa5l++dL8
	6DpUXMl0wep1GWf/jIXEdnCWxMipEnU71Bq1Xhq/iWQK3vPPSw+qv+cULo+pLxbg
	IsTptAmrcmfpMNRwGNUBRgvlX4+2yGznBgvPyvLSsughpuzdUVfNs0C6A2gikSaI
	CBrtn0k6II0Iyv9ZDM7awVP6R1yI4sQZMe/E9LnRD76hOpmXSl8n3fkXASwxLgiy
	xfGdceyozOl7g2r01mzBQ==
X-ME-Sender: <xms:jGM-aQ9PTiAexCM6WePrfGmGQqrM7q-Cs18UMjXFPPK-TnQNsKJqeQ>
    <xme:jGM-aVrhv5OIoUjMCN4Ze4fNbblTO5PSP03wVEvONJYQBZPcqZIHjHPAzg9tLwS5M
    nPdDVnKYm70tcyrRsvjd0wKQn8XxTyGYTGCg-4DuPUBm7JGUpcl>
X-ME-Received: <xmr:jGM-aRrtCo1oEtpr05bUx-clSEpznlXt8in7_qPFi9rizzCMlm1rBq2F1u-iM63RNUEfmrGchspS5s1toqrmmOaunikU2dadeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthgsohgvghhiseifvggsrdguvgdprhgtphhtthhope
    hlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheptggrrhgvnhgrshesghhmrghilhdrtghomhdprhgtphhtth
    hopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphht
    thhopehkohhjihdrnhgrkhgrmhgrrhhusehgrhgvvgdrnhgvthdprhgtphhtthhopeihtg
    hhihhnrdhmrggtvhhimhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:jGM-aY3e4iYvmqf2prL5BnOpIPmIhhueN0QVYJn4gW0HMOx5UPqW-g>
    <xmx:jGM-afFtP7OCzMPsNUWKJFUyVfNPrVhALX-HSBH6nVo66dZRaYXz6Q>
    <xmx:jGM-aTGmtymZBSxf-krYWm9nU-qZyb2BYv9xgIzOtbh98IIJImyeZw>
    <xmx:jGM-aS6pYaiTsNecaFb8NNBTo9C7RRGi9x2L6P9f9WxKNs40I-537w>
    <xmx:jGM-aRK78IfPByYaCD6ECKkb4DF5VctT4xCBn9F49a2crKX8MLinmsWv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Dec 2025 02:13:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Git List
 <git@vger.kernel.org>,  Carlo
 Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,  "brian m .
 carlson"
 <sandals@crustytoothpaste.net>,  Koji Nakamaru <koji.nakamaru@gree.net>,
  Yee Cheng Chin <ychin.macvim@gmail.com>
Subject: Re: [PATCH v2 1/2] Makefile: add NO_HOMEBREW
In-Reply-To: <20251214064544.GA26358@tb-raspi4> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Sun, 14 Dec 2025 07:45:44 +0100")
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
	<fe00aa37-e929-4ca6-ac23-84a693a48bc6@web.de>
	<20251214064544.GA26358@tb-raspi4>
Date: Sun, 14 Dec 2025 16:13:14 +0900
Message-ID: <xmqqecoxa645.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Torsten Bögershausen <tboegi@web.de> writes:

> On Sat, Dec 13, 2025 at 07:42:38PM +0100, René Scharfe wrote:
>> Allow disabling the use of Homebrew on macOS, or Linux for that matter,
>> like we already do for other package sources, MacPorts and Fink in
>> particular.  This is useful for packagers, or anyone else who wants to
>> control dependencies.
>
> Good.
>> 
>> Suggested-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
>> Suggested-by: Torsten Bögershausen <tboegi@web.de>
>> Signed-off-by: René Scharfe <l.s.r@web.de>
>> ---
>>  Makefile         | 17 +++++++++++++++++
>>  config.mak.uname | 11 +++++------
>>  2 files changed, 22 insertions(+), 6 deletions(-)
>> 
>> diff --git a/Makefile b/Makefile
>> index 6fc322ff88..dbd2760d18 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -100,6 +100,9 @@ include shared.mak
>>  # specify your own (or DarwinPort's) include directories and
>>  # library directories by defining CFLAGS and LDFLAGS appropriately.
>>  #
>> +# Define NO_HOMEBREW if you have Homebrew and don't want Git to link
>> +# against libraries installed by it.
>> +#
> Good
>>  # Define NO_APPLE_COMMON_CRYPTO if you are building on Darwin/Mac OS X
>>  # and do not want to use Apple's CommonCrypto library.  This allows you
>>  # to provide your own OpenSSL library, for example from MacPorts.
>> @@ -1692,6 +1695,20 @@ ifeq ($(uname_S),Darwin)
>>  	PTHREAD_LIBS =
>>  endif
>>  
>> +ifndef NO_HOMEBREW
>> +        ifdef HOMEBREW_PREFIX
>
> Question from a homebrew newbie, kind of:
> Where do the HOMEBREW_PREFIX (and other HOMEBREW...) come from,
> and what do they do ?

I understand these are purely _our_ thing.  HOMEBREW_PREFIX and
HOMEBREW_GETTEXT_PREFIX are set in config.mak.uname (added in this
patch).  I presume that those who installed homebrew at non-default
location and want to use homebrew would not set NO_HOMEBREW and set
HOMEBREW_PREFIX to the location they installed their homebrew which
would be different from the default set in config.mak.uname.  Those
who have homebrew installed at default location.

> Running
> git grep HOMEBREW
> gives
> ci/install-dependencies.sh:     export HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_CLEANUP=1
>
> Whould it make sense to have a few words here as a comment ?

Yeah, like 

# Define HOMEBREW_PREFIX to point at an appropriate directory, iff
# you want to use homebrew installed at a non-standard location.
# /opt/homebrew on Apple Silicon macOS and at /usr/local on Intel
# macOS are the standard locations (and you do not have to define
# this variable yourself).

perhaps?  Similarly for other variables.
