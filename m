Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B996ADD
	for <git@vger.kernel.org>; Thu, 22 May 2025 09:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747904987; cv=none; b=UwG7G0IVFBHmx6gvHOYGH3uJkKhX35bnOkTkkP9UxajP9j3qfmqQ7UxT7Wd56F7CudRxpMNHV1ruZppAWZF8CVTYGwznqXTNEI34OqmdQnB/ATiJT1QrBHgf7+DmCD584QF5vXtSPHGissLILI5DdhzhS25u0Hyy7gA0on1AZAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747904987; c=relaxed/simple;
	bh=7tDZvErsPIt6aSQoLS27OVwjtLKqazVV6WznA9RwK7w=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gAoPfROxMIpyMu8nNn+GF7i7Gm64beRJRBYmikXrWfgZ7st2YgeNOIwjl6lcIVKc1VLFuly+bEhMbV/Fb+4K/f1A8u70ycZoukAh1mgR6uqvj/jeyZSr5yDR/hR8kG0iSSgmzs+7E+gd3JJTS6Lz/x7J/5V7noL88SJdvAw36lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ql8UFVtW; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ql8UFVtW"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6f8b10b807fso84614176d6.1
        for <git@vger.kernel.org>; Thu, 22 May 2025 02:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747904984; x=1748509784; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MqleNCScFnwoiBuQngMTjtP38RQzlQc4BVyg3yCS3lM=;
        b=Ql8UFVtWa59C/ioNe6wJkBmderKB9JLfoxiMM38mmjCi+TtHJ6ZrlO6hjrrUpgZMaq
         8h9vw4FA8h7Q2S6sArQsbKm+Vsg5+BkN9HLi8dTroc3klmYqK038jrej4ygAUtwxf3ga
         01vdf8aR0xVkmGpdVd+Am+CjbL4yx+p/eGcOtVXEzp3H0g4cXYwENGRDyhaG0IpQiZxr
         u06iE2M/AXx9LnX04hb/0cW0M83zvmCjY7znIJHzHvHdYE3M5dz0HcN6E4r3a2yHQiXp
         s3omKUWDv1eQ/5bCsYcWKRKyqDeC8iaNdT3PqY+w1InbKTWnAKQe4SQiO7kge8NFJtBw
         1kuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747904984; x=1748509784;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MqleNCScFnwoiBuQngMTjtP38RQzlQc4BVyg3yCS3lM=;
        b=kaHv1sN0IRaUKyjrQJOg8MhfFDDQHQHrkblLZfTMWYqon9rbMm9tylWDzkcE1GxLxN
         sVtv1MIDDqDnib33yJouVv8WRVUxbwKKF/coDBhuw05f9Jg/nUAsYopZ3ZrblQpHsOC8
         6YTNi4lvRTtKHicSVXlOvO2t+4ygD8GOdKtV4TGd2ih92Jf854K62Up1vbtAQrlZG4W3
         qn3oNS5LQXVZe70GHubnrjAWoWT8yUs1KPNQ56sBBYbUFXgo/fhW5bPVFsjIqcMXtzKm
         C5XZM5qAZYOD6IrQ6+dPHzSbUPX1ClOIZDo33z2eWKNqlvQ8TcM31eYLIHLuP0c/uNbz
         N3aA==
X-Forwarded-Encrypted: i=1; AJvYcCUnlmHVQ9ZK79zUi6wSIOyaxha+SWcrtevjqym3s7Bu7ugo6K9qP5ZrckmKgnzvuw8Duj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKsIRzi479uniDIoRdXfwj9or3DHuGlqPe9VFFztyOUSQjQ2mG
	IMvv8nMwv3lM5VjYEZAKLMvDTrMQ8Bs5uuHww/WHYxDlqVm98YyT9KTvjz0WAXbbAmVbGPdZSyX
	sve3YKUbw3q7AxNMWq9e4iRpHnioetekSy4AF
X-Gm-Gg: ASbGncsHVFrEFcYORIypli2FgBQoNBnSAEcTR8+EtPvm3WWUK64QGdyWhhGLQAGYNJb
	drvwJvn6ZXpIi6NQ5P2Ww0uJt9BccClZpyZ/pUN3kYEmK65/x8QoovumEEJoxjxNnb1R/+PL221
	VAkDGBgYzgTLkzhvAzGZz7yTEoP2SVChFTbk4o34QdKsLzdWm1VMs31FGI/cEBPxyOKW0=
X-Google-Smtp-Source: AGHT+IFDWHN58QNJ+kaXa3RIx0CdF1EATxp2G2nwnXD+z6AnAG47ykFiAz1hTkYnKko3uS1qQM3L/7v1M6C6GnGb0xM=
X-Received: by 2002:a05:6122:1e02:b0:520:61ee:c821 with SMTP id
 71dfb90a1353d-52dba83a7damr22909990e0c.3.1747904974111; Thu, 22 May 2025
 02:09:34 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 May 2025 04:09:32 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 May 2025 04:09:32 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250520163218.263921-1-jltobler@gmail.com>
References: <20250520014920.201736-1-jltobler@gmail.com> <20250520163218.263921-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 22 May 2025 04:09:32 -0500
X-Gm-Features: AX0GCFv7VkeyaMtRJJ4wLYMMTt8ErqdGoMg8Cmlq9Dh94A4iUoBV6iv3-xv83MM
Message-ID: <CAOLa=ZTYR1JnVzgYMMLsnmFaOJy=EBTKADxV--zAT1AALvH2eQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] builtin/receive-pack: introduce option to skip
 connectivity checks
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im
Content-Type: multipart/mixed; boundary="0000000000001575030635b5d701"

