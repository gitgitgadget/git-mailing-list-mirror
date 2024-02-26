Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7486712F395
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 19:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974691; cv=none; b=QjDj+EuTuBzNPBCBHGBRzh/jkpZUsmmiQwlVxLiEMJ/fiEheNDSGoEWGnnNjcAL1Hk/rzxAVn4xBiSJVBOkhkHPrrDYE78KY24qkfk9a63t88J6+aiGlDvuT+w+Ly83C466eUyUbx6YArApbDv4R1VIuGSipYLX5PzL7AHU2EjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974691; c=relaxed/simple;
	bh=0s2hL9dM6yaj6ouhIrkRjXOvTJ7ZNPWHQ6OiulZrpMY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=YgDZqZb85MgmHBV6kcNcplbFKefX/wKd0fSMTz5QmLS4b3bPbrRjzgssKbslBGPFy068x6+jMfCDeLgRb/jj4l2cuMiS+EWHJxX6ZsEQWacl8ez+T7IQlNg0QZStgXduIeWCr3RyVA7NdEA/Fag2HwIJlj8IkIeMcDT63TX067g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCnxZNq9; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCnxZNq9"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e4f569f326so1437857b3a.2
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 11:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708974689; x=1709579489; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UQnjDOrQ8oz0O2uh+scK0YwR13d9XTrsGdd6S9UwSo=;
        b=RCnxZNq9LfJtvXzNfr8q5H6e8Enn0haIMZ8Vb6h3HP0hDwtJgvQkLMP7Ap1zmRoa0b
         l8g01AeJGIiLdLYSjkE6iy6DvrbuP41Bop4ONNYSUUijhnFgNzbl8ZEIbmZSahwK36QD
         BK6JtBYI3kaxlEb6YMhNZlCZe6LRES2I9n5YlBhAOeJDaxCeLZS4T9t5ksOowPkl6hW8
         ETG+QScP1GzA0EkqpttghtHNs4xrqkX4rHFNR1/usn2d2aLZWf6AKwsOnBRt4kil2n5K
         suxyLQwFg5GFA+sCSReUN36+Vg32BNLH+/dx3r8YMIDRibkvaY/dIDaaKRQz1KH84Qa1
         KnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708974689; x=1709579489;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8UQnjDOrQ8oz0O2uh+scK0YwR13d9XTrsGdd6S9UwSo=;
        b=lhE4FFVDac7pVd0iw4AeBJebL8+jzVn0Fvmh2IQD5qmmV/W/065nde815mUz9CjYF8
         z6qFrtyATBoC6xky/1RjEojCxRGw/58C8+fsMjAcOGVqIP0qjErFNXZPXcHiBkfMBPcv
         Mk344P4pccXYAjMDgtRWDQiJTzNpaiC73pY2XtT2T5Y7fmR0olnqMg67SZlVDROyqFQx
         kKmfeCIrlImVQxOgBh+94b1nlU1C7WMHu1RxzeWStU48l9zvxUSWDmjCTFDmRsiyeapy
         Kk3+Xdiw9cPaAqNrI//sXI61vBbKD+kOPspE47aMuu7WhxSTqxY9I6QT+ScXFh0fjXC7
         r8Tg==
X-Gm-Message-State: AOJu0YwWXAc0/39HRFU9mAHscTCvqNfHUrLZCOkx7O8ysO/7sjt6kxiI
	2FAFfzS773iWPpGH0/7heWj1YR8Ora5CUjxJJ9qD+diIAmhYVwKG
X-Google-Smtp-Source: AGHT+IG660XL6lisSRp9h32mnJDG6I4r2m0tiqzXaJud0192XgX7ofKduk+TnZxrRxGHYzU5+pchXA==
X-Received: by 2002:a05:6a20:6f01:b0:1a0:c3e6:3135 with SMTP id gt1-20020a056a206f0100b001a0c3e63135mr69203pzb.28.1708974688554;
        Mon, 26 Feb 2024 11:11:28 -0800 (PST)
Received: from localhost ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id b14-20020a63e70e000000b005cd8044c6fesm4357737pgi.23.2024.02.26.11.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 11:11:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Feb 2024 00:41:24 +0530
Message-Id: <CZF8YROS9RVC.9H2EKYCF08VK@gmail.com>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH] unit-tests: convert t/helper/test-oid-array.c to
 unit-tests
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Christian Couder" <christian.couder@gmail.com>
X-Mailer: aerc 0.15.2
References: <20240223193257.9222-1-shyamthakkar001@gmail.com>
 <CAP8UFD088GRkVQWjrBFk04_HFfiEk64Saxm2toYsci36oHgkdA@mail.gmail.com>
In-Reply-To: <CAP8UFD088GRkVQWjrBFk04_HFfiEk64Saxm2toYsci36oHgkdA@mail.gmail.com>

