Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C366C3987D
	for <git@vger.kernel.org>; Sun, 30 Jun 2024 19:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719774755; cv=none; b=LpqdKhnynS0mV0r+Ef7j1LGZ8mgbie0KwHKM9WpcShhbZA+ktN7RHUecMUcbrSuQVVkKXoi4CaSBPCXjmnjv9OFjtupNlUZG3gKjkH1PfoN0sZ79bqFTWxJTuxEoPIEORkDB2eiJ4nA3pg7KTGRP39eCRjiGtX3mDl4+eguzriA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719774755; c=relaxed/simple;
	bh=OUzX1Fn49Bl0U8lNeXbaty7E9asvlQ1YRFNXtJv16O8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ltCXyNciUxiu7ZdTav876u+0tgoTTMBn9hUsycZ91xerCsw+YBMzse5tzuw1XnpArcvIU52q2ZtO4k886X0rntPvitdppJrX0j15VOoz1+F3LcLdvy0kteu/MWjGSopzteiYNjDaBgz7wV4DYmpgkEUbPoM4ngt+kNfAuAkVVyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXpPRgIT; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXpPRgIT"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-25c9ef2701fso987772fac.1
        for <git@vger.kernel.org>; Sun, 30 Jun 2024 12:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719774753; x=1720379553; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3k3bvG7gUBF7FxiqNuWE4MW745b1ozLyZ90bBr/RSVU=;
        b=AXpPRgITcj8bfiZkO25H+8q14wGKxkOiOMxqiSHaCSDZHBDIfVfDI2CFNNPicYKIX/
         YgzjHiSYcEz+8KbprqvmIKz134XcJGT1N15Bjh2p1/4dJ70U0IB/CUnbMYs7zZKjTK1O
         mAciUyI2cdLjcsbrStvItcE5+mTzg1D9Dt0Dd8AP/H2ihptsQtmK2rkp7JRCnICN+oqb
         eFlTNKJKq4N4LOF+rnkunLfgHahmY7CSDjTboyyYvBLK9Qp8Te70ritghTliX/KUGNRJ
         jf9CoyvxsnNNOFKlWtOFJPy5LhcmJUHQGoNEyx73RBQKvY55rrzIrkk19fC9XsgiDXun
         fHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719774753; x=1720379553;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3k3bvG7gUBF7FxiqNuWE4MW745b1ozLyZ90bBr/RSVU=;
        b=MVZJJ/7wHU5JRaBN5gKtg4pqBgaX2cPbIHgkV82EtRm7j5sZVgXlhVCcu/NvLOc7ds
         2946uT8oYDu/CbYaYbzBtAy6WTaYubqklsF+lmcgGNsbSxiA3u1BDROyeYTOYtww9qVh
         UKUH2b9b1oBtrJh0gXQkbMtE0A1zBBQVL0Ds3HYX6lE6xKuBnQ6y6bN0piIbtNlWQYrz
         Bqq+iS2TL/DEcAYZHfuu+I6qC1fcPKZSgqSk+8PY08qMVy24RrNyzqLRr0a/fC3J5BNF
         /4rm1bW9xgy2oDKG3E58TkgeVsh+VrfGX2MruSgJcX/LeEL2KTokItsQPeKClOUBfiUG
         w0iQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+PNsBbQPlPbREKjZO4yinLIn8IeYQ4T7OS0a322V9QV3UmgoFpgcKlqbiT4YwmqwwfoGAQpP15bXnDw9EtfOjTnFq
X-Gm-Message-State: AOJu0YwscY9YEwar/Yapo24SQZQfRx1hg+zspZzUdrrprolSZB/ZFC+4
	77/xRbqRKpzbDhFdWpMbtH3sKWyzud4VqvzLT9oGGT+A2h6g4xynROy0tN9ylrdmcgeQdXzVdcf
	WxVXw9RezdP2E/4L9pNsLKlOx9jc=
