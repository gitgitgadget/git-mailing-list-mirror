Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0389450
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 17:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742838683; cv=none; b=cOxt2ci14A8qtW9lJ68ll7ZSvr8wm5UHGfdqOyuNMHxjkKV1ItGJoLXlCInnAfsr6cs2rUoPlgIgYPw1+M6PHiBYN1HvwkAJwMVUY0UgvxD2kf2TbLMYzu0SNtJChbSdSUh5LQI2wbF6NmTa+aKby+5QDoDw17ZKWH3UhUO/InA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742838683; c=relaxed/simple;
	bh=nQi8BbALV5ci/LRYQQRwvNIDgAXwVr4g0LlM2v+fNg0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q4nqyMh08uxe9QUbUotq0DiA2LhPfhDeQu8IFiLzTEyA7n767LnDbiODYHqE1OUYH8PLSLUyWqsF+dKY4Rd8JORUIkGLg0Mg9rH77aDaTDUVyquNdkqBemEAsf23MjO/GAgVcqUmrfAtwD8J4frGwNmLaEcNF9v4D+PULNO9Uf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6W0chHA; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6W0chHA"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86fbc8717fcso725632241.2
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 10:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742838681; x=1743443481; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=u0EIbvJKaEaMvbHXTtOKBwIzjOqJUJKYI9MNjQMpg/8=;
        b=B6W0chHAR7dOqOx4E2FOCr9+aQmmuN3uayi3gECWzTQ/kA6/AIZD6wRSBGE3cAgJcj
         WBgL+ZoL3WlD/c63Zb1tDE/IMraLKxqIrk+4P9o9UKwfaZHEnDieVfFCQrt6TMC/Y7n/
         q83tYK2ISa7hS6GfJ5tr0A7PSeMWpMjDbSedhq9DpqrRn0PtP8rtNxvEcs1wmExLJW54
         0ACVikXz9D3R9pEgljZwAdBr2CsSNsmyT8c5iDQL2SSY3Wrf1j8n7dHmrmE8bSe5m2gx
         S527dXxhdeYb2KBcarOQBOf8NRJ3Yi5soH2ykxn8APalfJIrvUCQnXyNW0iHdlQvEO6z
         A5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742838681; x=1743443481;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u0EIbvJKaEaMvbHXTtOKBwIzjOqJUJKYI9MNjQMpg/8=;
        b=NSulkOUgf3NNTknfvo6MgGY0ybWlxuaCNnl13Q+yPTK2nBuqiSrAOKZ1BiBxd4TNMq
         Ixrny5+njeE21pBUUcPq3aaXbhJ8zCe1ijiL32X1olr7UmPbg4g+pN+9cYuhh4WiBiUm
         WiuKGLI1xIAG9qPVH2UX9Bt+16GwGAIYEJ/ytwoWp7hM10AzUWrJVJ6e18DyFDCMg0g3
         izNLgWGAlqrOXlUySFfeBi6w5SI4ZDYUGKmy3Doer2cMoV9pb9wwIZk8oJBcAkJ9jiZw
         X3P3raHW0GoLn87aijjivFFZO3cxDAVsNT6WmpRThVVxx7mq15ELTNT588bDi2zb5yXl
         cBXQ==
X-Gm-Message-State: AOJu0YxpVGLAwydF9oJtAb9DUHuvhuosHYfyC/eC+nOsJlgNFa3nApq/
	LGPGVJzOFlWOOVehsO6Tq2nu+IqBvHoqBB3Bjt5gNP6tFqVHFCIwdyiL/frTZBwKBRh4RRzPH2Y
	j8t7dXp8FiQBDbzOXkOcnLo99DPY=
X-Gm-Gg: ASbGnctHvdvdVFTf3sKxS53VV6wogYJh4tdt93vIz18/dXZKMYkbpW4w2ZRzq0nlLxp
	1Qlj/Vvz0aIALX/BinbtGc7j/gBpjYH4pFfjewG3QzB2rXdPNJJxcLjpgriZDcdQhx6eQkIv+sE
	6dxlkeoGVRwLAep+Gvbne6DBfwbMQJFWoVpDk/lMDHzdR65svp22AHc5tG3Aw=
X-Google-Smtp-Source: AGHT+IEFPhCFVBJjK0/9ijjDalqMPBz2WdpAib3MC3hAyySiK5Iyl073CF7XiiqUGG/+zvWOv2iEkDnwgVWhJAHh/q4=
X-Received: by 2002:a05:6102:fa0:b0:4c1:76a4:aee4 with SMTP id
 ada2fe7eead31-4c50d5c5525mr10699846137.19.1742838680742; Mon, 24 Mar 2025
 10:51:20 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 24 Mar 2025 17:51:20 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z-FZQOYGPIuB2h-t@pks.im>
References: <20250320-245-partially-atomic-ref-updates-v4-0-3dcc1b311dc9@gmail.com>
 <20250320-245-partially-atomic-ref-updates-v4-8-3dcc1b311dc9@gmail.com> <Z-FZQOYGPIuB2h-t@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 24 Mar 2025 17:51:20 +0000
