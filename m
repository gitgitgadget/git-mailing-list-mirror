Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFAF1CAA1
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 08:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721811312; cv=none; b=fnOLqTnphApBUuZL7feVs/pIPSIP5hIso79gfpbStpsdjRTirA5LHoPf76dGV+EgCqSldCISwphlX3xk0iTF1RdKGLNj3Tjog9AdNJpXjvco49YmbxW1unHr7LiUaSKs/y/R7C5Ige7brgDtijPhRFdJkJ8vOVCRMCqNry+dS8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721811312; c=relaxed/simple;
	bh=M44sR28bN1Fiw6Eyfo36LRN4s0QN2VwR6Vi/GCIQ+LM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iGZ020YHXzeaDMSByfSbWtUpugMo2p+zBWWc6eSfTUY989dpjYjaTvn0ukEygiiFG1/eZAgU8bMYEnkTUlMkp/NDdX5vyXYxDhfpspXK/PiVCbb3KZsLFNlJKn7SkF+PnvMOA/YW5s7BMRm6c/Qi+IiDfFY2sjufVibMH3yw3XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNJstPeT; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNJstPeT"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-260f81f7fb5so3335544fac.0
        for <git@vger.kernel.org>; Wed, 24 Jul 2024 01:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721811310; x=1722416110; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NTnwgqxoiUu/MbdymFollPIxsbXSc9CfONDDBS2GJT0=;
        b=jNJstPeTf7qbGmTviBbtumfMwqNyOTOb1sMi3ejjA9sT1tOgPRXBBp+BGV1A0NazSo
         gDDfputBcOD14ns92huQ249WtX+TlO8qAKwIgVY7tLjgM4RUhKPUE8QnPn+a+ACjP/1F
         ukaaCCQWwiyesC8ixS551LJwmSNKgG3NI+elfY6ciEEE9j5mVIR2zxs4alNNMBB4+j3M
         diN48ZJiinn6Za6JefdUu11cYVstecPwpQD2oFsmACReZ3O9VWuJzn6p8Gx9TvURpqlC
         ZI1btihL8TIAVDYQBa+ZgrQj8tk3lw/oiWnEw9wIh/tP1NLUyJD4ooATb3volZWN3o4K
         nf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721811310; x=1722416110;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NTnwgqxoiUu/MbdymFollPIxsbXSc9CfONDDBS2GJT0=;
        b=mJxa8ZrIbt5FZ5mL5QXNbK8YVT4z7aguyBWrYSW/ekaix86XHX7r8LNq7dJGyCKygX
         Z6QfygGjDHUJ2ZE0i0u6gn/1+N6EVXYUHD0ljF/qg+pRqfPEJSvCxjL06Bj/41t60DYl
         DBB55TZSdUFUoDzpCfQcfrlTXevJThFJTnQvCiVBl+D79e35UdAfML9EX1s/fZ1zNU44
         /cT0QRvPJ36HajWhU246oXcjxs2EA9xVAyaxQdxihLsroK3dDUVJzJ9YvprlPpTaS01y
         PMGNAOe/aO/8c7DNJpdbFpyiGi5x4u1mzPHPShpjtdcKPiPpXHNJZWMuT7xKoLxNkl/n
         Ar9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVuhpdDsKK8NLe+54y56FNkKUPT3nWIOcRBhrTe7Eepbc40h+x/ddcnQyRVK8fX3ITaPAYocpAG6Ye/weL3111hcbSn
X-Gm-Message-State: AOJu0YyX0w/vBADuPWFJJin5JElAGcU550Fvc1QDhdb99/poYTe9nNoQ
	146fJ6QShCjdgFdzUJsCPS6rxHe0g1GA5OECAeXx92etx9SZTy4iPth6GLOl6s/Dj7JCiTCN7wk
	KC5C9fbyVp84rnB7RQzRd09IozGg=
X-Google-Smtp-Source: AGHT+IFDA3MiBSGvaO81tjttrDKaTZljB2zvWXbjuGQd8IL1+YtnZ8RKGheF4hO3iPUrvs17yYzKHeZbQWsuj9mOJT4=
X-Received: by 2002:a05:6870:168d:b0:254:b74e:d654 with SMTP id
 586e51a60fabf-261213acf42mr12860404fac.22.1721811310489; Wed, 24 Jul 2024
 01:55:10 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jul 2024 01:55:09 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZqCkJHC3ivdNVm9E@tanuki>
