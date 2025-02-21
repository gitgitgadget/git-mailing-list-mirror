Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D121FBC8C
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 08:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740126848; cv=none; b=pArfJwE0I4yTOWZt3XoAGXTQYm5vjxBgFH5dxFaxKKPsHRL3VMqhs9LzCHffbeYz2AHK8Kui+lB88MZXuvbmzAQcg4LjUIQh4RIMI3usApgMlmuPgZQPLwBXi/ge2XMyqdqEq1g7eM/f/dXvrcJFBKkcGZbvNc63l6djeWg/yeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740126848; c=relaxed/simple;
	bh=zB75GjiN4zok3q0NB6UYogyvkanw9p7CiKPu5BzKWH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfVv8vl37K9/k8+5w4pw6yH1YP1hTjeBiw19ShvPvPN4VDIIr3vi6ayk/tr+K3p4uYZeT/cmbgOw6Uks8JDkvwWTkCe5D1uXbn06Qz180KepEsKOmrSwebwAu8mLynxO3dZVVkdFpmhd0gCXjCheXrWxj1sWredgkSc/s+QU6IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=om4PVtsc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zkG0JR5a; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="om4PVtsc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zkG0JR5a"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 484AE114010F;
	Fri, 21 Feb 2025 03:34:05 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 21 Feb 2025 03:34:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740126845; x=1740213245; bh=IiNzEebkxY
	wYjocCI9GXXOzEH+riW/sPdh3Z5a+JUog=; b=om4PVtscl7naVcsklKhPW4avE2
	t3C3JrVqOEZj+PvqLuO7iLRePTwA38lFkkmvrRDFhVVn37mkoEvnfFhEbr7R3J6P
	Omlte1X1+l8wOsUt8eCDbTuU4/BRXloqwYAESP0GV1+69NekcGvYUdQfNxdlv2Ty
	F/02dsn8qEyCKf2YOTIV+sxqtIENiUPuRc/OcA/HL66MgupGW1h/qp2x0TDeBBdI
	Nn4uXYu97v5fBHIoQD4o0wBZdgzcIVdh166lNlTpBKZQleRHAWhEUmuBLlUbOBwv
	oz2w33BT+cFkGlgdrqKOiWeEiZbqYUZ84K57GwH0ipK6Bk5j481hYkcn9Fdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740126845; x=1740213245; bh=IiNzEebkxYwYjocCI9GXXOzEH+riW/sPdh3
	Z5a+JUog=; b=zkG0JR5a1AWNeqAM53pk8zRnmGh20d+KX8H+9rjT6UOxnqs5Frx
	FytUfEUeID4q5JjbWVc505u4K7yB1wykllZmZSXiDk5FNDtNlFvGNE02DZBlenrT
	cv+ijODKRT/4J64CK7JiM1EecA3pxXuykR7qHth5yPN0xAyrVLfTrKw68P5TAjkh
	S9/xh55SdVgbGtvlBE+8Dwy3/z1qpFPJ26PHgmlpjCViRL8ftKG2WPMAQtxXYE2+
	llMeB4v7HXjhFdVeZu0nERNDTyoTDd4b4qnp9PahNUfdkIfWeu7bnNMuJqxgYwHP
	bTNnAWHTYpt+gIYJQj7OqAXo5Vvo03/iR3A==
X-ME-Sender: <xms:fDq4ZyJ8As-IOXf1S2ZNQjmWTcBIjwuRl_3UPMw19lQgIF05gXXLZQ>
    <xme:fDq4Z6KC45Kg6PlM5XhBSUFdVpZXu3kjwG9TZiHGNJoRcLeVKyt7N4uv4XIMW4R_j
    dGrhokxmXF1RPUqUQ>
