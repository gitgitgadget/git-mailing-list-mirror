Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBB01922F0
	for <git@vger.kernel.org>; Mon, 17 Jun 2024 09:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615900; cv=none; b=N/AiFUnlfPZNqOmATW0u5cT1wvUWAkMfZ1sA7ioP962urI54w0ah289LBjlaJUqb75FzZ+r/5xUODFv7mFPtBp/RSVpJDwEuoKfEvtBk6gi+lgUfRpm6hoM9019uBmdsD0ozx5C2qUnaLPI10GU3MFd01ghbmdmr+nHpaI5B2HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615900; c=relaxed/simple;
	bh=LdEyFeGgENhEDRUNjUJa7+B7nrDXTBZcwVE3z9jwJGs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MwMuLCaNa2RGvTLTCNgrLu02mgsyD7Znwm+73WUlrpqe7Sp9410P5hSXN2lNhratzPZG6oysivxRS8/gfPD9pepUBdyf/17t7mFBgLm09rV1AxPQACG8iAducFJUvE44WhHEmEdNY+t5gkel8h4MoHZ2tfZGxUEtLP7wSbJE41I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8LgmVwp; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8LgmVwp"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-25837a78858so1905059fac.2
        for <git@vger.kernel.org>; Mon, 17 Jun 2024 02:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718615897; x=1719220697; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AYhs5UL8nD+Wt42DTYTdENE/NATtkrGNkNO6X5lNSuA=;
        b=F8LgmVwpt9Wt54/kyu1Ni2V2XhFiph/SQE/dbK6b5Dzs47dGhNqlLkiDi1eI1kiEWY
         HaExtSw0PWiyK4KSVzqgEA94u43+XNGB5vs0EuJ6lUC70mspu8B2iWDFoliFVWQpAziB
         gRdUSVuc+H52ahTVlv6JQx/tTkgPUXQmjSPgTcYz4S+G5pg647hquab6hS9LZSbrdEX6
         0lITko+Iq1iiHA83p1G/VBLlp0YtYNtePcXrBLM0eXEn6uay+/U6ZCu3fShx/TPNSmZm
         PAyHRyOaROOcXnixahpsBk0WzrQBcmx7FYoLQHGtNLShpr11MeC9Grk/t9VtnwXNM1gD
         6F8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718615897; x=1719220697;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AYhs5UL8nD+Wt42DTYTdENE/NATtkrGNkNO6X5lNSuA=;
        b=Z3g7ha60017mV6LCcnCWIyp6HDGw/suiGMxBvFG0WUEuMDGiJqlrXK0ZyUU+RX8C/y
         fk6O8Q0iHPsqsJss82+6w17rP+ItglT5XUYhUlJSzQT5IS0I7VwIgNbxETz0GFQrDVU5
         egTPlHOOnNjRsN10guN7PYPhh2TQRvZ3NFJho9XnjvSBSub9sPkMaZYttwArvjYg2L0p
         F3wNyiAgnK4Rnln3yC8IT/8bvV1PVAGyAVogZejEshGImg9SGOEXzpredVz3Ui7QLAHb
         NDkHw58zvla3Qrl35jsE4LHf5Wc5i/EuKYCAQRqi/bdMDEbDBFG90KLJFcYy/qeaHW+Z
         bDXA==
X-Forwarded-Encrypted: i=1; AJvYcCUQfhhIqmURNHGLZ2aR7S5sSYFPfocfFDHpmImLIkfKQ54/Vljwn14itMhXkTCz8ZecMTwgVF01kBrx+SIW4ntmkQjk
X-Gm-Message-State: AOJu0YzvNHVl+CHoh7Sl4PhUUG5f5KikgRKlSq1pgiAkRDHALjjSHWLr
	6tWWQNXyOb8zcLkconvnqUXXPRmM7NkJ9if5T9JR1JfeU5Lcw8HfaE5lz9YRz+FdgNEAMTFWTEM
	cuzLyGvi50aFEEUnMJUQHI3kI25E=
X-Google-Smtp-Source: AGHT+IHFee+i7MzbbXa2mwORoJKu7LaMzQLkoeQxamvQGDYEE00YNefhngcrzQa1xLefUZJmtWXUYsN0+a3pLlt0Ff0=
X-Received: by 2002:a05:6871:890:b0:24f:f282:2411 with SMTP id
 586e51a60fabf-25842b0aaf4mr10128985fac.47.1718615897400; Mon, 17 Jun 2024
 02:18:17 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 17 Jun 2024 02:18:16 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <91eb94bc0b91c8d1bda7f8fd776d94113acf8cd3.1718347699.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im> <cover.1718347699.git.ps@pks.im> <91eb94bc0b91c8d1bda7f8fd776d94113acf8cd3.1718347699.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 17 Jun 2024 02:18:16 -0700
