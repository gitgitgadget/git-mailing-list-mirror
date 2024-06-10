Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0474D8BC
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 08:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718007980; cv=none; b=FUnyMjtttPLUurapg7+AttXYLfbot5NIf02vC2DIOkHbguKB1zBD3qboeRKUp2mKWrZbEP7RNcEk73HiP5zcYeslas2tCHvWgBOr5hOOuD5Hq9MQXgI7RXufuhSOor9mRUdTU/2nYXVehXXWXEJAa+oruloPiHQ1Z5tgqV/6pPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718007980; c=relaxed/simple;
	bh=3uHLWk9Eq5VJt3pUpUSV7wLRV/YkEsm+p+KNKDFIAZg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bvzFW1dhPzgNRqjhlehh76FO4x5XRKIHtdtBsNBWfn+aYbJKA/3DRHdE/eD7unrDEtGa3L0wgbLVXQxe5y7SpOJGI9QKbrEI9h8QBPn8kRaauRl6hS1MFW4mwYm85uLJeUZiuuCtYRP4ND6nPzMC40qe/1Z+oVLXtUlljdjEdfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRUZvtyt; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRUZvtyt"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3d21f253a53so657071b6e.2
        for <git@vger.kernel.org>; Mon, 10 Jun 2024 01:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718007978; x=1718612778; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qy4fSlkvsUCbV9K/KNR1WeyQkxEjUl2wKWj3gtneXx0=;
        b=aRUZvtytpurukNzamq7O9DZ7Or04FxyQUlpfIMCO78ZGLXvX9SKsfOxPkiE2dvugQZ
         OqZdN1R1CvE+d1DsK0mcX0bOPjaCOyr4UL84FwlsMRy2d2vou5OhV7CT9MgcIB1qQeGU
         koJ4YIyVuI7xaTmp7TiPpXtnHmnCDZZIbXrKJqRARGI+cTTi/46Erlk+zMn7g6LXO4xb
         gWVOgC7Pop3i198i6UFv6cOXfN8NB0lf1vi9MeUzu1wuUZAFnnLDL4cG0OkI2jETLP4Z
         Y2XfbPKu2/kQCkomPDcGj6qLo0+XyCAc+jLHmWL8zxFvmSj1JP1+z1fGsj1qgIl1QVGA
         pb/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718007978; x=1718612778;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qy4fSlkvsUCbV9K/KNR1WeyQkxEjUl2wKWj3gtneXx0=;
        b=QkrY7fRBY0iigBwlLnYW953h11T+qHVfcUvySyILYiGYw8w3a+qOqJxyiR9rGhiHyP
         bs/aOZEsDTma3UOC4TqJz9rWMXrKsDHDl4PF5LEmbSWzf7ynPft4SwTq+ovJMvD27S67
         8VJKxhIZMREl1/ka6IOCulXQ6db2vtueg6rKbCcvEJCjXmtSo7O2ZmMXxsd+7Wjk4R4e
         X//oG7O4Hd9cEP4NV05AmR9xANezYClbJkyV+Cbf5/j6HUGvsicYjH0LfiAMtLln/d2b
         ZW/f1pdCaMLtEhE7fF1/DIQBNzZW8p9jtmNc4tu+ZqxCpi8+9E1NRB9EgyZ/cwzEN6xu
         bWig==
X-Gm-Message-State: AOJu0YyD0bTIQm1zUcN+Baiaka5iqTXL5CJzH2X4dTGaxygoH69cmkj/
	9zaKKHOBS7ByzqAnXJ7jVdwS2kNkRXNUUhLWzysrgUROweb08JkpadmmvEIbBGp9jm90jKvwDZp
	1eY3PC1gMSBiOlC1sC5UGCfhxpfs=
X-Google-Smtp-Source: AGHT+IESBr6lOxXVAhV/O4CNAp7CoGlvqC66I7yPzxBwGoR4ooQJn9/55cvfKGMwJh1tUrb/wtVgsfFZhTRlTGm3Yag=
X-Received: by 2002:a05:6871:289e:b0:254:421b:3dc5 with SMTP id
 586e51a60fabf-25464807bf0mr8736303fac.46.1718007978366; Mon, 10 Jun 2024
 01:26:18 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Jun 2024 04:26:17 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZmajCzuQftZlmlmS@tanuki>
