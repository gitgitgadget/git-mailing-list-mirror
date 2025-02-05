Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFDA229B12
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 08:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738742616; cv=none; b=MC+X/5f3HMAn9QwDBT16kiO6N43q4sQNGWM3hr1KqG52F/KZoAOmiYzK6LxJKj7C2hIwLaoi0LWIkacFQVVGNb62z/Ntrx7WWj7fjqFjW90UML5LmQoUHttVEo2pEEya3UkjJxH1VinfNnts4F7ZrCO0BR+lhMxhEp/ln+DoCZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738742616; c=relaxed/simple;
	bh=ic9rhE1qZXYHtZp32sPhSWL/xDgq3MD52ZuRm+lL2gU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLgj9CuWkKAkyvIkJODR+TYJ5LUJiqHWBzW/MEIIpWqreA6kbh0V2JTTJNI2mJjKVmnnhNnAhjclie/HUKK+klDVVQeCJaBzNqaM0qkN34MpDVNyMnPWZUywKzxE8mf9jdbgHAHLk8xiKdyDILjtTKndBajP7qkchXeMQ8DjmkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cTDyu/FC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YtfSBFob; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cTDyu/FC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YtfSBFob"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 51B9B114013D;
	Wed,  5 Feb 2025 03:03:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 05 Feb 2025 03:03:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738742613; x=1738829013; bh=/li3NTPmvQ
	5ydZMAYMmWuWpAzF/dkIbQi2+80df7vu0=; b=cTDyu/FCkwqcMYEUN6QbK5XoHx
	tJWingNoRVRgTRyse9qKgsi8bJ70QYhng/0hIIL9jJoBS+l7iuFPNIjBKRFPznHU
	Ha1XYjG4BwB218Sm2XOTj8Q8HkAP2NMro/UpK+O6681UdbNskvX7gAZY7s4W51th
	kWgRTrk/LIZQFsFvZyFMaoaYzhqtClvaGl3Pf6VkYIQPpYeI+5SsN67dnTaGHY6j
	D1S/S5w4tkPgIkHENnTKknAdbq9XdmpxokErs/QpF2RhZjvWnzj3hVCvoLjQUcaZ
	/ahkH7JP+rH6ql0CExIbeGi7jzxmNzkMp7F09heoUSpvC60W49DNlUlVDdVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738742613; x=1738829013; bh=/li3NTPmvQ5ydZMAYMmWuWpAzF/dkIbQi2+
	80df7vu0=; b=YtfSBFobOBeXdtXKh/FrxtuBtSYsStx4v0+YEFJNS5eUDLkV8li
	OiJ0pNQ58MfQq1fu4cYxwy+IdcpTr/gGKlEh6zaSn4aGAPx6vCf8wStGrKbrLdex
	HChqaEydez0S1wzd45SHFJPrqbgyS/UhRm+j1ov0250HeEuOrmFLxah4aKIto0/Q
	qytthtI0YcpaPWm3kFlrp9FJtirsfHLRW2etVVgQPsLn69gpHAwMuUyF+h8XFwjR
	tBMjS1xtbksVNEiEjITjp4u10Sl3qxVB5twqUaYVqXzMRGH7CjIqaG0aiUSH6PCW
	IGqmEdd54sTRgjF+NLt+H60oCYxG+EE55uA==
X-ME-Sender: <xms:VBujZ-93ZRpxNYej5r3ygbLoSSQd4Rl_jCISA8gmExQnHUVxGoXLAw>
    <xme:VBujZ-vmPoFLXJ-1wbW_m9UrPEyhAnttCxFpDK7zulPhxoassw_GrV7S2rhUX8ELC
    fHhMZ23sSkEduDj4Q>
X-ME-Received: <xmr:VBujZ0DMQy12ZCnu73yIXtlGmSvnftMWYqG577J7fdQF9RXKX9eSPDK4zPLHNsAczi2_CfRXUyWE9-em8NR5ZVkDJIrIx6dXJPN2Mt56Bf_eCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghf
    fhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhhsuhgthhgrnhgvkhesshhushgvrdguvg
    dprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehkrhhishht
    ohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:VBujZ2fjQj9B11Rz0NXTgzs24kLJ8nBEGED8VWNzi0kfmasx1puKQA>
    <xmx:VBujZzMhATkTAlDdEuMHcTwSskYvGxmjVn-sCqjnZp1aqTa8LHBCTw>
    <xmx:VBujZwmROZ-ZcVn66AKWSuKyBzswbZfthWACcxWisnv5b0miRQ_nVg>
    <xmx:VBujZ1tounh3xvtWyIiJj4GF72GkXkgdMC4bx6a8uBiACcLf35zxTg>
    <xmx:VRujZ_C2bCLKsPZLFvBhlYVblTgM066V3VmLVuKhF7f4eSF2cAekx8nP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 03:03:31 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7746bf92 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Feb 2025 08:03:30 +0000 (UTC)
Date: Wed, 5 Feb 2025 09:03:29 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 7/7] builtin/clone: teach git-clone(1) the --revision=
 option
Message-ID: <Z6MbUbi1A6pTmRdx@pks.im>
References: <20250204-toon-clone-refs-v5-0-37e34af283c8@iotcl.com>
 <20250204-toon-clone-refs-v5-7-37e34af283c8@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204-toon-clone-refs-v5-7-37e34af283c8@iotcl.com>

On Tue, Feb 04, 2025 at 10:34:06PM +0100, Toon Claes wrote:
> @@ -580,8 +581,9 @@ static void update_head(const struct ref *our, const struct ref *remote,
>  			install_branch_config(0, head, remote_name, our->name);
>  		}
>  	} else if (our) {
> -		struct commit *c = lookup_commit_reference(the_repository,
> -							   &our->old_oid);
> +		struct commit *c = lookup_commit_or_die(&our->old_oid,
> +						        our->name);
> +
>  		/* --branch specifies a non-branch (i.e. tags), detach HEAD */
>  		refs_update_ref(get_main_ref_store(the_repository), msg,
>  				"HEAD", &c->object.oid, NULL, REF_NO_DEREF,

I wonder: is this fixing a potential segfault? If so, it might make
sense to split this out into a separate commit and provide a test that
demonstrates the issue. If it doesn't, then the change shouldn't be
necessary, unless I misunderstand.

Patrick
