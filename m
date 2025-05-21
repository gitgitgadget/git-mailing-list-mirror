Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25D6239585
	for <git@vger.kernel.org>; Wed, 21 May 2025 13:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747833273; cv=none; b=bZ3kMLayqQeDDCQ+v8aYRTI3mSjmkNIycQJfOflXXy3JlBjfUYunCmbJTFjzf4Szcm5bXfg8uZd5Ng/la5rtB6oLcMPt0i5N2Kv3YtR7QcB8YVlaFZIQq2YYwbi9+Kd7FqDcAlK/2XAGsz87HvF9MxVkbMc7CJZpbw4t3cut/3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747833273; c=relaxed/simple;
	bh=HsQX7Rl9Eh9N3RP34GWjDpD5IT/mN9T5P1hxzcQFLOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oGz4xMFfQegc9xt/OZ0eO2uvOzqxkoGCLWtLYsJoHctL/IJ4PsIa+x3bQbeeMAp9yZ440q9lgPQFNokhEgViCFhjbsybkJ3VLH1IaEkv8u4f9n+JIepQZysKmzF+3DBjrMbR+9uQBnpT67Rs1Afq7p8YHNEtrgfo5eQAdzUX2So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGgXkUCz; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGgXkUCz"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60236e3d093so1273203a12.3
        for <git@vger.kernel.org>; Wed, 21 May 2025 06:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747833270; x=1748438070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsxXG3IsOjFJNj/q+ke8BP4R4F7Jn7THSmzUHqTONM0=;
        b=VGgXkUCzAqvMLu2RKdnlZ8s1SqYggpm00CqT/iVSM+lYWB44A72ezjVMNugp5wInkv
         l1UlYzGGEazzH0nJaJZ57l6/qPphwf99tRVRwoj60wH0xxhMcCTTWbgq+QsWE0C8tvAE
         EgMM9ces4dySy3KphGxBT4CQecWyrGA5diiGO2AXfZfhy9RIdyaTVfi1ZrXoifwKcZ1f
         zq5GOl5a0Q1YPiAd5wn6cAdFmyXsu3qNrnR1TMkcU2acT0mTzQV9Bvtd2kRR2pANgBRj
         A412uYjcRGXEiaNR0x0HZZZPQ4vddLaqnP/xciC/UgURUOScNR68Td1IuJBPYgdPoGwc
         lDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747833270; x=1748438070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tsxXG3IsOjFJNj/q+ke8BP4R4F7Jn7THSmzUHqTONM0=;
        b=aoL8cZNbS7feTGUrlRtS2mdzob6reaWGuc0w/AbR5lIfhsmpndA30R3EB5o2xAAbQT
         tpxGvz+MItGN/2jEprgCyY4o93KG8wz7qaPhC0XZZsH6Hah31uiCNpYP9yy/RJ0kbTcb
         v+nQgl6vbQzKsCnbMCuQGnQQ90Mfd1c50SA7rJDe1I0qUhNzZUaGv/AOtUEHe++H7L6T
         M02h14m7t2I1z4EEz3EyDZ/h5vsuuxOnbYJkwVEZaNlck/cDet1+h7oz7sDaDBJYPXow
         qmdR3//HdZLGxXykfvUr2kJ2Zxm8NEngXnsCkIPMuLG07fmLe9s2aaC3bzvjzP7QjCGD
         fFRg==
X-Gm-Message-State: AOJu0YzluJg6n3RHBPOpgAP81AqmcScX1pzVQRUGSFntBenduuNss4zE
	G+WdxLKb5UbR/sIiqLJcyQThP8EcopK6lPOUf407ZaK4kn7K4S/Y8++KgsqJK0tcQxsEdLYiFnM
	LHwaPAM9RrKqIVL0nKa5MW/wVIzYCyJo=
X-Gm-Gg: ASbGncsOpN+W4wMiPM9FxEjpthI6oU4Of1KJbwpa1KUDAi+Y1krDLVqaju9po/TmEf2
	JiK2GLNxk8LZhOsWB1nnTw9t7Ru4Leh6y8S8lPY3tLAxbB5mCb2QglKMZ3k/u9GZZfuWbX7JM/E
	Zem1TM+vwNiA9SrZxsm3/t6v4Mm8MpeTIcT0UOgmTK9pwEn8YtzZoxX20tYqkBnlnJKmw=
X-Google-Smtp-Source: AGHT+IFLzmcLSpSGp6ofkP+QV8otrj+dgiGTNbLji0winiU/ztjayGejoQ+EL9azxDIVDLgjJgsogCYGSqy/O0/RdLg=
X-Received: by 2002:a17:907:3e05:b0:ad2:40ee:5e26 with SMTP id
 a640c23a62f3a-ad52d46a3a8mr1934500466b.4.1747833270047; Wed, 21 May 2025
 06:14:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747753388.git.phillip.wood@dunelm.org.uk> <29769df1c601c77031a27f3b3e5b571d5d7d043e.1747753388.git.phillip.wood@dunelm.org.uk>
In-Reply-To: <29769df1c601c77031a27f3b3e5b571d5d7d043e.1747753388.git.phillip.wood@dunelm.org.uk>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 21 May 2025 09:14:14 -0400
X-Gm-Features: AX0GCFvzHbHFcnVBVq0JASZ_9P2nsAfSQfxA4dOt05dAysYMd2IGCWvctihzzQY
Message-ID: <CALnO6CCAUjd=x2bJALyoPMBGeheQ=KMvc4MPx2TmNt1znxVosQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] midx docs: clarify tie breaking
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 11:15=E2=80=AFAM Phillip Wood <phillip.wood123@gmai=
l.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Clarify what happens when an object exists in more than one pack, but
> not in the preferred pack. If the user does not pass a preferred pack
> then the pack with the lowest mtime is chosen as the preferred pack. For
> objects that are not in the preferred pack the pack with the highest
> mtime is used. "git multi-pack-index repack" relies on this behavior. If
> ties were resolved in favor of the oldest pack as the current
> documentation suggests the multi-pack index would not reference any of
> the objects in the pack created by "git multi-pack-index repack".
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  Documentation/git-multi-pack-index.adoc | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-multi-pack-index.adoc b/Documentation/git-=
multi-pack-index.adoc
> index 631d5c7d15c..1f016b2f682 100644
> --- a/Documentation/git-multi-pack-index.adoc
> +++ b/Documentation/git-multi-pack-index.adoc
> @@ -40,8 +40,10 @@ write::
>         --preferred-pack=3D<pack>::
>                 Optionally specify the tie-breaking pack used when
>                 multiple packs contain the same object. `<pack>` must
> -               contain at least one object. If not given, ties are
> -               broken in favor of the pack with the lowest mtime.
> +               contain at least one object. If not given the pack with
> +               the lowest mtime is used as the preferred pack. Ties
> +               for objects that are not contained in the preferred
> +               are resolved in favor of the pack with the newest mtime.

I think Taylor's reword caught this already: "preferred [what] are
resolved =E2=80=A6"? (Probably "pack".)

>
>         --[no-]bitmap::
>                 Control whether or not a multi-pack bitmap is written.
> --
> 2.49.0.897.gfad3eb7d210
>
>


--=20
D. Ben Knoble
