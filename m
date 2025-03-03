Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49423CA5E
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741033340; cv=none; b=N7WUFWsBFvrKLO3I5bMpA2LcYt9FJ1v+2e9HSzvcsc/hN9+JGrXdVqKQwGQ1fB4EWOqvQ0MqMN8iImefYcYaG2a2gB7u0iCasAURT+Qzhp9unIwFnr/5iatQ54ZJvKIqQ8+nc7H2uHoxNFXuzxPBJu4Px4DQ5elWegTtN9cZfu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741033340; c=relaxed/simple;
	bh=34qZ21y8FnY5aw/8XtvUJHLirpRkCDGJfxSjsnGwUOA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n1tabxtjsYahpbQoLotpder5Ybm5gUioCteNs/zSwAvjQUYze32heAH+qcdCD1hglKhrTlRocAdqqOXD7S2gEdHQgp37fsKu7egSeKNkWzgX5nqdsQNJpTH32Txra6Pzi8/HGIcL9vh64Elp2e5h8aE4NorNjCjD5OhQbUnCn1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmJV/Hiv; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmJV/Hiv"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5237c18a97eso617105e0c.2
        for <git@vger.kernel.org>; Mon, 03 Mar 2025 12:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741033338; x=1741638138; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=s2Hv9WskISe6+ayJ00hNL5EFb8eQRKuaATN43ZPv9lY=;
        b=fmJV/Hiv9CgzG8TqpvRfjdSFPAsC7NGaU3SS+hn7MCrbvZZ7p5mTwLQ6lqMjcTUSLa
         7mzZQvQQtjiVkPbAgex4l7h885VogZznptU2NT+Z+O/YDGH0LA2+1UaS71vk7CnyBTC4
         LlZh7Vc3+crQPpvjr8OU4TSekIdruAaEB9VE4gvFnifEWb0wR1Tby/sx+xrkfeRs84Sx
         paH3o40q8xeOwSUpQYIKqqxXT/wgKkpZlj+lELblE0q6tsFIJjSvml15G5w/Yir98AjO
         ODGZFoeoqhhduKBesMKojLxv9jkOSMM5FjwhQ2cbvAo8ECa00pG4/bVY+PszZG5U3csk
         ZG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741033338; x=1741638138;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s2Hv9WskISe6+ayJ00hNL5EFb8eQRKuaATN43ZPv9lY=;
        b=AEJPyEJXva75UcKJS90PNpIJ/qqFtO7hXrUJov0wGVva1DfoQ7SGrivgacmM3tkZ5c
         hwot//+QXeXI1Eb2tmJ8uyNnE2N2DnYhTZrcVqk+NbkT8NPgSZybqAHU9VOKUG3L0o1N
         y+OlRPa5OHtQImSuWyUjPctzSoMNu6aVnqARZxfKMpMKFYXh8kLI3HQgzLOQWE7kZMBV
         axOxwlQHwYKVURu713kdsJv16QtmRfQAwj9OkC0sh9H50mSINR5G/g1AIedjNRKn5zOp
         IR3kyjFH2co0piaVx4VgtlfjrqV+q4AkMskPOd5nGqmYNTscm+PYoSQufix28drr4hHB
         iclw==
X-Gm-Message-State: AOJu0Yzdaj9XhjAPeqlUTIB7bzOb6c2X+zps+wF8HyrDGPaZoct3QXPA
	KI8pywnZUVU99WvAWeowmi4m5jabZPv2PTAEAWZNfaGO0GbAgZPpTILvTsaGQCy3mpsZRoJMtmH
	jcXA8rg3ghXftNLg0xzEABDnu6AkdfeW+
X-Gm-Gg: ASbGnctluJBc1A4dx6ApRziJiXIb/JLwhun7fIkMch0TXSg5TywclUMJxFQjAqST/Ud
	F8rAri+2erx40L9WucTbNrFCYXPg0xs3wpDgTE+bG76U24BKIH9L5ysCy1IChJz7i6u7ZV+Z++9
	3W3fq4zUSEgky9Ahme712SQthsRDoKvpCbidqCTyLCqSCEK6Hv555Bowvf6HE=
X-Google-Smtp-Source: AGHT+IGeKSJvcczdB7T4dbCuE/UzT3QtaJknbj8/PK1OiMw/ZjfHuDHs9+IWncYK2OGmMrPnC08t+shn7GoQFxsXKR0=
X-Received: by 2002:a05:6122:d14:b0:520:60c2:408 with SMTP id
 71dfb90a1353d-5235a8e449fmr8989246e0c.0.1741033338118; Mon, 03 Mar 2025
 12:22:18 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Mar 2025 12:22:17 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z72klAEpQ0-cWCGa@pks.im>
References: <20250225-245-partially-atomic-ref-updates-v2-0-cfa3236895d7@gmail.com>
 <20250225-245-partially-atomic-ref-updates-v2-7-cfa3236895d7@gmail.com> <Z72klAEpQ0-cWCGa@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 3 Mar 2025 12:22:17 -0800
X-Gm-Features: AQ5f1JqOngtGzsnAQtLWCXsUx5ngA7cOWT4E7nT9nGnY9G78_lfSRYmhcxNXYM8
Message-ID: <CAOLa=ZQxziRioY9Ws6jVE7MikJifrVB3p9ifNMBn6cQFjuLZYw@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] update-ref: add --allow-partial flag for stdin mode
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, jltobler@gmail.com, phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="000000000000a94364062f75e928"

--000000000000a94364062f75e928
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Feb 25, 2025 at 10:29:10AM +0100, Karthik Nayak wrote:
>> diff --git a/Documentation/git-update-ref.adoc b/Documentation/git-updat=
e-ref.adoc
>> index 9e6935d38d..fc73f1d8aa 100644
>> --- a/Documentation/git-update-ref.adoc
>> +++ b/Documentation/git-update-ref.adoc
>> @@ -7,8 +7,10 @@ git-update-ref - Update the object name stored in a ref=
 safely
