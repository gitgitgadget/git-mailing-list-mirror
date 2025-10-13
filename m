Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE662FB0A3
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 08:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760345579; cv=none; b=pMZVtGaiuVThO0I7lry9Yd1vX5EI9a8dEghYUMO1Q4vjsToDaFSKD8RDVGTR3v1FddnXrEDxkfxDHJseU51+0sV0b0PDQ52isItjl80mEO7Q22bpGnJsYzW7zxLj5lJLRbE43Rq0KVEe1wjuJcy//Iz8OosSThNcA43VqsatUag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760345579; c=relaxed/simple;
	bh=v14Sc24hjfjOgmS2qTmhiM1+beh9d+yKwd8p7mr9hOc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMF/XytPI643yikJSfzbYAI48M2iDl6W/3vdbQruamQMpPt3uMI4GR318fxj5hG2OB03EeuRjCg8oMjaku5wDNVFf83v0UatWayvYZCKr6BY9BQadUZrZtwKdJZv10IqOX5p8wihRkYYUA7uK0pMZ17wZ2HL73dpbjXNzI009a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6LtRjGE; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6LtRjGE"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-8fea25727a9so910776241.1
        for <git@vger.kernel.org>; Mon, 13 Oct 2025 01:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760345576; x=1760950376; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qnr8wZ9YaUS75x+kT/wYRps2klKaEzu9H6WrMWSXMyg=;
        b=e6LtRjGEkU6mpUfnCM6vKR+QJ01fcrxgfqa+hAGB94IuO99FGZpM6PElB/AyHGPRg5
         XAsLoVwXcYoscLKOc63hDxMx+GSAMx2gMk1O3Z+kcZ9FCFyXwO538d2Xj5h8ef8zY4UI
         oyP7/KA2ysisgyTjxHu3V7nXzmT7yVY4uNVE0YVkpg5i27CmBQ6RR5z8VqwFPIDYv7+6
         BaIhMj+qAQrn0VE3i+YPdIiAbczp4ThixEEyNXUhKGTCX/2sOexVQKScwIK/EOKRH49c
         rKKMtlPc9WeDgKRW57YAVBcDSNi8/IGY/J8QGAsIoaWICsRME3Qgl4JKFM9VXdQChTmD
         4Kmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760345576; x=1760950376;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qnr8wZ9YaUS75x+kT/wYRps2klKaEzu9H6WrMWSXMyg=;
        b=gHYwK8P9Ks3C8i3qRtQqytM1JBh9JpgbUArdvOwt7JNi5lDxQfGBoMEJ+9LmJwOSQT
         +JMS5B6GAYJtXwSkGLbC2cSwNl6Yyw5pHfWq/k5XuYUj4qqBcW4VOH5CBei5M/cmgxqH
         r22mfddwvKtPN+STxMO765x67qNds0u7JINnneW6tTw46WC1X0KYeZXybFxe5Arj91G0
         ynmTUWqpea+rXLgEEC56sYSlk0/ZbcdeLSGT6RMXHYaadECbOWVy9P6VplEKZ7yLgoTX
         ghLoLAS5Cz6TGc3zh78VElEFPerph2KiLu/5U7BcYsiZ1nCk2UtjuliBOcoFN5/in0j9
         tYuw==
X-Gm-Message-State: AOJu0Yzxl9TP/1az2huhrqXq/814c8xAY/RtIoLyG2TMBzRaLhjXvST3
	IqhMCedJ9E3ADZLryBVclo3Dz5q1+xgF/owlVq0W/C+cYDke4ZfzMK4lIv/pqg70wyWd57oyyaH
	OBKR4KwkRm/jJ4LJxov9aIIbSUmG4l+w=
X-Gm-Gg: ASbGncv6H1qqAWE2OuaZt4/J/J2nvOdNG9eil+sriSDyGV0L2zNK3EJ7tdWV77JEwhD
	u0E/UefoI96oWcrexTxuGzt7cxNoKdJLKebDWHRvY7bEmjW1mfLdIUqKvN5UOLkpRQveY4NFqlg
	q5sUgCnBkY4KFUbvMzLtvEex9qMKpcPEncOzypAdz9cTNEV8CXrJT4ZWShdD4o1wKxrnDtvXOO2
	FRojbopPKY7W1xdGwj4kKJMz4moDLJutMovT/3b46Opmgw1/dy4D8uHMOKNEzpjaHTsfA==
X-Google-Smtp-Source: AGHT+IHPkdPslvpiECllD1+2T3vYJ1aHeqlLFiHhK3mVWnHnNu+erDW+QC75es/1vxA+AFjrf3LzldGtytFgribfsp0=
X-Received: by 2002:a05:6102:5128:b0:4fd:35ca:6df5 with SMTP id
 ada2fe7eead31-5d5e2216164mr6858916137.7.1760345576591; Mon, 13 Oct 2025
 01:52:56 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Oct 2025 01:52:55 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Oct 2025 01:52:55 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aOjscGfX4ns-5qCm@pks.im>
