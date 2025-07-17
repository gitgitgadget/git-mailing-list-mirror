Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B261298CBB
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 13:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752757406; cv=none; b=DDBI7ybC8IqS3gEFBL9KxPgkhWJzhQxZVWb2LjG079ztzNniRq7xqVMMazDTfTjnN603dvOjQMhFZkCXOyZy545TyNWuo//IRScZceM7UTtfvWLVYix6opzeY1DCLSbIbt9d7HGrv6sTIrlrN0vofc/P8ZiCIDT58peoxhvTj1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752757406; c=relaxed/simple;
	bh=yCoRwdr0ke+SsRQ/lYHEDiHuz3m2N1ivJeN6kUUMAuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4GH6H3vAl/1hVD1yw+4MTYFvtUBMk8nK3fYbRljguad43sH7lnlGjLDJBO8ZIsWjmWBKpmINfPdUb/A4bq3h/fFzCHBNJ8y4VHILPZ6KvOEoDWy6NJtqglD2WSZ5kmGJTrYtxGN2w/315Z98jA9+YYZkz0jWwOJb5AJtrBG6nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZVedQqk+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yi04ziqk; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZVedQqk+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yi04ziqk"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3F4311400129;
	Thu, 17 Jul 2025 09:03:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 17 Jul 2025 09:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1752757403; x=1752843803; bh=8zgaIDfyZ/
	rSttl6bIQBQowWuAVK8fu0sG8Mj9LfVfs=; b=ZVedQqk+1RSA3RgxdL8yJmjfc2
	XF/1UL7TQezzuK0ldFTpmVPUvqPgklpGbcDt3MGV9S+sNbFGjGgOrz9LXl/VNYUp
	15XPNQG1Pmh8xn6ydEU4GYfurEfrNxds0QS1kWr0ncW/K2ji69lFKZDzHs7ijPyS
	bDgpS32ZQJfijMJVOGIS/HI1LJwd9RoFR+4NMkRSUpw1urXvlMYWN+vU/XsW3DBD
	Z8nidKJOgKP1nHVLthWY5VIVW/n/bQSndOiy1cPgOxqUGj/hzKPpcf3Xcb45x5T4
	S7BJW8s6sJCgjQ81VglwCF3OZRHhYNKjwE8uFw4f+HDJYqNebz0B2vw0+ZiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752757403; x=1752843803; bh=8zgaIDfyZ/rSttl6bIQBQowWuAVK8fu0sG8
	Mj9LfVfs=; b=Yi04ziqkb3RHkyzPrLFLzPxaayu+pPiWqPYM1UXfGYfm8av+oI6
	IiWNFXTnkbDRmr9LJJxAWDTxB2WJbwt+Exm8KdKQOtgUCyVEDjQXBIHzsbPqaH9J
	VyytcA88Ckj221C8GWUUnCnyA8nMYX/WySn2nrjg4Sh9ggCLVdHZk/kH1U2f77qV
	h5G4+pxrfLoVVzYuGq5C8inRyRUK4flafRXQXLb3Fh0J/gHTIKxLzBot7t/sG08h
	6a5C3SeEZL0CPBT/CzZf+9dB4aewV8wz+HmbT4ofK9Tsw4GeAB/5y3i1XlsGSFJm
	pZ3XAaTqlcGF9I/8ErWaz1G6J+fw0n17CTQ==
X-ME-Sender: <xms:mvR4aPA0Opr3tPEeAMybB1MihhtD5sXEsPKsTioMwEjk_aQQrLyaQg>
    <xme:mvR4aJX-TCsXzgqK9Lf5JEnEg9xHV-AHM4jzX8kaIBTiuFbrqVRyl4vwBVJKINrHT
    1SDavUM5DsanTMZDw>
