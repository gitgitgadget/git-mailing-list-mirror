Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3666925B66A
	for <git@vger.kernel.org>; Mon, 14 Jul 2025 17:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752513050; cv=none; b=jOlfG3Rq6ASF/8Jrw/+H2C9CQg3zyrbstmoZqHD9zNHESoG6V4jH/ucX555Gn2pNpAMEn+GDfOYgGb+ls8cAVvoEsgcvuKhjir8WYMbILoSPJshDEuCeED6G+MeETa0WYPtqWtKEScJNRDsAxTrRJ2eZebo56ffGlSHGARd0tOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752513050; c=relaxed/simple;
	bh=Ne5gbrgVEuPMBy+14nm6FDBopSrdC5SiGukyPud6M4Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ftdfb54/hSmXB8wVbujNEbBhbtWiNZg6hSmBBs963jnpSB38EuHJHLyaHHt6UgZpN5OtOVL/BmitCpRuLUyf4MT6HsO3YCMDWx0PYMugWEbHRS3eCaEg/HUGkySHddApzqRARNBLH3coj3kVUQKU7WQdN8SwqSW8uEHfTCYAJXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CaZ8oevE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IanBJX6Z; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CaZ8oevE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IanBJX6Z"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 19D25EC05BE;
	Mon, 14 Jul 2025 13:10:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 14 Jul 2025 13:10:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752513047;
	 x=1752599447; bh=ouMyF3SK/l2djLtbovNHhXODs5/06ejAVaJx8+VMui4=; b=
	CaZ8oevE1NwJBfMzHe4o3cbjANaKHRfzGFIsbPROMRREkteL4NxeCCcSlzTBfCMR
	I6HEJwea7I+CEk6+HpBxRDdk9gOWlNQLTa1cQbMRCW8rC7odwuBBj7YXXlZFbsvM
	4U+BdjnR55SJaMq48VGwF4xsnA1q0IG9CJJFiiCGDwWEEN9rh6TBB8AhQyB0We42
	4eQPNnB+5YkuWGFe9Cebmq64ykObUlo0AstU9+Ljkc+rVpnO5XrsyX3CuCw5SPsO
	wqZ81EvtjwhqQIBL9KB0dCPgkIh2Vc3R0XLIrHVt3ORr+mxjf4IpV0md/6UhrQy5
	pMncoi8AqRwYOYoTIfLD6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752513047; x=
	1752599447; bh=ouMyF3SK/l2djLtbovNHhXODs5/06ejAVaJx8+VMui4=; b=I
	anBJX6ZOvYRSja1iwJ8NK5i8Lug+HwcWR/BuBaNVzOreSqXkQdoagwTSMiNdW9k5
	3m7e8E4hU//UfPSl3V4+qlPnUcOl5T26FBSUdLjJRu37+X4i57vBpZDGwwE9Auvg
	TaNXdwBLi11GfSxfyeWRldpKHD5Ldsfa+AA8qUCBZwC//17n6o0HkkGGg1rv5QNi
	0hrrBou4ldORmElJSWUqJcRUDTAZmMdeDT7ZJcwnBvDC6DFidB/IdEy/nCaJOXU8
	WtNlTEixwapZYDaPlISxJk+Fu8t/2KqOLSMcaC2LUgneyCicqeMJ3lpKrf3DM8NS
	CIoSff9B3xOYl3x9dqGcQ==
X-ME-Sender: <xms:Fjp1aI_0qEIEtDT4UnqsjcknVXLa7Q19hWPhmjnIdkcYGDSoiVntIA>
    <xme:Fjp1aMMtj0bfVMN57xk-MN3M7aFPyO2_2Z-X5c8d3KUYEg-mfy53_LekwrHmRxZeK
    L3y08paVhUcoxcfAg>