Message-ID: <CAOLa=ZS491t7n_b6kNoOg=9ALSe9PWO79DxNnfxa4RFgGtdYAw@mail.gmail.com>
Subject: Re: [PATCH v3 05/20] hash: convert `oidcmp()` and `oideq()` to
 compare whole hash
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Phillip Wood <phillip.wood123@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="00000000000011fd71061b1272ca"

--00000000000011fd71061b1272ca
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> With the preceding commit, the hash array of object IDs is now fully
> zero-padded even when the hash algorithm's output is smaller than the
> array length. With that, we can now adapt both `oidcmp()` and `oideq()`
> to unconditionally memcmp(3P) the whole array instead of depending on
> the hash size.
>
> While it may feel inefficient to compare unused bytes for e.g. SHA-1, in
> practice the compiler should now be able to produce code that is better
> optimized both because we have no branch anymore, but also because the
> size to compare is now known at compile time. Goldbolt spits out the
> following assembly on an x86_64 platform with GCC 14.1 for the old and
> new implementations of `oidcmp()`:
>
>     oidcmp_old:
>             movsx   rax, DWORD PTR [rdi+32]
>             test    eax, eax
>             jne     .L2
>             mov     rax, QWORD PTR the_repository[rip]
>             cmp     QWORD PTR [rax+16], 32
>             je      .L6
>     .L4:
>             mov     edx, 20
>             jmp     memcmp
>     .L2:
>             lea     rdx, [rax+rax*2]
>             lea     rax, [rax+rdx*4]
>             lea     rax, hash_algos[0+rax*8]
>             cmp     QWORD PTR [rax+16], 32
>             jne     .L4
>     .L6:
>             mov     edx, 32
>             jmp     memcmp
>
>     oidcmp_new:
>             mov     edx, 32
>             jmp     memcmp
>
> The new implementation gets ridi of all the branches and effectively

s/ridi/rid

> only ends setting up `edx` for `memcmp()` and then calling it.
>
> And for `oideq()`:
>
>     oideq_old:
>             movsx   rcx, DWORD PTR [rdi+32]
>             mov     rax, rdi
>             mov     rdx, rsi
>             test    ecx, ecx
>             jne     .L2
>             mov     rcx, QWORD PTR the_repository[rip]
>             cmp     QWORD PTR [rcx+16], 32
>             mov     rcx, QWORD PTR [rax]
>             je      .L12
>     .L4:
>             mov     rsi, QWORD PTR [rax+8]
>             xor     rcx, QWORD PTR [rdx]
>             xor     rsi, QWORD PTR [rdx+8]
>             or      rcx, rsi
>             je      .L13
>     .L8:
>             mov     eax, 1
>             test    eax, eax
>             sete    al
>             movzx   eax, al
>             ret
>     .L2:
>             lea     rsi, [rcx+rcx*2]
>             lea     rcx, [rcx+rsi*4]
>             lea     rcx, hash_algos[0+rcx*8]
>             cmp     QWORD PTR [rcx+16], 32
>             mov     rcx, QWORD PTR [rax]
>             jne     .L4
>     .L12:
>             mov     rsi, QWORD PTR [rax+8]
>             xor     rcx, QWORD PTR [rdx]
>             xor     rsi, QWORD PTR [rdx+8]
>             or      rcx, rsi
>             jne     .L8
>             mov     rcx, QWORD PTR [rax+16]
>             mov     rax, QWORD PTR [rax+24]
>             xor     rcx, QWORD PTR [rdx+16]
>             xor     rax, QWORD PTR [rdx+24]
>             or      rcx, rax
>             jne     .L8
>             xor     eax, eax
>     .L14:
>             test    eax, eax
>             sete    al
>             movzx   eax, al
>             ret
>     .L13:
>             mov     edi, DWORD PTR [rdx+16]
>             cmp     DWORD PTR [rax+16], edi
>             jne     .L8
>             xor     eax, eax
>             jmp     .L14
>
>     oideq_new:
>             mov     rax, QWORD PTR [rdi]
>             mov     rdx, QWORD PTR [rdi+8]
>             xor     rax, QWORD PTR [rsi]
>             xor     rdx, QWORD PTR [rsi+8]
>             or      rax, rdx
>             je      .L5
>     .L2:
>             mov     eax, 1
>             xor     eax, 1
>             ret
>     .L5:
>             mov     rax, QWORD PTR [rdi+16]
>             mov     rdx, QWORD PTR [rdi+24]
>             xor     rax, QWORD PTR [rsi+16]
>             xor     rdx, QWORD PTR [rsi+24]
>             or      rax, rdx
>             jne     .L2
>             xor     eax, eax
>             xor     eax, 1
>             ret
>
> Interestingly, the compiler decides to split the comparisons into two so
> that it first compares the lower half of the object ID for equality and
> then the upper half. If the first check shows a difference, then we
> wouldn't even end up comparing the second half.
>
> In both cases, the new generated code is significantly shorter and has
> way less branches. While I didn't benchmark the change, I'd be surprised
> if the new code was slower.
>

