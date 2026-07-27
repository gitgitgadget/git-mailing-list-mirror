Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B8741E6D6
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 16:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785168816; cv=none; b=ZBMiDFCopgO6wQE3UMB6rofCo9NogdCFGxf5hIKCc4skrn2yZQLX5pC0AFw9LoGdBQYGG5KkISzoojR8O35ICWX5a4R4qd2yMVXLxi+DSPQVhdiV9uMNfqmjSv3xi/grccqQrMUqATcB8VZgZuVZg18cwXEU+JKaq6Y6XSBfNmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785168816; c=relaxed/simple;
	bh=GvNR3lmyHLl9hN+BGS/cBm/42NF0JyPYcol+7EwscmM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=EQCln4Xk495fqGCQ0wERCIiFPuVsdqD8z88ieLXMnYz4ZmKy8ksM/C9ITd5YMBg/Zyfcv7+OgbcAzsIsF9jAwEJRf6GcpBud+cefsbfgYhJR2KJdd4EWuDcY3hJT3VYlAh7fwBk7Ln2pFOLvQUVdpMkZpnqm690S7ko8+ZLVOFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVEXBCHg; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVEXBCHg"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cbb662575d3so1663847a12.0
        for <git@vger.kernel.org>; Mon, 27 Jul 2026 09:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785168815; x=1785773615; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Tw3FOaKYeB8o5iG51aTE2Lpd0E8JDPFNAavS7lNc1kc=;
        b=JVEXBCHgDDCDBr02Km0egUIc/SXXnAO/bTnWG6QLPyaN8n9EFj8bYHD45w+F+yBed6
         iRvh6qrfejR6ZmAZyRD9yT1/d6XIO0YW/kA+buTrZW6VRalpdQYNyChUZ1pCUj4zN1XP
         iJWa8xMhn0KSqn3D16Ec/nuN0u2tNw4s18mRVg9f2EvtKuEC/LJMx2bTcRaY9EYklRhj
         AxtLfdbfkcWxT/dJYDwQY1HH8WgOPNiSH48z99v0mHQLArrN2uwJB6oTJ+ozQ9yjEzDc
         t/b1gMy32TaT33rjCgRRKsmsQNz4Ew+eD5RwsfecSmu0/FrDOLUc/ZpgYdC0dyZt598X
         zddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785168815; x=1785773615;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tw3FOaKYeB8o5iG51aTE2Lpd0E8JDPFNAavS7lNc1kc=;
        b=RVcIyVOHEHlYuqnh02iJCB7VUA2QeJ0C408gpirC3hBH8Q3CLmcTRHA57CbOc847Dr
         W7VLfWnaXXkIYrRs4KWLpflRl/S/gw9zwbHeDoAb6cg4Zg8ay0sGWJfDSDsDsXWJhTOe
         UdW6UkvCRFm0psUdfWoZj8v4L3ksxn0tYs+P/KgvRIP70XEQOS9xlB91yVvq021jD/iR
         OsRZl+xx+jR1FaNZ/m2WUlrsKG2QqpYgCV/lx6EmG5Al4kg2pMoXCbz7apIrK4/fYh5h
         cQlF7U9DSHApk554Q4JzHcSWgYW8ZMiRPPJqDqQLMbxUDDak1/kujZCUUwPZ3cXOJAKM
         ZHcw==
X-Forwarded-Encrypted: i=1; AHgh+RpHFiCs8lrOhY+QUgGSTKh1QTpYIIIgNXGrJOhoUT73LVJve4EdV0inc/9ac3zSZjHjS2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFCo3mhxdVgK0ZDUFgvlahpGASQz3ft5kpbLkEbHUdKq66yTfV
	KJkC/M2RGNt9b2sOkKADHgXPo+pgCf0R1mIn403M/A+0zYBNiumlTEzY
