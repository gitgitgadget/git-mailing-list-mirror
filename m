Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0352853EE
	for <git@vger.kernel.org>; Tue,  6 May 2025 17:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746551476; cv=none; b=PCSyrixFadnyMSs10x4KOyhz0bZCft6HyGrc6789EFUPZA/ApGFNLhdnj4ZYhLec1tPSf1LUATyoYLnEw/g0tZnlNkk1DmaQktNJJEZ8hayKn6ExpYMYyF5PFrlLKN8j5mGStyG7V/9PX8EJxaE7UXdagKNQ/qgl2h0foVsoriI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746551476; c=relaxed/simple;
	bh=YhcVjZXiHlk/Abjrp7ZHD87V0ogwusEuQ4FMduRrNog=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tLFyWOE3cHFo/g7eez1xT1L14yOs2xh+WUiArbvJeDcR1dfaqd+wIX4kmYDAcnb7nVaPNgBdbwn06QsSVTGK6KnvPxofwCt0iQ/aNZgsqo2MoTZtCdxlzT7JUajfJ4N4PEnnBipe5brKJ4fUQV5KMaw/orQkU4KjgSbx+lkhVXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RxmYGB84; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I0bIu4pe; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RxmYGB84";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I0bIu4pe"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3A7961140307;
	Tue,  6 May 2025 13:11:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 06 May 2025 13:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746551472; x=1746637872; bh=AOTdlaYtsj
	hRi1C08W4sXb4s7IVjriEi0kZRZCk93fU=; b=RxmYGB84wzKFAK9k487hLEIlSL
	adN0EnRzRpU1yykfAucr99qfPEHDC6sHCWWNpEW1vRHcEwhlc7cIKoYhuSBpkwaM
	KMV6Afx9dqufUAn0S00jac5mememKZEmKvuR96o4kCFikUBdZHepvAzWZF0r6ptt
	jh9jgnndd60mOnL4NQFGuWeAEqt0kKg7PtHBDbRZYiX4Z5dug1V/9fVnplEbC6IT
	uY+wYI2u6cUB2l1LWht4Dvo86bV47PzrAHI3apmi4CLTnVreeeRsCXYHXENOdmgk
	LUU1KVMBYOceGAdyV8d0WGuMlU+Ws+MUqWUVPeenfIx3tvRBg1S9fcn+Op/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746551472; x=1746637872; bh=AOTdlaYtsjhRi1C08W4sXb4s7IVjriEi0kZ
	RZCk93fU=; b=I0bIu4pewNb9AfjJfZKpyDmO5WuzvK/OndqAK4LX025NCMgJjnD
	4K4gQTBAjFZ0K7B5OO55OIB3ldkZUWWsTz+koCu5I9j3BBRoqY2KP85dkoaQvVAw
	gyHkYRMTSM+yX3Bn3O4ANNPmFLEq831AsfbgLY+kUFDZX13cNva3DwsNm6pDDiKa
	OcxkjFQkuMOWxmM425z7tlj8KKXyRyWT8C13wwsPH7eYY+RDotE7n44AjZo6Vqly
	ojVPg7t+GJO1HZU7J++ZoGHU6ww24RmMDfSqlT/pIut0n1UsU6Sukm7HNz0OdedR
	ObfY4qsLBf0OXqFEmCBoSPfcdLv38uDjuPA==
X-ME-Sender: <xms:r0IaaNGIXxIOlXzTXfzzpQLtjNIiaF-KvoostKmIvOuld73XF_kMLA>
    <xme:r0IaaCUjO04Yiq9CLKxzkALYwefZzKoO-F_3bReB12xxM1gsiQM5g5S-nEjImZ_Uk
    Xlb41EOKhSuljAklQ>
X-ME-Received: <xmr:r0IaaPKMPeRZC_JIjLr-hJDgSiVBcM1JI3-HnLZeeMpF7ye6yQITZ352ZIPoH7aTGViTNmQoBSsyeld8cA0xPr5eUkDw8MQi2JoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeegheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgrghrghgrug
    hithihrgdtkeeslhhivhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehmihhrthhhrdhhihgtkhhfohhrugesghhmrghilh
    drtghomhdprhgtphhtthhopehjuhhlihgrnhesshifrghgvghmrghkvghrshdrohhrghdp
    rhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
    dprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghp
    thhtohepiihihigrohesughishhrohhothdrohhrghdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehs
    thgvvhgvrdhmrdhhrgihsehgohhoghhlvghmrghilhdrtghomh
X-ME-Proxy: <xmx:r0IaaDHb0Yofhc6kvpDaMejkp5B_WPZaI7-aE7yiI2Zfr16DGrJoaw>
    <xmx:r0IaaDUeuHEy0tI5Bodf_mkxTkidAd5E66foy4UA-O1-k3DYdHrxVw>
    <xmx:r0IaaOMWSybPoVPH77EMA_rwzvnHi_RVp_1bl9mPy_7_gmXUTh5vtw>
    <xmx:r0IaaC1CaiqQpCOGEn_vzovnqlJKacgfoFj1oSTDe1ICZkd2KJ3h9w>
    <xmx:sEIaaHfgO5XwMAN9KD44vNS3GvPzx7wbkPQpvFs_RQktz-V71iGaABjT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 May 2025 13:11:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  M Hickford
 <mirth.hickford@gmail.com>,  Julian Swagemakers <julian@swagemakers.org>,
  "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,  Eric
 Sunshine <sunshine@sunshineco.com>,  Zi Yao <ziyao@disroot.org>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Steve Hay
 <steve.m.hay@googlemail.com>
Subject: Re: [PATCH v3 1/3] send-mail: improve checks for valid_fqdn
In-Reply-To: <PN3PR01MB9597ED4DA3E781A6EFC03B9CB8892@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Tue, 6 May 2025 09:35:05 +0000")
References: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597BD33DB2C4F3BE9E5F4C6B88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB95971B8A202ADEA412010B35B88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<xmqqplgmlisy.fsf@gitster.g>
	<PN3PR01MB9597B15F81AC6DDB35546C2CB8892@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597ED4DA3E781A6EFC03B9CB8892@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 06 May 2025 10:11:09 -0700
Message-ID: <xmqqecx1ll5e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> I think we can add a minimal check to ensure that there are no two dots together.
> Does that sound fair?

Is it a common misconfiguration in the first place that singling out
a name ending with double dots (which indeed is very likely that
nobody should be relying on getting accepted by sensible SMTP
servers, hence very safe tightening) is worth doing?  If MacBooks as
shipped would by default claim to be "MacBook.." like your example
had (I do not know if that is the case, as I do not live in Apple
ecosystem), it may give us a reason to special case the trailing
double-dots, for example.

I personally feel that "run of at most 63 alnum or dash separated by
a single dot in between" is easy enough to explain, so if I were
doing this change, I would just use the regexp used in posted patch
[*] and if nobody complains, stop right there.  If we get any
complaint, then I'd detect and reject the case where the string ends
with double-dots.

[Footnote]

 * ... but I don't know if your use of negative lookaround
   assersions is correct.  Shouldn't the "a label cannot begin or
   end with dash" be applied not just to the first label but
   consistently to all of the dot-separated labels?



