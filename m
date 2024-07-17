Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493261CF9B
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 11:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721216944; cv=none; b=WbLkiNtvYbOHb5cgrWCaZwdMqiEMXZ+s3OM8/AuXLdPUlUTtFuUbObcCQcT7dUvN2n2aN8e6NFDNS3o2UVRi8sVTdbklMvyb7wggBqiwbwUbCWfd3mZPTH7ULjcirYTdxWaYemvqgUu7Lekej6GpbquK/qRc956xDTMwsncEltw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721216944; c=relaxed/simple;
	bh=7S/kv34RYK6+lbLS5ifWaMq6WL6RSxDp1U02AKXJfEE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eJVY4b8wGX+V+/1JejouaQJprCkpm7xZq5vTCpC3yrnx4R21QRyXBJvRo99dC1Xus6O74V7XBYOYMfpe3FxYYaVwjtM2i/RcgXZeIvxEyyqB/EODPIUXHym7PFhM+9APB9MnRUt0QYo8CJIZ2EplCaoZMvDYnd6JfKy3flYJ+eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpN3zzh8; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpN3zzh8"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-24c0dbd2866so3377706fac.0
        for <git@vger.kernel.org>; Wed, 17 Jul 2024 04:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721216942; x=1721821742; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6qGAwroc9VPfJyxMp2rf/MZpOJsYsVGJoEEPWyCvntk=;
        b=RpN3zzh8aMbUVV3iMbrrQ7fO4BX/0wVvThqeS4yXYtsGZG1fpJltPKY1M5S6Gtb/TB
         XeH1ZhvgpxLelBmWH+4men7dZnEB/GrDIKTGlwvHNxKfXRPSVTrycMuwO+NbgmjX/Zyk
         zYuz0wFGimdT/mXbS8bVNxpGmn3GvGhJYUuITLw7I61RbTZzhk/KUI+fZ9vicsfhklEK
         UEaXIIDXWOQZGqTuANExmjpZ76SDlvh9bdGwfTvKBbDdGyjh4s9ZzT7OQRDO4r9ZElu9
         DlcQxIdY8l/TigIDqXoBEC0QeUn4eMz+hx8cK4BW3XQFNxYhazGPPRmNhTwYo9GmzC8I
         oCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721216942; x=1721821742;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6qGAwroc9VPfJyxMp2rf/MZpOJsYsVGJoEEPWyCvntk=;
        b=fXxhtOupFXe0O8B7IovaM7EddNOuHpfhGMfmMlvOPamWV9manVXX03qqOnStPA0LI4
         d2nGHXOkCfx+FhGKNTtHehlBiPShV8f+gwrk6pbjvduk0jBEy6Wb3uP+PgWLyYNkRMaZ
         3NcO4qKVKpd0O1YDV7AlwwhoLfwJFodselvxeOoITdgzaMsyPnWmM1z1o2OSs0f7S78M
         zIq61CfJmvaIwPhZWKnznU/osFTt/q61mQ6KUCxF2MZvz6vkU7vYuR0CMsXlsemwnfIH
         2B2gFSUiXjTjBCz9c/AMCUVaxi8Wsu5NxFoS8dMT/uz9LkBTOFhqQ5aYZw+vyFmtNGko
         TbcA==
X-Forwarded-Encrypted: i=1; AJvYcCV2n0fHGiwN0sBheaKfD3l872x0jHIziDBYom7ndPl1PFqtYGXJ0zhiIz+BNR7kvty05bwrPbm5QhAXyQV7FrJ6tx5g
X-Gm-Message-State: AOJu0YzchfpeCI7y7wtxIU5lskohvwxeYNFvbUZV7Yu3e4LTU9pa2UYd
	WKLVoWXWMLMDuBkV+8Rk0yoRWZjLXratIl21EDjkQ+HfdBVzDdde24G0/AY61ReWk46M48Gjv8y
	GsUxsnh2IUpL6sMP16w7urnDGDEI=
X-Google-Smtp-Source: AGHT+IGPY0NRhuzX29V2DOkfTPXxWkfR6Q8zGuNONLOC22p1NEZOTdEpA4LPq4oMecjtCvGuT3WqlcL9vQduhykJceY=
X-Received: by 2002:a05:6870:65a9:b0:254:a811:6c75 with SMTP id
 586e51a60fabf-260d9176133mr1149798fac.7.1721216942121; Wed, 17 Jul 2024
 04:49:02 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Jul 2024 04:49:00 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240716075641.4264-3-chandrapratap3519@gmail.com>
References: <20240612130217.8877-1-chandrapratap3519@gmail.com>
 <20240716075641.4264-1-chandrapratap3519@gmail.com> <20240716075641.4264-3-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 17 Jul 2024 04:49:00 -0700
