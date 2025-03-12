Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC57241CB7
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 13:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741784761; cv=none; b=RP3Cgd8G+Dm2Jgn2qUW/QzNBx+xHxL1ZTtMT10OXQcCB5fzMIkmG1c08CZa/YXwWPJEwVquXINUDb4JN79GrPSyZGZ9wA5cQW2xTKb6I7+kBy/Pm+711aPuNhL8u0cCCDeNutt6y9xvMTRsd6ZSBU+CgzFk86srK8INamn4qd9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741784761; c=relaxed/simple;
	bh=5jgmOYykbCGjYc+shwDNdNyRNbyX/ZGDIRUh6XNVbGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogAccqOM8BIp+6HQqKGI0p7EIgc9LS+eLUdwQr2eOI9+BoAmv3D1EHXn8hNswpPdXA0/1Q61fjG2eD51k6FUKX5dC6TFpEqjZdtbJ2CSx0RJwJLgpGtt9FAJ9ajfH69nyoNIbgDm01bN9JTOr+iIH25q6yZsRMVtXpgt0TnEvn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j28MYJgE; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j28MYJgE"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-225b5448519so5777365ad.0
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 06:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741784759; x=1742389559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DTI8E17g2TFDLocVt2Flxb+CVCkEihl5IHPfRIV0H7w=;
        b=j28MYJgEg130ZEtE9Pjro8A1YUotLgXin4hW41vM3DmfKW6Zvcd4EbzFRj61QORbgz
         c8tA3m2BvgI8kUloODSww/bOwRwCn4Rxl9rxrLkCGlvxZuXJJF3LhoGUvkOcvW6fRgpI
         i6UiJuROqn5MjuxLPgy1eKMdA5N3g9REaoDeKfdtmxVr0KjhbSYqAmoI6+MN35qNwfqn
         XqRBNpkgw2ZdxSToqUc7C8M82dG7AWkx7Md5LCrBlZX4HA3gbTfKQ/JyUQksA9dD8hKE
         QoxZxJ94gFIFSa60sOfNtNFUKhS0Nz6JFB6G1b5biya2qokWQYY5TXj/TfwzRGTCFhr3
         jC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741784759; x=1742389559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTI8E17g2TFDLocVt2Flxb+CVCkEihl5IHPfRIV0H7w=;
        b=JliN5WpplLRAT4kNENDKKjs5eRdGB15R2LEwaUGOS7e7BYbWORjJ0R9/hnGq1e/hMh
         joOO5nb8g9AIZ50TA35yP73L1O/sTdhEoXhyo10ObBp7fSPetic06T83BfHD5vNRYE3U
         lgYV7jVCYSaIupzZ9Nbp0q+2Yod+s3tJSyEq58Zq57TG1EYur5L2T5+dYzx1JSYsA2y2
         6CSjEkM5Jqxx07z+GdoGa7zTs3x2CGp67u+rfUbWevGKbOy2G2PD94El1DznmCWC+hPL
         PJ6rp5XgBCvb9LxouRG7vpNNaBhASzxUe970SUBB6izrYlKGIAvLAoinNU8akqh1jV7V
         kVNQ==
X-Gm-Message-State: AOJu0YzMRWvqmmVGECFZNxlvbJfn01SKtPDwyIq/JlzTwxclQkGb3ctg
	KS4vZ7tPLj8Yo/XoaAPjJct5l3mqM9+hVgqZPYEZAQ8Rrv0UxLvP
X-Gm-Gg: ASbGncti/sDD3ixH8rFQ9Fd+/QkOZGcfMX179p5OgUv3j1sHncMW6UeQjO7EfMBxkOn
	tBEQRLmXRhuJrREOKq3H2pJJjqdEiRsQNT/o89Cg9bs2xct+H7fZljaCrEysFLz3DEFuuIpgcW8
	IMuyeUJImHA+NegV+CuCtBajNLeRMJ41lDFkHAha1dY8w+Q4+HUqUK3n+UVDrVs/huh3UtrdGqm
	+t8a1j2oL8XIYAlRtHTSLHhDZB71Cn71CCXUyKnJK4Ll41jCvg68XzxNYjaFUoW8aye7uPhq2Me
	gLYdPbk2ghAtdLOWsaHtrM9XUW1MIc88+zxwpzVx
