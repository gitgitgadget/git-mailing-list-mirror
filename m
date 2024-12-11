Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D293A236FB0
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 10:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733913110; cv=none; b=eot6l7RrkF94WtC5k83c6Dt33c1R17duwgqpd2ldJOlNxrIjF3qjVPoDF6GEAAqC6Wc9EHU6jHdfIaWb46g+PES06gLk/BWXutNJI3Mrese0y89DZMdBx1XOcuW4Ini6asmg3k/+6LJG1T6WuOy1M2wXSBBoeo7CcsL5OA6p3bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733913110; c=relaxed/simple;
	bh=3bceZKFzm+v4hC1yThEx1KEuHUSar3fH13ZuX/vndH0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9hSv7j1zR2SUA7cG3eAugJPrPLSMmY07CBtxJJXYPO1b5+jFBeGl8gqwAWwSPw+LK6hnYD+A0BESwvU6Lk5dptiJ3ZBKApWlJZfQq0apGBm/irs7EoEVpMouwzcviaYwi7ztkHfWrJMf5U7CgTcOG31arlO6hDuoCl1SDQRHT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbD68cw0; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbD68cw0"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-51882748165so905760e0c.3
        for <git@vger.kernel.org>; Wed, 11 Dec 2024 02:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733913108; x=1734517908; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8VZp5F3Qq/hySqIHUjh6UjbtxUlkLUVkDSnXiw9kVuk=;
        b=nbD68cw0z3TAkte5cBy2yzxPIZUnj0d84lFuvtFYBPcR29N9UrHwtieQX8IUHiBUDl
         leBqfPFH37cqrhL4N4b/a+U0FmJkrq8jB4+FzhIyeKaidA3mhq85SXr7YqvZFfY89psI
         RdjdZcYs3ztFRI/nX+oBn7rjHNKUBPvwQb9L7d5LhX4ghsq/8l09OwN52gbtiwLD5IPH
         rTpZYxcwDVLvic4i1VxRvAy/XrseLmis8lZyyJK4iRAhpS/pVOhKHgKC4WAF55e6bm+S
         Jl2gS5oLs7KcpWxNevzQrpJqiBEJylODLSJCJzAtEc6IKoB46+G1uXYLfz7ZNWb9QeFN
         5ehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733913108; x=1734517908;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8VZp5F3Qq/hySqIHUjh6UjbtxUlkLUVkDSnXiw9kVuk=;
        b=SWkgUI92jQM4hAJYmZ/2AlXSbGb73/Bh5Wf81MGh9Pwbd2PgbNKRimuVTXXFVd3ZyS
         8xERWzF/8+pZvq49tDKbORBBrCFQ5hfh9mziK3fluj+0u4lArOkWkAbXKqcv0ROOOdgr
         5IyLGQg5gYksKk7iq+lzTa7+pOmgUBH3b30YXC8FgSZEEP3M0tCrw3tJLMCo1yAwDyGf
         0XmgxbqzT9a8FpkE1UcZFlqrGHc9WCDRPwCoN+S6gLrJ6BDHfK+QEgPZBRC1DlGWtawm
         RAuFULGqlm0ivhCsdfH20qiORxCA9+J4cxFsuJrVyXf3cmrNhehYtlohrIp0nl/jxO8U
         VxmQ==
X-Gm-Message-State: AOJu0Yxvbe0GF5L/y2nBZyDX/h8qydj2xECLFg2ggCkq7MwqjuueKGCx
	DbP2utXNsnFt6aEzZ2lhLqexv/bUXt7lOvVwni8dR1ByGlFB+UXZbJcuMzQt0M5LORqmCbGwZZA
	c870FpgNVHXI2YmgVa81bpIYu5M0=
X-Gm-Gg: ASbGncvaJIVR2AhtSBkSPYLUco3Fzzq/fr1hlqwp9a7PcYPal92T6lslwmJJhZQCJ1L
	O2CF6OYhPPLL2DrYQ7pp4yLkn8BJqyDwa0QPXlrwIqd1pQeP+DDRPyopPlBcDFZnOi2NmXw==
X-Google-Smtp-Source: AGHT+IFGRnUCKw9H1wIptsS5Txa5B6tZWlWfnVnh8tweGCWXKwNIoaJN/kmixdG5fm8KPituiVJT/zxRjPpgkCAGoVw=
X-Received: by 2002:a05:6122:91f:b0:518:859e:87c3 with SMTP id
 71dfb90a1353d-518a3c3045emr1799092e0c.7.1733913107647; Wed, 11 Dec 2024
 02:31:47 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Dec 2024 02:31:46 -0800
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <CAP8UFD3fZ21TXgtMcppXMHf35qgA-UH=0X9z-xJ456qXyV5=dA@mail.gmail.com>
References: <20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com>
 <20241209-320-git-refs-migrate-reflogs-v1-4-d4bc37ee860f@gmail.com> <CAP8UFD3fZ21TXgtMcppXMHf35qgA-UH=0X9z-xJ456qXyV5=dA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 11 Dec 2024 02:31:46 -0800
