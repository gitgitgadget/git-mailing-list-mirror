Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DFA26461B
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 09:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744102860; cv=none; b=sIh90/MzVrdiBIW+dEPCl80M3UnX7zW7lfOpHTs0sJB08dDs10VTaGjdrfdfUBbdH9KwoJkyRZzPXx4q26FMiiZEkHrQPEoWj5vAm4iL1i1aJTbuv81+4nYIPK1lWurMv8C7pxlWs4H97G2MyGkN701moDLZqH05OEwKWvrjq5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744102860; c=relaxed/simple;
	bh=luKAgjPY1D9UCJAjiEQ7IQOM4N/O7PpZsdrd7JyrVrg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cwt3S+4SNtp13aZasGl8/7h3I9hF0Maq8vVrQr2IsugwoNnFi/8XPElyRFHOsrEuhwFdwp4RihcsXe5foKGMpOqw8MNiPySZjbt1luCgHqFopBroEhhubXNZ9KjQRKIrAoWYx9tpHp1RtlwMQLdaEAH0ldNog5thLVyJsw5mqas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJ7a3LXq; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJ7a3LXq"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac2a81e41e3so955874866b.1
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 02:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744102857; x=1744707657; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZamY49KYIIQpna0pFjo1j5XN2zgcNiRu6ZUU8y1AfB8=;
        b=GJ7a3LXqhbfYtC3Sc8zluDOVLUAa7nht9DUBp/KkHTU6nT2oz62uY4/Zs+5a1nvE0D
         +dYsBoyKzpXw06Q2GCICXQcSQqqLXISYp2fcZemPxmGhYdfyuP/Lt1+IMU4pWXSvd87g
         wwfj8eZziSVpddhEkkg5nqQfp0eAnRixYiBUqd0Nqj1GH7zoUP5vx9z7tjepFvUcFhhL
         TtYOJ7Yuym85JHfUUQQbGaKLEwoEYRguyjoMresXdRahfnCLou5uQgqGqhFQbhMpYGM6
         SxVcbvUB/MVFD3o3t6qbIcTwZZsWjSFKa40lxZr3F81RaMSl8GMTxdQ3CTQyfwHSqMvP
         XfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744102857; x=1744707657;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZamY49KYIIQpna0pFjo1j5XN2zgcNiRu6ZUU8y1AfB8=;
        b=e6SFi4+EXiK7OiKNsC3iinmyrFvyb8FtdPs6RUZUQUD5mFjYh8hKZ3M4E8Acz5xuhW
         LDtl0tp5V8rf1eR4SM0aWdlVNIl4R0i9xhhPIscXg9eiwkGtcwvF0umcEoYdFqFwGkDT
         DMD5hvo2f+PJ+wZeaH+xoJz0H/8ycvzzQpki3wgCnrctrkQ1XjU6Oc2eKfmN7D7as2M8
         latFYeThCEKXm/HSzEIp54tmeHUkctM9R775T0Czm8+spsxfIydcHmCm6wPvP4qtwjtV
         wby9tlsuCUkye40frXh+jl8jx7+rA4mMDywa6PCnH0PH22xp++Hl9cOR0ejU+PME3PxF
         BEzQ==
X-Gm-Message-State: AOJu0YxyDwL3l//mTPpF8BIeG0VAsXjs4VdFYzN5e8HQBadV0YthlpPq
	q8g5/qSTsarm2L5m+RRv6UAtBjSjJhHBKCzMNPje5JjOeGcTLmfv
X-Gm-Gg: ASbGncuuxfnzoMpWGNn5z4V2QLLcNHMXCaN5kpQbY5BWR1gWNqj+7D4j5syduMCmGow
	NhUSR/3etyjIPntv01vcXCBkO1eW0avD6qpHN19OmHfAG17DjrUED2D4enXYHzuuV7GebfWu5V3
	oDeeIzY4Tb942boppV5LLmYF/MD+uYD5SqzKKwrRc1KOGlyd57o5DrLEN7sMyW7PFC5xqawCXKL
	ECkk4AbJS816lGNmtD3fjBf9iHVQR/LNvXvnBIvbXKh612ZElouP3s6umpeCgCskzsSWPClhk+Y
	rN7Wd1FA3SYtDuzrVAUwrPF9q10XTnC/EGJQOLYj/kOy4hfZ/vs+pH0=
X-Google-Smtp-Source: AGHT+IED4oAOJKPp6jCypAjmhlfHLhAmeTD2xa1jlsEI/kMOhtGAYrBmvcoYJuMaKmCKs00b5nSB6Q==
X-Received: by 2002:a17:907:1c28:b0:ac3:d54:d825 with SMTP id a640c23a62f3a-ac7e7779279mr1056287566b.56.1744102856859;
        Tue, 08 Apr 2025 02:00:56 -0700 (PDT)
