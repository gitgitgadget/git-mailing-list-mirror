Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C58148827
	for <git@vger.kernel.org>; Wed, 21 May 2025 22:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747866219; cv=none; b=OLt8u7PenLTDNXrGv+xg9A7qTWgaCvKA5MFkE3n7s7CujA/krpJeQXCfEqN1URKtaG5po0/16BdtQgynx6t+seLpGzwUqRLWPIqOaTt+kCZAL7u4PnderSPH86mL4Q6+d7YWFRbiNscOwiP3lsivzLr9qb0zzOdzoeDW3nid0AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747866219; c=relaxed/simple;
	bh=6CkUQdWQxW8dk5YBSEX8NqXCymnCxPnDUf2KGhMEmdE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GwruxKP0pTmzLwOMQ7FMhcGEqNyXm2WPpH9M6gAcbW3wwksGnRGOYw24SAsQdUOeaarpYyybXImzYHytF9BBApnce3HmeKGSyMz08U62fKdzsYk1TBl2w/VPdLIZoIbOdJJqi8rfTdO5KklKIHIGd11Y78MVW3GGnSZzo+3OYeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mCRdtzPV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ux/+oNbB; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mCRdtzPV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ux/+oNbB"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A81B211400DA;
	Wed, 21 May 2025 18:23:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 21 May 2025 18:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1747866215;
	 x=1747952615; bh=2dRJ0a5whaQYOrMi/Hj99i08g0UWUgGUW/OfFa2ev3A=; b=
	mCRdtzPVoF7bxrsuCUJMg3RwLFTqsIy5oxxrb9Sw9KpbqGaPMsc0mhahRgR4GF9A
	BTUVJSxPwHCO/hy4io3vqQ+AnZIUOyd19o183c/VTk3xkibr/XUFzyUn8CMW7VSO
	ct1CrQDTwMOrunS/kYvrHg1s77Zzrf9aIh9RHbFeTIc9Ao6qxqVOSE5/zCQzXBgl
	7nnFDV8BFh80I9aU2PRDad+Jluy/AvPzQ8yV4M9d5OpxZs/qqcO8omlqDgYLltEw
	+YtZ6Nh6BZvjNmX6j5gWPOobaW6VoXH4pthHeCQa1yf48FGh7UMHdqFRE5S311df
	8Po5DdI5gxTEaNxZABTVBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747866215; x=
	1747952615; bh=2dRJ0a5whaQYOrMi/Hj99i08g0UWUgGUW/OfFa2ev3A=; b=u
	x/+oNbBkEJUFxBAWUj2AQLr5EB2VgyvyZVs/9S2DpCmKtPrM16eEaPPfU/1FgvnS
	T1DTE8L/B+ufgnX26rvjWCsw9amUZoqHjoG+OE37cxsfZ2veEh8+3IYoh/ft3oRe
	Stm0yY5clNCdIURVJvlo25upmS6+KyA54x1XhyOcsaBUsggEFttA1tZzNaFnOCK9
	ygRK4LilFRmUa5gR2HPoSD89oPgy1L7h4LTuNIle2fdjBmeMY0MJhkg879VfJwHu
	jVEsEMftzE8VP1lbAejOWF/oSUYNdsXLNAudwLbzUWSPCHSNwbZ1v9eKX1ISkThz
	9UMMro71w3t2l8ox/jS5g==
X-ME-Sender: <xms:Z1IuaEQrtd_F2vXAI3rRa8SakBzYwi4MZtC7BfI5GPagRU-Gf2RKyw>
    <xme:Z1IuaBygqCeuOkjBU6h4y9hg3yHJ5L_mIZPbd9RZiclTZX3UdBlGFxM3UFWIiqBlw
    hJTvhksrB1KZ1_4hQ>
X-ME-Received: <xmr:Z1IuaB2s1TtXLxfdY1B_jxvRje9meHfhPv5eDVqR1ZNlej_PrL1XNy6bogQAgY0NnbVR7hkV2-KGGoVywxUki4mqn8mSlfWiwx9NvbM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdegvdejucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteeg
    vddtkeetfeevueevlefgkeefheeigfehveehvdekheelveevfedtheenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgt
    phhtthhopehgrghrghgrughithihrgdtkeeslhhivhgvrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvges
    shhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:Z1IuaIDCO4jib3hks8eTLDtxPj5YzwFiUkqsMFH6PmuSijXFZ3zQsA>
    <xmx:Z1IuaNiUdDwN-nrQXcAwEP08KJWcbxVGDncqeLxwzjyWdhkELUwDJA>
    <xmx:Z1IuaEoMZIOI46X2xNUxXjNGa2bKlzxc6slgkf6R2T2ONEZstKKUbg>
    <xmx:Z1IuaAhJecffnC5FI6eU-fmnECM2Nn0BSy9rXCmxhHLogal0JDZ6IA>
    <xmx:Z1IuaIMi-ZuAQMATZ4E7BmjtPwK6Pj2DZ1a7geqW4krUQICHqkczv9mh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 18:23:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Aditya Garg <gargaditya08@live.com>,  git@vger.kernel.org,  Eric
 Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] help: inform about 'git update-git-for-windows' on Windows
In-Reply-To: <aC5MOl66YuIK1eyU@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 21 May 2025 21:57:14 +0000")
References: <PN3PR01MB9597FDF30B7CE529985DE546B89FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597AFD63B750703E90AD18BB89EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<aC5MOl66YuIK1eyU@tapette.crustytoothpaste.net>
Date: Wed, 21 May 2025 15:23:33 -0700
Message-ID: <xmqq5xht8uxm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2025-05-21 at 14:22:29, Aditya Garg wrote:
>> diff --git a/help.c b/help.c
>> index 6ef90838f1..238ed1913c 100644
>> --- a/help.c
>> +++ b/help.c
>> @@ -355,6 +355,9 @@ void list_common_cmds_help(void)
>>  	puts(_("These are common Git commands used in various situations:"));
>>  	putchar('\n');
>>  	print_cmd_by_category(common_categories, NULL);
>> +#ifdef _WIN32
>> +	printf("\n'git update-git-for-windows' can be used to update git.\n");
>> +#endif
>
> I don't think this belongs in our codebase.  It should instead be
> carried as a patch in Git for Windows.  The reason is that there are a
> variety of possible projects that compile for Windows—Git for Windows,
> Cygwin, MINGW, etc.—and only one of them ships this binary.  It is even
> possible for users to compile their own Windows binaries, which I know
> is at least done by Microsoft as well as some Git contributors on
> Windows.
>
> This change might be misleading or incorrect as it might tell users to
> invoke a binary which is not present or to update software in a way
> which is not via the normal package mechanism.  For instance, telling a
> MINGW or Cygwin user to run that command would not result in anything
> useful or desired happening.

Do you mean that this is OK if the #ifdef were more specific to
Git-for-Windows?  Just being curious.
