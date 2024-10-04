Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5967E179BB
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 10:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728038962; cv=none; b=dfYChlcsSF84xFK5iL19ISF0X3rURopPpnvoUXeo5wzDFp+6V0R7SEkFBhHB7IP0l14SLsj8oLV4t3WOO7crYldENXXlQGjAgegokoZwwPbTyzFKhF4DYD/JbxTYLVjFKUMp27KDjIFkVuPrBMLpx4Nf1pDxcjHZESIZB7WJG+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728038962; c=relaxed/simple;
	bh=+IKx1ytvA1lfXCx0DB+FrdPUE4v6g7hP1Ps+MiaA67o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHDFJXQPGOyPi/xEP2ogX1zyyJ1UTxj095X/42IhGvY3e0XRyxuaqczDllPQa8148anCKGzHhm2w4mflr2u5BzinAYOgXPJEj365Fe8d5Pn2ZqzX1rkOqm6SRU9ar8yMPyue+zlDTkfSpkUx/HhZIaK92UH1Y6wb9RwiFomr1b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EpLaoVD7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cipMZIsd; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EpLaoVD7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cipMZIsd"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6E15511402EF;
	Fri,  4 Oct 2024 06:49:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 04 Oct 2024 06:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728038958; x=1728125358; bh=+IKx1ytvA1
	lfXCx0DB+FrdPUE4v6g7hP1Ps+MiaA67o=; b=EpLaoVD7/swt4KEzbt29FODppB
	Ka76tvIleZf/RxYmKl5ZABDDs+t+gcr9BNT0p8LXY6Pkb7FNRm5Gai3pLk/LAfvS
	25EOAwJGUrUiL0sBhMqo2agj7FRzeWBI4h8otfhkMcbe+6O3SJ7pEC8m9oDGQXDJ
	IpyNrH0hsUccPa8KpiBmTlkKM/4s23D2S9g01NzUJtSwndnXvRA6ehT1t0VVbv7N
	nG950qufG9WsLoODNS7xGOsLPo3z3ECASVAg4ar1MHM72sSsHhD7wdLIIksp5cnH
	ZJScuFfPkNNfuAvqJs+vme9ixzUkYKU1c91P5K4Jn1s0uhcsneJO752kSqcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728038958; x=1728125358; bh=+IKx1ytvA1lfXCx0DB+FrdPUE4v6
	g7hP1Ps+MiaA67o=; b=cipMZIsde2AAg42yjDGO1+oMFHXp8X4KwxftXuIcIGOd
	HE8zt/q55Fxg6HTMBIWNyD+2WfQaF65/5Hot1lY1n517qoelbcBmwLgn5qQZI9m1
	GYUFtNHv4EW4P3ZPJ7VyvjkFz7+52UxZw6Hbc6TK+o4bEEDXBRo6sn0gO88cf7PL
	YXdV05IsXY9h7Jo23NtF+KkzZTF6/O/amTsYQlopeMhemfuXL+9aoDI/9bnvxenL
	s0VHoEqaWAR4EBnHJVIhtEOB857pi2w3+uvNL6H1jov2ydu2Sj4uSu2A412P4INM
	8Nk45cXy9fzd3dH+Z3VlJqLqQVJvpMLUMOoQNZOliA==
X-ME-Sender: <xms:Lsj_ZoSK_AC2ZYIxPSFHWNydFD-t7LVc20v2XnPXxwcO6G4G4H9SzA>
    <xme:Lsj_Zlyun8HwMPsZIxSmC1nLGTL7ZaSKcLwrnPOy8l4g0sWjbxq_auz-UGGFsETct
    gMroTdxlwt5EUxGoQ>
X-ME-Received: <xmr:Lsj_Zl091GOb42A4fAyJi1_7Ytt5-nH-SO0RcO-s21IRZ4k8wO6czozpm4B2ZYa8LafHy2HcPlRsvjgxclewXWNgeOCLjRABIYmFLhFOzXH2Exvn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvfedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegvkhhikhgv
    rhgvrggsrghsihhmrggthhhinhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Lsj_ZsAaH62UFxq_2g5bNmYfPZiLkfyLJ8fl_VAU4nilQgWR1C9CRA>
    <xmx:Lsj_Zhioig3EWAXzhMT1iKZc93PGWm7XAk0zEzXGsfUCUU7-p97eLw>
    <xmx:Lsj_Zoq-FZ40uCB3pAUdvzVikpzZaWvPBQtZNj8x7XSvawIKO3VU7Q>
    <xmx:Lsj_ZkiuR56oUbdenSXcilB3P1nzpUhGTpC6Xf2co0WGB_OvDXca1A>
    <xmx:Lsj_Zkugic0bXAhJKOjCeQhlmnFI5b8akKZ4dj__zWnGpJrrIrb9DKzZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Oct 2024 06:49:17 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dbf88e9c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Oct 2024 10:48:23 +0000 (UTC)
Date: Fri, 4 Oct 2024 12:49:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ekikereabasi Nkereuwem <ekikereabasimachine@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [Outreachy] Intern applicant
Message-ID: <Zv_IJCNyD0NeeibN@pks.im>
References: <CAK83d8r6OTX8ThZV=7wmdB1LXKTMoUx8LPin+kKAbhzH560pZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK83d8r6OTX8ThZV=7wmdB1LXKTMoUx8LPin+kKAbhzH560pZg@mail.gmail.com>

On Wed, Oct 02, 2024 at 04:18:18PM +0100, Ekikereabasi Nkereuwem wrote:
> git subscribe

Hi,

in case you haven't figured this out yet: you have to send the mail to
subscribe to git+subscribe@vger.kernel.org, not to the Git mailing list
directly :)

Thanks!

Patrick
