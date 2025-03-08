Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859261D0E2B
	for <git@vger.kernel.org>; Sat,  8 Mar 2025 16:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741450289; cv=none; b=F9jxQZzPckPDWZOyvC+s/zJnR3mUaksgHtzut1ptQCZ1NyJQNXqvMfcoR1HMqMHp3g3cg6nG0A98CbHemqJteciOi4S026BmS6nwqkNdI0iSqvfMJNY5ZZr31zPw/0cifusObnTn9oQTFRY14rjpldV5J+LucC7mXBtSxnkS1yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741450289; c=relaxed/simple;
	bh=rt7IrtOBrgkzAvFtQks8zCWa52vxpsSQyLWnBdrNPrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L7aS1B+gHeSWmJ6zcYSA05OKVH5sBbY9tyWJHjRCOfhsJ5kPYYFp5sHpYPFnz57gbGCtg0iHWZ5Knsx14L3kj9rkOTOOZAdqcIRmQUE3Z6IANU9VAbuThEJJl66t+3wUSA4Hb/EcXZ7HhRXKGJkh6zcsQWu1fjvlmABL4R9IXjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSI4WDuU; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSI4WDuU"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d4502ca096so461115ab.0
        for <git@vger.kernel.org>; Sat, 08 Mar 2025 08:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741450286; x=1742055086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTooFyOKn3dz078T14we/9qL46FbOKYptHges5FKGBs=;
        b=LSI4WDuUVM74nudwOKC3OEo5vx3vc4OwCUwkjwDs/1ve+CJ57H62kojNGH3YYA5ETe
         qpGDaJ6EkrzTdeErZoyqOzM1GzDD7zd8g0q39Nw9I+pTS1bmHjRhDugTPgPuBitliVPI
         3MV/7l3p5OX3YXFbki+pET+IQm0M3QUxiVo8p4OCzDnidOkhadJt94gBiaq3I5Z1JEnr
         m8UhdNOMXWhBCkv29KJuP9m9WxRNxLxGh5s3GNNxLYaZsH5/lA6yDQbyDah3JBaFfB57
         0d3KZ4FM2De3tabpztZ5HFgVwkGaWL7peMLBS8sGuDBdHPzDzzSr6peKQcLMbiSm1Gf4
         aw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741450286; x=1742055086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTooFyOKn3dz078T14we/9qL46FbOKYptHges5FKGBs=;
        b=C1G/QMZTdo/ZcXGcc6YsFDFeOA9Mf8zri9hkTMuVccdc1ipVG9wCj1WL2iLYFlmwPM
         ZF2ftHLdX2Did6znX5VQNe1z10C0Omz3d5D+BDkeMFAjQFZ509j8/mpKVGFzey6CnbRG
         fNDwKJqQbq2YuvDTAz9sSZ+OIKbKqFNniAF5gg07BhMIqjrY7s0kmiD3h7842jhpRSBR
         ZoGgFc1jwX5UurIUf03DXHwCFQzcKHj0+qQuzc/HDlO402BEMlWBFUin1FksvRZQDbGU
         re4SiuM51bv61bTY9ifHKhD88+3bEhEmEjwmsXCXsRbGGsNStZpk1KmtU4enHjbB+7IR
         yIJg==
X-Gm-Message-State: AOJu0YwSDBThuAREiJYjPNuksQo1knNm0IumjQyUlMpP2dqLIlJhEnL/
	Sre2WFwqEn8PiK7J8K5Rq0NidRyasOJMPQPu/MraeX/KB5oVG3qWaGZniTeC1vld3lmmC41fBYa
	pqp3PXXfYfwA1sCsutFZC38QZwhX+QA==
X-Gm-Gg: ASbGncu2M+QsIYGaGUE0wXq0bdWz/nZTqZRgu+g8KHQZTlTXGeSgL3njegbRZySjF7F
	PsZuqoE5zfN8nAC5nDRXooJzHtE9NWdZ8DXEj8BkBVg3RLyxJoaS+/ywu5mSZnUFpjsCk6Qs2ri
	6nkXPIp1Bqh06o13emY7xevkn98CY93aOaW1JJV1AV3f5hoY4TRcV2MscwEqPEGmeLXqhZWg==
