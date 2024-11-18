Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4431ADFF9
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731943611; cv=none; b=khN3eNmoyo3KUE+w9j6hLfiESxE4vwCM3XkCHbqwjemDs5cbh3+0tyu6/OpdkulbUFVaD84rwQrCs+gm2kGq/c3iZ2PVr8pIHnsrIA3NBEA5sHjiA3VWYx8vCKex8PduK4NRrM0ryEqTyLpyV0vVRcgw983Eb2QxvyB4iP4NWLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731943611; c=relaxed/simple;
	bh=iGiF6ZUwCezPbjEqXpTSA8+kBqJqJSdx4oMNLcL7p44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dObZxxFfXqtTOClwrsjPJOZnwHqUJUMReElvKXa7zQ3iFRzeluEjC4XytLYmfHqAt8q+f4ZCX2Td9KHq2XEOMkkAeHlMywjXXsCoU+eqWxq/q6Uo52lJYTBIddGSIiV+1H1WrvpC53dvX4DiZpeGNtOSh598D++HmpLlxgZfIPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Cg/Pdate; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d3JUYzaS; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Cg/Pdate";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d3JUYzaS"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id F11AA1380601;
	Mon, 18 Nov 2024 10:26:47 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 18 Nov 2024 10:26:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731943607; x=1732030007; bh=S8mQ+KVZ7X
	hSpxO4kkXbhhnrGaCpI/4mttrZmnLJXlk=; b=Cg/Pdateh7nA0Za2icgrSrZbGA
	kijFToezgjnUJFt68HIglgCChqMsGMGjZhUmUVzc5vpK4oDBG+oqyskiCUslIrXN
	wLb23/2kwjraKxfx5xFv1GiG4nWjKbR8RbjoScBDAUYi2jlT7M6Ahf9Wx0HA3l3d
	xSb4AEYC7LOq8Gpfz7W08LdmjGNyc7KUCi7dr4ITS5D7VxiFuLebaNxa1HdMfup1
	HLedgtfiyYiyIPrCwonb2XRV+FqflNwWgIhvd26yh/yOD6CkT0d8hVZFmOtNG8XO
	NohSx/qCNqIvubTPFaNKtB3rqfxhlQiOEW5MphMyX6hyt1ES4lTxBTVcOxnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731943607; x=1732030007; bh=S8mQ+KVZ7XhSpxO4kkXbhhnrGaCpI/4mttr
	ZmnLJXlk=; b=d3JUYzaSXUP/4BiArmOZgqOHEbX9NHTR/jpqGTPp8BpPMecZDyN
	sN+gEe8fiGCktRfluXRYkdHGMqMawuGq9+ksPtjivgTonBpkLrd4eAov9v8XR+1X
	JhQeVrjGhx8WQjTjna6EZG7nQA6K1zWAkz91rspO8j3N092v8iwU/TwmSi32dijL
	fmzUP5imsazaXsS8CBpj5U1VB4SN/JjvaGWFGaYJpzwXj/jNbmTIk3A6WSfGrC/I
	JpcfReNFxHfkpaGT4rtKUMzsGU4RAp37D+XP6pxr5h9kQveP96A8eUi/e/5l8X5z
	F1k7gPpq8RT6imDvQ3RsehjS5VgI+qsAJSw==
X-ME-Sender: <xms:t1w7Z4fTJELGEMquOSuoN0DIMbfB9XjYRfYhjEW_-jaItsRkZLlemA>
    <xme:t1w7Z6N2I5r8mZ3NiE8HlLJV6TWsLS8E5ZK4wAVffdGlFJJC1xtDV2FNt1Hg86xhb
    UH-r0O70OW0D9tXEQ>
X-ME-Received: <xmr:t1w7Z5hNVC3-1gdQjJuDdk9f7OTdwniJHlN32xioacYQ4TfMDNmr4FXOS-WdMDcAxWBcnwFMuLmr3KyDmAvY2cW6wXFZQP8in-vVEq7y2aaYuaMK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedtgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghthhhomh
    hsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepjhhlthhosghl
    vghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:t1w7Z98Fn6fMYDuzRMxke8jHjhz3Q1dQZXSH_aTp9L4Eq5-sztp0CQ>
    <xmx:t1w7Z0ue00VOT2U6GwLPNtHS8xg-6cSm1zNDwbwlQJ1z08BuLShFxg>
    <xmx:t1w7Z0FkXFP1kSiE_BNW6Fia6sfF5YHLP-ZQ2cHflRk_rDp7E3RcJw>
    <xmx:t1w7ZzOn8rwNCLHu_u9CK53MUHFF9cztAKOUwyhDGE6DCN17rUJZ3A>
    <xmx:t1w7Z-XAlFQcWQhkehKy7AcQFr6ISg55x_tM6Tr4uvhgeiEzdhSCA-RM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 10:26:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 46f4cf71 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Nov 2024 15:25:58 +0000 (UTC)
Date: Mon, 18 Nov 2024 16:26:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 0/7] reftable: stop using Git subsystems
Message-ID: <ZztcrOog-UtHx3us@pks.im>
References: <cover.1729677003.git.ps@pks.im>
 <cover.1731047193.git.ps@pks.im>
 <CAOLa=ZQxtQ9zBqN9U8ZnxaQ+uyMqQ1EnfEL9Br918y6CBxtvVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQxtQ9zBqN9U8ZnxaQ+uyMqQ1EnfEL9Br918y6CBxtvVQ@mail.gmail.com>

On Mon, Nov 18, 2024 at 02:30:44PM +0000, karthik nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Hi,
> >
> > this is the second version of my patch series that continues to detangle
> > the reftable library from the Git codebase.
> >
> > Changes compared to v1:
> >
> >   - Fix a commit message typo.
> >
> >   - Document the values of the newly introduced reftable format IDs.
> >
> >   - Include "reftable-basics.h" instead of "basics.h".
> >
> >   - Adapt `stack_fsync()` to take write options as input instead of the
> >     whole stack.
> >
> > Thanks!
> >
> 
> [snip]
> 
> I went through the patches and I think it looks great!

Thanks for your review!

Patrick
