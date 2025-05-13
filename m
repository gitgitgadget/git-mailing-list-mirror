Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED4A49620
	for <git@vger.kernel.org>; Tue, 13 May 2025 18:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162250; cv=none; b=F5fhtUvyS1Q4J02Dz5OzFrI3rzIzF4lSXcGeMJVm8WihmRU2tGcfQwqVuG7evc1aNzdX6sBN8TWYP+jIxTaWYvsJFVUTH7hFmL50FUzuwlgKdcmKKjNhyBUkE+H59R8nhuAvOroq+Uk0kFswrgz9ep4g/gMBo/x8peHC5v0efMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162250; c=relaxed/simple;
	bh=g4h4v5OGbx6G7P0lEHHrmbAFGc0obRpmgkCKIsCNdkA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PoXLolH5Ue1dNLa8C/vTnp7RMIn+Vv87pz990Y22UxE3a2Tp2JwArVDgfwr9zNr0TxDb2Z0CJjVhyagTH2vXcC5hmT5jtLLjo9ONWMyiL8MoBvQ0yhbNjCE1C08BSTCVCq1vPUr4A1WOtH6AhQ1v7HfE/h/kW7MeQ/8cVrPDFCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Btvv+RBm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MW+2xjg4; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Btvv+RBm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MW+2xjg4"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 0E86B1380155;
	Tue, 13 May 2025 14:50:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 13 May 2025 14:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747162247; x=1747248647; bh=4MIGM0Kh8F
	1CfnZdENs3pgB773l5wZPtAfndM+W33+4=; b=Btvv+RBmD8KqU2icO0QYbkgi9Q
	xVpLV7Rx8c6BBcKCvjAkZivaCms0o6vT6CtyZxVpe5tbAlSCWyMj7FtCSNL9Ior+
	mV+LYbH19a/8wFp1KVTCtDubjxSLnodZIUtIAjyTKyhha2n9o1aveQpJz2J+l5JN
	mR7jCL4rtzdYf2rA2nEjBWZ3rCSbe5x8XxNsFcd7fzq5p3eJ98J4tTN6QzIXJHVs
	s1Kf5hdL/s7iijXazST/YYYrzKreHzB5iNY8b42LzkPUzLL/jZp+tdvzCRh19GWU
	470cRrC6zDCAcqIsJrhc78wGY5K96ogX9W3ZShYacFvFd2khYRYYFI24q1Pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747162247; x=1747248647; bh=4MIGM0Kh8F1CfnZdENs3pgB773l5wZPtAfn
	dM+W33+4=; b=MW+2xjg4p2iGhFg0+695VwkWINDGWU4A1SfYhLqd6zezpqxmwCa
	t2w0iVtPuxuyIHD7C53uuSPGyX2hGR43966tegEIvRsI3maeE+3u0UUkREQXqA5a
	Iie/j/nSiH7dkhOIhgPL/OJcs9V6X43jmfZPVRnZiUXVR5DJnvrxNcpILY3cFsCi
	Cbu58KLu6ukzAcxlM4hqGXqzB6eTtmCKuNtsK0cX8o4M3suqbf1nidak+SFOD0Ad
	VeSUk2lRWr1f/1TIyXU3IcVGlXi+mtqy1gYwys42efzyCJsa2FFyqryn5vRXChyi
	aPVStdRH60p0wD3IcwTv6mfZxiAWvhlb9+g==
X-ME-Sender: <xms:hpQjaFIPIMJNBo72VlMcM-zD9C30JAnBCpCCuFWxyjLTMpRZCjddfg>
    <xme:hpQjaBJO-PjW4TO7NNvKqb4nW47NDkb2bylGR_caGzCrdS4_okzlmK3IZt6NQs441
    6gyyqh9c4rY7Xk6Og>
X-ME-Received: <xmr:hpQjaNvB1aP4E8K-Ued9SpEC1XcBDLMeuQJJZEL_-6pHPtExFNCm9QocAkF_92JI-_-xGv1J9asmuCYDy6evUKoibfSEa-728p8FkCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdegkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepughhrghrieduhe
    elheesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepshhunh
    hshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:hpQjaGa49bKfUjH-n7N8ZSN7YXdAlG7J48fD6xyIYbzQJL3jIQ_vRg>
    <xmx:hpQjaMbrlqT_wVtcmAoexKpxHGAaNC0jB4Hdskd-Kp0QC-71PAWyVA>
    <xmx:hpQjaKDjhDtui3Fgmbdru5ok004tBiRSJTrjgVtkvqLf5VOYzj_7Xg>
    <xmx:hpQjaKY8NMbpcPWNwa9b88rEFZlHagPuODB-uG-4rxzbmSw3TW4YFg>
    <xmx:h5QjaOpKoaV2aK7Fu0wwgAk4WyWu0W-UMKknIpesQnXKvYG71g3ZyPtP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 May 2025 14:50:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Moumita <dhar61595@gmail.com>
Cc: git@vger.kernel.org,  "Johannes Sixt" <j6t@kdbg.org>,  "Eric Sunshine"
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 1/1] userdiff: extend Bash pattern to cover more
 shell function forms
In-Reply-To: <20250511141101.18450-2-dhar61595@gmail.com> (Moumita's message
	of "Sun, 11 May 2025 19:41:01 +0530")
References: <20250511125809.14180-1-dhar61595@gmail.com>
	<20250511141101.18450-1-dhar61595@gmail.com>
	<20250511141101.18450-2-dhar61595@gmail.com>
Date: Tue, 13 May 2025 11:50:44 -0700
Message-ID: <xmqqv7q4fipn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Moumita <dhar61595@gmail.com> writes:

> diff --git a/t/t4018/bash-posix-style-multiline-function b/t/t4018/bash-posix-style-multiline-function
> new file mode 100644
> index 0000000000..cc8727cbcd
> --- /dev/null
> +++ b/t/t4018/bash-posix-style-multiline-function
> @@ -0,0 +1,4 @@
> +RIGHT() \
> +{
> +    ChangeMe
> +}

Not a review, but I am curious what this test is about.  Is it to
ensure that the pattern does not get confused with the backslash
that does not have to be (but it would not hurt to have one) there?

IOW, does

	RIGHT()
	{
		ChangeMe
	}

get processed just fine, and the above is to check the corner case
where an unusual "\" on the same line as RIGHT does not break the
funcline identification?

Thanks.