X-Google-Smtp-Source: AGHT+IGYwAP+vKGBNOZWS/+zNvpoHeDuCqWGoxTzYYikueHjrxwx4puFQH/Y7e+qMhlTAlna9E+GvNPbclSfZ05fTMM=
X-Received: by 2002:a05:6870:b6a8:b0:25d:921:75ec with SMTP id
 586e51a60fabf-25db36c7cacmr2034166fac.36.1719774752629; Sun, 30 Jun 2024
 12:12:32 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 30 Jun 2024 15:12:31 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240628063625.4092-1-chandrapratap3519@gmail.com>
References: <20240621060018.12795-1-chandrapratap3519@gmail.com> <20240628063625.4092-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 30 Jun 2024 15:12:31 -0400
Message-ID: <CAOLa=ZS0KozyxVz6tXx3uWXGVfR1DhPYPjoHq9bTriozf8w49g@mail.gmail.com>
Subject: Re: [GSoC][PATCH v3 0/11] t: port reftable/record_test.c to the unit
 testing framework
To: Chandra Pratap <chandrapratap3519@gmail.com>, git@vger.kernel.org
Cc: karthik188@gmail.com, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="0000000000003982a0061c2043cf"

--0000000000003982a0061c2043cf
Content-Type: text/plain; charset="UTF-8"

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> In the recent codebase update (commit 8bf6fbd, 2023-12-09), a new unit
> testing framework written entirely in C was introduced to the Git project
> aimed at simplifying testing and reducing test run times.
> Currently, tests for the reftable refs-backend are performed by a custom
> testing framework defined by reftable/test_framework.{c, h}. Port
> reftable/record_test.c to the unit testing framework and improve upon
> the ported test.
>
> The first patch in the series moves the test to the unit testing framework,
> and the rest of the patches improve upon the ported test.
>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
>
> ---
> Changes in v3:
> - Remove reftable_record_print() from tests to reduce clutter in test output.
> - Add more explanation to in-code comment in 1st patch.
> - Use string literals instead of xstrdup() when possible to prevent the cost
>   of mallocing and freeing.
> - make reftable_record_is_deletion() test for refs conciser in 6th patch.
> - Update commit messages for 7th, 8th and 9th patch to better reflect changes.
> - Add tests for '== 0' and '> 0' cases n 10th and 11th patch.
>

I've reviewed the series and left a few comments, I like how it is
shaping up though.

Thanks!

