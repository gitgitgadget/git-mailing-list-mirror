Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4960B1D8DFB
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 20:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757536891; cv=none; b=WKWEBz70ch4wKF+D3cG5B/5kqJlOCVBd9zvl0w16+paqZb0ofccwYjM1/XkdNLXQ/rGymzeOXvYZ4zskkBp7FhTJkorl/vB/3YxwMODm38nXBlSe45PK/gVfv54yipUU5AEi1JPcEHnQG+uaJFFIH2ezu+tmpT4380h0jaQ1KZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757536891; c=relaxed/simple;
	bh=GXns/oXOVIDjSLJwIZr+y57wxPvR+fMOBYv/HD8GVng=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QbdoDKKcnm2T7Nst9InzLD44MGFeQloSg2dd/7coQWt1eNZ8zUzETd3qryrGjsgxs2YkF0Lpn+HYUYlE06h5N172H/8sPzy6C8cIxDAyNMJWZVjXbAp+V2N/+EzfYVp7z7A29AsgQdIXdrSE20MnsTMToiYHxXxui5zRPKWCd7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qKBSRds6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LNn5h3yL; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qKBSRds6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LNn5h3yL"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 598A4EC02B2;
	Wed, 10 Sep 2025 16:41:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 10 Sep 2025 16:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757536888; x=1757623288; bh=wZgvEDameJ
	3z4ZXwzNRe/gZZL/YPvVn2bQb3MYrpnE8=; b=qKBSRds6UHU8xS/e8NXl5MKqhW
	mC9ohYWf4nVEM0tIQBpuGq2aZWb5hRQK6N2LyuzhgeLHh0vBhCljhbw3wKtXtoa/
	WYHcT1nEu0C/C95B5MyepdX6HJ0U2BDeym6rg9EXhSX36HdpQt541mWHRTmwXTg/
	UL8rtcC2mwEUjA2zlczo0JGf0140C9Rm56Ja8/4e9gScjSCazhzaYPtL8QqBrjlX
	Y4pvrGcJdJS6EnRVQif//TcrOql0XNhxz0t/SAZXOHd10DbhDqP3ppAoMfzJXVIK
	G50qr2OqEuEM0WbFdt81PXSNRQwxM7G1SstneR4igx4jhNLo6f5Wyp4dboQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757536888; x=1757623288; bh=wZgvEDameJ3z4ZXwzNRe/gZZL/YPvVn2bQb
	3MYrpnE8=; b=LNn5h3yLNI4KAAwFNXZut9Ct8Ee7sVQ8OB65hO+IU/TQ0rNd4NC
	mgzhVjEVbwYS7sRBXdENEQk5lELsJnlylAc7QDLsdiYF7TclMkyWxLV2t8Kd6UHt
	XkGuJKQqHZgTfJdOqv2P7U1Ol+bNNtYdlF+ncVpe/FDMrnmjT3zeZV3OzjrbExiP
	9Q/xS8wM6iMBt8FrfFAA2AphM6yaR8cpPZuD0LaYCQi9RpfaC0hSa4K632d5fL30
	IMpZb5Th1QJ8lbTp6aS2Vs56sw+mm64JeWHVo05mjl1+HtqUwxveV+CImP+FhQgl
	mKKNmpvdPQhC61SrqRgEKHCqWl3qCbx4Oog==
X-ME-Sender: <xms:eOLBaPZf55fzijdFDL7OSn2q3-k_SY0knYQPPw2f4XHhv1rLM04Xfw>
    <xme:eOLBaG06RqGCRUG12mxTJawDrmTXCexig17b4Uw3fDislpfeEtDncuJMJvh-cbMTd
    WAKkKuzFWtRpb_QFw>
X-ME-Received: <xmr:eOLBaCY-zglL-XwtflIhdG-YzIVW9_psHxKlJLSceqeuCBXNsqNlZG9r7CMQjUvveQiktJunhVSm5DhmG-u7wPEK9Yn7kb7aRtpawy0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtth
    hopehhuhgrnhhgshgvnhefieehsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:eOLBaGJpJB6BNLCGcelcmtaehpiOntd-JSUMhcIYEqk8-ytCtlkyLQ>
    <xmx:eOLBaJEJtz0MEbvi8TKhtqe3MCJqiq8XlweMveNsl1pbw053bzPuxA>
    <xmx:eOLBaFvPO1d-Cxq-cj8-fOHafHex2BUPG5zHeavuwz4Q7ZkoqJruSA>
    <xmx:eOLBaAsQdfEAza64ldrkVZ-RoMdCFbEtXOKD0CyiVRPUBHpOdC8zOQ>
    <xmx:eOLBaG4L3pgcN4uZjvOGmcLLiqQw21vYSnxRq6FOfKvcrBoORE0X_AXg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 16:41:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Wing Huang <huangsen365@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 0/4] breaking changes: switch default initial branch
 name to "main"
In-Reply-To: <cover.1757518141.git.phillip.wood@dunelm.org.uk> (Phillip Wood's
	message of "Wed, 10 Sep 2025 16:28:59 +0100")
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
	<cover.1757518141.git.phillip.wood@dunelm.org.uk>
Date: Wed, 10 Sep 2025 13:41:26 -0700
Message-ID: <xmqq4itarqfd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Changes since V2:
> Patch 1: reworded documentation
> Patch 3: fixed typo in commit message
> Patch 4: added helper function to initialise repository

Everything I saw in the patch looked good.

> I'm still on the fence about the suggestion to add some advice on how
> to rename the branch after it is created in order to help users who
> are following tutorials using "master" rather than "main". One the
> one hand I can see that would be helpful, on the other it is pretty
> annoying to everyone else.

Hmph.  I do not see why we want to be quiet and do not want to give
"Now we created 'main', which may not match an existing tutorial you
are trying to follow.  Here is a way to use a different name to let
you continue with the tutorial." after annoying everybody with
"Sorry but we created 'master', which may not match your taste.
Here is how you arrange it to be different" for more than a few
releases already.

IOW, I do not see annoyance is a valid argument against or for a
corresponding message to help the users across behaviour change
boundary.

> If it turns out that we want to add it we can always do so at a
> later date.

Thanks.  Let's do that too.
