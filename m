Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304B91624ED
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270826; cv=none; b=DFUz6XffVpeBO4V99mjN6H+Fg60MEt8Xs1Tvwdl/ghLVwVI8+6kEzfKZEsiv9yFBsrJ39/bpPMKDlLMfDY+8AxY1NoV0I5RUjgLI8No2tB7a1oYiuu5uAYHOPAGhLjhJYbaUhz7TgaKTHqX3y6ChNiwXg1/7qV56IqrNZ+XbH20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270826; c=relaxed/simple;
	bh=LvcpKGQki3fNTwehHNFePFM2SozOBhkOX0MJN4+1G6c=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a3n76WZpZHJnAXG176trWFz+iO7AO0ZqoRWh5zmkZ8Pf0FO8RGV/0XUcStdGUT6DHKmX64gGJCsEuPta2w3UucAktaxeT1Vk3+E3hKGNhp6w128Nuh7KVKXVlbLOpk+txlHQDKEXgMde68No+ZtkmGImwVhxk/h6+YohncSzck0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDkUMuyL; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDkUMuyL"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-523b7013dc8so290178e0c.0
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 06:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741270824; x=1741875624; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uMtD5kno+niLJlZO04uPr1jumOXXe6uEr6PQdCruRh8=;
        b=gDkUMuyLJS0yYJgdOKB8OUQ1mkfPIB6c6NV06GJ+xjh+tSaKRMHtnq4NxEjLZ1dd5Y
         Rup1HDmpNBhHvsa1cfy4w0O3asRq+YLdw1fmLWh5T2MJz6zhNMv7wLZRXTiUWeazSPT1
         OPTFKuKFX+V4Q1p9ANRvhnVPNyBzRihy89wYZEQPc2FaHbp8uYxJaVoqq7wn/4oZdbs/
         zlkF6Hmb11FbuFoemzAcJiDPPfv3HyrgmgxwisIlIMfPqiaUtcp5i+xh83REb/ZYThUO
         UOSKZvespu/ufInEql6xmsqtQxo71Ni0FwnnfyaT4TuXLpEMydyc0v5dujhjyg/7JUa5
         B/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741270824; x=1741875624;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uMtD5kno+niLJlZO04uPr1jumOXXe6uEr6PQdCruRh8=;
        b=hdbqhkAjI8jz4aYPoPeDyqQ9mHBsyfy5zsId4GtzrCRoBFZIR8KwoBegXyko8Sre9k
         EKLrDABqkOFSrZdelAgk/mpXcN4zeRpdjfHaWCA7OFn1swgeWlSCeJZKcCmpgNF86aGh
         6DJBCKpGSO0gDCl8HrumiS6VboH+uFYC37Fohxp0W52Coh7rQ/ibu5TNmesDKFg24LvV
         t+1PpCZQ2wANLFSTx/eYaG6Uglkov1HBIHScVVZtnsp8zUg3UI9pDC7znF85Ha9aLidM
         2KJwSwXZVjMDFnWL7kvp24jckZTq24qV6iQJZmZ4iKQu2AS4nRp9d6pfCirakPKidOPP
         tf0A==
X-Forwarded-Encrypted: i=1; AJvYcCU2xLT+nmZUObSoIw3XLjNvNyM/KNALDHHnIOhDlQINGux4s9LIOrtcAbJtEXexzK5NkMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMhUJn/ZRlgaVJcvd6N/+1STEnwvvmi9QzkHCNjZs+1yKWqJ8C
	zlzNLIq2S31gqtGGc5NYsA5GGd6AAqaKA1eDXYI8qnZMRmcYQs/oT284uBLaNOQx9X6ehBAw3rY
	PQbnDklOQh2/uvk4469notDN4jJ0=
X-Gm-Gg: ASbGncucTVMqEz/ECB446lLQX2erkBYW4xZUzRvhVXtzKokc1+Mtpf3dUA75h3ICkiI
	CQZzCzy9r2h1jcbq+1AC23snBkTU1P3p9q1XuSNMj1+EGlDrL3cVSCg2/LyD8JRkuLPw/y9wgdf
	QSottFMtSahnRewp824CouoyabnHY=