On Mon Feb 26, 2024 at 8:41 PM IST, Christian Couder wrote:
> It might not be a good idea to start working on a GSoC project we
> propose (Move existing tests to a unit testing framework) right now.
> You can work on it as part of your GSoC application, to show an
> example of how you would do it, and we might review that as part of
> reviewing your application. But for such a project if many candidates
> started working on it and sent patches to the mailing list before they
> get selected, then the project might be nearly finished before the
> GSoC even starts.
>
> So I think it would be better to work on other things instead, like
> perhaps reviewing other people's work or working on other bug fixes or
> features. Anyway now that this is on the mailing list, I might as well
> review it as it could help with your application. But please consider
> working on other things.

I understand and will work on other things.

> > There is only one change in the new testing approach. In the previous
> > testing method, a new repo gets initialized for the test according to
> > GIT_TEST_DEFAULT_HASH algorithm.
>
> It looks like this happens in "t/test-lib-functions.sh", right?
> Telling a bit more about how and where that happens might help
> reviewers who would like to take a look.

Yeah, that is happens in "t/test-lib-functions.sh". I will update the
commit message to describe this better.
>
> > In unit testing however, we do not
> > need to initialize the repo. We can set the length of the hexadecimal
> > strbuf according to the algorithm used directly.
>
> So is your patch doing that or not? It might be better to be explicit.
> Also if 'strbuf's are used, then is it really worth it to set their
> length in advance, instead of just letting them grow to the right
> length as we add hex to them?

I thought of it like this: If we were to just let them grow, then we
would need separate logic for reusing that strbuf or use a different
one everytime since it always grows. By separating allocation
(hex_strbuf_init) and manipulation (fill_hex_strbuf), that same strbuf
can be reused for different hex values.

But, none of the test currently need to reuse the same strbuf, so I
suppose it is better to just let it grow and even if the need arises we
can use strbuf_splice().


> > Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> > ---
> > [RFC]: I recently saw a series by Eric W. Biederman [1] which enables
> > the use of oid's with different hash algorithms into the same
> > oid_array safely. However, there were no tests added for this. So, I
> > am wondering if we should have a input format which allows us to
> > specify hash algo for each oid with its hex value. i.e. "sha1:55" or
> > "sha256:55", instead of just "55" and relying on GIT_TEST_DEFAULT_HASH
> > for algo. So far, I tried to imitate the existing tests but I suppose
> > this may be useful in the future if that series gets merged.
>
> The fact that there is a series touching the same area might also hint
> that it might not be the right time to work on this.

I understand.

> > diff --git a/t/unit-tests/t-oid-array.c b/t/unit-tests/t-oid-array.c
> > new file mode 100644
> > index 0000000000..b4f43c025d
> > --- /dev/null
> > +++ b/t/unit-tests/t-oid-array.c
> > @@ -0,0 +1,222 @@
> > +#include "test-lib.h"
> > +#include "hex.h"
> > +#include "oid-array.h"
> > +#include "strbuf.h"
> > +
> > +#define INPUT "88", "44", "aa", "55"
> > +#define INPUT_DUP \
> > +       "88", "44", "aa", "55", "88", "44", "aa", "55", "88", "44", "aa=
", "55"
>
> Can you reuse INPUT in INPUT_DUP?

Yeah, that would be more clearer.

> > +#define INPUT_ONLY_DUP "55", "55"
> > +#define ENUMERATION_RESULT_SORTED "44", "55", "88", "aa"
> > +
> > +/*
> > + * allocates the memory based on the hash algorithm used and sets the =
length to
> > + * it.
> > + */
> > +static void hex_strbuf_init(struct strbuf *hex)
> > +{
> > +       static int sz =3D -1;
> > +
> > +       if (sz =3D=3D -1) {
> > +               char *algo_env =3D getenv("GIT_TEST_DEFAULT_HASH");
> > +               if (algo_env && !strcmp(algo_env, "sha256"))
> > +                       sz =3D GIT_SHA256_HEXSZ;
> > +               else
> > +                       sz =3D GIT_SHA1_HEXSZ;
> > +       }
> > +
> > +       strbuf_init(hex, sz);
> > +       strbuf_setlen(hex, sz);
> > +}
>
> A strbuf can grow when we add stuff to it. We don't need to know its
> size in advance. So I am not sure this function is actually useful.

Yeah, this was mainly for deciding the hash algorithm but that logic can
be moved to fill_hex_strbuf.

> > +/* fills the hex strbuf with alternating characters from 'c' */
> > +static void fill_hex_strbuf(struct strbuf *hex, char *c)
> > +{
> > +       size_t i;
> > +       for (i =3D 0; i < hex->len; i++)
> > +               hex->buf[i] =3D (i & 1) ? c[1] : c[0];
>
> There is strbuf_addch() to add a single char to a strbuf, or
> strbuf_add() and strbuf_addstr() to add many chars at once.
Will update it.

Thank you for the feedback and review.

