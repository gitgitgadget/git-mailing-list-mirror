Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F34A21505E
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744124137; cv=none; b=AWJzHyAHwcXuT4I62RYcTed/vkHVe3bEMPiy66IbBlYqcLk7PcLmAZ1SaZjGrzy/glMezg+zNEmuc+t7cCJePlrGqxLaoa1yDtDvX11cVq8tC1AowF0GZp4cRBrB9qC0gWGUHIarCuY41oRRpc5K6vf33DlbjHHqPy1wOm8ujlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744124137; c=relaxed/simple;
	bh=mmTuiQuxd4DIxB/YNgdcoiBQgy3rvox59Gnge7XIZIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E3zpnBKgy5ZpSNgGbEKNds1RKdjjXtByYpkeEjWc8FjxJIi9Knn1X19i18pcmR3nz0H5+niM8s1aJB8cLlBkpCikcS9OfRz6x5fbYQ6HuhR6EPoB4RFqMAVSkcritLQ1IzGyjgqJ4yQB8eg2fyfvvtns/0rkJKeRQA6Hmws/Eyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUsOViqL; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUsOViqL"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e5cded3e2eso8892492a12.0
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 07:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744124134; x=1744728934; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oQd0Id5N4S5vcYcnkDMaNz43zrPcwk73GBJQV+5Ssx0=;
        b=HUsOViqLiamBSg6/m1CnfRRZl1AAqVvB2AwwFpPVf3EuLefC1tTgUcaxjo3YRGH7f5
         VnFZ2aBkXBj0vipV1bexwOY1SNaOXWUuKgS3LG/ATGBAkmweNvmkJcwpEGK8SI6meR81
         6J4HEc7GobhWCUNubb/6zUzMKnIMiVWiwtjon6z4wIl027kLeDRlJVc0pLb9YJzAqxcb
         hR+vRqtZaoKqY4emRKumORp3HYsunkjScQpuNKiBZTATrIYhLBxUILaFIeE7pyRnp0u9
         FTgg/f/CzE++tAk+Zei09pvSNISXdk5h7qr6tYStQ2TP3FueivBPOh+shvaI0/vivYXH
         zeMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744124134; x=1744728934;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQd0Id5N4S5vcYcnkDMaNz43zrPcwk73GBJQV+5Ssx0=;
        b=XsFteeYTAq1jFNpiXAF0FMR86ODwb0LoKJX6cZo66CyYf8WnJq5q/fahYnNjA2YWj6
         47lV5aCnoz3Oj/XnooewGb9vWJEYuVxwlJyshp9+krPM6Erl+i/xzQLeew33UW1NX4UX
         Xaa7jkQrGlnR55pmkUMWijCU0Ln7mcTsVHILWe4AgAAnAuu66tfVucz4duHFEqNxjHyr
         e+VsQQxOL7bPLB8AaTAvI2Zlip9lP206av8Zu04decfaZMM6eO1otm6H1T4ogiiiqDmT
         Pfw35y/U6DFT6dBOafsm0NcB5fIthw0oeO8sPyhphqE5mN8RpiKYDG9v/qIWEhTuReUo
         qEog==
X-Gm-Message-State: AOJu0YyIJSoWrS0IaVy1MkXV50CcCMCEXm/odX65RzUQ2eAb+D656IHB
	WOBrFfp60Kie6mALCponCSiBepBQRN9wwRUjwuWcoIU7bDYwREP/hsXV27xk
X-Gm-Gg: ASbGnctJ08QzFa77Ir2An+RqVp+Yuv2NbVFLL5dUK6YkN9gHqNoxRhr2fNu+4UsJlbh
	8qLFUw6SBFX9ZPP3RfCay0GVhQpG/o11dg7X6f8HKQ4X9lS+Mjuw8ueLHkvr8lPT2fV3RlYLUre
	xyD9XdLPsRcM/3pigD78BDnHrIjlQqfOupUoDxvW0PBYBTRrpZSAivVQlZBCly1GtzTjB5qywli
	xMTt3iOew8UZp/HKNTEtiLH2bLjP8Q71BwDlFGgnvBaiX0jGls3hXyH9vcvk2ujlzYJa6qi213J
	iGQpxUwtM99yvr32xJXEiSrRj230vf3h4kGVkWrGJ24+
X-Google-Smtp-Source: AGHT+IGcD/xLRiyRa4s53ZqELLw+0houmWMSi16k9YiUCCHqIsr30lC2NpkPhKzXaDcmnIrwButRTg==
X-Received: by 2002:a05:6402:3489:b0:5dc:c943:7b6 with SMTP id 4fb4d7f45d1cf-5f0db80babamr11502045a12.3.1744124133759;
        Tue, 08 Apr 2025 07:55:33 -0700 (PDT)
Received: from [127.0.0.2] ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f087ed1c68sm7905678a12.17.2025.04.08.07.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 07:55:33 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 08 Apr 2025 16:55:29 +0200
Subject: [PATCH 3/3] meson: add support for 'headers-check'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-505-wire-up-sparse-via-meson-v1-3-17476e5cea3f@gmail.com>
References: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
In-Reply-To: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com, toon@iotcl.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3924; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=mmTuiQuxd4DIxB/YNgdcoiBQgy3rvox59Gnge7XIZIM=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGf1OOLJKopsoPAC1MbqaxpxoFT4vTBMZOaXY
 b4RbOS9TbK6fYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJn9TjiAAoJED7VnySO
 Rox/atYMAJiZ9ImEkHm4QIJWbWyWjGIQ9NlyRokHOvPbqqE0llqbbeHU5EoZZ7w3pa2qoQb1JVl
 nHOuYpyyZ7DrUjnfYBDft35CoKrdY4JyYDA/D2LFTcqZDX5zgdAWM8F4tVeUsNbyBpm9OHsO2+a
 Hnh7k/Nt/4cIOTuX9dJL3MqMjiYXL9eyoqSBzVL/GzHIqxQkRvMATtQ6eQ1H5jnmLkEXyXghFIM
 pdkEpPMB3ovz2GVfE0AeFo579uIsf/mywx4lCtNt35xW4cS70MtJY1D+Pa2RsmFQ2aJfBHJYZaJ
 66HQTwfcDO1uPQF5AIZ07cbKLaB+C9kL+Ga3d5rdR6YVmhFw9kvdikRPoau0L9gZyZ15cckUwA0
 4a0vI6w574sUivzVDzPo0iAOvsiUJCvW/3KOOVp3MgmV0R4TXCuDs6U0WYeKHO6I5yqwyTiCEhA
 UirZWhtc1mXsDIBNse4vnpSNLcLT5fmRy5uazw4JupyJnYppVem89sTYk/mXZB6lcfPynP0VzX7
 3s=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The Makefile supports a target called 'hdr-check', which checks if
individual header files can be independently compiled. Let's port this
functionality to meson, our new build system too.

Let's avoid the abbreviation and name the target 'headers-check', which
is easier to read.

The implementation resembles that of the Makefile and provides the same
check.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 meson.build | 107 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/meson.build b/meson.build
index 790d178007..1e0ecd37d3 100644
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
+  alias_target('headers-check', hco_targets)
+endif
+
 foreach key, value : {
   'DIFF': diff.full_path(),
   'GIT_SOURCE_DIR': meson.project_source_root(),

-- 
2.48.1

