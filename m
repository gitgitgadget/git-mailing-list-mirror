Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B5F38B
	for <git@vger.kernel.org>; Fri, 30 May 2025 08:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748592062; cv=none; b=Plw+10pQ5IE9gtJELLJ8ygS3SIVX0C/NPY+8tpY7n/3O74heKn3rEWWTXNP1vcDMobCnnpacfF9rYx+a1FH8sjCdsB+Zr89BE/5tO6XFowpX7ZFREHZ0/53/yeqysSe3f9CaTv3AOErTyqYj4dXozTF2kyQKIYUrQO0QrUCE1D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748592062; c=relaxed/simple;
	bh=lWpRJed+rV+ot5RVODVYTBSXzaKbxckp4H25mw2UOR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIskJ/Brcupz+fuLaox15a8kWEbHLGSv+JNPO2c9w5jcglTf6t9TmFw2rsV1+gXEXQEcgmdFukmdi7KKAcKzc1Qa7Y+F5G+enMpUxUtaV1YPREyC0/CNoQHaFs+SGSbXTHXdOywMygOCvTH6bv4PiUWsZ0IcgZDxOaPehMSiFsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qmxjPYRP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bcdOdP1t; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qmxjPYRP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bcdOdP1t"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 54AA81380365;
	Fri, 30 May 2025 04:00:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 30 May 2025 04:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748592059; x=1748678459; bh=4mx/sLA7tM
	Kbofhqiby+i1L9JJtE4Ua9eIzp6weEDDw=; b=qmxjPYRPQQk+L4xNP6rfDJcyPI
	YjZ0RsUkg7+3zKone/oKtva+juYQPilnoUlO1hm0qdjha+AO1854/w/uFWANYQMh
	3gDUOlTMbBskTe9MtoA6y9nwOAHOk51eV4MskzEW1xgFsyGT0N6qJMdIViOozOuF
	JW3J5kEGqbM4uq+IIq/7CMU6sPVhpgd3HESuGD2OfSkMP9Y8czNTpg8qli+ojaG6
	PV+d0jyvlBhmPBhE2zOUjWfBvtncuSYmxd79BnnMijrumMg6IYuCY2NRJ81anopG
	cEmQeYlLeSC3BkgWMevnG7DSOm3zUNJK8I8kZDyntm+ZogMIiOreYvP2G6nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748592059; x=1748678459; bh=4mx/sLA7tMKbofhqiby+i1L9JJtE4Ua9eIz
	p6weEDDw=; b=bcdOdP1tegIo66BKhqAEV9lj5noTX0vHEGKYF1SBHohh+rba3lA
	XOscTUoFB2WYjTd1yIgN5nbBJkbR7ejkL6misAChz2Q+7cFjuLGQ1MHX0vBvHZGm
	7xrM2ihe+rFqm2Kwes7GAu7oeHZYvJY6iXbtA29Yv1HbEazGYnVgHK0WKzU6QUGE
	ooLVYhFm6l4D1tC3ITDRAJYEYfAIpxc2t+tdhY//m6lkDGGks6dAM04VJMIQ8Mhw
	oxgxVFEiUlnL7dEQ7ZSaSw9nTaUM4/iOAiA5mXg8X4YpD76T3dZ2Ywe5UpcbRZo8
	qCywXl9a6fNwRwClGlD2diZSWmexe/CS/qg==
X-ME-Sender: <xms:u2U5aI0wiA0YGzS3z5l03aQy4Bbb2AXa_R4L6SaniOey5PvYngBZ1Q>
    <xme:u2U5aDF2jW6bLCq7KoOEV-h8DT_yp5SrUxLwMEOoydd0u-MNE5gsR92AVJeAnnN7M
    oaLY6EoVLgXdMkVmw>
X-ME-Received: <xmr:u2U5aA6x95S4VpW9vnMxb9Fur4ju-zBQLiZKSxsNzbM9cPjwGrgKthEII8og8UugFkaY93NRRoB5RRspagh8bdFDGJ70Yd8V4dj6jSX1FA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvkeegkeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrh
    guthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtledu
    iefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgt
    phhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhho
    sehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:u2U5aB1jVJjkTjPJvtRhnU94J5b3q_2Gxxm-6e3YvvzR4FHCdX-tMg>
    <xmx:u2U5aLEF-m1f7L8rOjk_SZDj41hlVO8z0rgDTn9yNtY5tgNihYoK9w>
    <xmx:u2U5aK8OpLIUs84Mf5SlqEXbel4h-EFbrWc80NUWC_aZ62wakBN1ig>
    <xmx:u2U5aAkM_TJkPqavhzHv8I-hP9gJQ_5b_xaU-pVsWlq-j1Tfh8N-Qg>
    <xmx:u2U5aCiHxQD6dyc28tHvL8NInSHURxW2eTboh7i_f3wh1HiUZxJSLwDD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 04:00:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 62b2a1db (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 30 May 2025 08:00:57 +0000 (UTC)
Date: Fri, 30 May 2025 10:00:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH 2/2] MyFirstContribution: add walken.c to meson.build
Message-ID: <aDlltNOH5pWBbwTQ@pks.im>
References: <20250529192036.75408-1-lucasseikioshiro@gmail.com>
 <20250529192036.75408-3-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529192036.75408-3-lucasseikioshiro@gmail.com>

On Thu, May 29, 2025 at 04:20:36PM -0300, Lucas Seiki Oshiro wrote:
> diff --git a/Documentation/MyFirstObjectWalk.adoc b/Documentation/MyFirstObjectWalk.adoc
> index 29d26abb47..3b66e48dd9 100644
> --- a/Documentation/MyFirstObjectWalk.adoc
> +++ b/Documentation/MyFirstObjectWalk.adoc
> @@ -96,12 +96,19 @@ maintaining alphabetical ordering:
>  { "walken", cmd_walken, RUN_SETUP },
>  ----
>  
> -Add it to the `Makefile` near the line for `builtin/worktree.o`:
> +Add an entry for the new command in the file of our two build systems (Make
> +and Meson) before the entry for `worktree`:
>  
> +- In the `Makefile`:
>  ----
>  BUILTIN_OBJS += builtin/walken.o
>  ----
>  
> +- In the `meson.build` file:
> +----
> +  'builtin/walken.c',
> +----

It's a bit hard for the reader to know _where_ to add this. How about we
say this instead:

    ----
    builtin_sources = [
      ...
     'builtin/walken.c',
      ...
    ]
    ----

That should make it was easier to figure out.

Patrick