X-Gm-Features: AQ5f1Jo_CH3Sfs-1UWi-tUYxMmly1ZrizGdA8pV0B-oXlyqvvbfUb8cqjVkz-Ac
Message-ID: <CAOLa=ZSjETz71mmeULYy74djOLZWfsixNCcAfONrAteHjdDdVA@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] update-ref: add --batch-updates flag for stdin mode
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, jltobler@gmail.com, phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="0000000000007789bc06311a4008"

--0000000000007789bc06311a4008
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Mar 20, 2025 at 12:44:03PM +0100, Karthik Nayak wrote:
>> diff --git a/Documentation/git-update-ref.adoc b/Documentation/git-updat=
e-ref.adoc
>> index 9e6935d38d..5be2c16776 100644
>> --- a/Documentation/git-update-ref.adoc
>> +++ b/Documentation/git-update-ref.adoc
>> @@ -57,6 +59,14 @@ performs all modifications together.  Specify command=
s of the form:
>>  With `--create-reflog`, update-ref will create a reflog for each ref
>>  even if one would not ordinarily be created.
>>
>> +With `--batch-updates`, update-ref executes the updates in a batch but =
allows
>> +individual updates to fail due to invalid or incorrect user input, appl=
ying only
>> +the successful updates. However, system-related errors=E2=80=94such as =
I/O failures or
>> +memory issues=E2=80=94will result in a full failure of all batched upda=
tes. Any failed
>> +updates will be reported in the following format:
>> +
>> +	rejected SP (<old-oid> | <old-target>) SP (<new-oid> | <new-target>) S=
P <rejection-reason> LF
>> +
>
> Does this support NUL-terminated mode? It probably should, and if it
> does we should also document the format.
>

It only does for inputs. So there is nothing to be done for outputs.
I actually added support for '-z' mode here, but there was an assumption
on my part that this is for both input/output.

Phillip corrected my assumption in the first version of this series [1].

[1]: https://lore.kernel.org/all/ceda422e-8c8e-4a1d-aaab-9a7a2fc009dd@gmail=
.com/

>> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
>> index 1d541e13ad..97e14b279e 100644
>> --- a/builtin/update-ref.c
>> +++ b/builtin/update-ref.c
>> @@ -735,6 +787,8 @@ int cmd_update_ref(int argc,
>>  		OPT_BOOL('z', NULL, &end_null, N_("stdin has NUL-terminated arguments=
")),
>>  		OPT_BOOL( 0 , "stdin", &read_stdin, N_("read updates from stdin")),
>>  		OPT_BOOL( 0 , "create-reflog", &create_reflog, N_("create a reflog"))=
,
>> +		OPT_BIT('0', "batch-updates", &flags, N_("batch reference updates"),
>> +			REF_TRANSACTION_ALLOW_FAILURE),
>>  		OPT_END(),
>>  	};
>>
>> @@ -756,9 +810,10 @@ int cmd_update_ref(int argc,
>>  			usage_with_options(git_update_ref_usage, options);
>>  		if (end_null)
>>  			line_termination =3D '\0';
>> -		update_refs_stdin();
>> +		update_refs_stdin(flags);
>>  		return 0;
>> -	}
>> +	} else if (flags & REF_TRANSACTION_ALLOW_FAILURE)
>> +		die("--batch-updates can only be used with --stdin");
>
> Nit: formatting, the `else if` branch should have curly braces.

Ah! Thanks, will change!

> Patrick

--0000000000007789bc06311a4008
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8d61fa30d3de8dd0_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1maG01WVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meFJMQy8wU1FtRFhqUVBVUXIxU3BwUFh6TzlBdnF0NAovcEF5aXFTcVZL
eXhJZzFqcEE2YW9pcExVbEhJNzhTa3ZKMnk2ZmIvZ2FnWVZKeFc0elM2eUZyQUd5UUkxeU0zCjZh
M3BnaElVYjY5UGxaN1RKNEJFZkdXb3NZemdGQXZtNVR4cFZZZWN2RHUxaWk0YW4xTDA5WkFVZm9Z
ZFhVWVYKT3pvL0N5eVIrcXUwSkJVSzkrSjdPNVVkaDZrK2xLRGJRT3NMSlhLQWtlcU14V1R6Y0lq
NmRXS3QrUGdjU3JSTQpubStkenZOMjVha1ZRWmx1UE5hMDkvd0NCVE82UmJ2aElyYWc2M3VFSTBX
WXpvU1JCaVZpWi82ZFloRURaUVdOCkg4Rks5YmZjcDhDMkhhbHhJV2xuNVNtNW00Tkx0QnRpL1pG
TlpjUVdaQmh2Rnp6SDZHdUJDQWx5T1lmMVZsUkcKc3R2MFpaRjJKaDN0dWh4M3dZTjBGK2J6Z0hI
Zm0xMXplYWxoVTlzVCtiUVdtWlU4M3dWdDc4YXJvbmpXSFFQVwpQcUl1UkxVSGxUc1dwVHZ2Yllp
dE1KWFBId2RSUzBUYnZaRHFmVzUrYzF4Nmt0b25aRHRUYjhFbTFyNk8vTDZlCkJ3K0xXaC96N1hH
Z3N5NE02TmxTRE1sSVNrWjRxMFlFZEg3VGxLbz0KPW56MDEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007789bc06311a4008--
