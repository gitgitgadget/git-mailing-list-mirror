Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A7E1CB305
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 11:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732275049; cv=none; b=lYmnXHcnD9je8k1EIxUBET6KUG/EDjySAuPMuIZ78Es3VJzgE4epQtxqgDCk77dwMW4xsuiJoeRioGP7kMXny2BxLH+3SJGJoLCcVmHF7SSRp3bmMCim8zKCE56L6dPkllFcV7Sacu2YdnYfTPzr4puOlqnIkZQRnZ9qEXitbjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732275049; c=relaxed/simple;
	bh=/ovh4dCsCwkHtdMtwhfhV3oMhku+Jt1EOpm+/oziDeI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K+V+fGGjPw8Fbz0yyH/SsySAFsGt8TZwHG3EbfZyMYP4CFE7C9vmsAPMu4UyhqYJkZb12rLTRkoP91g67ffeBe7GmhtokgwNuQmw2/ievb4UUAc1L4i855FcNNUFLCK8tIZFUX+u02NWKJ/uUbFqbxV8dB/yZpBCtirFbnPxAkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHJoybdq; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHJoybdq"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-856ec390e30so729998241.0
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 03:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732275046; x=1732879846; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zw+aL3+aDbEE8QLWGlFE9XEoN8lP9e4KsY1b4TQab1Q=;
        b=GHJoybdq46qas0GEBA+Du2bjwPGu9C05EAE7FUyYnIghJl7tDrfdiA8PwtezMamXL+
         48Itl0jqS3hhqDXCv/pp7+sKi33SwI9zF0K3AHjf9GTk335V3F0yl1WXKxuYVJFaSBPN
         PW8F9eRR1J5NGFNN35mdDzIVfNVdSXvire6fzuuJ7sGQVOTnC6CdM0MDxsId86v2mbh1
         qgJJ8tjfxtIJP/lNvrfIXfAEmp8aBzavrVizm5HtVyg9HNrqmlGrf5YRfR/QbvduwAmu
         qlW1j6ZJy7al+XxUOj58Ijyc9/ZjF06wAzMbAt8Yq4eoZsm+h8JJT/I00ECVTBO8hZ9O
         MkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732275046; x=1732879846;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zw+aL3+aDbEE8QLWGlFE9XEoN8lP9e4KsY1b4TQab1Q=;
        b=I+1K+YGaEeR5qjQu85w7UNHZLTLckwejiXhxMD6xH0I+GMrJ3ut4Vnb2p+I2G1f7n9
         xv3s3uetSpFNw837cQY8w1t+pxBPvVigvEuoyCikmOW/tjHj53q24bg+xEIQk2yO/2m1
         sMMpiqDHz6csPydy467s4fPEr4KeXXiVUXTuMzkbI3DHJVnVhboN6+qaF/Ynz1YwumcU
         Lul4vnwLvEBRTLI+T/Ri2N0/r7NTn4UeZf29KtGkgAm4IF2urkH5QNy3FtyiBTu/ggRg
         BDLNDt0HjoWSEMa6gXLxkWMhVmoWy+xY5ZaC0DXdsCzBeczxG3Nq2+cUBulsWLHOzfnr
         +nag==
X-Forwarded-Encrypted: i=1; AJvYcCV3USF295RUNN7i/YziTu1jDOfuD9/AmAOkt7kh66xy7uIQLIjtIBf3aiV2KCYVjb/bROU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLal/d05dYt7vEJBAzNErIxG6AKmib5SmTRSxAkCxi5IOOj/XJ
	z+/l9vp90m09G7cVqI7wVakIeHlss3tIaqWDBr6anMMa/7yF4xSgq0+iZleLVcF6mkDZA8gyttW
	TltnKaZMF09f1EnpuSgpPPYZWjDc=
X-Gm-Gg: ASbGnctGTyAMI30dCA1UAuHMMnB0oWUqY8GNQuf2HhyyzNhsP9MavLwwu9D+QtLalX0
	elTce6muT7O/8AK2753Xc1H5nkRaGHQ==
X-Google-Smtp-Source: AGHT+IFrWfAUy5YYxQvj0jrifqEaenWMGPgjW1LAt8WEQ9zI6A6oaf8rViUur9/ioMiTklsuI2WduVUDLlSfeNSdgPU=
X-Received: by 2002:a05:6102:32c9:b0:4ad:4e83:92be with SMTP id
 ada2fe7eead31-4addcbf254fmr2495239137.13.1732275046538; Fri, 22 Nov 2024
 03:30:46 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 22 Nov 2024 05:30:45 -0600
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <D5SNGOK1IKRS.1TY1DL9PJ7MPF@ferdinandy.com>
References: <20241118151755.756265-1-bence@ferdinandy.com> <20241121225757.3877852-1-bence@ferdinandy.com>
 <20241121225757.3877852-4-bence@ferdinandy.com> <CAOLa=ZS5yNpZEUqBAUpP-pSbJXk4+=XM6S6e9RY_eSVJEBhqkA@mail.gmail.com>
 <D5SNGOK1IKRS.1TY1DL9PJ7MPF@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 22 Nov 2024 05:30:45 -0600
