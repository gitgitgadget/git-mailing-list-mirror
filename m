Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94EE1F4E4B
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 14:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735309610; cv=none; b=d1MauA7Plx55NjHO4MDWwe/KUU3b+11H+pNW5KaP7rSMCCJ5Sjd5gfNEbZmtry2F3jvEGlq9jRgCXGaJVWxmslEBDPvL7+Ngtnjr1UecfUkqKsARv3ulpqkAA4lkcTJzVh3nPKNTWZfwCLS73kg7PL4vg3UlKxPscdQR5hRDBwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735309610; c=relaxed/simple;
	bh=VZ+8I/BeJI1PByIggde4MuCANJsnPXjYsiUXx69fyFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8AlQLJNFcnrNSuP5i7VGQg9y73PAMWcPGW4pAAvoiAuND/epiubjKy7SG73yUMxaJ4WHV8nbGcZ7p+9wdACCU26tU0JWPjZgH7bhK2JMPpyTzQptyI4G7wNTPSrKY2zE/6etCIoDrHOauek4zAt6jmkvh7tZoZ0P4p5vbUUpaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jNNrh84S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vaoMdOqC; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jNNrh84S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vaoMdOqC"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id DF03211400E3;
	Fri, 27 Dec 2024 09:26:47 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 27 Dec 2024 09:26:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1735309607; x=1735396007; bh=MNIdru/ZZ5
	FKNxyfcClQjQJuvuonThECvB7vWoRoSWI=; b=jNNrh84SblGoJICT6ZOAYj1/Zm
	ZOgqrYjEEeS7YjZnZ36Oa7k5up1Ghf25V29pFW+au4ByB0verrUFTmsKQbvvXSxf
	xa0X0CAst/+lOatce+MJ7Ma8VhRBSgAglXDTzNP3SpeFFYz14Thdx2oA3uUR4a4w
	+vH5tSTBkse+96H+xsMrx7FWkNSIw2qkA931RGHjE6eXumSlpxM/Mo6r7abZPDHR
	ECcMzZp7CKXIUJ1PSxb7zA+vNgHBNUrhKzh3HuKiOy9l4jZkR+KcqvxJH1qsG/6z
	qEpdAMqPds+cmoH/bWPud5dCjjIvv2FLh6nWTRoGECUPyK1035Gb6w0Vx0vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735309607; x=1735396007; bh=MNIdru/ZZ5FKNxyfcClQjQJuvuonThECvB7
	vWoRoSWI=; b=vaoMdOqC6+Tk4NDsC93GMI391lrKR+de0C5c4vwKCZfKlQ6CLWI
	KmbCWg+8IJkyHwIVqf8Xz8XXo6x4NDFePA4F/QUYZ4zrgd3aPgHw5p9ULp9qJz1T
	U3QdqGpDY2+LxnrCRTk0WYnKcvVo0dzC8TlQBW0PwL+nj3Vmm0ytstVtuHIHoTDB
	wVwT2wEiElSyicv44rNsOuRWhtfQPSmgsJwVZ1vcL5H+766DNAg+zcZTTAi7qYoE
	wMEt76ZgeGIsN8pb02iPKs5qTG46awRtK6PZBj73HQIODKIqj7QgXcCybHmSZZiW
	9ocNi4OBkItwxDOBxHX4I+YRp9sVm2itomg==
X-ME-Sender: <xms:J7luZxi9GfSL4IslWo_kCY2F86QnfoI-KsD8E4Y7HcF1bnFg_5VgKw>
    <xme:J7luZ2Av73gLynXSSZdshnsdbc5cdIM0RuP7-1nVWGudljEDuJEov0o5Z2jxXdvBl
    yxAIok0u3yk_jarRA>
X-ME-Received: <xmr:J7luZxHER0b8WRVg7LCYmn7OlNGjfyvsWcu-TEThFUfsuos76uctZPdx8dToBg3ZiS123EJIb3WhCxY5J-KaMPAHM4UoH-EKn7dFEC8qCByW4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrg
    hilhdrtghomh
X-ME-Proxy: <xmx:J7luZ2QtRSnx0gJlX0ZvrvzVZ-as2KqMHsXyaiVsKIVXwb-DazqZVQ>
    <xmx:J7luZ-zvr4VZHmgWlycmyHiSca7JOtGum4FYj442y_-d1oc-RIPBMA>
    <xmx:J7luZ87L7VPehnIj-VGwYAO5gXV7hdoBo9FPKsFXHbMlFHLm-cY9Ow>
    <xmx:J7luZzxs4FkZNR167I95E_R-RDaxlOypg5K2YKkjOp6Y1dqmXcKS_g>
    <xmx:J7luZ5-OmH9Hv-XneWRLGXAiNYVt6jW6JYaYfQ9Rbe25P7PY398CMQzt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 09:26:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9c225ca1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Dec 2024 14:24:41 +0000 (UTC)
Date: Fri, 27 Dec 2024 15:26:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/14] Stop using `the_repository` in some trivial cases
Message-ID: <Z265EvdDt0ynGC1M@pks.im>
References: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
 <Z2Fygp-5pFQi1p41@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2Fygp-5pFQi1p41@ArchLinux>

On Tue, Dec 17, 2024 at 08:45:54PM +0800, shejialuo wrote:
> On Tue, Dec 17, 2024 at 07:43:47AM +0100, Patrick Steinhardt wrote:
> > Hi,
> > 
> > this small patch series performs some refactorings to stop using
> > `the_repository` in several subsystems. There wasn't really any
> > criterium for which subsystems I picked, except that all of them have
> > been trivial to convert.
> > 
> > In this patch series I'm merely bubbling up `the_repository` one more
> > layer even though some calling contexts already have a repository
> > available. For the sake of triviality I decided not to handle these
> > cases though and instead let a future patch series worry about them.
> > 
> 
> Actually, I am excited to see that we remove the global variable
> "the_repository" in some subsystems because I have seen every patch with
> "<subsystem>: stop using `the_repository`".
> 
> By this, we make the problem smaller, which is good. I have read through
> all the patches, which looks to me.

Thanks for your review!

Patrick