X-Google-Smtp-Source: AGHT+IHmpwyYQtYnrAHXAs4GQvsC+oJifbfn5gjxyKZkVRp3yFAlO/G7Dn07eimNznoS7D+oHJXb6n6S9LLHcpazfzw=
X-Received: by 2002:a05:6122:310f:b0:51b:a11f:cbdb with SMTP id
 71dfb90a1353d-523c61423ffmr4078253e0c.4.1741270823852; Thu, 06 Mar 2025
 06:20:23 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Mar 2025 08:20:22 -0600
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im>
References: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im> <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 6 Mar 2025 08:20:22 -0600
X-Gm-Features: AQ5f1JqLj5H3pW_4Q4q2t-yqNC37FQbvjEfp35Y7SvZ_GT9ZdUDzVzdz1svjlY4
Message-ID: <CAOLa=ZR-AEGuKGARzrhXSpeJFWQrDSoTzsq3EfMQzH5PDqCxkA@mail.gmail.com>
Subject: Re: [PATCH v4 00/16] refs: batch refname availability checks
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, Jeff King <peff@peff.net>, 
	Junio C Hamano <gitster@pobox.com>, shejialuo <shejialuo@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="000000000000ea0673062fad3437"

--000000000000ea0673062fad3437
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series has been inspired by brian's report that the reftable
> backend is significantly slower when writing many references compared to
> the files backend. As explained in that thread, the underlying issue is
> the design of tombstone references: when we first delete all references
> in a repository and then recreate them, we still have all the tombstones
> and thus we need to churn through all of them to figure out that they
> have been deleted in the first place. The files backend does not have
> this issue.
>
> I consider the benchmark itself to be kind of broken, as it stems from
> us deleting all refs and then recreating them. And if you pack refs in
> between then the "reftable" backend outperforms the "files" backend.
>
> But there are a couple of opportunities here anyway. While we cannot
> make the underlying issue of tombstones being less efficient go away,
> this has prompted me to have a deeper look at where we spend all the
> time. There are three ideas in this series:
>
>   - git-update-ref(1) performs ambiguity checks for any full-size object
>     ID, which triggers a lot of reads. This is somewhat pointless though
>     given that the manpage explicitly points out that the command is
>     about object IDs, even though it does know to parse refs. But being
>     part of plumbing, emitting the warning here does not make a ton of
>     sense, and favoring object IDs over references in these cases is the
>     obvious thing to do anyway.
>
>   - For each ref "refs/heads/bar", we need to verify that neither
>     "refs/heads" nor "refs" exists. This was repeated for every refname,
>     but because most refnames use common prefixes this made us re-check
>     a lot of prefixes. This is addressed by using a `strset` of already
>     checked prefixes.
>
>   - For each ref "refs/heads/bar", we need to verify that no ref
>     "refs/heads/bar/*" exists. We always created a new ref iterator for
>     this check, which requires us to discard all internal state and then
>     recreate it. The reftable library has already been refactored though
>     to have reseekable iterators, so we backfill this functionality to
>     all the other iterators and then reuse the iterator.
>
> With the (somewhat broken) benchmark we see a small speedup with the
> "files" backend:
>
>     Benchmark 1: update-ref (refformat =3D files, revision =3D master)
>       Time (mean =C2=B1 =CF=83):     234.4 ms =C2=B1   1.9 ms    [User: 7=
5.6 ms, System: 157.2 ms]
>       Range (min =E2=80=A6 max):   232.2 ms =E2=80=A6 236.9 ms    10 runs
>
>     Benchmark 2: update-ref (refformat =3D files, revision =3D HEAD)
>       Time (mean =C2=B1 =CF=83):     184.2 ms =C2=B1   2.0 ms    [User: 6=
2.8 ms, System: 119.9 ms]
>       Range (min =E2=80=A6 max):   181.1 ms =E2=80=A6 187.0 ms    10 runs
>
>     Summary
>       update-ref (refformat =3D files, revision =3D HEAD) ran
>         1.27 =C2=B1 0.02 times faster than update-ref (refformat =3D file=
s, revision =3D master)
>
> And a huge speedup with the "reftable" backend:
>
>     Benchmark 1: update-ref (refformat =3D reftable, revision =3D master)
>       Time (mean =C2=B1 =CF=83):     16.852 s =C2=B1  0.061 s    [User: 1=
6.754 s, System: 0.059 s]
>       Range (min =E2=80=A6 max):   16.785 s =E2=80=A6 16.982 s    10 runs
>
>     Benchmark 2: update-ref (refformat =3D reftable, revision =3D HEAD)
>       Time (mean =C2=B1 =CF=83):      2.230 s =C2=B1  0.009 s    [User: 2=
.192 s, System: 0.029 s]
>       Range (min =E2=80=A6 max):    2.215 s =E2=80=A6  2.244 s    10 runs
>
>     Summary
>       update-ref (refformat =3D reftable, revision =3D HEAD) ran
>         7.56 =C2=B1 0.04 times faster than update-ref (refformat =3D reft=
able, revision =3D master)
>
> We're still not up to speed with the "files" backend, but considerably
> better. Given that this is an extreme edge case and not reflective of
> the general case I'm okay with this result for now.
>
> But more importantly, this refactoring also has a positive effect when
> updating references in a repository with preexisting refs, which I
> consider to be the more realistic scenario. The following benchmark
> creates 10k refs with 100k preexisting refs.
>
> With the "files" backend we see a modest improvement:
>
>     Benchmark 1: update-ref: create many refs (refformat =3D files, preex=
isting =3D 100000, new =3D 10000, revision =3D master)
>       Time (mean =C2=B1 =CF=83):     478.4 ms =C2=B1  11.9 ms    [User: 9=
6.7 ms, System: 379.6 ms]
>       Range (min =E2=80=A6 max):   465.4 ms =E2=80=A6 496.6 ms    10 runs
>
>     Benchmark 2: update-ref: create many refs (refformat =3D files, preex=
isting =3D 100000, new =3D 10000, revision =3D HEAD)
>       Time (mean =C2=B1 =CF=83):     388.5 ms =C2=B1  10.3 ms    [User: 5=
2.0 ms, System: 333.8 ms]
>       Range (min =E2=80=A6 max):   376.5 ms =E2=80=A6 403.1 ms    10 runs
>
>     Summary
>       update-ref: create many refs (refformat =3D files, preexisting =3D =
100000, new =3D 10000, revision =3D HEAD) ran
>         1.23 =C2=B1 0.04 times faster than update-ref: create many refs (=
refformat =3D files, preexisting =3D 100000, new =3D 10000, revision =3D ma=
ster)
>
> But with the "reftable" backend we see an almost 5x improvement, where
> it's now ~15x faster than the "files" backend:
>
>     Benchmark 1: update-ref: create many refs (refformat =3D reftable, pr=
eexisting =3D 100000, new =3D 10000, revision =3D master)
>       Time (mean =C2=B1 =CF=83):     153.9 ms =C2=B1   2.0 ms    [User: 9=
6.5 ms, System: 56.6 ms]
>       Range (min =E2=80=A6 max):   150.5 ms =E2=80=A6 158.4 ms    18 runs
>
>     Benchmark 2: update-ref: create many refs (refformat =3D reftable, pr=
eexisting =3D 100000, new =3D 10000, revision =3D HEAD)
>       Time (mean =C2=B1 =CF=83):      32.2 ms =C2=B1   1.2 ms    [User: 2=
7.6 ms, System: 4.3 ms]
>       Range (min =E2=80=A6 max):    29.8 ms =E2=80=A6  38.6 ms    71 runs
>
>     Summary
>       update-ref: create many refs (refformat =3D reftable, preexisting =
=3D 100000, new =3D 10000, revision =3D HEAD) ran
>         4.78 =C2=B1 0.19 times faster than update-ref: create many refs (=
refformat =3D reftable, preexisting =3D 100000, new =3D 10000, revision =3D=
 master)