References: <20240718081605.452366-1-karthik.188@gmail.com>
 <20240723082111.874382-1-karthik.188@gmail.com> <20240723082111.874382-2-karthik.188@gmail.com>
 <ZqCkJHC3ivdNVm9E@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 24 Jul 2024 01:55:09 -0700
Message-ID: <CAOLa=ZQ-VAgG3Qby94xz9ih=CROgYsRSUi894p7jErKFVg1xRw@mail.gmail.com>
Subject: Re: [PATCH v6 1/6] clang-format: indent preprocessor directives after hash
To: Patrick Steinhardt <ps@pks.im>
Cc: chriscool@tuxfamily.org, git@vger.kernel.org, gitster@pobox.com, 
	jltobler@gmail.com, phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="000000000000884e2e061dfa6fb5"

--000000000000884e2e061dfa6fb5
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Jul 23, 2024 at 10:21:06AM +0200, Karthik Nayak wrote:
>> We do not have a rule around the indentation of preprocessor directives.
>> This was also discussed on the list [1], noting how there is often
>> inconsistency in the styling. While there was discussion, there was no
>> conclusion around what is the preferred style here. One style being
>> indenting after the hash:
>>
>>     #if FOO
>>     #  if BAR
>>     #    include <foo>
>>     #  endif
>>     #endif
>>
>> The other being before the hash:
>>
>>     #if FOO
>>       #if BAR
>>         #include <foo>
>>       #endif
>>     #endif
>>
>> Let's pick the former and add 'IndentPPDirectives: AfterHash' value to
>> our '.clang-format'. There is no clear reason to pick one over the
>> other, but it would definitely be nicer to be consistent.
>>
>> [1]: https://lore.kernel.org/r/xmqqwmmm1bw6.fsf@gitster.g
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>
> This doesn't necessarily have to be part of this patch series, but I
> think that we should document this as part of our CodingGuidelines, as
> well. I planned to send an update to the coding guidelines soon anyway,
> so I can handle that once this topic lands.
>
> Patrick

Yeah, that would be great indeed. I think this series is now merged to
next.

Thank Patrick

--000000000000884e2e061dfa6fb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c361ae9fd5b7081_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hZ3dXd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md1puQy93S1E0cU1DYmZJRHNTdHV1djJqMTBndGQzTgpGU1l4d3N6WG9m
T21OMzNmSmJYbWloU0IreEFUMzhXRno2bnRocWQreUVYZEZmbFcxQzdscm1XSFRFWHdPN0FDCjY3
cFRTSTdEb29aWFpoM1RhN2Z5aGd6V2Y4T1hGZnlOUjFucTZuV084RG5NMnFZd2Z4YVBJTy9GdFZM
aWFOdmMKSTlyRlQ2WEw3dGE4anN4TkE1N0pleU5KYzZEMU85alhWakk3YzNWN0FIOXpKR3diUkNZ
ZkpBY2luRlFEUjVoVAo5QWtiUEU2dUNkcEF6TmV5MWtQcVR2ekwxcWw5bU1aYnR2ZC80OVZic3R2
STZxK1VBemh1OGxSREFtOHdEQ3ZlCjd3SExESXZnbnR1a21yY25UZzRBODArb0dPOHQzdm9yajl3
VnQ5Y2l6d0lybUk5S0cyVTB4QUdzZklMbk1XNkIKajNEVFp6L3pPN1kzWEI4am5LaEt2SFJlWVFx
MWFQNTNEeUVZRENJYTZyWjl0TUMyOTkwTStOOGFvTzlNWFBiVApoajM1MEZkZ1MvblpqMjgvRzVQ
eERMSjR4Q29uUTFKcDUzb1JqVUY5eE5FdG03VThBeVVlSkR6Mzh4cE9hbWRnCi9xTkNWTDl4Z0p3
SStYdDliOFBMcWlySnVPYW1HbzBrZzFObFdoTT0KPU5nTkgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000884e2e061dfa6fb5--