References: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
 <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-3-c7962be584fa@gmail.com>
 <aOjscGfX4ns-5qCm@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 13 Oct 2025 01:52:55 -0700
X-Gm-Features: AS18NWDnZocqlL3_o092Rkzmx_k4oM0iIyH3Gp8ywLX3EhkkVGAivn06pS9my_w
Message-ID: <CAOLa=ZRkKhjnqw+7J8sc=OSJ6Z1POW8Q6U65=-JwzeRRm6YR4A@mail.gmail.com>
Subject: Re: [PATCH 3/9] refs: rename 'pack_refs_opts' to 'optimize_refs_opts'
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000c6728c0641066491"

--000000000000c6728c0641066491
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Oct 10, 2025 at 12:27:07PM +0200, Karthik Nayak wrote:
>> The previous commit removed all references to 'pack_refs()' within
>> the refs subsystem. Continue this cleanup by also renaming
>> 'pack_refs_opts' to 'optimize_refs_opts' and the respective flags
>> accordingly. Keeping the naming consistent will make the code easier to
>> maintain.
>
> Good, this is what I was hoping to see :)
>
>> diff --git a/refs.c b/refs.c
>> index 77dc1ab501..514fb85af2 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2312,7 +2312,7 @@ void base_ref_store_init(struct ref_store *refs, struct repository *repo,
>>  	refs->gitdir = xstrdup(path);
>>  }
>>
>> -int refs_optimize(struct ref_store *refs, struct pack_refs_opts *opts)
>> +int refs_optimize(struct ref_store *refs, struct optimize_refs_opts *opts)
>
> An options struct for a function `do_something()` should typically be
> called `struct do_something_opts`. So we should rename the struct to
> `refs_optimize_opts`.
>

Will do that.

>> diff --git a/refs.h b/refs.h
>> index c6c955d78d..58b222ac02 100644
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -500,15 +500,15 @@ void refs_warn_dangling_symrefs(struct ref_store *refs, FILE *fp,
>>
>>  /*
>>   * Flags for controlling behaviour of refs_optimize()
>> - * PACK_REFS_PRUNE: Prune loose refs after packing
>> - * PACK_REFS_AUTO: Pack refs on a best effort basis. The heuristics and end
>> - *                 result are decided by the ref backend. Backends may ignore
>> - *                 this flag and fall back to a normal repack.
>> + * OPTIMIZE_REFS_PRUNE: Prune loose refs after packing
>> + * OPTIMIZE_REFS_AUTO: Pack refs on a best effort basis. The heuristics and end
>> + *                     result are decided by the ref backend. Backends may ignore
>> + *                     this flag and fall back to a normal repack.
>>   */
>> -#define PACK_REFS_PRUNE (1 << 0)
>> -#define PACK_REFS_AUTO  (1 << 1)
>> +#define OPTIMIZE_REFS_PRUNE (1 << 0)
>> +#define OPTIMIZE_REFS_AUTO  (1 << 1)
>
> And these would then be called `REFS_OPTIMIZE_PRUNE` etc.
>
> Patrick

Likewise, thanks for pointing it out.

--000000000000c6728c0641066491
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4115c1325a35192_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qc3ZlWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNVJJQy85MS8wdkNZOUpiMTc3eTFBSVpYS3huT1FnVgp1QkZwUHgrdHAx
eFJYblI3ZVRyazl1bkJOa2lEeUlDZjk0ZStDR3MraWxxNW5wbUozWHQrRjJPM1RLWURzMFkwCits
K1dOMk16dzZBQ3FhYWMxQUloczhydFg5dkJsamREQncvcU1BdXdoV0xDMXlUNzNUSEVjenk4amNP
NnJjVmYKMHBjaG01WUh3bGJpcUp1czRzU1FQRkQvS1Njb1VDZ0lFSEJmS1FSRXB6dGZOOWV2Q3FL
dHE3dWF2cmFMYWVBNQpCWUJCNis3ZHluckQ5TXRLcmlmejl1Y2JScHAzeURWRUhnaDdGdHJTcmpn
NWxqbDlIdXptbWhjK1hGTm9qQjc5Cm5xQ1Zja1ZGd1dzR0hlSGx6eXZxdVVnWjJIQ3c2VkhjU3RG
SmF6bGlZR2QzTlhNdlAzRXN6QVJlYy9oTnlnbGgKR1QxYWdsVTYxYlBVYXZLQmtxMDZ2MmVtZit0
bUZPbnIrUktKNi83ZGtLWmZPSUpJYm9za2plZFA1Zk5DNHhRawpuM0ZNVW90MS9xVnNpS2ZSbk43
UkpwZU5kYmpGSVVmSmtQK2VzSUZ3aWFOMHk5WEtOY05zb2FBTjJJL0hKVWlaCmdFVUVOVE9TdFpi
bXdBejN5OTBuNDZ3dE5FNElXalZFcncxTWg1VT0KPXlhdUwKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c6728c0641066491--
