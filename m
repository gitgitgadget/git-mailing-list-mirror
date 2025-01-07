Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306BF1F191B
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 14:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261831; cv=none; b=cvSjQIT1JmWdudLuSZvoo3js8ZlPM74vN37ZcC1EZ7J/30uAnlTJ8kb1V82g92wJtK86Fo8JujRCmyP7PhgHtTiR3V1io2yrIMkvgBlD+zf+55FHHduQ8qzES+vdKSaeSHVMkHCtKEuadRS20ZYwf5q7gMkD8q4glFZVOdwMF7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261831; c=relaxed/simple;
	bh=OMJVcj15UZjQU/Y8rhyo6mdGT+E962pMEu6zG2g+V60=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JBu4ogsVHLhc2UQ+FYC8s2doB4dWzkhiPha3NAOUBUPi78jZ5vldrNs0fjprFNa1pqbQryur9gEUgWI8+5HGJShmHAg7aaa+fVratnO95RxtCFA4yS55i5L6Wi6/WyY72wcK9s2Ut5GnIrEKypu3D6ssoc2b/XXU2kh1tZy9SUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hd1nxbrV; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hd1nxbrV"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4aff620b232so4816129137.0
        for <git@vger.kernel.org>; Tue, 07 Jan 2025 06:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736261829; x=1736866629; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OMJVcj15UZjQU/Y8rhyo6mdGT+E962pMEu6zG2g+V60=;
        b=hd1nxbrVz8LVnuOXHTcoMzJ66tMwW5M4L4o1atYOOtUKFIMVhRvDPFokHfOsMoTetN
         HHpV4bIpLp/7nEEbA+2dyb6NiBtCp8YFItZ9Ymd1uJK4OITPNGwv4ztR40KHnWk0Fqpd
         U5lzZwybxUBSFkQSIvh3pVqK2YVMxXHpeOzf8p0gY5oK4CExKMTL2RH23HqQU142P71x
         4z00PLjGVjRYr7BCd9riDEH9Pewuu5zaCAFP5LQXDmFTvEo66w/SUzb+/oCUWtezrZ8Y
         j/B5uiLTlK7Q9Ln7RquQ0gYoWjdU6VnkUpPAVda8mrlqt3TOpnUkLb+acNpTXzyxY/oh
         oFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736261829; x=1736866629;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OMJVcj15UZjQU/Y8rhyo6mdGT+E962pMEu6zG2g+V60=;
        b=eCu3Bf4hmsCECmqJGL6PSBF3jy0lsyQSKHOcyZFjNYiN0dHbE3ELLqCKazwhbpK5Ag
         4lTvwtRkzbH77zmWawK47/kt3kOogLW1DeGD8up6z7/f3HjlED4Rx7I8EFYeLa4cOkRd
         zvE96OO6sJ763gebcJd1/fvtdP9KF1wsTbtPadHp3pfW3e0Ip3HLK3igr+AvY+gYFzc/
         zdSyTPYspRWuSazzVALWuFoAYjK/9ciS4xy4XBTWJAPbSLdWD01uQK+0h/a8UaRnh4uJ
         evYf2MQluyEBMRnQLFYYr4LHILTxssTOTN3RPmtz+k7JNhf0BWAFsoRESnrSZwL70L7C
         NlNw==
X-Forwarded-Encrypted: i=1; AJvYcCUomg2SlNaD5fd3bFA933rZUCMXkWqD85qfq1bbOylfweAKYodblCF0GQekXCkiR33kDfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlkTl4d2Cb5FStDPrmV11ed2yl4LnGYNnXLxOGKMvfBvY55aiU
	qvzNH9ymv4OfpFqGZEPCxUyNAhf94DjK8YCMU5Ib9QcKvxxXcmTCVPjljMgZaikEGTZ3RfVkWdI
	QWCiBK715Vbw+Jyk6FK3bB1urvkVYTNhC
X-Gm-Gg: ASbGncuVZyS25N7Wcqg1ZOoKVJbfLNigPTgb9E/oKYbMpzb/k8CjQTZiayoxwAj6bRL
	3pCXS06smphiuCR3mSX35eXa0dHSitEMEc8G3/J4=
X-Google-Smtp-Source: AGHT+IGfEkpErK1cI030PQGUTvGj54gooX6dw7/hA9B8HqT+FElqNdb846oBkmT3mLzYgiTq2Ep8O6wOltorUOa14t0=
X-Received: by 2002:a05:6102:1621:b0:4af:f43b:9b0d with SMTP id
 ada2fe7eead31-4b2cc48982dmr44688685137.27.1736261828614; Tue, 07 Jan 2025
 06:57:08 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 7 Jan 2025 06:57:08 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z3qN30z1NCXa3AX-@ArchLinux>
