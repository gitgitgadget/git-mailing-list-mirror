Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF81A955
	for <git@vger.kernel.org>; Fri,  5 Jul 2024 17:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720201246; cv=none; b=sEqbveeqEN4cVLljUhfeUxqbcnUs8WDc3yngrxrb1OMvrdk4fe910NwwdbxFr0DwuqX4NB5A5K3+ElLRF3DokLDljLNx1iQgcXfd9GcuRICMRQitiBYhPGMdFwrlHA+K46dJqkZgmJBrC5pfCn2phCDWZhoPO5PmAUN9NPUJBrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720201246; c=relaxed/simple;
	bh=cXzW01ZACfIPcpzxqhuUL6cld/F8Z4GuZNufckfpXsg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mcjEXrZHEyrjePRkZsasiIHmKqWwFxTncgtcM9vHyTf2RYCKXjaTSMWI7HvtUAdvsXVTynYyiNadK1ItYss6t4s+bHhNJPKjwmaWR3OQZchgNy0pFdt21LMFbSX15edzfuWDu0SoeZKQiy/ZYWKqlNU/qchNtA0+Fzr6LKTlG4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0WGRIH4; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0WGRIH4"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c9cc681e4fso928118b6e.0
        for <git@vger.kernel.org>; Fri, 05 Jul 2024 10:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720201244; x=1720806044; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=puXwYSZoR2w+ol5lggoiTrj3itLHauGH/BUoCO3zbog=;
        b=l0WGRIH4azFwpDTeMnoIxi+g28Rx2tIm+I0o/MV7j6GgzmKB/eYlUdX02foKgVC51h
         0LQ5b3kDee20DClBeNO/bUxet69RGWh5vXcIBQtf1RM1Mc6eWoOLSywEFldQV7RWHmiJ
         sfQHiEkDVxbCIcx9F/k8JBSEiJGbMOOXx9/dhIjzbYj9C9pdng3EXkiMPV5cYkrQIUzp
         XUoqS966TAYOp9vN+gFVlKNIBCfAStmlELoWQfkTkB3xNrJAsOkmTcmK9urqLlKZBqvi
         /+YTAVxpbpi707tFCOPiw+ivqeD2qiLr8+dv3dd1uO7QNTbztKZtgyZDhLuP5+Bnr4jd
         hUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720201244; x=1720806044;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=puXwYSZoR2w+ol5lggoiTrj3itLHauGH/BUoCO3zbog=;
        b=iwhMR7GGLJNA1hFNaZ1g9MSLCYN0sBm/+mIJtb057JczDYsAhVtibkhQvA7aB6G7Qo
         rcO9Q9CxIifezVZytvJuPXmORBes9IP7BPnkLgVryZyv1ZW0J0NhlaKGhbmcaugkWND7
         VvxrdjPXa31O1RPyjX4suDke1sgq7uyMGJ9FtTWLItNpF/ByWKKeqkRDoig3kW/B/CXa
         Y8XJ9Jmntcoom6oT0MuV8qMY/OHPxgv8RwbDo1EoasCEFLzOSNkm76lnNqB8s2Wtizyv
         AzHPoTikIxePl4d1zP5BiJ19K0hfn75A0oiP8OdcUdmFFE0nW7ORK6qegf+J19RV3SUH
         1dcg==
X-Forwarded-Encrypted: i=1; AJvYcCVTSrRuabRAAFIDXJhflWG+8upI+Whc+Fkk7pexpEc3ri/UDNDqrYU4EIYFmro51oudLy/s8Rr52+M6vtamGWkhcDjE
X-Gm-Message-State: AOJu0Yx93Nxmr1dnNE3OuQ/VBs6/tYc3jTxwCrMMlqkbIWSS1pqI+HzA
	tis0RJNPiorJ9xkS+Ls8RI3dZPeRzqGLka4OWsMD4YyrHsDF8NGLpgks8QmchSAglW4E3gHVbnu
	0INl/tkp8YadqedHegNUgRY2EBFBhG1dI
X-Google-Smtp-Source: AGHT+IE+6ntDytIHwx8zY0+3j1Zl2x4xyq2vCtfviDRme4HToFcI0gfJBgsCVan1r2WtxEWmq8RwPiTqcV224VPeQh0=
X-Received: by 2002:a05:6870:9a14:b0:259:cdf1:b8af with SMTP id
 586e51a60fabf-25e2beaff81mr5260923fac.46.1720201243527; Fri, 05 Jul 2024
 10:40:43 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 5 Jul 2024 13:40:42 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240703171131.3929-2-chandrapratap3519@gmail.com>
