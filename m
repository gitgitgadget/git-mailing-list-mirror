Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE551DF985
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 01:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755220990; cv=none; b=aSV1O6Bt8KAnbLLXcCqfi1/zZXeyDJkyQhB9z52sFxrHnwcGz2Kjm0X553SQ2FaueGtXpQET5+UxsvOsV200hn2JjJ+/ng8s15caOgUe90WsjREoUU9+OToduiiSD3BuzqtcATzajNPv3S3OXd6Dpp65nvftjQKtEA8g9kYiDjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755220990; c=relaxed/simple;
	bh=gOk6mluCm+fkE/fQxGL78j0Mi+WIHTtrErya/dJHVjQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lZKA0mqGBS2PY/vaedIlOHhEtdP94ZcyX+sT6AXlC7wNUvbcWBRLy9WIKJAZuaMKgs9JujYDlZIrMHxKw8OIVLDiGsrDf7MHuKQDC8TSASXKSoaV5x1l5zgmi0Y2oev0QpDbO9Dr4wbRH8z3LlTwNOdPbIH91P/d4BCiSQDUKI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWiVceLQ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWiVceLQ"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b9df0bffc3so894143f8f.1
        for <git@vger.kernel.org>; Thu, 14 Aug 2025 18:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755220987; x=1755825787; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9MtfBScOoZEo5GJkEqj6oRKEmV9wskgz+o5HJhYUWZ4=;
        b=OWiVceLQyWrf/0lSmDQiAeyi61ZgckY2XVZvKbStXLPZpbeU6c9Lut860l0wLA9qHy
         O2OHBl9K5RYb7JYbCcKaWkQVVI0KAiqaaH6vc5/SHTTdbMA0yzoGuAUA/7tQqN1Ol/0j
         XD50uMO0q1zu8gDsCj/XjF9tuEW2I8fZjFZsn4+1C8WEHBpqWUL/+FSNh3GN6lcuzUqj
         00M3/Ma8Bef4NpwxaOnbIZnUX+Wzxz2cqsELsLCbRLHDuebsGOSUf+OGV0D03u06b5R7
         UT9tkXnmxbngGBX7rKwIc90d1k7kug93Y5dYWqT71nsQR/Ipjr+J92uUtWQSiX8rOxJN
         aayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755220987; x=1755825787;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9MtfBScOoZEo5GJkEqj6oRKEmV9wskgz+o5HJhYUWZ4=;
        b=r665mUrV+4/9Kcr68lFGz0m7vTYbhWey8IecJKOX+/TeCAibUxiqnDfeH1+WAjbvS6
         jShSCL1Ows92RCwsLp7Qfyg92Y6r9LmMOyTbW5tkMg3rZMzL0falXtrKWtVxBeyBueHZ
         U6QHRSY7/wEgI8hWneki+DSnCZEDb0xzn9rfgA16rWbN0xBt6BORGgqWpTz+7l9qT1VL
         cE9/9ejfAhqOmyHL7qd8TlzhRm2oTG/O48P7aIKGZF4HZMmvEB/+yxAyAoaU1qvX7wWT
         GgosthHePhkMJEwAK/hTQWuWse+i7ZWIw6uoFpDNtlAVNQcqNWcUtPshsXI0LRU+6ULY
         0PeQ==
X-Gm-Message-State: AOJu0YyBBNwlIKcSCM9xTFCOnIEQQAwsokXmAarA8Wz2TmJjUyySKJvP
	7VHKz7l6Uk4VOsEnL9n7x7ZirBiUhdXylkF7oYJN5naTb5eqflj+9ObVGbB2dQ==
X-Gm-Gg: ASbGnctBK74/4R/XRqZRVT/rO94UZkzVbMW8QG4whgCS7l6ojG1pIuKS7/KX7w8Sgfe
	WGxFX7aN4l2Vd2/wsj7gPyWB/Hk7xuKYgtRFar8bY/BfhdYFWF46Ivhb8C4glsJclXQ6aI0JZdZ
	Ssl8sxu6Ys8HTEY6Y8oQ/+0D04HnhE5AoNGs4eFaJPJayxo4fP41nZrq0DpT1kl4r0Dbi1++ZsG
	XARbydYnlggeVpRbIfCUmZxcztKdpeNxzjyskV/02yKYNYvV8QkRRchamcXA3EwIy6pTAjURL+/
	q+IzSdAZ7pU5Wiz3oG1xgzvRDFGol4dOcwi6VTqIsLqZJNRqccZOeIZOmOPGqBwgdscmL/Zos/u
	kZjdyz30swnircz2WYpQ7BEl/XMUs7EZ35Q==
X-Google-Smtp-Source: AGHT+IHa7y+JCYy2vBjNmRtiQJu6R4krFS9slsflbEKtnf60MdIt48w+BSTmlNDLkCTLKP6Hj9UK2g==
X-Received: by 2002:a05:6000:2881:b0:3b7:944d:e5e6 with SMTP id ffacd0b85a97d-3bb68545c66mr78936f8f.36.1755220986977;
        Thu, 14 Aug 2025 18:23:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a2215fd88sm194535e9.30.2025.08.14.18.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 18:23:06 -0700 (PDT)
Message-Id: <44784f0d672f15df238d5232ca098df3d13733ce.1755220973.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
	<pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 15 Aug 2025 01:22:48 +0000
Subject: [PATCH v2 13/17] github workflows: upload Cargo.lock
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Taylor Blau <me@ttaylorr.com>,
    Christian Brabandt <cb@256bit.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Eli Schwartz <eschwartz@gentoo.org>,
    "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
    Patrick Steinhardt <ps@pks.im>,
    Sam James <sam@gentoo.org>,
    Collin Funk <collin.funk1@gmail.com>,
    Mike Hommey <mh@glandium.org>,
    Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Make each ci workflow upload its Cargo.lock file as a build artifact so
that we can audit build dependencies.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 .github/workflows/main.yml | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index ef4d6348edcd..ba61bd516639 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -149,6 +149,11 @@ jobs:
       with:
         name: windows-artifacts
         path: artifacts
+    - name: upload Cargo.lock
+      uses: actions/upload-artifact@v4
+      with:
+        name: cargo-lock-windows
+        path: rust/Cargo.lock
   windows-test:
     name: win test
     runs-on: windows-latest
@@ -303,6 +308,11 @@ jobs:
       with:
         name: windows-meson-artifacts
         path: build
+    - name: Upload Cargo.lock
+      uses: actions/upload-artifact@v4
+      with:
+        name: cargo-lock-windows-meson
+        path: rust/Cargo.lock
   windows-meson-test:
     name: win+Meson test
     runs-on: windows-latest
@@ -378,6 +388,11 @@ jobs:
       with:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
+    - name: Upload Cargo.lock
+      uses: actions/upload-artifact@v4
+      with:
+        name: cargo-lock-${{matrix.vector.jobname}}
+        path: rust/Cargo.lock
   fuzz-smoke-test:
     name: fuzz smoke test
     needs: ci-config
@@ -484,6 +499,11 @@ jobs:
       with:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
+    - name: Upload Cargo.lock
+      uses: actions/upload-artifact@v4
+      with:
+        name: cargo-lock-${{matrix.vector.jobname}}
+        path: rust/Cargo.lock
   static-analysis:
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
-- 
gitgitgadget

