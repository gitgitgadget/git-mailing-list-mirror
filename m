Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DC813A409
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 21:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728508103; cv=none; b=HPpr4LlazvCYaNbvb/2EyqzMYFgEEtvQc4sAJ1A25csu4Xq1DouUozc0jQXSLGjkFBenGmFVO1CYmvOwwMF+cAtVUkTlNpDu92wuPj4gwkc7TqaeDuTEWz3cMHx2Am8EgEPGHQsvHfNvPeYisu5OUY7p9e5kvFcrDawWFEeGchY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728508103; c=relaxed/simple;
	bh=EtEg2apWW1KsA1tkj6baDtNIHefA5fMdtcFbzSPF31o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=irYrdghweD7/HIXV2Jf3gMCWRlFTBiskefn4d8NFlbt+MlvntkRmtg8Rk6QQVm4Ow4ISrOV0IpLuCR/eJSb04evqtKteetHY5P93QFLygsZpQk/bwWkmbtfyj+QSyeWhhzKC4I7q1FyfeRGOwv8LXzn5k9IcaTNrp69hN37DKBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eFJR0Iz0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hk7M0A6t; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eFJR0Iz0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hk7M0A6t"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1A2EE11401F2;
	Wed,  9 Oct 2024 17:08:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 09 Oct 2024 17:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728508100; x=1728594500; bh=obMNWh4fJ7
	+qwVs+Ncp0hF5GykYWWS18LKs+m8YEH30=; b=eFJR0Iz0Fs8AQWMGTMTuQ2DhRq
	bTYWnqaFE4G68H7Opi6PDH+4cSkABg11ixoxPEu58liGfTFeqoJOgbu0YfHJO3uv
	Ke7sDfP3FIGw7lFam+Armn6jjvT/dUkMtHvtl629LBCzIZIaFDAjjTYNmDmwzalu
	ro1Za8EVcwAmpvoX9RBjq+TD70F9V4gm9ica9DA66sDf7LuMoElSTZVwtiX0D0Xp
	T9d7+nynlN7D3X9oPdq30QQBv0Ys2B+SxFo7kAG1wzscSAJuUdMHphde8ATBDZPl
	jtuHndYtfnfOYY4KuOMaxNPk55Ki2HIBn2OJM7rVH0JlO/3Qqqkgd0AVDvOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728508100; x=1728594500; bh=obMNWh4fJ7+qwVs+Ncp0hF5GykYW
	WS18LKs+m8YEH30=; b=hk7M0A6t76+TnIOMVdj9VNj4XZoYbq5fhvOpxhwx8MyG
	baK11SMcopArS4JPTFSBNqwnzGN6vQPKkmE7hQbPWD87JXNJ0WBIGQNp8URtjkis
	24ZXh+V3Hf2J1gbAzUS/tq5j6JwuhdWOwNAae95vvg2PocvIpQVcwFSYeV8BEJ1Y
	qWICRVG5LllrSSPbRVPfuREOga5bBIaIYyS37AGQBiCjkRCi5XQO6oD2ZL8/RoZq
	Rd8sk3XXjivp1tMygBDTk90rPu+ciLdnjA2k9MA4qRqqTUDqMCb4AhyYcY6NQxhy
	eX8rJ6dEnekbricOqHkjJ3WkgCUpi6PPtki3WrxE3Q==
X-ME-Sender: <xms:w_AGZ9YqF6N9pxYKqMOHW7vz4Jse72rRh8ZJAJ-w22ozpsKZcE6bXg>
    <xme:w_AGZ0adl5pCWynflks2VeTH7dWMVhLpvjYBcSHDlheug-yOf3-N_sx1rGPcAc7H-
    7Z6CaSOtjBJCY9oxg>
X-ME-Received: <xmr:w_AGZ_8yw7HpECCSaUtRvya7Vqv2UYeYuXpbVAwBJ24h-fr4nCorKAPvPkizmRFhyInLw3BTC5JssmvVjSZ0EgqDewCijaC0AbwE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgudeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghntggvsehfvg
    hrughinhgrnhguhidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrgh
    druhhkpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehl
    rdhsrdhrseifvggsrdguvgdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvg
    hlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:w_AGZ7o85Xll4d71TwJfAi5OukEID5OHfrohQiXPTVj8CSxHVYkcKw>
    <xmx:w_AGZ4q75V6y05TGLdCL3Ht9VJ7_bL0GF8TkaT_Ur9xhCwV9keOAlg>
    <xmx:w_AGZxRybd5IYZhNm8a7AvOYO30oTFXkwS7V_f5jf9VSAmnc_iMoZA>
    <xmx:w_AGZwocJf55ytNltHx1vTsy3Gbn0BxNZKOqLbM2vQe2F_mk8c458Q>
    <xmx:xPAGZwIF2-Wvpydox6Kuw-KU6FlfjT3V8KaMoiIPL8cttLVkCJFThamY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 17:08:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org,  phillip.wood@dunelm.org.uk, 	Taylor Blau
 <me@ttaylorr.com>,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Johannes
 Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 4/6] transaction: add TRANSACTION_CREATE_EXISTS error
