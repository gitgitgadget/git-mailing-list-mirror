Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B05156227
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 13:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719321162; cv=none; b=lFJqXjGxzYGL2stikU/sLKRaPswU/mRo4Mk1dzFNd+LjENnkXAETwwXPPIPq2OTSKB50+B68I9YPNzuxUh6gbFlWNCVEadP+3k+Z574GJUjuaTBTuLvIE4bfP8BukB7Pdn2nwD8/8EtSbU4vxl698zmaT+nDI1+FMRt+MUQealI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719321162; c=relaxed/simple;
	bh=ezTRonThVFR9/9n+1coflxxTqsl73n8JDw8MjLRc+rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=euTiU2AYQvvYctNGnxt4GmhcihKN91hUEc1CXp0ue6Cx8uwFblphl5O8mKCdNxE7wA1HTYtW7zukYtmtLqKOCljcT074d2proYA0/EvbBKUeV3VImfUNy0bejo4pJ4429JIYFVvQvQAJ9UwWzVEDAo+hRNOKIwEfmcuzql3DjwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdEUzVuh; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdEUzVuh"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a724958f118so329291466b.0
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 06:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719321158; x=1719925958; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=awxKWKTbs3ZqR+Yie2aKJHj23q1ja2XBW4sZbnAGeiI=;
        b=MdEUzVuhrWQRZI34kcyUNLzJjAE4qmu6J9lLG0dchuAuH2W9Dg+RIs60w8rtJ1A7/V
         l2eDUC3fdLG649Aa4NYNWcMohzAMmumlSwgIsONx2iES2EluGF5wdk38xWRUIHo3JV7I
         ljiNzXDwa2QMMZHKImEABxz36WY5rr/4n5c3DqiJtjpmCJ0qxxk2QWpgnbfobwypfboM
         7EN7DkC9P01NzPvhW/shJVYiJHwB65ftWRFLjHUj3dwSvgLkFTHiKD1gCNp3H1i08KyG
         FHevLdoEBTrVJmy+i3z1akpYwSXa7mytZFAJufN0CF1zRKEQiKEHi4h9P+LiM4gt2Ed1
         gZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719321158; x=1719925958;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=awxKWKTbs3ZqR+Yie2aKJHj23q1ja2XBW4sZbnAGeiI=;
        b=DDkXa12XgKsaN6cbnB59iqrMVKmEaGzC/QY9Vvk9+gC+eK2LWsNmDghsPfZt0Ub1or
         Jm6tPsm8ZLJrNvXNoRH8UqF7Xh88xYIUtgrhDf0kgxSnd1+fGAvmhYt5dg8n4Uk3hV/G
         CY/mqMdVgdze7zkl7gM5jKsgiqlYJvQrBOFG1fLhtb20si9B3c9GBxwXfMLgshJEnl/u
         hYJzZTSN8z/6y5nmjKBvBvQkeF35mWiT48hemTrlzWTBw6R7H9onyp9PXTpq+uD0USh2
         MBl0yH712nfuKRsVVsNLoZpr3gu0AZOzWKy98BSWilEmuu/Qi2cQj70+6uO6mfmANwBE
         B5kw==
X-Gm-Message-State: AOJu0YyaCrJ3TTWr7+Zs0XJwV4Zcnqcxj9ltpsJaxs+StXMDB0jVnTnB
	EUU+omgOWbeB7eRjRHyP3E2dvcroaD9zilmLPBec1zqCfIZwnlcXMnTH1wFaExYOYPCCkxvETnD
	XYppH9/+qj35BZchyQeA0+jAgFgE=
X-Google-Smtp-Source: AGHT+IHxbUGPp9KEyoanQjmsRBn2N2w9zkJKMy4xYnefNaOttSO8IFphSatIR+7WrQbkpkhFsGXHcU2gyyYfiRf6dWU=
X-Received: by 2002:a17:907:b19:b0:a6f:4b5b:4ba7 with SMTP id
 a640c23a62f3a-a7242d2a239mr541690966b.67.1719321157903; Tue, 25 Jun 2024
 06:12:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
 <20240621115708.3626-1-chandrapratap3519@gmail.com> <20240621115708.3626-2-chandrapratap3519@gmail.com>
 <CAOLa=ZSmnMLMoKKWMiM7M4Jw8CJ0Jvrs0oMLy18FHaLv_6s6yA@mail.gmail.com>
