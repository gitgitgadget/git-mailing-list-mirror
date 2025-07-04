Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98CD7D07D
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751637741; cv=none; b=sfAJsCHftL1eqemi81Rqeo38CnSjuekd0tz4ABjaKDwVt6I0DNbm5Vj7hthShEVXIB0V/9przIbnnm5bGDMNNpXMUHnp3mQC2OPrJ7owsTy/sYzmtGf2xRYvf1OCYLfCp8hgFbT+xgh6AGp+vaelx3QWj/PzHZcR47ZGWYqNUqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751637741; c=relaxed/simple;
	bh=7Ay0EIaQnBWBvxrW7KEjLjpSCTc5pvqrgz9EUAXjQWc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ia/HSKwXpjiv/L+0SbK2BCEEszY7WiqWe06xNKmtBOae3r3XZSXR5yK1XWoH2dbTu+qIpNPqRTBBNWSxNpN4yjLk4qIXxYLG9n+WLdBAiPsfVgQQ1i4kf7mljj3cTFsauxSvtFhCoT8ovJkXIqaEJHbGIAKNthevGQCgFXoCl/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koo+I4Vb; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koo+I4Vb"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-40ba3c10b3bso352660b6e.1
        for <git@vger.kernel.org>; Fri, 04 Jul 2025 07:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751637738; x=1752242538; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnZjjSlWP2hFqfmX+kvvdnvHf/HyCdDKkFWJMfOb41w=;
        b=koo+I4Vb1EiXOWZgd479xY9upEPNGFrTdH7MS18FeeDQ3KwDrUtaOxFucXD5gstS4g
         89Ow6ox6BrBszvOUwxgn1DW0uAWoJZri5DV1Jqp5KfrRjfXnBI3Y/svn0KqtrMBEHpTf
         mSAKsoeQI1ag/gwa0sdvAV5nbcAC09KIdUfADaN4JdtfZpYXIEx/zvjG925pOL4NqTP1
         Fc8YnNv5t4p90fsPFQg8RoEW6Jm4uZ3KzRFwuN4ug+MTkLRNvS+r5rXVfi0DfKPREpFz
         jFf/2TmKqZ3Gq2IbFOvmqvdihNdEjcJz4ivHT/F3ifuoaAz21UUsoTFXciabXuKnXzCB
         UTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751637738; x=1752242538;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnZjjSlWP2hFqfmX+kvvdnvHf/HyCdDKkFWJMfOb41w=;
        b=K5baaagWtNzGBkkUqdU5htDao1hEoXxWks77fipRPttEtyiJlhpd41TNN6zKmHP1wX
         iqsY/WAUFrEtFQ4x0qFcIZ8dD6yd575GculKxVWMlWtRbf9OYypOOo5D3gqNZvMZwbZj
         t4ALzN26p3VWnOlgoyusvdrD9YJWKemQVoeQzc4Uxh3piypY59N+KUqMtmByL8t53YEQ
         sK07DJzgBvhIvaIs1BN1pNpZsU7tzZXtPyUIiiud803+NQwwBLrlWCDR3874bxMxACXY
         KA588n5QfnK2LI9i9CltDo4yO0AA5veoqQvFOwFr07Na5IAjQp4/r5tuHr6SoX4bTu0j
         GRdg==
X-Gm-Message-State: AOJu0YyhhtoipE55JLQ8A+SFpVrlcfRCR9/HWwdlx1JrgJhccQXiPE3j
	Eo8M8BMPmIb8KebyBjSKCoSwoF4so8uDfnN9X1LtHZK37AOuLvrr44lf1Jkl3SQD2RwbRecJfJG
	wjikHdtMzQWuc7wMWFyfMZajnN8ulxgg4e7Jg
X-Gm-Gg: ASbGncsyufxl9Z5cXcQbx/URepRlHloNgifLzq/XQTWUtIKKT+7UvODU3AYinp/1jfA
	mpcuVxfge13hUPESlBIv4/5q5mXDGW0q0orFIW7DMk5ibQCBsD295ilJdkVhdqY1iNmnt2ZIoJU
	GPAkz8tcPIFgkblC+sVkUMUxr1jTUp+VRgJEB8WDYXOw==
