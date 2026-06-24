Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D751A3165
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 18:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782326128; cv=none; b=IcOy4ikpGO9mtwsaMkkChwgyfQKeAQrJ/Z5zBneWEAuRfRMwqs3ZxQKimX1bXT9pT5zwbO1B+PM1mCAO7MGoVVEZ/uump1LLYw/Vop5dNVXff5yAMJ2uDi6Wfe4e9GX+wBmDkTsEizU+36tvrH8TFlvk1EPmseioRLmbF/1xa80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782326128; c=relaxed/simple;
	bh=tNPKrou0f8kw6OmSGVoLD3NcRfBoqdB1RVUmtcSCanY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OgwiuC4L4W2e28geHSWt7YvkP1YZaEHhrYIkp2W1t+ehdkhW+G8LCKoQjwjgmjxALQfYAPUhXDXU14aJlPnpgO0URHsbMfCQe1aQPoGd7mR7zTxQg1fcyoaTtsmbVE1mtdKIgu1r3jWY8P69sYl31LxCCVE5+C9+uEWOE7pK4wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kP8isDcS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AOtSYACv; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kP8isDcS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AOtSYACv"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 903AD1D000EC;
	Wed, 24 Jun 2026 14:35:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 24 Jun 2026 14:35:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782326126; x=1782412526; bh=dBISq3SowV
	P1xf8zVUnwz7Hjrv+LEGMVC5dTvpGf5/g=; b=kP8isDcSixjWHJbpB5kgztHRK2
	ZNLygvLZ2n8fTntFLDlS1hhNr8MDyZ/TSQS9Q1F83sTgRqxO2bw9HIWaLYi3zCdT
	Kw9aWS7MOCGKhGMpdwyI8I3zE54p70dnYeEXdACQ9kWZpM5oxMU+zDyuUhFoy7Fa
	Obc+JbkwdsTYojTJ2QB2zo8oCZenPG3ClXHID/nqalE5q//8qKfNTrkmHnkGJByJ
	XJ23n7TYZ5k6B4di6aNDrbM9ZiBGmhUjD8bjW/SJaZx0aWn/Wg3ZQaX9ZQuJoSfL
	U8Jb5azV2NA+KtCpiZ6NBqLGpugdTBlSY0JS6/LbPCiTQlRGQvtoX8oX7t8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782326126; x=1782412526; bh=dBISq3SowVP1xf8zVUnwz7Hjrv+LEGMVC5d
	TvpGf5/g=; b=AOtSYACvYrR2uD3vBihnThA55OslW5dgrHabsO8g5wzjvucdk00
	k1L4u9MIPpX3k3R2/lwUj/eYebsEHXyT65xzMqIc4bFe7kBVzpWNHIolPP+DPWDu
	zDeoGVxuL1WzWaKpyV0mZ2oKf/HcqXK+IjDcCkE04W/g1cEN4uqMM4MI/xE+6702
	K2NpQF5aD5LaNQEk1PzJ/fns/eBnQbOGddZjIOZbXzXFRAIah9FdBiKyXDSpS1/H
	22YwXZDRy6UQbrb51shSyRwmAj9y9Ww3pDP2K/sOKRj5uHxU64KHsfrLwgbByjnG
	Fi2zXFzoavQgeWGjHmozAtLaK6FcHLivqrg==
X-ME-Sender: <xms:biM8agCjEVSvIpErWXd0ubqkRVCRMc1W6_lxY_uoxV5n2NJcfhpokw>
    <xme:biM8apgnI0sbGdEtW0taihEI1RIESZqI0JChRycIzIakafy8NQSG4ZAcLGVUroQ24
    IsDWdeYKUe3JLZwofBtqJK4ZDueqZqIRTDJGrjKMb0-7H30FIwt3DQ>
X-ME-Received: <xmr:biM8aol5lFEZkh8rrfAEmRv0XPJYufjsF34lLahVl-49S9ZhLypg_GPL14p7pQYXkmJOf8UKorT2T1R23-6V7wf_M37U1CIXBx8UmCM>
X-ME-Proxy-Cause: dmFkZTFabFa/F7TmEwOxCS4b6QQWjGHrqXgm9/VAerB+biA6Ji56eZHVdXarVAkoR7GHLo
    l08MPyG5ymakfawQfjdg3AOXv/mm/DZkOC/A0gr56Sj8Si3Z6hLUxiLs+ZHh2LoveFLQQG
    nRvWJIN+ShfLoQIBkz0GfaLP14baHI1kYkmulSaiHXrpNN0yDnNDeQduTmCEgujdZiVH6t
    CaKmrjcB+L8yl8FCmBGzeGVrNEUkFQ83Y5KJeawFfTR+d90sxf2xtO2wIDRq8KzNt/kUH8
    Ki9tuz2HX3puhwY3SOsot8elbSa72pjSMmi6Ob+JSsWVIBR2OkqLP+t5dmEuBrmtP3PHZc
    rul/kW40M6m+4XWmwkV5oSzb8+GUCapaGqZlw4nH+aUswMnC5OdSzKYITdbzGLi3M/FH0F
    104m+pc3BvY9wArFiSd4S0CDHkii+lfNCv5K5oORnJ6OhczXGF/ZIK190lNNSmofon2mNJ
    ca3tvzZSCZGhqY5lwX7KhVF2e+l4WjfTJtfyNgvVlGzVUu9857xbIuRHRnt6kGQc35PLiE
    8jEBiAVe5jeiVhnxbgFDmv+To1Kam5JrDXb6wgN1od9LhHrshOGTsLUwVV3Ej2J0nfc36G
    vCmlqQdoAav34+RpqPl4uT07KjgfIBExib1ljdFUZwmIcTo763kUoz7KN+yw