References: <20240605102958.716432-1-knayak@gitlab.com> <20240607133304.2333280-1-knayak@gitlab.com>
 <20240607133304.2333280-3-knayak@gitlab.com> <ZmajCzuQftZlmlmS@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 10 Jun 2024 04:26:17 -0400
Message-ID: <CAOLa=ZSum=gWbxMyekwjfxqJ38EPTbQ-d4ts-xGxKaiiDgUTNw@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] refs: specify error for regular refs with `old_target`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com
Content-Type: multipart/mixed; boundary="00000000000045c58a061a84e715"

--00000000000045c58a061a84e715
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Jun 07, 2024 at 03:32:59PM +0200, Karthik Nayak wrote:
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index 194e74eb4d..fc57c9d220 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -2491,14 +2491,16 @@ static int lock_ref_for_update(struct files_ref_store *refs,
>>
>>  		/*
>>  		 * Even if the ref is a regular ref, if `old_target` is set, we
>> -		 * check the referent value. Ideally `old_target` should only
>> -		 * be set for symrefs, but we're strict about its usage.
>> +		 * fail with an error.
>>  		 */
>>  		if (update->old_target) {
>> -			if (ref_update_check_old_target(referent.buf, update, err)) {
>> -				ret = TRANSACTION_GENERIC_ERROR;
>> -				goto out;
>> -			}
>> +			strbuf_addf(err, _("cannot lock ref '%s': "
>> +					   "expected symref with target '%s': "
>> +					   "but is a regular ref"),
>> +				    ref_update_original_update_refname(update),
>> +				    update->old_target);
>> +			ret = TRANSACTION_GENERIC_ERROR;
>> +			goto out;
>
> Shouldn't the second colon be a comma? "expected symref, but is a
> regular ref" reads way more natural to me than "expected symref: but is
> a regular ref".
>

It makes sense the way you put it, but we also print the 'target', so it
is something like "cannot lock ref 'refs/heads/branch1': expected symref with
target 'refs/heads/master': but is a regular ref". I felt here the colon
divides the error into three segments
1. States that we couldn't lock the file
2. States that we were expecting a symref with a particular target
3. States that the ref in question is actually a regular ref

Having said that, I'm not too bullish on this and happy to change it :)

> Other than that this series looks good to me now, thanks!
>
> Patrick
>

Thanks for all the reviews. Since this is the only change, I'm inclined
to leave it as is.

Karthik

--00000000000045c58a061a84e715
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a38203e9d907fd83_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1abXVLUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMjh5Qy80c2hrQ3NWMGdpK2tBajFiZE11aXZsM3JpZwpsTFJIaXl5Tnd1
cFZId2tiWm0wOFpTNTdHZDJzYndkTXRvZmJFOTlrbE03R05WeU9RRmRHN2VsRE11NmVYM3lUCkxI
UXVSb3gyeHlsaWVUV2RDWVBRd3pDQ1ltRnNTOXZvQkk5N2V6VGFWVzlDMGo1NW1xSU51R3FiZXFS
aWxMSkcKOHVsVlgvNmxiQXI3aDVHYlgyZUtyL2ZKTEhBYjBBWDFCU0VuSHpIbEQzZlVlOVpPK01C
bWhZSE1ES1hoOGJMRApZdzZYeERUS2FsbFNnL3EvVjR6RHlUUjhra2wvOTNPU0RlYnJnb3FXU09a
TGNnZENERllPNHdCSDZmbFdxQ2kyCkh4clRWUlpBc2NaN1dEdG0wTGpzK1JQa1JXQWNUcHVuSGQv
cWkwZmRxaUthUWtSYk1CRE1KUnVLYjZiQ1VCYlcKMnYvbnhEdXlGK3VWcDVOKzBKRzc0UlZQckFn
cWJDcDZRY1Y0b2RiOWtYSXlYdklBMlhqdGwwN0RWaHIvOW13RwoyeUJST0ZCM2VpbjhKTDVKS0xX
aThVN09tYUcxSkJWMHRmbnBwQWtmTHNLakdBZnp3UHBJcGlKMStiSmtvSzFvCjQzTXJVTjhYaS9h
ZU9RMDhRcktWd05GY0F6eUlDYURGa2dvV3hVUT0KPU80ckIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000045c58a061a84e715--
