Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F860201012
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 08:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740127449; cv=none; b=hUR4ivejsfHnai1iT9OKeXMIt2MZhVT1N8I+968cYhq7V9SMJXoX/JyLWQbBRaKNGbetk2Ak2XNZy1YrUCit4BBPCpXLThzCb8OWV6TGgErXxju2UdmbFqJe/9SdjXl3RD6BnsRHooEprym4QWhVguFYEdgo9YS7Q3Cdlp+Hz7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740127449; c=relaxed/simple;
	bh=ZyYLXiw8IbqWCcVV9Z9OMaGJIpD8ZG+N7B2O9dVgP5M=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NkYgADDPKjAXVWoH9AHImQRH/MWapE8B9pu0r13einJHbD67zulnmHiS2yIV1ZMw3y4nHbEyRWo8ZH1cpX5Zy7H1LGj9E5iWx7i7DM3dxoy97x2p7wdpKsc7+ZJ2h63DUAUqJ6QUhh5Bhi1zhlEqONTe7qT8xNlLrIt+l+zt7w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsbPAfKZ; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsbPAfKZ"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-86718c2c3b9so456844241.2
        for <git@vger.kernel.org>; Fri, 21 Feb 2025 00:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740127446; x=1740732246; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VXAuJQ9mJJphuhqzIq2C38ogitYSA7rrsuT9jJ+U1QI=;
        b=OsbPAfKZmsM6FtN0USB74vvNKIDGHDTKhhBOkr4fCQu+VUMCNkkJmcMbNKJLZ49xx9
         q86Z2s6sItSjBwPfdy7W6qBL+Rwn5Jw9StuxjUWt5RfZlN2fwGUgQgDBXMOfWhSoV5aK
         sNQyWJwIEP5gpuLUSs9WxBUC20I+Bu/aed8AUNMeMdBkIWahk9iwEqxIkrw7yfGeQ5Iy
         +K89iyRxTohiRnHMj3uuijuxvrk3koUfOeHyQHeWNzcOHB/RT1OCg4sPnbPwHZztXJFy
         qC72KPHmks4q4hZtDft0zKrSnK+BkjPVkHXc8jmOa7xffK6qYfZePWoJEbbtoqaIj6O3
         VMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740127446; x=1740732246;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VXAuJQ9mJJphuhqzIq2C38ogitYSA7rrsuT9jJ+U1QI=;
        b=WBkB58rZesF9k+VtXv519fjvy/f8umtJ3r053NFaoiSc6GLp803ifbvtySFH7Vmm5B
         h/FU5CadXhXvqS1zlyQUuf0Yc0XGRyjCajm74SCMNQlQeCljknNVGOKV+vnJH36+XCsG
         rUupnPD/IltpoMvZIDKlQkBBEkEmnT1gWEtAwVImM+7XwiowWLLZO4B4ggJ48oHXoW8p
         C0+sdlhZy2kJqJodSwVBoZBw+XApvw4ZmC8ykLiap7Qgmt3mURd9azIm1T/YLhRs9AiW
         NoMs1C0kH4iMiHLnKxNzMERzLLdFTOaP67KiyJKZdN5qqjkwdQFNEoMDH1llxwNrbvVE
         qY2Q==
X-Gm-Message-State: AOJu0YzyNM76lc1OPVyMQcs06RlcDxkWRzAVNPBAmvWen0HPnjzJzdkF
	NHcNh0knQDCMhzDJhS+K4BNbhMiJgKMRPV5qi4sRW2C5qwWXqqA+KRWSpWua+CLqVHx7CWTyuWd
	T8Hi9+xOxmMDwe5ChXk2aRsAfuIY3vsYJ
X-Gm-Gg: ASbGncsTkkZswEUInGxQcSj7yRMOfpWHJTEzNwVmJEsaC9lvMvBaeQQMqKcp4Zsclto
	kv3O0lfIPeAd/yHbKeDFomhfJTF8my6ZoDH76ZBbTzsoCS/fN+leSxF/1PMiVa4nxYF+vKVj0p4
	V3uf7nWObEmrSSur1U4CmjeCHdNGGq7LSHl9++WLwExw==
X-Google-Smtp-Source: AGHT+IH91BorRNuupZ8p57SojWORyG5j/paJiInVY/7mHIGXDTU85+Gx80fb5hVJwhL8Uqc/OEODUS8i8ipeQtuP3bw=
X-Received: by 2002:a05:6102:26c7:b0:4bb:cf25:c5a7 with SMTP id
 ada2fe7eead31-4bfc0086c7bmr1549782137.7.1740127446437; Fri, 21 Feb 2025
 00:44:06 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 21 Feb 2025 02:44:05 -0600
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqikp4eji8.fsf@gitster.g>
References: <20250207-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v1-1-7d40f3b4e30b@gmail.com>
 <20250220095614.62042-1-karthik.188@gmail.com> <xmqqikp4eji8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 21 Feb 2025 02:44:05 -0600
X-Gm-Features: AWEUYZne0J3_obbUd34xdlhaX3jP5yCz7IgA-1VOKOIGX3Yfa9OmupmRxCRDqZk
Message-ID: <CAOLa=ZSL-X_8s6vcDiWBp8G3+M8GGGA1wBRtNqqThyq94YS16w@mail.gmail.com>
Subject: Re: [PATCH v4] builtin/refs: add '--no-reflog' flag to drop reflogs
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, toon@iotcl.com
Content-Type: multipart/mixed; boundary="0000000000004f34f7062ea2fea0"

