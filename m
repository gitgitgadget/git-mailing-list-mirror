Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB612853F9
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 10:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760092040; cv=none; b=YQfbIZbS8wMMrhD4VMhMxeeArXMnxsa4A8fSf178DjrgdFFt/BH1ufbLQ4f8q+7+n4LmdBQIMXgRz9MjkJvfZV/lxmaz71u6tveqbikfvQ2UEV3HR4FBGppjehvLhQ0jkhp13CV1qf5otubnR1BjhRsz7xNn/cjlM0F5BhKqqtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760092040; c=relaxed/simple;
	bh=0Lio97tAyqrT2/b8tgb0DfcfWZ6TB2kMjVrgJkSvkYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TTpgZ/cyZLM/hDfWT5o8tul2dOqbclFKGVWUSBHkjyXB8J95FE39WrTY4oX2U9hlUB9r5DXBziVU3jh14AbXXKeRAow5OvfBEMzVrY+DMesKh/1LuUfw/ovZOUZYavEYdEiMp885gUsiNH08m5rIMR2Mw2eSh11OnEM160lEU5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQJiq6kI; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQJiq6kI"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-637e9f9f9fbso3491397a12.0
        for <git@vger.kernel.org>; Fri, 10 Oct 2025 03:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760092036; x=1760696836; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Q7j9mbAvYWAJ52gpHIsUgLRmTS1wJARmgIwGQgMhFg=;
        b=DQJiq6kIBsSZYlsZcBC9ZnXSfMuNHaIXhg+b8gP1KP89tY4OZg2lbuz5Fv5cTvAvsS
         ZKzqL8NRMaZy3hiOJPmHek75OInUbdoggJxGysYUgJuAazLgKs31IX+rJ5WB42zkH5E1
         +qoHY9Cem/fmspfV4E1ffR+Yd2er8d7Q40oJamBwMT17V6dn0b+6B+1o/a8zf4xvuU6D
         5fmz6ly27R4z+5chD5lFDWJAHxj/jLQRVvFAGY5XQGq/+3N6M1J4i3Da7RtiloMaJ6T7
         I6achA+Uh2sk5WK8b/2fWtotVUy6THGCtoii0Qlm7lsp2jm3m58WB78OAbbu2wmO2Sxy
         7Xhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760092036; x=1760696836;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Q7j9mbAvYWAJ52gpHIsUgLRmTS1wJARmgIwGQgMhFg=;
        b=NM4HVx5P/4p2sXcNWVI3KaY2yxD1sSFpli/l0wbhKVFvVsyprjXXx2yll9/wPKAVuD
         VYes9LFAbImhfvStxx/fvMMFuUeHl7ejCEhE0VLyk1hIHpCCDUTVsYyA3Qy3rgU0JuUl
         hHz9ndEuVBYyBsOC53k/JdSE+zScV/GgG06+c+diUCra1l+w3HNVo0Pd0e/iXNnROtSN
         0sqer91OmQ16wCPqOIdhCc5FiVAvR1tNWrNmiRGkeUQGmm97wCSlMor7TpGS/KuVv8sc
         7qT+QfS5U86NrceV55f+p85tsCQRcdeAgxPjsvqE6Vzt1MMnKbkKQwzqwH6x3KO+kKWB
         iqOA==
X-Gm-Message-State: AOJu0YxXjZu5QTVFZboAyPrijrR7ftVQQXbbF8GJ8v1aCMUGakPNtVKo
	/TdeDSq05sjWvwEtxfTeAc1/lYr13Q/J9C3R/wWxJ6/Qhshi3sSW4oZtBnECPZ77
X-Gm-Gg: ASbGncvuuU0Wm4jMnd3440p+GVp1iww+EgiM3AG6mafv69YCyJMaPbQyaBxx+W8HofW
	K1qtHxQVdVE+7KzljTCHk61NNIoK2MgCcavqU33lWSrhHtHlLMok5BFbZ4VnkB5XyTncv/ElzM/
	A/ldFoZW5HX3FxvVcN0N14EKdN10kAEG4Ii9jR1Irz+SmQuFVZGwzj9bp0BfisQ9tE1Nb4l7wGN
	0DIZsZRFeYVGMsPKOEVsYycJ0x38CX+FLcqeZvUZfaTUoVXZQw0e4sEUOcfTdnKT/hv4soyEX0B
	AH1a+3W/d2yx4fsWoDslsA0N6gK2kKprlJZF00hepPNMBeiVw9gDNteoGhSc+u7ozZxNb3om7k9
	1OzbNmlEVoqHmmpQ4IhqGxtcIEeTl9JXP7klU06mEOd5miHY=
