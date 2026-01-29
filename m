Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6D034028B
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 11:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769685870; cv=none; b=e7OVAJmfPCsSrTu7rCaeODj1OGNt6D+ea1MJrj4Yg6KZ/bk9K+KapM2r3rcgoRaY3E3n+0QWK2/OQ5xdQxLs9EmeRGUarZo9TdFC1/Kn0vqCk3sdzjw7y7anebHHQ/1TOCNzgNgmEtvnWw7A/L4AVLYdiA+PoZihwuxvWX0uZcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769685870; c=relaxed/simple;
	bh=xaMM9cSbiwLskpToEa4aqJrZNeda6XCpLHaE6kNQpRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4WcHMgtE0ReoAz0T4Z8ZAp2OAFwJvOGdbr9EAqAe+2/rHGHx9AQ7edvUMhiYPc1sl3P+Q+ju1Frikp6FCOobTR3KJsVeivgXlo7HbxspmS10dK+aZXSrw7ODoEmNjHiwo9zQYpuIDQZPiueUUjXQ4XUwBfNRv5wYgUuqWqnqoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pMbNub88; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e1kkJ033; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pMbNub88";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e1kkJ033"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 624741D00055;
	Thu, 29 Jan 2026 06:24:28 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 29 Jan 2026 06:24:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1769685868; x=1769772268; bh=XNtl4S+GIN
	owhQkE+2HZLCiyD4aua63ccI18NHBMSLY=; b=pMbNub88SQZpx4WttpiosLYBwg
	uhsKVWSf22a2vRJ8YyDefN+99snELjvwPdoo9J/rp+JvmV72X6pllDb10Cc0L0Mx
	BfBopC4+R+tK5uGeezYwtXSzDIb9TPvIABj2y534OrC7qT1ecjXCm80z1S9s+bo1
	QIw5gxmPmkkBKE0a8c5nZsLzXAPCoOJpiOJBJ5A259STt3noJUFn/vybQ1RlquhM
	yUAesFcrMn/Ahj+b+7l9PAuR2+Y90Tm8oA2ARmOdZ4C1Rsx19XIyuNJ4duiAf/bR
	70QyVHQCyIk5pOaP/2PYOCwEN9mwkmn4OgBSAkG343i1DVX4j5EFP/gnmiEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769685868; x=1769772268; bh=XNtl4S+GINowhQkE+2HZLCiyD4aua63ccI1
	8NHBMSLY=; b=e1kkJ033wpzSPdv6/zLCk64QT5mmDgcrMqypTHLH7qdgfIXqGug
	nKzmObbtPc6B2vO/5vgOfzfzoNZD8MiSXEePTVNwODl70Db0cmXFIZ9dH5f5aAWC
	sXci54Jqdom/tmSIsjnRJdePMQx19YpP+r1nKpYEhbVwZ1svyx7PGGnhz4X3ayRn
	7FQod1D580pk5tGgOVJkksJ2C8qsiQqlAXBG5U8JZzZOdGjIUNGx1yvLJJcwOLJC
	83D7EaHDjDUyI0OmOQPR41rCIQ52L14fRT8FymJYuPykY8NaIBwbgI1y/TsjtO9e
	WOqEZ7iEcYffgG53K7Mohak3J3x1l2uqdpg==
X-ME-Sender: <xms:bEN7aZfvOB1EyEv1GzzzHM0tbMGAn76SQaVsjkaZEr-iKAYjcV5Btw>
    <xme:bEN7adNMR0JJqViDAqTc96sh_NzS2QR1ANVx67ehVgpSXk1nIPDrI0YjN6EWIlIjE
    AjISsWihM4N1hzfTB1htOhFF9c4nHlUOtA8U8F8wfkzzH5tnM9DJQ>
X-ME-Received: <xmr:bEN7aQI-LkjKRywYdUPSmXtCZYteGjWnS8mcEBymF5QCn0haKKhwhBJr1Pcgja1EMjwRcVTHjsKKzGgh8kKUFZP2K-vAYx8XQc0dUPd2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeitdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjedttdegffekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:bEN7aeF7GFUpme17VGJjTc_p-mFRCowDoZwgIhAyTLt-xuMEsKM7pg>
    <xmx:bEN7aYRi63XlNmaMCqG3EmB7skT4kLsBJc2e7K7NhTXuOrOwb7_s6w>
    <xmx:bEN7aaF1A5dXXaHGBs9SAIkQL7mlg15Wl11bVmtLPp9QG_fgbthnYg>
    <xmx:bEN7aU9uKFK94arZwFe7BeegPpiHi7qS0xFRoYCKwUoCXMXhFS5esg>
    <xmx:bEN7aQPMchbXInOYqXVniruSE0tVo-D8VeDg7Uk7JDN0HDEe7MB9Uwm1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Jan 2026 06:24:27 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 30ef0c5c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Jan 2026 11:24:26 +0000 (UTC)
Date: Thu, 29 Jan 2026 12:24:23 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] odb: prepare `struct odb_transaction` to support
 more sources
Message-ID: <aXtDZyFoSQahkxBa@pks.im>
References: <20260128234519.2721179-1-jltobler@gmail.com>
 <20260128234519.2721179-4-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128234519.2721179-4-jltobler@gmail.com>

On Wed, Jan 28, 2026 at 05:45:18PM -0600, Justin Tobler wrote:

The bit about supporting "more sources" in the subject reads a bit weird
to me. We still only handle a single source in a transaction, not
multiple ones. I guess what you rather want to say is that we handle
"generic" sources? How about:

    odb: prepare `struct odb_source` to become generic

> Each ODB transaction should be specific to the ODB source it pertains
> to.

This is a claim that should probably be backed up a bit. I myself
obviously agree with it, but I think it should be noted _why_ we want to
have this in the first place.

The patch itself looks as expected to me, as we split up `struct
odb_transaction` into two structures:

  - `struct odb_transaction` continues to exist, but is now the generic
    part that simply contains the source and a function pointer.

  - `struct odb_transaction_loose` is the backend-specific
    implementation.

One question though: is this tansaction really specific to loose
objects? We also seem to be handling packfiles there in
`prepare_packfile_transaction()`, so it rather feels like this is
specific to the whole "files" backend. I might be misunderstanding
though.

> --- a/object-file.h
> +++ b/object-file.h
> @@ -208,10 +208,4 @@ struct odb_transaction;
>   */
>  struct odb_transaction *odb_transaction_loose_begin(struct odb_source *source);

Right, we still need this function to be public right now. But
eventually it'll be converted into a function pointer part of the
`struct odb_source`.

> -/*
> - * Tell the object database to make any objects from the
> - * current transaction visible.
> - */
> -void odb_transaction_loose_commit(struct odb_transaction *transaction);

But this doesn't have to be public anymore as we have it available to us
via `tranasction->commit()`. Makes sense.

Patrick
