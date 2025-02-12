Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984C2208966
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 10:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739356950; cv=none; b=a/JEEk102MZ/7UIPDsmhD62LNN5IV7EGidPcKyVABiEwtlfb91SOZlxn2gwQgpiyhrFiVCnOSRtaPGrYxrPiRe/4LIQPJUB+ZXrsF0mfOjJt3wa9DLzTFT0axl850pN4Nf5GtJx4LDGWZqJUOhyhjj3347SfGGS1zrpkI3LSr3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739356950; c=relaxed/simple;
	bh=imlcO81ARK9PLKwrn82PnY1yc8/vqvvZlPieX77qB4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLYzCx0T9ZwzACjXlylG0SpS/GRmxHYEAOY+z2omeQ/cDBMX3fwED0O4I/uwZ1KPnNed0qaR75qxcCddoFTb0lLWYVSfEn0GFWlzIAZM1uz2+q3vF9Nn2liV+HyuiSuWoPfMGcbDCQc+v5AtpPd5QnCkinbhJdm4rQFfYubv48Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Qup5GQNB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LWf+Purq; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Qup5GQNB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LWf+Purq"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8B99C114027D;
	Wed, 12 Feb 2025 05:42:27 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 12 Feb 2025 05:42:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739356947; x=1739443347; bh=Hv7RmaJxk7
	0mGi5zNGYrVO38tF8OjUCNW5A8dWNjdf4=; b=Qup5GQNBZMU2mR7aK5xMjs0nln
	ZC99/ZYYIG8hWRFe4+W3gSG8meyI5xi9z9JTBz6YZ1ZNMN/Ex0K3a/NZsX1va3uc
	TfWTwUU8o1zzhMz9IiMDZ6PLbLUWY/62DxoppXZTRsyCl9iAWmUI5zLF72YG9dDU
	WfSr3BPk2eWfAcg45bsp85VB4cPabQSzuwuSSgKnoDqX1iko2j4uSNZfOgzKPkEY
	BYyS0VFpuINipG2LGNBfW0IwXy1Hh8kOV4gt+KJ4wJS07w+6Vu2JfVq/79kiKTay
	noe7hYf3kS/b3Umqi28K2StMPXsIWVfmyhCfuuTaKdrR0q+kB2I0GFsFcgaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739356947; x=1739443347; bh=Hv7RmaJxk70mGi5zNGYrVO38tF8OjUCNW5A
	8dWNjdf4=; b=LWf+Purqp49tSj4zWvcluA3mWhCBbwx+Qv4Vl5PWXV/5ikAa5I+
	YwREIQkL/qeaJ1mgOdGnJbeM8n+3lrm0r1uZkHLaClwAqkmwTJEJN0M6LhOcaSdB
	wt30/g2DHe3pIjYBLvdTtAMLzZQbCQ/sH/h8Q+vuUIIgX4xK25SnHQiWboxqy2na
	eqGiE378nayncmueqyg/Z5kAFrWdoRz8KMQgopuwNeMc2wAkBxsfkrbo+/+4IdZx
	IWMYU6BQ4Qq7fgIk1PTgJYTmD8MnxhnuDy0/YhkH9Iw58sHSAGXBjMsdLovMC+/8
	G6GThJpB9ff7zslAFJqBOEMev8DU0vqnzAQ==
X-ME-Sender: <xms:E3usZ2_qaCC9Coaf9jG7rf_cxbKh4YTvMTJ80WrLzIiJm99Q3dKxzg>
    <xme:E3usZ2unlbdiOXFBpz5t6dkIMdE4IBjxTzSMWfD4BKtQK6PsDRuMJGLKBTuRH4jFi
    we73ky93aGYbwsLYA>
X-ME-Received: <xmr:E3usZ8DCJrf8dWZ8hUG2tMV6SP8n8q3rs7VM7PWRhCr7ojGwurBiPslWah2-62c1bQ9V0aLo8qrjJ1QqDdaQvOFBWVHuuP69tzdaH5enp17KFAs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfeeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmhhgrghhgvghrsegrlhhumhdrmhhithdrvgguuh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:E3usZ-fXXBwKCi4KL5WgV-UbCL8r0_pQev8UTESuCnDC-aE2lEVuRw>
    <xmx:E3usZ7M7uRQ9bKrgg1Fp7tEKq_rTDMqQXLj9dl5ZO1L0VP8zO13pmw>
    <xmx:E3usZ4nZawK6jQ8zR05CG4tZNSe8lxXcJ6P1-1E2UwQt_GFPEoSHQQ>
    <xmx:E3usZ9tGRrhyHv-0Tbz9AVMTdG1kiqwaFQCqW-Tdg2q3sjgBmRE_fQ>
    <xmx:E3usZ210UJkPgNagg3Zztj_sbnACfYMRw5e4XYQOSbb14pSZjZcJzbdW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 05:42:26 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 379fe598 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Feb 2025 10:42:24 +0000 (UTC)
Date: Wed, 12 Feb 2025 11:42:23 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 7/8] packed-backend: check whether the "packed-refs"
 is sorted
Message-ID: <Z6x7DwERuCKET77c@pks.im>
References: <Z6RPJI10-2QkwyqH@ArchLinux>
 <Z6RP2_wL1gjsWpkR@ArchLinux>
 <Z6xwaMIUx_x6QVrU@pks.im>
 <Z6x10U4HUwMYKUDh@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6x10U4HUwMYKUDh@ArchLinux>

On Wed, Feb 12, 2025 at 06:20:01PM +0800, shejialuo wrote:
> On Wed, Feb 12, 2025 at 10:56:56AM +0100, Patrick Steinhardt wrote:
> > On Thu, Feb 06, 2025 at 01:59:55PM +0800, shejialuo wrote:
> > > diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> > > index 658f6bc7da..0fbdc5c3fa 100644
> > > --- a/refs/packed-backend.c
> > > +++ b/refs/packed-backend.c
> > > -	return 0;
> > > +	string_list_split_in_place(&traits, p, " ", -1);
> > > +	*sorted = unsorted_string_list_has_string(&traits, "sorted");
> > 
> > I think we call them capabilities, not traits.
> > 
> 
> Yes, capabilities will be more semantic. But the original code in
> "packed-backend.c" uses "traits". Let us follow the original style to
> make sure consistency.

Interesting, TIL. But yeah, in that case we should continue to call them
traits.

Patrick
