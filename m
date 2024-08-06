Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F639770E8
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 19:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722973787; cv=none; b=GP1p7X7/54yzrZarIU5Z6K4/GdJBevNWvxh0+Ghe1J+bGvu8XgJd35xcrR8irEpwE458rPcxdXTOpmPjrhQ8s5u3LOQVmLu24H/th9UA0pZxae1eWUvryKYig0rQ73eOsm4ssenxFYL6aDVEU7iyR6/xRQOSe6x3dpBnvgLU480=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722973787; c=relaxed/simple;
	bh=G8xyexIodNh+g19DxPsd4MObuFX2vbuHJwFuNvM8lOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KE3/uG+6GgD7uIacHzeRsfIIPj5iEcnJvILxf5BP9IHmFWC2jP91d5XWZpWqG5yXKrYgOpEWw9yisxirxK2FlyiAd7h/NoGHF0uOCVCRlDU2/2IFIx7pRGxG/IO5bsH6zJAzsVit/LGxQUhXZheYqyUJW/C0Zswb9XGGrNPwSmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grPXbXSX; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grPXbXSX"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a201bcf379so14065485a.3
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 12:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722973785; x=1723578585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMmT0JuY/ehpAH03ZDx2cO/Ms2SSday5VxL8h+kRQhs=;
        b=grPXbXSXiEnjzCxah41JksgN7A1ajRV06Hkgk3o0FMj1y35Qvukcj9BWsf9dkxJIPQ
         VktGu/CX7oT3hujGaxyAjRELKM2SfYk95ypBoDVcZpc6WNBPUFtoRRmhTJYuq9zVm0YW
         SP5Po1CEWqrmNDfrn9d1eMTiiFgDmNrJpaRFAGXbM5j1Zsn+GI2/ocQgasdl8eXvdil/
         xLSNzyiPINDwGROFQWxZ7mToqeg6HNUNAVsE5Gx7vjcaBDLzWABZTnxfna2C6kB2rpuK
         6NFiiYqQyPRm5p7Ybh/eFlE2/z82w9NmzlUCXsYEAk9eVdRMS3uqOi+m4ltHkTmSmsQD
         a1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722973785; x=1723578585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMmT0JuY/ehpAH03ZDx2cO/Ms2SSday5VxL8h+kRQhs=;
        b=Fs8FYRyhC7Pb4/O4p/3JDepnob1biJDlt7hgkPKp+6j16xaoKX3VPRHSDe574ffleH
         eM6i7Qz/J3PYYfZWbcq7+/jZnYxfBIjr2allXZAG78JPdih2n8xRSeALjQStrW9Pq8LG
         HNGAryK8e2L9Vy1QFEF4IfmimaLdJajan38mfGOFzHc+jLXaRJw5t7ypgmK97MS2Z3MQ
         NKeTkieSC+PBDiMgNrTLFDEGotEX67LNAkpzplrQUPz6obAXUzaH+FNSlIR+LCgVYtnN
         EbVS37Bjm2mxa3Ygy2Ew8SP8ju1UwAcbyXektlUvKrR4ttXc9w4TkqeY9bGaAohc4fPI
         5yvg==
X-Forwarded-Encrypted: i=1; AJvYcCU0cL/OkbF1/VujTPEwaSdOZIaiW/Ln3XnfMgNPEBUdFK1e1EiUQum6LzV8CPH53I7BuTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY8e4AoMAPqr5Iea5LSswE3gAbBAdF+Z+NiXR9MT4FahBXRIpk
	Nb6rq4ordVDptq0LigaTyQ3mfiFRvys7HLWZR+oF1ZTXxiYJeDiTNCXeDw==
X-Google-Smtp-Source: AGHT+IHaMieEysC7pD/+Ma4Q2knPJAWVXcK5lfpCtEBjUDhZJZSKKaglXTUdRm26UrW+L+uTNucpSQ==
X-Received: by 2002:a05:620a:2699:b0:7a1:5683:6b70 with SMTP id af79cd13be357-7a34f033d73mr1029194485a.9.1722973784979;
        Tue, 06 Aug 2024 12:49:44 -0700 (PDT)
Received: from [10.37.129.2] (syn-068-173-161-103.res.spectrum.com. [68.173.161.103])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f6fd852sm486482785a.66.2024.08.06.12.49.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2024 12:49:44 -0700 (PDT)
From: John Cai <johncai86@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Phillip Wood <phillip.wood123@gmail.com>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>, Jeff King <peff@peff.net>,
 Patrick Steinhardt <ps@pks.im>,
 =?utf-8?q?Jean-No=C3=ABl_Avila?= <avila.jn@gmail.com>,
 Linus Arver <linusarver@gmail.com>