Message-ID: <CAOLa=ZQtT9KXXro5kCbJUN7fFAAHirZXo06nStqn_u6urr149Q@mail.gmail.com>
Subject: Re: [PATCH 4/7] refs: extract out refname verification in transactions
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, toon@iotcl.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="000000000000da820a0628fc1a89"

--000000000000da820a0628fc1a89
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Mon, Dec 9, 2024 at 12:11=E2=80=AFPM Karthik Nayak <karthik.188@gmail.=
com> wrote:
>>
>> Unless the `REF_SKIP_REFNAME_VERIFICATION` flag is set for an update,
>> the refname of the update is verified for:
>>
>>   - Ensuring it is not a pseudoref.
>>   - Checking the refname format.
>>
>> These checks are also be needed in a following commit where the function
>
> s/are also be needed/will also be needed/
>

Will amend.

>> to add reflog updates to the transaction is introduced. Extract the code
>> out into a new static function.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  refs.c | 43 ++++++++++++++++++++++++++++---------------
>>  1 file changed, 28 insertions(+), 15 deletions(-)
>>
>> diff --git a/refs.c b/refs.c
>> index f003e51c6bf5229bfbce8ce61ffad7cdba0572e0..732c236a3fd0cf324cc172b4=
8d3d54f6dbadf4a4 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -1196,6 +1196,29 @@ struct ref_update *ref_transaction_add_update(
>>         return update;
>>  }
>>
>> +static int transaction_refname_verification(const char *refname,
>> +                                           const struct object_id *new_=
oid,
>> +                                           unsigned int flags,
>> +                                           struct strbuf *err)
>
> We have a number of functions named 'xxx_valid()' or 'xxx_ok()' while
> I couldn't find any 'yyy_verification()' function, so it might be
> better to name it 'transaction_refname_valid()' or maybe
> 'transaction_refname_ok()'.
>

I think you're right, it helps to be consistent here. Will change to
`transaction_refname_valid()`.

> Also I think it should probably return a bool so 1 if the refname is
> valid and 0 otherwise, unless we have plans in the future to follow
> different code paths depending on the different ways it is not valid.
>

That is a good idea.

>> +       ret =3D transaction_refname_verification(refname, new_oid, flags=
, err);
>> +       if (ret)
>> +               return ret;
>
> Then the above could be just:
>
>        if (!transaction_refname_valid(refname, new_oid, flags, err))
>                return -1;

Yup, also will remove the need for the `ret` variable.

--000000000000da820a0628fc1a89
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 98e241a1c80e8994_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kWmFoQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md0NmREFDak81c0l4WnEzR2tMQmVhOGtoUjhwdG9VVAoycGZqa0FJdEFZ
QmNkcWVjcitITG4vVGRJRkw4aEIvbUoxYlNBci94VXk4RkJvWnFtUUlWN0lUZldJNW0xcG5mClZv
ZVlBb2NtZWhGR1VvZ09yYkRKZnd5QWEyVmNoSlFtbnJpelV5NUxMSDJhTGFYQWVna2w3UjIrUG1O
ZDI1VmgKUEdoUk92bzZMY290MHVBSXpWSi9CbEJKRjYvbmlMOWtVZW93OUxqY2JaMUFRTjNjbEJv
amR6bm5JditzeDVTSAp4elgrSmdWVjhOY2VpVzdQVlF1Y29MOFdoNkVFVDhpeGN5dkZrdmZaSlZ5
ei84QVZDZVJRNitJSTlZK2d3VnJNCmtrUUdBWWFnZFk4Z3BTSGEzdmc2V1ZMMi8rcWlxQ2tHTGYx
NFZ2OHE5bkxBcnBOT1kwcktnZUlwYmlmMERoNE0KaG9uS0xKQ1NpeTNvNEhacEdMZVB0UFZLWUlC
eUV1Y0dKUm1DS1J4ckZ2M0FENmIzZkdzRHdOTWNHV2FYamJlOApvRW44blFSeDJWWXZvaUdrWW5l
c0pjTzNYRnNLc1g3b3FkTXlBcGxNRXpmR1g3ODJUcHdDdUk5bTNBc1ZSTHFUCm00dkZBQ3c1b2dw
UXJ0Z2V6QUpvWTFmeHRnbHJmbmZBSFdSWjNDVT0KPUc2N0wKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000da820a0628fc1a89--
