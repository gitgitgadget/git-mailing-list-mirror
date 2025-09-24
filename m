Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E5623C8D5
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 07:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758700542; cv=none; b=K7xYqHVw2WQyzMzuSboPLN2aPueS8lquKC2oDJdkTYLEAmr3SP/euS5sjnLDDgjZ5n+tdOLQ3SaTh24aChx+R9Oi+HGf+tqxddl136w+ndciWuL5VZIJM9srnG60qqp9Qql9VtQ8GUCoSo4X2c67Xawpnf7TmcVOJUsv/XDVK1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758700542; c=relaxed/simple;
	bh=U2jxKsad/FYhxq8NHI6sbCUXkY4rxFmMvwTTcn2iJQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o38wchK3LhJvM7csnmtDM4GJzIX8bq2A9pO95YJ5TlRSeRyTwEu6sf6GIx8+cXCfhTzPIW0UiYUIlqR929zShmOH+d8AByKAuFM4xI8BYLLi9nTSReoHdKAo37Gamd5Hd4HhS5LaJX8WZ4azKRnIU5wx/8PGvkKEsqzoawwxjzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iOgyaZ5x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S74u/Tv1; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iOgyaZ5x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S74u/Tv1"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id E4B46EC0110;
	Wed, 24 Sep 2025 03:55:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 24 Sep 2025 03:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758700539; x=1758786939; bh=FVWL6WNF/l
	hZHXMx2L8D+qDsMJvpaBDipRqyA72vIN4=; b=iOgyaZ5xHyBnV0Dk71Kf7VmY51
	Qr7lPwANjblNHa4qeqUnqFuJ1/wKOzK6fuMSKlXXbXgqATOJzvYbitda41N5f/F1
	Ffo1yNyjDG6ElVR2qNC/GWU+s7wvsI34AMMhXCkWSZ7+Rf4sLPsGCKT0vhxwTQmr
	HWgoqWq9m/CJhcwynKMYUhkt1RbqMD2fhqQUh7egs4+dgDqEaVI/J2C/lrDjU0y8
	++WFfyNmtCg6fXxCAk3uE9mUvfWDpam6UxtjRD24xvFvcUxJ8vADQvICy41z9vE9
	zJf8kpmudgNPIHgD+hK8NLFd88unDBVf7dksT/eO4IqIM10bO+pjkp+b3BrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758700539; x=1758786939; bh=FVWL6WNF/lhZHXMx2L8D+qDsMJvpaBDipRq
	yA72vIN4=; b=S74u/Tv1U52a2nkvH7mgXsGbPWyFlCpZV5nUON4IY1cK0FREFMB
	ojHrdpdxVupT3Z4kWjZlxAFMm7xq6g5K9idCmh6uFJVPH2pNJwVFem47ZGQLr5Jb
	yjdhmnVE8D8nxdPLMjTy3HNK1uW9hCXfsej3i3TWCJVqujb8SNWhsjYwoMBcqmm2
	Ht7WomNBs0Bo0Hy5ElbRZHXrdJKrjrehcpx+VAbWwGRmUImCz4ihmbvES/tNrmqC
	85uZkWLXBHL3f1Q8WnOSTsDLXOgeaOIBsjcgW92FBKjQz03kYqc3dl3UoZkeQUlW
	Kd6C8BeXNgWqunAGRGvzDTqiJ+H2uc820AA==
X-ME-Sender: <xms:-6PTaAT6dtQHI_QqirW6jX7GZ3dg9xZRXPIL17Wrxtj1PkHSm1VqlQ>
    <xme:-6PTaEzMJrIzoPhUbARl4jL8skccJHXOlcDKSp4yofLaUpcNVVnFv1xG8H7iyfDDX
    0mpsUcJjtlBVpplzGDXB00pjJYsDMAeLAV6T5ixqaitSSGW_Lwf>
X-ME-Received: <xmr:-6PTaC1SC2JL937jvU9im3tidgYTvK33GnKkLFumiOv6gfI9j8mg8QBPsWnvmBCHmbVj7YGvwSfvnoqKhX8ShE5XTQ6iCSzQtyi-TqZEvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeifedtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohht
    hhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-6PTaC55Qov_oq2LJHxFXnZE3PLJBIb1KZTeTxNEM6p2_XjDdh8kJg>
    <xmx:-6PTaFUi1kvS2SbITwmHlrrCasxe8-Ar1pcaIDG-aNsToH6AHv4OBQ>
    <xmx:-6PTaBBK91cxlOjDo0GUVNULZ5Qz_Cf10oJhrng3CKDSpsdW1bin4A>
    <xmx:-6PTaE78f0-A5u9CuE1P4q47XDmtPvLejw8oa2x1ZnHQToZljgXo1Q>
    <xmx:-6PTaEExbDZLotqMmJaGrIxHr3-zN8bxjP7PHCXpNsiXAn2rqg-u0xVH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 03:55:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id abd15927 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 24 Sep 2025 07:55:37 +0000 (UTC)
Date: Wed, 24 Sep 2025 09:55:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/9] docs: update pack index v3 format
Message-ID: <aNOj8fFTvkQ6jsaT@pks.im>
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
 <20250919010911.649831-2-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919010911.649831-2-sandals@crustytoothpaste.net>

On Fri, Sep 19, 2025 at 01:09:03AM +0000, brian m. carlson wrote:
> Our current pack index v3 format uses 4-byte integers to find the
> trailer of the file.  This effectively means that the file cannot be
> much larger than 2^32.  While this might at first seem to be okay, we
> expect that each object will have at least 64 bytes worth of data, which
> means that no more than about 67 million objects can be stored.
> 
> Again, this might seem fine, but unfortunately, we know of many users
> who attempt to create repos with extremely large numbers of commits to
> get a "high score," and we've already seen repositories with at least 55
> million commits.  In the interests of gracefully handling repositories
> even for these well-intentioned but ultimately misguided users, let's
> change these lengths to 8 bytes.

Yeah, this makes sense. We can only assume that repositories will
continue to grow, so it makes sense to future proof.

We also have the 4-byte number of objects contained in the pack. But as
you explain, it's nothing we should need to worry about given that this
is a mere counter, and not an offset into the file. I doubt that there's
repositories out there that'll have more than 4 billion objects anytime
soon.

> For the checksums at the end of the file, we're producing 32-byte
> SHA-256 checksums because that's what we already do with pack index v2
> and SHA-256.  Truncating SHA-256 doesn't pose any actual security
> problems other than those related to the reduced size, but our pack
> checksum must already be 32 bytes (since SHA-256 packs have 32-byte
> checksums) and it simplifies the code to use the existing hashfile logic
> for these cases for the index checksum as well.
> 
> In addition, even though we may not need cryptographic security for the
> index checksum, we'd like to avoid arguments from auditors and such for
> organizations that may have compliance or security requirements.  Using
> the simple, boring choice of the full SHA-256 hash avoids all possible
> discussion related to hash truncation and removes impediments for these
> organizations.

For now we only have SHA256 and SHA1. But thinking about the future,
there will be a time when SHA256 will be considered broken. I wonder
whether we should safeguard against that and also specify the trailer
hash to be agile? That is, instead of hardcoding the hash function, we
add something like a "primary" hash to the packfile and then use the
full output of that hash as checksum.

In any case, please feel free to say "no" to the above thought. It's
just something that popped into my mind upon reading this.

I guess one thing that should be explicitly pointed out in the commit
message is that there are no implementations of the v3 format yet, so
this is basically updating our envisioned design, only. Otherwise one
might wonder why we can update the spec just so.

Patrick
