Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78DE1DDC07
	for <git@vger.kernel.org>; Mon, 24 Nov 2025 13:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763990802; cv=none; b=q7PXX4bTDSMxm86HAWCIV5U3z8YfkmqmFre44czAxG7cuVLgCfQC44yu9ZpXr2NiLwlrPJHHoueg+Q2z7hrJaT94INB0X5gAeGENjWhVhqK+aGbpHCFbpNMA/LIojuZbhRlElcOjiXdouzzRaxE0lpONdtF9ariwYefWjSzs7bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763990802; c=relaxed/simple;
	bh=ld22ctc4QjEfycsC2HmDZloex7XRyx9Ua9WjEiARBts=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=i2e95JuH+2KSFojU88e/DH9oulwLCXhO4JZZDRVFR7e+yx8u5m/TLHE3fNsayjFSR/3tAWvPa58PTUkR88uUbRBO30wEA4EWwWuPnzxW1UcbAsx0iQyLhTPkVy3+ug0E0gFGPKdvf0ft53dhGh6xjc5v12mEKMjfk7kjpkIgEfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRAgCDKG; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRAgCDKG"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-932e6d498b2so2611781241.1
        for <git@vger.kernel.org>; Mon, 24 Nov 2025 05:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763990799; x=1764595599; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rMtl4mZM6wbPh/gq3v0gglxecaWPQ/BHVmZQ05nRW8c=;
        b=XRAgCDKGLmFfMO+oUPBHHk8/eKwTNFD7aRVPuv4tjthqYxJXhBLJ62hatgE1MZmyY7
         WcCv6li9avjrMYndMPcITfjpIzaI8wE5Vu5IZk+300rDz2+Zd01LX4dvOh/vCRZ4WkqC
         3ENUlDaNmbX4EXEp9QzKl51isXyi+YHJtp2BY+GdBOCJ3Nmv10m01g+ME5cPHJgb/Srj
         QLWRpih//vPNVoNbYJFHy33iXjr/jafHfEgvAAMhkyeus+kE1BpAhuOZQ2JMVvFGM06X
         SOoyJTGZfPxZFz+tgcD5RaiNR0O5Scj+C/3/18L8/E71VblJen/yE1XI6EHG18HduGEp
         WxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763990799; x=1764595599;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rMtl4mZM6wbPh/gq3v0gglxecaWPQ/BHVmZQ05nRW8c=;
        b=aNzcPuFgWAATZXm9dgvqxBQM1AiSfgRL3tlUvoYboGwaq3ZEsNCBmayEvOnvQCpvQk
         RWBXgMRQPkh9bu0yJFscDbq2bl7BDZQ1ILYaUfAt6/+KA6DCrHa6oFTRtOgCOIZp3MIs
         oKuwDPRJbtdDCNgk2YzhRJCmmB++zxdh52DAUDXrc+WGVRLHtff1dbFzfRXBaa6NN8gY
         6tGmaltTteWjFZjXyvEezEntNV/a+kV5Ucz10XFX1POYo5av9B0lHT7yUPuFnd+b2ct5
         Dx/JRr6DMnqMTpGtrY1ojkq4tuVuvsNQxVB17lId13QuRhJWwg0pwoFtLfq8IqTUdkoH
         9Z3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX0GYHhua+JDbpMIKsj2JkiQ+ZW9fXQcx+oLk5KEZkhN6fn37B5fNwzAQm/5Ibqv75ceWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPqMrpg98PfjsugqIAOM+Rp0uyMqUgq8cOVbScjDStx/QIoMo2
	w38LyM8RhLP+Guw30p/IcNBR3GsThV5IysYKlqiyAYzPXNQaFSOe6OfXTTSBV76/+N0de4hT6Z4
	8mD+2xvu7zEdpg5LfXkeD0bSL2aQZ4zHhIQ==
X-Gm-Gg: ASbGncsws0OVKWLphnKsJauL8KLV379tf8HudJlOoHhVTO03f5/M0UE3/lHYHU/BDhe
	bgqXXn5ywgYBnM+rSku/pfLH+jup5QI03TUTCG5w6J3gHcCviD0Kh5XHXf5rhHHPelTO0HmZ8hL
	7AO6ylm8AmnxHJoUfHr9sCqYTegeBjFnrEbSBEYR8uTmJPGy4OoXzErqFFX3sLn0TF6XCWiozva
	5EB3mcJFSD21HkG78sgiFfVxwU5GdA2Qqoyf2BlMz3wll7hARmXnQg8yupd8myNgSlsFKFue4PI
	TNzGqnlvwlxuqDmY187c3s9Pi5ED8Q==