X-ME-Received: <xmr:fDq4ZyuD9NJ6JdmjgkrdVUUBmnyUWnJiHSX1SM4uPKsKg2tSHl_hkt1ANVqov-PTLwgO_0HprmPiHSJ-vhS7VsQjK2rfIgh4Ig_ZLPe37VOzTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeileehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeejvedugefgffffieegtefhgfeikeevfeefheevvdeg
    ieetgeeujeeliefhiedtueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsh
    hunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehsrghnuggr
    lhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehrshgsvg
    gtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhs
    thhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoh
    epkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhs
    thhirghnrdgtohhuuggvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:fDq4Z3bne_rD9EE7yUzpMfdPl8RX7VUrwgH7vkgtBX71IwIwNi6iLQ>
    <xmx:fDq4Z5ZVweme6gh9Ub-Jau27LHlqXzHNLpMwK7PMLVJaObMGc9TMaA>
    <xmx:fDq4ZzDRZLUZHkNw4b4NdUUePu7BkL_8MZhe4IOas9KLHKYyC7xI6g>
    <xmx:fDq4Z_bCu7qHsBM8RJYn-m4gxTTMD0HxELp_wHXmsy_XCXh_5x3Rew>
    <xmx:fTq4Z7nR0c-ZUzTOwFWm-qkW7IRu5aDWKwSQDWCNmSDRCPhRFiFLlF4W>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Feb 2025 03:34:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e147b6e6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 21 Feb 2025 08:34:01 +0000 (UTC)
Date: Fri, 21 Feb 2025 09:34:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	"Randall S . Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v5 0/3] Introduce a "promisor-remote" capability
Message-ID: <Z7g6eOmgRyP-BEcZ@pks.im>
References: <20250127151701.2321341-1-christian.couder@gmail.com>
 <20250218113204.2847463-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218113204.2847463-1-christian.couder@gmail.com>

On Tue, Feb 18, 2025 at 12:32:01PM +0100, Christian Couder wrote:
> This work is part of some effort to better handle large files/blobs in
> a client-server context using promisor remotes dedicated to storing
> large blobs. To help understand this effort, this series now contains
> a patch (patch 6/6) that adds design documentation about this effort.
> 
> Last year, I sent 3 versions of a patch series with the goal of
> allowing a client C to clone from a server S while using the same
> promisor remote X that S already use. See:
> 
> https://lore.kernel.org/git/20240418184043.2900955-1-christian.couder@gmail.com/
> 
> Junio suggested to implement that feature using:
> 
> "a protocol extension that lets S tell C that S wants C to fetch
> missing objects from X (which means that if C knows about X in its
> ".git/config" then there is no need for end-user interaction at all),
> or a protocol extension that C tells S that C is willing to see
> objects available from X omitted when S does not have them (again,
> this could be done by looking at ".git/config" at C, but there may be
> security implications???)"
> 
> This patch series implements that protocol extension called
> "promisor-remote" (that name is open to change or simplification)
> which allows S and C to agree on C using X directly or not.
> 
> I have tried to implement it in a quite generic way that could allow S
> and C to share more information about promisor remotes and how to use
> them.
> 
> For now, C doesn't use the information it gets from S when cloning.
> That information is only used to decide if C is OK to use the promisor
> remotes advertised by S. But this could change in the future which
> could make it much simpler for clients than using the current way of
> passing information about X with the `-c` option of `git clone` many
> times on the command line.
> 
> Another improvement could be to not require GIT_NO_LAZY_FETCH=0 when S
> and C have agreed on using S.

I'm fine with this version of the patch series. There are a couple of
features that we probably want to have eventually:

  - Persisting announced promisors. As far as I understand, we don't yet
    write them into the client-side configuration of the repository at
    all.

  - Promisor remote agility. When the set of announced promisors
    changes, we should optionally update the set of promisors connected
    to that remote on the client-side.

  - Authentication. In case the promisor remote requires authentication
    we'll somehow need to communicate the credentials to the client.

All of these feel like topics that can be implemented incrementally once
the foundation has landed, so I don't think they have to be implemented
as part of the patch series here. I also don't see anything obvious that
would block any of these features with the current design.

Thanks for working on this!

Patrick
