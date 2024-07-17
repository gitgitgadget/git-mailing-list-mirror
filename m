Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C7D1802DA
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 13:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721224257; cv=none; b=jLF+S2EdwxOzf5hrWs9Jp7uivuFJhleNuutDS4HP03jfCO2bzlNtxyFaafMFBGMpnqS392mhsZHiUfrZkpYXS1xZJD+405wPNOUrYR+Og3STR0jh8VRBDZWjeNS2CUWwydM3ceYnI9UFs+/wcYykxmfiioh+mSsbcNuJSzew5lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721224257; c=relaxed/simple;
	bh=onM7Vv3dI46sQ73GvfKqO6YPveS4GRnL64uHeTf8O7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dy8Mk6LhYCa69N10Y80zQ41fPjG1N+i5y6ZrwObbbepHi/RUReYEt6KmvsAuLKWWrvFwh7mX8s9Je3B6BvPpI/1SQxZVjb7W/oSmpBehXT3za7c2YfdOBscC+AEU4AxUz/ysDC2FL253qKMHtRNG5ntQLEBC2KNgwegmuVLsgwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSBvCunH; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSBvCunH"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5a10835480bso339007a12.2
        for <git@vger.kernel.org>; Wed, 17 Jul 2024 06:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721224254; x=1721829054; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=onM7Vv3dI46sQ73GvfKqO6YPveS4GRnL64uHeTf8O7o=;
        b=lSBvCunH2AtsOJs5r/OPJieKnd6xphFEfnvJprV9MSCHJqP3st2oJZocJEIismrw6k
         MDwrZFfsOnBAYB7NR+vPkMg+A4Em2FAnv4pKgLHmwMFUdXCR/utbEWLyR5CNzNw6hlNN
         M2fqYj3UZNcf+z87+9ZSWmNGErQlKM1pIRxm6/D3x1Y1q6BTg/hluOmXo7X39QVyNJVM
         cMN2XZjjueG59zbEJGKFtkDaKcfMnwFATZC7mrNtVOjMG/aFX/EMptDK9gQGECdLJG+M
         NIoIcEHQKrI6ZNNjNV6LrPVjjbVlzsaOeTJihhKvSa27tr2695KWBpbtJ/wZKNiIj0Dt
         B1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721224254; x=1721829054;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=onM7Vv3dI46sQ73GvfKqO6YPveS4GRnL64uHeTf8O7o=;
        b=tniUSkYZqPTDhdQbn+R7H3PoK236/IeT0WKnVYvRYYdIx9dMIycyveZUW58Cdd2RaT
         lVFHxlZirT8FMz0WZ2To9vC5jQ7id/Tjv0lEQyTH8rWpdhgaMIIfwjH0ifaqFoDELD+i
         wgiwyJUfNtUBXFZXBA9ZUIlslbDRnxsxObsEPoJy0rjw6sGETTCccDCuLe44NMCTzfJX
         xFZ9trtEah2n/rIohTYW1ICuptORUly+/L7a7RzyL3DxXqJEeLB1s7cQ+9Kfhww0Truz
         MuZovZs1CuEu+tjfhIF1BZD9fPOcCJ5KgZREioAVe6Vo6FkYhGtkUkOucIQ3oY5eU5vt
         89fg==
X-Gm-Message-State: AOJu0YxQKMPLB6NLFHz+EKMdTsJmW/A/F0F01QXT0zDZLQQ0Vi7jh+l+
	WNelz+7Zt39c4JMvrvDJYni1B84U+/2iMUpnf1C98RfuF/I8TFrbPJTDJhuqRZFqtrg2a4+dpjy
	3SlTB3cMPqWMMNRVi7x27ocXjM4Q=
X-Google-Smtp-Source: AGHT+IGkpBpe47DKja1QjQqUKNQwM4ruptrTPkzrAP8aYUVMIfbjSYVAQhNKirmSAIPtmJ+tmmvY8bk1KOElWlDaWv8=
X-Received: by 2002:a05:6402:354e:b0:59e:a1a6:134d with SMTP id
 4fb4d7f45d1cf-5a05d0f07d4mr1708924a12.32.1721224253862; Wed, 17 Jul 2024
 06:50:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612130217.8877-1-chandrapratap3519@gmail.com>
 <20240716075641.4264-1-chandrapratap3519@gmail.com> <20240716075641.4264-3-chandrapratap3519@gmail.com>
 <CAOLa=ZQ7xQFKZ9Oeo0WyrgzvjCvNm4dbgatp0JTvP33sUQ_3fw@mail.gmail.com>
In-Reply-To: <CAOLa=ZQ7xQFKZ9Oeo0WyrgzvjCvNm4dbgatp0JTvP33sUQ_3fw@mail.gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Wed, 17 Jul 2024 19:20:43 +0530
Message-ID: <CA+J6zkQpNiM1UpGRzkNP9o04cEL4ip-YFkQvXk2zgSjpE4uGBw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] t: move reftable/tree_test.c to the unit testing framework
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, karthik188@gmail.com, chriscool@tuxfamily.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jul 2024 at 17:19, Karthik Nayak <karthik.188@gmail.com> wrote:
>
> Chandra Pratap <chandrapratap3519@gmail.com> writes:
>
> > reftable/tree_test.c exercises the functions defined in
> > reftable/tree.{c, h}. Migrate reftable/tree_test.c to the unit
> > testing framework. Migration involves refactoring the tests to use
> > the unit testing framework instead of reftable's test framework and
> > renaming the tests to align with unit-tests' standards.
> >
>
> Nit: it would be nice to mention that this commit copies it over as-is
> (mostly) and the upcoming commits do refactoring. This would really help
> reviewers.

I do mention that in the patch cover letter, specifically this paragraph:

> The first patch in the series is preparatory cleanup, the second patch
> moves the test to the unit testing framework, and the rest of the patches
> improve upon the ported test.

Would it be better if I transport that here?

----[snip]----