X-ME-Proxy: <xmx:biM8alrj1NLP_tTblhwsNg-BkXPjo3m2UBHYIqNznYR_dONlLLymBg>
    <xmx:biM8ahHfIFmJl8GYhergSX7S66R3fyR7K7k3ewLI523N_BSmv6BJtA>
    <xmx:biM8ahyOqit29Mg-hOwSaVQ1il_38BZNSwpyrf2K3s_R4URAHIf0Tg>
    <xmx:biM8amq9BqVnecBfWz1I7nM0s4KriI-CnzAy1f__CYdWnlQFB26SOw>
    <xmx:biM8agGF0uNS1PjaKDunmp5ueQ1uNI0k9XiYmqgNeqFW5ufzPzXKdKWo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 14:35:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH 2/6] object-file: propagate files transaction errors
In-Reply-To: <20260624041920.2601961-3-jltobler@gmail.com> (Justin Tobler's
	message of "Tue, 23 Jun 2026 23:19:16 -0500")
References: <20260624041920.2601961-1-jltobler@gmail.com>
	<20260624041920.2601961-3-jltobler@gmail.com>
Date: Wed, 24 Jun 2026 11:35:24 -0700
Message-ID: <xmqqjyrniy6r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> The "files" transaction backend may encounter errors related to managing
> the temporary directory used to stage objects, but silently ignores
> these errors. Instead return errors encountered in the
> `odb_transaction_files_{prepare,begin,commit}()` interfaces to allow
> callers to handle as needed.

"handle them as needed", perhaps.

> -static void odb_transaction_files_prepare(struct odb_transaction *base)
> +static int odb_transaction_files_prepare(struct odb_transaction *base)
>  {
>  	struct odb_transaction_files *transaction =
>  		container_of_or_null(base, struct odb_transaction_files, base);
> @@ -511,11 +511,15 @@ static void odb_transaction_files_prepare(struct odb_transaction *base)
>  	 * added at the time they call odb_transaction_files_begin.
>  	 */
>  	if (!transaction || transaction->objdir)
> -		return;
> +		return 0;
>  
>  	transaction->objdir = tmp_objdir_create(base->source->odb->repo, "bulk-fsync");

If this fails, NULL is returned, and ...

> -	if (transaction->objdir)
> -		tmp_objdir_replace_primary_odb(transaction->objdir, 0);
> +	if (!transaction->objdir)
> +		return -1;

... we return -1 from here to signal an error now.

But callers of this function in write_loose_object(), and
odb_source_loose_write_stream() are not prepared to react to such an
error.

I guess this is nothing new.  The callers ignored such an error from here
in the original and proceeded writing the primary ODB anyway, and we
continue to do so after this step.

> @@ -542,13 +546,13 @@ static void fsync_loose_object_transaction(struct odb_transaction *base,
>  /*
>   * Cleanup after batch-mode fsync_object_files.
>   */
> -static void flush_loose_object_transaction(struct odb_transaction_files *transaction)
> +static int flush_loose_object_transaction(struct odb_transaction_files *transaction)
>  {
>  	struct strbuf temp_path = STRBUF_INIT;
>  	struct tempfile *temp;
>  
>  	if (!transaction->objdir)
> -		return;
> +		return 0;
>  
>  	/*
>  	 * Issue a full hardware flush against a temporary file to ensure
> @@ -570,8 +574,12 @@ static void flush_loose_object_transaction(struct odb_transaction_files *transac
>  	 * Make the object files visible in the primary ODB after their data is
>  	 * fully durable.
>  	 */
> -	tmp_objdir_migrate(transaction->objdir);
> +	if (tmp_objdir_migrate(transaction->objdir))
> +		return -1;
> +
>  	transaction->objdir = NULL;
> +
> +	return 0;
>  }

The caller of this function does react to a failure of it, ...

> @@ -1670,27 +1678,34 @@ int read_loose_object(struct repository *repo,
>  	return ret;
>  }
>  
> -static void odb_transaction_files_commit(struct odb_transaction *base)
> +static int odb_transaction_files_commit(struct odb_transaction *base)
>  {
>  	struct odb_transaction_files *transaction =
>  		container_of(base, struct odb_transaction_files, base);
>  
> -	flush_loose_object_transaction(transaction);
> +	if (flush_loose_object_transaction(transaction))
> +		return -1;
>  	flush_packfile_transaction(transaction);
> +
> +	return 0;
>  }

... like this, which is good.  Do we need an explicit "abort-transaction",
or is that implicit?

Thanks.
