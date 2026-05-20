Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF9126290
	for <git@vger.kernel.org>; Wed, 20 May 2026 00:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779235975; cv=none; b=ggAJiFpmCSTghjkdvQgOiuwblefWb1FeMLppmJ1PdBSEJeWnypSIIuyp6IAS2tx74uJb2ZNM535IY6SeLbZULWAc23zAWSnCxqCAK7o/53T9kSfAxpT8rZXT1tV24u8QT6tean50f9FPefQr5fbEQ7UnSRabefSvWjZabcFsTWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779235975; c=relaxed/simple;
	bh=tdWY5arJff/hL45cnrp3bHtrNliw9cTp/F6XSgqzIUo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=UGrwBv/PVR9Dgx3GN7CRbLVqlVAZQbr0x6Namb28xF7Lo1ySb869PlZL3bx959TfIocBJ47t5BvIzWHujjKre8HhV8SA/NlZ9r/VO8KTUSr7iE6fWu7qqdJFOMdFp/+JbBTcwq7fz9UsUbQHbMV0gPnvoXmi2oZ/fH/Ua7N5UZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ffYHPOfu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=puMDIhSY; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ffYHPOfu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="puMDIhSY"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 27CE81D000C3;
	Tue, 19 May 2026 20:12:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 19 May 2026 20:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779235973; x=1779322373; bh=9Czd5CyQc5
	qbxkUA1IariEvcNdTd3qAU5LrnfsjV55k=; b=ffYHPOfuhbxB5zFPDCsraOGnyt
	wjRxOn1dwa3xWwxC1OpQsufegrArdO45ikw7bs5nVjuam41SYnxFTkx0vKbcm0Jj
	USbwmYIP1nrQe2Xt4prdQOTZaDiJXUuX8FhmidYv7KqwcUfXl+QxdEui/JBHiII2
	Gsv+fJubZ4S4CPqfL/3mq3lexmkfH087ZeSDdv8hTBdthgjHtOwyLhQOxLkf5fLP
	XVFQqyvjwzjD6ffUh/A+vU0dzmZBHNQRG8B9GeuxpFiDeeMXPCVciiU82Gv35N40
	c3Nqrbo0iA6/XRQlBm/leM6+KgQ/29RBqzW6bmqtFhQzeSB2Epb60TvVQBZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779235973; x=1779322373; bh=9Czd5CyQc5qbxkUA1IariEvcNdTd3qAU5Lr
	nfsjV55k=; b=puMDIhSY9Cp3M9IcS1tX9Ti3Yohs0gx1V4iVrAG4f34quUJ6b11
	g4Ws5WMFf16lm9iYeIF2oUTsPhJuO4DeHT90+GbpMmOOESp2rHuLsQXDymQzEwQc
	nroyz5gZyidLxi1quGhnI2pxld6jr5bn8e+HaeFHz3GTgr0W+dt+s2V4rrFeFEdT
	7QzKBClSi1MgJi+lOCP6BM/0Txnr4kAwJgsa/Cxd6A0ZIfJE1RX7nSMl9G1dUWu6
	pEUwog4q0mFV7YMIeRsNQybGeWpIGkjLEfGCVatuZTH00TATN2UTkiafemseOAGK
	roeHDxYH20XhYSH+ZQXKyI+79I0KdvpiANw==
X-ME-Sender: <xms:g_wMakMcmeDVSdp-uYUqn6fMEDlzHbG3MdOg8JXzq0TVJN8hxssISQ>
    <xme:g_wMatgaDYvMj-AlBbjFgNBEHbNOMK9GvSxUD2M2mvoqVUWYChdDwJ1u_D9jtkeWc
    kKZKSXU9cq3kDyFrZ-cnFWiFRz3RwfjIGN8JrkZ0nqedPidAPM_cg>
X-ME-Received: <xmr:g_wMau5S8JBFMcx9in4MYtOYVELilKp4kzsyqoPcsGNAC52UoGhsHHMqkNUcZA0T9f3IAOYcw24PK4dI7a1tfi9CIgEO4kvKNWASZb5TJJON>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeefudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufhffjgfkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepteevteehgfevhfdthfduhfetgeefjeekhfelleetueevuedttddthfdvieej
    teelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtg
    homhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehioh
    httghlrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:g_wMas3YyYVlv-cO75c12mYq4nSgHdSe7UtAGHU4YGLJb9yMq5GwWw>
    <xmx:g_wMahutNXTxoips2BWVOxgeuqStTOD5ZpjHOdyaSL1kwVFz3PDZsQ>
    <xmx:g_wMaq6s5sRNUyd5WT2bHHNVEp9xSVe-rvJ_FpAUEe5XjXzcYJyBvw>
    <xmx:g_wMalfWyvKMLtjEs5snWmKv-lWrOny6ERNJdC6Wb1UfjxDEg_468g>
    <xmx:hfwMakf21-S9kdr44PBraToQOmZZbgYnPUsuLS8WnSfJcWEDJm0KCABf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 20:12:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Taylor Blau
 <me@ttaylorr.com>,  Karthik Nayak <karthik.188@gmail.com>,  Elijah Newren
 <newren@gmail.com>,  Toon Claes <toon@iotcl.com>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 4/8] promisor-remote: add 'local_name' to 'struct
 promisor_info'
References: <20260427124108.3524129-1-christian.couder@gmail.com>
	<20260519153808.494105-1-christian.couder@gmail.com>
	<20260519153808.494105-5-christian.couder@gmail.com>
Date: Wed, 20 May 2026 09:12:48 +0900
In-Reply-To: <20260519153808.494105-5-christian.couder@gmail.com> (Christian
	Couder's message of "Tue, 19 May 2026 17:38:04 +0200")
Message-ID: <87a4tvq6pr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

>  struct promisor_info {
> -	const char *name;
> +	const char *name;	/* name the server advertised */
> +	const char *local_name;	/* name used locally (may be auto-generated) */

OK.

> @@ -449,6 +450,7 @@ struct promisor_info {
>  static void promisor_info_free(struct promisor_info *p)
>  {
>  	free((char *)p->name);
> +	free((char *)p->local_name);
>  	free((char *)p->url);
>  	free((char *)p->filter);
>  	free((char *)p->token);

Having to cast away constness is irritating, but to the users of the
struct it may be safer to mark the members const so that they do not
touch them, perhaps.  It is not a new problem with this patch but is
inherited from the existing code, so let's not worry too much about
it.

> +static const char *promisor_info_internal_name(struct promisor_info *p)
> +{
> +	return p->local_name ? p->local_name : p->name;
> +}

Hmph.

> @@ -829,7 +836,7 @@ static bool promisor_store_advertised_fields(struct promisor_info *advertised,
>  {
>  	struct promisor_info *p;
>  	struct string_list_item *item;
> -	const char *remote_name = advertised->name;
> +	const char *remote_name = promisor_info_internal_name(advertised);

Is this really a "remote_name", though?  As ...

> @@ -937,7 +944,8 @@ static void filter_promisor_remote(struct repository *repo,
>  	/* Apply accepted remotes to the stable repo state */
>  	for_each_string_list_item(item, accepted_remotes) {
>  		struct promisor_info *info = item->util;
> -		struct promisor_remote *r = repo_promisor_remote_find(repo, info->name);
> +		const char *local = promisor_info_internal_name(info);

... this name "local" is "the name the thing is locally known to
us", promisor_info_local_name() might be a better name?  I dunno.
I jsut found it odd that the return value of the same function is
stored in variables named "remote" and "local" at the same time ;-)
