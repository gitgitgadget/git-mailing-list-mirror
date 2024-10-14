Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFE61547F2
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 08:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728895700; cv=none; b=AoqXa8jaYfu6myMwanDB1NqIg9ftMmqML2qTVypAc5v5dE4UJJIRUXmxm5w8OeVXFXQth8gG8pm4E+ZTN3fRa+FYwlD4gxAbzzHfZ8DQ5+YdFvbrV4skqOKDHKkrV1u6XLVVXqI3JzIdzx188G1IauGv5ixYevLWrnSNF/CEB6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728895700; c=relaxed/simple;
	bh=IS2W+5ygGrLOo48UBNvfnplKSAw8e6YZqu58sFAG/yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gnaE91Pw/qz53fsHvYW8s9UsQgOCbQlWoOrAftFIE7ze8mRq7kHGcaXu5/7szzp+j2C75RltusfFaXV9X3XYpe7yZHzTCgrboxpjdlSXOExhyj7in5X8qclgwGzDlK6/3npM9/WvWNgmPuefjtfpAIFOvBcsIrA52UlZZZPOS90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPXh/GPn; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPXh/GPn"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539f84907caso637303e87.3
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 01:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728895695; x=1729500495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xRX7qIx3eLyGef671/z/yND4kjbK1jJUtkwjNB2aWmA=;
        b=RPXh/GPnzqfq22QXtxliG4wI2c1ZKzCed9S/TCQEkjvds6kKX4Cy6Kys7XbZvM7r66
         jKmETa1B3S4EotWMHsX8Cay2bDohadfsl6O1/ny8tqyN7+ZpiRVrCFGzYN50IvN+PkXb
         HONZvxqOXQgHEmUDOxKZKEjOzkA80Ef/KcZlFqpPGPAaIqJkrw1rQnA02bYCkdM6+hR6
         5Q7Er9qcjbq/s063eqvzxgaiA1qfnvFNIH2Zze+1XY4NDsSaD2mCvlOIe9CssaC0Rs4J
         gIHAYxAgkk5KTfdRfL65/o+dC6paVQkcZfvfzTdKDW0+gWkDRF0Wa6FPaUuoFoT26M3D
         z6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728895695; x=1729500495;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xRX7qIx3eLyGef671/z/yND4kjbK1jJUtkwjNB2aWmA=;
        b=PIpPiVJQHSxx2l39OjtheUX87R8jrb1SmGguLUgjDYxzdLsBRvyjrkaRVitP1qEaao
         PdUTQVHuSyZRgBfyZPnKVqWvbkVpbUbYA6e1W5fL5d6sqL6Nk9Ilt3ybUPyh+pMYbg15
         go4I5XEbO8D1RWIvuiXEeXXAdCCufOY0tIWAil2AucJiqMHim01lzS9EjGvMaLGJtTs1
         79PBkSt/AQRO1suqW27qjXOrRxUasLpB73vd8PESW0UPttBBsE21/TsMU6meKiOac0sE
         puHgqip03yMU815Tx8fAojogNxK8abGz6HlCbQxLNe9z8yaVLGJk1O5TvAPVuSU5Mxhg
         lumg==
X-Forwarded-Encrypted: i=1; AJvYcCVUPyrIg+9jVzUe0mgV/qg+TKf4e1nzmGOHQuhXDxBYGbWL6SCmfVFI3/uZuKNp0P5P0uk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE/2nkemvlSt3lPmE8Mxl2r/Ush5zG36Id8Tph0Js+oc1CtTbp
	IxlzSB1fOpQqT+jBZYLo3KMRzEstCbNGOtk5kCL2x8XHxnlApwEP
X-Google-Smtp-Source: AGHT+IFdRdCP2hnKIhUmakebZ3XOftc5tEriTCeFI02wBGpKqn3FJg1Gx9pDYM2wT1cuURHjMLEtBw==
X-Received: by 2002:a05:6512:33cb:b0:539:f65b:3d1 with SMTP id 2adb3069b0e04-539f65b0552mr1265392e87.21.1728895694948;
        Mon, 14 Oct 2024 01:48:14 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a? ([2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf4b1a0sm144701195e9.14.2024.10.14.01.48.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 01:48:14 -0700 (PDT)
Message-ID: <509dffdb-ea4a-4fbc-8769-0b2e181c952b@gmail.com>
Date: Mon, 14 Oct 2024 09:48:10 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 4/6] refs: add TRANSACTION_CREATE_EXISTS error
To: Bence Ferdinandy <bence@ferdinandy.com>, phillip.wood@dunelm.org.uk,
 git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?=
 <l.s.r@web.de>, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>
References: <20241010133022.1733542-1-bence@ferdinandy.com>
 <20241012230428.3259229-1-bence@ferdinandy.com>
 <20241012230428.3259229-4-bence@ferdinandy.com>
 <cf7c4831-a766-430c-aac6-5cd5c2ceabed@gmail.com>
 <D4UZ5DJWM3WM.MYD9YL6SLE@ferdinandy.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <D4UZ5DJWM3WM.MYD9YL6SLE@ferdinandy.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bence

On 13/10/2024 21:52, Bence Ferdinandy wrote:
> On Sun Oct 13, 2024 at 16:03, Phillip Wood <phillip.wood123@gmail.com> wrote:

>>> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
>>> index 3c96fbf66f..ebf8e57fbc 100644
>>> --- a/refs/reftable-backend.c
>>> +++ b/refs/reftable-backend.c
>>> @@ -1206,10 +1206,13 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
>>>    				goto done;
>>>    			}
>>>    		} else if ((u->flags & REF_HAVE_OLD) && !oideq(&current_oid, &u->old_oid)) {
>>> -			if (is_null_oid(&u->old_oid))
>>> +			ret = TRANSACTION_NAME_CONFLICT;
>>> +			if (is_null_oid(&u->old_oid)) {
>>>    				strbuf_addf(err, _("cannot lock ref '%s': "
>>>    						   "reference already exists"),
>>>    					    ref_update_original_update_refname(u));
>>> +				ret = TRANSACTION_CREATE_EXISTS;
>>> +			}
>>>    			else if (is_null_oid(&current_oid))
>>>    				strbuf_addf(err, _("cannot lock ref '%s': "
>>>    						   "reference is missing but expected %s"),
>>> @@ -1221,7 +1224,6 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
>>>    					    ref_update_original_update_refname(u),
>>>    					    oid_to_hex(&current_oid),
>>>    					    oid_to_hex(&u->old_oid));
>>> -			ret = -1;
>>>    			goto done;
>>>    		}
>>>    
> 
> This originally returned -1, and it still returns that if it doesn't return -2,
> I just used the named variable instead of the integer itself. It might still be
> that this should be -3 GENERIC_ERROR, but if that is the case I think fixing
> that should be a different patch? I didn't check if changing that -1 to
> something else breaks anything or not.

Oh sorry I was confused and thought TRANSACTION_GENERIC_ERROR was -1.

Best Wishes

Phillip

> Best,
> Bence
> 

