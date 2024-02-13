Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7191E501
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 17:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846426; cv=none; b=F11FKQxzsSK628sRhad8l6gbgXXFybEX1qfhWSXFQiQCJMmCI3t+3k4TFvELMVqQ44KKQzVyU78PWCSVt6TSXuvUnFj6r/cAnwxrVSg1nYABsUwiKdiwoOexSIdugDbtVbl9M0ZY7zbSWBKo73XHxEZciE/R5oj42+BvbvQygmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846426; c=relaxed/simple;
	bh=iQn54aaFVF8oAcaGpOpdgTZix129CTQXhlY+u0mIfPk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sB/7Txxd44BVGzPWHmV+k5inTggZUM4F1MbJPik6Q8+wZ+4+FkI9vy93OLbDpPg5qsh9t3xvw5owiP7qtJjIT3JTzjnd4FKniSrtVmVh7qTsUFTdmTQJJ/8HpJyNBqmCouiLDzZURjal4s0tooOzk/xNCsmN+JqHTCHFgiNjBMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WIncUVD6; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WIncUVD6"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6e0cceb6bd4so1221095b3a.1
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 09:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707846424; x=1708451224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=leHhGhFVtqhUtQi4yxb0IVZKTZl/DtAy/ejTaCdutUo=;
        b=WIncUVD60zqeGbGTfNm9rpBBJhXSl2qkL7gxbSP6vztu1fyZhLnfGGtALQM+MHedhq
         8boBSaN7vGL2fBmIozQlTcge9ghIgRmngG5X5k0hzL0Py5psfgc7TjAsVpyzb6WGmtBd
         GF27f+lmjBT89qet5zNkbJEkcKbdr7VfK1sPMxfOI/Ed1xLDAaFHrVV+sAYylhQHvAZE
         WpFISmPh2C+bCJ40VaBtwOCpNMsbtShHlJwiK30cruHjMXVut1Kt/quARbPB/WYjAeIx
         866Q8gB7X0ksAoAmkXf/vbRR9UsxoVn78BHnrR+D+MVy0l/2LMAYn0EisYlKsKqtFsoi
         hVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707846424; x=1708451224;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=leHhGhFVtqhUtQi4yxb0IVZKTZl/DtAy/ejTaCdutUo=;
        b=IyIbqlRicOe92itv9fQgKJeyk59L8EpYtxFLoaCQb8Izq6C+07HAxXOqu7iqvS2oJK
         UQn+dM1tXvGj//U5Ra9UnF6ZdYCdDnCOxQeK+LhRl+KJVFq6W7bje2aBvY04UYNP9mL8
         4dREtcMNBSMmK0QqcA6tPAkHeDZvzeGxcRn3NG2j9zptSDMXXQEmdYIj2zA1TpZFwLuF
         VdJW9Zum9tbWHcIgASWMRhL6unVHegc4Qkhkfzs1KpLs+bXm13P6/sbkol0yQA2Y66Iz
         IOLVK4SCidx6F3G5uuKvysGTDpMlMjNsRuce9ud5rOtpvZkpmq840eYZ/xA0pz4SvT3t
         jXUA==
X-Gm-Message-State: AOJu0Yw834k53/RvDFZniw0feLh9a5g9G02VNMrWJJwTg94t0EEotkJU
	o8/66bRajzKy1F2utKbtm7LN4oE55ZE/2OArDpvXSFgKevl9joxwhmWqYmVZ6IebnHP6q7gy93d
	Xpg==
X-Google-Smtp-Source: AGHT+IEL1TtE8Hm2CsEdl6+BOHBYUanxfNoHkKfB5nWfnYgkwEOR3OUipez73EurGAb0ltWv8vIAN47aAjA=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6a00:9394:b0:6e0:f65c:aa2f with SMTP id
 ka20-20020a056a00939400b006e0f65caa2fmr247152pfb.6.1707846424278; Tue, 13 Feb
 2024 09:47:04 -0800 (PST)
Date: Tue, 13 Feb 2024 09:47:02 -0800
In-Reply-To: <CAP8UFD3ZRfrG4s5jox55dYMRF7UT3uYMkyMraEGWRJ2HqBEYZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
 <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com> <38f4b4c4135dfebc06c2b1d5c56854af4b07fedc.1707196348.git.gitgitgadget@gmail.com>
 <CAP8UFD3ZRfrG4s5jox55dYMRF7UT3uYMkyMraEGWRJ2HqBEYZA@mail.gmail.com>
Message-ID: <owlyfrxwb6jt.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v4 21/28] trailer: spread usage of "trailer_block" language
From: Linus Arver <linusa@google.com>
To: Christian Couder <christian.couder@gmail.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>, 
	Josh Steadmon <steadmon@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Tue, Feb 6, 2024 at 6:12=E2=80=AFAM Linus Arver via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Linus Arver <linusa@google.com>
>>
>> Deprecate the "trailer_info" struct name and replace it with
>> "trailer_block". The main reason is to help readability, because
>> "trailer_info" on the surface sounds like it's about a single trailer
>> when in reality it is a collection of contiguous lines, at least 25% of
>> which are trailers.
>>
>> Signed-off-by: Linus Arver <linusa@google.com>
>> ---
>>  builtin/interpret-trailers.c | 25 +++++-----
>>  trailer.c                    | 97 ++++++++++++++++++------------------
>>  trailer.h                    | 18 +++----
>>  3 files changed, 71 insertions(+), 69 deletions(-)
>>
>> diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
>> index 6bf8cec005a..f76841c5280 100644
>> --- a/builtin/interpret-trailers.c
>> +++ b/builtin/interpret-trailers.c
>> @@ -140,8 +140,8 @@ static void interpret_trailers(const struct process_=
trailer_options *opts,
>>  {
>>         LIST_HEAD(head);
>>         struct strbuf sb =3D STRBUF_INIT;
>> -       struct strbuf trailer_block =3D STRBUF_INIT;
>> -       struct trailer_info *info;
>> +       struct strbuf tb =3D STRBUF_INIT;
>> +       struct trailer_block *trailer_block;
>
> I understand that using 'trailer_block' for a 'struct trailer_block *'
> makes sense and I like the idea behind this patch, but it's
> unfortunate that 'struct strbuf trailer_block' becomes 'struct strbuf
> tb'.

I confess I did not like the name "tb" either. It does have "symmetry in
naming with 'sb' above" going for it, but that symmetry is only on the
surface because the "b" in "sb" stands for "buf" (buffer),
not "block" as is the case for "tb".

Let me try to clean up the naming scheme a bit around here.

> Also the name change for 'struct strbuf trailer_block' could be
> in a separate patch.

Will do, thanks.