This was nice to read, thanks for adding the ASM here.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  hash-ll.h | 10 ++++++++++
>  hash.h    | 20 --------------------
>  2 files changed, 10 insertions(+), 20 deletions(-)
>
> diff --git a/hash-ll.h b/hash-ll.h
> index b72f84f4ae..b04fe12aef 100644
> --- a/hash-ll.h
> +++ b/hash-ll.h
> @@ -278,6 +278,16 @@ static inline void hashclr(unsigned char *hash, const struct git_hash_algo *algo
>  	memset(hash, 0, algop->rawsz);
>  }
>
> +static inline int oidcmp(const struct object_id *oid1, const struct object_id *oid2)
> +{
> +	return memcmp(oid1->hash, oid2->hash, GIT_MAX_RAWSZ);
> +}
> +
> +static inline int oideq(const struct object_id *oid1, const struct object_id *oid2)
> +{
> +	return !memcmp(oid1->hash, oid2->hash, GIT_MAX_RAWSZ);
> +}
> +
>  static inline void oidcpy(struct object_id *dst, const struct object_id *src)
>  {
>  	memcpy(dst->hash, src->hash, GIT_MAX_RAWSZ);
> diff --git a/hash.h b/hash.h
> index e43e3d8b5a..ddc2e5ca47 100644
> --- a/hash.h
> +++ b/hash.h
> @@ -6,26 +6,6 @@
>
>  #define the_hash_algo the_repository->hash_algo
>
> -static inline int oidcmp(const struct object_id *oid1, const struct object_id *oid2)
> -{
> -	const struct git_hash_algo *algop;
> -	if (!oid1->algo)
> -		algop = the_hash_algo;
> -	else
> -		algop = &hash_algos[oid1->algo];
> -	return hashcmp(oid1->hash, oid2->hash, algop);
> -}
> -
> -static inline int oideq(const struct object_id *oid1, const struct object_id *oid2)
> -{
> -	const struct git_hash_algo *algop;
> -	if (!oid1->algo)
> -		algop = the_hash_algo;
> -	else
> -		algop = &hash_algos[oid1->algo];
> -	return hasheq(oid1->hash, oid2->hash, algop);
> -}
> -
>  static inline int is_null_oid(const struct object_id *oid)
>  {
>  	return oideq(oid, null_oid());
> --
> 2.45.2.457.g8d94cfb545.dirty

--00000000000011fd71061b1272ca
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e14d22219f20bb4a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1adi8xWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meGV6Qy85NFRzN01kVS9FZHpCMlZleUxibVJDOG5xaApvQUNtaEhDenUw
VXB2Ti9uOHc4M29EOFI5b0pqVjJOSHBnbzJkQ1hhdjNiYzI1Qi9VK0gzY2UwM1F5cERsd0JaCm1U
Yk9RcnR1RW9YbFArNVV3ZFZvbmFVbG1tKzMvWm5jMEVkdVdYUVFFTTNUT3M4eUQ5QlRrU2pzUUZC
TnlHenoKTW9EMEd1OGE0TEkvOXlQckhrVHZzeVJsb0cvTlAzN0dOZG1hS2tCRis0aVlNWE9wdllk
dTdQa0hETDN2dS85YwpHQTlUV0w3TFp4OU9teDFSbFBHbEFIK2hFdmZmZnE0MnZ4WVpjTDMwOURG
bk5USSsrejJHOXE1djJBdFQrTHNnCmZwRWJYVnM1UEhRUUlFVWltRERGYTU1RDJpdUtyTGwyckhq
RGN2K1JEdC8xWVEya0dmaVZCR1FuNEFsRXU3OHIKNUF3bXhpY0YvdDJVTTlld3hYYkt5TVE1d0Q5
V25WR3lqLzlKUU81VVJtdURvMTI1NHBmTERTVmlBNVJoMGx2NAo5azNCNk02czMxUkhIcmJPR2px
bnoxT2RucUtCNFEyUlR6dDdEK2NueGhINnVBc2FCeWMrVTF1andPdGc5Wk8yCkVJcEEvSXlRMXNW
dnVMRFBBQ2lVRmhLNHhaaW1xcFQ5WXp5OGdndz0KPTdxUkwKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000011fd71061b1272ca--
