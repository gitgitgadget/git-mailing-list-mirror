Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3711E87C
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 12:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719406662; cv=none; b=EoF3NFSngLo9HT4q1FS4TTK2o1cTw2qIUpDqvzdpklzXl1NSt/G9WiAbpQEWXrPyAvPKEQz77QmEW+so2MFoyNFqag/lFh84MWzLEMWuTfMTYNKa8ZblND0k8GljZV/NlFTDkxFcU1DV4ZTdpNGEBlUb4rJfVXgDcbA9GckwfJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719406662; c=relaxed/simple;
	bh=IoQ1O5Q8zN5vBDspkvBLyu/S1jyqbt42q6gaJnongm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JststsIP8YNUMvK87tvxel5DPzZQqPw1J8hgczATls0By8hxecpQkdWIG3h4mwInuQ8E2+4yt2DlYeXhqpg/Jd1WETYoEkzpKIzeguQI7rf7YtnawIFyartazpR21h6GsSdYiPMH6l2avbf+fIl3SxWoSmOGWk7CpsI5sVXc06A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EN5hWb3N; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EN5hWb3N"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ec5779b423so45196521fa.0
        for <git@vger.kernel.org>; Wed, 26 Jun 2024 05:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719406659; x=1720011459; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YmNChBO7ME9Ug6wogr6pkILXwG1ILvRrLdIfgTfJli0=;
        b=EN5hWb3Nav7frIkYx+ecP3e14wUdoMZbyo/uxwy4GF9X/jdnAJPCJMb+OgABc/Ost/
         FhIWuYGephhhZfzXbRc/1cx1O9/mCQhxKTBfNY0V6zlrxMi7KfeNaZcgbuvvOMUdHX2J
         kxB+MGfTOXJgYzB20NkBMqDh3hgsq/9Q476Ql3dw7654aIzQImcGlDTk2yVLqv/eMj6g
         0FdeK2X1OgPN18kifKHp5pAqAw2gsqr8cE61uF9vg7g4IeZSkvrTfp++KiLMOfvdIlmB
         YrUc0GkKg1lZHw09wQgCR4me/8zBGycx22yh7NJSGuBcsjYOsERp/yVAbq9zdUn8NTfr
         WvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719406659; x=1720011459;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YmNChBO7ME9Ug6wogr6pkILXwG1ILvRrLdIfgTfJli0=;
        b=UKsR1raVUFyEvQegn9+tAZT3KXN3Duhgxw+453RJEFvWr7Q4Jddk/yBbu0uQPqvt4X
         Zv2Lfpc+fMPkOw2F06OJRWmt4+rTcWei6WRYKSv0J1nfOL7Dr4fFSvVJiyugrcEEoN44
         6yLMnmho3MjsgGc22+NKpqLgkBRHIQEMgg2s1qIlfLPnLJRUSbE18s7CjyO+EGe2csUe
         uegbygaAIeVyYBBPzpzl+Bu7gGw7H1zknlcbEjZlK3OClidSrWqPviU+qxE/htHsEkZp
         Na0jwNxl6pPNnZzDeSOYjrtUhqBFvkg6q0GgTmvWSA8NM93BcmjgUkcWhb6DTF7VQjl5
         BUUw==
X-Gm-Message-State: AOJu0YysvzPZ3/UZLeNw/kvGyU0N9AfOUT2kmpJBkdDLWWvrkHiq9TKx
	abITAcAY3d9PSCQkSEoh/M40ic8asxVVn4rIRJSe2XKfvy8aCbiy0VQ+VdFCGtD0/eG3seU70DQ
	pO8cVcuaxsoFzXleP1X9nmUKQSYzAMUjKA78=