X-Google-Smtp-Source: AGHT+IFL2n240vGlz+1+nRmP6krrU5M/hsoCcurwSiUbNZqVGFgoZwr8Y1x7SWAm05ecUcaNP0WsH9WTlHtUKbR6EK0=
X-Received: by 2002:a05:6e02:240a:b0:3d0:10ec:cc36 with SMTP id
 e9e14a558f8ab-3d441990a54mr75516655ab.11.1741450286524; Sat, 08 Mar 2025
 08:11:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
 <20250307-b4-pks-objects-without-the-repository-v3-0-7bccf408731e@pks.im>
In-Reply-To: <20250307-b4-pks-objects-without-the-repository-v3-0-7bccf408731e@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 8 Mar 2025 08:11:15 -0800
X-Gm-Features: AQ5f1JoF2xe7tMMhLCYu9HV6pm4KE9TbZUaNT0acYyJPoj5ag78E_usHp-JeuVQ
Message-ID: <CABPp-BEMy2w5O=azrvjXEcBb15uRXcTrFNPyy5hTVHgs_p4AKQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] Stop depending on `the_repository` in
 object-related subsystems
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Justin Tobler <jltobler@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 6:19=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> Hi,
>
> this patch series is another step to remove our dependency on the global
> `the_repository` variable. The series focusses on subsystems related to
> objects.
>
> The intent here is to work towards libification of the whole subsystem
> so that we can start splitting out something like an object "backend".
> It is thus part of a set of refactorings aimed at allowing pluggable
> object databases eventually. I'm not discussing that bigger effort yet,
> mostly because it's still taking shape. So these patch series contains
> things that make sense standalone, even if pluggable ODBs never get to
> be a thing.

Sounds like a good goal; and the series is helpful regardless of
whether we get there.

> Note that this patch series stop short of dropping `the_repository` in
> "object-file.c". This is a bigger undertaking, so I'm pushing that into
> the next patch series.
>
> The series is built on top of cb0ae672aea (A bit more post -rc0,
> 2025-02-27) with ps/path-sans-the-repository at 028f618658e (path:
> adjust last remaining users of `the_repository`, 2025-02-07) merged into
> it.
>
> Changes in v2:
>   - Point out why t1050 had to be adapted.
>   - Drop the rename of `get_max_object_index()` and
>     `get_indexed_object()`.
>   - Fix a couple of commit message typos.
>   - Link to v1: https://lore.kernel.org/r/20250303-b4-pks-objects-without=
-the-repository-v1-0-c5dd43f2476e@pks.im
>
> Changes in v3:
>   - Fix a semantic conflict with an in-flight patch series.
>   - Link to v2: https://lore.kernel.org/r/20250306-b4-pks-objects-without=
-the-repository-v2-0-f3465327be69@pks.im
>
> Thanks!
>
> Patrick
>
> ---
> Patrick Steinhardt (12):
>       csum-file: stop depending on `the_repository`
>       object: stop depending on `the_repository`
>       pack-write: stop depending on `the_repository` and `the_hash_algo`
>       environment: move access to "core.bigFileThreshold" into repo setti=
ngs
>       pack-check: stop depending on `the_repository`
>       pack-revindex: stop depending on `the_repository`
>       pack-bitmap-write: stop depending on `the_repository`
>       object-file-convert: stop depending on `the_repository`
>       delta-islands: stop depending on `the_repository`
>       object-file: split out logic regarding hash algorithms
>       hash: fix "-Wsign-compare" warnings
>       hash: stop depending on `the_repository` in `null_oid()`

I read through the series.  I had a couple small comments on patch 12.
Overall, I really like how you've divided things up; it makes it easy
for review, especially combined with --color-diff.
