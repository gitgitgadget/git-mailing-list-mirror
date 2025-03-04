Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507072512C3
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 18:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741111520; cv=none; b=tTgvsHopoKcIb+BaerzBE38H5YF9Abz6hX/c7cuQ8MiErYfcMPX0bH/c1vX/To/Uejfzywhi3swh5WLknw/e+DF0+SJRkv9E9Vxn6wa/sJjRPoDLYoERB70WIFYchv3aCyzEc7t1WSGEbAJSMBESp8vjVe8RvQiFx7aM2RSrV/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741111520; c=relaxed/simple;
	bh=JZJQkwuRsIEKI0ZT6OX7U5ra9pV3qkHHdDQNe6zVRXQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c5HQ8w+A0KzrFM2ChFlTqeW4TR69LrsFA+QOcxD6Td373sSMmWegdXrsHvXdFvh8gsNRhQLnt8xV7r40xSXFEIhIFK7g1JFMijS5HKLO6c+0ycN3znahZWrDjx/WVMBZL0iOEKuzmPe/Bue4PeP+d6CBA+DEuRofkj6VLIX8N2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HdIy5HiQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AIRnT3TO; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HdIy5HiQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AIRnT3TO"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 516B5138276C;
	Tue,  4 Mar 2025 13:05:17 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 04 Mar 2025 13:05:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741111517; x=1741197917; bh=3G2ykG5qDW
	a/AKOTZcuFmOf5Dl4/ST8olcrW1XnEjgQ=; b=HdIy5HiQ2MoZX/qEw9aD5cfpYW
	e8+rU0gxM3IyIDH8zZPaHDZ0vWdtxgWrWm/aP7oi99LQqF9C38KTg6T8iqRyo2/P
	HtLRxsj+ThZDnQHKGrpb8ZXWq18698XWO13C1NWqMmkXc3/J0/4VDCKet9O7RYcs
	gLbCld8+J2BQAcd8wIrbh3Issy/b4gv71a3d319HYyN4PNHBuPSnDqOtx26WyL2m
	nXANg9B+dDpscBP61dHFYvFQw38S2NcsDVTyd+tyxgfjRau8wmNX62J0yKnZtHDi
	d9c8nhDoc0NXK/AcvG76tjQy140t0XrEk5vD60/tEZoZvGgbCYr+MJIS+Z1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741111517; x=1741197917; bh=3G2ykG5qDWa/AKOTZcuFmOf5Dl4/ST8olcr
	W1XnEjgQ=; b=AIRnT3TOLPwyFwGgtq0lkFmmPOjAk4Htqi41vJ1qaGSLyCHcWor
	2z353iER4dI9m2O8E+vN93zRya3xWl5rQQmBdTZ6jTyv1TWBDnDUZ5dkOqwBEudx
	5KN1ToX8auVUm5N7rss4tVQEU+9BEXd75LkRQuDK2veX7gzNTBwLLOdyznGY5PCB
	Ef+aJaNw9F1myJCbDkBoPizeW31X4MnmTXvUhI8zEc3gVXA6kyXJ9ploQAM51jBe
	uUJtrgNM9WgJ/9YOAb9CSlXZl/AS76xWz5UESQonChsdHQjN7ThYoqtSLA5vfAMj
	1rP1RC1p0DOMuxUNjS3bKZr4u3cKsyc5yww==
X-ME-Sender: <xms:3UDHZ6ZMg2lBzp13YKdnrv1JeiNWEU3gXgsXLkEs-29ihQiqPSGzJA>
    <xme:3UDHZ9biwsgTynf0cCXS6Xyad1NgdfPxFcpbYMdavSRSi1z6TjKeynpDf1zpj5u0e
    HT7KytFh19flOBYVQ>
X-ME-Received: <xmr:3UDHZ08xbzuwbVe0GZPu0Wf_G2r6HCQWbxjBVWyZpTt_peohw4DhP0bUV9JuRb-Ubp-joNaX8otPmtAAkVCMKgcjuXYGl7BrhANp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddvjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnhhimhgrhh
    gvnhgurhgrtdeltdegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:3UDHZ8pkXHDv0vIsKGd8RyLgArac47iCkE0EznzXtvN3qGv77mGQEw>
    <xmx:3UDHZ1oqYCzCVYDap6K0CLE7jFAQ4Ie9Sluy8yzIvUBoAHo_zS_byg>
    <xmx:3UDHZ6SA3eLPOdUuLudGaHRkh1tVyBjgCWhBTWqEeuXVHmesnpQ6jw>
    <xmx:3UDHZ1qvsNsrr04ofQ_LwN1J9tTtOdg2Qh-GCk33ATE-B3J7qW9iUQ>
    <xmx:3UDHZ8XWzyraOWPC-5RBKmtHo9aaturLOZACUET24eJ2raGg_6IO4XtA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 13:05:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Mahendra Dani <danimahendra0904@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 1/1] t1403: verify that path exists and is a file
In-Reply-To: <20250304094153.28959-2-danimahendra0904@gmail.com> (Mahendra
	Dani's message of "Tue, 4 Mar 2025 15:11:53 +0530")
References: <20250304091556.22478-1-danimahendra0904@gmail.com>
	<20250304094153.28959-1-danimahendra0904@gmail.com>
	<20250304094153.28959-2-danimahendra0904@gmail.com>
Date: Tue, 04 Mar 2025 10:05:15 -0800
Message-ID: <xmqqv7sopt7o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mahendra Dani <danimahendra0904@gmail.com> writes:

> test -e does not provide a nice error message when
> we hit test failures, so use test_path_exists() instead
> and verify that if the path exists then it is a file using test_path_is_file().
>
> Signed-off-by: Mahendra Dani <danimahendra0904@gmail.com>
> ---
>  t/t1403-show-ref.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
> index 9d698b3cc3..4afde01a29 100755
> --- a/t/t1403-show-ref.sh
> +++ b/t/t1403-show-ref.sh
> @@ -196,7 +196,8 @@ test_expect_success 'show-ref --verify with dangling ref' '
>  
>  	remove_object() {
>  		file=$(sha1_file "$*") &&
> -		test -e "$file" &&
> +		test_path_exists "$file" &&
> +		test_path_is_file "$file" &&
>  		rm -f "$file"
>  	} &&

Makes sense.  Will queue.
