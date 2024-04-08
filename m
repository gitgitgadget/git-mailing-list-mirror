Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E443C2F
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 05:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712555119; cv=none; b=nowztwYrewmhSip+SK0ATKzUyXCyy7HMMJdgu1o1cgA9P4BrbjsTP7cyPUC5JnZ8SCybKB6P+j4301OD2v4bxQoKplPvVa5JYDlExXM6qr+gc1DEb4/ZoLm5u2L7qDCKTpW5ESPZL5U0UJKzJWIgGsOh1Y9/VQ31wl4U73lFvDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712555119; c=relaxed/simple;
	bh=0+L75spDFAtmEwtz29vdM3xHNAX6oHhr4rfJxP1a/B0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K0NHw+a23sWCgOulodSHFYtyen1qxvcnPWKIDJRlRWD1wIwyU0qlgqnY7DbtLlwPiCyd56ORDFSTWjuGhHC6rcKQ5PL018H6YIGk4HNsvtcBDMBMEAz0fCGiHZ3ok9whvYcCTuKk5oaEltH4f3PJX/0DAD+IxTMxNynkNTLsVF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DYBQR6Rh; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DYBQR6Rh"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a51d05c50b2so92948366b.0
        for <git@vger.kernel.org>; Sun, 07 Apr 2024 22:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712555115; x=1713159915; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GgtkMel8lTa75UoNurEppHvdIPB2weSOLB86I2g8KUw=;
        b=DYBQR6RhPcsMZqxZVmH2f2JMCgD5YAAowGwpFfTFHnaGZ8yDomuCZ+RQKlVMb+8niR
         UF/R3Rz1xnzAoR+mCyOxUmCPBRNi6Wu32E+5bm36j/eFWK43AE7BX1dtlg7diMpM+YMR
         JlWFi7xj3q8+kdo3JiB7YEDCeY0CeP+bGzoWZ+CUgYiMVeN6/v0kZZL3YyFOV4ZXtQ2n
         TKFP5ctWWFQudlvgS2aTPXOO4XnMac1uI/QAAdBtD7j3VdcjJVAD0Zqqh8jMx+bq0Kuz
         eOIWzo91bDlSRKXZhzGhCBRBckd22S/dJKjhz1a7IJJ90YWt664xJxkqZqsCxkGK2+bD
         7+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712555115; x=1713159915;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GgtkMel8lTa75UoNurEppHvdIPB2weSOLB86I2g8KUw=;
        b=SiDSoRAbRy6U/QZEr7NLFbaaeqlXivttNLmhLe4fUchg7CeuM5a1MRVdYGlhFQbodS
         8qG5ykbJ9TdZQZlAY6EGre6An6wz1nsG6vJmhKg8tO6PoGdVb4CQi8ddpRcVAr8CHUA4
         CRSRHI6L1JdTuWTQN00eK49KRHs16SgNTC8oTl2ZHGWOIsoyCeIf0kZaBaSj748yNmWU
         FspodUOPi9QoN1IeHIKD7Lzfbsk0/hCcfIgX11lEbr6TS3ZwvsjXeuJEPkXrez5xXnuc
         cK5xhSM/PimXUHLvh8oQO5qR2Y3s8FxzHUWkM46elPjJiMCsYbrt87fn1sSns6cVmsA9
         4EdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXS0VuyixVeEGL1me4o/Ie0BXqq7wKXzfkbFdSW3KZeJnGgaaLqPa2xNGbU8JX/RM4aR8LJStL+OJKq8cdfvIdiN+XU
X-Gm-Message-State: AOJu0YyPLCbnBKHXLAJtQ+Bz/KcOW86pHC9yvIiUzZn+V/sON7tySXp3
	7tbhf0l/i9XcZgsGZqj1XnIRZl28UOdxP2+m+nV809zL+PFv8UrUpKLgKVq9NDO9akkt9ijgCfK
	b1t9y+WcsHsEQh9mcUTXyJqFJECWyNESiURJ6dg==
X-Google-Smtp-Source: AGHT+IE1717JJHIppDDGNzuyLjeinXndDM2XM79ab3PLQ5nmPJPhMGQ5pHAPswUrGZG2x8UMzZdF225uc4k3UQjiTNc=
X-Received: by 2002:a17:907:60d0:b0:a51:d49f:b6e3 with SMTP id
 hv16-20020a17090760d000b00a51d49fb6e3mr1334148ejc.54.1712555115070; Sun, 07
 Apr 2024 22:45:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1711.git.1712495507815.gitgitgadget@gmail.com>
 <ZhKqvA1NQwrVfnfE@nand.local> <ZhLfqU9VNUW+2mmV@nand.local>
