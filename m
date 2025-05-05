Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85EA1922E7
	for <git@vger.kernel.org>; Mon,  5 May 2025 07:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746430662; cv=none; b=djv+mJ3lRZIGaa9n5rA728WrXLl31l+KQI5syOmcdRPoaSZYteguFcbBb3Q4mF4YTuRZtFEjc/olG98SSmMqKtERhJqxNbd7clA6We0AAjCJty4GV+tzCjjFI9VR9Klcw3cOtQlVFxg4+9Ub2q/2i+OR+9rRA2ZXwZAHn8wYPUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746430662; c=relaxed/simple;
	bh=X1p/WW4W6nzkI2EPdoQxk8n2LgfG/yYjhyJeK8PYV5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rf+4TZXcgpxi2OS6NKVOxz59ZKg2OM22Ad3vQkHzxMt4p7eJpLE5jRxPyZFm1mMFfYy9uwSspgrEMM6A+6W+u1T3fzCrYgMookZeh4GesXKwO5+kLe9ZaQhnkPpYtJGlsWAeFhj4WMhEEco42BeS8gLCxWNOBDzKNYF9sRkxl2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljcJrKMe; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljcJrKMe"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e7387d4a334so3254420276.2
        for <git@vger.kernel.org>; Mon, 05 May 2025 00:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746430660; x=1747035460; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d3KH16fDqwGAigmpDifob4bSwegI8m92FgAeo+Sq0iE=;
        b=ljcJrKMeZhBTotKp051hAkUTv3lWGK8O5EkvDQBESLbLZe/JLU71MAdTJ73RAoRLUp
         RgySAqLlc0dTfQbCZSUQHkl4gtSe9RiyHClL/UeoJviAB4+GgGfCd6n4bnNqz5ernuf8
         ONfGmwLRj1608F2pF8f4OH5Hk27OyH+zVREfsLRA9l+oHiE1qhlVBK5w6Hxoit2ts12X
         AePXLohNVsw31VLdlnn8d0nPW4wGXTcYB9ToVE666p/UyOl5qOL1ZvLd5g5h8rbdCzJ5
         qoDifnFWOGZz84XHfBt9S6PvYqINmv2AwDQD9MN+evPooRSsJo41gW6oVoqccKPRH+Fm
         gUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746430660; x=1747035460;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d3KH16fDqwGAigmpDifob4bSwegI8m92FgAeo+Sq0iE=;
        b=l4ELsxtPrIFbcuvADVeAjF84eevwrNBl/JedTBxf0H9Bu0R8B937bURv0EWrMMhaEH
         gDDlDTkTzyj2Xe0KMVSTemF3h66YvF20JKYpyKL3dJ783Rc0o0BCYBZSv9buOyY5Du2h
         7xfl/K7BDFfZhJfOq3+uATCFdrSarCqeO9ac0EE4WSFyiHFMu4aNXsYNTtZWWgXetdzs
         oPD3QvXBolmsUw3dTResV7tOb2n+cyNq9NlGH4NW0CfWRtIXlhvIWIGbaNYsrykKzxTt
         7u7ouyqTLt0X+SAPzfDgE5mBGfbLp3UWifRjR7+W9bCluzxd44w4jt5E0E1XBSjpZO1P
         u9/g==
X-Gm-Message-State: AOJu0Yw7K+NZNHsQ+mYGtjoPJBRePPdLnITr5MgxIdYQ9jWl8ZYXVZDX
	uvmqyddabk5Mb37cbngQXVHtX9rnWS6kz67v/lOM1rne2xg3WZDfdco46jHr4G0CcesNQMHqYSV
	ICGfH02WXjH9NB6zCrY4nkBwP63j34DceFo8=
X-Gm-Gg: ASbGncuTPbgUqMA0UZOv0Fvh/wnwK74PJJ6WdGt1vkf5Xh82UZmIUm6k+9oQTH7DfCG
	ws9854QWKuTo1jl4Qy0X1aclYH1GeE1ZRx+NU5TQHS6F6Gyaw09ohZk63Y0c/vf6JHOi59jt2dr
	Mtd2zJhkXKE+l5OJKGKYtdkFk=
X-Google-Smtp-Source: AGHT+IEQFY4GOOzHSVI1nPOCnz2N0gHyfXoYnDKiYAEkM7cdp9otuRxm3w28LWW6cgq6sEzhYr0FS48sUfArUY8+ZqQ=
X-Received: by 2002:a05:6902:2781:b0:e72:cbf1:6e8c with SMTP id
 3f1490d57ef6-e757d2e0352mr7636002276.16.1746430659683; Mon, 05 May 2025
 00:37:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429175302.23724-1-kuforiji98@gmail.com> <20250429175302.23724-4-kuforiji98@gmail.com>
 <aBSXGz_eIljWbb2H@pks.im>
