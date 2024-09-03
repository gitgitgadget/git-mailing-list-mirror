Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385FF1C7662
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 09:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354019; cv=none; b=KDSvE/nMl0mSkwpDGG6uY1sbsiRnODO2+YIbsaoGo03YHfJzw5kGvpmW8+hHxMLP9lpgaGlW55aiz6sKB/Vy5uC0tm9bUGpT2WoObeZFV/j7kNDBuJ2qusjvoACiRj2v84TuKLdWFaoUyvNuOH30/fLfK8Hzai4u2gTc6ZuWQf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354019; c=relaxed/simple;
	bh=fXLZ1SDSGCQPHsLOUJ6sfFUUUlT2jLa4OCpjcx5mLFw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=sCMX/a7oUwGs2VGezYmG4kqWJVMe/Lo1ke5Bc7vZDIEZ6oHJ2IAwCSuss6xCPJz4rCI8gRDXzOhjXzClh83XYuEZGa/dUAllIZH/C/G2ajs7o1RI3k4rOhxneZrQ6BtHTN/ZwgZluPGV8areXXECICBkyY8g9VJ+nkF+tqDDekU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kubtIf8W; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kubtIf8W"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2780827dbafso677033fac.1
        for <git@vger.kernel.org>; Tue, 03 Sep 2024 02:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725354017; x=1725958817; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I+4RGV7QHtQUpkJPSE1GhsjI1YdonohoRjh0pLJn2H8=;
        b=kubtIf8WVZSl69rhm7DATOZagA6Y0Mr8ooYfc6d7OjedwT6wBxbte2goMHgYkEIHGt
         12FXU94CZzildecNAqJc7fjkFNgIB8L6XlFYKXFH4l0BFqB6E/rbCctSqIwKzg9hgStr
         oPYFIRQ/4WLDESyA+yKrnH8bNsuafR7Y1SwEIjvYiEoLeynk5H+KIn0kxX9/aUcUw8cw
         eYkEoC28vIVdXr47YY4OsyUmzWHpAuPrNc5yGc5NTwICETKrRUL91SJggwFNTiERV7cr
         uZ2WaK2xLioEIiEWGCEELZ7NiNEcKJhJ1dbvVp6q67b22Eu2G9BDpxgmLN6aeV43Bn7b
         L8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725354017; x=1725958817;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+4RGV7QHtQUpkJPSE1GhsjI1YdonohoRjh0pLJn2H8=;
        b=VKq1qhJy8QPhHtBFcZAQJRAJWLLrj/HSqjESiyRD4jRzC/sRkmQ6TlaqseTfoK+l7g
         oNTzgUF89qRlt1OoUCkpPkjn1SdphXwATuxF3+XAkdaiyRZ3OxNYuEc/lYzwZk1YJioZ
         f80k99JpC91bjEoAfE5x1WQ71pCF29O+jEHmlvSHt4cmrVed2POTRs0tFQgRyQFigQxW
         DAG2zDK+kVDO9YK10WGrOKbVloeJ1QKLOqRV+X2nTLU4Ai5CtINP1lRhTJEyUTYe3sq4
         uuvL6pBz3TDHxvBl6z5Mv+5ePcC2tYoZYqj1PldddZIhRPnTmRt+f46W7uGEmKPoP0Jk
         ryiA==
X-Forwarded-Encrypted: i=1; AJvYcCVtcSU8ixe9bk15/WA0s3CSOeJ8XYkwYNHxLcwY+AMpYmUB9bvvvcEX+VvRHDYG0biqbCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxPs1oo2WZgAOhL56M4KVx2avxLYC04wopHqnWq7zS4M5Df3oc
	rk6CfbFNYQJdl51PhEvoFM/TwcZ87sLGqZLVxdA1E6bGllHf73rlneKhkdD0uIdl8sJElJo49Zk
	8kQi7QtYcfAq6Vza5XaX9BP/ihUFDcg==
X-Google-Smtp-Source: AGHT+IFhxyxb7RWzZsEOyCWJM6fg8SMdYbMj4swvWDDm4LLjjI1ANozZg4fFtwenjfCEkgtRvrLx0VyhxBPLi1hI6Yk=
X-Received: by 2002:a05:6870:6b0b:b0:261:f8e:a37a with SMTP id
 586e51a60fabf-277d03a8867mr10173730fac.14.1725354017168; Tue, 03 Sep 2024
 02:00:17 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Sep 2024 02:00:16 -0700
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <9a63abfe3b812a32d69c7393004bea4f88971559.1725280479.git.ps@pks.im>
References: <cover.1725280479.git.ps@pks.im> <9a63abfe3b812a32d69c7393004bea4f88971559.1725280479.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 3 Sep 2024 02:00:16 -0700
Message-ID: <CAOLa=ZRGvU4LvX9kjvF3dJCTvKR6CC1CwPTp515c3Wt5M8a5vA@mail.gmail.com>
Subject: Re: [PATCH 2/2] refs/files: use heuristic to decide whether to repack
 with `--auto`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000004e43a40621334983"