--0000000000001575030635b5d701
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

[snip]

> Range-diff against v1:
> 1:  f659612c9d = 1:  f659612c9d t5410: test receive-pack connectivity check
> 2:  31e5f41983 ! 2:  f6dbb02778 builtin/receive-pack: add option to skip connectivity check
>     @@ Commit message
>          During git-receive-pack(1), connectivity of the object graph is
>          validated to ensure that the received packfile does not leave the
>          repository in a broken state. This is done via git-rev-list(1) and
>     -    walking the objects which can be expensive for large repositories.
>     +    walking the objects, which can be expensive for large repositories.
>
>          Generally, this check is critical to avoid an incomplete received
>          packfile from corrupting a repository. Server operators may have
>          additional knowledge though around exactly how Git is being used on the
>          server-side which can be used to facilitate more efficient connectivity
>     -    computatation of incoming objects.
>     +    computation of incoming objects.
>
>          For example, if it can be ensured that all objects in a repository are
>          connected and do not depend on any missing objects, the connectivity of
>     @@ Documentation/git-receive-pack.adoc: OPTIONS
>       	`--http-backend-info-refs` in linkgit:git-upload-pack[1].
>
>      +--skip-connectivity-check::
>     -+	Bypasses the connectivity checks performed to validate incoming
>     -+	objects. This option exists for server operators that may want to
>     -+	implement their own object connectivity check outside of Git. This is
>     -+	useful in such cases where the server-side knows additional information
>     -+	about how Git is being used and thus can rely on guarantees to more
>     -+	efficiently compute object connectivity that Git itself cannot make.
>     -+	Usage of this option without a separate mechanism to validate and
>     -+	ensure incoming objects connect properly to the references risks a
>     -+	repository becoming corrupted and should not be used in the general
>     -+	case.
>     ++	Bypasses the connectivity checks that validate the existence of all
>     ++	objects in the transitive closure of reachable objects. This option is
>     ++	intended for server operators that want to implement their own object
>     ++	connectivity validation outside of Git. This is useful in such cases
>     ++	where the server-side knows additional information about how Git is
>     ++	being used and thus can rely on certain guarantees to more efficiently
>     ++	compute object connectivity that Git itself cannot make. Usage of this
>     ++	option without a reliable external mechanism to ensure full reachable
>     ++	object connectivity risks corrupting the repository and should not be
>     ++	used in the general case.
>      +
>       PRE-RECEIVE HOOK
>       ----------------
>     @@ t/t5410-receive-pack.sh: test_expect_success 'receive-pack missing objects fails
>      +
>      +	test_grep ! "missing necessary objects" actual &&
>      +	test_must_be_empty err &&
>     -+	git -C remote.git cat-file -e $(git -C repo rev-parse HEAD)
>     ++	git -C remote.git cat-file -e $(git -C repo rev-parse HEAD) &&
>     ++	test_must_fail git -C remote.git rev-list $(git -C repo rev-parse HEAD)
>      +'
>      +
>       test_done
>
> base-commit: 6c0bd1fc70efaf053abe4e57c976afdc72d15377
> --
> 2.49.0.111.g5b97a56fa0

The range-diff looks good, and seems to address the review comments from
the previous iteration. The series looks good to me!

Thanks,
Karthik

--0000000000001575030635b5d701
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 45c2e8e5a327d10b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ndTZjb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meHhGQy8wWUprdElRaVp2V2hLbXdGWTZldmh0SVE3WAo4NEI0R2VXWFIw
TkxtVjk4OVlxd0JadWZqOEswODI1Zm5kN3VWbVBxcmx1a1dtdlZ5amRrTDBtUzRFWm1KL2YrClNm
NklnRUZWREc5OW91ekJNdnQxSHRwOU1BWHRNRkE5aDdZOHR4clVTckkyTlVJdnNTU1lCb0hSbDEx
SUh1b0oKNmc0SXpmSXJvM1BLbVFHcGVhSzZaUTRId0hDL1pUV2xkY3ZrZnJIaHpFNzZjdXVFc2lN
clNHcnpPNDl6ajN5ZApFa1ZZaVdURjhGdzI0Nm16STFCejErcVFnR2NNVFJOSDNmRGVaNnlOODIv
WVRJMzdPZUY5WEExTUdiQXBDUlNoCkhxTm1nWDUzVFhFTTlYRnNPVVdEc0VlMGl4S01vZFlCRnQx
ZU42eFFWbkZRNXdoT0Jja1pySkdpaUxKSytpWTAKQWUrcTg3eSt4TXFTeGVQZzRWMkhvNTVLQ2lr
a1pXVmRJdnRZSkNtbGZGSFhWM0R0d3FzYjlBb04vY0psUGdnSgpkcHhiYmozSjY3bVh4WVdkazRq
cUNlY3hlUFM3YkFGL045YWdhTnhBeWxnMkdsbno0VlJlK1g0OGJNM3dUUEhKClRFY3RqMGpmd1Ey
ODFUbHYyRFhSU2NEVDlqR09PanVndlVQU2NBWT0KPVF2QTMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001575030635b5d701--