In-Reply-To: <20241009135747.3563204-4-bence@ferdinandy.com> (Bence
	Ferdinandy's message of "Wed, 9 Oct 2024 15:57:26 +0200")
References: <xmqq1q0xhu13.fsf@gitster.g>
	<20241009135747.3563204-1-bence@ferdinandy.com>
	<20241009135747.3563204-4-bence@ferdinandy.com>
Date: Wed, 09 Oct 2024 14:08:17 -0700
Message-ID: <xmqq8quxq91a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bence Ferdinandy <bence@ferdinandy.com> writes:

>  /* Naming conflict (for example, the ref names A and A/B conflict). */
>  #define TRANSACTION_NAME_CONFLICT -1
> +/* When only creation was requested, but the ref already exists. */
> +#define TRANSACTION_CREATE_EXISTS -2
>  /* All other errors. */
> -#define TRANSACTION_GENERIC_ERROR -2
> +#define TRANSACTION_GENERIC_ERROR -3

My initial knee-jerk reaction to the name "CREATE_EXISTS" was that
the "CREATE" part is redundant, as the only case that the fact that
something exists is a valid reason for an error is when we attempted
to create it.  EEXIST in errno(3) is not ECREATE_EXIST for the same
reason.

But let's let it pass; contrasting with the fact that what ought to
be named similarly to EISDIR is called NAME_CONFLICT, CREATE_EXISTS
is fine.

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 8415f2d020..272ad81315 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2502,14 +2502,18 @@ static int split_symref_update(struct ref_update *update,
>  static int check_old_oid(struct ref_update *update, struct object_id *oid,
>  			 struct strbuf *err)
>  {
> +	int ret = TRANSACTION_GENERIC_ERROR;
> +
>  	if (!(update->flags & REF_HAVE_OLD) ||
>  		   oideq(oid, &update->old_oid))
>  		return 0;
>  
> -	if (is_null_oid(&update->old_oid))
> +	if (is_null_oid(&update->old_oid)) {
>  		strbuf_addf(err, "cannot lock ref '%s': "
>  			    "reference already exists",
>  			    ref_update_original_update_refname(update));
> +		ret = TRANSACTION_CREATE_EXISTS;
> +	}
>  	else if (is_null_oid(oid))
>  		strbuf_addf(err, "cannot lock ref '%s': "
>  			    "reference is missing but expected %s",
> @@ -2522,7 +2526,7 @@ static int check_old_oid(struct ref_update *update, struct object_id *oid,
>  			    oid_to_hex(oid),
>  			    oid_to_hex(&update->old_oid));
>  
> -	return -1;
> +	return ret;
>  }

OK.  So if a caller does not care which exact kind of error it got,
they will keep working just the way they used to work, and a caller
that cares can now check.  A nice API enhancement.

> @@ -2603,9 +2607,13 @@ static int lock_ref_for_update(struct files_ref_store *refs,
>  					ret = TRANSACTION_GENERIC_ERROR;
>  					goto out;
>  				}
> -			} else if  (check_old_oid(update, &lock->old_oid, err)) {
> -				ret = TRANSACTION_GENERIC_ERROR;
> -				goto out;
> +			} else {
> +				int checkret;
> +				checkret = check_old_oid(update, &lock->old_oid, err);
> +				if  (checkret) {
> +					ret = checkret;
> +					goto out;
> +				}
>  			}

Likewise; this code is just propagating what check_old_oid() did
to its callers.

> @@ -2636,9 +2644,13 @@ static int lock_ref_for_update(struct files_ref_store *refs,
>  				    update->old_target);
>  			ret = TRANSACTION_GENERIC_ERROR;
>  			goto out;
> -		} else if  (check_old_oid(update, &lock->old_oid, err)) {
> -			ret = TRANSACTION_GENERIC_ERROR;
> -			goto out;
> +		} else {
> +			int checkret;
> +			checkret = check_old_oid(update, &lock->old_oid, err);
> +			if  (checkret) {
> +				ret = checkret;
> +				goto out;
> +			}

Ditto.

> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 32330b6bc6..c6b25ebac4 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -1206,10 +1206,13 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
>  				goto done;
>  			}
>  		} else if ((u->flags & REF_HAVE_OLD) && !oideq(&current_oid, &u->old_oid)) {
> -			if (is_null_oid(&u->old_oid))
> +			ret = TRANSACTION_NAME_CONFLICT;
> +			if (is_null_oid(&u->old_oid)) {
>  				strbuf_addf(err, _("cannot lock ref '%s': "
>  						   "reference already exists"),
>  					    ref_update_original_update_refname(u));
> +				ret = TRANSACTION_CREATE_EXISTS;
> +			}
>  			else if (is_null_oid(&current_oid))
>  				strbuf_addf(err, _("cannot lock ref '%s': "
>  						   "reference is missing but expected %s"),
> @@ -1221,7 +1224,6 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
>  					    ref_update_original_update_refname(u),
>  					    oid_to_hex(&current_oid),
>  					    oid_to_hex(&u->old_oid));
> -			ret = -1;
>  			goto done;
>  		}

So it remains a little mystery how the ultimate caller uses this new
bit of information.

Which is OK---the next step seems to have a new condition on the
error status.
