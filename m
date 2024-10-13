Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E1974418
	for <git@vger.kernel.org>; Sun, 13 Oct 2024 14:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728828231; cv=none; b=fQFxOK9FVKFu4NFizRzgxNdeNsucnGLKL3OQTaNqWKz9R3rGni4PvqAJ7JHWG7yqY7Nqn5+Q3D70DTqUWJ3A/CaliNh5ZDfvnCtMCSa/iU9LbiSJ8Md/mLFN4W6BcSiPAAgyBVs8SwwHWBQYbAEuG+viElZNekpnHemV/tU6ml8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728828231; c=relaxed/simple;
	bh=1qGx+9ZHhXKEqkrfZ7OdX3pvw3wZszDgEwYyE5cS0rc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K2oH4rLfqrBbphLlcyvpMdbZUSAIAuOG5u73VoCqgGdzQ9/aNmRwvDQbD6ArXpJY+TZE5jbEqgv6nk470YtNyHwRze4b+5IrHA27MoQoBLUpa6YcI+/z0y07Q3Ddo+I32wN1ZfbNRpNHYjUUBbHN9ChMqNfKOKh0RjXb5yayx8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQGZyYFx; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQGZyYFx"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43058268d91so32100265e9.0
        for <git@vger.kernel.org>; Sun, 13 Oct 2024 07:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728828228; x=1729433028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I4P8WlPAaPp09DxtvDbBApxIFicqC4VKzSTZxL8IViU=;
        b=aQGZyYFxRTfSaRJPTk9plI6YVK5FxO+frWrVF8vByDQWvLRLbQrX5Q+LlrIiUk39mM
         l4HfoWF57G1nDGmFV8Hld3N6Z3D4POGN+PdULzzR1ikl9irJgq+mgkMxhMKUiDhAo/OU
         hrGo8YopEBSGPDARwucOHwvvd8Xp2V3rAHDhIqzvQzjDu1RU3/M3eO2rPPSaSW3NtYNY
         oQRnhhn8wB5cyC06JALd8eHS9fQC3k1QqWDw6jXublxZKjNtIyfjAh1wJ8XFDaQf9fzn
         aG5Xjnz9mIOiNAJaOgczcz5dyTXHzrheUzJVjjAREMJi3WcheRfOLkTXioELMzyCgUxM
         2V0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728828228; x=1729433028;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I4P8WlPAaPp09DxtvDbBApxIFicqC4VKzSTZxL8IViU=;
        b=BN5ReJ9cRpRE1OYzeiAu5T0qLwmmNxa5bwTpRpQYFT/s5BvOWmmb28/VD1Bt9pj9qR
         NsMC5dNHDYkQXm5jbMiIA/xcps6oXP46mPhdH8VdDmLEbob7ys/ip+RCYgoMoS2EJ3gJ
         CvycZaPOXmDUNBlM2TqkePfx6FPA/CDT4QKrw0Q5FEu5CRH4c4WtuDc3JXprLg9QAIs7
         Z9zRXJWKhzQxMKlJhIiNr8G8JiOc0KB1cpjlHSUlsXJsNCdAzrLcHZlrRKAnsklh+dBq
         88zQEiKsIBVgPzJCITU4XZl3JFVP+ruMIFUb197ewm31aIph1wC69fzENYaYO1SMoN8x
         FynA==
X-Forwarded-Encrypted: i=1; AJvYcCWrMuTS8KkCQalbCrIkoJBAJP4ikV4e8xKFZgw3ZAhhlU+Gt+bmgrN7I1aDBF2cjouqQac=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVWee/4iSDM35soeZV5BUn0jH9KXgvp5d/UY4Pkzjpi1rxfv3L
	GpnpHlSEZFu0FeHxv6xWyG8A3MzamtghKMMJZ1W1qT6VVVvbFaQlR2xYhw==
