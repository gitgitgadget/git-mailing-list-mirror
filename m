Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D40D27F732
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 10:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758708129; cv=none; b=j4wrnrhkkiKvHonW6s7e31COeTSz2CnVm+NNH8pIwxc6d7E59+q9A05mXfM5KKM4cNDkSTLvyGDIHAg4gstqxSdIvX965Dxui9JYaNa80ppNDzMr1G54UipihHhKzhjvZceHydlJ6mLiqfLr94jPRoaPo/g+pNZlktJW+S2XkY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758708129; c=relaxed/simple;
	bh=1cMQSdsc9dKqmud3GFAdL1oa5xRRfojFZo25AMYorG4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cm/Lod9m5ioJVP7BA53aW+IFqNRUfSutMww7H8l+ys0HthK78q6koh5u9R09kDXDaW/jSWL4Cv7CDzgm6IT/uvAFjfmzVDdT5Le2w4egHLWk5lp7t8f+An/SaS6PP0xJqe7w4dpfe7y/Es9ddyRyMU9JAvsrg2r5JvdH3J+EdiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvX/5SJp; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvX/5SJp"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-89018e97232so1606212241.0
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 03:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758708123; x=1759312923; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pR/ubudWndmLLontM4veXXXOUoyk8o0rX78MMAjVbCY=;
        b=IvX/5SJpHGDnBXRxvZRfj+mZEJ/QJX4w3N3zxGyMVL6F4h6fXWCed2bNrJtw/znyHJ
         hlJrcvvY9//nLasZ0xed2LvCaw1AR6J96fmlfGvjAe9g5fepXoKUrtmfgRD55DyaU3gZ
         eHRJiE2zNRDlkzZ6c1Iv5N3oKWgGFqaZSSdVAmAz0ifXSJrrGjqG4WoYjN/C3ENKI1Ap
         lHpaF1RR1IfjtVLZOUbOCo1jeNY6fL5JtuJnf7Q4UjaGTV8HayrofpZOGlTX33Ykyoqh
         SviZDSAA4JaaZZrNDR4EWvrLZu7jC4hzmJYpUYdWi1w5WF2Zpzd15cXFNJAV5lDZaLyN
         TB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758708123; x=1759312923;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pR/ubudWndmLLontM4veXXXOUoyk8o0rX78MMAjVbCY=;
        b=k04D0ohEJrIytTNywLER6m+tKpp+5YMPQ+XNYHXRvt0Y65ykcgJzoPVRkjcXZPG8GP
         /jQA/btoHdFqNOxvGa1J0ez1rXaiw/WuabRQAYljhBYKY7XN2yC1YjVFo7ToSgxBQZe9
         6CrMdzXeulV1iKKFdp/VYf5f+Q3LGrJAbFAxnv3cC4WWBtqivgWM/Qm8jTD1EsYq8bWu
         EAgaxka6rpXb9McoT/twSFj9JeLrmDmUUQSBZ5WX6JYq8PKyfM5VXPhsKaURWUo5cBLN
         PMz79QAxL1v4Ffbt67uWhKFtiYoLvQizVja67Zft5SoSZbPSgCAJoCOzIcjskcaB5+Bv
         eUaA==
X-Gm-Message-State: AOJu0YxqXQOb+EmksUJjDvup+QFupIe7jDhWz1guLIBO6xVbb0ZGyVKJ
	gmpACK3+zcz0vthywG5c48cy8+lKTTL9X6IlHZnmhnHlb/hI1SlbdP3JnZwzNY/IiIyMBEsgEzo
	Sciq3Pn/o8n7EfupmZP8qR8qEBa8ZgV8=
X-Gm-Gg: ASbGnct8QRXjhsZtwp8txYf+DqBWf5r9WyC0NDFc4hgdna4tQ8kZxbV1P+fQs1WQNiJ
	vsT5Pdbhrx6Cex/IIy7WPjklbEKAVJEBLEah5SQaUJ9M2ZLWBqmynR5OPqGxXbw3KLkf0A/XZWR
	lRw/cQ10vuYWMIijmM+b10SM4+0mLdoM+t7Jir0w0DLQ8Y8P5DZayOZ5Pdp1nuDqrQ+CvGDvAWj
	f8Rh386oVf3RPLqGV1X4K7TDL6ZenGDmpsV3Tkx
X-Google-Smtp-Source: AGHT+IGeZ4z+aecA41IdjQ+4f1/4BzvnP2myo9jYpD49n/ZTGF2WdzJ37VvJ8e3eIvlqMAd6GU3zEaEL24B15xf9M0M=
X-Received: by 2002:a05:6102:c52:b0:4fc:1a18:aaa2 with SMTP id
 ada2fe7eead31-5a574fc713amr1817150137.5.1758708122771; Wed, 24 Sep 2025
 03:02:02 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Sep 2025 06:02:01 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Sep 2025 06:02:01 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aNOHjdVEbCufSCPw@pks.im>
