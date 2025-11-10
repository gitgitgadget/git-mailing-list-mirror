Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863A723D7C8
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 07:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762760076; cv=none; b=fNGz+UioPdN0qc9KDia7M7f8sJE4iXE7Eg6zyDVULKLS+1AaE5IKEOPtPfAqvYQ69qCOPYhNUIAXB27+UoLdBsRdk2d6Yuz7KYgAaHoJb7Ov11nERoprnk4/9al1BFpAAVKkWL2jvzkL8vIVAb/3yFArQDc/RXt+IoBwwwmLsks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762760076; c=relaxed/simple;
	bh=dwLaLQf4OOU9e2J3x8+bCwAsu9CptMb0eEPQngzGiZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLqtUekLngHOIZ+IFhV/5mEIJ+RAP1QJHx0Hye8KHrfRp8T+3vXyx76yKp9OlmljPGv0kEiTJqPVPYG/17iqXC0Tgojm/qcAsl0FqylWppbAYqZHxGOzFhw4pVGNCw46E6DFM88ZflvEzE2EEo5J2TgmF14FaXKERZsJ0YCzOPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GsBP7rmI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BHW+9Mdf; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GsBP7rmI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BHW+9Mdf"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id A17C31D0018D;
	Mon, 10 Nov 2025 02:34:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 10 Nov 2025 02:34:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1762760073; x=1762846473; bh=397RqVodJU
	HAka5KLcO/ZX+oOXdCcQokbrsql15UzSg=; b=GsBP7rmIVd7ivNXmTfMeXsanyG
	YnWOE0VS0dmgmbiBoyDO8Hm6MmVKgWE3PODI3mUgmCzZh/usXnOAn3pHr8OEOnbz
	X7zm/zssLVSAjj7EwsuJNc809sy42xMeB8l68e8cUbn63h6c1+RkAGmymMqKetid
	UpV2MtdfJsWl4jRtAJ/cdIxlU3EQAF3GbG4r5SV2057Y4RB9Nxx9Er/FdMMtfxAx
	kqQSoHLKxAOYJvJ8e7Xo6V6D2VF3AcbO5bWlQYia//6zCNlUeWy2CNRAl1ftOZgB
	8SFoV7jT0lmBB5x6V/RpWu/3Ot5WdFGhfqAsTxrAW6rPQVl0zIDhHczkt20w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762760073; x=1762846473; bh=397RqVodJUHAka5KLcO/ZX+oOXdCcQokbrs
	ql15UzSg=; b=BHW+9MdffDzFXgSeBEatVPj5T1njwEdeLNc4USW6EIGaUMrJR5J
	yqZx069fpwiRKGsrSYuq19M0BY5PPrieZoyboUVdQ+Fp8OPVTdiH/C0Vh3UUUtgM
	D7JlclEnekiiZic7oElu+4kBR33pf8AJK3m8pAuyH9esmOudpGrDx+RLg0/C6NI3
	3tDcniJvmXfr08qgE0B4En4LbWBuczHSAkNs+Ah/fmewx40W/2DutP+lPG865jwv
	blUbE1507EepLy8CDh7lOfQABWO9D8EYMQ0upkAJLzRZszB4hyWwy0rtk6LFdJRl
	DAOwJoLJKvhUA+W2ae0WlFL1eCgwukXz6jA==
X-ME-Sender: <xms:iZURaY6XbNh4u9clM_fNKPfaPSicaYIUYNT3423wk0N5_g0SQ04-9g>
    <xme:iZURaVauYDT03xcHIh3rPxVOt2DNV1dYpfZiwdf9r_TQRnLdyRkliSWo_z1jwtcXU
    ukY-RZWZf-HjDhaPlvVkE-gVcLGcEHRlp0N1gnAs6prM1BTeCUdGA>
X-ME-Received: <xmr:iZURad6otPrbwQJgsNpWFSAx7jsJX4j3GAknbpxOULyUuwWJsZ7avI0gMQjSAazV1bLItmMG5FrbhKrdQ-1gbTwurUHhaKPPAqNT5AP3AA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleejjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:iZURaYAXYXSZ_koiLR0CWWY9A7AYb12uZJyAA4XbouUujTU_SRNhRg>
    <xmx:iZURaTdbcHZkPWuvqgV-eOvTQ71A-53QRKCUZZXFrB9JW960IbCrDw>
    <xmx:iZURaXKIt365oHOY75MDweEHdZPxam6yWki5g7uSbe7d0RwJNAb7Vw>
    <xmx:iZURae3FRHUVqrrnWUOuB-mDqOGVesiJ1repuYF2SfgS1ifpgpxo_A>
    <xmx:iZURaZdsxzFpg5M3kU448mOrJXY7_Je1deijsC_a2NkYqcTCbHHAIgPR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 02:34:32 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 396733e4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 10 Nov 2025 07:34:31 +0000 (UTC)
Date: Mon, 10 Nov 2025 08:34:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, sunshine@sunshineco.com,
	gitster@pobox.com
Subject: Re: [PATCH v3 1/2] fetch: extract out reference committing logic
Message-ID: <aRGVhA4eXnAFxvqE@pks.im>
References: <20251108-fix-tags-not-fetching-v3-0-a12ab6c4daef@gmail.com>
 <20251108-fix-tags-not-fetching-v3-1-a12ab6c4daef@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251108-fix-tags-not-fetching-v3-1-a12ab6c4daef@gmail.com>

On Sat, Nov 08, 2025 at 10:34:43PM +0100, Karthik Nayak wrote:
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index c7ff3480fb..49e195199e 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1686,6 +1686,42 @@ static void ref_transaction_rejection_handler(const char *refname,
>  	*data->retcode = 1;
>  }
>  
> +/*
> + * Commit the reference transaction. If it isn't an atomic transaction, handle
> + * rejected updates as part of using batched updates.
> + */
> +static int commit_ref_transaction(struct ref_transaction **transaction,
> +				  bool is_atomic, const char *remote_name,
> +				  struct strbuf *err)
> +{
> +	int retcode = ref_transaction_commit(*transaction, err);
> +	if (retcode) {
> +		/*
> +		 * Explicitly handle transaction cleanup to avoid
> +		 * aborting an already closed transaction.
> +		 */
> +		ref_transaction_free(*transaction);
> +		*transaction = NULL;
> +	}
> +
> +	if (*transaction && !is_atomic) {

This condition is somewhat weird, as we know that it won't ever execute
if `retcode` is non-zero. So wouldn't the function be way easier to
follow if you turned the above conditional into a `goto out`?

	static int commit_ref_transaction(struct ref_transaction **transaction,
					  bool is_atomic, const char *remote_name,
					  struct strbuf *err)
	{
		int retcode;

		retcode = ref_transaction_commit(*transaction, err);
		if (retcode)
			goto out;

		if (!is_atomic) {
			struct ref_rejection_data data = {
				.conflict_msg_shown = 0,
				.remote_name = remote_name,
				.retcode = &retcode,
			};

			ref_transaction_for_each_rejected_update(*transaction,
								 ref_transaction_rejection_handler,
								 &data);
		}

out:
		ref_transaction_free(*transaction);
		*transaction = NULL;
		return retcode;
	}

This feels significantly easier to read to me.

Patrick
