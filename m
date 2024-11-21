Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADF514B959
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 15:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732203020; cv=none; b=DoerPM5oQ/v6gYrCHI8Qmkm5LFj+Evfui2oW35Rhv8nbySivvSJ/1Cd19FNUwthFQgSidPUf/rFLzUcjklmS6B4Uxo/bgpopqenWU73ODDZVA/KvB6xynTAShxjH7reCXEGqfPWsLPn7mH+qFkhmhpWyuDpw1s8ql1Rgtg2agNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732203020; c=relaxed/simple;
	bh=nBzZGwqdpkiEIDIOJSOZCTqJsK//+MSsnWRbdcZeFXo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V8mJfzOpHXRO+MoxwuEkbPircLbexZUZG753HCncC7JFnjEB3xBd4p3bbd/dGWBHY0olRvmJY9fvhoV43uf1CP4A1GR5YPAtVYrmYb60vBMHZKseONXyBUCs6RXFrmHCwDx12hmW6DanHy7OR/Bf5fVYPi/aPffV5M4cyGJmQdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6B/aQnm; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6B/aQnm"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-718186b5c4eso393944a34.2
        for <git@vger.kernel.org>; Thu, 21 Nov 2024 07:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732203018; x=1732807818; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XCZgy3rOj8bgMFtxRhtwbQ/yYVuttGEUsesL4npsS2o=;
        b=b6B/aQnmdobO+TNeU0B2NsTqKxtoQohNBuFU6Sb+b67Zz+vtRed8s2g4gbIGB9vouh
         0zDUGRO6g/s3JC3jvwjRTWfpqggJLdRWeEddZ1/mzsqIfbBBCNmJrcuHW6WOBsSY/pCT
         1l47nUT1CU4SAoCI6vJeqbbYCl8cmy695ubrv1Zkn91Zae2cLk0gKQx8ojQ/O4jz4xyK
         IgrMOq57QPC3hNRw12tbb3DqlZEIHnH/Z2itZtGkYAKthSmepwgaH+KxXK4PZdS47q5B
         QC8PsMfAog6gtfUaHE+48TTsDRUv8geeAzS1EabBvz9bIHsb8r7zaeU8q/ltMupCKuvo
         Yr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732203018; x=1732807818;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XCZgy3rOj8bgMFtxRhtwbQ/yYVuttGEUsesL4npsS2o=;
        b=F3yDDLwMb0M5H6gSc9apeBN1QvizebpP3hyA+OHqt+dKlWGbzvaNzO8rvnrfcHfg2t
         6KRE6HlZs6ykx8auNo3TJAgqd9JoFwDvDb6kiKv/Xk+EMfGgAshFzOPcUqQlPK/Zfs/i
         28k/6O0Kvxv6D/iH5aikNFfqjCsTxDM714w0QIC67fs6lnAFj5DNQi7uDijgzlf2dQvU
         mK/CvVnl/gshxCSxt3GXOn6I07Sni06k3OrE5UUZ9mBltAE0jLCFVZOTKhSXT8Ozd9r7
         wQ70CYFKXJ2+bxLVl9pXS7gbX8/7ZUwoCmSfB5K1L2OdljmqVfikfYHSrpZ3rJ/2lMdi
         w/wA==
X-Forwarded-Encrypted: i=1; AJvYcCXUvGK+Q0xvztnpQHnIsC0sHRAX5nCC1rOrUutGK49dptojSqz5Pxz6Ew5j/eSNaKLTnFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfD5FaPURrECkv6aAQfepU1a1Cc1jICFCWKBuVFZWuZRJ+fryE
	8DlniBgZsPHJrn1EQtCPWkMd0RIXe304PjJsty0lht9f5Ukpo56OrV3kXKx1cin2XoglDBGFwcT
	dU2Na7fT2d+9uNEv+L5T5rjZPiRXG1FdR
X-Gm-Gg: ASbGncszjRa5V32IhBgJeE/n1GXg77hIPZYj0a400x/fio+GbvoEIz4mlbvpGZObHwS
	mSdmTi6l88VF0YTxNpZnpskRFNt4LrFQcLSf923IPBg4vhQ5Py3AwN4AbWs/QOcq02w==
