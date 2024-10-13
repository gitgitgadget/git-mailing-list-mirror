Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7908513E02E
	for <git@vger.kernel.org>; Sun, 13 Oct 2024 12:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728821358; cv=none; b=ouxHRlEhfWdexp17KU6weQYwURJbivyQADoNN4Dr1P8rag0ccX626Je0NpkMaVZkyX8zDkSqpm/jJExY3vefzMGilEFCujNkqYZ4dMk2IQRpnCTyNPSKxS93nGSzaXApjNczVYZuMe0Axs8+0pPDJqaY89FP0teeYd7ErB+phmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728821358; c=relaxed/simple;
	bh=4LsCKdKX0auaR66NpNyrxiUy2FfpBXHw2gN+vmvjWVU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pSQItHFktKym17tevrcBvgagCpmTKR3kGqe+l/j1tc7S/dopEBsaH4Kfn3Mfg4uF6g38VyHwzPnnulBhccyP3IA1wyMX8sNvUpfH/vmB9uN0dYt/OZEcsmjSLj2KJBy4+ztaRGkDttn2UIrMrBIoQft7uaL/hmqcyrr6yjzQhVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxVmaYk7; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxVmaYk7"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-84fe454176bso538060241.1
        for <git@vger.kernel.org>; Sun, 13 Oct 2024 05:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728821355; x=1729426155; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=n+HWHXiStcaoVYBcef5Vkm8RWLTcppbD9Hp8/fw8hDw=;
        b=RxVmaYk7MQhHP1A3eYjw6pG3XNvx9bzS1dZnChTFz4kQH/Sb+5NnUUC4AcCw2Dg+d4
         p6GQSunpELN9nJvCNp0jtxXXTojN5sG3N/5d27UHa2eZHZhmFGqUN3vC5fKFJpUCvf6/
         yiD3OvFKViJjMeC/vp0NAtsRG6ZFE4ogDcnoKavkXtI4LSFWNboJ4CZaDDzbwYxkRylc
         EFtWm+PPhcr/PwBmRx/kO4lZv0LsU0ChHOy2TraVY1z6pEaXY97b6WpvnvwxQh9LbXY3
         6jOFD+GCrieLDiBMFWQbqTxy8pW1kDgsOoqFX4aEgD1tlKuHMNg5+QWAsbaEgfnRyh2A
         y7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728821355; x=1729426155;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n+HWHXiStcaoVYBcef5Vkm8RWLTcppbD9Hp8/fw8hDw=;
        b=i2kH6UU51TBabJK73RnLNZ23mWN8jKJiBMqvg2tXHcwmh6EX6bTojmUibG2YOEC0Lm
         MJ+pJH1ejyiBwcpOCcAZtNVz0CEPmWXlev9E07sdvRrXbnmGd0jIRyRMrorrRSv3GjR1
         rqkpr9Grqhg6D7AMDPvXQ8b/JW9+lJJ/qrv3x9EHJidYf0bIP+zAUezWBqphpY1HSqMj
         W2XJFq9YjB5PPnDQUHj1KdnbUwp9xI56DsdRQzfmJqTTf02LKTbiaI6qUHgLEtdjbDIb
         B4fP2IseWDCfyMv8lzb609Y3/o6bmpwnkQtsmgNlLEIPrFvP0fAqpc6d+CYxly7AnYIz
         xMeQ==
X-Gm-Message-State: AOJu0YySRYdBvrZ6/SIdnOZV1S/pyD7dHvScukqtUbNit83aQEo3FMVB
	1HMquomeus9ciGsdm6eTInflVPW5VwM0vEbUxHhx3m/Xl2NaNcClLUXGxgN65LwIKMiCIYl/Kx8
	2Al94Q4ZsPi6yyY5Tr+bQYMgpbY4=
X-Google-Smtp-Source: AGHT+IHYKGMG7JdbF+VLRlbX2w4LKaahpYrIFNNVS6BuJJJ+4FLQErECwF5wVckeMqyfIdam8/K6VmkNlOoI0b2U/ss=
X-Received: by 2002:a05:6122:250e:b0:50a:cc6f:2a32 with SMTP id
 71dfb90a1353d-50d1f38f7c1mr6304470e0c.3.1728821355071; Sun, 13 Oct 2024
 05:09:15 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 13 Oct 2024 07:09:14 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <16d2d47c-5887-4658-b6db-996dac075828@app.fastmail.com>