In-Reply-To: <ZhLfqU9VNUW+2mmV@nand.local>
From: =?UTF-8?B?6ZGr6YKi?= <xingxin.xx@bytedance.com>
Date: Mon, 8 Apr 2024 13:45:03 +0800
Message-ID: <CAER=4vi71KWKJUJF4Qg8eMax8D6xr4+pxTuE1_Pw6-yv40EOiw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] midx: disable replace objects
To: Taylor Blau <me@ttaylorr.com>
Cc: blanet via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	blanet <bupt_xingxin@163.com>
Content-Type: text/plain; charset="UTF-8"

> I had a some more time to look into this, and I think that your original
> fix is correct.
>
> The issue is, as you suggest, due to the following (from your original
> patch):
>
> > After some investigation we found that all repositories experiencing
> > failures contain replace references, which seem to be improperly
> > acknowledged by the MIDX bitmap generation logic.
>
> Indeed, the pack-bitmap-write machinery does not itself call
> disable_replace_refs(). So when it generates a reachability bitmap, it
> is doing so with the replace refs in mind. You can see that this is
> indeed the cause of the problem by looking at the output of an
> instrumented version of Git that indicates what bits are being set
> during the bitmap generation phase.
>
> With replace refs (incorrectly) enabled, we get:
>
>     [2, 4, 6, 8, 13, 3, 6, 7, 3, 4, 6, 8]
>
> and doing the same after calling disable_replace_refs(), we instead get:
>
>     [2, 5, 6, 13, 3, 6, 7, 3, 4, 6, 8]
>
> Single pack bitmaps are unaffected by this issue because we generate
> them from within pack-objects, which does call disable_replace_refs().

Thank you for the comprehensive investigation. I have quoted them in the
commit message to provide a clearer explanation of the patch.

> In addition to the test fixes I suggested earlier, I would instead demonstrate
> the bug by showing a clone (which fails with MIDXs, but doesn't without
> MIDXs) like so:
>
> --- 8< ---
> diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
> index 5e4cdef6a8..1fb3b0f9d7 100755
> --- a/t/t5326-multi-pack-bitmaps.sh
> +++ b/t/t5326-multi-pack-bitmaps.sh
> @@ -442,19 +442,16 @@ test_expect_success 'do not follow replace objects for MIDX bitmap' '
>                 cd repo &&
>
>                 test_commit A &&
> -               A=$(git rev-parse HEAD) &&
>                 test_commit B &&
> -               B=$(git rev-parse HEAD) &&
> -               git checkout --orphan=orphan $A &&
> +               git checkout --orphan=orphan A &&
>                 test_commit orphan &&
> -               C=$(git rev-parse HEAD) &&
> -               git rev-list --objects --no-object-names $B |sort >expected &&
>
> -               git replace $A $C &&
> -               git repack -ad &&
> -               git multi-pack-index write --bitmap &&
> -               git rev-list --objects --no-object-names --use-bitmap-index $B |sort >actual &&
> -               test_cmp expected actual
> +               git replace A HEAD &&
> +               git repack -ad --write-midx --write-bitmap-index &&
> +
> +               # generating reachability bitmaps with replace refs
> +               # enabled will result in broken clones
> +               git clone --no-local --bare . clone.git
>         )
>  '
> --- >8 ---
>
> With the change in your patch to call disable_replace_refs() in
> builtin/multi-pack-index.c, this test passes as expected. With that
> change compiled out, we instead get:
>
> [...]
> + git clone --no-local --bare . clone.git
> Cloning into bare repository 'clone.git'...
> remote: Enumerating objects: 8, done.
> remote: Total 8 (delta 0), reused 0 (delta 0), pack-reused 8 (from 1)
> Receiving objects: 100% (8/8), done.
> fatal: did not receive expected object da5497437fd67ca928333aab79c4b4b55036ea66
> fatal: fetch-pack: invalid index-pack output
> error: last command exited with $?=128
> not ok 352 - do not follow replace objects for MIDX bitmap
>
> as expected.
>

Applied! The test looks much clearer now, thanks!

Xing Xin
