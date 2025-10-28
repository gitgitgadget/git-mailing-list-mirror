Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F373633375A
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 19:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761678192; cv=none; b=u0oSzPtyK/UFYXg9HaW2DtOS4NOZlyeja4AXXgdjdwmPdDapqIFao1G3/EJmXNE/SAQ9WX4Zr4+kXkT4q+EkfK6mylpODREGm/ZxmkRBMlfJgdfNQGu8nikdK1D897m1eqgImAF1baIiF1Wq5m32WZ+n5pvP/scSuP6A7DoRBsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761678192; c=relaxed/simple;
	bh=bvTP4BVS6EKcO5G89AnDHfy1F3ZX2nE/ZcDY4ybkSl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FxL88E+r6nSz1GaHulMOxSx9i8/XSRrafZO66aEpUZEzyQpfXl5UxihoVQ7CFiytl10a0y51GqMbCKV1W7dJTAR2wh2KAztUshHuBVVCVhciTQDfxJuFEuZcSe6TC4Rj4HEXovzUKS4g30HGBrQK7ZgYq1SsJByM765d/EKw8EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzEsXgdI; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzEsXgdI"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7a27bf4fbcbso5410709b3a.1
        for <git@vger.kernel.org>; Tue, 28 Oct 2025 12:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761678190; x=1762282990; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=886JnqUuBhiNP8SE+xgne4b4WmXKjv5a+q9yN7iJth4=;
        b=TzEsXgdIDA9kUzZ8r0kU5LaCnVtCth2YniWkSRdl6ceigDDcIlL0aXrVAs8rV+Z8h5
         slebwZEF7Wcpqfw9H7OyJ24i5MPeESz1UO7dolf0XPBvhKWRfhofwxLL8EsmCQce4gAP
         YRP7FUcTSgGpoCgx8dStg1lynCscckxdW6L2xSK5GyA1+ahgNJtlUN1URcQ5BmcdQBt0
         U7MkTjiVl36k0+uRZoX8FWFhh3akzfLsrbA6xXyGxxw2ddyhqAn3ST4LGuqf3InOkp75
         QsN4GsbYalVUHNvm1kMKnjBDt748yNYvZvSNufvWCG0NYKNb2hacruAVqi+e5u8W8uKU
         6bpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761678190; x=1762282990;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=886JnqUuBhiNP8SE+xgne4b4WmXKjv5a+q9yN7iJth4=;
        b=KGfM5MaiiKdz5zSvdpY7XmZYejHyFuXJ1Jb1toVkiVVnk59zBv26zdmXor4EvzusyX
         PUZ1GwmraFLXCa/VWHvxLK9CSXim/qWMpuhQTXQm3nkUqpeZmGYmCp+FIm3MhAT8u9SW
         fEjRVfwvpY/ch+GZ0znPjdmRrOS7hf2DshbRmc2FuGcH5w0c+woHkAT1TryVwpnywmqr
         M9uXv3K2DXmvBP1moFtjB6DGDh9aglH6rdnCeVd02XEUfDsGlz9vDE+Ag1twf1np+Uqq
         M2J1ASvAmYinKPJsAKETb7njKPUvAxWz/7js5k+vUOSxB6JmUeNT0h4RSviqxo0KvAZG
         wo4A==
X-Gm-Message-State: AOJu0YynIe+w99YYas/7MQxy1S1oXVsy0klHGSXg6hw29+6g+Yf+D2+r
	DNA5hDlMTknYC1KqJeBqfnv3rVyBWg1q1v9ir9Lsz2DvGutVXEqIJjKC
X-Gm-Gg: ASbGnctBDFD1Ec8yGTiZq8DSVq3ltUeUrMB2mtLWn1I8vB9bz16ifb1ZwHrU9s7Jtjh
	syFYJcESzrq/EwHBHjBynxkKm7AzF7iG+F1nKTc4RD+kJovMAPlxxTBOWA3SDiXPZbak5ttPBvn
	P+XJun0Iea9PoumVcFncqpMXRsv+X/E2RzuAVEqRdhc5YpmS9kvNjhvC1ZiUX+vLVgIOltaZcPs
	oXPmDau0/b80i95LzGU8XdRMADM+HYrLzDKWKA0mIKM0LDNLI2Z6SQWuLfYGIxEOphlJ8VXEkNJ
	lDNoWzwM+M1KOUYA4SL9pLrZNKrxzfgP0ZKBIl+cl5gaSvpbxAPRrpVyKPapQom2yAM3IY9isq0
	uXDeLTN1aeNdlNTf9aJ+vWun4mz+3jSrUb/0o3RwLOXo71wtUhuVIuqBwu4/rM4TyWKo88QbdxH
	G7w3HfhysOvzTJYOf7gO7kcDDhiQGnr7sneIqV1P+MpUndEui5b2XD0l0OZhwFUSukdqB55ZkU9
	5PJInmvBzQ6DFYntsuTKi2UBKeVzYx6r3UeDo8/dV6aCshKeCwpQBNgKDkOEh8=
