Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D249236F95
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 09:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733909206; cv=none; b=D4vpCCCmrtb8n0ZZ0ExYigAN3FrmaAAoI53ME13AUPGfGepkRpoTsQaEUxT1uLgta1b6Wq+Mv7lknkpwqIsK883R6uuIyNUpKWkmOTG0snpU5QjWiCZLPG4nOCLtcoFjNfn+WQ0zccRHA/yr7Vef3nEasVmczGB3v3uuBhs3MNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733909206; c=relaxed/simple;
	bh=TZ947Q1I5rx3Mlczoe03alqq+KFu7TH777VWrqlN44w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZDPN4KbgNEzjq6cBz5S5/XDz1PFyowPPIu2Tszzyju2aS+e9+qchskmexCBppFIxV7Qbuc1qco0tEuVmIyTGQAWs2+Ihv3aytUBDx1km19Mos95I1TntfvavWG7PlqBCXcKpZYhgYcWL2sUGrU2DsZOE+S0D9YTyD87z1QVX0zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Njo0TezN; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Njo0TezN"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d3bbb0f09dso7165173a12.2
        for <git@vger.kernel.org>; Wed, 11 Dec 2024 01:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733909203; x=1734514003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7pqUMtvMpJxTOXZKYHpsLIjkhNZZJX1z02p2Hj1HE0=;
        b=Njo0TezN5JQybIR9blwXhGAqvTjV7HmHjUAqx/K3ffEX+ND/iQbAkAiSDBjhAZW8jC
         Jq7Wz/dZpg3XcetIJBP6JzSNQxZSHEY22ngbXGSX559LfsXSZD7r0lFfGs0h7SEFMOG/
         V1xpp0BcRhzz8JVMc7IKz+HUIjXatH4FOQZr6EiVxS9yHpMkLoOF94x0dzPHAI/+aF24
         hbnsEL6RyifzefCm4RC30yLjMJtpBe1t+JH6+vt4BB6WAYYI/jEaoh+zSv4O0TTG6hEC
         s3CeO1fwgBJ+/FT++der9PlmSNzP3OMmazqZA4U8AOImiUqYv0xYlp++shDvPrcfOzuI
         6LUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733909203; x=1734514003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7pqUMtvMpJxTOXZKYHpsLIjkhNZZJX1z02p2Hj1HE0=;
        b=eDvWWEDgihvs3h0M6jci1whdTtvGfN1349FPeH1pYpYGy8pBV/HO653aVGpnqgq0cF
         w1XaT8PHv2GlZaW5y749BGlOMVBTQjISZU/S06Jy7BC7noTQfGvevy6uXFFU/Cq81YYa
         eTLwdppIIBgvWX3pj710DN0QHh8sh95y2dWwO0TBsCfLmpp26mk2m8uoUiL2cVCjY2w5
         nZMlsEAcNucns4hcFGzGhkOrv1ZVehgJgpLwaO/tkXeUJ9fEOBhdybFdvLsbHF1h2bhM
         ZFiVxpePrHc+WkbGjulYCKrvBhjkawEzhkfFrOnuKbx37FQymf7jMc63J6MTKG0Wixmj
         a3Aw==
X-Gm-Message-State: AOJu0YwaJyEirVj0BxWesi6eIpWJke5U3Ec5dLGtp+jyA9q18CJpV4Ks
	7q99iWZqnUYluIDMam1CgdbRhOLN1iEPA2ok6zPw64ruc3bPuQ39g82zACrYg9BKcqWePP2n3/T
	0B2MsJNJf72tykH7gdCFE0Q7V1/4=
X-Gm-Gg: ASbGncsop4HB8ddjeAnzE4ShBqJfR3rQUV4oWhEeCTKJLTEkilNS7H5nFeAbRK1HkVS
	r6Z5TzrITymUqndA1eYHg/QknTY0wJA90J3vA/057
X-Google-Smtp-Source: AGHT+IFNEyNPz1+qNZbtSZjUwkG9w0ytj5mG/YgkXWJGSvdRbgLnciMlZ8s/7CgXgf/fu5mIZ6TnYT2Jhh7wrAlH94Q=
X-Received: by 2002:a05:6402:5242:b0:5d1:2440:9ad3 with SMTP id
 4fb4d7f45d1cf-5d43316ff4dmr1954734a12.30.1733909203264; Wed, 11 Dec 2024
 01:26:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com>
 <20241209-320-git-refs-migrate-reflogs-v1-4-d4bc37ee860f@gmail.com>
In-Reply-To: <20241209-320-git-refs-migrate-reflogs-v1-4-d4bc37ee860f@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 11 Dec 2024 10:26:31 +0100
Message-ID: <CAP8UFD3fZ21TXgtMcppXMHf35qgA-UH=0X9z-xJ456qXyV5=dA@mail.gmail.com>
Subject: Re: [PATCH 4/7] refs: extract out refname verification in transactions
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, toon@iotcl.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 12:11=E2=80=AFPM Karthik Nayak <karthik.188@gmail.co=
m> wrote:
>
> Unless the `REF_SKIP_REFNAME_VERIFICATION` flag is set for an update,
> the refname of the update is verified for:
>
>   - Ensuring it is not a pseudoref.
>   - Checking the refname format.
>
> These checks are also be needed in a following commit where the function

s/are also be needed/will also be needed/

> to add reflog updates to the transaction is introduced. Extract the code
> out into a new static function.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  refs.c | 43 ++++++++++++++++++++++++++++---------------
>  1 file changed, 28 insertions(+), 15 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index f003e51c6bf5229bfbce8ce61ffad7cdba0572e0..732c236a3fd0cf324cc172b48=
d3d54f6dbadf4a4 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1196,6 +1196,29 @@ struct ref_update *ref_transaction_add_update(
>         return update;
>  }
>
> +static int transaction_refname_verification(const char *refname,
> +                                           const struct object_id *new_o=
id,
> +                                           unsigned int flags,
> +                                           struct strbuf *err)

We have a number of functions named 'xxx_valid()' or 'xxx_ok()' while
I couldn't find any 'yyy_verification()' function, so it might be
better to name it 'transaction_refname_valid()' or maybe
'transaction_refname_ok()'.

Also I think it should probably return a bool so 1 if the refname is
valid and 0 otherwise, unless we have plans in the future to follow
different code paths depending on the different ways it is not valid.

> +       ret =3D transaction_refname_verification(refname, new_oid, flags,=
 err);
> +       if (ret)
> +               return ret;

Then the above could be just:

       if (!transaction_refname_valid(refname, new_oid, flags, err))
               return -1;