X-Google-Smtp-Source: AGHT+IF7ug7ykwQYpL49qWKOXfRPJahlJFGew05r+t25HTjMDzNA6yuFOOy/cVhhDeh7q8ASQ8WtAA==
X-Received: by 2002:a05:600c:470e:b0:42c:acb0:dda5 with SMTP id 5b1f17b1804b1-4311dea3c39mr78869575e9.1.1728828227367;
        Sun, 13 Oct 2024 07:03:47 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a? ([2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6bd1b7sm8782157f8f.37.2024.10.13.07.03.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Oct 2024 07:03:46 -0700 (PDT)
Message-ID: <cf7c4831-a766-430c-aac6-5cd5c2ceabed@gmail.com>
Date: Sun, 13 Oct 2024 15:03:45 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 4/6] refs: add TRANSACTION_CREATE_EXISTS error
To: Bence Ferdinandy <bence@ferdinandy.com>, git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk, Taylor Blau <me@ttaylorr.com>,
 =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>
References: <20241010133022.1733542-1-bence@ferdinandy.com>
 <20241012230428.3259229-1-bence@ferdinandy.com>
 <20241012230428.3259229-4-bence@ferdinandy.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20241012230428.3259229-4-bence@ferdinandy.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bence

On 13/10/2024 00:03, Bence Ferdinandy wrote:
> Currently there is only one special error for transaction, for when
> there is a naming conflict, all other errors are dumped under a generic
> error. Add a new special error case for when the caller requests the
> reference to be updated only when it does not yet exist and the
> reference actually does exist.

This looks like useful improvement. Are the changes to 
reftable-backend.c correct - it looks like where it previously returned 
TRANSACTION_GENERIC_ERR it now returns TRANSACTION_NAME_CONFLICT which I 
think is used to indicate a file/directory conflict (e.g. trying to 
create refs/heads/topic/one when refs/heads/topic exists)

Best Wishes

Phillip

> Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
> ---
> 
> Notes:
>      v4: new patch
>      v5: no change
>      v6: no change
>      
>      v7: - change commit prefix to be more in line with project standards
>          - changed error checking to Karthik's suggestion
> 
>   refs.h                  |  4 +++-
>   refs/files-backend.c    | 24 ++++++++++++++++--------
>   refs/reftable-backend.c |  6 ++++--
>   3 files changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/refs.h b/refs.h
> index b09a3a4384..c83b1ec76e 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -759,8 +759,10 @@ int ref_transaction_verify(struct ref_transaction *transaction,
>   
>   /* Naming conflict (for example, the ref names A and A/B conflict). */
>   #define TRANSACTION_NAME_CONFLICT -1
> +/* When only creation was requested, but the ref already exists. */
> +#define TRANSACTION_CREATE_EXISTS -2
>   /* All other errors. */
> -#define TRANSACTION_GENERIC_ERROR -2
> +#define TRANSACTION_GENERIC_ERROR -3
>   
>   /*
>    * Perform the preparatory stages of committing `transaction`. Acquire
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 0824c0b8a9..e743ec44b5 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2502,14 +2502,18 @@ static int split_symref_update(struct ref_update *update,
>   static int check_old_oid(struct ref_update *update, struct object_id *oid,
>   			 struct strbuf *err)
>   {
> +	int ret = TRANSACTION_GENERIC_ERROR;
> +
>   	if (!(update->flags & REF_HAVE_OLD) ||
>   		   oideq(oid, &update->old_oid))
>   		return 0;
>   
> -	if (is_null_oid(&update->old_oid))
> +	if (is_null_oid(&update->old_oid)) {
>   		strbuf_addf(err, "cannot lock ref '%s': "
>   			    "reference already exists",
>   			    ref_update_original_update_refname(update));
> +		ret = TRANSACTION_CREATE_EXISTS;
> +	}
>   	else if (is_null_oid(oid))
>   		strbuf_addf(err, "cannot lock ref '%s': "
>   			    "reference is missing but expected %s",
> @@ -2522,7 +2526,7 @@ static int check_old_oid(struct ref_update *update, struct object_id *oid,
>   			    oid_to_hex(oid),
>   			    oid_to_hex(&update->old_oid));
>   
> -	return -1;
> +	return ret;
>   }
>   
>   /*
> @@ -2602,9 +2606,11 @@ static int lock_ref_for_update(struct files_ref_store *refs,
>   					ret = TRANSACTION_GENERIC_ERROR;
>   					goto out;
>   				}
> -			} else if  (check_old_oid(update, &lock->old_oid, err)) {
> -				ret = TRANSACTION_GENERIC_ERROR;
> -				goto out;
> +			} else {
> +				ret = check_old_oid(update, &lock->old_oid, err);
> +				if  (ret) {
> +					goto out;
> +				}
>   			}
>   		} else {
>   			/*
> @@ -2635,9 +2641,11 @@ static int lock_ref_for_update(struct files_ref_store *refs,
>   				    update->old_target);
>   			ret = TRANSACTION_GENERIC_ERROR;
>   			goto out;
> -		} else if  (check_old_oid(update, &lock->old_oid, err)) {
> -			ret = TRANSACTION_GENERIC_ERROR;
> -			goto out;
> +		} else {
> +			ret = check_old_oid(update, &lock->old_oid, err);
> +			if  (ret) {
> +				goto out;
> +			}
>   		}
>   
>   		/*
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 3c96fbf66f..ebf8e57fbc 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -1206,10 +1206,13 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
>   				goto done;
>   			}
>   		} else if ((u->flags & REF_HAVE_OLD) && !oideq(&current_oid, &u->old_oid)) {
> -			if (is_null_oid(&u->old_oid))
> +			ret = TRANSACTION_NAME_CONFLICT;
> +			if (is_null_oid(&u->old_oid)) {
>   				strbuf_addf(err, _("cannot lock ref '%s': "
>   						   "reference already exists"),
>   					    ref_update_original_update_refname(u));
> +				ret = TRANSACTION_CREATE_EXISTS;
> +			}
>   			else if (is_null_oid(&current_oid))
>   				strbuf_addf(err, _("cannot lock ref '%s': "
>   						   "reference is missing but expected %s"),
> @@ -1221,7 +1224,6 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
>   					    ref_update_original_update_refname(u),
>   					    oid_to_hex(&current_oid),
>   					    oid_to_hex(&u->old_oid));
> -			ret = -1;
>   			goto done;
>   		}
>   