Message-ID: <CAOLa=ZQ7xQFKZ9Oeo0WyrgzvjCvNm4dbgatp0JTvP33sUQ_3fw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] t: move reftable/tree_test.c to the unit testing framework
To: Chandra Pratap <chandrapratap3519@gmail.com>, git@vger.kernel.org
Cc: karthik188@gmail.com, chriscool@tuxfamily.org
Content-Type: multipart/mixed; boundary="0000000000006abfae061d700c74"

--0000000000006abfae061d700c74
Content-Type: text/plain; charset="UTF-8"

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> reftable/tree_test.c exercises the functions defined in
> reftable/tree.{c, h}. Migrate reftable/tree_test.c to the unit
> testing framework. Migration involves refactoring the tests to use
> the unit testing framework instead of reftable's test framework and
> renaming the tests to align with unit-tests' standards.
>

Nit: it would be nice to mention that this commit copies it over as-is
(mostly) and the upcoming commits do refactoring. This would really help
reviewers.

> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---
>  Makefile                       |  2 +-
>  reftable/reftable-tests.h      |  1 -
>  reftable/tree_test.c           | 60 ----------------------------------
>  t/helper/test-reftable.c       |  1 -
>  t/unit-tests/t-reftable-tree.c | 56 +++++++++++++++++++++++++++++++
>  5 files changed, 57 insertions(+), 63 deletions(-)
>  delete mode 100644 reftable/tree_test.c
>  create mode 100644 t/unit-tests/t-reftable-tree.c
>
> diff --git a/Makefile b/Makefile
> index 3eab701b10..79e86ddf53 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1340,6 +1340,7 @@ UNIT_TEST_PROGRAMS += t-mem-pool
>  UNIT_TEST_PROGRAMS += t-oidtree
>  UNIT_TEST_PROGRAMS += t-prio-queue
>  UNIT_TEST_PROGRAMS += t-reftable-basics
> +UNIT_TEST_PROGRAMS += t-reftable-tree
>  UNIT_TEST_PROGRAMS += t-strbuf
>  UNIT_TEST_PROGRAMS += t-strcmp-offset
>  UNIT_TEST_PROGRAMS += t-strvec
> @@ -2685,7 +2686,6 @@ REFTABLE_TEST_OBJS += reftable/record_test.o
>  REFTABLE_TEST_OBJS += reftable/readwrite_test.o
>  REFTABLE_TEST_OBJS += reftable/stack_test.o
>  REFTABLE_TEST_OBJS += reftable/test_framework.o
> -REFTABLE_TEST_OBJS += reftable/tree_test.o
>
>  TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
>
> diff --git a/reftable/reftable-tests.h b/reftable/reftable-tests.h
> index 114cc3d053..d0abcc51e2 100644
> --- a/reftable/reftable-tests.h
> +++ b/reftable/reftable-tests.h
> @@ -16,7 +16,6 @@ int pq_test_main(int argc, const char **argv);
>  int record_test_main(int argc, const char **argv);
>  int readwrite_test_main(int argc, const char **argv);
>  int stack_test_main(int argc, const char **argv);
> -int tree_test_main(int argc, const char **argv);
>  int reftable_dump_main(int argc, char *const *argv);
>
>  #endif
> diff --git a/reftable/tree_test.c b/reftable/tree_test.c
> deleted file mode 100644
> index 6961a657ad..0000000000
> --- a/reftable/tree_test.c
> +++ /dev/null
> @@ -1,60 +0,0 @@
> -/*
> -Copyright 2020 Google LLC
> -
> -Use of this source code is governed by a BSD-style
> -license that can be found in the LICENSE file or at
> -https://developers.google.com/open-source/licenses/bsd
> -*/
> -
> -#include "system.h"
> -#include "tree.h"
> -
> -#include "test_framework.h"
> -#include "reftable-tests.h"
> -
> -static int test_compare(const void *a, const void *b)
> -{
> -	return (char *)a - (char *)b;
> -}
> -
> -struct curry {
> -	void *last;
> -};
> -
> -static void check_increasing(void *arg, void *key)
> -{
> -	struct curry *c = arg;
> -	if (c->last) {
> -		EXPECT(test_compare(c->last, key) < 0);
> -	}
> -	c->last = key;
> -}
> -
> -static void test_tree(void)
> -{
> -	struct tree_node *root = NULL;
> -
> -	void *values[11] = { NULL };
> -	struct tree_node *nodes[11] = { NULL };
> -	int i = 1;
> -	struct curry c = { NULL };
> -	do {
> -		nodes[i] = tree_search(values + i, &root, &test_compare, 1);
> -		i = (i * 7) % 11;
> -	} while (i != 1);
> -
> -	for (i = 1; i < ARRAY_SIZE(nodes); i++) {
> -		EXPECT(values + i == nodes[i]->key);
> -		EXPECT(nodes[i] ==
> -		       tree_search(values + i, &root, &test_compare, 0));
> -	}
> -
> -	infix_walk(root, check_increasing, &c);
> -	tree_free(root);
> -}
> -
> -int tree_test_main(int argc, const char *argv[])
> -{
> -	RUN_TEST(test_tree);
> -	return 0;
> -}
> diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
> index 9160bc5da6..245b674a3c 100644
> --- a/t/helper/test-reftable.c
> +++ b/t/helper/test-reftable.c
> @@ -7,7 +7,6 @@ int cmd__reftable(int argc, const char **argv)
>  	/* test from simple to complex. */
>  	record_test_main(argc, argv);
>  	block_test_main(argc, argv);
> -	tree_test_main(argc, argv);
>  	pq_test_main(argc, argv);
>  	readwrite_test_main(argc, argv);
>  	merged_test_main(argc, argv);
> diff --git a/t/unit-tests/t-reftable-tree.c b/t/unit-tests/t-reftable-tree.c
> new file mode 100644
> index 0000000000..5df814d983
> --- /dev/null
> +++ b/t/unit-tests/t-reftable-tree.c
> @@ -0,0 +1,56 @@
> +/*
> +Copyright 2020 Google LLC
> +
> +Use of this source code is governed by a BSD-style
> +license that can be found in the LICENSE file or at
> +https://developers.google.com/open-source/licenses/bsd
> +*/
> +
> +#include "test-lib.h"
> +#include "reftable/tree.h"
> +
> +static int t_compare(const void *a, const void *b)
> +{
> +	return (char *)a - (char *)b;
> +}
> +
> +struct curry {
> +	void *last;
> +};
> +
> +static void check_increasing(void *arg, void *key)
> +{
> +	struct curry *c = arg;
> +	if (c->last)
> +		check_int(t_compare(c->last, key), <, 0);
> +	c->last = key;
> +}
> +
> +static void t_tree(void)
> +{
> +	struct tree_node *root = NULL;
> +	void *values[11] = { 0 };
> +	struct tree_node *nodes[11] = { 0 };
> +	size_t i = 1;
> +	struct curry c = { 0 };
> +
> +	do {
> +		nodes[i] = tree_search(values + i, &root, &t_compare, 1);
> +		i = (i * 7) % 11;
> +	} while (i != 1);
> +
> +	for (i = 1; i < ARRAY_SIZE(nodes); i++) {
> +		check_pointer_eq(values + i, nodes[i]->key);
> +		check_pointer_eq(nodes[i], tree_search(values + i, &root, &t_compare, 0));
> +	}
> +
> +	infix_walk(root, check_increasing, &c);
> +	tree_free(root);
> +}
> +
> +int cmd_main(int argc, const char *argv[])
> +{
> +	TEST(t_tree(), "tree_search and infix_walk work");
> +
> +	return test_done();
> +}
> --
> 2.45.GIT