In-Reply-To: <aBSXGz_eIljWbb2H@pks.im>
From: Seyi Chamber <kuforiji98@gmail.com>
Date: Mon, 5 May 2025 08:37:27 +0100
X-Gm-Features: ATxdqUFa5ncoMoZhvarbbp9OeKEqT-d8ehr7sHIDcT8bhC7cLlQewwa611OkbuY
Message-ID: <CAGedMtcBsT=7=tL_y99_G9xNW43Bttb3dFqy68DfFt0ZgpZ-4Q@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] t/unit-tests: convert reftable block test to use clar
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 May 2025 at 10:57, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Tue, Apr 29, 2025 at 06:52:55PM +0100, Seyi Kuforiji wrote:
> > diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
> > deleted file mode 100644
> > index 22040aeefa..0000000000
> > --- a/t/unit-tests/t-reftable-block.c
> > +++ /dev/null
>
> Hm, why is this recorded as a delete and creation? Weird, inspecting the
> diff locally properly shows it as a rename, which makes it a ton easier
> to review. It would be great if you could try to play around with the
> `--find-renames` option in the next iteration of this series and double
> check that these are shown as a rename.
>

I used `--find-renames=90` for this patch series. Is there any
recommended number to set it to? :/

> > diff --git a/t/unit-tests/u-reftable-block.c b/t/unit-tests/u-reftable-block.c
> > new file mode 100644
> > index 0000000000..af24901230
> > --- /dev/null
> > +++ b/t/unit-tests/u-reftable-block.c
> > @@ -0,0 +1,373 @@
> > +/*
> > +Copyright 2020 Google LLC
> > +
> > +Use of this source code is governed by a BSD-style
> > +license that can be found in the LICENSE file or at
> > +https://developers.google.com/open-source/licenses/bsd
> > +*/
> > +
> > +#include "unit-test.h"
> > +#include "reftable/block.h"
> > +#include "reftable/blocksource.h"
> > +#include "reftable/constants.h"
> > +#include "reftable/reftable-error.h"
> > +#include "strbuf.h"
> > +
> > +void test_reftable_block__index_read_write(void)
>
> This doesn't got to do anything with indices but with refs, so I'd
> rename this to `__ref_read_write()`.
>
> > +{
> > +     const int header_off = 21; /* random */
> > +     struct reftable_record recs[30];
> > +     const size_t N = ARRAY_SIZE(recs);
> > +     const size_t block_size = 1024;
> > +     struct reftable_block block = { 0 };
> > +     struct block_writer bw = {
> > +             .last_key = REFTABLE_BUF_INIT,
> > +     };
> > +     struct reftable_record rec = {
> > +             .type = BLOCK_TYPE_REF,
> > +     };
> > +     size_t i = 0;
> > +     int ret;
> > +     struct block_reader br = { 0 };
> > +     struct block_iter it = BLOCK_ITER_INIT;
> > +     struct reftable_buf want = REFTABLE_BUF_INIT, buf = REFTABLE_BUF_INIT;
> > +
> > +     REFTABLE_CALLOC_ARRAY(block.data, block_size);
> > +     cl_assert(block.data != NULL);
> > +     block.len = block_size;
> > +     block_source_from_buf(&block.source ,&buf);
> > +     ret = block_writer_init(&bw, BLOCK_TYPE_REF, block.data, block_size,
> > +                             header_off, hash_size(REFTABLE_HASH_SHA1));
> > +     cl_assert(ret == 0);
>
> Same comment here, asserts like this can be retained as
> `cl_assert(!ret)`.
>

ohh, I didn't know this was possible.

> > +     rec.u.ref.refname = (char *) "";
> > +     rec.u.ref.value_type = REFTABLE_REF_DELETION;
> > +     ret = block_writer_add(&bw, &rec);
> > +     cl_assert_equal_i(ret, REFTABLE_API_ERROR);
> > +
> > +     for (i = 0; i < N; i++) {
> > +             rec.u.ref.refname = xstrfmt("branch%02"PRIuMAX, (uintmax_t)i);
> > +             rec.u.ref.value_type = REFTABLE_REF_VAL1;
> > +             memset(rec.u.ref.value.val1, i, REFTABLE_HASH_SIZE_SHA1);
> > +
> > +             recs[i] = rec;
> > +             ret = block_writer_add(&bw, &rec);
> > +             rec.u.ref.refname = NULL;
> > +             rec.u.ref.value_type = REFTABLE_REF_DELETION;
> > +             cl_assert_equal_i(ret, 0);
> > +     }
> > +
> > +     ret = block_writer_finish(&bw);
> > +     cl_assert(ret > 0);
>
> It's a bit unfortunate that we have to use `cl_assert()` here, but that
> isn't the fault of this series. I do have a pull request pending
> upstream that introduces integer comparisons. Once we've updated to that
> version I'll go through our unit tests and adapt callsites accordingly.
>
> [snip]
> > +void test_reftable_block__ref_read_write(void)
>
> This one here should be called `__index_read_write()`. I guess you
> confused the first and and this test name with one another.
>
> Patrick

Ah, okay, Thanks!

Best
Seyi