--0000000000004e43a40621334983
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The `--auto` flag for git-pack-refs(1) allows the ref backend to decide
> whether or not a repack is in order. This switch has been introduced
> mostly with the "reftable" backend in mind, which already knows to
> auto-compact its tables during normal operations. When the flag is set,
> then it will use the same auto-compaction mechanism and thus end up
> doing nothing in most cases.
>
> The "files" backend does not have any such heuristic yet and instead

Nit: s/instead/will instead/

> packs any loose references unconditionally. So we rewrite the complete
> "packed-refs" file even if there's only a single loose reference to be
> packed.
>
> Even worse, starting with 9f6714ab3e (builtin/gc: pack refs when using
> `git maintenance run --auto`, 2024-03-25), `git pack-refs --auto` is
> unconditionally executed via our auto maintenance, so we end up repacking
> references every single time auto maintenance kicks in. And while that
> commit already mentioned that the "files" backend unconditionally packs
> refs now, the author obviously didn't quite think about the consequences
> thereof. So while the idea was sound, we really should have added a
> heuristic to the "files" backend before implementing it.
>
> Introduce a heuristic that decides whether or not it is worth to pack
> loose references. The important factors to decide here are the number of
> loose references in comparison to the overall size of the "packed-refs"
> file. The bigger the "packed-refs" file, the longer it takes to rewrite
> it and thus we scale up the limit of allowed loose references before we
> repack.
>
> As is the nature of heuristics, this mechansim isn't obviously
> "correct", but should rather be seen as a tradeoff between how much
> resources we spend packing refs and how inefficient the ref store
> becomes. For all I can say, we have successfully been using the exact
> same heuristic in Gitaly for several years by now.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs/files-backend.c          | 75 +++++++++++++++++++++++++++++++
>  refs/packed-backend.c         | 18 ++++++++
>  refs/packed-backend.h         |  7 +++
>  t/t0601-reffiles-pack-refs.sh | 85 ++++++++++++++++++++++++++++++-----
>  4 files changed, 175 insertions(+), 10 deletions(-)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 1cff65f6ae5..261e2b8570f 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1311,6 +1311,78 @@ static int should_pack_ref(struct files_ref_store *refs,
>  	return 0;
>  }
>
> +static size_t fastlog2(size_t sz)

Nit: We already `reftable/stack_test.c:fastlog2` and `bisect.c:log2i`. I
wonder if it would be nice to consolidate all of them. But I guess it's
okay, since the reftable code anyways is isolated from the rest of the
Git code.

> +{
> +	size_t l = 0;
> +	if (!sz)
> +		return 0;
> +	for (; sz; sz /= 2)
> +		l++;
> +	return l - 1;
> +}

[snip]

The rest of the patch looks great!

--0000000000004e43a40621334983
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b5b1f05fb5feec28_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1iVzBCOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1melZLQy80dmFtOW1jSGZxdUJkczdHTFpLR1pPNmdaMApOOG9GU1RVc1dq
NTR6eU9RcTJzNno0eFNZdUUzTGg0REFzN1NjYStyTjRHUnFtbS9YUWcwNTREaERTMlBRWjZlCllt
Rk9XbVJoWUgvNkptNjJkL1Y2NmFOS0pERGxZTUVzbUtFSjdjYWs2L0twUmEvSDlzRzh2eUhlQWVr
YmRqNm8KNm5HYi9MWDViemdEM3hXY1EwUUlBdHFoS0pCcC81SDdVYlJndi9IQ0NWS2c1Z1ZneVNT
MVRKWFByRlR6alhZZwpvUXI4bUZYcm54UTFKR1BkdC94WUFmVW5FMWJEREJhL2tsd3VULzhVc1A4
aHBKUFExWlhSWVlZdDVSK1FzSUhrCm1QL05uMkxtYXdFaUZYb0ZQMm9jTmMxKytPTG5xVWJkcGdU
dTRrY2hPanVjSHB4SXFsOWp0bFVjWWNjWUs5VEsKMTZmQitJWGFsekYvR3NXWklsakFEYS9kTmp0
UTcwdUpyWFgrOFR3VmxxMGxxS0tjbmNXNW5Gc3pJNVFGdUNWdwpUV3RwTzJ5RjdRck00N1VJVmdN
aHBBdGZyckFoYmlvcktGU2RvZEZwaEFmd0YzQ2h0bmZxb1lHRjJEUnlhMm9CCk9uL3k5VUJtSUpJ
cGVVUDdVSFk0RzVyUDdZQTE4c0UydVNXWmlzRT0KPUJIVVAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004e43a40621334983--