>
> The series is structured as follows:
>
>   - Patches 1 to 4 implement the logic to skip ambiguity checks in
>     git-update-ref(1).
>
>   - Patch 5 to 8 introduce batched checks.
>
>   - Patch 9 deduplicates the ref prefix checks.
>
>   - Patch 10 to 16 implement the infrastructure to reseek iterators.
>
>   - Patch 17 starts to reuse iterators for nested ref checks.
>
> Changes in v2:
>   - Point out why we also have to touch up the `dir_iterator`.
>   - Fix up the comment explaining `ITER_DONE`.
>   - Fix up comments that show usage patterns of the ref and dir iterator
>     interfaces.
>   - Start batching availability checks in the "files" backend, as well.
>   - Improve the commit message that drops the ambiguity check so that we
>     also point to 25fba78d36b (cat-file: disable object/refname
>     ambiguity check for batch mode, 2013-07-12).
>   - Link to v1: https://lore.kernel.org/r/20250217-pks-update-ref-optimiz=
ation-v1-0-a2b6d87a24af@pks.im
>
> Changes in v3:
>   - Fix one case where we didn't skip ambiguity checks in
>     git-update-ref(1).
>   - Document better that only the prefix can change on reseeking
>     iterators. Other internal state will remain the same.
>   - Fix a memory leak in the ref-cache iterator.
>   - Don't ignore errors returned by `packed_ref_iterator_seek()`.
>   - Link to v2: https://lore.kernel.org/r/20250219-pks-update-ref-optimiz=
ation-v2-0-e696e7220b22@pks.im
>
> Changes in v4:
>   - A couple of clarifications in the commit message that disabled
>     ambiguity warnings.
>   - Link to v3: https://lore.kernel.org/r/20250225-pks-update-ref-optimiz=
ation-v3-0-77c3687cda75@pks.im
>
> Thanks!
>

