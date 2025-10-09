Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B861524501C
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 06:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759991773; cv=none; b=i+rL8k+qo4luhZ3nOgVXP1CGmlL3O4+2UOFt2iTTOHgJ/4/36PVNhah+Cn/4knqI9rol8ASJkyY/EeDFsg+0ldOlCMk59aewFmmkQTSSb2TUGRvg2mf+rk+RnaU5T4kqOfssBkGwI4sPna+KAc+Y095LkoZsDmlKGoNq91JAEzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759991773; c=relaxed/simple;
	bh=HjzTlcEl2rz/icncsNlPBlsAxW1nlKQfTxf1MFLsE2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhtfZNPV1BCaUaG5lYjl+GjUUuqjKjhoI6Cb1/hWUGbn46Bh8CGpksKJO54f/9vnbXsNEmLn+n6X9AFCDZJmvkMibMb/lTFPV8kMIMDAPM/JmrM6CFWTu/p8ycbudo6HRa4MENC1cnmXIZzcmC72ospII06J1IUxeuI+N6ZiNnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FMmHnTjS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NwxwQjvn; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FMmHnTjS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NwxwQjvn"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CB4507A015D;
	Thu,  9 Oct 2025 02:36:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 09 Oct 2025 02:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759991769; x=1760078169; bh=Iy+GSKk7J9
	9wduBJ7f+JBR3y5VYv4nmYMav4KkMH2/0=; b=FMmHnTjStaEZzz5GkDJWFWD71E
	QLWvBh578zMCGkd77XmwoBJx21V6NH/RGaDg82aLJ9DehHtxzKyZIveRv9+JhBIA
	qyN+00FI3dVBfNYMv58XPgmHoxcCOhNcUqo03uufI9hsDInRZZtGS+QHSiyCmdmO
	QZQS21mwxU3DNSIyUFqnMivGZwddSQYNBSm9twBqBTJcik6vllW/8/OYiQURWC/T
	L2j17HWyDiYfr9UJ/SuYKDmmyJenYlqrrqPQGBW2O1XilyiH6lPtUFMbOat+VZn7
	rbzLFs6qZE2XAtyPJFD1FE78cGm4RcDFSP8sdw5L+QxNWq4wl9RE4eXKTUCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759991769; x=1760078169; bh=Iy+GSKk7J99wduBJ7f+JBR3y5VYv4nmYMav
	4KkMH2/0=; b=NwxwQjvnnSz88Z+k2yKtfmS2cqv5+sHiNMknrNe7E+hKxgwKqj/
	GW9iIN/1a4pmMiitoVhfcZwdxCiJhnXDPVBArA4w89JGCBHcExVSLYmJ/vsFHUQq
	qLKtRN4sQOQ8kzvsDQEOR0PGfzx0RgnD8zSw0nNCE7JGROHxUrR5y4sDbcZC2cAe
	j4Z4XzYdY2j9BL5scLdUha0fdW65aRTpzr99Bcny5dGLfJvc9zkbKxto43p8wdAq
	LD5IjSvafXDbTrkcyV1Us3cMfEbIQxRVUzszpQQJqE/MvWTVqF7Jd25qC5QZ567G
	adSmH0VylyRhg0FRQrUmyPik3gS6n6VCJNA==
X-ME-Sender: <xms:2VfnaDES-XtHKzVtDf2yoYyne0RnIzSPLw1mBN2s8UWY1g4iCzs2Gg>
    <xme:2VfnaGVkJKs1mzobHtrBvwCEQYMNse-gVgYYszJa9zvE2Cp88Eo288O1ykYVvSVtw
    UegfqH_Wd3_PCLJQAhtPeun1-vCY6vnuWYrS49hNveq0ZiNX-Loiw>
X-ME-Received: <xmr:2VfnaCxzFui2H-J4ikLHQJiq0alk2Qb1-1N5esHdOexJGg8mWnuf1d5ojzpgbSVnhUwqNacPXt6t1F9_aFFCGp-XEVO6wHRplfh1jNNd2q0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdehgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:2VfnaMPacnnUJyfUsjHiYk0zrPKAIwdCEB8C1tx_pV5b6A7nteRPcA>
    <xmx:2VfnaL7U_JXKEfMDgU9dNiWhAI-WPkZXDdQwEPvLhALJvKjKutb89Q>
    <xmx:2VfnaFM0iYSbQYCOSMbUM1R0tYSOGMPVgvhh4K7iIrVIZwyIoQxhyw>
    <xmx:2VfnaBmMhsXJRI8_VvIq5mCA77zNerWO1JMdJ4b-qGPVjH1oz3uaaQ>
    <xmx:2VfnaFNB4sk703ohvWCx1Uh1VsPt4nBcU0KIpgtqEdRP-aIURu3FJkV_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Oct 2025 02:36:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9be21b15 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 9 Oct 2025 06:36:07 +0000 (UTC)
Date: Thu, 9 Oct 2025 08:36:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/6] builtin/gc: convert to use
 `packfile_store_get_all_packs()`
Message-ID: <aOdX01_MrVkDKu9D@pks.im>
References: <20251007-pks-packfiles-convert-get-all-v1-0-428227657a89@pks.im>
 <20251007-pks-packfiles-convert-get-all-v1-2-428227657a89@pks.im>
 <aObIw/et7DxB/NrZ@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aObIw/et7DxB/NrZ@nand.local>

On Wed, Oct 08, 2025 at 04:25:39PM -0400, Taylor Blau wrote:
> On Tue, Oct 07, 2025 at 02:41:08PM +0200, Patrick Steinhardt wrote:
> > When running maintenance tasks via git-maintenance(1) we have a couple
> > of auto-conditions that check whether or not a specific task should be
> > running. One such check is for incremental repacks, which essentially
> > use `git multi-pack-index repack` to repack a set of smaller packfiles
> > into one larger packfile.
> >
> > The auto-condition for this task checks how many packfiles there are
> > that aren't indexed by any multi-pack index. If there is a sufficient
> > number then we execute the above command to combine those into a single
> > pack and add them to the MIDX.
> 
> s/them/that pack/
> 
> > As we don't care about MIDX'd packs we use `packfile_store_get_packs()`,
> > which knows to not load any packs that are indexed by a MIDX. But as
> > explained in the preceding commit, we want to get rid of that function.
> >
> > We already handle packfiles that have an MIDX alright by the very nature
> 
> s/an/a/, s/alright//

Heh, I guess the first s/an/a/ depends on how you pronounce MIDX. I
typically say "em ei di ex", and in that case it's correct to say "an".
But I think I heard you pronounce it as a single word like "midex",
where it's indeed correct to say "a".

In any case, I don't care, let's just say "a midex".

Patrick
