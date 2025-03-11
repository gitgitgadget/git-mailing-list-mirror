Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CD21E7C06
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 22:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741731188; cv=none; b=ida06zeUnfI2z9cpM+MXGK3cx1IQT4Z6hNeAqcXzJsY0TFjvfS2XckqE6J2ZWo7fX/D36dGKuBKgJAeSrsx9C8hOyADOXfrt3B0CL4ffaumgDWUFUPRFOQoQKNHiyKBZi16TXtmS9Yg5biq2w63ppwd+jQbKPNaIOy3u5D0C9I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741731188; c=relaxed/simple;
	bh=60KoQc9FLigCPYn4r5mF/9VFrxBzdBbUpfilYbmhcos=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QHvgPUh2006TueyULt2DwlAjscGscW8A9TNc/dlyqcLk4Mh7GbBFGhR0ycGuqZlIXsoPxRhF5MWtPcO2zU8tOj9hG8oofhKN2mE1gBvk7zcrKzkEe/eCXPxETFVmOQmnRhQ1ON+JD6SjbjYNQRiWL5gik6ZLrW4oq7gga98RQAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=a0J0GQw1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vsifmx8v; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="a0J0GQw1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vsifmx8v"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E28AC1140292;
	Tue, 11 Mar 2025 18:13:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 11 Mar 2025 18:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741731185; x=1741817585; bh=51SLEzvOgS
	kXr/QkND1pmFcEDNi76T+V7cvPvwXO0jg=; b=a0J0GQw12pl8JD8oelKmKm3sSK
	OVSRqrDAfHJWh5KXE70bd/WZ97KvvhH8BP3jP/Ko2LRxOV8b7K3JDH5T/0BOOvrE
	X1kAq97xWLfTzKuHDbk8qhrSKeC3qPuDd34Cw0z1X3vRc/fm42uXgacCW1VSZsIj
	kXCe/4r1XO8/F+jXH8/BRcDZimHn2fyyCylZ13hNq8zgaGrKANEfmEX6gVI9XFvm
	sSbQhGnrKhxxhrfU5iV69yI86wyxH5BytfAvjbRa1qRBHQadG5v+WdUHKqf63WSO
	VOy2jabggzE9ZJFeOTPmzpE4TXdn+0bqGCh3w9R6uRqMjgLUrqyQAziXD+Lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741731185; x=1741817585; bh=51SLEzvOgSkXr/QkND1pmFcEDNi76T+V7cv
	PvwXO0jg=; b=Vsifmx8vHwkBR+LrQWFx2vgLWkNVD603y2gGl0zcnQmI4PXRGoZ
	xByHJXQHlfPQccd5JlxAlCk4w/lxBb/VxQU7fxt0Bab0QkCPO037IM7dm1eEyg9/
	lxCWdN38pGmRr8EOK8AaS/KDbx63etGcwoP6WfzQHxGzg5gJ6p9+TQcxrdOEF3Pj
	NMqpi9ujrG3FcirCeO+7jrBDf2a7B28TsAyG70W0wjW7B6RBpMRq62XnfZX98fxc
	mldWvSq2kNCeUSTayl9nlkWnlNNwPuzIZgm7F94gg13LufG8jBQllxne7ambRx+W
	DFOiriKAZjCVkVHwtPMAhygP4ucwGeztL0w==
X-ME-Sender: <xms:cbXQZzkgViRqp7oRYxEkOhFTm_QAWhsqrjW1D6_90IbPrtHdHmvPcQ>
    <xme:cbXQZ20KIURbcVI30KwfVQrLGrYC3WKja14ERhxlTOfivoC98cMt4-Wywm35PvPnO
    0JGrvJ-oPUAw038OA>
X-ME-Received: <xmr:cbXQZ5q2S8uCQGpUbklH-_VLWMtjkW1s8JUAZhhkQjo0PrNUV2GPuRVMWh130YbG0ecaItTx98r_WdAdP4LJoCdQhQE3nJjrjBJG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdeffeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegrsghhihhjvggvthhsihhnghhhrdhgihhthhhusg
    esghhmrghilhdrtghomhdprhgtphhtthhopegrsghhihhjvggvthdtgedtgedtfeesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:cbXQZ7mHJrw_hk57kAnhgNBPhJIbq_cxKlhKGFcLkpyN0GYFWNS8xA>
    <xmx:cbXQZx3EJ4Pa3qwKFjsqPailhrNm4FDplYshtWwmLid9WbH77TkjQA>
    <xmx:cbXQZ6sqwwNihT4tQLJiFCY7MV5gTOHCV3eKLmQZHhUaoWpBKT-1pQ>
    <xmx:cbXQZ1VesAT89GHRf3Xih2O0FajoT42VNVqUA_U2KrV_gcdLeoRikA>
    <xmx:cbXQZ5-7tXOXN_kFq-v1mQVwS0EHePAN7GDK-fUPm9WDnFOIV93UitcS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Mar 2025 18:13:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Abhijeetsingh Meena via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Abhijeetsingh Meena
 <abhijeetsingh.github@gmail.com>,  Abhijeetsingh Meena
 <abhijeet040403@gmail.com>
Subject: Re: [PATCH] dir.h: remove duplicate forward declaration of struct
 repository
In-Reply-To: <pull.1879.git.1741705175922.gitgitgadget@gmail.com>
	(Abhijeetsingh Meena via GitGitGadget's message of "Tue, 11 Mar 2025
	14:59:35 +0000")
References: <pull.1879.git.1741705175922.gitgitgadget@gmail.com>
Date: Tue, 11 Mar 2025 15:13:04 -0700
Message-ID: <xmqqecz32p3j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Abhijeetsingh Meena via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Abhijeetsingh Meena <abhijeet040403@gmail.com>
>
> The `struct repository;` forward declaration appears twice in `dir.h`:
> once at line 10 and again at line 46. This duplication is unnecessary
> and likely unintentional.
>
> Removing the second declaration has no impact on compilation, as verified
> by a clean build.
>
> Signed-off-by: Abhijeetsingh Meena <abhijeet040403@gmail.com>
> ---

Thanks.  Will apply.

>  dir.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/dir.h b/dir.h
> index a3a2f00f5d9..e659c47ad77 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -43,7 +43,6 @@ struct repository;
>   *
>   */
>  
> -struct repository;
>  
>  struct dir_entry {
>  	unsigned int len;
>
> base-commit: ef8ce8f3d4344fd3af049c17eeba5cd20d98b69f
