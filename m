Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E1A1A7264
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 20:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756844901; cv=none; b=q7dfIsp6HyS37GRl3Ctzylby2RdCexv9ozMcirp8FERn3lkswTDSeG0U/tE/q/a/SuNwnUabd0eoBRrWw5cQN1vWq/Le82J5XGpXTuBwJY0R/jpal5Tj3ZvlXH03iwQs9H8BASBCb/UTFpDKPce4tJJuiUaLDmRGvTQ3B3mh3WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756844901; c=relaxed/simple;
	bh=qs4C9hjbdDE25RRCXzbASxYJpxRzrYl7CWA5G7Jo1EE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=sdo2e4ydUDViEn298Po+pnegwkgfnhMP4GKeGubBu8ppHrBqymMaVc3JfHC+LNKKBxbS3S8Xp7gflF4XqTzmhLdnnLB56yszNKnO1PL3+gSYU/DPG2LIVDAbkJL8RHj85cl/2Mktq3KVoqQjSQkw77/NhM7d5EKjVNqnZXvxxoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifA4DdgT; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifA4DdgT"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-52992b299feso1143431137.0
        for <git@vger.kernel.org>; Tue, 02 Sep 2025 13:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756844899; x=1757449699; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qs4C9hjbdDE25RRCXzbASxYJpxRzrYl7CWA5G7Jo1EE=;
        b=ifA4DdgTheC6useM47ZarRDPhdhz3uHRv44dcng4B50tcXmThfiw5iifB4Pg6cNHO0
         d4K0FgYFiArv99POljqi3AHaTOzLIgLQBQLqtnDqCLmpoOT78Xmbwj7/rJ2Ek2h1Ui8/
         I/VP2u8Hoh2vYIYdz6yV7lHqpRAOuDbjbR9npXO3j4g9F85xYnwiAJ/6bqLs4XFYfcaL
         7WHX3i/bRIUZ94pZcPvZ7mM20tGW7m+ajaDiAL2OnWiramPJiPNfEdjCKrBXOn7WiDol
         nRMLNfn0M2wP3naYpkUX2fMLzYsDqQ8quueB2mN7o6gVorvDtIG5D8+0k6Eac9BtLeH5
         FrJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756844899; x=1757449699;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qs4C9hjbdDE25RRCXzbASxYJpxRzrYl7CWA5G7Jo1EE=;
        b=Biql3UWfdZhovesfIFkHQ/DBn0zjVChPrXTiAkVdtbHKCU3qlrIzJwn/l04EFv2scT
         zpCSVLw3sKN20+GlBfuRDF+AxKDpNQ2CyKZ/pBlo87a637v//aGb4YzOUbFrNzhfRUpj
         yt9xdBHHYqDaiCxqJ7k7ZE5LZb2xBj4B3Gbz8a8tytasd8IrGzTxl60H1TwYe6Wd4tLh
         U9Fy1pshG2XS5T23+8QIJA313TNH9NPh2SbVEz2vr9g6xU+sgOvmG6v+NK+wfL4uY4sH
         8wsBh7Nsj+YjvkWhAdbZKDyWevN8jMNiX6hWejkgn8oxsnXptwjofHVI34mCeOaAZck9
         C0OA==
X-Forwarded-Encrypted: i=1; AJvYcCVEEdNQgzACol2zFDYsnRpn8weKzwu4rxGfMVjFFqzdic69l2EgZrV1FmKu7VVaPpRmw70=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6WSVvK4XZS+hYbEr69lHwd1OjqcKYgRLVEKSvxUjTmMU9Phhq
	qpyyOkykdA0tYYG+BpJFVk7IpD9MSivHk+lBgqVlsDjr8S14iKFDyorWLTfESDSF17NVf6hkr+X
	w+WDzTHHI/2j/wZTzW4fWs7RiqQkGBfc=
X-Gm-Gg: ASbGnctWSeaUv4tBIck8+4T2cJeIuGv1z8iNJ87N1EkO7hCafVe7mKoHY5LN51Q6meO
	5OQ9vID3IsDCDnD3JL9KOPFEOA+V6NBVFLbFRv4NC+hq+gEXlZxU7qdRqo4stxZWNQJqaDpiw8N
	abPpLm9bFZFXMSqsoj74S4XcP0/K+iFKUFtZPepxjX/l5HulXK0v6nriane49s3JA+CFifwceIa
	Dre8ID14KwOp0K5KHmhb/S7OsvT0+e5JXECOhvV9A==
X-Google-Smtp-Source: AGHT+IECU8b9AfveeT1GlySEhojqaYtPPFUvPZDMYdMKvWEJ+H0UXxmZREl5SCheajSja6+gqUKnjvYTHrePM1um9BM=
X-Received: by 2002:a05:6102:5a8c:b0:525:471f:de14 with SMTP id
 ada2fe7eead31-52b1a37bfcemr3824464137.13.1756844898890; Tue, 02 Sep 2025
 13:28:18 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Sep 2025 13:28:18 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Sep 2025 13:28:18 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <829c6e09-c834-461f-820d-981512a02a76@app.fastmail.com>
References: <CAGAx-2Ac2Tt4-jTH=AApK3m=U7d2RJBaTW=uX6jBHzmpWU9NYw@mail.gmail.com>
 <829c6e09-c834-461f-820d-981512a02a76@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 2 Sep 2025 13:28:18 -0700