--0000000000006abfae061d700c74
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 98c5d027293bfea2_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hWHI2a1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOGdBQy9rQnV3Nyt2ciszZVdKSmxlSkl4MXlHbWx2bwpQaHhpYVBnbXpx
OStIL2tpdVQrY3JNbnhvVGtkVHlEWE9QWDFtRXc4QS9kRndaa0dFRU1ISWFWbUpGTDVHUVlxClp6
S2ZsL25leEZ4bFZPRThuYkR1S3lRVE9QWkNjdEhuTkFqZmMraitHMmxTMjVtZEw0MmR2SWoyL0Zh
RGRuS1IKOExnd3NvQkVoMm5aWVl4Ry9rcjNTaktvcWlqZStzY0YzUW9BMUQ5TTFUVUxhSnA1OG10
Wkx4dThTd2svMUtHZwpxUWFlZXFVTk1UTU4wbmtBa040QVFWMVUwVGhKd2hKUWtCTGMrZkZRRDdr
aG1QWmp0S09TdXJ5YmRmR2lFK1loCnV3UGdFM1FNVmVicEtyNWticC96VzVkczNlWHdxdFozZjF5
UnhRUEZJUnBXN2xQcS9YUHlEYVk3Q0hpUVZYMVQKQUhrUVJaYWQ0WEl5Z2xjUGw1NTlIWVlKQ1Qx
bDJGSEgvbE1KZXZnU3ppZWVreEphc21KVEszMGRNVVNodStOUwo3dThYZnBQM2RnNmdkSWo5YklS
cjZwazNudEhSYlhpcm1ZSGV6OEllVWhGMGF0eXgzdjM5NFkvYVBXTTVHTjBCCklLSTlsdWZZeTRD
S3EreDVnMGdaczlkeSt6dTlzZkxRWnhBUGZ1UT0KPWRwQTYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006abfae061d700c74--
