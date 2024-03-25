Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D9F679E5
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387395; cv=none; b=qlQYJ89BrltsIwoZ+s1vb1agr/GrhooRtS28LBVtZz1t5RMjTnH1IIc0acfDrGJlulI2x29ZgRwy/MpEiyVWJvpTVjZUp517lbYXpotAbK94cbe5P1AEnbsw4/dLITiROCJEh2Su4IOo2wSn7SqlaKAItHHbG+URIqaL2RU2I+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387395; c=relaxed/simple;
	bh=kHtmTPfIusGiL6ODhRhFStdAyhKQgstheuUhaPrGqR0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4fd84RVVjJk9YiBleW3ch6Sfh3fWp2cMCys4xy1x3cfbD7SL0TKlPnbqJpKK/bc6UnNUv6EGpUZGvvFlpDQ26eodzDE+9L8dx4fDSG9D6fPlleZIFvQ1v6rhgD0z9JRv7oFN1zc8dJ+BgAwS2J8iPyYg/sC9UhbdzAvfPNy8gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2YqYIO9; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2YqYIO9"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5a529a1f69aso1276936eaf.3
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711387392; x=1711992192; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kHtmTPfIusGiL6ODhRhFStdAyhKQgstheuUhaPrGqR0=;
        b=F2YqYIO9qgvvnqtyQRUgfc1RwDyGJKVTg6z1Pl4sLvsn4Dw6VkNpxbunljXWJzYbYN
         tvH4Wy5iQmSghMBaYrXlCXSLJJxUtqB0GLe08Ir4JWP3hbrBhrxGz1h9rRZE/mY4V7AY
         02qvmJpwV58eB2wUU+K1cgoou//O+k8O8YKa74XEGhXIWjiHQ6AQy0pLfn19Lz6QUQi2
         QMu4xdPCfar91FUOSu9iWj9+2Dj6g7kiovtbZAlcsMfN2+woMsG45aURVDpMVvFiV6VC
         ZXZN7/aRMiPdBdg67Hrop0615XKru6pV9pghv86RJTFIFwHuvJmokFqqjIStqzEC+ahZ
         rhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711387392; x=1711992192;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kHtmTPfIusGiL6ODhRhFStdAyhKQgstheuUhaPrGqR0=;
        b=wuf58bBVzdP8/VngpbcgqF4fZKFg0Q3iu+6G2eeNLWALm+laj7MNMb1qq8kZFUIhsl
         UgJOJFQu9Yj+/0zGwfKVxNDEqdnTJrtAe1mMuBa/aGknD2g4iGOmfROV6LFgCI4ssLfd
         xpPXVqpRkH8YQ/qp8Jrg1ogodOqEYb7vSIk1E4T0nZwKWD6VQIwzynnr3JH5EJAWNwHA
         PqeRbMm4zuNFUG8R7uIpoE4TlIc3oTohBHTrcbXrES8OQfqQaScxLI4R99K+JWImxTIO
         l3Oll5NvpaCpgbmCAcATsT9GiEaONXi4zzIE+gkL/W+yxYZfGgbKiZWAMATbUd2vo8Rp
         5TYg==
X-Gm-Message-State: AOJu0YzolQ9Ba6AKflpHiFLZzU5QDx4i3NF989Lqvh9Apvb8r0WcmHsy
	e1MFEBkXMMGw/+IRuL+ROASm8NpJzBxccUl3prJ4+feSZk4G+T1BoKcxgni68OQeGdQ1fHTX8mQ
	Fmrt16wxiDHDODY9LRRvnxcoA8guejY3vs2I=
X-Google-Smtp-Source: AGHT+IFMQ3+FkEJ1sDCn35Fo03JJWuxB0tmlWFirWy42RNns7xYKwKGWuWuYxSjtQJul84TQNaEN2NAEkjYDc4fwR0w=
X-Received: by 2002:a05:6870:1708:b0:22a:f96:28b3 with SMTP id
 h8-20020a056870170800b0022a0f9628b3mr7012559oae.53.1711387392550; Mon, 25 Mar
 2024 10:23:12 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 25 Mar 2024 10:23:11 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240324174423.55508-1-utsavp0213@gmail.com>
References: <20240319185938.243667-1-utsavp0213@gmail.com> <20240324174423.55508-1-utsavp0213@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 25 Mar 2024 10:23:11 -0700
Message-ID: <CAOLa=ZTSHSErXaZjwxERLgjejqws5fgs43+RoUXp2cgn0fs_Eg@mail.gmail.com>
Subject: Re: [PATCH] userdiff: add builtin driver for typescript language
To: Utsav Parmar <utsavp0213@gmail.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000009b444d06147f6d95"

--0000000000009b444d06147f6d95
Content-Type: text/plain; charset="UTF-8"

Utsav Parmar <utsavp0213@gmail.com> writes:

Hello,

> There are no implementation or test changes in this patch. It simply relies on the git formatting rather than the IDE git UI formatting that I believe messed up in the parent email.
>

I think Patrick mentioned this already, but seems like the new patch
too needs to be wrapped to 72 chars. Also when we send a follow up
patch, we version it accordingly like "[PATCH v2]". I would suggest
reading 'Documentation/MyFirstContribution.txt'.

--0000000000009b444d06147f6d95
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ebdabd3f01e3cb8c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZQnN2MFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNEZ3Qy85STliVE9GZ2lsRkF2WjVwcnlBbkR5TkZnVwo1NCtHMHB6SDVC
Q2lmc3lXWDQ5dXF5SUluc0MreHV6YU1uWDNydlFmc1R0WlRZa3V5TkZrUkFTVFhuQmJ4UWdxClJr
N0JYRHBkZzlISC85VmUybXRzbjlsZDA0cSs4T0x1aloxdFpSc0dHRjNuVVdBRDVtN2R5T2NBMzc2
VE16djEKc3N2NTRac3BYRm0vb2wxNXAvTlRMS3hreWZQTk0zZklYVWxETVVPWHpndE53dkovMTQx
bWpNeFV1bGZVd25xMgppWFcvVWpkMGtGNG0wR2RzV3NjMGZlUk9hZnZkS1gvaTV1OUhVbUpCRUJV
cUxqeHdHV01kd1hMdDV1NnE0M3FjClY1WSsxMlZ5Y3pHUkxsTUQ4NGQrUTRoNTYrRDAxSEdndkpK
bjlybkhla0Y0dGJxdzlIOGlmZ2w3V3dvckRyb3EKZGxqZmsyUndTTG9BTjl4RWNDdVVoVUZpUmYr
QW41aVdUTWJtMDBscGd0cndvUGtRL0ozUTVRRC9teTB5SldJNwpKaW9mdnZPUGp2OFFJVjVsV05y
VURkOU05R3QrWG12NkdkWmF1VlBkQnhBZktnVEIveW8wYTNIc21Pc2ZPM1o0CkFHMHFESVpYVkhr
aWxicGJaWnBsQ3phRnhXOExWUGliY0t0L3lHND0KPXhEM28KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009b444d06147f6d95--