--0000000000004f34f7062ea2fea0
Content-Type: text/plain; charset="UTF-8"

FJunio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> The 'git-refs(1)' migrate subcommand, which transfers repositories
>> between reference backends, currently migrates reflogs by default as of
>> 246cebe320 (refs: add support for migrating reflogs, 2024-12-16).
>
> "transfer" is a curious verb to use here, as it almost exclusively
> is used in the context of fetch-and-push object transfer over the
> wire.
>
> 	The "git refs migrate" subcommand converts the backend used
> 	for ref storage.  It always migrates reflog data as well as
> 	refs.  Allow it to optionally discard reflog data.  This is
> 	useful because ...
>
> or something?
>

Sure, I'll modify it to something along these lines :)

>>  builtin/refs.c          |  3 +++
>>  refs.c                  |  8 +++++---
>>  refs.h                  |  5 ++++-
>>  t/t1460-refs-migrate.sh | 28 ++++++++++++++++++++++++----
>>  4 files changed, 36 insertions(+), 8 deletions(-)
>
> I notice there is something missing.
>

For a minute I thought I broke something here, but I'm assuming you mean
the lack of documentation.

>
>> diff --git a/builtin/refs.c b/builtin/refs.c
>> index a29f195834..c459507d51 100644
>> --- a/builtin/refs.c
>> +++ b/builtin/refs.c
>> ...
>> +		OPT_BIT(0, "no-reflog", &flags,
>> +			N_("drop reflogs entirely during the migration"),
>> +			REPO_MIGRATE_REF_STORAGE_FORMAT_SKIP_REFLOG),
>
> This is somewhat ugly, but parseopt API is nice enough to hide the
> "--no-no-reflog" nonsense from the end users, so this is OK.
>
> I think we are almost there but lack documentation updates?
>

Yeah, this was a total miss. Thanks for pointing out. Will add it in.

>
>  Documentation/git-refs.txt | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git c/Documentation/git-refs.txt w/Documentation/git-refs.txt
> index 9829984b0a..bb50d6f888 100644
> --- c/Documentation/git-refs.txt
> +++ w/Documentation/git-refs.txt
> @@ -8,9 +8,9 @@ git-refs - Low-level access to refs
>
>  SYNOPSIS
>  --------
> -[verse]
> -'git refs migrate' --ref-format=<format> [--dry-run]
> -'git refs verify' [--strict] [--verbose]
> +[synopsis]

I see '[synopsis]' being called out in 'Documentation/CodingGuidelines',
but nothing about '[verse]'.

> +git refs migrate --ref-format=<format> [--no-reflog] [--dry-run]
> +git refs verify [--strict] [--verbose]
>
>  DESCRIPTION
>  -----------
> @@ -43,6 +43,11 @@ include::ref-storage-format.txt[]
>  	can be used to double check that the migration works as expected before
>  	performing the actual migration.
>
> +--reflog::
> +--no-reflog::
> +	Choose between migrating the reflog data to the new backend,
> +	and discarding them.  The default is "--reflog" to migrate.
> +
>  The following options are specific to 'git refs verify':
>
>  --strict::

Will add this in! Thanks for the review.

--0000000000004f34f7062ea2fea0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 571f016908fb58ef_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lNFBOTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOHZiQy8wVHF1VDhsaEJxRmJZa3NaWFRpb0ttRnQvbApuTjRhWTQvaU9X
M0FzaC84STE4eTREazA3RUxXKzlYQWo0aHVUdCtON1lkM1lITXlnSnVNRFg5WEJSYXFuN1BkCm1O
blE4dHhhL1RoVTZocHhMbFV3ajExOHU1WmVTQzBLTnJaUTIxbG82YzNXRCtLT0dkRzZSWHVjTGVt
Z1RIaFIKTitqc3pTemNvUUIzK0FhUUF3K1pKUWhkSExYOVQvM1ZEYXVqUk05aTBocEpHL0FxcEdm
NWNxYzdvWERPT0l3Zwo1UFBmakdIQmtpWGN2N1ZGNTBMUHZUUjZUV3R1Y0d0RzNxWFoyV1Z4N0pG
ZnRMOERud3dyak1la3FlVDNrRE1kCmQ3S0J2WlMxcG15WUNYZVd5N1dYV29TSHRoVzlkdFlRSmFn
NDloci9sakhWZlZUVGVXSGw0citWeEp2NkcvNHoKT3FFYUlZbzkyNStRaEhzTERBNkkyanFXbGhI
L1djOVA5dzZaMEgrd2x5SCtuVHJrejRzZEZFN01jaU5lWVJDagpRUit5MThRV0xMelZXUURzRE5Z
dCtoaXFpTis1UHlRY1pwa2E0UFB5bHFFemZUZ01NY2xrUVFtRlJwTVZJdkFIClBkVTNJYndjTStw
bnJaWjR6TzZIZVRpbitoaWFGbk5meFNsRkdyTT0KPW9OcGEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004f34f7062ea2fea0--
