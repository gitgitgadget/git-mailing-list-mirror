Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E125D35897
	for <git@vger.kernel.org>; Mon, 19 May 2025 05:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747633140; cv=none; b=tWFfRRoU3sqDJhChkGsVDmIFXSxItcb/R6a4LDSLEN4xFQBqf3UKfwxSPghTtnbda0uiwwR0lHxpAb4ssn09pLyMw66Oy1uvoObjLNXeLnrRlZlaUD83mMijH2cCQAG4Dl64Pz1fNAUqQPnjrI8oyvnykfT1lsPCuguFHmPkI8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747633140; c=relaxed/simple;
	bh=B/Nc7j42qeD1rygR2+XZ1g09M6JOFy3+dZC2QArg9nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdpcuoCQ7auySdP6VhUDijdtKMl4OM16zx0G3oGqbxHyoB6eUchUlb9Kjn5tqyL9v8wcGGbODiNe/3q+Q0oReTHwhNwCva1iHfTqru9WYyfy83v5pyxcQxdYoJmHPUs+b/ZJycEAxlMD6tyFtYq1KaFKCPuX/Uv7LxGSWwesTFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ScQuxlgn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Aos4Vmj1; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ScQuxlgn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Aos4Vmj1"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 719161380158;
	Mon, 19 May 2025 01:38:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 19 May 2025 01:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747633134; x=1747719534; bh=ordYHzOEv+
	gLYFP5f1Ulid6y90khmL+Q5VU+Uw6a/vI=; b=ScQuxlgna72cYNSposn1Igsl1S
	NWrykV++Df9H7fcgp3iwAx/XVngPPQ/d94fpfWP14IEG9qQ19gBl8vpx8D4VwaYV
	O+AVkEHbbJjZ5jLhSo7xO/hY7z81Up9dyKWOrSKd9wAjoKQV/SAtqgTKw6TnBDvK
	iYJxaTQtTVX1Esc3lKaSaBlYXN0XBhmOYQeK2z0WGBKVQPKNrsmY1hb/PkrGO7sT
	gjAIx9eSwiSUTMqJVpZ0jJzkMhAVev11c51Y/ymz7+6RRabAOFZGwfQMtpuK5+BI
	PjzbFcD2tTHpargVJ8lCjTEb2VKOygxwmeqPwfX3UJax0CbXOvZgHibMi3mA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747633134; x=1747719534; bh=ordYHzOEv+gLYFP5f1Ulid6y90khmL+Q5VU
	+Uw6a/vI=; b=Aos4Vmj1OCHLY25qxEgFnAhEqhKYgzhp1mHEfbChWDuOgVxnuXc
	zNr6pT1CwDAF6P2k2yjPnCuzAX43jZ4x1LKBGzMkkSCYP+qO2GT46ej9bN47cGkg
	mKRmQCqDItu6Y9/bfmJbcMx8fVuV3Q1ezdb21J4H5hilwLHlq9c9EnxIRzHuT8IF
	gxYVexmp02k1F351C6YwDpJJBYVS6p6ZogKhP16Pt6juqOLY7pbEKEnw+XOYx4SO
	QDPR+Qm3RzPwYOKMk2DQGReU1Ad5e0FZcGbNZ+1dfBs7MNuoAr7MfLq7R6Z+ByTp
	7IB50uPZaVmhAO2jSsLCKPZ2HbdA2Ux0LTQ==
X-ME-Sender: <xms:7cMqaCtD8NhEHdMd9ejVKQg4V3fvmjin0erotW_47oA1vLD4iwy2cQ>
    <xme:7cMqaHdXP7go46e3PRqIXcfK_p2z5eC7sxJu-IfGx52vIw5p9WMymvVIyMy-4YyG-
    zzJCO52mGe3hhxXBw>
X-ME-Received: <xmr:7cMqaNx_oSa3sKfCmALniaxE1b3PzmlbT4YgXXlWuaTNJOESUNFai8hYfHYVUm53fVpbI_JSspawCtYGMTTa5kn7-hAFDxyFLdA50w206URN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddtheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhephfeigfdvffdvtdeuhfelgfelhefgfeevueetffdu
    gfehtefgveelhfeuueevuedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    gtohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgtphhtthhopehtmhiisehp
    ohgsohigrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmh
    drohhrghdruhhkpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdr
    tghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsth
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepghhithesmhgrthhthhhivghuqdhmohihrdhfrhdprhgtphhtthhope
    hphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:7cMqaNOEVne-OwSouSTp_7xflDC7TagPRIJWSwe_N0nZoiu6xe4LGg>
    <xmx:7cMqaC_k8zNbb1Uuw3HzV9HIY4TCgbJFrogi6Z2iQcOho1XQZg7yZw>
    <xmx:7cMqaFX-FNwMX7DkmpNQYK_2cO1liuitaHH91mrFeOnXTxqc_fY1eA>
    <xmx:7cMqaLc5ajDapuACK6F8EvJJ7QGvBtDAI0zhPAcZjWToD-UwyPwPew>
    <xmx:7sMqaMhe8Q7UFHMqguO7o7TLKKbG-UIIMB9rinOGklZ4avfMlH_61fLt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 May 2025 01:38:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9546f875 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 19 May 2025 05:38:50 +0000 (UTC)
Date: Mon, 19 May 2025 07:38:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: collin.funk1@gmail.com, git@matthieu-moy.fr, git@vger.kernel.org,
	kristofferhaugsbakk@fastmail.com, phillip.wood@dunelm.org.uk,
	sunshine@sunshineco.com, tmz@pobox.com
Subject: Re: [PATCH v2] contrib: update thunderbird-patch-inline
Message-ID: <aCrD6RlO0xUmXr6i@pks.im>
References: <a3aaa11a-a842-4c10-8189-07b681663573@gmail.com>
 <20250516135540.218937-1-phillip.wood123@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516135540.218937-1-phillip.wood123@gmail.com>

On Fri, May 16, 2025 at 02:53:55PM +0100, Phillip Wood wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> This script uses an extension to run an external editor from
> thunderbird that is no-longer maintained. Replace it with a different
> extension that is maintained[1]. The new extension uses a different
> separator between the mail headers and message body so update the
> script to accommodate that.
> 
> Signed-Off-By: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> [1] https://github.com/Frederick888/external-editor-revived
> ---
> Changes since V1:
> 
>   - removed the original definition of SEP (thanks to Junio for
>     pointing that out)

What I still don't quite understand: who is this update for? The
existing script is broken for years and nobody showed interest so far to
fix it. So I don't think it makes sense to fix the script just to keep
on dragging it with us.

If the answer is "you" then I'd be fine with it. But if the answer is
a hypothetical "someone" then I'd honestly prefer to just remove dead
weight and not bother with this update.

Patrick
