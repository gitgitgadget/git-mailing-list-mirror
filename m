Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07021DF273
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 20:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639901; cv=none; b=ViEtGpZKUyVyx4EfX+O7tPI5Gpj56d7/U1TceLxByz4ZyTgkjaNjchN2G6/NjkTtx1pGHuU83Ugusf3lznWCq7kUHURdo86Jof4rpW8PjlUPxy2/CIUNb0ty1TdyXGKhWu/mH1qOkCmHpzqh9H9IjczREU3mN55tFjDNBWIC9Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639901; c=relaxed/simple;
	bh=bRj8lWytto1ROXv/YU61thhPv9m7t3RaGcAuAu+A31o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZCBSvT67/NqHkVvdJQ8KRmdOyOsWJL4HV+RjwhM0oDk7JWLHbMt8jf56NDvBsTPkdw4qp5J75HW3b5osVEq84/s+PBfXRb3aRB2Z5GMUCPT6xAg1zwsQHk+qC4KOn3fTQdBJp5XX/dtrLzew/4dqL4AB2wNC1w2UKkhbuQEcgAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=suzbqULY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WFb6wYtg; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="suzbqULY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WFb6wYtg"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E2D602540246;
	Mon, 10 Mar 2025 16:51:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Mon, 10 Mar 2025 16:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741639898; x=1741726298; bh=jqYJyDm8/J
	H/DRtueFw72BOTrGvXtC8i8R93GUaLn18=; b=suzbqULYRl5X5jthoEhPxUdYht
	kGKR48Q/TRLLzEkUVvY98DlBzqS5fbOiXWka3pNt6s7cxTlda82i4clhqcLKpXj1
	E+9J6eAzWmuLyhrSx+7hGRuyaVdoIVyfepqZk38U9JxGBrmnmou0w7HLSB2EGMLr
	Ff21wxm1JC/m8G/Q9+NBQ4KQIFEVwZRyJIc2frXjaDrQWW6YL/Y72/mKw8CgdKeF
	59ktn36IqGukCsE18U/UZ9owQxz/ZorjgccT0ykgp8XrhsF7BRNl1fRo4Znn9Zs7
	FPcnFWm6uBuE0cL9c4yNObNLPXAzH49CjAifEgVbsBJWbC+dKJl4k6k9Yz6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741639898; x=1741726298; bh=jqYJyDm8/JH/DRtueFw72BOTrGvXtC8i8R9
	3GUaLn18=; b=WFb6wYtgEONp2Md+xedfDvcnhP+iad/qQIGHlXhvkW/34/fqW7X
	n+/LJUJO2Vqwj0PJiycazmHEeQpwLAIWD3mrzYoDt2YqOha0RV9IiXWGR2OueTzV
	1HRRsjEByBaEtArJRasFfVgv2OvlGC5ekJb0CJfaP9LNMHbAV5QlCwhJQLjJetqe
	axNf2MmdPzIs7zzvpcvYo08iIN7gvwlWohjZ9qXJ7CeNuMW/dwSB0Df1pu5bhX/d
	ecnGe3eSYh5xwE3kT5dnQqCblxkE6hv4V0pStOLZlqgYUqcQwhYuwROoOhwUvo7v
	M1Oj9LjQKzUhiGBHGH2hi8daOmx4mDYE89Q==
X-ME-Sender: <xms:2lDPZzyh6KsxgjrNOKrh5OQLY8Tgg3JSB-fqaNWMCXzCJkBCBxtu3w>
    <xme:2lDPZ7SqLiZ10wzlWOX539nGJIhQ6QIVYpbnaqDpuqzKPMoV8gtidvRYVJSQRJaod
    9cgyfpFLKRS9_lF3g>
X-ME-Received: <xmr:2lDPZ9W-jJz2gR7DLCeL-hbE4_EmmRFjRGk-TG2UK8bdWPnifZ5Q_DpASrQei-6ASCBdku7BlKbfAqKkroib0oZByDhsBA0088ib>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddtfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoheptghhrhhishhtih
    grnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:2lDPZ9gKoAKNwOH0xL6YshzfSFBXEMzeFvbWKZj8qElo80oA7TAxeQ>
    <xmx:2lDPZ1ByRnMxK7c60frQTqzBysQLcO4Tw5ZDM_SsOaT9LGgIdtLesg>
    <xmx:2lDPZ2IoWaKEksFXfZAh_LLwxnSm4AudUK0pF-XSLc1rW0Z7W2SufQ>
    <xmx:2lDPZ0DPM-MjJ31aQ-DbEzHXMNWgvcPcsNkGEejBYFu258Cb4fVRJw>
    <xmx:2lDPZ44ESSITGfVKsrcEPkl8AjY2g_PYxVi0w0HB8-6x977LLPPU567U>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 16:51:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  christian.couder@gmail.com
Subject: Re: [PATCH 1/4] rev-list: inline `show_object_with_name()` in
 `show_object()`
In-Reply-To: <20250310192829.661692-2-jltobler@gmail.com> (Justin Tobler's
	message of "Mon, 10 Mar 2025 14:28:26 -0500")
References: <20250310192829.661692-1-jltobler@gmail.com>
	<20250310192829.661692-2-jltobler@gmail.com>
Date: Mon, 10 Mar 2025 13:51:37 -0700
Message-ID: <xmqqy0xc623q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> The `show_object_with_name()` function only has a single call site.
> Inline call to `show_object_with_name()` in `show_object()` so the
> explicit function can be cleaned up and live closer to where it is used.
> While at it, factor out the code that prints the OID and newline for
> both objects with and without a name. In a subsequent commit,
> `show_object()` is modified to support printing object information in a
> NUL-delimited format.
>
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  builtin/rev-list.c | 13 +++++++++----
>  revision.c         |  8 --------
>  revision.h         |  2 --
>  3 files changed, 9 insertions(+), 14 deletions(-)
>
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index bb26bee0d4..dcd079c16c 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -357,10 +357,15 @@ static void show_object(struct object *obj, const char *name, void *cb_data)
>  		return;
>  	}
>  
> -	if (arg_show_object_names)
> -		show_object_with_name(stdout, obj, name);
> -	else
> -		printf("%s\n", oid_to_hex(&obj->oid));
> +	printf("%s", oid_to_hex(&obj->oid));
> +
> +	if (arg_show_object_names) {
> +		putchar(' ');
> +		for (const char *p = name; *p && *p != '\n'; p++)
> +			putchar(*p);
> +	}
> +
> +	putchar('\n');
>  }

Makes sense.
