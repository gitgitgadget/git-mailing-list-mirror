Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE4A17FAD5
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 11:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719402769; cv=none; b=Rl3Rlbx+w1wWQq0xGC0E02F4blmmhdT1XsBlfgZSK9+GPrnlADyDJkQaWTTqz2aGCYy8koc1eG04RiAMMKl5pPAD2wQ94wy1ERuC5YWH+SQH7ufqe64DjGoFn2NQ6ulStd9zkDa0FRBICCT2yABMSkgZDoa+LAjL0PqbyHdS2TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719402769; c=relaxed/simple;
	bh=i0eoUzV1mYbkuT0Z4sfxLHmEKlgnPO878bTcG2cmNs4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ij+H0VT06JlFTiMNyxsMgj3orAp6Nc+6uVXC5ojbK4Vz9nsndXq29frDWCo3T0u5SPWlP/6ZWWXJelLj+WugTtyhSS9k/oNb7PtRKt5KGaOmnaUyd9E5RLQyunjqZXVwRdTGA0fo/bRWwEewccaXARQgYQAcoL8F+Cd6z1OSbEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5BMrbfx; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5BMrbfx"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-25980546baeso3138954fac.2
        for <git@vger.kernel.org>; Wed, 26 Jun 2024 04:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719402766; x=1720007566; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=F4qXfE+jTvrtCHHozDlX87RFWm1myD1/gGhgy/L8m4I=;
        b=F5BMrbfx3fYtKwPkq962SWvC0ZGxsLXwU2WHHzw8OkWbnwnxB6LvLoEz5t4ws2xwjF
         i19L0KCtMf6FBp1qLAHyMnW/MbHxn6+YWU9KLkHa1a84aEyhd9/Y31JZ0SdCPMNVVHoj
         1+osRmoFjRnziYtvCrBaAoOL0AtzEf2F6gCJoXtUytLMPUZYc0JXD9Rp1kNUlO/xCsKL
         r6tPAIcsaDZ86lsCmTULTYXrmVTVozSN86OJmFF0hVcP614mZmvFiZkCSEHT8PZQej3L
         AS4iV/0ZGPvXu6lnQ18lou8/IgfTAJJHJgLE0CAs9dg+6HOGazQCCPgVGVYzpZXOatQL
         KiVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719402766; x=1720007566;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F4qXfE+jTvrtCHHozDlX87RFWm1myD1/gGhgy/L8m4I=;
        b=gIMKcnABgXFKmqTtx15jH3dQ8KmPJbO02gsvHI9mvd6GKMVvo2n+MBjQhjLXmBwsg/
         BRMMjNQFRdIZqExgaTle56v0Wck6USUcPgP5MGaHh3tUPSIL4B+xVKr29FbpiWxaZOfl
         ZGF6kbw1FCDxiD98kB7Q9AibrqolVwc5Vla4ql5JHI4Z5XQYMru5zsjoUoYUaQ1YRqCA
         j8UuUJDK5C1TiCLRKRh5JenI+mYgEzJbWVUHMSUBCRQ2E/0mQMLf5I9E8tyu68Rccl+T
         gswHGAMZul5KMv2eGRV5yKzuozNOI4J3LVuMQiAkyz6OZhBv4R1RvksRX0QZmX4u8t5O
         FeHQ==
X-Gm-Message-State: AOJu0Yw5pcEcNcPa1H8BXhM2UDRNkAJc8ldVjXmVz4QTLwONGDSiDkNP
	kHE2b8sA+NTnRpXVlggeSQhdHVAgWyvUB2av7EBj96G1Hjb1+ll/8cvdtw9+Lb9iL/FJgbQsajH
	FI6fjwVK7hlO1McTpcLws3FcbOq0=
X-Google-Smtp-Source: AGHT+IGlAySMeez9Vi2WZJ9IUkief0GM5cCevrRSUwHpyjQXm2rIE2Dmi+30zFEN4E80ccuBJPMt+Mtq6OerVC2f20g=
X-Received: by 2002:a05:6870:2011:b0:24f:c892:d02b with SMTP id
 586e51a60fabf-25cfc97a1fbmr11844972fac.0.1719402766368; Wed, 26 Jun 2024
 04:52:46 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Jun 2024 07:52:45 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CA+J6zkSymKxSRnAVx7oeAoPpMxrRsVRPGO-X0tVbc0VtKOe3ig@mail.gmail.com>
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
 <20240621115708.3626-1-chandrapratap3519@gmail.com> <20240621115708.3626-2-chandrapratap3519@gmail.com>
 <CAOLa=ZSmnMLMoKKWMiM7M4Jw8CJ0Jvrs0oMLy18FHaLv_6s6yA@mail.gmail.com> <CA+J6zkSymKxSRnAVx7oeAoPpMxrRsVRPGO-X0tVbc0VtKOe3ig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 26 Jun 2024 07:52:45 -0400
