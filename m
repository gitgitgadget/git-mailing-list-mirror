Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E151429A
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 06:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722579364; cv=none; b=uc9R6TWJ6AgfNA+i+z4T28KT6uP7gGOuQlZUlhrxTSCewxd9+Pwy+pM0hN4C1GYGzyt/2LMnG/i+igpDw0U0zBsvn8M08EkAcNKN2bs5Ey6jz4u89xlLWEvFYIOprDQ6OuibSS/dlMeZ0rJrR9eTjHqZpieVDjDet3QmuFWrPdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722579364; c=relaxed/simple;
	bh=Q5/3urCRIQKJLTZu4mmgDWBnExCxO72PYDP8qRk4n4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dyMSel++uBENYCekb3mPWuAacbGHZE90s28n+dgC6ULsJajwfc9Qd/Rw/4dn/QYVVFtYJTPdl5YgeD3bhtkG3iSQOm/1JFS/ndVIvt16Fa5u1vJGjQYmAw0BMyPphel7RRtU+3iGmosgqJTs+0VXHN9BXrXk2bfpEu/bEJhwdgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kzq+2e34; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kzq+2e34"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a611adso153253a12.1
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 23:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722579361; x=1723184161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5/3urCRIQKJLTZu4mmgDWBnExCxO72PYDP8qRk4n4M=;
        b=Kzq+2e34YPxDtSsCe7TxeWhwXXhkH5gRcL9GT9Y/8IYI2/Adzd06464CVrMl3BWxDi
         1OiDjD73+lh1WI2zaO3i8Wo7voU0w3ootXiFhnen/x0le3BLYj0Ju4US2sO+DIp/NXMM
         eby3g9Jo4T4OVvgffXSAwwkGPQlZFb4VZEwttdOdBecrAuvr+AwCMOY7oK7najxdwT3A
         6+lpG8/Nkr1HCyFTi4qHITlBB9thDN7fzCi2em/TQLPRAEy0oaGuQRjD5tf27hUcqEm4
         K/xRkQ/nFKXWHgAAZ3a26p/B6qZUWRNv5gpV76oFP+c5mW7hdZtVsakdi5K02e57cQW5
         nQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722579361; x=1723184161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5/3urCRIQKJLTZu4mmgDWBnExCxO72PYDP8qRk4n4M=;
        b=AvMynZrkgcYAX6vnev8sQqUHEisuqpQGoa9gF6HtxwYZlUfjR8G461KJgM0ICP27tf
         jP80alTuDCSEg492326EgdOxg2HwlNhxapfCrDd1QUZtpk9b0V0by9rnDOR75rsHw33E
         unZW9JXLDh6lHyfuxZsrY8h5r2E/Prq33JSE5ubzAsk8dOeyNDmyG8Najn9xZMaDwXQh
         Fip7v3c+E4d1hVhJsM51/UBvR2TT1B7OvfNFE9570JfUHIPMo5+MWlh1HPRmsOF92WAB
         hRXumGYQSvHkZoKf5CcWVyagpeBA5Pzqzs4Rmdh2YKdnXncRmRUvPD3J8sXCIQKwY/Wn
         W+KQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFckHKlqfBjtv/wF7JGsBVsJNvclk0Wh1WS3voTfGyGbE2mqhdGxRwLL5eTUyOOZJ1ocXkQXtVOWVILZwp+23nfKOe
X-Gm-Message-State: AOJu0YybVo1q1So8NZH1IwxRTbwzCUrJTaWIsdjltuIgkM6flW7nis5w
	3Hjw7nFYNjaCWuH9dAxrD3/fb8Kht86ZLKpoSzQ0EyARMi9phWQxhdj5kevQDz2EX11wZIJ+zl8
	X/ptpSN4SycK7fvcx3ZRpx1Fwcwwql/gfzGt7
X-Google-Smtp-Source: AGHT+IGq6sc8I1AFnK+sgRUXp5kEOB24TGETiVgQ1qTdmnLZGSt5tfWAq9A0xxHl/4j2VgGOV7QIr13Uwu9JKwGMIo8=
X-Received: by 2002:a17:907:7f21:b0:a7a:9144:e254 with SMTP id
 a640c23a62f3a-a7dc4d94affmr180044966b.10.1722579360983; Thu, 01 Aug 2024
 23:16:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1756.git.git.1722571853.gitgitgadget@gmail.com>
 <4dbd0bec40a0f9fd715e07a56bc6f12c4b29a83c.1722571853.git.gitgitgadget@gmail.com>
 <ZqxqtIJi4-xBL9Sj@tanuki>
In-Reply-To: <ZqxqtIJi4-xBL9Sj@tanuki>
From: Kyle Lippincott <spectral@google.com>
Date: Thu, 1 Aug 2024 23:15:44 -0700
Message-ID: <CAO_smViSG27KrtE7hgq1GAzUYSoKFgrQymRYg-aKJqm4UW9DUg@mail.gmail.com>
Subject: Re: [PATCH 1/3] set errno=0 before strtoX calls
To: Patrick Steinhardt <ps@pks.im>
Cc: Kyle Lippincott via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 10:12=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Fri, Aug 02, 2024 at 04:10:51AM +0000, Kyle Lippincott via GitGitGadge=
t wrote:
> > From: Kyle Lippincott <spectral@google.com>
> >
> > To detect conversion failure after calls to functions like `strtod`, on=
e
> > can check `errno =3D=3D ERANGE`. These functions are not guaranteed to =
set
> > `errno` to `0` on successful conversion, however. Manual manipulation o=
f
> > `errno` can likely be avoided by checking that the output pointer
> > differs from the input pointer, but that's not how other locations, suc=
h
> > as parse.c:139, handle this issue; they set errno to 0 prior to
> > executing the function.
> >
> > For every place I could find a strtoX function with an ERANGE check
> > following it, set `errno =3D 0;` prior to executing the conversion
> > function.
>
> Makes sense. I've also gone through callsites and couldn't spot any
> additional ones that are broken.
>
> Generally speaking, the interfaces provided by the `strtod()` family of
> functions is just plain awful, and ideally we wouldn't be using them in
> the Git codebase at all without a wrapper. We already do have wrappers
> for a subset of those functions, e.g. `strtol_i()`, which use an out
> pointer to store the result and indicate success via the return value
> instead of via `errno`.
>
> It would be great if we could extend those wrappers to cover all of the
> integer types, convert our code base to use them, and then extend our
> "banned.h" banner. I'm of course not asking you to do that in this patch
> series.
>
> Out of curiosity, why do you hit those errors in your test setup? Do you
> use a special libc that behaves differently than the most common ones?

The second patch in this series fixes the original reason I noticed
the issues in three of the files: our remote test execution service
uses paths that are >128 bytes long, so the getcwd call in
strbuf_getcwd was returning ERANGE once, and then it remained set
since getcwd didn't clear it on success. ref-filter.c was found via
searching, I think that was during the search for `ERANGE`.

>
> Patrick
