Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AA823ABBE
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 07:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771311794; cv=none; b=lTkENqA1rWZP38SCAy61mDU6d3pvz+ejSOS240R+7qZdkdOyp780gjKe7BWBn493+xPAuEfw5S+F5nMuq9MT74BA9FTvNQTCLACWhMfoY86glPtXQslT9VYKFRWUrwDgIm/G8dW1W2U1Kvy4ZHvnr3QBtYd+SCFZPctqSf6RY1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771311794; c=relaxed/simple;
	bh=Ao0fEjDO0r5KdYNw6j8RhwurYtIaljA6WAbIWHekNlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C013QLam8BpC7cz/zZjgxg37PnhCLP2jOM7ATTz8PCHkafO6MFOwIhS1vmfrhsy4YDCpoy9tBFDmrxTOsZlX4u01/7Wx4SO7JFG4QqdPCNZ/DFmmtpt5ssqo4upPcYqfgD+kCw8vR83dKW1RmtAJ5uZrw3FPYmhKVEZF4FtPgU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fLhF44a+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NycY3+eN; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fLhF44a+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NycY3+eN"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5ADB57A02B3;
	Tue, 17 Feb 2026 02:03:12 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 17 Feb 2026 02:03:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771311792;
	 x=1771398192; bh=Ao0fEjDO0r5KdYNw6j8RhwurYtIaljA6WAbIWHekNlc=; b=
	fLhF44a+Ff1H2GhwB8+oWdiDqMlygxemzVmC++BLm694gHCdAaUjefAwEdp2RsUx
	OROekygTLu3S9uexGwXQvmRgMmhdpIljgmwF6e+hA/TO92bjtoL9kuVOlNf86G+C
	ryyEZxtTGg+jupNHDhYlQvNGmqThcrtBvxqgpE42HS2/fLRKRfadhbDL6soV3KEH
	N90iYTdxpWpwLjqauwtqTXjBMXhq6khza1fxPxjsGNIviDF75ZjKRtfAV9yfq0oe
	h4EFfhnn0v7c0WrEstf2VlfbdpNtEpr90cHP7WOcWxmCcRRnuyYbihWJUUfqbOZR
	R418O141bV9aDL48XzQHGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771311792; x=
	1771398192; bh=Ao0fEjDO0r5KdYNw6j8RhwurYtIaljA6WAbIWHekNlc=; b=N
	ycY3+eNF/Va+tfOV4UtpRNjT4FJR5RWSMU6S+Hx8IRH0uHLCk+kuqSk71AwjfHen
	OjPEJGqkjAA6KWKwgKvJ/WaQqsy/c9uIgZVfJY4ay01IU63929j9JmOPVfuS4KOD
	nFEi49wN8cVinXHXKFb4qviOfEory/KWaz2od4fJIMuWbbv2PAe4XR9LWVhpWmIO
	bDj6689FkBZSqTt8BfWufsHJSqG8IE5WbXcDrpn/lMyZNwZYBV7QJsOZbDpwzuvB
	Pb0HQqVsBJrhbvMtB2gv5eWufu857HV4chHdGRZ8FFiS77cM8LvWkUW/ADzCiCJL
	P5HwK/RnHiGPG74rmURMw==
X-ME-Sender: <xms:sBKUacDYqDacAEi-ZjHU8O5oGB6ptyLwbGXnOv7CCkmqzo7pysvK1g>
    <xme:sBKUaX05ji06jki98Rn-PuOgQem5gyOCOXzg_zW9jTvw_TPxduQ36DMURidnlooeQ
    90tRMdFdG1QZOJCAvzC8pC-IELLStfhQ7aA22IOycAzggkkat9Y4eo>
X-ME-Received: <xmr:sBKUaW2X5vif-eZ7hLxZ2d9csWCEwyYrOLo0LrPxGlm8jaMFSIUSSMBe6Zwvvs1UfaPvG5sIVhLuB3nt3yIUrDAJXlD1DR_RJfrdwJw0WA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudeludduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeegkedthfduteekudefuedtveetveelleefheduudffgfehgeehveffieefieehheen
    ucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvodhgih
    hthhhusgesghhmrghilhdrtghomhdprhgtphhtthhopegvvhgrnhdrmhgrrhhtihhnsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmh
    drohhrghdruhhkpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnh
    drkhhnohgslhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:sBKUaUCG5tM-goLeilRDya4pMWvGIVPqPtEsHyiAJHhFVI5oI6UFvw>
    <xmx:sBKUad4fzab18J6Bn1MjCjpVT1G-p3foRxm_x21n3HyhjtHEqN5PKQ>
    <xmx:sBKUadIJbjNCJsZQN8uK9_6iv4kZ8kMK4mawlUYVe_rd4uRrdYS9mQ>
    <xmx:sBKUaWu2iNcMsRQN-j2dAoq4T97x5GHfKARuL69N6HSnw97s1j98ow>
    <xmx:sBKUafL28mbPwT3PYCP6UGY0EXuvLf3_3-P5aFzfa756DiBFM_Urk-xX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 02:03:10 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8aab2b17 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Feb 2026 07:03:09 +0000 (UTC)
Date: Tue, 17 Feb 2026 08:03:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Evan Martin <evan.martin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] meson: regenerate config-list.h when Documentation
 changes
Message-ID: <aZQSqtxf_alZnYXD@pks.im>
References: <9cdcc9de04f0f8fff657f0474b31c063466ed808.1771280837.git.ben.knoble+github@gmail.com>
 <286624E8-94CD-4C65-BB91-BF8338B8A79A@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <286624E8-94CD-4C65-BB91-BF8338B8A79A@gmail.com>

On Mon, Feb 16, 2026 at 07:33:19PM -0500, Ben Knoble wrote:
> Hmm. I’m pretty sure this worked locally but I’m seeing some CI
> failures on GitHub. Will investigate.

Where did you see the failures? The changes look good to me, and things
work as expected on my machine, so I'm wondering what the root cause is.
A test run at [1] in GitLab's CI is also successful (ignore the
MSVC+Meson failures, a fix for these is being reviewed on the mailing
list already).

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/merge_requests/505