> CI/PR: https://github.com/gitgitgadget/git/pull/1750
>
> Chandra Pratap (11):
> t: move reftable/record_test.c to the unit testing framework
> t-reftable-record: add reftable_record_cmp() tests for log records
> t-reftable-record: add comparison tests for ref records
> t-reftable-record: add comparison tests for index records
> t-reftable-record: add comparison tests for obj records
> t-reftable-record: add reftable_record_is_deletion() test for ref records
> t-reftable-record: add reftable_record_is_deletion() test for log records
> t-reftable-record: add reftable_record_is_deletion() test for obj records
> t-reftable-record: add reftable_record_is_deletion() test for index records
> t-reftable-record: add tests for reftable_ref_record_compare_name()
> t-reftable-record: add tests for reftable_log_record_compare_key()
>
> Makefile                         |   2 +-
> reftable/record_test.c           | 382 -------------------------
> t/helper/test-reftable.c         |   1 -
> t/unit-tests/t-reftable-record.c | 554 +++++++++++++++++++++++++++++++++++++++++++++
>
> Range-diff against v2:
>  1:  d0646af549 !  1:  c88fb5bcfa t: move reftable/record_test.c to the unit testing framework
>     @@ Commit message
>          functions are similarly implemented, and
>          reftable/test_framework.{c, h} is not #included in the ported test.
>
>     +    Get rid of reftable_record_print() from the tests as well, because
>     +    it clutters the test framework's output and we have no way of
>     +    verifying the output.
>     +
>          Mentored-by: Patrick Steinhardt <ps@pks.im>
>          Mentored-by: Christian Couder <chriscool@tuxfamily.org>
>          Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
>     @@ t/unit-tests/t-reftable-record.c: static void test_copy(struct reftable_record *
>       	/* do it twice to catch memory leaks */
>       	reftable_record_copy_from(&copy, rec, GIT_SHA1_RAWSZ);
>      -	EXPECT(reftable_record_equal(rec, &copy, GIT_SHA1_RAWSZ));
>     -+	check(reftable_record_equal(rec, &copy, GIT_SHA1_RAWSZ));
>     -
>     +-
>      -	puts("testing print coverage:\n");
>     -+	test_msg("testing print coverage:");
>     - 	reftable_record_print(&copy, GIT_SHA1_RAWSZ);
>     +-	reftable_record_print(&copy, GIT_SHA1_RAWSZ);
>     ++	check(reftable_record_equal(rec, &copy, GIT_SHA1_RAWSZ));
>
>       	reftable_record_release(&copy);
>     + }
>      @@ t/unit-tests/t-reftable-record.c: static void test_varint_roundtrip(void)
>       			      4096,
>       			      ((uint64_t)1 << 63),
>  2:  90feb4168c !  2:  45ac972538 t-reftable-record: add reftable_record_cmp() tests for log records
>     @@ t/unit-tests/t-reftable-record.c: static void test_reftable_ref_record_roundtrip
>      -			.refname = xstrdup("refs/heads/master"),
>      -			.update_index = 42,
>      +			.type = BLOCK_TYPE_LOG,
>     -+			.u.log.refname = xstrdup("refs/heads/master"),
>     ++			.u.log.refname = (char *) "refs/heads/master",
>      +			.u.log.update_index = 42,
>       		},
>       		{
>     @@ t/unit-tests/t-reftable-record.c: static void test_reftable_ref_record_roundtrip
>      -			.update_index = 22,
>      -		}
>      +			.type = BLOCK_TYPE_LOG,
>     -+			.u.log.refname = xstrdup("refs/heads/master"),
>     ++			.u.log.refname = (char *) "refs/heads/master",
>      +			.u.log.update_index = 22,
>      +		},
>      +		{
>      +			.type = BLOCK_TYPE_LOG,
>     -+			.u.log.refname = xstrdup("refs/heads/main"),
>     ++			.u.log.refname = (char *) "refs/heads/main",
>      +			.u.log.update_index = 22,
>      +		},
>       	};
>     @@ t/unit-tests/t-reftable-record.c: static void test_reftable_ref_record_roundtrip
>      +	check(!reftable_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
>      +	check(!reftable_record_equal(&in[1], &in[2], GIT_SHA1_RAWSZ));
>      +	check_int(reftable_record_cmp(&in[1], &in[2]), >, 0);
>     -+	/* comparison should be reversed for equal keys */
>     ++	/* comparison should be reversed for equal keys, because
>     ++	 * comparison is now performed on the basis of update indices */
>      +	check_int(reftable_record_cmp(&in[0], &in[1]), <, 0);
>      +
>      +	in[1].u.log.update_index = in[0].u.log.update_index;
>      +	check(reftable_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
>      +	check(!reftable_record_cmp(&in[0], &in[1]));
>     -+
>     -+	for (size_t i = 0; i < ARRAY_SIZE(in); i++)
>     -+		reftable_record_release(&in[i]);
>       }
>
>       static void test_reftable_log_record_roundtrip(void)
>  3:  e435166a78 !  3:  db76851f4b t-reftable-record: add comparison tests for ref records
>     @@ t/unit-tests/t-reftable-record.c: static void set_hash(uint8_t *h, int j)
>      +	struct reftable_record in[3] = {
>      +		{
>      +			.type = BLOCK_TYPE_REF,
>     -+			.u.ref.refname = xstrdup("refs/heads/master"),
>     ++			.u.ref.refname = (char *) "refs/heads/master",
>      +			.u.ref.value_type = REFTABLE_REF_VAL1,
>      +		},
>      +		{
>      +			.type = BLOCK_TYPE_REF,
>     -+			.u.ref.refname = xstrdup("refs/heads/master"),
>     ++			.u.ref.refname = (char *) "refs/heads/master",
>      +			.u.ref.value_type = REFTABLE_REF_DELETION,
>      +		},
>      +		{
>      +			.type = BLOCK_TYPE_REF,
>     -+			.u.ref.refname = xstrdup("HEAD"),
>     ++			.u.ref.refname = (char *) "HEAD",
>      +			.u.ref.value_type = REFTABLE_REF_SYMREF,
>     -+			.u.ref.value.symref = xstrdup("refs/heads/master"),
>     ++			.u.ref.value.symref = (char *) "refs/heads/master",
>      +		},
>      +	};
>      +
>     @@ t/unit-tests/t-reftable-record.c: static void set_hash(uint8_t *h, int j)
>      +	in[1].u.ref.value_type = in[0].u.ref.value_type;
>      +	check(reftable_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
>      +	check(!reftable_record_cmp(&in[0], &in[1]));
>     -+
>     -+	for (size_t i = 0; i < ARRAY_SIZE(in); i++)
>     -+		reftable_record_release(&in[i]);
>      +}
>      +
>       static void test_reftable_ref_record_roundtrip(void)
>  4:  ad014db045 =  4:  78aff923c6 t-reftable-record: add comparison tests for index records
>  5:  69c1f3891a =  5:  b0b3c98042 t-reftable-record: add comparison tests for obj records
>  6:  dca1a016da <  -:  ---------- t-reftable-record: add ref tests for reftable_record_is_deletion()
>  -:  ---------- >  6:  5e6b004216 t-reftable-record: add ref tests for reftable_record_is_deletion()
>  7:  c7ffff71b0 !  7:  a68be88ccb t-reftable-record: add log tests for reftable_record_is_deletion()
>     @@ Commit message
>          reftable_record_is_deletion() is a function defined in
>          reftable/record.{c, h} that determines whether a record is of
>          type deletion or not. In the current testing setup, this function
>     -    is left untested for all the four record types (ref, log, obj, index).
>     +    is left untested for three of the four record types (log, obj, index).
>
>          Add tests for this function in the case of log records.
>
>  8:  f3e0c2aaf5 !  8:  02516add15 t-reftable-record: add obj tests for reftable_record_is_deletion()
>     @@ Commit message
>          reftable_record_is_deletion() is a function defined in
>          reftable/record.{c, h} that determines whether a record is of
>          type deletion or not. In the current testing setup, this function
>     -    is left untested for all the four record types (ref, log, obj, index).
>     +    is left untested for two of the four record types (obj, index).
>
>          Add tests for this function in the case of obj records.
>          Note that since obj records cannot be of type deletion, this function
>  9:  8eeeb63982 !  9:  541f9811d3 t-reftable-record: add index tests for reftable_record_is_deletion()
>     @@ Commit message
>          reftable_record_is_deletion() is a function defined in
>          reftable/record.{c, h} that determines whether a record is of
>          type deletion or not. In the current testing setup, this function
>     -    is left untested for all the four record types (ref, log, obj, index).
>     +    is left untested for index records.
>
>          Add tests for this function in the case of index records.
>          Note that since index records cannot be of type deletion, this function
> 10:  979db146a0 ! 10:  c2aff283b1 t-reftable-record: add tests for reftable_ref_record_compare_name()
>     @@ Commit message
>
>       ## t/unit-tests/t-reftable-record.c ##
>      @@ t/unit-tests/t-reftable-record.c: static void test_reftable_ref_record_comparison(void)
>     - 		reftable_record_release(&in[i]);
>     + 	check(!reftable_record_cmp(&in[0], &in[1]));
>       }
>
>      +static void test_reftable_ref_record_compare_name(void)
>     @@ t/unit-tests/t-reftable-record.c: static void test_reftable_ref_record_compariso
>      +
>      +	QSORT(recs, N, reftable_ref_record_compare_name);
>      +
>     -+	for (i = 1; i < N; i++)
>     -+		check(reftable_ref_record_compare_name(&recs[i - 1], &recs[i]) < 0);
>     ++	for (i = 1; i < N; i++) {
>     ++		check_int(strcmp(recs[i - 1].refname, recs[i].refname), <, 0);
>     ++		check_int(reftable_ref_record_compare_name(&recs[i], &recs[i]), ==, 0);
>     ++	}
>     ++
>     ++	for (i = 0; i < N - 1; i++)
>     ++		check_int(reftable_ref_record_compare_name(&recs[i + 1], &recs[i]), >, 0);
>      +
>      +	for (i = 0; i < N; i++)
>      +		reftable_ref_record_release(&recs[i]);
> 11:  fe044f186b ! 11:  7bdfca3744 t-reftable-record: add tests for reftable_log_record_compare_key()
>     @@ Commit message
>
>       ## t/unit-tests/t-reftable-record.c ##
>      @@ t/unit-tests/t-reftable-record.c: static void test_reftable_log_record_comparison(void)
>     - 		reftable_record_release(&in[i]);
>     + 	check(!reftable_record_cmp(&in[0], &in[1]));
>       }
>
>      +static void test_reftable_log_record_compare_key(void)
>     @@ t/unit-tests/t-reftable-record.c: static void test_reftable_log_record_compariso
>      +
>      +	QSORT(logs, N, reftable_log_record_compare_key);
>      +
>     -+	for (i = 1; i < N; i++)
>     -+		check(reftable_log_record_compare_key(&logs[i - 1], &logs[i]) < 0);
>     ++	for (i = 1; i < N / 2; i++)
>     ++		check_int(strcmp(logs[i - 1].refname, logs[i].refname), <, 0);
>     ++	for (i = N / 2 + 1; i < N; i++)
>     ++		check_int(logs[i - 1].update_index, >, logs[i].update_index);
>     ++
>     ++	for (i = 0; i < N - 1; i++) {
>     ++		check_int(reftable_log_record_compare_key(&logs[i], &logs[i]), ==, 0);
>     ++		check_int(reftable_log_record_compare_key(&logs[i + 1], &logs[i]), >, 0);
>     ++	}
>      +
>      +	for (i = 0; i < N; i++)
>      +		reftable_log_record_release(&logs[i]);

