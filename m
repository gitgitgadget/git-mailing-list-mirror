Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE27147C71
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 10:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731927098; cv=none; b=RwbnHhxr2lqus8FB/iSi711DWx+b/tmzK2nJyg9xhicVZ4JiM4m1GU5kac00c2rqyvFfSFfKLCoA4c9eHuqscbQwRHv5CNEwJhvmNaJqp450uDyQVXiuuy9cgEL+etB1PdKl+93xgjkKmRrJg50GSvxD06tZHpcfzmBXqsYX6gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731927098; c=relaxed/simple;
	bh=nr/DPUZADu41bBUc/JHOkJqzlYF9jA+AuAwlx68FbDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWPe9jAotcGvxEPu1KGHrdeeZPpt5hnt4LUNV2nJfY5Tvuq7U9X4t83HV2XuUshSomLV6BvajcLqjYIMc3ht0D/bqAPgF7VimTH5RpO4Fu2qskXJSYcdyJlpxyPHYvk5RIQqeIMnEK3lXX7oV4tHM0t4obUdp6gSaDzByiPRWB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EMag+whW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xyz6bgiu; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EMag+whW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xyz6bgiu"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id D18961140192;
	Mon, 18 Nov 2024 05:51:34 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 18 Nov 2024 05:51:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731927094; x=1732013494; bh=YQFFct4h1V
	eP83wRqzpNS6TdFHLwrjPfMVFxfqbstUI=; b=EMag+whWsLz9LUlIwqma+ioZ7b
	RCmvF4oSgdyiyZHUfZCKsXz9b0KD5pvaqL9E5FquM0+0Xj0U1J62EqL5TvOWMgXO
	e95/8IB+ix8uEzMpDRFYYigE4yHfN8vXEOkG4m/xDcQ2ifG2udYv+zhSbH7lrm/b
	8Rs7ixE9BY9F/jX3Pef7tJ/hyW+qSu55RefaB58H8bRS03NA7vdZODOmylf5lETY
	/PBUMZDPFFGtevAT8rapV4kNSuHKpyIB1vNUF5vrRIFP7ac98LTYMtQLLYlzc0O9
	UQS8lQ8C0qM+EX5h+GvwoG0NZR6DYl6EPvlvGunA3HAV0yke9TWOxy3ysRfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731927094; x=1732013494; bh=YQFFct4h1VeP83wRqzpNS6TdFHLwrjPfMVF
	xfqbstUI=; b=Xyz6bgiu6daUl3GWinf5QPRAMD9w4+ZX7XgmQi7KjZXphbI/sUX
	uEmGYLOs2tmpJZp6ENYsnbRsmeB3yldNcuGeKMkeM4PqYLhAcjO5QSiF/OkN2k5d
	+QBtzpojct6RmYmPeLbpqxWB15V/V0NBGLqXpZX5tmO+AA1UaEWD+2H1HsPL/Z3N
	jJGw6XwJZ+lAHDQcrmcfVM3tqz7Rlc6u5+Vhhu2U8xTcncNwWbeZqkTbxA5s77Q0
	inF8s9vnRjiZjK4w6jlItEHO0C4EccKRqt+mk2Ute66SqbGnIGNCUwLTPEbNDzJp
	M2R55ms079tCpeYuF5rrfr6YW0A+GdLYWCQ==
X-ME-Sender: <xms:Nhw7Z5Tp_yFWhDA9FdbHw4zEFO4ROeDqAKjXjY5mCvwap_d-Tk2aWw>
    <xme:Nhw7ZyyIN1pJvVTg_9n4P-nUddiv1i_BPN1-3LjrKa5R3epXH5aA4oKkQS-wZcbpf
    KA0U7ld6YAJIFcRuA>
X-ME-Received: <xmr:Nhw7Z-3a7PVDgrEn28BGvnB3lTsyVZ_cVJfGvvd6uP-PaM4Xr7uR-c1jCHWPU87qJbHK1unc3Y5kHmtf9fMfwU4-l05lk_JTG7ozKC9BO35rBGd4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedtgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheptg
    hhrhhishdrthhorhgvkhesghhmrghilhdrtghomhdprhgtphhtthhopehlrdhsrdhrseif
    vggsrdguvgdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrsh
    htvgdrnhgvthdprhgtphhtthhopehsrghmsehgvghnthhoohdrohhrghdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Nhw7ZxCR6R93Au-CKRohJbNmx5ysgDvLuRoT_YVIcy7LB5gIviU5Rw>
    <xmx:Nhw7ZyjoykV303e4Q0KNHhvvsY80MfxJwi39knf7aqxMzCYOcRUFEw>
    <xmx:Nhw7Z1plvzlyBamYwHSCQDntKNQOgqYFpGs5LQRMUyVXSx1tMi2bag>
    <xmx:Nhw7Z9iUInmN4BNRlc3kBxsPSwzviaWlyJ5wlTWZ2AxW0-ElBcNkvw>
    <xmx:Nhw7Z9XbSqR6KTPbY4cNA0uD65jx0-Imx2k0BVVEggiuXmlYCunqZe13>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 05:51:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3176a8c8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Nov 2024 10:50:42 +0000 (UTC)
Date: Mon, 18 Nov 2024 11:51:20 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Sam James <sam@gentoo.org>, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Chris Torek <chris.torek@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
Subject: Re: [PATCH 0/6] -Wunterminated-string-initialization warning +
 cleanups
Message-ID: <ZzscKHq6HN0pThV_@pks.im>
References: <87wmh2o9og.fsf@gentoo.org>
 <20241117090329.GA2341486@coredump.intra.peff.net>
 <20241118095423.GA3990835@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118095423.GA3990835@coredump.intra.peff.net>

On Mon, Nov 18, 2024 at 04:54:23AM -0500, Jeff King wrote:
> > Here are some patches. The first one should fix the warning (but I don't
> > have gcc-15 handy to test!). Please let me know if it works for you (and
> > thank you for reporting).
> 
> And here's a minor re-roll from comments on the list. I was able to
> reproduce and test myself this time; the patch indeed fixes the problem.

Thanks, this version looks good to me!

Patrick