Received: from [127.0.0.2] ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfe5d442sm875538666b.26.2025.04.08.02.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 02:00:56 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 08 Apr 2025 11:00:52 +0200
Subject: [PATCH v2 1/2] t6020: test for duplicate refnames in bundle
 creation
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-488-generating-bundles-with-many-references-has-non-linear-performance-v2-1-0802fc36a23d@gmail.com>
References: <20250408-488-generating-bundles-with-many-references-has-non-linear-performance-v2-0-0802fc36a23d@gmail.com>
In-Reply-To: <20250408-488-generating-bundles-with-many-references-has-non-linear-performance-v2-0-0802fc36a23d@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com, ps@pks.im, toon@iotcl.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3284; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=luKAgjPY1D9UCJAjiEQ7IQOM4N/O7PpZsdrd7JyrVrg=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGf05cdxdGWF09Ml7Zk6NHNmyP285EAC1RDwF
 rUvs0GMW5Jj/YkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJn9OXHAAoJED7VnySO
 Rox/j0IL/i/sBVvoWJyZ7yF+oRrL4nDDlPxUUDTXNPFKIP/4u3zIMriT08IrWTHtD/dE+OUqwrE
 5OitVEKBzxI694rZB57GzTL9CboPyS6tcbRunJeXNBMer+zYPpcs9IY4Bye8z6i2vVhy5nWe2ha
 5TJT9VLeFSPT3tUUmY9NIPilb7s264mJzqZuX7LiuxrpwAYLzemi4GXkOifaf0d4VhVH/pjz3YI
 Tds6v34zCU5C2X2PIedQhIpX74iIOhoHWm8nhlA2lbFEhPpp2II/mV9v/IWRej45Nib38Up0bx6
 kzY0xjzMzl0I4jUjSrjD4RLUDmxii9Xu+F+mE4Lj3bIbFggYAZHwGaWKIycIwjKlEFqco5131cG
 9qjFT7yiDT0aW89SD5twi820G7JjylchB62HCqJt+aBv3S/KPXkQnkUQv1diOfr3TTfTcu3pA2H
 HAd42o+DqqgekK4Gx3Ige7jKT0fZH3Ebx4IaktHIo/42imyShhhsWA99YTIpdaq5bOFmxW9m4/9
 CI=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The commit b2a6d1c686 (bundle: allow the same ref to be given more than
once, 2009-01-17) added functionality to detect and remove duplicate
refnames from being added during bundle creation. This ensured that
clones created from such bundles wouldn't barf about duplicate refnames.

The following commit will add some optimizations to make this check
faster, but before doing that, it would be optimal to add tests to
capture the current behavior.

Add tests to capture duplicate refnames provided by the user during
bundle creation. This can be a combination of:

  - refnames directly provided by the user.
  - refname duplicate by using the '--all' flag alongside manual
    references being provided.
  - exclusion criteria provided via a refname "main^!".
  - short forms of refnames provided, "main" vs "refs/heads/main".

Note that currently duplicates due to usage of short and long forms goes
undetected. This should be fixed with the optimizations made in the next
commit.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t6020-bundle-misc.sh | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index b3807e8f35..dd09df1287 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -673,6 +673,63 @@ test_expect_success 'bundle progress with --no-quiet' '
 	grep "%" err
 '
 
+test_expect_success 'create bundle with duplicate refnames' '
+	git bundle create out.bdl "main" "main" &&
+
+	git bundle list-heads out.bdl |
+		make_user_friendly_and_stable_output >actual &&
+	cat >expect <<-\EOF &&
+	<COMMIT-P> refs/heads/main
+	EOF
+	test_cmp expect actual
+'
+
+# This exhibits a bug, since the same refname is now added to the bundle twice.
+test_expect_success 'create bundle with duplicate refnames and --all' '
+	git bundle create out.bdl --all "main" "main" &&
+
+	git bundle list-heads out.bdl |
+		make_user_friendly_and_stable_output >actual &&
+	cat >expect <<-\EOF &&
+	<COMMIT-P> refs/heads/main
+	<COMMIT-N> refs/heads/release
+	<COMMIT-D> refs/heads/topic/1
+	<COMMIT-H> refs/heads/topic/2
+	<COMMIT-D> refs/pull/1/head
+	<COMMIT-G> refs/pull/2/head
+	<TAG-1> refs/tags/v1
+	<TAG-2> refs/tags/v2
+	<TAG-3> refs/tags/v3
+	<COMMIT-P> HEAD
+	<COMMIT-P> refs/heads/main
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'create bundle with duplicate exlusion refnames' '
+	git bundle create out.bdl "main" "main^!" &&
+
+	git bundle list-heads out.bdl |
+		make_user_friendly_and_stable_output >actual &&
+	cat >expect <<-\EOF &&
+	<COMMIT-P> refs/heads/main
+	EOF
+	test_cmp expect actual
+'
+
+# This exhibits a bug, since the same refname is now added to the bundle twice.
+test_expect_success 'create bundle with duplicate refname short-form' '
+	git bundle create out.bdl "main" "main" "refs/heads/main" "refs/heads/main" &&
+
+	git bundle list-heads out.bdl |
+		make_user_friendly_and_stable_output >actual &&
+	cat >expect <<-\EOF &&
+	<COMMIT-P> refs/heads/main
+	<COMMIT-P> refs/heads/main
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'read bundle over stdin' '
 	git bundle create some.bundle HEAD &&
 

-- 
2.48.1