--0000000000003982a0061c2043cf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f4065bd8e7014dda_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hQnJoNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL01mQy85Nll2cGZ4YVhaTC82aFp3NWhYdjNrWjVxbwpsZHB3SFJ3c0xu
aFlueU03d0p6Z24xMmNIdlhWTndCOE9aYjF3dlM5T3hyRTBEdU4xWW9MbDRMT1VHVDdaaHlHCmIz
TjhGbnBsT2lvRXZyN0xrMlJSN2daNjdPbE0zTEk2SWl5QjdteUdKRUNpRDZXclBUYXUrZkRnYlhT
eWlwelgKa2VPdXVVREgxM2F1bExyN1pBUldEL0RRQlJxSDFOS09kOHNVUTE2RVdqM0xCYmZKb0Jh
M0xpa1VVMitnZUhlUQpGdGhjMzZlY2pwOUVyWUtoS09YNys3U1IvZVJsWHFNMG9VQWxGNE9DMGRN
R05LRkRqS2pqeWpZTVlra2Rpb0J2CldCc0Q4NnlMVzV2Mk5NN0xvRUZvMmx3OVVCa3BPV05KcDZ2
eTVMNS9MMlZUOGRpSk1mQm5WQUlvSnlJc0NGcC8KYzhXQU5NTllncmJlb3NNbzRKOVhQMkxuRlkw
RC84cEVEbVkzeTF0MG9RbXJGN0J3a2xpNGcwYTM0WHJ4WmJHMQpJZlBxWklIRTlhWFd2U1Z2bGN4
Qm1uaDNlL0xLRDFjays2OVpuRFZsYkVWQUN3Q3VHdStQREpIV3BQaDFjNU1aClIzM0puVXFERnRM
OExQNmFZa3lLMHJUZ2NCdER1L3R6eWlQUDQxdz0KPWd2VEMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003982a0061c2043cf--