X-Google-Smtp-Source: AGHT+IHakjJl7yDwP3W/D+IBf8FF1LANcihxlZow/ZbR+WmVvE3MdApsRLITLXBPd4WlXJHnGwPqAg==
X-Received: by 2002:aa7:c9d4:0:b0:637:e94a:fb56 with SMTP id 4fb4d7f45d1cf-639d5c71065mr7617732a12.35.1760092036272;
        Fri, 10 Oct 2025 03:27:16 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:70de:2d8a:d550:c37c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a52b0f750sm1960729a12.14.2025.10.10.03.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 03:27:15 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 10 Oct 2025 12:27:08 +0200
Subject: [PATCH 4/9] t/pack-refs-tests: move the 'test_done' to callees
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-4-c7962be584fa@gmail.com>
References: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
In-Reply-To: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1741; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=0Lio97tAyqrT2/b8tgb0DfcfWZ6TB2kMjVrgJkSvkYs=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjo338yUtjFua3g/0oLXCi08PHw3wAGGO/Dn
 olaRYRrR2nVSYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo6N9/AAoJED7VnySO
 Rox/lk0MAJVqdhfqEgDukXZzBhT6e2UbyxsYVbSw6SumwaoCQ+ON9dcX/BXivwoHJTaPQ3uAVL6
 OuHe3BSzIcNTMCdO1VYNdKYagIp7HosomhAu9DZ9NJKIhO+CEIW0nT16EX+tk5CelJNUB7jJB6D
 gcTJVK43mA5sj4B+ZV4IlqKruEA0qiO4aAS9Sw60dJffC71EvM1nKeZVa9h01kK5MUH58vLLJUA
 5zT2umQdGEphcQO1sIhyub1RLMiJYifQEXf0c9UKEP8gONl1NpX1L85VkGzGgMOtH5yG0FOw0UA
 wGD5jxWXwfiRohses+baRpS5Sl5IczXbHUd+r9ZFBHOH+uN+t8QKV6LHFbvTKPb/rcrfaU5AazB
 aQ0a4MFWQoL+l50yIA+siouSxv2X/fdcKVwJQT1hTQ7TA9lAmC73VIQXd8E4vcBDothlA46mdUd
 vmCuGBKahARBg5FI1R116H+sOLP72OTtOY47Ot7OUg9TBgPlxlRKfKFNEjct1NlbOQFcVsvlim6
 Eo=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In ac0bad0af4 (t0601: refactor tests to be shareable, 2025-09-19), we
refactored 't/t0601-reffiles-pack-refs.sh' to move all of the tests to
't/pack-refs-tests.sh', which became a common test suite which was also
used by 't/t1463-refs-optimize.sh'.

This also moved the 'test_done' directive to 't/pack-refs-tests.sh'.
Which inhibits additional tests from being added to either of the tests.
Let's move the directive out to both the tests, so that we can add
additional specific tests to them. Also the test flow logic shouldn't be
part of tests which can be embedded in other test scripts.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/pack-refs-tests.sh          | 1 -
 t/t0601-reffiles-pack-refs.sh | 2 ++
 t/t1463-refs-optimize.sh      | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/pack-refs-tests.sh b/t/pack-refs-tests.sh
index 095823d915..6a71838ffa 100644
--- a/t/pack-refs-tests.sh
+++ b/t/pack-refs-tests.sh
@@ -460,4 +460,3 @@ test_expect_success 'pack-refs does not store invalid peeled tag value' '
 	)
 '
 
-test_done
diff --git a/t/t0601-reffiles-pack-refs.sh b/t/t0601-reffiles-pack-refs.sh
index 12cf5d1dcb..3c706978ef 100755
--- a/t/t0601-reffiles-pack-refs.sh
+++ b/t/t0601-reffiles-pack-refs.sh
@@ -18,3 +18,5 @@ export GIT_TEST_DEFAULT_REF_FORMAT
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/pack-refs-tests.sh
+
+test_done
diff --git a/t/t1463-refs-optimize.sh b/t/t1463-refs-optimize.sh
index c11c905d79..9afe3c1ed7 100755
--- a/t/t1463-refs-optimize.sh
+++ b/t/t1463-refs-optimize.sh
@@ -15,3 +15,5 @@ export GIT_TEST_DEFAULT_REF_FORMAT
 
 pack_refs='refs optimize'
 . "$TEST_DIRECTORY"/pack-refs-tests.sh
+
+test_done

-- 
2.51.0