X-ME-Received: <xmr:mvR4aDqjK9bjTc7wZcSIpZ3WIeIm2HxSA43dHwoklTkPEbjDQ4YVtO94zi9_m06jjA1NTsunBUDLbjytG1VeRJ4po3TKEiyghoavbuESbPEY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeitdeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhope
    hluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtghomhdprhgtphhtthhopehk
    rghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:mvR4aFT3jJ4a9DlAGBX_NKk7r-ff2vPE0C8tYYkBnYU-gOpCcHd7wA>
    <xmx:mvR4aN3BE5Co6_Vjnc9_ByYGzZIFPv8-pwPNg-jJiojldvmasfVIag>
    <xmx:mvR4aBDX3gkOyq9nuFbAXf_yNYnNgggoyp-qTSTr297_74HTIlj4gg>
    <xmx:mvR4aJgPwwC3b844J_I95NaANcCjEbXLsATr55sttXfxU7mMMR-4lg>
    <xmx:m_R4aEF9wzs-g8saaUtgbqw-rzh32FhgnZXhczaDHDPZHpJrT5JGOrW->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jul 2025 09:03:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ab25372d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 17 Jul 2025 13:03:19 +0000 (UTC)
Date: Thu, 17 Jul 2025 15:03:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org,
	karthik.188@gmail.com, ben.knoble@gmail.com, gitster@pobox.com,
	phillip.wood@dunelm.org.uk
Subject: Re: [GSoC RFC PATCH v4 2/4] repo: add the field references.format
Message-ID: <aHj0lF5Kbirzv3pZ@pks.im>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250714235231.10137-1-lucasseikioshiro@gmail.com>
 <20250714235231.10137-3-lucasseikioshiro@gmail.com>
 <mgdervgp34m6ipfbodsfn7cztcl7gdeggzemfgivzvuyk7qtba@wdijebkuioxg>
 <aHc6y9FGFXjowkU1@pks.im>
 <2v7b6mpufnn6cj7u7tactgu2ibggn4xpuezl2bsfjxv62afrsa@chfrii6vkrx3>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2v7b6mpufnn6cj7u7tactgu2ibggn4xpuezl2bsfjxv62afrsa@chfrii6vkrx3>

On Wed, Jul 16, 2025 at 09:04:40AM -0500, Justin Tobler wrote:
> On 25/07/16 07:38AM, Patrick Steinhardt wrote:
> > On Tue, Jul 15, 2025 at 02:15:07PM -0500, Justin Tobler wrote:
> > > Also, as mentioned in a comment for the previous patch, maybe we should
> > > support printing two output modes. For the default output, maybe a
> > > simple `<key>=<value>\n` where the any value containing special
> > > characters is quoted via `quote_c_style()`.
> > > 
> > > A null-terminated output, such as the one proposed in this patch, could
> > > be enabled via a `-z` flag similar to how its done in other commands.
> > 
> > Agreed in general, but instead of using `-z` I wonder whether it would
> > make sense to use something like `--format=key-value` and `--format=nul`
> > instead. This gives us more room to introduce additional formats in the
> > future, like for example the JSON format that was scrapped for now.
> 
> If we already plan to support additional output formats, they I agree we
> should probably a `--format=<output-type>` flag from the start. I still
> think it would be nice to have a `-z` flag that is shorthand for
> `--format=nul` though as that is fairly common across other commands to
> have such an option.
> 
> Out of curiousity, is there a reason we are interested in supporting a
> JSON output format in addition to what is already proposed? From an
> earlier conversation I had with Lucas, it didn't seem like there was any
> particular reason for JSON.

I don't care much about the JSON output format. What I do care about is
to have a default format that we are free to iterate on, especially in
the context of `git repo size`. If we ever want to have output that is
as user friendly as git-sizer(1)'s we need to have that freedom.

From my perspective that necessitates two things:

  - That we are able to change formats with a proper `--format=` flag.
    `-z` alone doesn't fit that bill, as we are already talking about
    there formats: user friendly, key-value pairs, and key-value pairs
    with NUL termination.

    That being said I'm not opposed to also have `-z` as an alias as
    long as we also have `--format=`.

  - That the _default_ format is the user friendly format that we can
    iterate on, at least for `git repo size`. Otherwise we have already
    failed on our mission to supply a user-friendly alternative to
    git-sizer(1).

Patrick