X-Google-Smtp-Source: AGHT+IFujhPAccItuCbXgdxTtY8ojPLiSBiyHrY/xYH9YSzRuILPDRYs3rpS9DE0phJ2osz9NDykG6UnrQX6nmBWLEI=
X-Received: by 2002:a05:6808:1910:b0:3e6:37f7:5a3a with SMTP id
 5614622812f47-3e7eb7d1a06mr7065850b6e.41.1732203017916; Thu, 21 Nov 2024
 07:30:17 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 21 Nov 2024 07:30:17 -0800
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <Zz48r6ZZcol6TQaF@nand.local>
References: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
 <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-3-e2f607174efc@gmail.com>
 <Zz3dAZGAG3BupQqE@ArchLinux> <PA4PR07MB74069403837F36FD07D075EB9E212@PA4PR07MB7406.eurprd07.prod.outlook.com>
 <Zz48r6ZZcol6TQaF@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 21 Nov 2024 07:30:17 -0800
Message-ID: <CAOLa=ZSjwUjV71H2tNwF1J-qxP3ikrVbmKOGAAWv27KcgeTo+Q@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] midx-write: use `revs->repo` inside `read_refs_snapshot`
To: Taylor Blau <me@ttaylorr.com>, Richard Kerry <richard.kerry@eviden.com>
Cc: shejialuo <shejialuo@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>, "ps@pks.im" <ps@pks.im>
Content-Type: multipart/mixed; boundary="00000000000090679706276df1b7"

--00000000000090679706276df1b7
Content-Type: text/plain; charset="UTF-8"

Taylor Blau <me@ttaylorr.com> writes:

> On Wed, Nov 20, 2024 at 02:26:23PM +0000, Richard Kerry wrote:
>>
>> >> The `read_refs_snapshot` uses the `parse_oid_hex` function which
>> >> internally uses global variables. Let's instead use
>> >
>> >Nit: s/variables/variable
>>
>> No, that's fine.
>> It's plural, so ends with 's'.
>> Unless it should be "uses a global variable"
>
> The global variable in question here is just "the_hash_algo", so I think
> shejialuo's suggestion to use "variable" is correct, but it would need
> to be "uses a global variable" instead of "uses global variable"
> (without the article).
>
> But I think we're being unnecessarily vague here, and could instead say:
>
>     The function `read_refs_snapshot()` uses `parse_oid_hex()`, which
>     relies on the global `the_hash_algo` variable. Let's instead use
>     [...]
>
>> >> Also, while here, fix a missing newline after the functions definition.
>> >>
>> >
>> >Nit: s/functions/function
>>
>> Maybe.
>> But it could be "the function's definition" as it could be seen as possessive.
>
> It should be "function's definition", as the possessive is the correct
> form.
>

Will fix all of this and re-do the commit message, thanks all.

> Thanks,
> Taylor

--00000000000090679706276df1b7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 44fef0a73f0238c1_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jL1VnY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK2VEQy8wZnVGNzdXWllBdTRKbnNUNi9HS0NPUTJYcgpEWTlJMzVZQWla
b3J0bDJXY1hJN054QXJxdzR1ZDNBSDBDWFlPNWthaEN1TEJKcjRwaS90QkN0a0djcjQrYkV2CmJH
cWszSjF0cTdwTVFaaXRuQ3JIVEF3SGdQcDM5ZXZqNkptajRwRDZ0eVFiSkovWGtsaHl6dDJZdXFR
Nkp3TG4KcEwvbTgzb0gzTHJ3enlOUStrY0xhc0pOVklXRmpvb3d3MDVoTHNJamFwZ1JmWFhEK01s
WVpCTGgzMXkwbStZdwpUb2RTQVdNa3E3NWFPLzFmSUFSaTcySFg5dHFEdmZLOVRHdmtKOVh4bW4w
enRYL3pSRGsrYi9aSEVxNWhJTEZhCmNiQTRLamIwcGFLT21qNHUrbGJyVzdqaFM2U3hLWngxendi
QlMvNkxhR1pzTXFvSHB2ekZWS1RSNWVjQU1yd20KS3krWDFnNC9qR1QycVRWOFpXOVBsMmtFUnJU
a1NaM21RZlU5Rm9HaUE3MjFZN2ZhTmRzM1A1cWZ4cklRWmxwagoyVkhqVkcxMWY4eHdEaVAydEpB
clRHU3JPeDB1UzZkL1NrWGoxNTZnVjJtemcxakJyTTkyL3ZBOTk4Ui9Oc214CnNoc0VLUVRGeHlZ
cUVFTFhtOCtXOHV4MlFCanZMRlJTNUdvaEtYST0KPWpsNXAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000090679706276df1b7--