References: <20240703171131.3929-1-chandrapratap3519@gmail.com> <20240703171131.3929-2-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 5 Jul 2024 13:40:42 -0400
Message-ID: <CAOLa=ZSkfTCVgexzN=UQf-qzkEdfunp6YCmiqcf8gsxCS9aNvw@mail.gmail.com>
Subject: Re: [PATCH 1/5] t: move reftable/merged_test.c to the unit testing framework
To: Chandra Pratap <chandrapratap3519@gmail.com>, git@vger.kernel.org
Cc: chriscool@tuxfamily.org
Content-Type: multipart/mixed; boundary="00000000000010279e061c839082"

--00000000000010279e061c839082
Content-Type: text/plain; charset="UTF-8"

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> reftable/merged_test.c exercises the functions defined in
> reftable/merged.{c, h}. Migrate reftable/merged_test.c to the unit
> testing framework. Migration involves refactoring the tests
> to use the unit testing framework instead of reftable's test
> framework and renaming the tests according to unit-tests' naming
> conventions.
>
> Also, move strbuf_add_void() and noop_flush() from
> reftable/test_framework.c to the ported test. This is because
> both these functions are used in the merged tests and
> reftable/test_framework.{c, h} is not #included in the ported test.
>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---
>  Makefile                                      |   2 +-
>  t/helper/test-reftable.c                      |   1 -
>  .../unit-tests/t-reftable-merged.c            | 112 +++++++++---------
>  3 files changed, 60 insertions(+), 55 deletions(-)
>  rename reftable/merged_test.c => t/unit-tests/t-reftable-merged.c (84%)
>
> diff --git a/Makefile b/Makefile
> index 3eab701b10..e5d1b53991 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1340,6 +1340,7 @@ UNIT_TEST_PROGRAMS += t-mem-pool
>  UNIT_TEST_PROGRAMS += t-oidtree
>  UNIT_TEST_PROGRAMS += t-prio-queue
>  UNIT_TEST_PROGRAMS += t-reftable-basics
> +UNIT_TEST_PROGRAMS += t-reftable-merged
>  UNIT_TEST_PROGRAMS += t-strbuf
>  UNIT_TEST_PROGRAMS += t-strcmp-offset
>  UNIT_TEST_PROGRAMS += t-strvec
> @@ -2679,7 +2680,6 @@ REFTABLE_OBJS += reftable/writer.o
>
>  REFTABLE_TEST_OBJS += reftable/block_test.o
>  REFTABLE_TEST_OBJS += reftable/dump.o
> -REFTABLE_TEST_OBJS += reftable/merged_test.o
>  REFTABLE_TEST_OBJS += reftable/pq_test.o
>  REFTABLE_TEST_OBJS += reftable/record_test.o
>  REFTABLE_TEST_OBJS += reftable/readwrite_test.o
> diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
> index 9160bc5da6..0357718fa8 100644
> --- a/t/helper/test-reftable.c
> +++ b/t/helper/test-reftable.c
> @@ -10,7 +10,6 @@ int cmd__reftable(int argc, const char **argv)
>  	tree_test_main(argc, argv);
>  	pq_test_main(argc, argv);
>  	readwrite_test_main(argc, argv);
> -	merged_test_main(argc, argv);
>  	stack_test_main(argc, argv);
>  	return 0;
>  }
> diff --git a/reftable/merged_test.c b/t/unit-tests/t-reftable-merged.c
> similarity index 84%
> rename from reftable/merged_test.c
> rename to t/unit-tests/t-reftable-merged.c
> index a9d6661c13..1718489f06 100644
> --- a/reftable/merged_test.c
> +++ b/t/unit-tests/t-reftable-merged.c
> @@ -6,20 +6,25 @@ license that can be found in the LICENSE file or at
>  https://developers.google.com/open-source/licenses/bsd
>  */
>
> -#include "merged.h"
> -
> -#include "system.h"
> +#include "test-lib.h"
> +#include "reftable/blocksource.h"
> +#include "reftable/constants.h"
> +#include "reftable/merged.h"
> +#include "reftable/reader.h"
> +#include "reftable/reftable-generic.h"
> +#include "reftable/reftable-merged.h"
> +#include "reftable/reftable-writer.h"
> +
> +static ssize_t strbuf_add_void(void *b, const void *data, size_t sz)
> +{
> +	strbuf_add(b, data, sz);
> +	return sz;
> +}
>
> -#include "basics.h"
> -#include "blocksource.h"
> -#include "constants.h"
> -#include "reader.h"
> -#include "record.h"
> -#include "test_framework.h"
> -#include "reftable-merged.h"
> -#include "reftable-tests.h"
> -#include "reftable-generic.h"
> -#include "reftable-writer.h"
> +static int noop_flush(void *arg)
> +{
> +	return 0;
> +}
>
>  static void write_test_table(struct strbuf *buf,
>  			     struct reftable_ref_record refs[], int n)
> @@ -49,12 +54,12 @@ static void write_test_table(struct strbuf *buf,
>  	for (i = 0; i < n; i++) {
>  		uint64_t before = refs[i].update_index;
>  		int n = reftable_writer_add_ref(w, &refs[i]);
> -		EXPECT(n == 0);
> -		EXPECT(before == refs[i].update_index);
> +		check_int(n, ==, 0);
> +		check_int(before, ==, refs[i].update_index);
>  	}
>
>  	err = reftable_writer_close(w);
> -	EXPECT_ERR(err);
> +	check(!err);
>

Nit: Couldn't we just do `check(!reftable_writer_close(w))` here and in
a lot of places below?

>  	reftable_writer_free(w);
>  }
> @@ -76,11 +81,11 @@ static void write_test_log_table(struct strbuf *buf,
>
>  	for (i = 0; i < n; i++) {
>  		int err = reftable_writer_add_log(w, &logs[i]);
> -		EXPECT_ERR(err);
> +		check(!err);
>  	}
>
>  	err = reftable_writer_close(w);
> -	EXPECT_ERR(err);
> +	check(!err);
>
>  	reftable_writer_free(w);
>  }
> @@ -105,12 +110,12 @@ merged_table_from_records(struct reftable_ref_record **refs,
>
>  		err = reftable_new_reader(&(*readers)[i], &(*source)[i],
>  					  "name");
> -		EXPECT_ERR(err);
> +		check(!err);
>  		reftable_table_from_reader(&tabs[i], (*readers)[i]);
>  	}
>
>  	err = reftable_new_merged_table(&mt, tabs, n, GIT_SHA1_FORMAT_ID);
> -	EXPECT_ERR(err);
> +	check(!err);
>  	return mt;
>  }
>
> @@ -122,7 +127,7 @@ static void readers_destroy(struct reftable_reader **readers, size_t n)
>  	reftable_free(readers);
>  }
>
> -static void test_merged_between(void)
> +static void t_merged_between(void)
>  {
>  	struct reftable_ref_record r1[] = { {
>  		.refname = (char *) "b",
> @@ -150,11 +155,11 @@ static void test_merged_between(void)
>
>  	merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
>  	err = reftable_iterator_seek_ref(&it, "a");
> -	EXPECT_ERR(err);
> +	check(!err);
>
>  	err = reftable_iterator_next_ref(&it, &ref);
> -	EXPECT_ERR(err);
> -	EXPECT(ref.update_index == 2);
> +	check(!err);
> +	check_int(ref.update_index, ==, 2);
>  	reftable_ref_record_release(&ref);
>  	reftable_iterator_destroy(&it);
>  	readers_destroy(readers, 2);
> @@ -165,7 +170,7 @@ static void test_merged_between(void)
>  	reftable_free(bs);
>  }
>
> -static void test_merged(void)
> +static void t_merged(void)
>  {
>  	struct reftable_ref_record r1[] = {
>  		{
> @@ -230,9 +235,9 @@ static void test_merged(void)
>
>  	merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
>  	err = reftable_iterator_seek_ref(&it, "a");
> -	EXPECT_ERR(err);
> -	EXPECT(reftable_merged_table_hash_id(mt) == GIT_SHA1_FORMAT_ID);
> -	EXPECT(reftable_merged_table_min_update_index(mt) == 1);
> +	check(!err);
> +	check_int(reftable_merged_table_hash_id(mt), ==, GIT_SHA1_FORMAT_ID);
> +	check_int(reftable_merged_table_min_update_index(mt), ==, 1);
>
>  	while (len < 100) { /* cap loops/recursion. */
>  		struct reftable_ref_record ref = { NULL };
> @@ -245,9 +250,9 @@ static void test_merged(void)
>  	}
>  	reftable_iterator_destroy(&it);
>
> -	EXPECT(ARRAY_SIZE(want) == len);
> +	check_int(ARRAY_SIZE(want), ==, len);
>  	for (i = 0; i < len; i++) {
> -		EXPECT(reftable_ref_record_equal(want[i], &out[i],
> +		check(reftable_ref_record_equal(want[i], &out[i],
>  						 GIT_SHA1_RAWSZ));
>  	}
>  	for (i = 0; i < len; i++) {
> @@ -283,16 +288,16 @@ merged_table_from_log_records(struct reftable_log_record **logs,
>
>  		err = reftable_new_reader(&(*readers)[i], &(*source)[i],
>  					  "name");
> -		EXPECT_ERR(err);
> +		check(!err);
>  		reftable_table_from_reader(&tabs[i], (*readers)[i]);
>  	}
>
>  	err = reftable_new_merged_table(&mt, tabs, n, GIT_SHA1_FORMAT_ID);
> -	EXPECT_ERR(err);
> +	check(!err);
>  	return mt;
>  }
>
> -static void test_merged_logs(void)
> +static void t_merged_logs(void)
>  {
>  	struct reftable_log_record r1[] = {
>  		{
> @@ -362,9 +367,9 @@ static void test_merged_logs(void)
>
>  	merged_table_init_iter(mt, &it, BLOCK_TYPE_LOG);
>  	err = reftable_iterator_seek_log(&it, "a");
> -	EXPECT_ERR(err);
> -	EXPECT(reftable_merged_table_hash_id(mt) == GIT_SHA1_FORMAT_ID);
> -	EXPECT(reftable_merged_table_min_update_index(mt) == 1);
> +	check(!err);
> +	check_int(reftable_merged_table_hash_id(mt), ==, GIT_SHA1_FORMAT_ID);
> +	check_int(reftable_merged_table_min_update_index(mt), ==, 1);
>
>  	while (len < 100) { /* cap loops/recursion. */
>  		struct reftable_log_record log = { NULL };
> @@ -377,19 +382,19 @@ static void test_merged_logs(void)
>  	}
>  	reftable_iterator_destroy(&it);
>
> -	EXPECT(ARRAY_SIZE(want) == len);
> +	check_int(ARRAY_SIZE(want), ==, len);
>  	for (i = 0; i < len; i++) {
> -		EXPECT(reftable_log_record_equal(want[i], &out[i],
> +		check(reftable_log_record_equal(want[i], &out[i],
>  						 GIT_SHA1_RAWSZ));
>  	}
>
>  	merged_table_init_iter(mt, &it, BLOCK_TYPE_LOG);
>  	err = reftable_iterator_seek_log_at(&it, "a", 2);
> -	EXPECT_ERR(err);
> +	check(!err);
>  	reftable_log_record_release(&out[0]);
>  	err = reftable_iterator_next_log(&it, &out[0]);
> -	EXPECT_ERR(err);
> -	EXPECT(reftable_log_record_equal(&out[0], &r3[0], GIT_SHA1_RAWSZ));
> +	check(!err);
> +	check(reftable_log_record_equal(&out[0], &r3[0], GIT_SHA1_RAWSZ));
>  	reftable_iterator_destroy(&it);
>
>  	for (i = 0; i < len; i++) {
> @@ -405,7 +410,7 @@ static void test_merged_logs(void)
>  	reftable_free(bs);
>  }
>
> -static void test_default_write_opts(void)
> +static void t_default_write_opts(void)
>  {
>  	struct reftable_write_options opts = { 0 };
>  	struct strbuf buf = STRBUF_INIT;
> @@ -426,23 +431,23 @@ static void test_default_write_opts(void)
>  	reftable_writer_set_limits(w, 1, 1);
>
>  	err = reftable_writer_add_ref(w, &rec);
> -	EXPECT_ERR(err);
> +	check(!err);
>
>  	err = reftable_writer_close(w);
> -	EXPECT_ERR(err);
> +	check(!err);
>  	reftable_writer_free(w);
>
>  	block_source_from_strbuf(&source, &buf);
>
>  	err = reftable_new_reader(&rd, &source, "filename");
> -	EXPECT_ERR(err);
> +	check(!err);
>
>  	hash_id = reftable_reader_hash_id(rd);
> -	EXPECT(hash_id == GIT_SHA1_FORMAT_ID);
> +	check_int(hash_id, ==, GIT_SHA1_FORMAT_ID);
>
>  	reftable_table_from_reader(&tab[0], rd);
>  	err = reftable_new_merged_table(&merged, tab, 1, GIT_SHA1_FORMAT_ID);
> -	EXPECT_ERR(err);
> +	check(!err);
>
>  	reftable_reader_free(rd);
>  	reftable_merged_table_free(merged);
> @@ -451,11 +456,12 @@ static void test_default_write_opts(void)
>
>  /* XXX test refs_for(oid) */

Not sure what this comment is for, let's remove it.

> -int merged_test_main(int argc, const char *argv[])
> +int cmd_main(int argc, const char *argv[])
>  {
> -	RUN_TEST(test_merged_logs);
> -	RUN_TEST(test_merged_between);
> -	RUN_TEST(test_merged);
> -	RUN_TEST(test_default_write_opts);
> -	return 0;
> +	TEST(t_merged_logs(), "merged table with log records");
> +	TEST(t_merged_between(), "seek ref in a merged table");
> +	TEST(t_merged(), "merged table with multiple updates to same ref");
> +	TEST(t_default_write_opts(), "merged table with default write opts");

Nit: Could we order these alphabetically?

> +	return test_done();
>  }
> --

The diff only shows parts of the file which were renamed, some generic
comments though:
* Some of the parameters passed to functions can be made 'const', this
makes it clearer if/not it is read-only.
* The functions names could definitely be a little more verbose and
clearer. e.g. `t_merged_between` doesn't even signify what we're doing.
Even the test descriptions could definitely be improved.
* Some single lined for loops have '{}' which can be removed.

Now coming to some individual tests:
- t_merged_between: This test is to check and ensure that a ref which
only occurds in one of the records can be retrieved. This is fine, It
would be nice if we could however add another record 'r3' and ensure the
ref 'a' only occurs in 'r2', this would also ensure that merged tables
don't simply read the last record.
- t_default_write_opts: What is this test trying to achieve?

--00000000000010279e061c839082
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 36cf6d38951c3fcb_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hSU1CWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md1BEREFDUFlMYm84MW4vWFk0bHpJNGJrUCswM0ZRMQp6NkJRa3BRZjhT
Y2ViTnJJazNybTJEUmM2MzFxQmhCQUFFZ3BlRTh3RmlKbVVldFkxMUNWQ2Z2anROekNqNVpvCnc4
SDI4dHpsRm84VENCTzJURURYak5KYk5NYktubFJackZ1R0JWS2JOaGp4M1lOd1dEbHo1c3FjQTFX
ZjQrMXIKRk94NXlQSmdDODlCdGhrWTlSRXdid3ZUaDl0Nk5rNjZoelZhN3RlalVualhBbVlFNGhU
dlVWV3Y3QjdFYVNpVgplZjUwd0JTKzcxV01OL0Q2OUsxSnpmVjhXNmhEa1lMZHRnR1NONFR2dEU1
MTdTL3dYZUJ2REwzSXV5Z1BpRDgxCmpXQ0Y1SHowSFVUVkhXUllCWTFaZThJbnNPRERUMHRsOXJD
TTNjTmsvVGlCakZhcTZ4cjlCRUVzb3NCcmh1MEUKbTZ1b2hkd3lZS1oyODVhT3R2Y3VhaHhOTFcx
VXljV1pZQ0RscDlxMmdzeEhhWGx2MGhLQis1Q2p4dGNveVlvVQp1d2tOQ1F4ZmJmVjNFTDJKNkVN
NjFVMWV0dDZJTGpqT1BKcTkvRXJVL2NzajdHN2R2UWdYaUNMSHJhejdTVDlNCnNnUWdSZ3hia2pN
SC9nd1A0bHRhQ1JSOG9VMERoVmhjYTU4TkUvMD0KPW1kcjkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000010279e061c839082--
