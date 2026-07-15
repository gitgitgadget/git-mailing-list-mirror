Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CD3425888
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 18:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138804; cv=none; b=jKc6HD3kcZTyp/DRJpUW1X4Ft2Cb2hsHY5gQLgOtzEgDFBR/yUgUDAkQpRGMPk0DmieFYoqxd1uQKA3N3j7S7bBKhyju+hYgu3EYlcBwHTlDdrIqxKDl3Og1FkNeW9mRwAXLauXI5umuN1/+T5kIJX5j9cULNLD4rnSxb6HcKZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138804; c=relaxed/simple;
	bh=dty62MzCfSxqR/Di2VuIpmVgzVjlIE/FU2C446zNKh8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dkYN3q19fqoPGgUt3/AdRqA4I+9NzU0c2VoF11/bOEzmYrFtq9b+JiVYviYKLGT7WTI1DvHMlylFAL6MAo78MRLf8BGMiMGXoUOvOaldikbvyzui1XFrYvylqEE2JhxT+QuwcwKzN/UM9xntTRRL6C1KDWctVXtlWU8gOobpybY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/H6RC5Z; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/H6RC5Z"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4758b2a9e2aso3595918f8f.2
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 11:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784138792; x=1784743592; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YVz63a4dfG9FckJbIZTKNdP8fAcu3OYOyBE7IfQWOwI=;
        b=S/H6RC5ZU8cah2dtey0ASpDnlTXi8y1yQ3J7iKurY6fSRwl7Hffq21ylsdqSjT2DtO
         BtbcUpY0dr7VJB5YUV6qnIrU2P3cw6JVLVf/dFC4H4Rrod6MClB1BKgcqcFVWFkx03/I
         sMPX2pre90Q6TEmdU/g77G8h/gUc2b/RHbK60MSeKxz6mQlGB8ceTWe4TVzt+/kV8iL+
         Edep9NPY1gZcHK+gzkkHB+UT5y3f6anYr7BUCwvG3V3b8WqcYdnG/JYKVxkzDmXV8roM
         nNxOa2aCFpH8YqWcJfWvDB9ypQ6EfN3YkNOn6krZVAOsQKpYAtxFAiLV7mt5XaRAZ7uP
         g0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784138792; x=1784743592;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YVz63a4dfG9FckJbIZTKNdP8fAcu3OYOyBE7IfQWOwI=;
        b=lOlOyhMKsQfcoVk6LVvB+xr523RPJpb6crZZGflmeD63bB1jFan4WDqC7/L5jxJasN
         hXW0pOAcbYA/VNngEtTiQqNBMx5iIE1WKdAOQA6VhBWE2j4ulP9KiVY4KUbHpS0smGaV
         wSMmjjDhrXzeyl48JHZutdok4tNuu/uKn9nEuevX8EGBXEKPqJUBXRD8tUcaQkENoZfm
         TartdFo8AueUnKeHOjlyA2jcXunNEVMWI4mR+NyeK/Mm8n9qrGibGRqhXcbTK6swNERu
         4hr/3VqubD1xua1HQDqTQ0NkZ7AB45o2b0L7O6ZNTpy8KmQLoFoAkvwtQKL+oZeNsCuU
         D22g==
X-Gm-Message-State: AOJu0YxSIoj5gwkXyKX48y+OFBCvXoFCX3+bDGlTIEmKvwfRlLvAaHSN
	v7JkdfXrTFAKl5HfJI9GjVCi1VLFTi4Iu+lA6q9ItqHXHI02i5xclYxY
