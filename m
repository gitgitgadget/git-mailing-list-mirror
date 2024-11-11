Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E83B13C81B
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321822; cv=none; b=Luus9ZrB79jQPa7cgY4zZ/6yorhADwFbwjVdIDunNVWXGOD0YsscXl0Knnu8sHGAcaqD83UC5/k9v3/hgsTcDWDo4cxrW9hYJezw38FAicoLFiMMEV0TpOtTIxnzTuw6D8f4ib8a4dirUSvGEGcmSpWaei8Dyl/BnQn78ETTTs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321822; c=relaxed/simple;
	bh=s844iPwi3Alo7IXAVUYi3SP7NA1FGfcAz3ppH3tF3pQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=krp4a3iX7RIqdorDyELbzSxsW05prt1bQye9z3t8d0XIwnDm2V7jAzh3wXYLVpR/nzqpkffGJe2HCJZb+d67T9rESN4XaVV4ungCWXKdXDyS4NGVMYkPBciocttBzysTTdlOxpJHuVdCchvUVLdWexppjZRfPsBwodSPGTuPLjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tk9ffwOL; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tk9ffwOL"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-50d32d82bd8so1346188e0c.1
        for <git@vger.kernel.org>; Mon, 11 Nov 2024 02:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731321820; x=1731926620; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wi1iG92iWTeN3kR/IXL6LQFQ7yMThR0j6G6RRcrkUsk=;
        b=Tk9ffwOLfMxTbbg5qWbRC4OSRhOcGjo/CcPM+2DIT71XBRh4vYyxmnoytoL5M93C3G
         WETB3OZNbIXxQebL4DQeF0Jqd0XVSjnytttECjJV7kKPSjwdCLYsMbxsMtHv9OCOMml/
         pVgRlEtg9cDp/jUuizg11+f03wF8XeTNKhyTnpMbjH25YvSEceHnXnheuj3m33BdpF/w
         RycuUH5ifzX+gKgAsZA4pu52tqyyzzvORYtcvoCe2ez6NbaUL6kjHxBRpGdoQIX26xYH
         22DoPgDrStp5Hm2h7MqUFvLtNH+wyrE7MbqAc7YFOBaDEOwWdulx1A+hE53NSvKv79vG
         8NCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731321820; x=1731926620;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wi1iG92iWTeN3kR/IXL6LQFQ7yMThR0j6G6RRcrkUsk=;
        b=F9SyHq6oTSOf5BuReb/Y5EME4+AI1NOK9OtiU1pHwooXtyHc+E8w+KPyFx4e3JgKrd
         tnfCWFJ06djlvLn69BWsaKT5z4mxod2oO4o9brEK1EcNlr/VHB+VT2QeK/s5R1boo1uC
         nndFIsNIEUuTQ9dtpmMmLxuzPnYPETBPHdk3sO3ed0GZ8D9Vp3bHVtLVYx+cm2gqreln
         SJBfrWPN8Ywnfx3/jBub0uX1+pY3/ylm8ALct3jz2gM1JH/jitQuC81D0QHrB5tbdk+3
         utv3K6OTU4pLmmEscQTTPLCc1zAreWsQ+ppNDCYUk5LlcUo1ICPQ9FJnwgchW94DiIyC
         sTtw==
X-Forwarded-Encrypted: i=1; AJvYcCWKz9cVC7yMppL+eN0aZdHWVQ0NAvfoupeYHY0rfWLdjR+RC5T0kOTFQkFg2ETCLzcA//A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7FyiZFdwovg8VoxkaV95ABjeUg3PPvCK1pspHsolN0Mu4zuGL
	umQ5iWdk45ZOvt6PRD93jqJXgRusLyV4vpBrHSVHHTMcxxKnuVuV/+fPMG60Dx/kukG2FHivi2V
	uKYJTDE3hNW/Nx/wwdGzRJwtp+2w=