References: <Z3qNUizvHJLgMx1y@ArchLinux> <Z3qN30z1NCXa3AX-@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 7 Jan 2025 06:57:08 -0800
X-Gm-Features: AbW1kvYDe7PqXi0JtXjP_CtTOBpjRU8hkdv_ie_VzsIy7nqjAdAkXFWo6jMLHbo
Message-ID: <CAOLa=ZQ6J9GLQjJihKxbDwH6SmHbmVq4sHrKh0ZtMqyEt3hsiw@mail.gmail.com>
Subject: Re: [PATCH 02/10] builtin/refs.h: get worktrees without reading head info
To: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: multipart/mixed; boundary="000000000000884195062b1ef5ad"

--000000000000884195062b1ef5ad
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

> In "packed-backend.c", there are some functions such as "create_snapshot"
> and "next_record" which would check the correctness of the content of
> the "packed-ref" file. When anything is bad, the program will die.

So you're saying, `create_snapshot()` and `next_record()` exit the
program on any error. Okay that seems to be valid.

> It may seem that we have nothing relevant to above feature, because we
> are going to read and parse the raw "packed-ref" file without creating
> the snapshot and using the ref iterator to check the consistency.
>
> However, when using "get_worktrees" in "builtin/refs", we will parse the
> head information. If the referent of the "HEAD" is inside the
> "packed-ref", we will call "create_snapshot" and "next_record" functions
> to parse the "packed-ref" to get the head information. And if there are
> something wrong, the program will die.
>
> Although this behavior has no harm for the program, it will
> short-circuit the program. When the users execute "git refs verify" or
> "git fsck", we don't want to simply die the program but rather show the
> warnings or errors as many as possible to info the users. So, we should
> avoiding reading the head info.
>

This is a bit tricky here. If the information for the `HEAD` ref is
incorrect in the packed-refs, git would exit early. Which is what we're
trying to avoid in this patch, by using the `get_worktrees_internal()`
function.

However, I would question if this is the right approach. Shouldn't
`get_worktree()` failing indicate that the repository is invalid? In
that case does it really make sense to allow the user to even run `git
refs verify`? Isn't the prerequisite for running the `git-refs(1)`
command a valid repository?

Generally, I'd agree that we try to obtain all errors so that the user
can get a full picture. But exposing internal worktree functions so we
treat invalid repos as valid repos so we can do that, seems a bit of a
stretch.

> Fortunately, in 465a22b338 (worktree: skip reading HEAD when repairing
> worktrees, 2023-12-29), we have introduced a function
> "get_worktrees_internal" which allows us to get worktrees without
> reading head info.
>
> Create a new exposed function "get_worktrees_without_reading_head", then
> replace the "get_worktrees" in "builtin/refs" with the new created
> function.
>

[snip]

--000000000000884195062b1ef5ad
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 377f0c4e7de8526_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kOVFNRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mdzRCQy85N05HOGk5NHVZNDVvZk1vcXQrUlUxM1ZrMgpFeFE1VWxPcmdm
TGw2bGxhOXdQZVR5cFgrSW50NUhqZTIzSm0ySlVCVHVzMllEdHR6ZUZ1MndYblBVd1FadWNQCnZI
bUtBblNndEhBSDdGaE52UmZRYlJ5QmVBckVaSlJhY2hEVlBIV2tFK1ZNQi8vNkVRQzYyc3RZcGo3
Uzh1QTIKaGwrY08vUkdKdmJOVDh2bEdLUW03ZUpzclZRMERld05QWC95cGloUk0vU2RybFRaVm8y
aldkLzBFeTlvSWc3Rgo3dWsrT0dqTVl0bVBjTG9LWGtkeGFweDJTOVdYMDZ1Tjg0Szh5cWQ0SUd2
R1I2ZlNkdk5VNHNPQTRuVVdPTEJwCllDL0s1Y21Ha1B0L2hSNEt4NHhNUFg2V1VVbWl3WG1BY0ND
Q0x1Tk1lT3U0UmhsQ2FuY0NXOFVsNkk2dE81NHUKeWdEMklrT3pkRnJSVTRYU3BBNVVvTGlTWHh5
dVJuVHQ4RjVxVm1UMUJaZDZBMmRQNVd4R1ZBZG95N3NRZ1VRKwpuWU9ySC9zaEpzc3NGbE81djBq
Ym9CRmgwVzNYM2pRblN3emRVVGpDWEp3bmtETWtLUUYzMXFveHlxdVRuYlNuCk03OXZhRmtVZmNn
dU5ZRnVRZWFhTjhzam1aUEsyYXFkSWZOUFJ3MD0KPWgyd1YKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000884195062b1ef5ad--