X-Gm-Gg: AR+sD12/E8X4KtEzT89NmEk1fATdPSId9PlVe8LBRHlfMo917zwfHclV5KNz9sp7Zj+
	ojCm8sB2EYrfkDF1Xa5ks0UhdF9opljeJSHQBW3tnhFKAOqaly0woy6SPR4Snb/2Dn2ZOj9GCy7
	Oo7bUhdjoCuz4jL5S5o6QMhRhC8+m5dLiyPM8boq1JkxkfiRy7Grsh3JOSawoCznWpVgOrhbtWj
	aQs9XTDxfL/baJJnxLtHwE8L1DdiERaM+WGGwaXbEYdxgCNbd8R6Eae8dJp9/P5HQ9WfDx0Z4EB
	lGxMzVKnQYjkLse9bTBLxpd32GbK/OMoQTFsrBzGBTbgxtKzXx8HEU0DVekH/37pMBz9WlTWdbY
	e15xJV1zwFGNENf2h9FLOp9DJC2zO3+p+P87Mch48pvPu1eYnEWYkqttEMUfWxgAD1m80mqwyhg
	==
X-Received: by 2002:a05:6300:8d:b0:3c3:7ecd:72df with SMTP id adf61e73a8af0-3c67daa7f4amr8441140637.30.1785168814504;
        Mon, 27 Jul 2026 09:13:34 -0700 (PDT)
Received: from localhost ([220.158.183.16])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc5a67f3sm34991444eec.29.2026.07.27.09.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 09:13:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Jul 2026 21:43:28 +0530
Message-Id: <DK9HJ1A58HMD.2CDVOK50X2UMH@gmail.com>
To: "Phillip Wood" <phillip.wood123@gmail.com>, "Hardik Kumar"
 <hardikxk@gmail.com>, <git@vger.kernel.org>
Cc: "Patrick Steinhardt" <ps@pks.im>, "Junio C Hamano" <gitster@pobox.com>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>
Subject: Re: [PATCH v3] utf8: make utf8_strwidth() and utf8_strnwidth()
 return size_t
From: "Hardik Kumar" <hardikxk@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260726123427.173877-1-hardikxk@gmail.com>
 <20260727065917.469738-1-hardikxk@gmail.com>
 <e971400e-6d23-463f-ae9c-a21d3c5a3563@gmail.com>
In-Reply-To: <e971400e-6d23-463f-ae9c-a21d3c5a3563@gmail.com>

On Mon Jul 27, 2026 at 6:21 PM IST, Phillip Wood wrote:

>> diff --git a/builtin/blame.c b/builtin/blame.c
>> index 48d5251..83e4dd6 100644
>> --- a/builtin/blame.c
>> +++ b/builtin/blame.c
>> @@ -564,7 +564,7 @@ static void emit_other(struct blame_scoreboard *sb, =
struct blame_entry *ent,
>>   					name =3D ci.author_mail.buf;
>>   				else
>>   					name =3D ci.author.buf;
>> -				pad =3D longest_author - utf8_strwidth(name);
>> +				pad =3D longest_author - cast_size_t_to_int(utf8_strwidth(name));
>>   				printf(" (%s%*s %10s",
>>   				       name, pad, "",
>>   				       format_time(ci.author_time,
>
> To me this example perfectly illustrates why changing the return value=20
> of utf8_strwidth() is a bad idea. The return value is pretty much always=
=20
> used to calculate a padding to pass to printf() which expects an int. By=
=20
> changing the return value you're forcing all the callers to do the=20
> conversion themselves which is a bug waiting to happen. I'm also far=20
> from convinced that the conversions in this patch are complete: grepping=
=20
> for 'utf8_strn\{0,1\}width' turns up several calls which do not appear=20
> to be correctly converted here. For example:
>
> builtin/worktree.c: display[i].width =3D utf8_strwidth(buf.buf);
>
> where "width" is an int.

I had intentionally left out some sites which did not seem could have
any impact by implicit conversions as there are other examples of such
cases where the return value of `strlen` is being assigned to an int
variable. Example:

in combine-diff.c (where len is an int):
	if (len < 0)
		len =3D strlen(line);

in builtin/update-index.c:
	int namelen =3D strlen(path);

and other such examples.
>
> I think it would be much better to remove the TODO comment as Junio=20
> previously suggested and instead add some documentation to the function=
=20
> explaining (a) why it is appropriate for it to return an int; (b) why we=
=20
> must use the cast_size_t_to_int() helper to prevent overflows (see the=20
> commit that added that comment).
This can result in issues down the line and I had mentioned so in a
previous mail but wanted to try it with v3 since I had already been
working on it. I'll send a new patch to remove the TODO. This change
might just not be worth after all.

Thanks,
Hardik
