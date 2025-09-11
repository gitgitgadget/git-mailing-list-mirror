Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CF7238142
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 06:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757572853; cv=none; b=RBzVmUaPOxiMKFASOFOcStDR41Rh2Gs7xhhSDHCSB1xGoe/f4l+RVPjIdPeZ6q1DnX7Bh1xc4DEQSQNOxvkjVNwIBRGWH4vD9KskfhFatdnR2wApKjOPkpyvrdTxdL6mgnET+mG4tESDOGDCwG8+xstUdkAw1I4i50+ZSFKq08M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757572853; c=relaxed/simple;
	bh=8awBl23ypLfxggq473sQFl6wDIe3TqmWOkdf7z1ki6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4fIK4fgN6CXfW472IOYXP0R5i7bZ3FPoF+ydUAKfCEYqGC7ZDB1MdrodQnM25zar1930p5H3wfzubHBzU2XMZxQ1RVJzSsdFeyqXWSr0bgO1wqkKg8D+Qyh+jshVy/yoeNZzMGQEqsvd5UGW9p2TZ4xCmFpNRLYt3kzQ3xe3+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=s3Fu09NZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HI7btz18; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="s3Fu09NZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HI7btz18"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id C21D61D001AD;
	Thu, 11 Sep 2025 02:40:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 11 Sep 2025 02:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757572850; x=1757659250; bh=D+kEQ5XAeq
	/5l+f9dBPlm4cMCSrDk97Lg4XZFbg6PG4=; b=s3Fu09NZG6lzhorcRkUlsqZ6px
	EvQKB++GxAdq8FZZrgysPX/0Q0z6sQxg1/CW5rDquzJrTiTBrgl9RbRVN32oPrmY
	g+blYPIY7tLnrIsqLfnyGxecIRHv6rKEMQhMuuXA0Om1IG7YIAx0BUUizAx2WqX1
	wON3o+HQZ+/0ui8A6fC1zCtt6MDXIUVYM+H0k3i5st/xkdG9DqTBnLgl3pfR559h
	WE4iHtYpcBwqFEMa4ZDMzHzbQr8Gk8GGwQtEbYXWcT4o6i64VnxHPSX26s2Q/ZRK
	xpSL8s1stknhjO9NItopkvSwe86KpL1yibQckJ1WKZ78pGSN7SsSpgPZTKzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757572850; x=1757659250; bh=D+kEQ5XAeq/5l+f9dBPlm4cMCSrDk97Lg4X
	ZFbg6PG4=; b=HI7btz18ZwYuy6vJpCtSGbY4m95w+U9GR3jXVIm9StvczgMMjS3
	nAJ4Z2XrCzJ+CpJdB6bN4abojZUknzsno2OuYkSgrO7K6RKb16qZ5CUy0w9R3A4c
	MqGLAa11NaPDflvkSHKgYXatlKlacCWonaf6DOtGZXQLaakrEM3O3vgOat+W56zv
	2YVaVFyBlIfi76M8PzyPTPmwemYfQirdZRg8IBOctJdbIcGXY1QABt3gAyuVQcml
	SPbRD+fq9wujyHQHd9ELDvI0jknsLbPETMSutAIOwVZ9uZrg64iJr2AGsEc8+gFS
	aYuz0zOVaCeY2R19QWWTdOiSqxXAEz9kKow==
X-ME-Sender: <xms:8m7CaLVNsjG8OmrszwfEBmr4tf7jo9o7yKy09Tfn9yyahFFnI1FrBQ>
    <xme:8m7CaDyq4CevxIAK3QwcKdEXFJi0dkIuFHspuj2aJF5YZMCZwNFZy04a75p0ClVUy
    Nu7xl_hatlzK9ReBA>
X-ME-Received: <xmr:8m7CaJOsxPIgRGFC4T2gFxj08Dw_lOa2mll6ADZ3Xvlm-HDbqaa-ZP-TSkW5VZJ5oeyzL1TecJPrwoY6W1YjABa3zaJ6mVp_kt6P7GG6AQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:8m7CaE4KFIzIDqonrjBiIf2Stnm1hXa8934H0Fx_XhL155OH0QIpgw>
    <xmx:8m7CaKNiSmfrJ287Phct_X0MPsYDq-wHnv18SAI1ixloBW3d5P7pww>
    <xmx:8m7CaCkkI_O7nsqAkCYtHkFl7BH4_gKHcSnNwaefbXyvq7Yfo4D1yQ>
    <xmx:8m7CaBQzEa6LmsJto-UshYriOtrr1jyQQR6YInC40gX22uxhqJZv3w>
    <xmx:8m7CaC5Gvbtm8eaVjgRPVOp7EvOXt3n7yCQWREdbhC7Tmf-9HOaT5B48>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Sep 2025 02:40:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cc4d969e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 11 Sep 2025 06:40:49 +0000 (UTC)
Date: Thu, 11 Sep 2025 08:40:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/6] builtin/update-index: end ODB transaction when
 --verbose is specified
Message-ID: <aMJu7vPKfnxt9UiC@pks.im>
References: <20250909191134.555689-1-jltobler@gmail.com>
 <20250909191134.555689-3-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909191134.555689-3-jltobler@gmail.com>

On Tue, Sep 09, 2025 at 02:11:30PM -0500, Justin Tobler wrote:
> With 23a3a303 (update-index: use the bulk-checkin infrastructure,
> 2022-04-04), object database transactions were added to
> git-update-index(1) to facilitate writing objects in bulk. With
> transactions, newly added objects are instead written to a temporary
> object directory and migrated to the primary object database upon
> transaction commit.
> 
> When the --verbose option is specified, each individual object is
> explicitly flushed via flush_odb_transaction() prior to reporting the
> update. Flushing the object database transaction migrates pending
> objects to the primary object database without marking the transaction
> as complete. This is done so objects are immediately visible to
> git-update-index(1) callers using the --verbose option and that rely on
> parsing verbose output to know when objects are written.
> 
> As soon as verbose output is requested in git-update-index(1), all
> subsequent object writes are flushed prior to being reported and thus no
> longer benefit from being transactional. Furthermore, the mechanism to
> flush a transaction without committing is rather awkward. Drop the call
> to flush_odb_transaction() in favor of ending the transaction early when
> the --verbose flag is encountered.

Okay, this interface feels somewhat weird indeed. If we now end the
transaction early, does the transaction still serve any purpose at all?
Like, do we use it to batch steps _before_ we start reporting stuff?

If the answer is "no", we might be able to just not create a transaction
altogether. If the answer is "yes" we should probably point out in the
commit message that the transaction still has a purpose.

Patrick
