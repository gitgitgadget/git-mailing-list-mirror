Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2B1D27E
	for <git@vger.kernel.org>; Wed, 29 May 2024 17:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002948; cv=none; b=MPpCt14n3N76puQ+OfZR6agRoqiGS98xix1nLkYFwbYpL8ZRt8t9qksDN+kxzMGmB5qtQsx0J13jktQQfurVOVfnZKfAff5AEKnYSx8PoAamYoJ2a55O7RLaAOVvRFVH133kXF71xBy9pDpzFe0a2Pnh37PlmDwag4Su/4a4M7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002948; c=relaxed/simple;
	bh=kNyN2dgDG1+qTmTzJ9dXM1CuizdnxwTqptU2HPxrp1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GlBhp2bQHbGFO5FPjT+Qufbr3y81/CjM4HvYgoA5YOsON5MrCHBbFl1IEx2BrvxxJm8OM67IHf4rp3aDlPfBWGS3ONhoi5/WQ33KT7xu2TuWPd4tPQSHtpRu9owQNwIwyKf3ZPM5jmvqFZDvBHDryBp/PMtRIavAr8K3CF0WYCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wz+S2q0i; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wz+S2q0i"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f4a5344ec7so1533285ad.1
        for <git@vger.kernel.org>; Wed, 29 May 2024 10:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717002946; x=1717607746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVHANNjyXLBsiu5q7U/82PS66Gg3p8XVfQxajEaYpfQ=;
        b=Wz+S2q0iCO+q0GBkzG+XtAyFH3Inh5/1MNCOOtzrtN5trklGHHfdY8rhLoCfEP0ZrZ
         /qZgCbCVjzj9qEKYXMyBDPrK+W3Y9rL9FkI146MoIrJm0Fh/72y+KD9QhHZ1wthydH39
         vz0uH/dBRVx19Dk2qfIJlW2hy+xQwwRC0uPzDw0T7MJSHNYg2oc5tFc+RkYoWR8V3ou3
         z15QDCoVk/vc574hmWFt7zWm8KnBfBDz2x2FnJIrc9jypFlTf3tCB0atd8NXGrtb/9mU
         jiM7I1iuVbov0QY2meR5QRNsquZ0Yz+jTB1VrXMlF9sbbjWSWqF27IVXERiAx86jRoV6
         1tiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717002946; x=1717607746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVHANNjyXLBsiu5q7U/82PS66Gg3p8XVfQxajEaYpfQ=;
        b=L2thQwwzMD+h/vH0cCrOpHmzCZZ2qQo8Gf1SJxUtyPVJxY/FadPO2I4IHT6lwb7GUf
         CBHPug7+bmCUwyF1eqRhGpyiBnaxSUQbcgqlFdwtbUfl00CwNtB00hWA3A/MQj2jkGex
         S5TXwDMYmngcZozd6Q73jMOYorF16jiTIEi7GaYPQUU+Dyn+senSmFsw279yAj06AEM2
         NRRYFZP0cARBFb3vuc6qcsuZquVsxpynkJdczwI6NScc561hLrvDiqKfCuwYCpHtF3TA
         gOtrMxlHXzXycgBzPVVfqD7laWcSg/Bdl+Cl2cnwUuUt6VGQGvRkBq1ZzXkumFDqCMoS
         AoOA==
X-Gm-Message-State: AOJu0Yx6jkNomBAzHniiGH/0Soi6y1HGe29nztgLX5lBPXLGuAwXHc0m
	ZQ39/At+z9ymJ3LcR2JTDh/gwEOeMiwCfSdkYxedzkYqK/2CPm3Ttxt1uzXcueA=
X-Google-Smtp-Source: AGHT+IFQlWKqGi8wMVaGmcbbphHRRK8b35QjSxrglh6uNJZ5jVeLWzi0ieilvgPgAmAGmnmAQ4w2Lg==
X-Received: by 2002:a17:902:e844:b0:1eb:e40:3f74 with SMTP id d9443c01a7336-1f4eab3c947mr43926745ad.32.1717002946134;
        Wed, 29 May 2024 10:15:46 -0700 (PDT)