>>
>>  SYNOPSIS
>>  --------
>> -[verse]
>> -'git update-ref' [-m <reason>] [--no-deref] (-d <ref> [<old-oid>] | [--=
create-reflog] <ref> <new-oid> [<old-oid>] | --stdin [-z])
>> +[synopsis]
>> +git update-ref [-m <reason>] [--no-deref] -d <ref> [<old-oid>]
>> +	       [-m <reason>] [--no-deref] [--create-reflog] <ref> <new-oid> [<=
old-oid>]
>> +               [-m <reason>] [--no-deref] --stdin [-z] [--allow-partial=
]
>>
>>  DESCRIPTION
>>  -----------
>> @@ -57,6 +59,17 @@ performs all modifications together.  Specify command=
s of the form:
>>  With `--create-reflog`, update-ref will create a reflog for each ref
>>  even if one would not ordinarily be created.
>>
>> +With `--allow-partial`, update-ref continues executing the transaction =
even if
>> +some updates fail due to invalid or incorrect user input, applying only=
 the
>> +successful updates. Errors resulting from user-provided input are treat=
ed as
>> +non-system-related and do not cause the entire transaction to be aborte=
d.
>> +However, system-related errors=E2=80=94such as I/O failures or memory i=
ssues=E2=80=94will still
>> +result in a full failure. Additionally, errors like F/D conflicts are b=
atched
>> +for performance optimization and will also cause a full failure. Any fa=
iled
>> +updates will be reported in the following format:
>
> Shouldn't it be possible to detect F/D conflicts though and not abort
> the transaction? If we want to make use of partial transactions in the
> context of git-fetch(1) and/or git-receive-pack(1) we would have to
> handle them.
>

Yes, this was a miss in this version, mostly from me not thinking enough
about this series interacts with yours. This should be fixed in the next
version.

>> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
>> index 1d541e13ad..b03b40eacb 100644
>> --- a/builtin/update-ref.c
>> +++ b/builtin/update-ref.c
>> @@ -565,6 +566,54 @@ static void parse_cmd_abort(struct ref_transaction =
*transaction,
>>  	report_ok("abort");
>>  }
>>
>> +static void print_rejected_refs(const char *refname,
>> +				const struct object_id *old_oid,
>> +				const struct object_id *new_oid,
>> +				const char *old_target,
>> +				const char *new_target,
>> +				enum transaction_error err,
>> +				void *cb_data UNUSED)
>> +{
>> +	struct strbuf sb =3D STRBUF_INIT;
>> +	char space =3D ' ';
>> +	const char *reason =3D "";
>> +
>> +	switch (err) {
>> +	case TRANSACTION_NAME_CONFLICT:
>> +		reason =3D _("refname conflict");
>> +		break;
>> +	case TRANSACTION_CREATE_EXISTS:
>> +		reason =3D _("reference already exists");
>> +		break;
>> +	case TRANSACTION_NONEXISTENT_REF:
>> +		reason =3D _("reference does not exist");
>> +		break;
>> +	case TRANSACTION_INCORRECT_OLD_VALUE:
>> +		reason =3D _("incorrect old value provided");
>> +		break;
>> +	case TRANSACTION_INVALID_NEW_VALUE:
>> +		reason =3D _("invalid new value provided");
>> +		break;
>> +	case TRANSACTION_EXPECTED_SYMREF:
>> +		reason =3D _("expected symref but found regular ref");
>> +		break;
>> +	default:
>> +		reason =3D _("unkown failure");
>> +	}
>
> As git-update-ref(1) is part of plumbing we don't want to translate
> those messages.
>

Makes sense, let me remove that.

> Patrick
>
Thanks for the review on the series!

--000000000000a94364062f75e928
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 10dac8e63b2e1ff3_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mR0QzY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMjRrQy80a0lEZ3J4N3VlZnBPTkxaYy9PM3M5MnNNeApKa2lXWDAwK0tW
aWVpVi9veWdyNjRZOHFaNFM0N3NpRTVTTjFEZkxBRVdkWFZBdVJWTmRkYlZ2NStSMFREeDBQCkty
ak5FZVpteEN3U2J5RzZYZy9vVldxS1ovMGNsUmt4MGllU3FOODNYbm9aZWRDNWwrWWNHbFM2cEQ3
b0hDTzEKQ1kzRW1GejNaSThBdkFkcit6RVVDVFRNMkRNUktxOWdYbitvWHdPZ0EwZVoxdUh0bHVV
TDVlVUREb3VLTjRpZwpyeUpyd2RZKytlM0ZDN2JBRkQ2OEUwdU9nbzZkZDNVZjl4UUtJUHFQUzNx
bnpFMzNuckc0dklFaVY4cWFiNExkCmVUQXhIRE1uWENPTkQvSjFrOXJaaDFubldhVVE0OVVxOVZr
bHZnbXpOcUNGVVFQVW9VU2hmZ0YySmptOHEzT3EKNDdPYlJmT1VMaW1xczBCR2tKenR5ZzNrb0lu
UGhXeC9kTTl6M3kxS0Z4Tit5TXBib09HZ0k2aDRwbkd1T0pPSwp3SnpSNWpqSWJxSlVaRFczbDVC
NFRQb25sUXR6d3pITEk0OXlwZjJwRU9wODJLU0dUYkxNTnRZOGNBRWpGSkt5CnY5WHdERk9kMVBz
MXgraFNqWVZySmVqcTduUVdtTXhUVzl1dUdsQT0KPXZXTksKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a94364062f75e928--
