Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AED2AD11
	for <git@vger.kernel.org>; Fri, 30 May 2025 04:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748578379; cv=none; b=aGvhdGl/GrOFbqe15RSsrbtOefMqv6GFxb33nQC3CU61Br/O9V4hCx80pUOm1OEEiUYjiIawqMNz3d/kXVUXBDjvLn9GqiOeCjLpXs1AnXwTAB2iMP27aUiEUQZBHB6jsUYdBS1gT28+P+rssR6pxWpRFiIDL3ZGUJht4JvmUB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748578379; c=relaxed/simple;
	bh=YKMTukjHnNROO81CZbbTQWFVajvRQjc9bcq2Invghbg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vd7Zmw4Gx+B8tyETI7UITTyrllTY81Jz055UZpl1XwpV9lzx2VPhGzaSSYIGLF2wuC2bZGcPhVij69kJ82D4WrkP4NP30hnehJUsHjRLoW0EkI8LthzLALZZM5YBObjMqCRWxBHw03EMULzHMW5BIZ5fgxqsFCDuQ0tIjvMZVsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hRaFC3G/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lgJZip8e; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hRaFC3G/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lgJZip8e"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 5E2591140137;
	Fri, 30 May 2025 00:12:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 30 May 2025 00:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748578376; x=1748664776; bh=jF3EEcSRJ9
	nCw+Pg40lBt+rFbQfHutSFWqtZ4zXPL0o=; b=hRaFC3G/0tmvQiR8m867a+bCVV
	jZBGigu7wdkNkxdCZ1U5AouHVd9SPZfflEXgGdWKzDRLCzBw/BUy83+Pdh0B6nkW
	ZObeNeSyF6tmEjUcvIB+xXNTafhBGo28yWza/2MjlmC6EIhz2E/+KWT+NJH+syj7
	IE4PvPxctn999xRYu+hyLo3mleErNMgE5RdfMeGGj7pQcrdjrOXMCk2IUZcmNAeL
	BNWkdRm7cHLMQ6fo+d2l+UGhog3RNzcR/QDMxSEQ/w87i1XMMjNVvc7aDkooqueu
	XU128mD2ahF/oSdMhNqW5zpR3nGGadqNJYHL6mhGN5wabtH0W428xfluZRKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748578376; x=1748664776; bh=jF3EEcSRJ9nCw+Pg40lBt+rFbQfHutSFWqt
	Z4zXPL0o=; b=lgJZip8emIQU0gdhWY6OCpawGZD+P4D16iquaTLW+edUjkX17YD
	ciHI5fRjjCLpGUwFpTotVyyAU69RTnDrCU+wma+IQ63IYe70ZimBMwtZ4Lm5iMgT
	QHPnQLch8j/++cjeH1gTz+uNQxRE/Wp9kIF0kQlNPZ8/pflqrKuhcgGF7HoJQmYm
	PaX6gHNdBclyucWtIy0MlxlyhB10Dm+fjiSd7To4rxLpClWgQxXG4g97htlwfRtt
	ko4GOGbfSU87ei0fQe3/xjSmznaS8/oRV499RIa9zR+jzh69JV9BImPJXwyYFbgK
	DnmHFx/KJlcubC7M/q6JAU/WmKLXdLGCGIg==
X-ME-Sender: <xms:RzA5aETeT26ixhCQtkNkE9JPsAGXzHbKAA63Id9s-sL2WznaJ0m-lw>
    <xme:RzA5aBzXWODYkVKYjGzOYg7TTpYE0XuPlXE2tUfeKJZvM9kdfqBo6stGWHTS1pkG0
    rHkkWR4cRwuchmV8w>
X-ME-Received: <xmr:RzA5aB0XR-RQt2ilfiZ0udBZhcISgmpuibwfuBW9hI-EmlLenMIGr5z42fvsRP_rXKTo8PtNpP6zBm-UgE6IzdJAqVpGRSfmD6bfDnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvkedtvdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgt
    phhtthhopegtrghrvghnrghssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtoheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:RzA5aIBRqMo_OchvnC0K7kJ6yjmuvS1LwGCaMb2vjgkUaSdOLWb7Rw>
    <xmx:RzA5aNh3J-Fw7B-ZtJZVq6i4L94jTs3lu7AWwn2S0zq0bMsu7FBB4g>
    <xmx:RzA5aEqzgJ9ylQZ8oOjELbbJhIJFvskl8vOC7HqTb16e8W3rxH8I5g>
    <xmx:RzA5aAhktnERNLVWsmldT1fCg4O0SgAYh_AY1C4j3b07dGrmQdyPcw>
    <xmx:SDA5aGGWwhIfK1T5ZdREuud-nyh-sILTUT4AmwlB4s60Y1es-TRd8SBR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 00:12:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
  git@vger.kernel.org,
  ps@pks.im,  "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH] reftable: make REFTABLE_UNUSED C99 compatible
In-Reply-To: <aDjp_IkgmITrl59-@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 29 May 2025 23:13:00 +0000")
References: <046901dbd002$a0c245c0$e246d140$@nexbridge.com>
	<20250529101136.16219-1-carenas@gmail.com>
	<xmqqtt53l7cl.fsf@gitster.g>
	<aDjp_IkgmITrl59-@tapette.crustytoothpaste.net>
Date: Thu, 29 May 2025 21:12:53 -0700
Message-ID: <xmqq7c1yivne.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2025-05-29 at 16:17:14, Junio C Hamano wrote:
>> Corresponding definition we use in the main part of the project
>> defined in compat/posix.h looks like this:
>> 
>>         #if GIT_GNUC_PREREQ(4, 5)
>>         #define UNUSED __attribute__((unused)) \
>>                 __attribute__((deprecated ("parameter declared as UNUSED")))
>>         #elif defined(__GNUC__)
>>         #define UNUSED __attribute__((unused)) \
>>                 __attribute__((deprecated))
>>         #else
>>         #define UNUSED
>>         #endif
>> 
>> GCC 4.5 or older may no longer be relevant, in which case yours may
>> be good enough.
>
> RHEL 7, which is now well past EOL, had GCC 4.8 and Debian 7, released
> in 2013 and also well past EOL, had GCC 4.7.  I think we can safely
> assume nobody within our support policy is using GCC before 4.5.

Good digging.  There is another one in git-compat-util.h that
is conditional on GIT_GNUC_PREREQ(3,1) which we can simplify away to
just "#ifdef __GNUC__", together with the above.  Of course totally
outside of Carlo's fix to the reftable library.

Thanks.
