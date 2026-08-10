Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98F03AB496
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 08:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786350953; cv=none; b=Ok7XYjtHpl01EjZC5wqXqFclK3/BeVQ/wVLCc7ozW/uzlZ32JBrwsb+IJPyZr+swmdzVahXLltDUvKAtGoJr4HFUKvNOJfnHlcBAxZJ4OgEDvtOZnQMX78QATfD2u0wB9L7t1hgtHu/Vp2qnas7tZSnVHP9xLApb2Z1NrpN5NpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786350953; c=relaxed/simple;
	bh=jEPUieVEMlI7yIYilNPC1H7G2fp0GnV5OU+bfJGZgcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8L7pLgy/nh70sDBCOyI9r/B2tWKnvL6lzf7kLbsmAV33f80GD/SVjX/dK3yLM2oftYIcRYCVu6frkQNqXtSwVym/0nDuOOTDIgeEOapjWl1y8D9wBfMjtB8HjLH0XuSbmV/GgeFzykcNULvAMrs1Y5FjdUCl2zcRJiiYsEdmAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kL5Q5uG6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VvAkxgn9; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kL5Q5uG6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VvAkxgn9"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BFDD17A015E;
	Mon, 10 Aug 2026 04:35:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 10 Aug 2026 04:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786350949; x=1786437349; bh=9oO1WHiJ1u
	2N4Biq6Lwv3dTye8vReuBM0/B1AI37L3w=; b=kL5Q5uG6VGXOBT9KMxyhGuwZIJ
	chfvaPRwomEjUtgNKlzmh/6H3ICQ2s1w3FyqmFWH+n4MBshcPE6QyZduu1U4ZQ/j
	O+OQB4TDqB25NjbhT7+chSMTeZtOLrskETggzUXkW3Cvg8lpWOm2ROgSDo7sZ3sr
	VRq2qEpc6MT1248y01HelbmejiI7gdma9ZE9z9bA7G0yE6CA+IeZHooFgkQ5Fc8P
	sK6sbUtdjkFmQ088evaKg8xlilGRMJfQN83NV1cf2atgtnlgbtmQufeKuM2aiaHx
	+gEHhkzUcmjMQgJCQ2orIJvNumgiAxU5CD5AZfdiz5FrjoBx8Y+kvMJ+niRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786350949; x=1786437349; bh=9oO1WHiJ1u2N4Biq6Lwv3dTye8vReuBM0/B
	1AI37L3w=; b=VvAkxgn94MeYUdGQ3FydO6RSs7t1GeuikY7bT9cvSLYcoqEBFgW
	GWcsh/RlDMRRtV1Fh4iDsII42Hl2O1hrSUyX2t78Fu+aNME/phorAm8d7Czb2sAi
	OC2HqtSSkcspsTrp5VhlFnfLcGaFba9lfY1m9OrfH6ttDscthenvEZu+jsLqWSmw
	o0bLLPuM2BeIr/EiBGdkwnJSpCTgkPDYG+/BHbuFUjau8y+vPH6AtExMkomstogy
	iOFhgBlGYYNVMRDg0MOwhhGTLuwkn5Al7/2hr40fNBrA83rkxOkEpRhI6SqNOFo0
	jwqqAF8Q0jydhXij5H7eNrAgTAD5z68q1Rg==
X-ME-Sender: <xms:ZY15aqpPRGwzUt87O0Ym7U9kKoj7wq2JAn2e4psM5IpzqyPBcJA3Mw>
    <xme:ZY15avpnj7hV7IwCf0hVJZxePjCGF9hhZh1EEsXt6wVnxIyTRW2X_AllkAnHUWhur
    lPiwtWO0kUo8bZ5X2zPrgDuO5_LvbLw2kaOfWkpqkOziiBq9V2q0A>