References: <D4T9VCF8OS6U.1FMB8P6YU7I3S@ferdinandy.com> <cb60b7ad-7902-4293-81e9-06d1b1526842@app.fastmail.com>
 <D4TA5EXQFFA0.1XVEK1RM2Q6VA@ferdinandy.com> <xmqqa5facosb.fsf@gitster.g>
 <f7a7046c-020a-4365-baf4-49184bd2c60b@gmail.com> <16d2d47c-5887-4658-b6db-996dac075828@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 13 Oct 2024 07:09:14 -0500
Message-ID: <CAOLa=ZQJy1ZkQqBoWwJJvL0f+NCP=3SAfyeSNuztgApzNH1mGg@mail.gmail.com>
Subject: Re: with git update-ref?
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, Junio C Hamano <gitster@pobox.com>, 
	Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000bfebf406245a968d"

--000000000000bfebf406245a968d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Sun, Oct 13, 2024, at 11:34, Phillip Wood wrote:
>>> I do not think update-ref is a tool to modify a symbolic-ref.
>>
>> Didn't we add support for symbolic-refs to update-ref with
>> 'kn/update-ref-symref'? Maybe it only works with --stdin? I've Cc'd
>> Karthik for clarification on how it is supposed to work.
>
> Yes.  The man page says that you can use the `symref-update` command
> with `--stdin`.
>

That's correct, we did indeed add support for symref in the --stdin part
of `git update-ref`. To give some context, this is because we sometimes
want to update regular refs and symrefs in the same transaction. While
the underlying code exists, we didn't add support for symrefs without
--stdin, mostly because `git symbolic-ref` already exists.

> So the issue or confusion here seems to be that you have to use specific
> commands for symrefs.  git-update-ref(1) won=E2=80=99t try to figure it o=
ut.
>

I agree, the documentation here could use some cleanup. The confusion
here lies around

    It also allows a "ref" file to be a symbolic pointer to another ref
    file by starting with the four-byte header sequence of "ref:".

This is added to talk about how the command de-references symbolic refs,
but it can be misinterpreted to mean that it does support symbolic refs
on the top level.

Do either of you want to take a stab at updating the documentation here?

> That seems in line with a plumbing command.
>
> --
> Kristoffer Haugsbakk

--000000000000bfebf406245a968d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3b797b9736e0a556_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jTHVHUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN3ZPQy93TGZwUGduUjRHY1FHbkh0RXpEZFhnYjNmSAp4N2RwbWl0MXJM
YjhqQnN3bkxvMUtsZVh4QWo4R08wYUxtT0FOR3p1ZEwxTCsxNEpMSWFZVTl2bjgyM25NZEpHClcw
Mk1vU0Zta2R1eHR4RVl3blArTVJubDZKZ0thbmJIWlAxd1d4M3pLOGxZSmxvZ2V1S1IrcHVvU2Na
SzFUMzkKTTlVM1FsQlhHMXV5TWZvRmxYUzFOVDRwQjllOGtpSFRsOGZNMlhrb0JhRlQzNHFEN1hr
dEVkbGszNGVONTh1UQpnQ1pkTExudjFxVGo3MEV0eHJVbGNMZ2RJUlp3WEs4bHNxVUFwWllUTEJl
U2xObkQ0ZWlvWmt2dGJEajFPaTExCmZ6V1lZZ2hEQkdJeTdSajI1bXlnYmNoRFlzUnIreTBqWHRI
QWxBVGpmV1NFamFBTVNSSHIvTWJ2Y3ZjMVYvVWwKeVRMMmtobjkvdE90ODUyT2lpYi9ST0FQTmF2
QnVtNzYvOHJlNnI3RnJKVEVIUDl0N2pGYkVUTUtDUGJxTlN2QQorK1FvTjdNSVdaWkNUaWZrNE9I
ZHpGMC83WEtNaDcrSDArcWtPTE9BZ3lCR1AwTUdtdDNlTWNFWTRvNGlaODl1CjRiMmlON0Vidnow
NDNwSHlUazNIcCt2cWFZRkM1T1NaNU83UDFtOD0KPXFLYzgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000bfebf406245a968d--
