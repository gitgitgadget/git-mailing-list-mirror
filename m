Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF451E517
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 08:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733387902; cv=none; b=eO4XZjD2lCtZuLnJ2eHfYTRk84hniVsPYyiMyh8uBvSDVcOGI8RAbistGa5jZeHoXo3W/6k9pB1ELUCJgN79ZZSVgv9c7K1zuo+JqZ6aIQPCBRZpoSibbD98gHur1WKvuyiy+xIh1krFZdic77RIQPj8Q97sUidgnXjS1SBFTf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733387902; c=relaxed/simple;
	bh=eQ3D/YGO7+VIJOnIU7pMTaDDxCd64PQf9ZO3s/SagEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QG/64I5wMxcdhTa+cMXnFNa5Qcek1UgGqGalvRURGGYkZ7V4Myz3kQG9fE28Sxby60pWsaCGIyiGPR7EWf0t/goyDI6dZjLBvpBb4Z6Pujly1PXqrqdy4m83QYtnbN9U5G59OIBpWRMH7MmM0nRyu12e9IaBa9aDHg6P8uSlujI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P9CNI2YX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e+4I/FY+; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P9CNI2YX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e+4I/FY+"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F1862114016F;
	Thu,  5 Dec 2024 03:38:19 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 05 Dec 2024 03:38:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1733387899; x=1733474299; bh=PM+rZ8liyd
	IqGx/tOxPB5+80wJydqPJgKQYuHNBaj2A=; b=P9CNI2YX5i+vS8jwxO8ypAf90F
	+j1oeK3ArUH3D9Bg6MWVI4C+Qyl9VBnHBUr5rrT9ixlRkUS12SW7Dm6u7A/vbqAb
	w6Yf9+Of+gLUodh2k+NkTfnrc2usePns65MKe7XBmoblFEm1z6fa/d9xyRGcpnvN
	GDrK54TJKMjzTt+bVk2Mb/3q+AvR8hB/iwWf3PeKbJ5WcIpzmcvJlu/BAZkAxJnn
	KuEfqbgcx7LcJvXkpEZr1uWn0SeTwIG4nsvjCRjP0g+MFZwziNLqggap+p5RyUbT
	7KpCyb3zDwKKezOdbgrhuol8YUXWrDN/scFE4t1pw6XLByUmVZmEolybcsvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733387899; x=1733474299; bh=PM+rZ8liydIqGx/tOxPB5+80wJydqPJgKQY
	uHNBaj2A=; b=e+4I/FY+oAxhEOo6ISXZZXHxAxjR/2gbHZw9crPY2fAFipc0zRl
	zG+pFchtTgpwtzHKyc9aPgA4XyMQT5IbFi7VFLO2Y47w3M46ff/7Xobctu/K+KUo
	ikR8PChsS3tPL0HpdQH6VFvHrdaRTeCRbyxsAiG7twEV/DiR4X3oMXNwedVDM7er
	S01ijH17Fa+pHCL+DSeNKZ0szxyERV4LNBFAk6/gyB+OfssvawgieoemtbtHdRDM
	G9MjIy3gHQbqrX3/2BxuFs8K00ZQVL05D2KQjfQmLmvuc3Jky6NpkYAYY2PfXRI8
	mL2YfdFTWeuo09wDoypgTPrD0z6pJS7m+0g==
X-ME-Sender: <xms:e2ZRZ__-UHR2zDqlRNLAnVPGZBt-5fXpRTnbkMzbQuBxnGt7fHQVYA>
    <xme:e2ZRZ7vIn8gDLvhTEgnJHk9jditRmdjz4ezliU89IP13_zGzy2PzZs4qwqXG3y8lu
    fMT-8QhvuH1zS08gg>