Message-ID: <CAOLa=ZQG4S6oJ_YTvc9LjV9C+THKcr_4xMsrOB2Mw6CZYfK9GA@mail.gmail.com>
Subject: Re: [PATCH 01/11] t: move reftable/record_test.c to the unit testing framework
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, karthik188@gmail.com, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000001da367061bc9a742"

--0000000000001da367061bc9a742
Content-Type: text/plain; charset="UTF-8"

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> On Tue, 25 Jun 2024 at 13:56, Karthik Nayak <karthik.188@gmail.com> wrote:
>>
>> Chandra Pratap <chandrapratap3519@gmail.com> writes:
>>
>> > reftable/record_test.c exercises the functions defined in
>> > reftable/record.{c, h}. Migrate reftable/record_test.c to the
>> > unit testing framework. Migration involves refactoring the tests
>> > to use the unit testing framework instead of reftable's test
>> > framework.
>> > While at it, change the type of index variable 'i' to 'size_t'
>> > from 'int'. This is because 'i' is used in comparison against
>> > 'ARRAY_SIZE(x)' which is of type 'size_t'.
>> >
>> > Also, use set_hash() which is defined locally in the test file
>> > instead of set_test_hash() which is defined by
>> > reftable/test_framework.{c, h}. This is fine to do as both these
>> > functions are similarly implemented, and
>> > reftable/test_framework.{c, h} is not #included in the ported test.
>> >
>> > Mentored-by: Patrick Steinhardt <ps@pks.im>
>> > Mentored-by: Christian Couder <chriscool@tuxfamily.org>
>> > Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
>> > ---
>> >  Makefile                                      |   2 +-
>> >  t/helper/test-reftable.c                      |   1 -
>> >  .../unit-tests/t-reftable-record.c            | 106 ++++++++----------
>> >  3 files changed, 50 insertions(+), 59 deletions(-)
>> >  rename reftable/record_test.c => t/unit-tests/t-reftable-record.c (77%)
>> >
>> > diff --git a/Makefile b/Makefile
>> > index f25b2e80a1..def3700b4d 100644
>> > --- a/Makefile
>> > +++ b/Makefile
>> > @@ -1338,6 +1338,7 @@ UNIT_TEST_PROGRAMS += t-hash
>> >  UNIT_TEST_PROGRAMS += t-mem-pool
>> >  UNIT_TEST_PROGRAMS += t-prio-queue
>> >  UNIT_TEST_PROGRAMS += t-reftable-basics
>> > +UNIT_TEST_PROGRAMS += t-reftable-record
>> >  UNIT_TEST_PROGRAMS += t-strbuf
>> >  UNIT_TEST_PROGRAMS += t-strcmp-offset
>> >  UNIT_TEST_PROGRAMS += t-strvec
>> > @@ -2678,7 +2679,6 @@ REFTABLE_TEST_OBJS += reftable/block_test.o
>> >  REFTABLE_TEST_OBJS += reftable/dump.o
>> >  REFTABLE_TEST_OBJS += reftable/merged_test.o
>> >  REFTABLE_TEST_OBJS += reftable/pq_test.o
>> > -REFTABLE_TEST_OBJS += reftable/record_test.o
>> >  REFTABLE_TEST_OBJS += reftable/readwrite_test.o
>> >  REFTABLE_TEST_OBJS += reftable/stack_test.o
>> >  REFTABLE_TEST_OBJS += reftable/test_framework.o
>> > diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
>> > index 9160bc5da6..aa6538a8da 100644
>> > --- a/t/helper/test-reftable.c
>> > +++ b/t/helper/test-reftable.c
>> > @@ -5,7 +5,6 @@
>> >  int cmd__reftable(int argc, const char **argv)
>> >  {
>> >       /* test from simple to complex. */
>> > -     record_test_main(argc, argv);
>> >       block_test_main(argc, argv);
>> >       tree_test_main(argc, argv);
>> >       pq_test_main(argc, argv);
>> > diff --git a/reftable/record_test.c b/t/unit-tests/t-reftable-record.c
>> > similarity index 77%
>> > rename from reftable/record_test.c
>> > rename to t/unit-tests/t-reftable-record.c
>> > index 58290bdba3..1b357e6c7f 100644
>> > --- a/reftable/record_test.c
>> > +++ b/t/unit-tests/t-reftable-record.c
>> > @@ -6,13 +6,9 @@
>> >    https://developers.google.com/open-source/licenses/bsd
>> >  */
>> >
>> > -#include "record.h"
>> > -
>> > -#include "system.h"
>> > -#include "basics.h"
>> > -#include "constants.h"
>> > -#include "test_framework.h"
>> > -#include "reftable-tests.h"
>> > +#include "test-lib.h"
>> > +#include "reftable/constants.h"
>> > +#include "reftable/record.h"
>> >
>> >  static void test_copy(struct reftable_record *rec)
>> >  {
>> > @@ -24,9 +20,9 @@ static void test_copy(struct reftable_record *rec)
>> >       reftable_record_copy_from(&copy, rec, GIT_SHA1_RAWSZ);
>> >       /* do it twice to catch memory leaks */
>>
>> I'm curious why we do this, and if it is still needed. The original
>> commit (e303bf22f reftable: (de)serialization for the polymorphic record
>> type) doesn't mention any particular reasoning.
>
> Yeah, I was confused about this as well. I asked Patrick about it some time
> ago and it seems like he had no clue about it either:
> https://gitlab.slack.com/archives/C071PDKNCHM/p1717479205788209
>

Just to note, this is an internal GitLab link and not accessible to
others on the list.

But to summarize, seems like we're not sure why this was added. CC'ing
Han-Wen here incase he remembers the intent.

> Should we get rid of this after all?

The best solution would be to understand its reasoning and incorporate
that, but otherwise its best to remove it. We do have CI pipelines to
capture leaks in a general sense.

>> >       reftable_record_copy_from(&copy, rec, GIT_SHA1_RAWSZ);
>> > -     EXPECT(reftable_record_equal(rec, &copy, GIT_SHA1_RAWSZ));
>> > +     check(reftable_record_equal(rec, &copy, GIT_SHA1_RAWSZ));
>> >
>> > -     puts("testing print coverage:\n");
>> > +     test_msg("testing print coverage:");
>> >       reftable_record_print(&copy, GIT_SHA1_RAWSZ);
>> >
>>
>> This prints for any test that uses this function. As I see from the
>> current usage of the testing library, we only print debug information
>> when we encounter something unexpected.
>>
>> This also clogs up the unit-test's output. So I would remove this from
>> here.
>
> That's true, but that would also mean the print functions are no longer
> exercised. Is that a fine tradeoff?
>

I don't see it this way. Just exercising the function doesn't test it in
any way. Since the function just prints to stdout without an option to
pick any other file descriptor, there is no way to test it currently
either.

On the contrary if no one is using the function, perhaps we can even
remove it.

[snip]

--0000000000001da367061bc9a742
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e25a3255c13592f9_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aOEFRc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md0I3Qy8wUThGeGhzTmJpOW45OWNya0NXVW1LUWFDdgpTcElsMW1yTzhw
NXBqUFRXS1IyRDZDa2tpYlhlWDM5Q2VMSWtIQWhBZlV5SVNMNlhTNWJwcnBLVW5FWktDRDFuCnBX
UE9BRjhSL01QR3J0WWVtRXF6NjlONnhaa2pSNEZPMUJwQjRJS1JNYjFzSGJFNGx5VHZyZHNBQnN3
bzdIK08KdFN0UW5QQzhOQkMwZlNldTZMcCtLODhnQ0haVHFpVXlrcGM0bHNxUE01a2Y0Sm9vRHhj
YjVDcmhFYlU1b0RZSwo3WW9uV0wxcFppZTJ3dS9GWG04bHJzZkRhSFdBb3NNOUVVNzkvVXlBazBU
UVNvMSt5RGsrcGg4QVBhb3RhRG9KCmpYVFdYR0wvTG45aTFIYUtJWGNHdjlKQW5JRHZJa2NjUFYv
SlFoMUIvUTl4RlFaK09jOTFQQjJDM282NU9NTVEKVnZnbG1ndVk2RlljYmpiM1lrSldnZi9ETlBV
K3ZjY2c0cmVlcnZYcWpUWGd4U1lCemVkTVBIK1MxZFdMdmVkNgp0WnBoYk02NXdtQXFkazRZejRE
eVpxTlNTS0F0YldoOThTL012bXJnWWcrUzRqTmdmbWJ0Qy9jQVJzOFc3dGNhCm0xVVorNEEyejls
NXBucm1YV29Ma0p6blV3dGIrRDZRKzlDR2hPbz0KPXFXbjIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001da367061bc9a742--
