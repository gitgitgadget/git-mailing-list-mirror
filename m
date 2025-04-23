Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BB6274FCC
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 08:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745396146; cv=none; b=NR99/2owxb4EvxeoPWC6cjR5Izg6MUAhP74Ei3kG25a3N2wNiQLqPukMuvN0Qc9IaozCbHOApJRp5a4DH/PTqBOVxXgcEt56bdJM6t8sAGbEEwdpsW9UQICYCNai80n5Cde6b4Vq6w1vc3nekssQk1gWE8RxfKb7K+7puT5RaL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745396146; c=relaxed/simple;
	bh=A6ZJbKyccJlKaYon29BRE8mWmXoI4sYCyM/qoiH76Ic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DVBwKvbavFFMSturNAYjP1NImbqfXsLZef99LKPRPTUu8Vo0gTRIf+0NNDmZj15qqUMaj+kzX0Gtl4nVI1PdY7EBAbP5ZUOZvyzWoYemxWrQrmd2m7O0DMY8eYZ9OYnG+u4VeZHVRzAilhvcqUxx8lEQVcDQ2bzhcr784jv8Y08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnOOboIn; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnOOboIn"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5f4d28d9fd8so8207840a12.3
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 01:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745396143; x=1746000943; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bDPts2/mACZRF1SsaM6qRy3Y2CGzx90o8b9ou1GRkiw=;
        b=SnOOboInHVmSrRjAZrl5rXMOyab8nmWouzcvL4LJlCsyTVyI64SBKBjM8VSP2jbTbB
         huTvpF4m9Scg6OZsWZ/Kcg2qkHprbIsV2gQ4S7VfUNSxZicpsE/t6PkcCD9WfaEPHRQV
         nHd6oG4V9+qRcfvDEjzgnF7GDJh2LIYGJ1+vELHCoAY8CpW8asJVpODPCiI6LusfzGAp
         fcpQgtQYhuTwJoz+D9pSZ3ROXTTjbmyztywOxnb3lgjl3L3A8E/a9n0z2ZjwVYKLHUMy
         kfeRlYcm56cOhk1tbplxwK8ODs/8GJPmD0YmRArOxBGrXwisoqSbKIgov4Rsi59OIRSW
         Nvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745396143; x=1746000943;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDPts2/mACZRF1SsaM6qRy3Y2CGzx90o8b9ou1GRkiw=;
        b=EVpOWctSNy4LCz5cvF74VvCyVz/50FtgL/ZsqGBRlMDWbPufeQXn1OKGnj8nC6pc8V
         HE0ahL0vNoJke9QQXvOLWuh3w5fmE9SKzGqzhzc5K/iQvsj8LaZfArF88Fmv0DeZ6Dg4
         l022WFsdPLzLGMyZOtF4u8Y6QLUP3SzTKS+qX7QKyUfY/4/Ztv4duAgig63Ls6LQ/UB4
         70FyDcdxpgo+PBFa4WnpYFY/wFj3jC361r3HMIxEB2LPZFRGAZUkrek28be7FgAnFjeL
         B0O5KJHx0KguEtI4LRz3Vx8lRxuB/Xn7KUQO1ATxBPi8gzjN0CcbO9vUIKyrGSM9ndJg
         6CRQ==
X-Gm-Message-State: AOJu0YxbMkS6H8/m9eyH2WSIMjv1z3F5/6Q/FfceFmKXa2v7kl6ds+Dw
	jUWaihfNwoXkgYQtvkPUcEqEYfRCtJkgGqTLV6ZkF+Xaid+KsgGV
X-Gm-Gg: ASbGnctXmhk8ZPGlk4jVi6cLC3KGxSZwe27P+h8yJwcsq0Jp00Dnfyt9yguLPRgjfMZ
	9MwIF/spygu5+zDBVA7xrCzg+a3R37p9axpq5/qZP+IU1H7VQYEyVoy5pdHFwRNvht2PpLVmiBO
	kynAd5ulqdh8DPjxEWO0SCEp7BbDwWMw3vWHyZY3jC2A1Pfz6CNKeHIUK9AXfwQtDpxnSMzk5iQ
	YxAXcQxRZCYaInfL/AFZDCHLnfzGf/sCMF4wy6/Ha7F94fTyJblPW68qrhWpKyTPudGNESVipeM
	mbEfzNJXldpq2rCVwmumnkR3t/rRWYSIIAygmtR7RZQuqQ0=
X-Google-Smtp-Source: AGHT+IF3jluDF91SHFQOrBjcJzLhLMRnC8Sp+okVPKWTsuQUiBxNzL6zVCJLHOqT2iuhKlhFufCoKA==
X-Received: by 2002:a17:907:9815:b0:abf:6ebf:5500 with SMTP id a640c23a62f3a-acb74b18d6dmr1593357766b.16.1745396142647;
        Wed, 23 Apr 2025 01:15:42 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:8764:66c7:f630:d3a4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ec13a5bsm766577266b.27.2025.04.23.01.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 01:15:42 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 23 Apr 2025 10:15:38 +0200
