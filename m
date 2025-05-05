Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDC1314414
	for <git@vger.kernel.org>; Mon,  5 May 2025 23:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746489256; cv=none; b=TdKOo9htIhuWGqENc0FhQsUCjsQRsrrATx6qkzRTHHDvhUnIgoNEC1R0XS+rSxLry1SYD3srSBZ+sXC3ezgqzzurcJQcnJuSgC341eHO/Ci8IIX1YwBsQ99lpIPa8ndZqvFh9jbtEbSXJHBheuXaRsvxc7TTd832YFH+R8/dNHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746489256; c=relaxed/simple;
	bh=5Viq1vbITCyvupu0GXjWBfP4b90Z8lnQ4EmY+46Vs5c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=glqmEPGAd0+oI+D+pHtoDnRvfaqHErw/jLpus0NfiozItJNVHsx4i8BrV6tuIDmbcbpICgn2vxfnFnT//7x9cOzdOmRlQQh0bkI3KmiWFwCHxjXD8WtjFOhgbFNzh0sUEW6gFjLOVx/ZfvxFDilt1fLlJImntHOQK+8UUwVtHqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J97LU10Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dD7EmIzg; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J97LU10Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dD7EmIzg"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 686812540222;
	Mon,  5 May 2025 19:54:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 05 May 2025 19:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746489252; x=1746575652; bh=94QfSj8L1A
	5iiCJPlulN56IAHlaRsbou1uqHVszJFaA=; b=J97LU10YSj18qguhdxnLP0UpuD
	PFAmVN0nvpHaJuqjpdsYmNwGZ8zAfyeGt1hawlkK6yQmK3UlnE/Xy2kfno+i7bTF
	1UDEhyUZBE/PUIVuyob3n+rhESDYKXEZjhVcyS96gUEPvvAnJa8UnBJuLb1S+ryT
	u94P/IKA3Bi7DQ6cSEDDhN4Wr3JDs03ZC7itGYnNdN1PPMFnDXpnLF56aNtXzWZI
	41mIHrEvXa8hcOc0GHxsddsUeK1Uo3WDfUcoaPA9RwA+Wqww65G5vM3oxjPuhgzn
	1yRLVl/I+9xR2wcE8qHkX6wsBP4xnq93biBo5nkw1obfVhxHila2jeSPHfdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746489252; x=1746575652; bh=94QfSj8L1A5iiCJPlulN56IAHlaRsbou1uq
	HVszJFaA=; b=dD7EmIzgy175FWDAG+WDsqKulnHKiqxytRrmohzDiqYoFE688IS
	H30chNjPNGAYvzOtPjusxV7pKH7++o+SONdccF7NEyn9ue5xzbg8Xu7EAav9CHMO
	4ez12zmN99xJJ+ZuSZmD35R4uAuwyah/3OQ2h3nWaYr9tZkpel3QuAdpHJ20uNUr
	Eo+BXI32zjYl5/NXhDpd3T7QMN20NaQXefEZeT/5HUzfTHepyxFJxYLIsjPQWEpc
	McfaB+C6vdZ44EezbRqPi3iBC5stsIAgBlCHaSd30Q4lVgDp7mK6DjBF/JU5YkFt
	1bUCfbUbPX8dBR8UjXUpZIC1KIPt6oeCwZw==
X-ME-Sender: <xms:pE8ZaLLDHoifMwMQxzkP7hVTKRIpQZEyJSUktEymRnLEmvY4cYv2kA>
    <xme:pE8ZaPJa-aQrglHIGPvl8YuNYSDGj1-J0l7369SAfY3yXXMAIPa4I9lo65SviO6HT
    oo_53yJS7TunJIe2g>
X-ME-Received: <xmr:pE8ZaDt9WfBPU4mKI_QiipPr80i1ifTdCHSFeBzmsIyTg1f0eLM_C82371Ot_Fm8cJ5cj5ktj8FkkndWnJaGMhOFpQbPlytsioeF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedvgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrrhhgrgguih
    hthigrtdeksehlihhvvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepjhhulhhirghnsehsfigrghgvmhgrkhgvrhhsrdhorhhgpdhr
    tghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpd
    hrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphht
    thhopeiiihihrghoseguihhsrhhoohhtrdhorhhgpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:pE8ZaEbA5J24QCnFjddea5l1uuvb898hTggHVb5SsOZUf1iGkNzaIA>
    <xmx:pE8ZaCaG8O-SdYGe6m3SniPK--08kpjCufStRrlaZk9LEE-cyocwoA>
    <xmx:pE8ZaIDe3WHcx8eqivcX0fDT3rYfPJVLtfbkEwYyqruAJRt3_nkKYQ>
    <xmx:pE8ZaAZO_JEL7IuXRqY7qAi2on48EULM2yKUrt_yltNslP2P_din6g>
    <xmx:pE8ZaGj69D9lMHKH8zfzP8ckpMDlJUFoWJDpNwmgmlBatJuWZ0UbpO6Y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 19:54:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: git@vger.kernel.org,  M Hickford <mirth.hickford@gmail.com>,  Julian
 Swagemakers <julian@swagemakers.org>,  sandals@crustytoothpaste.net,  Eric
 Sunshine <sunshine@sunshineco.com>,  Zi Yao <ziyao@disroot.org>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 2/3] docs: improve send-email documentation
In-Reply-To: <PN3PR01MB95971776178BED3516DA03DCB88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Mon, 5 May 2025 15:23:04 +0000")
References: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597BD33DB2C4F3BE9E5F4C6B88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB95971776178BED3516DA03DCB88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 05 May 2025 16:54:10 -0700
Message-ID: <xmqqldralil9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> +If you want to send a single patch, run:
> +
> +	$ git send-email --to="mailinglist@example.org" HEAD~1

Didn't I already tell you not to encourage to run format-patch from
send-email all over the place?  Just prepare the mail files once,
and feed them, perhaps

    ... how to send patches to a mailing list from a set of patch
    files you prepared with `git format-patch`.

    If you want to send a single patch:

	$ git send-email --to="there" 0001-fix-this.patch

    Or more than one

	$ git send-email --to="there" patches/000[1-4]*.patch

etc.

> -	$ git format-patch --cover-letter -M origin/master -o outgoing/
> -	$ edit outgoing/0000-*
> -	$ git send-email outgoing/*
