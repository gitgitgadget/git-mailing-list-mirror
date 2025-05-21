Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E58C208AD
	for <git@vger.kernel.org>; Wed, 21 May 2025 15:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842870; cv=none; b=en1ckiM06oK1x2BKul5q5ebuE9gBOeTC0+vWutn/iQVOw207WBGiHNAuSPIfn0fmHSpB0JKsDXVJe9jUX9tGmqhIF7TG2Yx2x2ITD+yMcQn8kw8aTQl+MKTcTztcpyQg5PnahJKerdfaVC1QnSdLmcZHvN50hsvmGbdurLYC5Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842870; c=relaxed/simple;
	bh=O0T5aFjBi6YKVT7HO3yv4h7g2GNbOTxbyG2DJqbJWaU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cx9mAhGzFDow9eAQSiFCipCMglmzL0y9AchDiNj9zKEYZQ1y7zXNTn5ZPA0VW/oyKIhiJeaSPcxj9IF97146wlcxaPGE6mCcuSIhhJL2sCv3g0+xCvk/iuN0qOWgAaahaQXmvIfO3w6nLopR5XtKp24v9lcEoNJ9/H7jhfqceW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SVSNLvY1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WD0Tm79c; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SVSNLvY1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WD0Tm79c"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 609241140097;
	Wed, 21 May 2025 11:54:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 21 May 2025 11:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1747842867;
	 x=1747929267; bh=2O2C7PuzHiZbNoWXr3F9iNx4ZRH1fn/GDwJT6jtl1II=; b=
	SVSNLvY1xuWzBkiwTe+3PTdyI2A9Hfjd+5BEO/J8Y4ZGZf1dOskjCAbzC5IaBuop
	YhOoHdny1Kt7CMIV88YAohtcid4YVoXjFTIMNVOfuRE1ZBxU8syXhQaBFMcjftfb
	8mTZLU8S5l5VT3ZbezW8mDyMRp2AkOEMU/4PLNGo8X0SRVaWA2n1maNGKMVngNBP
	yKAnp/hIiI+I3asSNwMGq5p2VAZeR9thIoO9yrP6kTYECa26JTGZKbUa9QUGbaSY
	CrvHHoYUaMS0l3sYxdUok/PpROnUb52armXnDZqH+Jz/hgTWz9soayHEiMaf0hxl
	NUFnafQ4e4+ja3umSKpCMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747842867; x=
	1747929267; bh=2O2C7PuzHiZbNoWXr3F9iNx4ZRH1fn/GDwJT6jtl1II=; b=W
	D0Tm79cBgjyA9a7yd1KpFA1kNw8jm3R4i2cHSqddSYfXJIJWm5FQft2ZwXdqleo4
	p6vfYHxtHC041Re/lIb3Z13566jUz+7bgSVuAu2u4a2aBbbYg7wWy147KtSnXbzu
	4Ih6z+FP5QjNToM9XXOIRSqOTny8c6sSK4/efzE8GJ91zk6FVH5pza+50fGEhFUj
	+Pzy33lXxRCGgdjW3tGsNvWje9wKzEoYmE9j5ZSPbrWFcNFGptUpO9166TWrd+al
	wmSniNLypBYfxRDq6hdRB5ivLEZRlCWrKKLLGn/p1DdnOdg7KBew24V/2sGoOEQQ
	spSymGwN1CBLgZTwpz4tQ==
X-ME-Sender: <xms:M_ctaCB6Sbw4hmueG2KUJ6qWEVo075oYzBF_RHDo70sVMyGcLGkmqA>
    <xme:M_ctaMjbd8wt4JOnl_Y0BN-Ii8zp5o30vtu_2I6urqmJ1r82hda6hxjwFlPwhD9RP
    JhHMorZJjnbxLVwHw>
X-ME-Received: <xmr:M_ctaFmcPsIqy2wGTIe2-XFl_nqVnMCXf3l1I0wvIByrZPB_vquQAM4MVqXz17rcPGbpkLrzmIh5mDTGuCm2SHIcFXcrJjHRv921gxI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefhedtucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgfgsehtkefotddtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpefgteefgfel
    fffgtefggeethfegfeefuedvtdekhfekgffgleekkedugfdtffeigeenucffohhmrghinh
    epmhgvthgrtghprghnrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpth
    htohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughg
    vghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehophhohhhorhgvlhesrhgvughhrghtrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:M_ctaAz0D4r8iRSf_rERihHl-V65ujDDvgWNwF61rzB0yEayFRKUsw>
    <xmx:M_ctaHR1Yb2zldwLTK9aXPqrdy0cAHQbiGTtVYaGeLa9hSnepViLbw>
    <xmx:M_ctaLbW25HZiauMMaMPcGKSEFkLwDhBGliQ64y7YxYuh6wSjNLyWA>
    <xmx:M_ctaASB59PAcBK-pBECXUZRBIIKX1WSscV7-0TjeHgoLb_ycHViNA>
    <xmx:M_ctaBWDrWC7m60WU9y9xE5d3RT2KFoMQMXN5xRswV4kYrzBIRcIoCWa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 11:54:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ond=C5=99ej_Poho=C5=99elsk=C3=BD_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?B?T25kxZllaiBQb2hvxZllbHNrw70=?=
 <opohorel@redhat.com>
Subject: Re: [PATCH v2] cvsserver: avoid precedence problem between ! and %s
In-Reply-To: <pull.1925.v2.git.1747822992457.gitgitgadget@gmail.com>
 (=?utf-8?Q?=22Ond=C5=99ej=09Poho=C5=99elsk=C3=BD?= via GitGitGadget"'s
 message of "Wed, 21 May 2025 10:23:12
	+0000")
References: <pull.1925.git.1747813502225.gitgitgadget@gmail.com>
	<pull.1925.v2.git.1747822992457.gitgitgadget@gmail.com>
Date: Wed, 21 May 2025 08:54:25 -0700
Message-ID: <xmqqldqqarim.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Ondřej Pohořelský via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: =?UTF-8?q?Ond=C5=99ej=20Poho=C5=99elsk=C3=BD?= <opohorel@redhat.com>
>
> With perl-5.41.4 and newer, git-cvsserver fails to build because of
> possible precedence problem[0]
>
> Added parentheses avoid this issue.
>
> [0] https://metacpan.org/release/ETHER/perl-5.41.12/view/pod/perl5414delta.pod#New-Warnings
>
> Reported-by: Jitka Plesnikova <jplesnik@redhat.com>
> Suggested-by: Jitka Plesnikova <jplesnik@redhat.com>
> Signed-off-by: Ondřej Pohořelský <opohorel@redhat.com>
> ---
>  git-cvsserver.perl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index a4e1bad33ca..076c10cb2c2 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -5009,7 +5009,7 @@ sub escapeRefName
>      #   = "_-xx-" Where "xx" is the hexadecimal representation of the
>      #     desired ASCII character byte. (for anything else)
>  
> -    if(! $refName=~/^[1-9][0-9]*(\.[1-9][0-9]*)*$/)
> +    if(! ($refName=~/^[1-9][0-9]*(\.[1-9][0-9]*)*$/))
>      {
>          $refName=~s/_-/_-u--/g;
>          $refName=~s/\./_-p-/g;

Thanks, will queue.

