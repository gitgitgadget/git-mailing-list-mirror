Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E056015853B
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 12:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731329600; cv=none; b=U5YJrn6el8obUIEi3ngURmeTPEbbTMWaDBMC8Q6Ku9MhIxfGO/Yxdj2p+UXDVdLVMkNQWJNzgLKBw17nI880I/aoLN7PtR41MzVTEsaB1IxKPy4xIGy7OasIYqcdPxmv7V1enCuDryfLNpUWfCWHlNZV9i6VDENqeX1VZzQ67Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731329600; c=relaxed/simple;
	bh=gty9HqccVxtIWzYKcBK0FQTGFDybNzQIU+CHT+KPnEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovc2bCvEoKZ0DWoBTBxfBE7mLfe+8WtdmdYwKgc7t58L5iyO8kLDX2qo2ggs3QnSR00Ecr8MMN3S9Zm9GHWgbN2WKoF25QOhxOYS4Wph8sNQY8aULMmr7xSLqaMvVPtX8Z96MDsvA+Y7yPA1IDxv53otcG4ibMFe33NuWlHc72k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F7tkpzW7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IjFrfrWJ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F7tkpzW7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IjFrfrWJ"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 1476D13805E7;
	Mon, 11 Nov 2024 07:53:17 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 11 Nov 2024 07:53:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731329597; x=1731415997; bh=cPfmUajR/h
	HKqSNxagf5YLiiWnNi7ffDfXF9x/N25Ig=; b=F7tkpzW7jJvckgO6AuloBRDxzy
	TlaYhyHZjPqFuJrx9I1nf4QenqgpaaZbPRbjLnYtgQpKy7rAg+yHOmel4WuxxngG
	uoR4bEc5pxxwHMUhhOuSjeXVdjIu7UlOp9PT3TdhqhYScyvpqkoZ+0kzcG87c55L
	pLREvm0K2BLeKWYsIfnuic5QMicnzPz2wRM44v1HMYKt0873osa1R4uV1T2rizQC
	l6WiL/Z/wwFCn+IjNZtnzMWGim+RebhSNhHz6Pz8HInE0gf04bDpyq7hrq9AlxeB
	BwenyL/X3v8sjsY9KVWVu2TE7gakQ+P0MW5hjHdNv0gAqxQ1dGVx4VBw+A4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731329597; x=1731415997; bh=cPfmUajR/hHKqSNxagf5YLiiWnNi7ffDfXF
	9x/N25Ig=; b=IjFrfrWJXBxky5v00REteWnotqt6x9p5orA0dtiC5l4MS7FWgeV
	BUqh4SfsIgIKHtqMj1JNN4nF4ULJdQPtpGIZunTFNeGDMSFpOm9XQAs1AzqpxtbL
	kTcFfLX+ErkHebQkawd/VO1biYlW/rO1KIqtuteD0nwX2/VgSyTQuyyAYuju+9hd
	Qgxd1YFgs3pJGoDVD5R0cgb8bCB1wHMz6ArRGXbxYcQZzYB2yuo+4jH2tgoG9sFX
	xv2WRGfbi/ajbJOOOIyykhmuW4RuYbEyOKlScjk7zpAgNbFWFX1FX3OMSsBMQ71/
	+hC4D3Qtth0Y1ZuIzDu9adkjca9kAkgUUZw==
X-ME-Sender: <xms:PP4xZ5E59k51sX049aw0q_S_83UOv2SsH_L-zmrVUAGYANaT4b6Cgg>
    <xme:PP4xZ-XkMO6fCQm7zGwzr9bftRUhpALNaleQaqynaXpUpx4hmrXa_YQ18GHNfcln6
    Fo_aaas3hurY3E7KA>
X-ME-Received: <xmr:PP4xZ7KL8-j-AP2QOnX-7kSNkFmT4X23tzQ9MJsr-rFWxffb6mmGHeYIHxovxV0nycouPHBojQHeqg70C2PjUm2bTAz3eFf94pIOFbL_Sxu1OUjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:PP4xZ_HSL2hQrld0PYo5HzmFLDth_i9Ab7k_PM5GsqFArXoyoHPDMA>
    <xmx:PP4xZ_UaUQThqU896OsWi61dSjawJna7SXcD64pLBaWarHDbSh8LxA>
    <xmx:PP4xZ6M0g4WzgdalZ91RiQZ4zzvLlEcgsreqL6S-TtFXEmP8lay3XQ>
    <xmx:PP4xZ-1sCQ16iwRtdTXtGvprArZ5TvwPQVq2mG22eTuZPnKi3D5grQ>
    <xmx:Pf4xZ8ixZrv40e6yXy5Qf5dPbQSqTcDMHLC4Mhb1fbOrcVQqbBMad6QO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 07:53:16 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 47a1ac01 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 12:52:40 +0000 (UTC)
Date: Mon, 11 Nov 2024 13:53:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/10] refs: allow passing flags when setting up a
 transaction
Message-ID: <ZzH-MZ29Nu9yUu_Y@pks.im>
References: <20241108-pks-refs-optimize-migrations-v1-0-7fd37fa80e35@pks.im>
 <20241108-pks-refs-optimize-migrations-v1-1-7fd37fa80e35@pks.im>
 <CAOLa=ZQKJ3Twdze-08t3kh=kiuy6h9GfNSO25PkinjTwF5oG+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQKJ3Twdze-08t3kh=kiuy6h9GfNSO25PkinjTwF5oG+w@mail.gmail.com>

On Mon, Nov 11, 2024 at 05:30:18AM -0500, karthik nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Allow passing flags when setting up a transaction such that the
> > behaviour of the transaction itself can be altered. Adapt callers
> > accordingly.
> >
> 
> Maybe it is self-explanatory with the upcoming patches, but it'd be nice
> to know _why_ this change is being made.
> 
> The patch itself looks good.

Explaining the exact use case here wouldn't make sense, as I'd basically
have to repeat the explanation given in the subsequent patch that wires
things up. But I can mention that this will be used in a later patch.

Patrick
