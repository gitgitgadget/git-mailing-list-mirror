Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C484A28368E
	for <git@vger.kernel.org>; Thu, 10 Apr 2025 11:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744284650; cv=none; b=UPu25aj12Uw6s99g7Uu2oyC5348WK22twoDPBZBkPpJpQ5nhzS6O8RLGbqpTl/8vAEZMg2TXfNgJCPGqrtwpuEggy6cdgglrSAvraDgBuU0ZPZhKnX08GF4jOOzEu/gEFvtzT2XFHzKxuv7PiLxXofnzM+BbT6WUftjGO7Mgkww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744284650; c=relaxed/simple;
	bh=mc4QLKBFogSfCVh01LKsFE981igB0NxM+FNoK9eHHog=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f0B0B0pdhgsLL/M4aAjh8AyRmC133O7UvcAbfl7sw/0DddjawMS3urAsn930cPAOEx2BmW7ilQ/vUuFasGxHMD29T0C+SGCs7+yVqtA8ABo5VeAjSCF35U3ouSxzOmO0Oyyyg6zqj+6jG0/VTBvZKH1JC+7DFYvAqjOjLJSIr/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WC8dWu9v; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WC8dWu9v"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso104720066b.1
        for <git@vger.kernel.org>; Thu, 10 Apr 2025 04:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744284647; x=1744889447; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H4WtAslQXt54QpSjqiDeOdYFxkevmWMzXtX+B+UMMbQ=;
        b=WC8dWu9vZtcvhYe24jOSVUEXKvkCa1M/ytywKiv1nnsmY0lbGH9f1tRi4U3/Rj9uGR
         7DpiVam0gcUWVuXMcJzX3bYAqv7LsluoLkdmDVkwl2gVawtGKDmD9m7og+Q5zscv6OO1
         EDx36UbYgzD7ywK8PqK2bGKQwBHufOYhktWgQYPzNlQ6xN5pVnVLESVU697T6tTV7/cn
         cNaCC8JA/6jeam8fyLWI9tnTmF8bpNXf6zDIoWrVktcN5MX1U6Nzncxe7mnlsZdDj4Ck
         c57j/6edP9wQPSaekGn0wYszLNRtNDSS4Q7eFHxrZcHH5kpBUBVbIEv6+FSMNbnPAeUT
         BDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744284647; x=1744889447;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H4WtAslQXt54QpSjqiDeOdYFxkevmWMzXtX+B+UMMbQ=;
        b=NMg6Af/Maz9nAyXVsRfLLZID5cdU54UCXzkktPph9jExA07c7zDW8/u0wxjTuuGcoS
         Z9tcx9Qxg+W3IJfUILUkjayk6HAQmrGiTOeF8vzrzbnIZ06lmDFBVLJq5daHKlPNeHpU
         QtPF5yxgBG638mN+OaKNBFCwbwniZSwFEn87tFfLGjTU67yqh9dut9zQvQD5GgmpbgT9
         1HiIZwOL8N+zzcib4rI33iS49+dX7HaCQvknCj1L7GxBxDDiscmz25aVzmQXiZIrQTyZ
         bbjDXDAX/8inufiFv8JiVzNQUACvJYlfyeRYFZRL2COluPbVoaBxbhhYuA8k3q+ZL7aF
         PjtQ==
X-Gm-Message-State: AOJu0YywNKtm+iTlxsn+jhPaBniTN3H5tSToZmDBVk7Djt2/aAxvmxwK
	dsJwSPJWOG4N+snvG1iccmZRhofkIbxXde2wlFrNRQZn14CpRZPjlwgwXYac
X-Gm-Gg: ASbGncvrAypcvlulJdQJb/sgdywCm0DeTSPhKe+0rHllFWGMcUBWzpedZW9H8UiUfJs
	QG8q8PGL8urQ3+AxhM7abgJ3uAHuOdIs9iXnd9LBDfQ4IiuzyRVCnLsCL8qh6NKfcYxFKMRAguV
	epZNu1QbazIIUPDVKoTso5AjJdPG0H3zA4PthpDkMjmA9YtqLP2i7V+IP/v9+RwjGBrWgmEfW/6
	LunYrmYxdkTSRhEFtd5m1w6Mr7r8Dh1r65jSSrpgoZ85UDNS+1icEQb+oJ7jdcJgGt9gyH7r3fs
	L5EuOfJ3XKLjT90slGbK7dw6A/JKvl45r7EWEDv0HutQsJjCdJBH12X8
X-Google-Smtp-Source: AGHT+IFdam0G+8wdB1nd1EDtHpUbwF9fu8U+aH6BgBJFhXHvGGskQE7RffwHXCAcvFSHLdDkerfjbA==
X-Received: by 2002:a17:907:1b0a:b0:ac8:16fb:a291 with SMTP id a640c23a62f3a-acac007f9d2mr236860066b.18.1744284646444;
        Thu, 10 Apr 2025 04:30:46 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:9936:e3af:b877:72d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1bb3553sm260230666b.29.2025.04.10.04.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 04:30:45 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 10 Apr 2025 13:30:33 +0200