X-Google-Smtp-Source: AGHT+IHH0Fa4Ogaf0R9zgdMjKCRkCtGrdnDOH/nr/Tz5VxOoEUHgI+oM5Ulzgq0CBRn7lsZ7Atm7K28TJq38xQPGx40=
X-Received: by 2002:a2e:97d5:0:b0:2eb:f86c:9d69 with SMTP id
 38308e7fff4ca-2ec59329e9bmr81587581fa.29.1719406658676; Wed, 26 Jun 2024
 05:57:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
 <20240621115708.3626-1-chandrapratap3519@gmail.com> <20240621115708.3626-2-chandrapratap3519@gmail.com>
 <CAOLa=ZSmnMLMoKKWMiM7M4Jw8CJ0Jvrs0oMLy18FHaLv_6s6yA@mail.gmail.com>
 <CA+J6zkSymKxSRnAVx7oeAoPpMxrRsVRPGO-X0tVbc0VtKOe3ig@mail.gmail.com> <CAOLa=ZQG4S6oJ_YTvc9LjV9C+THKcr_4xMsrOB2Mw6CZYfK9GA@mail.gmail.com>
In-Reply-To: <CAOLa=ZQG4S6oJ_YTvc9LjV9C+THKcr_4xMsrOB2Mw6CZYfK9GA@mail.gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Wed, 26 Jun 2024 18:27:25 +0530
Message-ID: <CA+J6zkSGyJ25dHSUgxF+-uEHBg13qaBwk_526QSqGN+FwRrMEQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] t: move reftable/record_test.c to the unit testing framework
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, karthik188@gmail.com, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Jun 2024 at 17:22, Karthik Nayak <karthik.188@gmail.com> wrote:
>
> Chandra Pratap <chandrapratap3519@gmail.com> writes:
>
> > On Tue, 25 Jun 2024 at 13:56, Karthik Nayak <karthik.188@gmail.com> wrote:
> >>
> >> Chandra Pratap <chandrapratap3519@gmail.com> writes:
> >>
> >> > reftable/record_test.c exercises the functions defined in
> >> > reftable/record.{c, h}. Migrate reftable/record_test.c to the
> >> > unit testing framework. Migration involves refactoring the tests
> >> > to use the unit testing framework instead of reftable's test
> >> > framework.
> >> > While at it, change the type of index variable 'i' to 'size_t'
> >> > from 'int'. This is because 'i' is used in comparison against
> >> > 'ARRAY_SIZE(x)' which is of type 'size_t'.
> >> >
> >> > Also, use set_hash() which is defined locally in the test file
> >> > instead of set_test_hash() which is defined by
> >> > reftable/test_framework.{c, h}. This is fine to do as both these
> >> > functions are similarly implemented, and
> >> > reftable/test_framework.{c, h} is not #included in the ported test.
> >> >
> >> > Mentored-by: Patrick Steinhardt <ps@pks.im>
> >> > Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> >> > Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> >> > ---
> >> >  Makefile                                      |   2 +-
> >> >  t/helper/test-reftable.c                      |   1 -
> >> >  .../unit-tests/t-reftable-record.c            | 106 ++++++++----------
> >> >  3 files changed, 50 insertions(+), 59 deletions(-)
> >> >  rename reftable/record_test.c => t/unit-tests/t-reftable-record.c (77%)
> >> >
> >> > diff --git a/Makefile b/Makefile
> >> > index f25b2e80a1..def3700b4d 100644
> >> > --- a/Makefile
> >> > +++ b/Makefile
> >> > @@ -1338,6 +1338,7 @@ UNIT_TEST_PROGRAMS += t-hash
> >> >  UNIT_TEST_PROGRAMS += t-mem-pool
> >> >  UNIT_TEST_PROGRAMS += t-prio-queue
> >> >  UNIT_TEST_PROGRAMS += t-reftable-basics
> >> > +UNIT_TEST_PROGRAMS += t-reftable-record
> >> >  UNIT_TEST_PROGRAMS += t-strbuf
> >> >  UNIT_TEST_PROGRAMS += t-strcmp-offset
> >> >  UNIT_TEST_PROGRAMS += t-strvec
> >> > @@ -2678,7 +2679,6 @@ REFTABLE_TEST_OBJS += reftable/block_test.o
> >> >  REFTABLE_TEST_OBJS += reftable/dump.o
> >> >  REFTABLE_TEST_OBJS += reftable/merged_test.o
> >> >  REFTABLE_TEST_OBJS += reftable/pq_test.o
> >> > -REFTABLE_TEST_OBJS += reftable/record_test.o
> >> >  REFTABLE_TEST_OBJS += reftable/readwrite_test.o
> >> >  REFTABLE_TEST_OBJS += reftable/stack_test.o
> >> >  REFTABLE_TEST_OBJS += reftable/test_framework.o
> >> > diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
> >> > index 9160bc5da6..aa6538a8da 100644
> >> > --- a/t/helper/test-reftable.c
> >> > +++ b/t/helper/test-reftable.c
> >> > @@ -5,7 +5,6 @@
> >> >  int cmd__reftable(int argc, const char **argv)
> >> >  {
> >> >       /* test from simple to complex. */
> >> > -     record_test_main(argc, argv);
> >> >       block_test_main(argc, argv);
> >> >       tree_test_main(argc, argv);
> >> >       pq_test_main(argc, argv);
> >> > diff --git a/reftable/record_test.c b/t/unit-tests/t-reftable-record.c
> >> > similarity index 77%
> >> > rename from reftable/record_test.c
> >> > rename to t/unit-tests/t-reftable-record.c
> >> > index 58290bdba3..1b357e6c7f 100644
> >> > --- a/reftable/record_test.c
> >> > +++ b/t/unit-tests/t-reftable-record.c
> >> > @@ -6,13 +6,9 @@
> >> >    https://developers.google.com/open-source/licenses/bsd
> >> >  */
> >> >
> >> > -#include "record.h"
> >> > -
> >> > -#include "system.h"
> >> > -#include "basics.h"
> >> > -#include "constants.h"
> >> > -#include "test_framework.h"
> >> > -#include "reftable-tests.h"
> >> > +#include "test-lib.h"
> >> > +#include "reftable/constants.h"
> >> > +#include "reftable/record.h"
> >> >
> >> >  static void test_copy(struct reftable_record *rec)
> >> >  {
> >> > @@ -24,9 +20,9 @@ static void test_copy(struct reftable_record *rec)
> >> >       reftable_record_copy_from(&copy, rec, GIT_SHA1_RAWSZ);
> >> >       /* do it twice to catch memory leaks */
> >>
> >> I'm curious why we do this, and if it is still needed. The original
> >> commit (e303bf22f reftable: (de)serialization for the polymorphic record
> >> type) doesn't mention any particular reasoning.
> >
> > Yeah, I was confused about this as well. I asked Patrick about it some time
> > ago and it seems like he had no clue about it either:
> > https://gitlab.slack.com/archives/C071PDKNCHM/p1717479205788209
> >
>
> Just to note, this is an internal GitLab link and not accessible to
> others on the list.
>
> But to summarize, seems like we're not sure why this was added. CC'ing
> Han-Wen here incase he remembers the intent.
>
> > Should we get rid of this after all?
>
> The best solution would be to understand its reasoning and incorporate
> that, but otherwise its best to remove it. We do have CI pipelines to
> capture leaks in a general sense.
>
> >> >       reftable_record_copy_from(&copy, rec, GIT_SHA1_RAWSZ);
> >> > -     EXPECT(reftable_record_equal(rec, &copy, GIT_SHA1_RAWSZ));
> >> > +     check(reftable_record_equal(rec, &copy, GIT_SHA1_RAWSZ));
> >> >
> >> > -     puts("testing print coverage:\n");
> >> > +     test_msg("testing print coverage:");
> >> >       reftable_record_print(&copy, GIT_SHA1_RAWSZ);
> >> >
> >>
> >> This prints for any test that uses this function. As I see from the
> >> current usage of the testing library, we only print debug information
> >> when we encounter something unexpected.
> >>
> >> This also clogs up the unit-test's output. So I would remove this from
> >> here.
> >
> > That's true, but that would also mean the print functions are no longer
> > exercised. Is that a fine tradeoff?
> >
>
> I don't see it this way. Just exercising the function doesn't test it in
> any way. Since the function just prints to stdout without an option to
> pick any other file descriptor, there is no way to test it currently
> either.

While that is true, it makes me wonder the reason behind adding it
in the original test. Maybe we're supposed to manually verify the output?

> On the contrary if no one is using the function, perhaps we can even
> remove it.

The thing is, all the 'print' functions defined in reftable/ directory are
meant to be used for debugging. So while they're not used anywhere
in production, they still serve an important purpose during development.
