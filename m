Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F2E2153D2
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 05:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761198599; cv=none; b=RfOEkvbbLWEedc9dGSqvoQX+k8MXCFQyLHJBPCu+Y0c77MPaFDemDcE77g14uG4CMRkDuLx2ZDbdzWDlMbEMcIMaoT1C8rpE/q6JE2WMnrGdsFkAmzjSpTBjYw2mBDnkO9bScUG85hb3UCq6ClLbH807Ad3LE4pxj8cRag0GqHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761198599; c=relaxed/simple;
	bh=MpR6Gi8E8Q3pyqV3vURciwcBnxeAT+u7N5jlwcM/pTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBlPxEPrjj7JI4HmBq44b0DY5HJn51tvThCpB6HSEhiswtxZvjh29ELDqtsE82Q8dfOj9dzLMr3gYpaBq73QZjI6mLyKp3gWjl/aNYilYeDGI/djw/l4+LTIjcVTBnJF/GK7ShflhWvXshjWVh0TnUDbBrPNwVxkEuWGmjXcALs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gND4bicn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B+fsfnMK; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gND4bicn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B+fsfnMK"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 17C021400190;
	Thu, 23 Oct 2025 01:49:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 23 Oct 2025 01:49:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761198596;
	 x=1761284996; bh=lfnN/z39uUb02lzMF229uEbdz9E4tm5VAWQq3THJb0U=; b=
	gND4bicn2JmX8Y9EfI5caQFZwgZ7yOvsELJfJeazbp3JQ43Wm/GHTIqhlV2QflV5
	ZcoMjTCuTFywYzQVvrOhLVnEQItkDy/Mo0VT9O2c65aAySf/KDcapTHwNeqQibIP
	Bb//7kSRrMXaD1dRqj2L1Xs8QtbtpCyVAmmv+pVrvIoakbyR7Ut8Pt8VgCmNjTJv
	yt6RbFDXjdSfWYrn+cG+vGbCE/fbST4/o+TRqsIO0p2TNmSC3bp3+Rcs6jDGIF22
	LK1PFrURNGU86PbTEWdXjyNQTmCllZ7jZUXpvJ0YX9VkbCUtcoqh7cnpvfRnV4r0
	2vQU5V2QsmZVIhJVC+QfhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761198596; x=
	1761284996; bh=lfnN/z39uUb02lzMF229uEbdz9E4tm5VAWQq3THJb0U=; b=B
	+fsfnMKH08HoaaK5w8f5Kg9dvqAE8lqQxhW/PK35vmUuZ3QeFxEiC1Um20j0tAAZ
	ZVlZQ9jODFmNNv5OnGCtWcgtwTk3Io0trCCQUB5L03tgKs21pzFuastEDFfQIrs+
	Jp6Eriiz8GpwbNxSAlx5ekc2WNhZWjkBap3MKNEvyWZ6wjO9mtAZ0iaskHXtgGVf
	60Izwoy/SrGhBsvjZcmVVJhI3nXLnW4M+s9NBN3J+fdtvv0/AmstNKsb7a5NK2q6
	08TBJ7l/elZKM6D9LhklNdDSDqcx4YQ8KAB7QV/nbSSjSyLVG7P1s00g8cEoGSyN
	5UT/wIRuYSssDWU7UR8Sg==
X-ME-Sender: <xms:A8L5aLZdbqgPAF72M6vMgL4dAgHyXD5sjrWiOrrEOZhkv2rM1Iledw>
    <xme:A8L5aB1iychXgLWlv_6HlRfqtYFfkmD0ztnVe_r4xcKjhxz5lIl1JdIhA026j-mU8
    1b5KYm3OqvAwhg5M16ugpxLP1jlJ4d_ZF0ICQ3rv8Ied9IUzWTP3_M>
X-ME-Received: <xmr:A8L5aLXcHjnYhwXM5sUynKkW4Vrj3jIBm3C0BJBhNs3zRsg4snvCXn8bxIMv52rad-WfeJ6dY6KjDAqK7EINOqdRC09bGLDH9mgC2s4amPWUkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeehieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgiivghkih
    gvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggu
    ghgvthesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:A8L5aLUaFWJ3taYrpNWsiWMVBxQSUUg5HBV2Nnvny6YeEn3_h_arQw>
    <xmx:A8L5aKd4OLiI2H4s1ewc36__pKH4pjfHlI8W3TYQW8Chmchyw-6pig>
    <xmx:A8L5aEXq9kKdFK82AR0Qf-Z0EaHkJRPoYFzHCxvJVpHeCsqnKcZ4Xg>
    <xmx:A8L5aDfHCpVyQsvazJHHyUgkNr98FNF_qmkKJZeIkN9mTwcb5DO1XQ>
    <xmx:BML5aDRUkdVAA9HDgihGR_BWFBK4nI1lhzigLt8VNymMGBMbiYCPbZcg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 01:49:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e6020116 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 23 Oct 2025 05:49:53 +0000 (UTC)
Date: Thu, 23 Oct 2025 07:49:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 4/9] xdiff: use unambiguous types in xdl_hash_record()
Message-ID: <aPnB_jEjn-nnRg82@pks.im>
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
 <7fcd83c99076404960302b64a4f0c8fa1c13feba.1760563101.git.gitgitgadget@gmail.com>
 <aPdFbPN-60MVo3cv@pks.im>
 <CAH=ZcbBeDNqW6PqhhzU75wttND86RfMRuNS2ga6KP1fN7AhFnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH=ZcbBeDNqW6PqhhzU75wttND86RfMRuNS2ga6KP1fN7AhFnw@mail.gmail.com>

On Wed, Oct 22, 2025 at 03:20:32PM -0600, Ezekiel Newren wrote:
> On Tue, Oct 21, 2025 at 2:33 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Wed, Oct 15, 2025 at 09:18:16PM +0000, Ezekiel Newren via GitGitGadget wrote:
> > > From: Ezekiel Newren <ezekielnewren@gmail.com>
> >
> > This should have a commit message explaining what exactly you're doing
> > here.
> 
> I thought I did have a commit message justifying my changes. Maybe it
> got deleted through a rebase. How about a message like:
> 
> Convert the function signature and body to use unambiguous types. char
> is changed to uint8_t because this function processes bytes in memory.
> unsigned long to uint64_t so that the hash output is consistent across
> platforms. `flags` was changed from long to uint64_t to ensure the
> high order bits are not dropped on platforms that treat long as 32
> bits.

Works for me, I guess. Thanks!

Patrick