Subject: Re: [PATCH v2 3/3] ref-filter: populate symref from iterator
Date: Tue, 06 Aug 2024 15:49:43 -0400
X-Mailer: MailMate (1.14r5937)
Message-ID: <A71B6F98-820D-4692-9712-C6D63F019DCE@gmail.com>
In-Reply-To: <xmqqsevouqsj.fsf@gitster.g>
References: <pull.1712.git.git.1717694800.gitgitgadget@gmail.com>
 <pull.1712.v2.git.git.1722524334.gitgitgadget@gmail.com>
 <3e147e7d850773f44b48d1b86e89aef1415a0ccd.1722524334.git.gitgitgadget@gmail.com>
 <xmqqwml0uqxi.fsf@gitster.g> <xmqqsevouqsj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On 1 Aug 2024, at 12:54, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> @@ -2852,6 +2852,8 @@ static struct ref_array_item *apply_ref_filter(=
const char *refname, const struct
>>>  	ref->commit =3D commit;
>>>  	ref->flag =3D flag;
>>>  	ref->kind =3D kind;
>>> +	if (flag & REF_ISSYMREF)
>>> +		ref->symref =3D xstrdup_or_null(referent);
>>>
>>>  	return ref;
>>>  }
>>
>> What is curious is that we do not lose any code from
>> populate_value() with this change.
>>
>> Is that because of this piece of code near the beginning of it?
>>
>> 	CALLOC_ARRAY(ref->value, used_atom_cnt);
>>
>> 	if (need_symref && (ref->flag & REF_ISSYMREF) && !ref->symref) {
>> 		ref->symref =3D refs_resolve_refdup(get_main_ref_store(the_repositor=
y),
>> 						  ref->refname,
>> 						  RESOLVE_REF_READING,
>> 						  NULL, NULL);
>> 		if (!ref->symref)
>> 			ref->symref =3D xstrdup("");
>> 	}
>>
>> That is, if we somehow know the value of ref->symref for a ref that
>> is known to be a symbolic ref (and when we know we need symref
>> information in the output), we do not bother calling refs_resolve
>> here to obtain the value.
>
> I forgot to ask the real question.  With your change in place, does
> this "lazily fill ref->symref if it hasn't been discovered yet" code
> still trigger?  Under what condition?  Or is this now a dead code?

Yes that's a good question. I took a look and it seems like in *most* cas=
es by
the time populate_value() is called, apply_ref_filter() has already been =
called that
populates the symref member of ref_array_item.

populate_value() gets called by get_ref_atom_value() which gets called by=
 both

1. format_ref_array_item()
2. cmp_ref_sorting()

In the case of [2], the callchain starts with filter_and_format_refs() wh=
ich
calls ref_array_sort() that eventually calls populate_value(). Before
ref_array_sort() is called, filter_refs() is called which ends up calling=

do_filter_refs() with filter_one(), leading to apply_ref_filter().

In the case of [1] however, there are a couple of code paths that call
populate_value() without apply_ref_filter() ever being called.

pretty_print_ref() directly calls format_ref_array_item() ->
get_ref_atom_value() -> populate_value(). However, apply_ref_filter() is =
not
called which means the symref will not be populated.

Looking through the codebase, this function is only called in builtin/tag=
=2Ec and
bulitin/verify-tag.c in the `git tag -v` codepath. So it seems that if we=
 got
rid of this block of code in populate_value(), only in the case where `gi=
t
tag -v --format=3D'%(symref)'` on a symbolic ref pointing to a tag would =
the
symref be missing.

But I don't even know if this is possible. I tried this locally and got t=
he
error:


$ git tag -a -s -m "version 1" v1 refs/heads/master
$ git symbolic-ref refs/tags/symbolic-v1 refs/tags/v1
$ git tag -v --format=3D'(%symref)'

error: tag 'refs/tags/symbolic-v1' not found.


So practically speaking, I think we are safe to remove. However, from a
future-proof point of view, anyone in the future who calls pretty_print_r=
ef() would also need to be sure to populate the symref member in ref_arra=
y_item.

So perhaps from a code durability standpoint we should keep that block?

>
> Thanks.