X-Google-Smtp-Source: AGHT+IHpMM4TU4NT+JcI/SutetvY/Ikv+GqwvLRpblmkSi8uAJZ4PD2BrEctQ/Gz6V4dxRhtI2Tv3A==
X-Received: by 2002:a05:6a21:6da7:b0:301:daeb:58ad with SMTP id adf61e73a8af0-346533349demr65675637.14.1761678189738;
        Tue, 28 Oct 2025 12:03:09 -0700 (PDT)
Received: from ?IPV6:2409:40e3:177:42ef:798a:642a:892e:b13? ([2409:40e3:177:42ef:798a:642a:892e:b13])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b712d7cdf28sm11156965a12.31.2025.10.28.12.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 12:03:09 -0700 (PDT)
Message-ID: <6a41eae1-8d44-401b-85e2-4e52187da525@gmail.com>
Date: Wed, 29 Oct 2025 00:33:01 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] replay: make atomic ref updates the default
 behavior
Content-Language: en-GB
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com,
 phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk, newren@gmail.com,
 ps@pks.im, karthik.188@gmail.com, code@khaugsbakk.name, rybak.a.v@gmail.com,
 jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com,
 johannes.schindelin@gmx.de
References: <20251013183311.33329-1-siddharthasthana31@gmail.com>
 <20251022185045.29256-1-siddharthasthana31@gmail.com>
 <20251022185045.29256-3-siddharthasthana31@gmail.com>
 <xmqq7bwmy6r6.fsf@gitster.g>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <xmqq7bwmy6r6.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 23/10/25 02:49, Junio C Hamano wrote:
> Siddharth Asthana <siddharthasthana31@gmail.com> writes:
>
>> diff --git a/builtin/replay.c b/builtin/replay.c
>> index b64fc72063..1246add636 100644
>> --- a/builtin/replay.c
>> +++ b/builtin/replay.c
>> @@ -20,6 +20,11 @@
>>   #include <oidset.h>
>>   #include <tree.h>
>>   
>> +enum ref_action_mode {
>> +	REF_ACTION_UPDATE,
>> +	REF_ACTION_PRINT
>> +};
>> +


Hi Junio,
Thank you for the detailed review! Both are straightforward fixes:


> We allow and encourage the last item in enum definition to have
> trailing comma, i.e.
>
>          enum ref_action_mode {
>                  REF_ACTION_UPDATE,
>                  REF_ACTION_PRINT,
>          };


Will add the trailing comma in v5 - makes future additions much cleaner.


>
> unless the last one is somehow special and we are not supposed to
> add any new item after that (e.g., a sentinel REF_ACTION_MAX that is
> supposed to give the upper limit of the values).  That way, future
> developers can add new items with minimum patch noise.
>
>> @@ -434,10 +491,15 @@ int cmd_replay(int argc,
>> ...
>> +					ret = error(_("failed to update ref %s: %s"),
>> +						    decoration->name, transaction_err.buf);
> Hmph, don't we want to use '%s' when reporting the ->name thing?



You are absolutely right about the codingGuidelines. I will fix both error
messages to properly quote the ref names:


         error(_("failed to update ref '%s': %s"), decoration->name, 
transaction_err.buf);


These will be in v5 along with Christian and Philip's feedback.

Thanks,
Siddharth


> Documentation/CodingGuidelines has this:
>
>     Error Messages
>
>      - Do not end a single-sentence error message with a full stop.
>
>      - Do not capitalize the first word, only because it is the first word
>        in the message ("unable to open '%s'", not "Unable to open '%s'").  But
>        "SHA-3 not supported" is fine, because the reason the first word is
>        capitalized is not because it is at the beginning of the sentence,
>        but because the word would be spelled in capital letters even when
>        it appeared in the middle of the sentence.
>
>      - Say what the error is first ("cannot open '%s'", not "%s: cannot open").
>
>      - Enclose the subject of an error inside a pair of single quotes,
>        e.g. `die(_("unable to open '%s'"), path)`.
>
>      - Unless there is a compelling reason not to, error messages from
>        porcelain commands should be marked for translation, e.g.
>        `die(_("bad revision %s"), revision)`.
>
>      - Error messages from the plumbing commands are sometimes meant for
>        machine consumption and should not be marked for translation,
>        e.g., `die("bad revision %s", revision)`.
>
>      - BUG("message") are for communicating the specific error to developers,
>        thus should not be translated.
>