X-Gm-Gg: AfdE7cmbTv7D4M0yRCGt7JTeWjXnHVrmDV8rubfxheVOVhn9SUSGf1Nbwod1PVvwrsB
	JJRuxuPLDcrelsiRIXt8aAUE24YO9FLWH9X+To6nZYSioL4UKFyOQZzXgQDNB0ByJgNtiJDqDP2
	oY1c+nKZF3KeZYkcBRK3ds02Nf2xW0y7teJ3q2Ys9IYqsZLI6z/ZGH+G8pUkkB9kk8BEV28ZJhJ
	Uquoyzbr4rPs5W+ID65/dyfwzyr9fbxBUNP65KYy0s3E2txspoeEnvPaNWFbn6WM1Sj3oQ7XVRQ
	qF3TUxx/HCBHdSssjfdLPwLd7pg0gLKBhxmN1f4apKScLT3k/MHp/Cr22e4XPPCG71+BE6O9g4z
	vsBioMSleyd3384m+s/EQQS3NI8PnIuUn2WNrEQaqYbXvr1tWGL45BTn20UvbDU3oaKdFZen5Rw
	h0ciyn+XX9fp1ZlZbSihMwzXXPmfuVTr9QZZJ+wXfZ4Kzncef32iaIULlYv9iHDv3WOQjPgkm+c
	2KdQID1UTZIgdtOxCuM6CoN6HHL0mjXcD17LLtNirQ7VcQLN/4OqfV3ITRXzfmaNlgIU6KiBHoC
	s9wS4XqUdRrcCFDuudPjSwhpZnIGHc+PRnVjG4JV+3cy5RtZoq4Apwae7xEii1e/ih9bZw==
X-Received: by 2002:a05:6000:26c3:b0:475:f0c2:5afe with SMTP id ffacd0b85a97d-47f488d663emr9773382f8f.52.1784138791616;
        Wed, 15 Jul 2026 11:06:31 -0700 (PDT)
Received: from localhost (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635ac2esm18625984f8f.13.2026.07.15.11.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 11:06:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Jul 2026 20:06:28 +0200
Message-Id: <DJZCF0EAPPM0.3KTS5DZRJKUR3@gmail.com>
Cc: <git@vger.kernel.org>, <chandrapratap3519@gmail.com>,
 <chriscool@tuxfamily.org>, <eric.peijian@gmail.com>, <jltobler@gmail.com>,
 <karthik.188@gmail.com>, <peff@peff.net>, <toon@iotcl.com>, "Jonathan Tan"
 <jonathantanmy@google.com>, "Calvin Wan" <calvinwan@google.com>
Subject: Re: [PATCH GSoC v18 11/13] cat-file: add remote-object-info to
 batch-command
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
 <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
 <20260715-ps-eric-work-rebase-v18-11-34d7adb051bb@gmail.com>
 <xmqqjyqwnoqf.fsf@gitster.g>
In-Reply-To: <xmqqjyqwnoqf.fsf@gitster.g>

>
>> +static void parse_cmd_remote_object_info(struct batch_options *opt,
>> +					 const char *line, struct strbuf *output,
>> +					 struct expand_data *data)
>> +{
>> +	int count;
>> +	const char **argv;
>> +	char *line_to_split;
>> +	struct object_info *remote_object_info =3D NULL;
>> +	struct oid_array object_info_oids =3D OID_ARRAY_INIT;
>> +
>> +	if (strlen(line) >=3D MAX_REMOTE_OBJ_INFO_LINE)
>> +		die(_("remote-object-info command too long"));
>> +
>> +	line_to_split =3D xstrdup(line);
>> +	count =3D split_cmdline(line_to_split, &argv);
>> +	if (count < 0)
>> +		die(_("remote-object-info: %s"), split_cmdline_strerror(count));
>> +	if (count - 1 > MAX_ALLOWED_OBJ_LIMIT)
>> +		die(_("remote-object-info supports at most %d objects"),
>> +		    MAX_ALLOWED_OBJ_LIMIT);
>> +
>> +	if (get_remote_info(opt, count, argv, &remote_object_info,
>> +			    &object_info_oids))
>> +		goto cleanup;
>
> Since this function does not return a value, the caller cannot
> even tell if there was an error if we just silently return like
> this.  Is it really OK to silently ignore such a failure?  Should
> we not die() loudly to report it instead?

True, this comes from the v11 before I got into, I think Eric tried to do
something like what 'info' does (it doesn't die) prints "<oid> missing"
but this comes from failing fetching.

'remote-object-info' prints "<oid> missing" when the fetching works but
the oid is unrecognized.

I will add a die instead of the goto. Thanks.

>
> Thanks.

Regards,
Pablo