References: <20250918-228-reftable-introduce-consistency-checks-v3-0-271af03eb34d@gmail.com>
 <20250918-228-reftable-introduce-consistency-checks-v3-3-271af03eb34d@gmail.com>
 <aNOHjdVEbCufSCPw@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 24 Sep 2025 06:02:01 -0400
X-Gm-Features: AS18NWAn4V6D3tKY1lWrgb-jewQUG8rRId1_RSpYeEyvoZzuR9C2fouZpjr2Q9I
Message-ID: <CAOLa=ZQMDjpMLeyHxeePY3VQjD1GhotXA6-GDhTNY_BDu4zSVQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] reftable: check for trailing newline in 'tables.list'
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com, shejialuo@gmail.com
Content-Type: multipart/mixed; boundary="000000000000ec2904063f8924ad"

--000000000000ec2904063f8924ad
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Sep 18, 2025 at 10:11:44AM +0200, Karthik Nayak wrote:
>> diff --git a/reftable/basics.c b/reftable/basics.c
>> index 9988ebd635..75d4086769 100644
>> --- a/reftable/basics.c
>> +++ b/reftable/basics.c
>> @@ -195,7 +195,7 @@ size_t names_length(const char **names)
>>  	return p - names;
>>  }
>>
>> -char **parse_names(char *buf, int size)
>> +char **parse_names(char *buf, int size, int *err)
>>  {
>>  	char **names = NULL;
>>  	size_t names_cap = 0;
>
> Nit: Wouldn't it be more natural to return an `int` and assign the
> result to an out-pointer?
>

I thought about that too, I couldn't find enough consistency or reason to
warrant one over the other. So I picked the one with the least change.
Let me change it.

>> @@ -205,30 +205,40 @@ char **parse_names(char *buf, int size)
>>
>>  	while (p < end) {
>>  		char *next = strchr(p, '\n');
>
> Not a new issue, but it's kind of broken that we use strchr(3p) here. We
> really should be using `memchr(p, '\n', size - (end - p))` as the user
> provides the size to us. And the provided size should be `size_t`.
>

I think that's fair. But I'll avoid making this change now, I've already
added a few commits which are mostly tangential.

>> -		if (next && next < end) {
>> +		if (!next) {
>> +			*err = REFTABLE_FORMAT_ERROR;
>> +			goto done;
>> +		} else if (next < end) {
>>  			*next = 0;
>
> Can we maybe convert this line to `*next = '\0'` while at it? It made my
> reading hiccup a bit.
>

Yeah, I could definitely add this in.

> Patrick

--000000000000ec2904063f8924ad
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 2fe69ee6770ca8da_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qVHdaSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK0h6Qy8wYk1BM2lMTDVMT0prSGptNGlLOGVsYTVuVwo5NnhYTUxvNGVj
QlpXc2RtenlGd0VPOXl6RnZzNXRjbndpem5OYU5vOGZDcXVURFBlR3RIZzB1aWUyNnZ5ay9tCjhm
NDRaYkZSLzl2YzFtcStHSTdSZGs3SjN4RG01Ylc3Z0pWREoxUi96LytEM0s4NnlFaHkxaUNVMDJK
T2hQbHkKZVE2a3EvMmYwTDNRMGE2QTc4RDN4UkQ2UEU3b2pFelNGR2dUbjN6b244V25pQ21aVWd4
aWtYUm5wcVI4cHBPWApKb0QxS0JzbmVKMURiZ2RrV3p1N1hhNHBLTDkvbUFsQ2Z6b1IyTE5BNzA2
SFc1amxzYlpJa3E3UitPbmxxZ3pFCmp3bGpLNklHdllKQWVzZWJwTjZncVY3czZlNzNQaFdjV1Bl
Nnk5RmtNSGR0Q2sxRFlsNzlxeWZIRFh2eVk0MmsKZ2xOdDU0U25VUy9IWUtRN0JzNlE3RFNkcTRJ
OVZWOWtPaEQ0a1JFQzEwakdqR1hrMStpVjlhYlNKVmRTWGFyWAp2VnZLTHdBU1Vub2luYVovU3FG
WjRkaXV6bFR4YldLQWpWWkVFS1VMWW9BcndEaDlBM2ppczkya3dNcVd1d0h0Cmxaaml5VmhxLzlr
bkQwT25SMnV1RER6aEJ5NjJBSlYrZm1LNVFXOD0KPTcyYW0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ec2904063f8924ad--