Message-ID: <CAOLa=ZS28xvpEBNO9AMamF00Yf8eHFGKyU5uHjBD7vOVF3_oEA@mail.gmail.com>
Subject: Re: [PATCH v14 03/10] refs: standardize output of refs_read_symbolic_ref
To: Bence Ferdinandy <bence@ferdinandy.com>, git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Junio C Hamano <gitster@pobox.com>, 
	Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: multipart/mixed; boundary="000000000000cd8f4706277eb66b"

--000000000000cd8f4706277eb66b
Content-Type: text/plain; charset="UTF-8"

"Bence Ferdinandy" <bence@ferdinandy.com> writes:

> On Fri Nov 22, 2024 at 11:37, karthik nayak <karthik.188@gmail.com> wrote:
>> Bence Ferdinandy <bence@ferdinandy.com> writes:
>>
>> [snip]
>>
>>> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
>>> index 38eb14d591..1809e3426a 100644
>>> --- a/refs/reftable-backend.c
>>> +++ b/refs/reftable-backend.c
>>> @@ -830,10 +830,12 @@ static int reftable_be_read_symbolic_ref(struct ref_store *ref_store,
>>>  		return ret;
>>>
>>>  	ret = reftable_stack_read_ref(stack, refname, &ref);
>>> -	if (ret == 0 && ref.value_type == REFTABLE_REF_SYMREF)
>>> +        if (ret)
>>> +                ret = -1;
>>> +        else if (ref.value_type == REFTABLE_REF_SYMREF)
>>>  		strbuf_addstr(referent, ref.value.symref);
>>> -	else
>>> -		ret = -1;
>>> +        else
>>> +                ret = NOT_A_SYMREF;
>>>
>>
>> I was building my series on top of this, and noticed whitespace issues
>> here. A simple way to check your series is to run:
>>
>>   $ git log --check --pretty=format:"---% h% s"
>
> I ran this on v15 and it didn't produce any output.

Did you already post v15? I only see v14

> I read what --check is in
> the manpages, although the format is a bit cryptic for me. What does that do
> exactly?
>

It ensures that commits don't have conflict markers and that there are
no trailing whitespaces and spaces followed by tabs by default.

Also this is included in the CI checks (see ci/check-whitespace.sh), so
if you use either GitLab or GitHub you should see these shown as errors
on the CI. You'll have to raise a MR/PR to trigger the CI I believe.

On a sidenote, do you think we should modify the manpage? I found it
comprehensible, but would be nice to clarify anything cryptic.

> Anyhow if there was no output for v15 I should be fine, right?
>

At the least you should see `git log`'s output, but if there are issues
they should be shown inline. So when you say 'no output' do you mean you
see absolutely no output?

>>
>>>  	reftable_ref_record_release(&ref);
>>>  	return ret;
>>> --
>>> 2.47.0.298.g52a96ec17b
>
>
>
>
> --
> bence.ferdinandy.com

--000000000000cd8f4706277eb66b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 11c721e16c921918_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kQWEyRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK0ZRQy8wU29qK2cxM0k4cW5aYnR1bEdEQjRVYndPQwpYRGZ4QklISjc2
MkRMZ29xWllpY0xzOVVHckdMWEdRM2FkZXJIR0dEK0pSd0JzNHFqT0g1QXFKdnc5RjdyODRQClB5
b1U2STJwUitVYTgxSkxSTDZDdkVSVzA2cVh5NzU2QkdlZGhpWXFmY3h4c3NxbEtQR0RkSVQ1TW5L
WFZJMWwKZTFad0JNR1l2R3ZQZjY5WExBK0hOMURaZVlsNEpaS3ArNTBRdTVsRURsU3pISjU0eGZy
WWhXTVIzWlJCd00ycgozd2QrS1NGZ3NvSVJoODVrbVI4QjdRMXo3Ly9DK1hLK1FGUFEwRlB3RHlx
Tlp6eDN6eFZITFJ6YXM1Y1NabGJrCkFpSGFZYTNueUZVaEwzU0p2RlpoOUs0UEhISjhxMTk4QU1p
di96RmdXQitNdGJldWl5b21YTW9hVVlVc2ZYTTIKM2VhYzVTdDFOeUwxZk1CSVBESUF2eGY5UXlO
Z3ZrQWhqVGxxNjNINnlpZG0zUDRUdUxoNGthOFNmL3RJdWhEWgpUTzVuUDExbTRpOHo5VVd5WThm
TW51YVMvYWY0anQxb2ZjcHl2Z0VaNUVNbzVBY0xoM0xZdldQeTZvVFhkNm42CitiZklSRW9lVGZz
SXZiUDNDL2YwdGtqNk5ZOU5IbmRHdnpFRzJBUT0KPXl0M04KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000cd8f4706277eb66b--