Subject: [PATCH v2 3/4] meson: add support for 'hdr-check'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-505-wire-up-sparse-via-meson-v2-3-acb45cc8a2e5@gmail.com>
References: <20250410-505-wire-up-sparse-via-meson-v2-0-acb45cc8a2e5@gmail.com>
In-Reply-To: <20250410-505-wire-up-sparse-via-meson-v2-0-acb45cc8a2e5@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, jltobler@gmail.com, 
 toon@iotcl.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3822; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=mc4QLKBFogSfCVh01LKsFE981igB0NxM+FNoK9eHHog=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGf3q+ISlou16PH4Q2bhkf2h1Qe4Eoez+tAiS
 5rGWm7lIgaJaokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJn96viAAoJED7VnySO
 Rox/RysL/A0nM2uj0t9f2erTk/kfUPZVwIrCXAEdpMMWIsU5cvIKxVI22ttYUcMkjetVyL3nNsx
 vUlBwP66/X5BU+wy1DGQGQQL6b+YtjogdXnGDcEk3jxNnye76kgxAdGLJKe17p2KMLVgj+Y4/+Q
 6N11cuynCryCkgtcnxHZjgxSPssXyUrPjXrZ+s/jetZhpztek1OdDUjHMADPY275iffmAfFS0xz
 goCaUEy1if+xpFONgxXI0YdAj4X0841SNOMUPVafydL655iHt5SOAB81cjAiM+BEu356oyRXMXu
 sip/O5SFC40e3TgkHMyDnboCj7liUFTTV5Qg85BOb1fcOyvX1M6yTx/rOBaF+szOdNMR1Oz1QFx
 zcHXfR2W1QX2Cx3RIbi+62e/NXust0ZIzRQj9tNilK1XsJ8hZ3VowxVOzbdaBBl6VkP4nViAq+N
 QkovoTBQZSzIuq1P5ybJObgnPN2cfikCZPlqeaOZFS3TgFNNg8dylTZkdoKbb9nxMaBQMVXeo16
 kI=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The Makefile supports a target called 'hdr-check', which checks if
individual header files can be independently compiled. Let's port this
functionality to meson, our new build system too. The implementation
resembles that of the Makefile and provides the same check.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 meson.build | 107 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/meson.build b/meson.build
index 790d178007..6fce1aa618 100644
--- a/meson.build
+++ b/meson.build
@@ -655,6 +655,12 @@ if git.found()
   endforeach
 endif
 
+headers_generated = [
+  'command-list.h',
+  'config-list.h',
+  'hook-list.h'
+]
+
 if not get_option('breaking_changes')
   builtin_sources += 'builtin/pack-redundant.c'
 endif
@@ -1995,6 +2001,107 @@ endif
 
 subdir('contrib')
 
+headers_check_exclude = headers_generated
+headers_check_exclude += [
+  'compat/apple-common-crypto.h',
+  'compat/bswap.h',
+  'compat/compiler.h',
+  'compat/disk.h',
+  'compat/fsmonitor/fsm-darwin-gcc.h',
+  'compat/fsmonitor/fsm-health.h',
+  'compat/fsmonitor/fsm-listen.h',
+  'compat/mingw.h',
+  'compat/msvc.h',
+  'compat/nedmalloc/malloc.c.h',
+  'compat/nedmalloc/nedmalloc.h',
+  'compat/nonblock.h',
+  'compat/obstack.h',
+  'compat/poll/poll.h',
+  'compat/precompose_utf8.h',
+  'compat/regex/regex.h',
+  'compat/regex/regex_internal.h',
+  'compat/sha1-chunked.h',
+  'compat/terminal.h',
+  'compat/vcbuild/include/sys/param.h',
+  'compat/vcbuild/include/sys/time.h',
+  'compat/vcbuild/include/sys/utime.h',
+  'compat/vcbuild/include/unistd.h',
+  'compat/vcbuild/include/utime.h',
+  'compat/win32.h',
+  'compat/win32/alloca.h',
+  'compat/win32/dirent.h',
+  'compat/win32/lazyload.h',
+  'compat/win32/path-utils.h',
+  'compat/win32/pthread.h',
+  'compat/win32/syslog.h',
+  'compat/zlib-compat.h',
+  't/unit-tests/clar/clar.h',
+  't/unit-tests/clar/clar/fixtures.h',
+  't/unit-tests/clar/clar/fs.h',
+  't/unit-tests/clar/clar/print.h',
+  't/unit-tests/clar/clar/sandbox.h',
+  't/unit-tests/clar/clar/summary.h',
+  't/unit-tests/clar/test/clar_test.h',
+  'unicode-width.h',
+  'xdiff/xdiff.h',
+  'xdiff/xdiffi.h',
+  'xdiff/xemit.h',
+  'xdiff/xinclude.h',
+  'xdiff/xmacros.h',
+  'xdiff/xprepare.h',
+  'xdiff/xtypes.h',
+  'xdiff/xutils.h',
+]
+
+if sha1_backend != 'openssl'
+  headers_check_exclude += 'sha1/openssl.h'
+endif
+if sha256_backend != 'openssl'
+  headers_check_exclude += 'sha256/openssl.h'
+endif
+if sha256_backend != 'nettle'
+  headers_check_exclude += 'sha256/nettle.h'
+endif
+if sha256_backend != 'gcrpyt'
+  headers_check_exclude += 'sha256/gcrypt.h'
+endif
+
+if headers.length() != 0 and compiler.get_argument_syntax() == 'gcc'
+  hco_targets = []
+  foreach h : headers
+    if headers_check_exclude.contains(h)
+      continue
+    endif
+
+    hcc = custom_target(
+      input: h,
+      output: h.underscorify() + 'cc',
+      command: [
+        shell,
+        '-c',
+        'echo \'#include "git-compat-util.h"\' > @OUTPUT@ && echo -n \'#include "' + h + '"\' >> @OUTPUT@'
+      ]
+    )
+
+    hco = custom_target(
+      input: hcc,
+      output: h.underscorify().replace('.h', '.hco'),
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