X-Gm-Features: Ac12FXwdlmSjvwIxt4mrEN3d9P2BvHczJxZjfpN3HgLe9NXBJ8p66jxEZaTe9B8
Message-ID: <CAOLa=ZQZL3hZE_3ajCAA5=41PZLAVOE=rnPJexu4nPGibNgvRA@mail.gmail.com>
Subject: Re: Git fetch Failure
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	=?UTF-8?B?VGFydW7jgJDjg4TjgJE=?= <tarunramsinghani@gmail.com>, 
	git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000001fd8f2063dd754f2"

--0000000000001fd8f2063dd754f2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Tue, Sep 2, 2025, at 16:08, Tarun=E3=80=90=E3=83=84=E3=80=91 wrote:
>>[snip]
>> What happened instead? (Actual behavior)
>>
>> Git fetch failed with error
>>
>> error: cannot lock ref
>> 'refs/remotes/origin/users/ajya/sqlservermoduleimportM146': Unable to
>> create
>> '/Users/admin/Repos/tasks1/.git/refs/remotes/origin/users/ajya/sqlserver=
moduleimportM146.lock':
>> File exists.
>>[snip]
>> [System Info]
>>
>> git version:
>>
>> git version 2.51.0
>>
>> cpu: arm64
>>
>> no commit associated with this build
>>
>> sizeof-long: 8
>>
>> sizeof-size_t: 8
>>
>> shell-path: /bin/sh
>>
>> feature: fsmonitor--daemon
>>
>> libcurl: 8.7.1
>>
>> zlib: 1.2.12
>>
>> SHA-1: SHA1_DC
>>
>> SHA-256: SHA256_BLK
>>
>> default-ref-format: files
>>
>> default-hash: sha1
>>
>> uname: Darwin 24.6.0 Darwin Kernel Version 24.6.0: Mon Jul 14 11:30:29
>> PDT 2025; root:xnu-11417.140.69~1/RELEASE_ARM64_T6000 arm64
>>
>> compiler info: clang: 17.0.0 (clang-1700.0.13.3)
>>
>> libc info: no libc information available
>>
>> $SHELL (typically, interactive shell): /bin/zsh
>>
>>
>>
>> [Enabled iHooks]
>
> It looks like a casing issue caused by `default-ref-format: files`.
>
> ```
> $ git for-each-ref --format=3D'%(refname)' | grep -i sqlServerModuleImpor=
tM146
> refs/remotes/origin/users/ajya/sqlServerModuleImportM146
> refs/remotes/origin/users/ajya/sqlservermoduleimportM146
> ```
>
> You could try
>
> ```
> $ git clone --ref-format=3Dreftable https://github.com/microsoft/azure-pi=
pelines-tasks.git
> ```
>

Yeah, so the issue is that using the files backend on case-insensitive
filesystems breaks since there are conflicts due to references with only
case difference. Before 2.51 we would simply overwrite one reference
with the other _silently_. With 2.51 we use a single transaction for
reference update and this breaks.

There was another report similar to this [1] and I've also pushed
patches to overcome this issue [2]. But with the files backend, there
will always be a compromise.

So like Kristoffer suggested, the best path is to use the reftable
backend, which can handle different cases in references.

[1]: https://lore.kernel.org/all/YQXPR01MB3046197EF39296549EE6DD669A33A@YQX=
PR01MB3046.CANPRD01.PROD.OUTLOOK.COM/
[2]: https://lore.kernel.org/all/20250902-587-git-fetch-1-fails-fetches-on-=
case-insensitive-repositories-v1-0-35e69bbb507d@gmail.com/

> --
> Kristoffer Haugsbakk

--0000000000001fd8f2063dd754f2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 82a935bc54433366_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pM1UyQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNFFLREFDYkVleHV1eEZ0T1NBYTAvbktDVnFrSk42aAo2VWQrV2R0c21G
SndCSzVaeTFXZHp3UnVMa2pJaVBWcHBIbWxYRHQ2M3hVOGRqM2VyVnBrU09tV25XRTgwU1ZmCmM4
MmJSQ3Q0WEJaaHlWbVV0YnhYMGZlM2dGT29FR0pUUjUwU1YzV004U21hSDBPcStab0xUcDBRcUcv
c1dmUWYKSjM2azFQSTB5QWdXdW40MFNjUUV1WnhLTTFFNEJwdUdWdkk3bmV4aGFIR2cvRnRsK2FQ
YXRONGFWaHh1ZkNCcwoxdCthdmc4RU5aWU9HSEM1dHV4aW5EVmVhcWRaaTRPbmtCQWpJcjNIcjRP
bitGQjl1UE1yUnFpdFArOWpJemViCmppaTdEQjFpTnZvLy9rSGptM2lQT3BBQXpER2hyUFc2OWwz
ZmVsMXBhbitmOFEyVXVqWG9wN1NVRnp4UlFhcUcKYWdwNThhWTJLRldHTTU1ODhJN2VKU25mLzZk
SHdseWVPOFpUVVFUTVpaaHdFOGw0S1VUbGdSZmthZzNrR3lVbgpMUmZVakpmYjhJSjNKbVdZUzFB
Nk9ZYXdUekZ2RWhvemowdWxVWnhZU1laSVZWUmVkUzIvb1BsTzFxa1VwZE5pCkZ3SXdsZ3VwTVV5
bWdqd2M2Qkh1L21PdlhadDhYTXMrMWJhcmdsUT0KPWEvbmMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001fd8f2063dd754f2--
