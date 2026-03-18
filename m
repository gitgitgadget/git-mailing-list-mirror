Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A01401A28
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851237; cv=none; b=m51Avr/+c/UDlceJOXGY/RtR1MjTbH+Oy7wJmqx2OqKbgfdzVGfjA1Df3C/lRWsXCkFnxp9uEBub9POuzA8WVXx7Bfp9ndM2x6Za1C1mieKCVFg3JxkNhMMxSrR4xjkkBrs55OsU678GTmDjmxHVaiBn8d87F/R6rtofyarQTno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851237; c=relaxed/simple;
	bh=4sqAqsUXPUOVJIUv1POIl6OEfLsBzHJslCygTjqHerc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hAmSgVuISnG2kGnpqxjbSNvbSd7y0Lkj3Ao+cMaM4kx0ckEwRkMBzg82EMxciZsmCV8LYbirnPzmasyQfz4veq1MOubjjaBS3a8pcUOm4kuhV/lWCXiEQnOGmDP+1jdhBqPBFI1pJmPvqXws4A7sxPSBEfLN6+O0yhSBXckb0gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZoxOsDEQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MOxhh47D; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZoxOsDEQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MOxhh47D"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 988081400274;
	Wed, 18 Mar 2026 12:27:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 18 Mar 2026 12:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773851230; x=1773937630; bh=HiELQ1lYyU
	47AYPMsloSjnt8tt8CgzqqGmQ+rQNiUDw=; b=ZoxOsDEQ/kJmzTj4tHaGzZTqSF
	o6gPWULt+jVPR0w3FS/tlyJ6vxzZrRJB0cQmWNvv58S1QFI0rL+v1cq1ptX0Q+dW
	tJzQrwdKjRWFb8sPsgchsKaPqxCO3jsadD2sKF1HB/wJdEQTUbAU17Lbwy0onon6
	frGA5wEAaGzp7dDjDv+SWQlRa7qfeqv1s0e+m8veNxM1SvQL/31++z797XB9pvbH
	JMy7sm7k5TqhjwrFDguiep8Zd8m+2gXPJCJUA7re8jaADsVFQcuME9tbfhfv/JyD
	9bbXFefWqx75PfFkrkDXOxJZS6ausF9QaGFqhvSrNTJZPyEn9ZM9oSow+CXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773851230; x=1773937630; bh=HiELQ1lYyU47AYPMsloSjnt8tt8CgzqqGmQ
	+rQNiUDw=; b=MOxhh47Df63fv0TNe+Owyhon28htMrS8CDnhpZ+ca47PZ9xYQqR
	OHS9TB9n4uQIKnqyxo6epo6Nbb3V+v/6/bnBo+PxhDAAfnp5YPybCjIMJrwIfek3
	lt+7JfxMaATgKductlSqkTRuJXhBLav82aJ6HZmkVL7+YWT+zkTFQzSdSc2XjS8K
	FocBEfJ5quPsjpHSq8euIEUqjDfoFus3FHIygX6Ek+jyYvVQC2YOhAuGo0y7RfRo
	lnmFdr8jArEyvK64JsOPchDZbifqjRKXDkunamxHM8Ps7iFpUVoXPx2ulviuaMGV
	oZuyRIspBEdFID58qTt4k7Ze5oDcnj3OB/Q==
X-ME-Sender: <xms:XtK6aSqMrYL3ImsHXXYxoKgNxH6Unw80Q4M5AltLLLzm2geef0KuGA>
    <xme:XtK6aXoquZU0WK83psTsFJv8QgzYR7hPIxiwt1oTZeSdO_xjWv-ezJJyLmo9hRMao
    nm0x6G0rt1T-MjyLZZYnE-YTwRA1YSmXSL6S_62HHtyebtHHwn8ccc>