X-ME-Received: <xmr:ZY15akPv24DCjFcRGfgJ3utNGLqZIf7xzqCn7Ms-dKfDxp7LuXlPjHxGbgW2u5_nlX_fkPaEBSv6Z9ZjrZ3CNuTh_ySdSTwSw3wYomaFlQ>
X-ME-Proxy-Cause: dmFkZTFO62T8NgWnoICpGYyEXuqDvbMw/PmWPwRyUGp9juhcHAankGLoa7MtQANcW2aJ/J
    sQk09mIcc9MDpf4g6A2cTt3AjpZ917lCwwmVS0aA5PveaFI52zIg58hYiv6ycgXiE6/LYy
    OyZMixzsMLlTHeF6RKZ+elcwpa8J7mv/DXlnSki+tplVj6yxYqf7fK0JvtBILFWIo5NgXr
    Pcdp7Zlr8gQ5v7JGh4PHIEghi/UrSAG8PYeNzr4rJhrK1SvJc3xFD11ogCAcxXRUZRu0+Y
    wu3x8G9DN6mCyPkQLvemn/0rGEZ7cctDcR24Nd6vl8j0dlnEQB6DwbSx7epOyU9R9dSac7
    Rakx+ozuANZJnhg1sZdW3VR5QVCr5EtuaqMFKJ5RdgARINtqYEdbWCgzabfK3Yah0eq/2J
    fMz9GCZCflZdxI9oAZtyuTMmyEkPDv7WgFhn3efUpwkhlTB0bLRe7qtFKRlPZXKwRNu/sJ
    9AaCF1YC9p40+gm1/Ed83k1AEf8hJzWfA62QfDuYfMWaoo6excLA6DY3N/IvMf6fUNtbOh
    digS/ZVLwKbvTckJ/HAxqSt/gBcxdOqqWGkgMp+NhsQEexk4/hc2g4eZT04FCAg5Q92cUg
    Uq7b5v0DK7BHuW8WghTdmyUIh3jU0ajkuggwoCz/KB4fFA3tlgcl1CvKcoLg
X-ME-Proxy: <xmx:ZY15aowff_uipoKg4eUl8JW96oMSFnWWkRe7qNjsL54il8gjnYPXGw>
    <xmx:ZY15altsyXVRkxWzZcImEI259_fgxJdVsh1CpvI_YspSVIeoYQYTnQ>
    <xmx:ZY15ap4ylzqhASEbvU1wJdRvLVfyZvqrgTsektD3VHmaI0BZ5GbJZg>
    <xmx:ZY15asSUbf-6SxhiyfQoW_ppMhj5m8HDLxDqyqjxmGdNgn7SUPsS2g>
    <xmx:ZY15au3lkzImxPEwbM2xYu2kTj1yO3mLfjbDm2NjV4bdTseWeZj-7UP6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 04:35:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4009c026 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Aug 2026 08:35:46 +0000 (UTC)
Date: Mon, 10 Aug 2026 10:35:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Stefan Haller <lists@haller-berlin.de>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/8] t: fix races caused by background maintenance
Message-ID: <anmNX-WVohAyjEcc@pks.im>
References: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-0-faeb321ad13b@pks.im>
 <20260220-b4-pks-maintenance-default-geometric-strategy-v1-1-faeb321ad13b@pks.im>
 <17d460c0-564e-45fd-830e-548f60e01e01@haller-berlin.de>
 <anlfk0P7UillhlUd@pks.im>
 <801031d7-f219-4410-a863-7410cff7952f@haller-berlin.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <801031d7-f219-4410-a863-7410cff7952f@haller-berlin.de>

On Mon, Aug 10, 2026 at 09:37:01AM +0200, Stefan Haller wrote:
> On 10.08.26 07:20, Patrick Steinhardt wrote:
> 
> > Git commands should just work with concurrent maintenance, and if they
> > don't then it's worth to have a deeper look at why it doesn't.
> 
> That was my point; in lazygit's test suite I was getting errors when
> executing simple commands such as "create a bunch of files, git add,
> git commit". I had cases where the commit fails with
> 
>   error: invalid object 100644 50d5612... for 'file09.txt'
>   error: Error building trees

That's a bug then that we ought to fix. Do you maybe have a reproducer
for this?

Also, which version of Git are you testing this with? We recently had an
issue with multiple concurrent git-maintenance(1) processes running at
the same time, which is something that shouldn't ever happen. That was
fixed already, but IIRC Git 2.54 was still prone to this race.

Patrick