Received: from Ubuntu.. ([171.51.169.75])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f4757734b6sm79720225ad.234.2024.05.29.10.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 10:15:45 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [GSoC][PATCH v3 0/4] t: port reftable/basics_test.c to the unit testing
Date: Wed, 29 May 2024 22:29:26 +0530
Message-ID: <20240529171439.18271-1-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240529070341.4248-1-chandrapratap3519@gmail.com>
References: <20240529070341.4248-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the recent codebase update (commit 8bf6fbd, 2023-12-09), a new unit
testing framework written entirely in C was introduced to the Git project
aimed at simplifying testing and reducing test run times.
Currently, tests for the reftable refs-backend are performed by a custom
testing framework defined by reftable/test_framework.{c, h}. Port
reftable/basics_test.c to the unit testing framework and improve upon
the ported test.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

---
Changes in v3:
- Split up the 4th patch of the previous series into 2 sub-patches

CI/PR for v3: https://github.com/gitgitgadget/git/pull/1736

range-diff against v2:

1:  3ab1b415f4 = 1:  3ab1b415f4 t: move reftable/basics_test.c to the unit testing framework
2:  51fec8a376 = 2:  0143bbd2e4 t: move tests from reftable/stack_test.c to the new unit test
3:  e0e9adfdf6 = 3:  2f1d02e945 t: move tests from reftable/record_test.c to the new unit test
-:  ---------- > 4:  14606ac8db t: add test for put_be16()
4:  81b8975b4c ! 5:  2e741bab6d t: add test for put_be16() and improve test-case for parse_names()
    @@ Metadata
     Author: Chandra Pratap <chandrapratap3519@gmail.com>

      ## Commit message ##
    -    t: add test for put_be16() and improve test-case for parse_names()
    +    t: improve the test-case for parse_names()

    -    put_be16() is a function defined in reftable/basics.{c, h} for which
    -    there are no tests in the current setup. Add a test for the same and
    -    improve the existing test-case for parse_names().
    +    In the existing test-case for parse_names(), the fact that empty
    +    lines should be ignored is not obvious because the empty line is
    +    immediately followed by end-of-string. This can be mistaken as the
    +    empty line getting replaced by NULL. Improve this by adding a
    +    non-empty line after the empty one to demonstrate the intended behavior.

         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
    @@ t/unit-tests/t-reftable-basics.c: static void test_parse_names_normal(void)
      	free_names(out);
      }

    -@@ t/unit-tests/t-reftable-basics.c: static void test_common_prefix(void)
    - 	strbuf_release(&b);
    - }
    -
    --static void test_u24_roundtrip(void)
    -+static void test_be_roundtrip(void)
    - {
    - 	uint32_t in = 0x112233;
    - 	uint8_t dest[3];
    - 	uint32_t out;
    -+	/* test put_be24 and get_be24 roundtrip */
    - 	put_be24(dest, in);
    - 	out = get_be24(dest);
    - 	check_int(in, ==, out);
    -+	/* test put_be16 and get_be16 roundtrip */
    -+	in = 0xfef1;
    -+	put_be16(dest, in);
    -+	out = get_be16(dest);
    -+	check_int(in, ==, out);
    - }
    -
    - int cmd_main(int argc, const char *argv[])
    -@@ t/unit-tests/t-reftable-basics.c: int cmd_main(int argc, const char *argv[])
    - 	TEST(test_binsearch(), "binary search with binsearch works");
    - 	TEST(test_names_length(), "names_length retuns size of a NULL-terminated string array");
    - 	TEST(test_names_equal(), "names_equal compares NULL-terminated string arrays");
    --	TEST(test_u24_roundtrip(), "put_be24 and get_be24 work");
    -+	TEST(test_be_roundtrip(), "put_be24, get_be24 and put_be16 work");
    -
    - 	return test_done();
    - }