Subject: [PATCH v5 5/6] meson: add support for 'hdr-check'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-505-wire-up-sparse-via-meson-v5-5-d1e2be4b2078@gmail.com>
References: <20250423-505-wire-up-sparse-via-meson-v5-0-d1e2be4b2078@gmail.com>
In-Reply-To: <20250423-505-wire-up-sparse-via-meson-v5-0-d1e2be4b2078@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, toon@iotcl.com, 
 gitster@pobox.com, phillip.wood123@gmail.com, ps@pks.im
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2883; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=A6ZJbKyccJlKaYon29BRE8mWmXoI4sYCyM/qoiH76Ic=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGgIoamKqC+pcUWCH/6PFo/fjuemmHQ4YGGXo
 0evWwH85RHIVIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoCKGpAAoJED7VnySO
 Rox/IO4MAKIQykMygr1sYQghOUDArbS7wAzy7fqOMaQdGI8WT125HRqFyD74XkIXpAhjU12qGqI
 KfYdzCPXOSAk43nyD6gPDpBArp2giw53vjMINTdxL6JEdOoiLVzOD1qMz1oUnQHu7ubAy6qF8NQ
 Kc2Hx1GnzM8mOFI5haSwIME4+m+nKWxk28fTVFzp4tCg4zPPmosXDyy9fSpiaS4gD69hhmugXL3
 kHm5p+5g0GkHZte0V5bLbmHZHoaC1401I62SQYla0aQd8muNaJiHX0v6/OkYInMZeOltdgj79iV
 dvXgHfOBrbcTcC5PUCsZXm8JPvkmk82kCO1baCHPYQ0ShTQHqgypaSCNqfWH1FVgl0bdQXKeUM3
 7IuIEkmUF3w9G/9dv67xAaUD8oglWpogbJ/9JXyBPoVWeFBDBohRFco454tybmX5j1VwD8phMf1
 mzswEpGiTdvOzZ3yjkqCfHWGfX+uuDgcaNyFAeUwIaO2kn4kdkDw00wtdbDyq0HE/suVvOqAQx3
 9I=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The Makefile supports a target called 'hdr-check', which checks if
individual header files can be independently compiled. Let's port this
functionality to Meson, our new build system too. The implementation
resembles that of the Makefile and provides the same check.

Since meson builds are out-of-tree, header dependencies are not
automatically met. So unlike the Makefile version, we also need to add
the required dependencies.

Also add the 'xdiff/' dir to the list of 'third_party_sources' as those
headers must be skipped from the checks too. This also skips the folder
from the 'coccinelle' checks, this is okay, since this code is an
external dependency.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 meson.build | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/meson.build b/meson.build
index 4618804c7a..22fc65ec80 100644
--- a/meson.build
+++ b/meson.build
@@ -645,6 +645,7 @@ third_party_excludes = [
   ':!sha1dc',
   ':!t/unit-tests/clar',
   ':!t/t[0-9][0-9][0-9][0-9]*',
+  ':!xdiff',
 ]
 
 headers_to_check = []
@@ -1994,6 +1995,68 @@ endif
 
 subdir('contrib')
 
+exclude_from_check_headers = [
+  'compat/',
+  'unicode-width.h',
+]
+
+if sha1_backend != 'openssl'
+  exclude_from_check_headers += 'sha1/openssl.h'
+endif
+if sha256_backend != 'openssl'
+  exclude_from_check_headers += 'sha256/openssl.h'
+endif
+if sha256_backend != 'nettle'
+  exclude_from_check_headers += 'sha256/nettle.h'
+endif
+if sha256_backend != 'gcrypt'
+  exclude_from_check_headers += 'sha256/gcrypt.h'
+endif
+
+if headers_to_check.length() != 0 and compiler.get_argument_syntax() == 'gcc'
+  hco_targets = []
+  foreach h : headers_to_check
+    skip_header = false
+    foreach exclude : exclude_from_check_headers
+      if h.startswith(exclude)
+        skip_header = true
+        break
+      endif
+    endforeach
+
+    if skip_header
+      continue
+    endif
+
+    hcc = custom_target(
+      input: h,
+      output: h.underscorify() + 'cc',
+      command: [
+        shell,
+        '-c',
+        'echo \'#include "git-compat-util.h"\' > @OUTPUT@ && echo \'#include "' + h + '"\' >> @OUTPUT@'
+      ]
+    )
+
+    hco = custom_target(
+      input: hcc,
+      output: fs.replace_suffix(h.underscorify(), '.hco'),
+      command: [
+        compiler.cmd_array(),
+        libgit_c_args,
+        '-I', meson.project_source_root(),
+        '-I', meson.project_source_root() / 't/unit-tests',
+        '-o', '/dev/null',
+        '-c', '-xc',
+        '@INPUT@'
+      ]
+    )
+    hco_targets += hco
+  endforeach
+
+  alias_target('hdr-check', hco_targets)
+endif
+
 foreach key, value : {
   'DIFF': diff.full_path(),
   'GIT_SOURCE_DIR': meson.project_source_root(),

-- 
2.48.1