X-Google-Smtp-Source: AGHT+IH8s6nKivRbxYWkcQDA5EsM3LwdJgAj7KKDoS70GLj98+Qo2IT4PWax95/MVsowYfXCJ6s/Ec7HPmtqk2LMv3s=
X-Received: by 2002:a05:6808:1927:b0:40b:2b2e:89c9 with SMTP id
 5614622812f47-40d043a3148mr2087187b6e.16.1751637737816; Fri, 04 Jul 2025
 07:02:17 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 4 Jul 2025 09:02:17 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <87ms9kcbtq.fsf@igel.home>
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
 <20250704-306-git-for-each-ref-pagination-v2-0-bcde14acdd81@gmail.com> <87ms9kcbtq.fsf@igel.home>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 4 Jul 2025 09:02:17 -0500
X-Gm-Features: Ac12FXxWkHvvpuK8iIfgASx5-bMKQr89OACFo5Y07-x1caFGlknlnLESSK_vQGw
Message-ID: <CAOLa=ZS0uP+5xso_SEG2GJZHeac-0F2_wMJKtvbFj_wROKbBkw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] for-each-ref: introduce seeking functionality via '--skip-until'
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im
Content-Type: multipart/mixed; boundary="00000000000023ff3e06391af135"

--00000000000023ff3e06391af135
Content-Type: text/plain; charset="UTF-8"

Andreas Schwab <schwab@linux-m68k.org> writes:

> On Jul 04 2025, Karthik Nayak wrote:
>
>> This series adds a '--skip-until' option in 'git-for-each-ref(1)'. When
>> used, the reference iteration seeks to the first matching reference and
>> iterates from there onward.
>
> I would have named the option --start-with.  It has the advantage that
> it is clear whether the matched ref is included.
>

We did discuss this internally, some other names we thought of:
--skip-to
--start-after
--start-from
--seek
--skip-before
--start-at

I think I was a bit against '--start-from' and '--start-at', because
they imply that the reference provided must exist.

Consider the example

  $ git for-each-ref
  refs/heads/bar
  refs/heads/foo
  refs/heads/main

  $ git for-each-ref --seek=refs/heads/cat
  refs/heads/foo
  refs/heads/main

You can see that the reference doesn't have to exist. So implying that
it should can be a bit confusing.

But I'm open to changing this, if we can conclude on any flag name...

> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."

--00000000000023ff3e06391af135
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5358e6e029f9406a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1objN1Y1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL2hMREFDaVpFN1hvQzdlZVhKSTdpeDQrK2JibUwwMQptcGpkeGM3Q3FK
ajIxdjRURXdmb2lBRDBKRVljL3ErdUZ5ZjIrN0Jtc1RJeVlLaTFMYnRHVmZVTzBOZ0V4STBxCk9P
Qmw3b2JOR01tVWRyWHdQWEdiZ1NmWlpqdWU4S3pVUzY1OFNSMkhCRURMOFV3L09Jc3NndkRBYWV0
NUl4cXYKYmxkRlUzZVdkeDZVcnlMeE9nUlVLbDMweU9CTHk0ZU1WZVp5RTJYMVRJRnFoVUs2RjlE
bndveXloa2dhakFZVApFdHREVlZjdSs2ZWlmdjFYL3BubXNVcXlWNVlKNEdYZFBXYXRiOG1MVHMy
MUFqdFB5WVdsMkRkRncxVGYwMWpyClNTTmR2c0ZiUXhnQklnUkUvcmcwSDVWNkRkbndkZ2VZZFNG
UHdFUkc0NHFQKzg2aUU2V2VhVWZCY0ZuSUVwOVIKb2tpdnJaU1VEYmdyeDY1TzNvL0NTMm1KeTdt
MTkzVTZVZlI1NnhVMldLZURkdTFPUlJLanVFeE1JTkZ0WHpONwpUMGRiQ1lmS240S2YvbEt0d2xy
ekZERnhHWDdpMmk2Y2t6bUZYSjJRWUVZZWZodUZIeUYvd3N5RktYZjVuR0xBCkswRnppVUtZMjg5
aHM3WHdZTGFiSmR4SnVCNHJKQ01FYUo0b2RuUT0KPVR2SVIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000023ff3e06391af135--
