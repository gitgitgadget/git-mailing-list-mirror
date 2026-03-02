Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2B631E834
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 21:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772487790; cv=none; b=IJy3jtn3SOeqMDS8NbaNZMENoFSWJXWcQn3VtdIpwOnR72xydIZtGVgTEA+oFI3fbyXVlYiqFtb6OBALzb4a6Et11mnT9pKGxoZ4kyhx4FoXXzq2ZQGzwQMP36fxHhHbD9cw3uPQzPxeAV5+jSXb+RfibIFRtqLeeaPkxHIRp4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772487790; c=relaxed/simple;
	bh=cUg80xsAgGi7Iu9g7S3m+0bCncm3JwbQJrdjOOvEAJc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hG+nudoioJMHjPGrw69Xx7DNegViPOqFjXJVeev0sXf9FZxmhVVGfCSDVd5ejOvK32B9bwkgjVqsPi8OLYSHxzQh1RVwTGdBX6eCys5iDcvo7DNfRmOXZALSygF+pZesg1QXdhKAptLQrhYE/DA8pM8zMglsrwwjQsN/AAKHkHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e8clWwsS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d14NMCDu; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e8clWwsS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d14NMCDu"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1BC3A140003C;
	Mon,  2 Mar 2026 16:43:08 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 02 Mar 2026 16:43:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772487788; x=1772574188; bh=I+XENvAkwf
	ICV1PKxJQ6s9/ktfM8K2guNkeECBJ702I=; b=e8clWwsSzb1YEQwzIb03NW0iBV
	MYW4ba4sHTf7+TKMtvYp8Zc8zgyRGYZiA0+Ox0CMKwke/AGmDrrHgWkey2hlOiiv
	CUPgGvwEpNu9vY9W15Mxe61J3QUoLrgDAUdDeppTFhgO6pj6BahfMadrXxOsqJYq
	2saDb7+Vo3/5+uMuPgNCaL0q5BehtMedh+lKSWJ6fwb+4VYlN021nk4SW8haZ9/B
	luSYJdKwPYu+lZmBisO82wvp4UUpIjqUGQXqF6DV98M7N1G1PfTthZIQYOrcTvDB
	duGb536QG0yHpEcWA4XC/Cd04P3IoxbZS5VdVnyU4t4dCFRocHWIAlywpV9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772487788; x=1772574188; bh=I+XENvAkwfICV1PKxJQ6s9/ktfM8K2guNke
	ECBJ702I=; b=d14NMCDuJRN+hDnwRcclv76B1f516YCuJQW7hw6f4E44sVElUpa
	Lr3RMgaTLAVfVj1lsDKrU8H7hh9o6Fh8+nY3i8tO84rOq9Luv8xLOsoQpzv0E/x+
	Qljz5lksyev/Wg+AHP2NYbqGqDNs+VgBuuE/RgmnNUDbUzYmuZhTLcO6I24cql3H
	7TwBiuTxvHew8LUmQDKfsxUF7lOo7yhpgr0uu4KkCpTxXQ4XM5+QVqCnMDyfmLqt
	IkpcVgW9MJFU0XzrkiWaBxlSAkdQJmw2gE1mWIZMljiBdoGzgiNfD+tCnOF7rqgs
	6FW+SKv9SyoEZa7PoPOBQBh6BNPLXlHTF3w==
X-ME-Sender: <xms:bASmaSqwECv_CJRugYyEDRRWyLn-HVocAZy237ipAnxoLWcVSZL93w>
    <xme:bASmaYG16tium90GpmyMvMqwfDLmIyR2Vpc0XU8Pokgh8yvkyNOp8izbARjokBLzH
    zqi4ex5IAotInIisP500YoBkSUVQ3NLczyStTklbcrFT-PawGXOpg>
X-ME-Received: <xmr:bASmaUk2a6CYcOMVmxVqNdJJ_TBdPpB4g6gHK793AV6aS-z8aFIdAKxBUgWEKbPVmJ0MKagqAU21yr5GAtTEdIN-iQCmnkQK1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhdrshhiugguhhgrrhhthhdrshhhrhhimhgrlhhise
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:bASmabk2guK2VRHmHPpsmtQTtBlM_d73qejc31wrRn1YFZhytLzpKw>
    <xmx:bASmaVv-iLl_zU5Oo_xa4xOst6vmV4l6u4UN3-7OiCm1i356p4ALHw>
    <xmx:bASmaemPT4TMjQ3bDDj_yIIIKeks7NA-SmO3167TGfc7noV8i-ltqw>
    <xmx:bASmaQumyvfw6-8q9ROC4nj-oiL1J-_ZxzsbkjvncAVikw4gfBq53Q>
    <xmx:bASmaQHrYG_9wots2Xpij6dQ7jMCLBj1rQVU_p10Q0qWpo1_e-gxMyxh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 16:43:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] t: fix "that that" typo in lib-unicode-nfc-nfd.sh
In-Reply-To: <20260302192627.83631-1-r.siddharth.shrimali@gmail.com>
	(Siddharth Shrimali's message of "Tue, 3 Mar 2026 00:56:27 +0530")
References: <20260302164521.79148-1-r.siddharth.shrimali@gmail.com>
	<20260302192627.83631-1-r.siddharth.shrimali@gmail.com>
Date: Mon, 02 Mar 2026 13:43:06 -0800
Message-ID: <xmqqv7fdykk5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Shrimali <r.siddharth.shrimali@gmail.com> writes:

> In the comments of lib-unicode-nfc-nfd.sh, "that that" was used
> unintentionally. Remove the redundant "that" to improve clarity.

Thanks, will queue.

>
> Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
> ---
> Changes since v1:
> Dropped changes to t0019 and t6416 as the original "that that" 
> phrasing in those files was grammatically intentional.
>
>  t/lib-unicode-nfc-nfd.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/lib-unicode-nfc-nfd.sh b/t/lib-unicode-nfc-nfd.sh
> index aed0a4dd44..201ab9b24c 100755
> --- a/t/lib-unicode-nfc-nfd.sh
> +++ b/t/lib-unicode-nfc-nfd.sh
> @@ -75,7 +75,7 @@ test_lazy_prereq UNICODE_NFD_PRESERVED '
>  #
>  # Note that I've used the canonical ordering of the
>  # combining characters.  It is also possible to
> -# swap them.  My testing shows that that non-standard
> +# swap them.  My testing shows that non-standard
>  # ordering also causes a collision in mkdir.  However,
>  # the resulting names don't draw correctly on the
>  # terminal (implying that the on-disk format also has