X-Google-Smtp-Source: AGHT+IEv3BwWhpYXxN7WV7HIgEEKAB1Irc0ETYUt7HuOxKShcbgq/6gBZrX53H6a6qu33bA5Vci9SfFilv+CnDucfiY=
X-Received: by 2002:a05:6102:2ad3:b0:530:f657:c40 with SMTP id
 ada2fe7eead31-5e1de3b1fa1mr3700188137.22.1763990799570; Mon, 24 Nov 2025
 05:26:39 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 24 Nov 2025 05:26:38 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 24 Nov 2025 05:26:38 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <87pl9b5wos.fsf@iotcl.com>
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
 <20251119-kn-alternate-ref-dir-v1-2-4cf4a94c8bed@gmail.com> <87pl9b5wos.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 24 Nov 2025 05:26:38 -0800
X-Gm-Features: AWmQ_bmmn6tlv7HVJrqiSbiYHfh3bEKLtbz_CZGsKjC3xKXXTnVwUVfHdlB4TBU
Message-ID: <CAOLa=ZScEu6YimZwdgGXSd0+7YGOOy_iL7M4APAMVPJkC7Pn7g@mail.gmail.com>
Subject: Re: [PATCH 2/2] refs: add GIT_REF_URI to specify reference backend
 and directory
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000fefbcb0644571c12"

--000000000000fefbcb0644571c12
Content-Type: text/plain; charset="UTF-8"

Toon Claes <toon@iotcl.com> writes:

[snip]

>> diff --git a/refs.c b/refs.c
>> index 23f46867f2..0922f08c9f 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2186,15 +2186,66 @@ static struct ref_store *get_ref_store_for_dir(struct repository *r,
>>  	return maybe_debug_wrap_ref_store(dir, ref_store);
>>  }
>>
>> +static struct ref_store *get_ref_store_from_uri(struct repository *repo,
>> +						const char *uri)
>> +{
>> +	struct string_list ref_backend_info = STRING_LIST_INIT_DUP;
>> +	enum ref_storage_format format;
>> +	struct ref_store *store = NULL;
>> +	char *format_string;
>> +	char *dir;
>> +
>> +	if (!uri || !uri[0]) {
>> +		error("reference backend uri is empty");
>
> I see no localization on any of the error() or die() messages. I think
> it's worth to make them translatable.
>

Yeah, that makes sense.

>> +		goto cleanup;
>> +	}
>> +
>> +	if (string_list_split(&ref_backend_info, uri, ":", 2) != 2) {
>> +		error("invalid reference backend uri format '%s'", uri);
>> +		goto cleanup;
>> +	}
>> +
>> +	format_string = ref_backend_info.items[0].string;
>> +	dir = ref_backend_info.items[1].string + 2;
>
> Length check before jumping to the third char would be adviced. Also I
> think it's worth to check if the first two chars are "//".
>

This is a good point, will add a test and fix this up.

> --
> Cheers,
> Toon

--000000000000fefbcb0644571c12
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b229d9e76ecc6418_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ra1hRMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md0JBREFDSlJhcjBucWRqNThLdXUxdll4RW1PMmVVRwpvanZwZkF4aGRj
a2NnNWlrQnhjaVdNZVhXWFhqODhkYVFUeUFVQSs2c3BhVjRwbEZ0Njh4dzBmczhhRE9vOHhmCmFY
M3ZacGZqaUlScDJldmM5MUc3Wkx1clJxMExPOXdxaG5oNDhmczdQUlIvdWlZZHRFVFZSaG1wK2to
SGp5bkIKZFBMYnNuOHp4LzZWMWYxYzlPRll1bkRMNENnM09vTFJTa3F0Y3RRNlBjWCs4dzBMSGN3
b05KMHhIbWswSS9OOAoydlZ0NW1DWnJOU1BDV1ZpWTlhRjFqV3I5ZmxpdXE3cWZMY2dyakJYRW13
Qk0vM2Q3eXRmcWdKSU9KRDNHTS9DCktEQWlaOHNzaXkzdGxHWFozV3FtQ0tmMWc4STlLRnRsc0tl
aGFuUmxlSmFIdkRFVDlDUVJTSGIrbi93aDZhTWgKbmxKTThCcVJtK0NISk9qZDUzUVhxUlVCZXU2
SFJieUhBMjUvV25GN3MzaVA1L3p6MVo1VE5DeEZCRUJrc09jNgp3NGJHd3hveDFTcXhjSHdWZ3Uz
WjFHcmQzZXJHenVTd3A3OUxEVCtDdDhFdmREYmgzTEN0TE5FWVpHYjc1czdMCk5TQkNqSzVoN3J2
a3lZeExZQ1VJWmZGdXNRaDU0bGRISFFoZ0loaz0KPUFFd1YKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000fefbcb0644571c12--