X-Google-Smtp-Source: AGHT+IHRx30U9Ws58Yqjzv4qKLUgyi5X7sUHJEKzs7P6IPsmXzFiIBCxLIKhZ0SIDv19E9hzLY/rJL+JZsBiwOKs36k=
X-Received: by 2002:a05:6122:ca8:b0:50d:4cb8:5b10 with SMTP id
 71dfb90a1353d-51401bb63e2mr11444219e0c.4.1731321820178; Mon, 11 Nov 2024
 02:43:40 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 11 Nov 2024 04:43:39 -0600
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <20241108-pks-refs-optimize-migrations-v1-5-7fd37fa80e35@pks.im>
References: <20241108-pks-refs-optimize-migrations-v1-0-7fd37fa80e35@pks.im> <20241108-pks-refs-optimize-migrations-v1-5-7fd37fa80e35@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 11 Nov 2024 04:43:39 -0600
Message-ID: <CAOLa=ZSOVYKgwkm-4w6cr_SSpGTJ2QMC-5pa3xm3mR5sBWmYMQ@mail.gmail.com>
Subject: Re: [PATCH 05/10] refs: use "initial" transaction semantics to
 migrate refs
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000001595170626a0c6c1"

--0000000000001595170626a0c6c1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

> Until now, we couldn't use "initial" transaction semantics to migrate
> refs because the "files" backend only supported writing regular refs via
> the initial transaction because it simply mapped the transaction to a
> "packed-refs" transaction. But with the preceding commit, the "files"
> backend has learned to also write symbolic and root refs in the initial
> transaction by creating a second transaction for all refs that need to
> be written as loose refs.
>
> Adapt the code to migrate refs to commit the transaction as an initial
> transaction. This results in a signiticant speedup when migrating many
> refs:
>
>     Benchmark 1: migrate reftable:files (refcount =3D 100000, revision =
=3D HEAD~)
>       Time (mean =C2=B1 =CF=83):      3.247 s =C2=B1  0.034 s    [User: 0=
.485 s, System: 2.722 s]
>       Range (min =E2=80=A6 max):    3.216 s =E2=80=A6  3.309 s    10 runs
>
>     Benchmark 2: migrate reftable:files (refcount =3D 100000, revision =
=3D HEAD)
>       Time (mean =C2=B1 =CF=83):     453.6 ms =C2=B1   1.9 ms    [User: 2=
14.6 ms, System: 230.5 ms]
>       Range (min =E2=80=A6 max):   451.5 ms =E2=80=A6 456.4 ms    10 runs
>
>     Summary
>       migrate reftable:files (refcount =3D 100000, revision =3D HEAD) ran
>         7.16 =C2=B1 0.08 times faster than migrate reftable:files (refcou=
nt =3D 100000, revision =3D HEAD~)
>
> As the reftable backend doesn't (yet) special-case initial transactions
> there is no comparable speedup for that backend.
>

Nice. Really like how the actual perf changes were built up to a single
line change.

[snip]

--0000000000001595170626a0c6c1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ce8849269299ce34_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jeDM5b1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNkFpQy93S2dnS09MSzRpaTM5eEw3b0xLQ2xlc1ZrNApMTEtqbGJoTDl0
aW1xb09tdEdqaTdhUXZWaDZLUHdmM2NwczQ5WHNGOU5FR2xjL0xhbk9MVEdTak5SUHdRVEwzCi8z
bDhTa1NHd3k3ME0zYUtYRk9uWGdKZG41KzFsd2o4U2d5SE5xQmRhamJ4RWZzUFAwMXZUZ09wcXpB
QkovSGIKNG10dHByTjlOMlJnbllEOElDNGVlWUhWeEFqeWxKMmJVTVNoc3lUc3dtMjhGcjhBUkJW
QVhaY2dIdmVWVHFXMgo0bkI1WlBWV0l1RC82cDlDTzlFMmt3OVc0Z2pNWlZFT3RHQjFLTll6UUlO
ZFpvZmVSaU54TzBLRHUwUFVvMEFYClUzZE5SZ1J5TGdLdWF5eHZmUkNOM2FzUnRsKzhwTURZc24v
OTZmQ0FDR0V4KzlwUXgvQ09wb3hKd0NyYmxvdVoKNkRaVFpuT0VvTm9HQmdsMFU4Ni9BaWpXaTI5
Uk9seDBjZmpyZW04VkprdUtlME9MZy93clhHNlRwc3VsWktXVwpGc0pOM1FXVHEwY3FJZ3ErdXVN
MURQR2ViTjA4TUg0ZmtFOVpITTFjSGYyMHllaFRGUGI0Q0FySk40RDBBUjlnCjV6SHJ0ZTJnQnVv
ZnR5dHVmNEtNd3pHc3RpWGRQWVlieXNNRTIzOD0KPXlaN3kKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001595170626a0c6c1--