In-Reply-To: <CAOLa=ZSmnMLMoKKWMiM7M4Jw8CJ0Jvrs0oMLy18FHaLv_6s6yA@mail.gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Tue, 25 Jun 2024 18:42:26 +0530
Message-ID: <CA+J6zkSymKxSRnAVx7oeAoPpMxrRsVRPGO-X0tVbc0VtKOe3ig@mail.gmail.com>
Subject: Re: [PATCH 01/11] t: move reftable/record_test.c to the unit testing framework
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, karthik188@gmail.com, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Jun 2024 at 13:56, Karthik Nayak <karthik.188@gmail.com> wrote:
>
> Chandra Pratap <chandrapratap3519@gmail.com> writes:
>
> > reftable/record_test.c exercises the functions defined in
> > reftable/record.{c, h}. Migrate reftable/record_test.c to the
> > unit testing framework. Migration involves refactoring the tests
> > to use the unit testing framework instead of reftable's test
> > framework.
> > While at it, change the type of index variable 'i' to 'size_t'
> > from 'int'. This is because 'i' is used in comparison against
> > 'ARRAY_SIZE(x)' which is of type 'size_t'.
> >
> > Also, use set_hash() which is defined locally in the test file
> > instead of set_test_hash() which is defined by
> > reftable/test_framework.{c, h}. This is fine to do as both these
> > functions are similarly implemented, and
> > reftable/test_framework.{c, h} is not #included in the ported test.
> >
> > Mentored-by: Patrick Steinhardt <ps@pks.im>
> > Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> > Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> > ---
> >  Makefile                                      |   2 +-
> >  t/helper/test-reftable.c                      |   1 -
> >  .../unit-tests/t-reftable-record.c            | 106 ++++++++----------
> >  3 files changed, 50 insertions(+), 59 deletions(-)
> >  rename reftable/record_test.c => t/unit-tests/t-reftable-record.c (77%)
> >
> > diff --git a/Makefile b/Makefile
> > index f25b2e80a1..def3700b4d 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1338,6 +1338,7 @@ UNIT_TEST_PROGRAMS += t-hash
> >  UNIT_TEST_PROGRAMS += t-mem-pool
> >  UNIT_TEST_PROGRAMS += t-prio-queue
> >  UNIT_TEST_PROGRAMS += t-reftable-basics
> > +UNIT_TEST_PROGRAMS += t-reftable-record
> >  UNIT_TEST_PROGRAMS += t-strbuf
> >  UNIT_TEST_PROGRAMS += t-strcmp-offset
> >  UNIT_TEST_PROGRAMS += t-strvec
> > @@ -2678,7 +2679,6 @@ REFTABLE_TEST_OBJS += reftable/block_test.o
> >  REFTABLE_TEST_OBJS += reftable/dump.o
> >  REFTABLE_TEST_OBJS += reftable/merged_test.o
> >  REFTABLE_TEST_OBJS += reftable/pq_test.o
> > -REFTABLE_TEST_OBJS += reftable/record_test.o
> >  REFTABLE_TEST_OBJS += reftable/readwrite_test.o
> >  REFTABLE_TEST_OBJS += reftable/stack_test.o
> >  REFTABLE_TEST_OBJS += reftable/test_framework.o
> > diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
> > index 9160bc5da6..aa6538a8da 100644
> > --- a/t/helper/test-reftable.c
> > +++ b/t/helper/test-reftable.c
> > @@ -5,7 +5,6 @@
> >  int cmd__reftable(int argc, const char **argv)
> >  {
> >       /* test from simple to complex. */
> > -     record_test_main(argc, argv);
> >       block_test_main(argc, argv);
> >       tree_test_main(argc, argv);
> >       pq_test_main(argc, argv);
> > diff --git a/reftable/record_test.c b/t/unit-tests/t-reftable-record.c
> > similarity index 77%
> > rename from reftable/record_test.c
> > rename to t/unit-tests/t-reftable-record.c
> > index 58290bdba3..1b357e6c7f 100644
> > --- a/reftable/record_test.c
> > +++ b/t/unit-tests/t-reftable-record.c
> > @@ -6,13 +6,9 @@
> >    https://developers.google.com/open-source/licenses/bsd
> >  */
> >
> > -#include "record.h"
> > -
> > -#include "system.h"
> > -#include "basics.h"
> > -#include "constants.h"
> > -#include "test_framework.h"
> > -#include "reftable-tests.h"
> > +#include "test-lib.h"
> > +#include "reftable/constants.h"
> > +#include "reftable/record.h"
> >
> >  static void test_copy(struct reftable_record *rec)
> >  {
> > @@ -24,9 +20,9 @@ static void test_copy(struct reftable_record *rec)
> >       reftable_record_copy_from(&copy, rec, GIT_SHA1_RAWSZ);
> >       /* do it twice to catch memory leaks */
>
> I'm curious why we do this, and if it is still needed. The original
> commit (e303bf22f reftable: (de)serialization for the polymorphic record
> type) doesn't mention any particular reasoning.

Yeah, I was confused about this as well. I asked Patrick about it some time
ago and it seems like he had no clue about it either:
https://gitlab.slack.com/archives/C071PDKNCHM/p1717479205788209

Should we get rid of this after all?

> >       reftable_record_copy_from(&copy, rec, GIT_SHA1_RAWSZ);
> > -     EXPECT(reftable_record_equal(rec, &copy, GIT_SHA1_RAWSZ));
> > +     check(reftable_record_equal(rec, &copy, GIT_SHA1_RAWSZ));
> >
> > -     puts("testing print coverage:\n");
> > +     test_msg("testing print coverage:");
> >       reftable_record_print(&copy, GIT_SHA1_RAWSZ);
> >
>
> This prints for any test that uses this function. As I see from the
> current usage of the testing library, we only print debug information
> when we encounter something unexpected.
>
> This also clogs up the unit-test's output. So I would remove this from
> here.

That's true, but that would also mean the print functions are no longer
exercised. Is that a fine tradeoff?

> >       reftable_record_release(&copy);
> > @@ -43,8 +39,8 @@ static void test_varint_roundtrip(void)
> >                             4096,
> >                             ((uint64_t)1 << 63),
> >                             ((uint64_t)1 << 63) + ((uint64_t)1 << 63) - 1 };
> > -     int i = 0;
> > -     for (i = 0; i < ARRAY_SIZE(inputs); i++) {
> > +
> > +     for (size_t i = 0; i < ARRAY_SIZE(inputs); i++) {
> >               uint8_t dest[10];
> >
> >               struct string_view out = {
> > @@ -55,29 +51,26 @@ static void test_varint_roundtrip(void)
> >               int n = put_var_int(&out, in);
> >               uint64_t got = 0;
> >
> > -             EXPECT(n > 0);
> > +             check_int(n, >, 0);
> >               out.len = n;
> >               n = get_var_int(&got, &out);
> > -             EXPECT(n > 0);
> > +             check_int(n, >, 0);
> >
> > -             EXPECT(got == in);
> > +             check_int(got, ==, in);
> >       }
> >  }
> >
> >  static void set_hash(uint8_t *h, int j)
> >  {
> > -     int i = 0;
> > -     for (i = 0; i < hash_size(GIT_SHA1_FORMAT_ID); i++) {
> > +     for (int i = 0; i < hash_size(GIT_SHA1_FORMAT_ID); i++)
> >               h[i] = (j >> i) & 0xff;
> > -     }
> >  }
> >
> >  static void test_reftable_ref_record_roundtrip(void)
> >  {
> >       struct strbuf scratch = STRBUF_INIT;
> > -     int i = 0;
> >
> > -     for (i = REFTABLE_REF_DELETION; i < REFTABLE_NR_REF_VALUETYPES; i++) {
> > +     for (int i = REFTABLE_REF_DELETION; i < REFTABLE_NR_REF_VALUETYPES; i++) {
> >               struct reftable_record in = {
> >                       .type = BLOCK_TYPE_REF,
> >               };
> > @@ -109,17 +102,17 @@ static void test_reftable_ref_record_roundtrip(void)
> >
> >               test_copy(&in);
> >
> > -             EXPECT(reftable_record_val_type(&in) == i);
> > +             check_int(reftable_record_val_type(&in), ==, i);
> >
> >               reftable_record_key(&in, &key);
> >               n = reftable_record_encode(&in, dest, GIT_SHA1_RAWSZ);
> > -             EXPECT(n > 0);
> > +             check_int(n, >, 0);
> >
> >               /* decode into a non-zero reftable_record to test for leaks. */
> >               m = reftable_record_decode(&out, key, i, dest, GIT_SHA1_RAWSZ, &scratch);
> > -             EXPECT(n == m);
> > +             check_int(n, ==, m);
> >
> > -             EXPECT(reftable_ref_record_equal(&in.u.ref, &out.u.ref,
> > +             check(reftable_ref_record_equal(&in.u.ref, &out.u.ref,
> >                                                GIT_SHA1_RAWSZ));
> >               reftable_record_release(&in);
> >
> > @@ -143,16 +136,15 @@ static void test_reftable_log_record_equal(void)
> >               }
> >       };
> >
> > -     EXPECT(!reftable_log_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
> > +     check(!reftable_log_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
> >       in[1].update_index = in[0].update_index;
> > -     EXPECT(reftable_log_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
> > +     check(reftable_log_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
> >       reftable_log_record_release(&in[0]);
> >       reftable_log_record_release(&in[1]);
> >  }
> >
> >  static void test_reftable_log_record_roundtrip(void)
> >  {
> > -     int i;
> >       struct reftable_log_record in[] = {
> >               {
> >                       .refname = xstrdup("refs/heads/master"),
> > @@ -180,12 +172,12 @@ static void test_reftable_log_record_roundtrip(void)
> >               }
> >       };
> >       struct strbuf scratch = STRBUF_INIT;
> > +     set_hash(in[0].value.update.new_hash, 1);
> > +     set_hash(in[0].value.update.old_hash, 2);
> > +     set_hash(in[2].value.update.new_hash, 3);
> > +     set_hash(in[2].value.update.old_hash, 4);
> >
> > -     set_test_hash(in[0].value.update.new_hash, 1);
> > -     set_test_hash(in[0].value.update.old_hash, 2);
> > -     set_test_hash(in[2].value.update.new_hash, 3);
> > -     set_test_hash(in[2].value.update.old_hash, 4);
> > -     for (i = 0; i < ARRAY_SIZE(in); i++) {
> > +     for (size_t i = 0; i < ARRAY_SIZE(in); i++) {
> >               struct reftable_record rec = { .type = BLOCK_TYPE_LOG };
> >               struct strbuf key = STRBUF_INIT;
> >               uint8_t buffer[1024] = { 0 };
> > @@ -217,13 +209,13 @@ static void test_reftable_log_record_roundtrip(void)
> >               reftable_record_key(&rec, &key);
> >
> >               n = reftable_record_encode(&rec, dest, GIT_SHA1_RAWSZ);
> > -             EXPECT(n >= 0);
> > +             check_int(n, >=, 0);
> >               valtype = reftable_record_val_type(&rec);
> >               m = reftable_record_decode(&out, key, valtype, dest,
> >                                          GIT_SHA1_RAWSZ, &scratch);
> > -             EXPECT(n == m);
> > +             check_int(n, ==, m);
> >
> > -             EXPECT(reftable_log_record_equal(&in[i], &out.u.log,
> > +             check(reftable_log_record_equal(&in[i], &out.u.log,
> >                                                GIT_SHA1_RAWSZ));
> >               reftable_log_record_release(&in[i]);
> >               strbuf_release(&key);
> > @@ -252,14 +244,14 @@ static void test_key_roundtrip(void)
> >       strbuf_addstr(&key, "refs/tags/bla");
> >       extra = 6;
> >       n = reftable_encode_key(&restart, dest, last_key, key, extra);
> > -     EXPECT(!restart);
> > -     EXPECT(n > 0);
> > +     check(!restart);
> > +     check_int(n, >, 0);
> >
> >       strbuf_addstr(&roundtrip, "refs/heads/master");
> >       m = reftable_decode_key(&roundtrip, &rt_extra, dest);
> > -     EXPECT(n == m);
> > -     EXPECT(0 == strbuf_cmp(&key, &roundtrip));
> > -     EXPECT(rt_extra == extra);
> > +     check_int(n, ==, m);
> > +     check(!strbuf_cmp(&key, &roundtrip));
> > +     check_int(rt_extra, ==, extra);
> >
> >       strbuf_release(&last_key);
> >       strbuf_release(&key);
> > @@ -289,9 +281,8 @@ static void test_reftable_obj_record_roundtrip(void)
> >               },
> >       };
> >       struct strbuf scratch = STRBUF_INIT;
> > -     int i = 0;
> >
> > -     for (i = 0; i < ARRAY_SIZE(recs); i++) {
> > +     for (size_t i = 0; i < ARRAY_SIZE(recs); i++) {
> >               uint8_t buffer[1024] = { 0 };
> >               struct string_view dest = {
> >                       .buf = buffer,
> > @@ -311,13 +302,13 @@ static void test_reftable_obj_record_roundtrip(void)
> >               test_copy(&in);
> >               reftable_record_key(&in, &key);
> >               n = reftable_record_encode(&in, dest, GIT_SHA1_RAWSZ);
> > -             EXPECT(n > 0);
> > +             check_int(n, >, 0);
> >               extra = reftable_record_val_type(&in);
> >               m = reftable_record_decode(&out, key, extra, dest,
> >                                          GIT_SHA1_RAWSZ, &scratch);
> > -             EXPECT(n == m);
> > +             check_int(n, ==, m);
> >
> > -             EXPECT(reftable_record_equal(&in, &out, GIT_SHA1_RAWSZ));
> > +             check(reftable_record_equal(&in, &out, GIT_SHA1_RAWSZ));
> >               strbuf_release(&key);
> >               reftable_record_release(&out);
> >       }
> > @@ -352,16 +343,16 @@ static void test_reftable_index_record_roundtrip(void)
> >       reftable_record_key(&in, &key);
> >       test_copy(&in);
> >
> > -     EXPECT(0 == strbuf_cmp(&key, &in.u.idx.last_key));
> > +     check(!strbuf_cmp(&key, &in.u.idx.last_key));
> >       n = reftable_record_encode(&in, dest, GIT_SHA1_RAWSZ);
> > -     EXPECT(n > 0);
> > +     check_int(n, >, 0);
> >
> >       extra = reftable_record_val_type(&in);
> >       m = reftable_record_decode(&out, key, extra, dest, GIT_SHA1_RAWSZ,
> >                                  &scratch);
> > -     EXPECT(m == n);
> > +     check_int(m, ==, n);
> >
> > -     EXPECT(reftable_record_equal(&in, &out, GIT_SHA1_RAWSZ));
> > +     check(reftable_record_equal(&in, &out, GIT_SHA1_RAWSZ));
> >
> >       reftable_record_release(&out);
> >       strbuf_release(&key);
> > @@ -369,14 +360,15 @@ static void test_reftable_index_record_roundtrip(void)
> >       strbuf_release(&in.u.idx.last_key);
> >  }
> >
> > -int record_test_main(int argc, const char *argv[])
> > +int cmd_main(int argc, const char *argv[])
> >  {
> > -     RUN_TEST(test_reftable_log_record_equal);
> > -     RUN_TEST(test_reftable_log_record_roundtrip);
> > -     RUN_TEST(test_reftable_ref_record_roundtrip);
> > -     RUN_TEST(test_varint_roundtrip);
> > -     RUN_TEST(test_key_roundtrip);
> > -     RUN_TEST(test_reftable_obj_record_roundtrip);
> > -     RUN_TEST(test_reftable_index_record_roundtrip);
> > -     return 0;
> > +     TEST(test_reftable_log_record_equal(), "reftable_log_record_equal works");
> > +     TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
> > +     TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
> > +     TEST(test_varint_roundtrip(), "put_var_int and get_var_int work");
> > +     TEST(test_key_roundtrip(), "reftable_encode_key and reftable_decode_key work");
> > +     TEST(test_reftable_obj_record_roundtrip(), "record operations work on obj record");
> > +     TEST(test_reftable_index_record_roundtrip(), "record operations work on index record");
> > +
>
> All other tests in the 'unit-tests/' folder use a `t_<name>` format for
> the tests. Here we seem to diverge and use a `test_<name>` format. I
> think the best outcome would be some documentation around this, but it
> would still be nice if we follow this pattern nevertheless.
>
> > +     return test_done();
> >  }
> > --
> > 2.45.2.404.g9eaef5822c
