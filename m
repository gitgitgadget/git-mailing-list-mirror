Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB7810FD
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 12:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759752160; cv=none; b=KuroVg0o5htwOMwHnRYizRz/DeZh8dfIcSu9C6xdqpp1RtgZslDGKeQO2q+i2fDhHx1sPpHj0xI+FhKiaJEZk24qRCX8h4He0udHB8Hu6zk3lK984Ju1djvXzcQMv4jbWySJniyMJcBOj79kpIOzruXZZ6T+SAHNuCttls0mO5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759752160; c=relaxed/simple;
	bh=eA3gfP7mQMgQBuZRbEkOhTNBaoWWvGaWd5QuFM//4g8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tY9zhyJHP3UelvZ5CywGjjlCCUMv1bpN6HkmYyYLR7hR/bprs6DsqZ4nmdR0A0r5hkc8UKMK5Xds88NktPIHz1Gb5wl5MdOPRfyA0sgOiLukfvHKH6/e/1wpxemA04s0rd9m478Qrz4x0X4ZS5HOtOj/21+wJFJ9kdQKz8Ip/AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDhi20ai; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDhi20ai"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-54a7bf06edfso3380156e0c.0
        for <git@vger.kernel.org>; Mon, 06 Oct 2025 05:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759752158; x=1760356958; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/g7/uvfZFOdySs/gP+qAP5nPcVslVla3mzoYMdRmnyg=;
        b=lDhi20aiQn8xhXjx65VbWocUr5xykLg+/Yx8L9jljMCyAhPqMv1Yjq8f5MrzqYtiWG
         SW4s3kf4DYmnBKGray1wQbENje4tOHpTAn7eMWlwPKTtD+150ag/iyX1hlEYp79C5OxT
         SJwZa0Ku3GpxegCewd6xiJEdkeW1F9KMvC+IhXiGMtrZzXjH2RepzAOuqC9zD9MXc6Mk
         tVicICgqFi60j5mfocw9wwWmJ6alrTlOICsjwY5adwIFeUEw8faF9K/ifdKxaZ31ax2C
         2wsIrLkJ1OTfw7H3LzCjX3vHy4M3SZT4m9+jTYkakM+saf/KJh8SOCVMJeHE3c3OZ976
         8YMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759752158; x=1760356958;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/g7/uvfZFOdySs/gP+qAP5nPcVslVla3mzoYMdRmnyg=;
        b=dBDokX59aMrCzwGPHd8LXUCJpbgUX5B7ivCyLXk0hbEITvHvL8q6MFWum8fB+69lIY
         +8HE4mrhjLHcPCDWJmlqbSF9d4Tzs0cDs/0MO2bro0kHcYjyW6teAAU6ZnkOepf38lDk
         loh07K1jOgTvBihTm5we3RJyUXyvL6ndfX3PhSElnwx/MB4aYK5gpdnnk1OwPm4JkgET
         82guwfGj9vUQ/kg4I6iewpfeSfhUtgt2+PM+YFqr49yJ9VR160B63hNMoIAOe1n6XOkL
         Ua/yGFZY0AxD2LkY1O8+TBjuEkbyuft4cex2NiDAFInt2cFQX9h1YXMUjfXR+vGSGEkH
         WQoA==
X-Gm-Message-State: AOJu0YxKeSuL9b8PVNFkuthWMpvXv1w7o+Uw05yyYu9YmVQt2GFwszNZ
	zUNEtiMlM8ivrXHM7f/eb+AT9kheLMjT9i9OskiW0+7XmhHSGUC54s7x+uKOTWBA/97hGw6lM6n
	SV2Kcal5u69DtkiUNbqD5YzkOV4Ra3+U=
X-Gm-Gg: ASbGncuojFAclyH/Y8BYa0DtNYrURNotmBcS7jOpA+VCek3PybQU+Y95qxozr6/aNMH
	o7DOOEU5Grun6NSSVClmvBdZFJs1uvS7k9acY59kT0sCfPgENQPdRNSMSLng95c5dtYMeG1Pn46
	AgtV1ZFOb3L+5KZtWTmaSetxLa28cZ110vgVHroR3uqviRzfxuxNUXxXEoWFfwZgKsQTLUcctL4
	bbfPGqolWYYyWfEoO/3jaGfrKQEHN1wygaRf9XZ
X-Google-Smtp-Source: AGHT+IGaPWVPk0DJiMYz0T2eHFaAwbvC6VZEUnJkEwkZli041ge5lbWgzA2GWPB3dyvM5o9wv8PWSE+6GDpV+kiIogk=
X-Received: by 2002:a05:6122:2190:b0:539:3bb5:e4d6 with SMTP id
 71dfb90a1353d-5524e8669f3mr3678261e0c.1.1759752148128; Mon, 06 Oct 2025
 05:02:28 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Oct 2025 07:02:27 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Oct 2025 07:02:27 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aN5lmEx7Q57YEyHH@pks.im>