I did a review of the 4th version and it generally looks great. I've
noted some nits, but I don't see anything that warrants a re-roll.
Thanks

[snip]

--000000000000ea0673062fad3437
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: edb3386d9c99b736_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mSnJ5VVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meEZzREFDZHhHS09acTd4UUdZalZPdVBEeVEzc2N1SQpPTTNSL21kQU44
WE9vdHRXaGFKTDMwN1Z5TnRRcFVMdHQ2R2laWG9VelR2azJaU1VBcXJVZUc0OGcraFdXaUptCjdX
NXdzWVJ4Q001VXBnV2VveU8yT2t2TUVYcWNjTnAvcDNKOTBVSzZjY1oxNVRUcDBlUTJYN29yVzg0
cDVxUi8KZTk4Mkk3L2hoVWp4STlvQ3pSeTBJM0xDRHFBdzhXZktTRHc0eTBMZGdMWUQ4Y2VoS3Av
cHFPYjNtcHFvblJwRwpMZ3ZTOFZId3cxVnRDSHRQelZYaW45UC81VlByQm9UVEFzS09FZjIzL3py
cVBBL0p2VjRJZlFHcUNkTGlXeUZ4CjNySjNwYzBlTmV2R3Q5SnNFUkdJdjlXVXFHTDlqakFYWWpx
YWNLT3dtYU85MVZzampJMjdHUGc3TGx0Rnl0MVoKUjBUZDZpb3JzVFpCdGlTZWtwazVmZnBpMk9m
L2dZUEJVMlZtWWRNS0ZQZGw5d1lneE10TG1URXdiSDZLTW9scwoyUWNDcko5cm1CNytRdDNhajA3
RDZVSHg0WW1IUStGNGVTOEVXSFJBZjVBVGg0Q1JKKy8zRXdtaW9lSVg4VUI2CmVEckxSVjRGbVM3
eS91TURIV1VTUTRPNEEzSDQ3UmYrekVwSW9GQT0KPU9WYlkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ea0673062fad3437--