X-Google-Smtp-Source: AGHT+IEKHx0jaUYoLVvSPtvyPH/MU3Uh2o4ChjOC3Eo3DBF2c5Z5ZUn/HTAEhc6VEcBeMO0UH7GZsQ==
X-Received: by 2002:a17:902:e88a:b0:21f:6fb9:9299 with SMTP id d9443c01a7336-22428aaad15mr339082655ad.27.1741784759385;
        Wed, 12 Mar 2025 06:05:59 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-224109e98f9sm115266565ad.93.2025.03.12.06.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 06:05:58 -0700 (PDT)
Date: Wed, 12 Mar 2025 21:06:08 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 07/16] refs/files: batch refname availability checks
 for initial transactions
Message-ID: <Z9GGwNpfDly4_NIL@ArchLinux>
References: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
 <20250306-pks-update-ref-optimization-v5-7-dcb2ee037e97@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306-pks-update-ref-optimization-v5-7-dcb2ee037e97@pks.im>

On Thu, Mar 06, 2025 at 04:08:38PM +0100, Patrick Steinhardt wrote:
> The "files" backend explicitly carves out special logic for its initial
> transaction so that it can avoid writing out every single reference as
> a loose reference. While the assumption is that there shouldn't be any
> preexisting references, we still have to verify that none of the newly
> written references will conflict with any other new reference in the
> same transaction.
> 
> Refactor the initial transaction to use batched refname availability
> checks. This does not yet have an effect on performance as we still call
> `refs_verify_refname_available()` in a loop. But this will change in
> subsequent commits and then impact performance when cloning a repository
> with many references or when migrating references to the "files" format.
> 
> This will improve performance when cloning a repository with many
> references or when migrating references from any format to the "files"
> format once the availability checks have learned to optimize checks for
> many references in a subsequent commit.

I guess you forgot to delete some sentences for the commit message. This
paragraph is a little redundant. In the second paragraph, I think we
have already talked about this.

> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs/files-backend.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 6ce79cf0791..11a620ea11a 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3056,6 +3056,7 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
>  	size_t i;
>  	int ret = 0;
>  	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
> +	struct string_list refnames_to_check = STRING_LIST_INIT_NODUP;
>  	struct ref_transaction *packed_transaction = NULL;
>  	struct ref_transaction *loose_transaction = NULL;
>  
> @@ -3105,11 +3106,7 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
>  		    !is_null_oid(&update->old_oid))
>  			BUG("initial ref transaction with old_sha1 set");
>  
> -		if (refs_verify_refname_available(&refs->base, update->refname,
> -						  &affected_refnames, NULL, 1, err)) {
> -			ret = TRANSACTION_NAME_CONFLICT;
> -			goto cleanup;
> -		}
> +		string_list_append(&refnames_to_check, update->refname);
>  
>  		/*
>  		 * packed-refs don't support symbolic refs, root refs and reflogs,
> @@ -3145,8 +3142,19 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
>  		}
>  	}
>  
> -	if (packed_refs_lock(refs->packed_ref_store, 0, err) ||
> -	    ref_transaction_commit(packed_transaction, err)) {
> +	if (packed_refs_lock(refs->packed_ref_store, 0, err)) {
> +		ret = TRANSACTION_GENERIC_ERROR;
> +		goto cleanup;
> +	}
> +

Still the same question: why we don't sort the `refnames_to_check` here.

> +	if (refs_verify_refnames_available(&refs->base, &refnames_to_check,
> +					   &affected_refnames, NULL, 1, err)) {
> +		packed_refs_unlock(refs->packed_ref_store);
> +		ret = TRANSACTION_NAME_CONFLICT;
> +		goto cleanup;
> +	}
> +
> +	if (ref_transaction_commit(packed_transaction, err)) {
>  		ret = TRANSACTION_GENERIC_ERROR;
>  		goto cleanup;
>  	}
> @@ -3167,6 +3175,7 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
>  		ref_transaction_free(packed_transaction);
>  	transaction->state = REF_TRANSACTION_CLOSED;
>  	string_list_clear(&affected_refnames, 0);
> +	string_list_clear(&refnames_to_check, 0);
>  	return ret;
>  }
