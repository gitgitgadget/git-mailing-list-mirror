Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC18A3D0BD
	for <git@vger.kernel.org>; Tue,  7 May 2024 06:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715063013; cv=none; b=HpVSWgMCMQ9XXjTQgCY3mUBIHSyHlumSXumoCw+0o3rFB2VABD2N4KAN0cRL5i8cky4xo+NtoPBFSGxhunF9wR5kM2EXw8F9ORxm/AQBDqlhbfrXYgCVNnRqoBXMvDilBBrQ0uwEnNU1ZaPeeCvOSpFYloB2Ob6y49vhuZ++EAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715063013; c=relaxed/simple;
	bh=STZgH0FXwG+nHFGCUAHXatkiyJkHyGXHl1/saQ//0ss=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJNhMnNaE6L+N1W43sPg8pJdLZCXWAE755VxWZ4FMslMSkLNRFNk5a9zLaXxcnQNUxj5vS6JWgCxw6dA537PyIZfPJQQV8YC8r1N1q1JV4rk0LUxcA9Z+8X3mrXUDT9T//HF66r4RcX3s+52XWYQIzBLTeTzJokUHuuScSWj73Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEQ3Z4od; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEQ3Z4od"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-23f9d07829bso929499fac.3
        for <git@vger.kernel.org>; Mon, 06 May 2024 23:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715063011; x=1715667811; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CCVH0t9XpA6MXHm90cLt6RVDFSjqs+d0fbu9QHX3cQI=;
        b=FEQ3Z4odaV+OVBB9ujYL5UVRVU74eaIBeJR8N8spwHfhUEqaPSbJaF+fufpkRAnxCu
         03iWtWia23PnZxC8aXDmh3O/3tRaIYRppQMIOwOhscGP5kM1LJvrd+fl0paZXylfMx9T
         wnWD2uf0dWQzJ9yz5lzO+cnat6qLvIdDs0SYBhHsGRDaiONjn/PtzyyCZg3yXUl1Wg+L
         rLy9QM7YvLLb7j3MMPh/rU64CcyTRSD/+D6pRuVN3EJcRbFQWxobxKpOe6uzy8zm/pAS
         oX9SjHCeWCiSjHohOR0FL0Mw3biQjrqNTC9nXsvK3gWxG5Fq9vOkXdD9wii3jM5iwchy
         9xVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715063011; x=1715667811;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CCVH0t9XpA6MXHm90cLt6RVDFSjqs+d0fbu9QHX3cQI=;
        b=TQG+xfwro6iY+BwcEgID+qbP3cwMLDgPO+iTYVOllEXNIDetIobkAGmFH+2dpsYSYL
         ++kOGalb0rDr936L6h0e5/DL+/3QJMzN1IeIrEJKAT1l4BXLFaJ1BQLcPUafBCbM52DI
         BSc1XjHj7k+TwwXizECHJwEZEL7utUb8LXdZ9GaMOYZBt2gnCZUkg8TIvVzLUQmIHsbR
         Aja2OjzaRN7xjtgCKyGFE14JZJRBcScw96IGeqhg/AMH+z0bTwvcPZn5l2gy4RPeS3DL
         Jhu4Ru5VAt1AlamlCfKzChkBOeZfiVWIlSs7PUcFQaS3//MbAHXNqaaqBGLPohMp2ZfD
         zbsw==
X-Gm-Message-State: AOJu0YyEcPUpKoND+mpQZg8I4sosRdSMMXe4bbTLxBYU9/3fpSols2Ny
	3uOyDgiucPjGi6Kb1ulmEMGXZ3XAhuFbP+5M7tafsZniPVJwdVxMcs3WkdMSTG4UBh57AIfiPWr
	My0Y2b5Z1l1a6WLu2Q/Dy9UmJUcs=