X-ME-Received: <xmr:XtK6acO_Yn4rGHK1Po9DXGDZ3JdW9mGAtqJDgMD1S1PE9fv-DXpUPbEZIzULltp7EILyj-SS7hGbyOid1CX8J_2qhxKHXjwLWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdegiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhgvrhhrhiifrghnghdukeefseihrghhohhordgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:XtK6aQzmOEOZKfdIM8MmwHAdnPez31i3K3Npi2HqvO6i3dTkHj-bPQ>
    <xmx:XtK6advwOeZ-8_g_q5EwqQcFZt_deZStQIc-Sgi1DhO7JNViQM9VJg>
    <xmx:XtK6aR6dilfzisSJ7KSXGV5nbMgAVjY3rTP4ZrnK11cjGHGZV6jIAg>
    <xmx:XtK6aUTtwDIj7POZHpexpSCzQGXhKNO7rKcK0A4-KjS0ctXIFTE9CQ>
    <xmx:XtK6aSPGrVIcK_kFW8i8rdEFWa0HcRaL6nOiBt1otDrZ_OnjHdGzfldv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 12:27:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jialong Wang <jerrywang183@yahoo.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com
Subject: Re: [GSoC PATCH] object-name: turn INTERPRET_BRANCH_* constants
 into enum values
In-Reply-To: <20260318003917.84792-1-jerrywang183@yahoo.com> (Jialong Wang's
	message of "Tue, 17 Mar 2026 20:39:17 -0400")
References: <20260318003917.84792-1-jerrywang183.ref@yahoo.com>
	<20260318003917.84792-1-jerrywang183@yahoo.com>
Date: Wed, 18 Mar 2026 09:27:09 -0700
Message-ID: <xmqqjyv9gl2a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jialong Wang <jerrywang183@yahoo.com> writes:

> Replace the INTERPRET_BRANCH_* preprocessor constants with enum values and use the enum type where these flags are stored or passed around.
>
> This keeps the existing bitmask semantics, but gives the branch-name interpretation flags a dedicated type instead of plain unsigned values.
> ---

Overlong lines without sign-off.

> @@ -1660,7 +1660,8 @@ static int interpret_empty_at(const char *name, int namelen, int len, struct str
>  
>  static int reinterpret(struct repository *r,
>  		       const char *name, int namelen, int len,
> -		       struct strbuf *buf, unsigned allowed)
> +		       struct strbuf *buf,
> +		       enum interpret_branch_name_allowed allowed)
>  {
>  	/* we have extra data, which might need further processing */
>  	struct strbuf tmp = STRBUF_INIT;
> @@ -1692,7 +1693,9 @@ static void set_shortened_ref(struct repository *r, struct strbuf *buf, const ch
>  	free(s);
>  }
>  
> -static int branch_interpret_allowed(const char *refname, unsigned allowed)
> +static int branch_interpret_allowed(
> +	const char *refname,
> +	enum interpret_branch_name_allowed allowed)

A funny way to wrap lines.  Use what you have in the previous hunk
as a template, perhaps?

> +enum interpret_branch_name_allowed {
> +	INTERPRET_BRANCH_LOCAL = (1 << 0),
> +	INTERPRET_BRANCH_REMOTE = (1 << 1),
> +	INTERPRET_BRANCH_HEAD = (1 << 2),
> +};

I do not think "allowed" matches what this set represents.

The way "reinterpret" uses a parameter of this type (or the bitmask)
is to specify which _kind_ of branches are _allowed_ to be considered
for its output.  The bitset is used to specify the KIND that are
ALLOWED.  The type should identify itself as representing the kinds
of branches, while the parameter name should reflect what these
kinds are telling the function to do (i.e., allowed).

I'd name it "enum interpret_branch_kind" or somehing, if I were
doing this patch.  If the type can stay private to a single C file,
we may want to even lose "interpret_" prefix, but I do not think
that is the case.

By the way, in the longer term, the set may even want to be possibly
unified with what "git branch --list [--remote | --all]" internally
uses.  At that point it might even become shorter set that looks
like

	enum branch_kind {
		BRANCH_LOCAL, BRANCH_REMOTE, BRANCH_HEAD,
	};

or "enum ref_kind" that also covers different ref hierarchies like
"tags" and "notes".

Needless to say, I do *NOT* want you to be doing this as part of
this patch; I do *NOT* want you to drop INTERPRET_ prefix from the
names of enum elements in this patch, either.