X-ME-Received: <xmr:Fjp1aEfYeH32--7JcUXNOGCPlrs4BU_mNMwLYNqwuP7fb9JgVORrtECiKReAm66h-jrO10c86ZNNUgs-RXrJutz3b1SMBOJ-n5hyCO4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehvdehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepkeejiedvveevtdevkeetieefueevvddugfffkeejhfefhfeilefhieeukedt
    teeunecuffhomhgrihhnpehprhhoghhrrghmrdhlohgtrghlnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidr
    tghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epjhhonhgrshdrsghrrghnughsthhovghtthgvrhesghhmgidrrghtpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehfshesghhighgrtg
    houggvshdruggvpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Fjp1aDWdTSebDwPWShPnWqgJBoq29IItviu_HlXCpYw97xd7pb8rmA>
    <xmx:Fjp1aEjnIV7i9DUv_EAft4QF5lCJGNxW0A87lb_dbPN01JU8ocsibQ>
    <xmx:Fjp1aK9x04Zn5P0XB8jyBAMfgFK5bLyMaGlBEHhDWyTMmX_8_PX78w>
    <xmx:Fjp1aObi7-ZRy7T5GyfYIwRcLeGu8rpwJJ4Jvvl0GR1DKa6MECCs_Q>
    <xmx:Fzp1aOz0XJ1Jc9V41tGELfibe0crflFtv8H9T0zOp4sf8FS4ciVvCeG6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Jul 2025 13:10:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jonas =?utf-8?Q?Brandst=C3=B6tter?= <jonas.brandstoetter@gmx.at>
Cc: git@vger.kernel.org,  Fabian Stelzer <fs@gigacodes.de>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH] gpg-interface: expand gpg.program as a path
In-Reply-To: <20250711232348.460804-1-jonas.brandstoetter@gmx.at> ("Jonas
	=?utf-8?Q?Brandst=C3=B6tter=22's?= message of "Sat, 12 Jul 2025 01:23:47
 +0200")
References: <CAF1X4d7N1xdZt9JkVZytbEU1=7q3X_F_nqm4EG82B8-cVa7g8Q@mail.gmail.com>
	<20250711232348.460804-1-jonas.brandstoetter@gmx.at>
Date: Mon, 14 Jul 2025 10:10:44 -0700
Message-ID: <xmqqy0sqsnor.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jonas Brandstötter <jonas.brandstoetter@gmx.at> writes:

> This allows using a custom gpg program under the user's home directory
> by specifying a path starting with '~'
>
> [gpg]
>         program = "~/.local/bin/mygpg"
>
> Signed-off-by: Jonas Brandstötter <jonas.brandstoetter@gmx.at>
> ---
> First time interacting with a project via a mailing list. Do let me know if
> I did something very dumb.

Thanks.  The update to the codumentation to explicitly say that the
variable is about "pathname" is a very nice touch, and the code
change is trivially correct, I guess.

I wonder if we can have some test to protect this feature from
broken by mistake, though.

>  Documentation/config/gpg.adoc | 2 +-
>  gpg-interface.c               | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config/gpg.adoc b/Documentation/config/gpg.adoc
> index 5cf32b179d..240e46c050 100644
> --- a/Documentation/config/gpg.adoc
> +++ b/Documentation/config/gpg.adoc
> @@ -1,5 +1,5 @@
>  gpg.program::
> -	Use this custom program instead of "`gpg`" found on `$PATH` when
> +	Pathname of the program to use instead of "`gpg`" when
>  	making or verifying a PGP signature. The program must support the
>  	same command-line interface as GPG, namely, to verify a detached
>  	signature, "`gpg --verify $signature - <$file`" is run, and the
> diff --git a/gpg-interface.c b/gpg-interface.c
> index 0896458de5..3dfbc45385 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -783,7 +783,7 @@ static int git_gpg_config(const char *var, const char *value,
>
>  	if (fmtname) {
>  		fmt = get_format_by_name(fmtname);
> -		return git_config_string((char **) &fmt->program, var, value);
> +		return git_config_pathname((char **) &fmt->program, var, value);
>  	}
>
>  	return 0;
>
> base-commit: a30f80fde927d70950b3b4d1820813480968fb0d
> --
> 2.50.1