X-ME-Received: <xmr:e2ZRZ9DRJCgb0WtRg15RBP3DL9oWIId0iGsXWH2AjfeOfPSMCbkL12pxba9JYjt8uTcWVqUcn6T0J980FaFW1V-PjG2kMxVOoO6DKfjE7ODYIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieeigdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehsrghinhgrnhestggrlhgrmhhithihrdhinhgtpdhrtghpthhtohepjhhl
    thhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:e2ZRZ7eh0Txx2L6r2lF4SnAMgnJuGGFiVMCk2149HSceXS-v72eCCg>
    <xmx:e2ZRZ0MJhD_dvTjScw3eFDluB57xQnzuUS4IVc4SpIkRWmNxslIG0w>
    <xmx:e2ZRZ9m_NNBL6_gLDbyHllGEFejbprsBSPadmZg4MtFIVRiUudNnNQ>
    <xmx:e2ZRZ-s2fIfrh1pfPLXz4kTWcHumomgXKJ4PSaSEl5_1zYEgkKjBrA>
    <xmx:e2ZRZ5rn-QD8wWhARTfdlXsB0h85YfyuDGp5iw5jW-FBt6mZ3KTzcBiv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Dec 2024 03:38:18 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 52ad9f75 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Dec 2024 08:36:56 +0000 (UTC)
Date: Thu, 5 Dec 2024 09:38:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: Sainan <sainan@calamity.inc>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Some feedback on 'git clone create'
Message-ID: <Z1Fma7OLPOkxRncd@pks.im>
References: <AfLIcOv4X1AxLOaODNS89HA-bMeI7bj0xUGsLD-6xmVAS_a_2xOzy2uX-wXxpNA7kCpKYudELCEKv73roW_-HTd83Fcz3FZ_yJQOswQHW48=@calamity.inc>
 <pgz37cgfssouykfqxvmjt6pc2lycta6tmyjkovsceqwibww4fw@424usnt3dlh2>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pgz37cgfssouykfqxvmjt6pc2lycta6tmyjkovsceqwibww4fw@424usnt3dlh2>

On Wed, Dec 04, 2024 at 05:19:53PM -0600, Justin Tobler wrote:
> On 24/12/04 05:28AM, Sainan wrote:
> > Hi, I hope this email finds you well.
> > 
> > I think Git bundles/packfiles are an exceptional compression format, but I find there are some rough edges with the tool to create them:
> > 
> > 1. There is no way to specify that you want a shallow bundle, instead you are only able to a) pack the entire tree at a given head or b) pack new/updated objects in a specified range. Anecdotally, this could store data in ~67% of the size of an equivalent .zip file.
> 
> You can create an incremental bundle covering a specified range.
> Something like the following example might help you achieve what you are
> looking for:
> 
>   $ git bundle create inc.bundle main~10..main

Yup. The thing that might not be immediately obvious is that
git-bundle(1) accepts git-rev-list(1) arguments, so you can influence
what is and isn't included via that. You can for example even generate
partial bundles without blobs:

    $ git bundle create partial.bundle main~10..main \
        --filter=blob:none

What you can do with the resulting bundle might be a different story.

> > 2. It seems that when specifiying a commit hash, it raises an error:
> > $ git bundle create repo.bundle $(git rev-list HEAD | head -n 1)
> > > fatal: Refusing to create empty bundle.
> > This confuses me slightly because I thought a commit hash should also be a valid head _pointer_. 'git rev-list' also seems to agree with me on this.
> 
> A bundle is essentially a pack file with a header indicating the
> references contained within the bundle. If no reference is provided, the
> bundle is considered empty and git refuses to create it. I think this
> makes sense in the context of unbundling as you probably would not want
> to add new objects without updating references in the target repository.
> 
> From the git-bundle(1) docs for "create", the usage does say it accepts
> <git-rev-list-args> which may be a bit misleading because
> git-rev-list(1) does consider the commit hash as valid. Maybe that
> should be updated to indicate that proper references are expected.

That's somewhat weird indeed. I don't see a strong reason why the first
of the following commands works while the second one doesn't:

    $ git bundle create inc.bundle master~..master
    $ git bundle create inc.bundle $(git rev-parse master~)..$(git rev-parse master)

It's not like the bundle has "master" in its header in the first command
anyway, it only lists HEAD in there. So I'd claim that we could do the
same for the second command, as well.

Patrick