References: <20250926-228-reftable-introduce-consistency-checks-v4-0-c96fd8551c0d@gmail.com>
 <20250926-228-reftable-introduce-consistency-checks-v4-3-c96fd8551c0d@gmail.com>
 <aN5lmEx7Q57YEyHH@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 6 Oct 2025 07:02:27 -0500
X-Gm-Features: AS18NWDbfCgYETpPuRqzXoRx-R4LLjoew3UhJC6IaCvpAujzNWM7Cwj-0zsp9DA
Message-ID: <CAOLa=ZT48BV5Xs8R0Mwi1tpMHKC1jrR8AGScHHAq37xU4_UpOw@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] reftable: check for trailing newline in 'tables.list'
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com, shejialuo@gmail.com
Content-Type: multipart/mixed; boundary="000000000000aeb56a06407c39cc"

--000000000000aeb56a06407c39cc
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Sep 26, 2025 at 09:25:46AM +0200, Karthik Nayak wrote:
>> diff --git a/reftable/basics.c b/reftable/basics.c
>> index 9988ebd635..e969927b61 100644
>> --- a/reftable/basics.c
>> +++ b/reftable/basics.c
>> @@ -195,44 +195,55 @@ size_t names_length(const char **names)
>>  	return p - names;
>>  }
>>
>> -char **parse_names(char *buf, int size)
>> +int parse_names(char *buf, int size, char ***out)
>>  {
>
> Yup, this changed function signature reads a lot nicer to me now and is
> more in line with our usual coding style.
>

I have to agree with that. It would be so much nicer, if we could return
(value, err) in C. Anyways this seems a lot more consistent.

>> diff --git a/reftable/basics.h b/reftable/basics.h
>> index 7d22f96261..693db9524f 100644
>> --- a/reftable/basics.h
>> +++ b/reftable/basics.h
>> @@ -167,10 +167,9 @@ void free_names(char **a);
>>
>>  /*
>>   * Parse a newline separated list of names. `size` is the length of the buffer,
>> - * without terminating '\0'. Empty names are discarded. Returns a `NULL`
>> - * pointer when allocations fail.
>> + * without terminating '\0'. Empty names are discarded.
>>   */
>> -char **parse_names(char *buf, int size);
>> +int parse_names(char *buf, int size, char ***out);
>
> Tiny nit, not worth a reroll: we may still want to document that a
> return value of 0 means success, and that it otherwise returns a
> reftable error code.
>

Yes, I'll add that in my re-roll.

> Patrick

--000000000000aeb56a06407c39cc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 43412d45e020e0d6_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qanI5RVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK0VBREFDTmNaWlkxRWFxVlhZNUtDcmNUc3ptTFI4cgpYVmx4SEhadk5q
M1FiVHJqVTBXY2dqNUJKSm51N2lpcTh5TVpyQm04T3l6OU9RY2F2Y1RTeUpBbDhUMmFWQU1sCkwv
ZmRVa29Kc3ZPMVdxbk4ra29aTC8xSkpmSU0zMVdxaitHdDdBUmxxNFR1M2J6QUhvdUxqeUxTZW1q
VDAyYy8Ka2hGR3ZYeHFPL25RaE9CNWRDWk5zcnA4NDhRNzZSWjU1RE0wWlVzenEwMU9xSG00QjlR
a3B3NmNycFBCbm9xcQpVMTRDQ055VE5rcHJsTXpzK2c1YXcvc05mN0pVZUVVMldiQmRqSU0rdWEw
dVpLVVpMZ3dXU3RVYXpQSkhkeFpJCkV6YXdjbUtLU0NFcm5XMzJEclI2eDJjOGF5Wmp4cDFaUE5C
YTQzcVV1a0o4WjlVb2t2UHlNeTlyTm9aa1lqNHQKVzJJa1pOMWk1ZGhwbjFzaGNIUlB6aG4zOTVX
SUY5N2VWWWQ3bkhza3RrVjkzd2tMRDhLTThOeHU2ajZYRFVaZApRZG1GUGxpMXl5S2hJb25XSllG
YlRsM1ZzUTg2ckRlSlJxOHJkWXlSZVhIRDZXd3Q5YjVLYUdSRmJIVHc4Y0tNCjROWlQ5WVd3a1dq
eEJvSW1RckZVTXdBNlUvQUNJci9xV1BLR2xBUT0KPWZlL2oKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000aeb56a06407c39cc--