X-Google-Smtp-Source: AGHT+IHSDw1qivwdPBtJItqMfa9rRRPDO/cNKss0ykCv7EpJgl6VhR3y8ZgbSd6OeZP+QaE5QLISQ8Xf4QKTZQfqemk=
X-Received: by 2002:a05:6870:d18d:b0:22e:9e7:8b2a with SMTP id
 a13-20020a056870d18d00b0022e09e78b2amr14669372oac.0.1715063010636; Mon, 06
 May 2024 23:23:30 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 May 2024 23:23:29 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <D12XUEC6DL6O.POVU09JJFHO9@jamesliu.io>
References: <20240430014724.83813-1-james@jamesliu.io> <20240503071706.78109-1-james@jamesliu.io>
 <xmqqedai959z.fsf@gitster.g> <D123HB68ZKO0.3C5RSYGQNO9L3@jamesliu.io>
 <D125SZ21UPI0.166ZOVLTOBCRH@jamesliu.io> <xmqq1q6e3n0i.fsf@gitster.g> <D12XUEC6DL6O.POVU09JJFHO9@jamesliu.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 6 May 2024 23:23:29 -0700
Message-ID: <CAOLa=ZTwdLPYqeDh=HPf6tQqBfeTjQV6syE_sxtgWE_Cj48tvg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] advice: add "all" option to disable all hints
To: James Liu <james@jamesliu.io>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000008449410617d7399b"

--0000000000008449410617d7399b
Content-Type: text/plain; charset="UTF-8"

Hello,

"James Liu" <james@jamesliu.io> writes:

> On Tue May 7, 2024 at 2:47 AM AEST, Junio C Hamano wrote:
>> I count two messages from Karthik for v4, one of them being "this
>> round looks good", to which you said "thanks".
>>
>> If you mean the other comment about a non-sentence in the proposed
>> log message of [2/3], the copy I have in 'seen' says this:
>>
>>     doc: add spacing around paginate options
>>
>>     Make the documentation page consistent with the usage string printed by
>>     "git help git" and consistent with the description of "[-v | --version]"
>>     option.
>>
>>     Signed-off-by: James Liu <james@jamesliu.io>
>>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
>>
>> If that looks good enough to both of you, then we can probably
>> declare victory and mark the topic for 'next'.
>>
>> Thanks.
>
> Yes I'm happy with that. Thanks Junio!
>
> Cheers,
> James

Looks good to me too :)

Thanks
Karthik

--0000000000008449410617d7399b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 59fec0e152d85685_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZNXlOOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOVNHREFDS3M5cGdmZ2pLS09OVGR3azlhaUxuNHJOUApMUEVBdm9Qankx
Tm84YklmT2dodGtrUkpsdS9RVkZLZ1NNOGNkdjB6UnhRZEkrU2J3ckpVSHhRdjJaY0paWEFxCnFG
TE10OWorb1BIWU5oT0F6L2ErM0FDS1BlV0VSeElzVWlzVit3VUNMWUlnNHNxNE5PQzNMdlBPWTZ0
Z1B5WGsKNm1YT0R6bUVHZ2pwU3dteFBLOXZvTHo2ek5lSG1FR0ZrRFp5ZnlqVGFDTWJpOEx3V1lm
UFBQWS9yZk9oMFhESgpmZk1NMFlpUDhNSG1JMk1jVVhXa1d1eUdyRjlwYmlISFFON2JvZU1ucCtO
UXFkWVFCRzVLZ1R4NHhxYSsweDNoCnBmeW1ibHkrUmFsdW9LdXErYkUxV1VTWEs1cWZ1WjNwWlIy
Wm1wYzU3RWV6dXd2REFBWFhpeG1XTkFaZmdvUXAKYWhrLzNOaXpVQUpnNFlPQ3ZjQzdXT0RiMkNk
Sm81UzloUjdsamZUMFZuM1RsUDV5MjViUXFRUGdrMFQwTWtjbwpQZ2VTc1plQXRRMVBXQ1pMU0hm
Smo5WEx1NHQrMmRKYkVTenJHcXJNU1hrS2xzOWxJV0k0Yml3cTNnOSswamd2CjY1Z0gxSFBBQ2VQ
VVlVcEx2aGpCb1VGTDBCV2lMTWpxZUF3am9JND0KPW1acU8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008449410617d7399b--
