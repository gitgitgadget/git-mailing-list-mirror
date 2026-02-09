Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4D43793D2
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770650430; cv=none; b=gGl2j4ckgkH/LVKfeOrdeEsbnFSpJdyfMqEKvquJfEw6FlDd1TyrMOmgkFMCYpCZ13XeOMQ4zzbMtGysI0/Ujli8Fu0bsxCpOMwKtcukVqo9GrMVwFmuL4QZZiTTcEgtT5jZ/fPYZnuo+XXwLC1RQhXvNtb+bmbXfhH/E9q25mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770650430; c=relaxed/simple;
	bh=AnN2LhMOckf2SbKjkLnWa28HudfEO7b1T0efWg9dW6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FLVvrHVlHroE6YR1UeS5U9yFk308PfKaaL8gwEo4CnuZmPNZIZrIL0/EYNffq/kVDZvkG2JTzs7IUKO1eLzhSWqhT3V06SsUfCqYhjCIdtv5rAvkoEXvryLz4olQ+UBkTBgb7nRbCpkd2typNzVuw0dR1M240PhzwwNcCFuoelo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VyzQ28ZB; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyzQ28ZB"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-794911acb04so29584047b3.0
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 07:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770650429; x=1771255229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8JPAabN+GU9xrQlnXrQUroATagrraHrIutBEhTJ6dk=;
        b=VyzQ28ZBywcdlpF7K8devu3raihmnwuTtziqY2hrIQ8OnKeDUOEb0Dl5xxsxA8FtqW
         Yr7lPyFAy6yhYH9aR3nG/jjc2nafpeebFeoK1WMzQ19I3hHndfQqsIjGOxS+H55zw87m
         puRHbpE0Pz/6bayYODQ12BTZ94LhUwC3/0o956G78s+l5vHljz+UCA+EVDrjjO1IV9mB
         fEgWWY4DadbYSrb4MPwYCE5ssIH3tGp2zu+JMRrd+Ioa+a+v1UTGrsxh4sslDC3K9X4b
         DRnCjikhRebIurUxIOpOtmE8srpBUMAEsZ9d+LV8CVR3IuH09x4tqFD/pHsQN0T2wXlQ
         oPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770650429; x=1771255229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V8JPAabN+GU9xrQlnXrQUroATagrraHrIutBEhTJ6dk=;
        b=dr1RPWub1m+11Ny9oNWw1O1yoYi6ZVarpzg20Kv5VQcRXbCs7WW5UMv1ldnutWEFUj
         WNw3bV36MeapI6AU/9O0kX8zt8bF26vGnqdbgeltce2WI9i8f383AWIeGFIV0ew7EZbu
         D0GDeJhsISFoNksRXfeqWjWB1iVueQ3LpfC7mpXzJz859ErYfmO+SbsegHLpHczJUzmw
         Htv/GYJknXQJ1MapBtisSqSY9WqaOHY2GbAdbz7tpWkyFTOBnBNEYTipV++XjLQtUor+
         BGGDdDlZjx91D4avHQd0TMNcCzABSS4QtYOJOLcXqiEm2blmRWiv7f2yoY0FvuNP0cDd
         ordQ==
X-Gm-Message-State: AOJu0Yx3YxEvIRHG+eAUaK+Mlh03gGSLLkAmXD41wl58x/NcJfEezHoG
	kZ/9/btO1Gvw8oWLHou+8JNK0MktXk+tKs+IbX8O1sxaWnloZELkNoLglx4jImdJ
X-Gm-Gg: AZuq6aKubzCZGjJfpYDViteXUrXR2XraMNrLMw+pksebucTFDhKlykC3GA8W4Vz3Er0
	afGir7BMs0eNp4AnkDlEFG/0mem8iDmWZS8vjLIBRDmdF6L2f+boqvxFfqHUiSkJQ5gvpDQkaLJ
	GzmpFUR1CBodZT+dh50+AxZAFte/Bu7i5fIHH3hGwFV/lkkcS8wqa1YWc4UuIJjo2pBgf2+WPPC
	XikcTIC6zXWlVv9Jxt3j/BeTRSLNOtEUJs6ECBBlCMBbUXgyb36+kXG5EuQbTNNQQSXYGlwZelU
	zZA2+q3mdNXHNybZndfocfpYY3xFH0PBCkmSa52wqXTVaiRJXz1mU+2hQ+hnPuEDRfPVd+caikF
	tO+9MAswibnwTdDsHP9yUp5WXqMG3g01dEvJFUuuKrb/F1TLAzDLLjnELVQ5wEwVky5/LblrzZ8
	RHAoIyM6j53nr7VVJ0RPYV+tuprl7Fb8TxJkRNE6IjBr/7vumkgdaRk3Nhvq2GssDu8+QmnJJP8
	jKF
X-Received: by 2002:a05:690c:e3ef:b0:794:ff22:4fb4 with SMTP id 00721157ae682-7952aa49c21mr107223237b3.4.1770650428966;
        Mon, 09 Feb 2026 07:20:28 -0800 (PST)
Received: from localhost.localdomain ([2605:a601:90eb:5600::9])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-796506f1dddsm14578077b3.25.2026.02.09.07.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 07:20:28 -0800 (PST)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Evan Martin <evan.martin@gmail.com>
Subject: [PATCH v2] meson: regenerate config-list.h when Documentation changes
Date: Mon,  9 Feb 2026 10:19:59 -0500
Message-ID: <c9ae171eed6bd5b0fa6671b10a5ad0da024f36d0.1770649805.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.52.0.rc0.1018.g3ad6585c12.dirty
In-Reply-To: <20260207215924.28863-2-ben.knoble+github@gmail.com>
References: <20260207215924.28863-2-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Meson-based build doesn't know when to rebuild config-list.h, so the
header is sometimes stale.

For example, an old build directory might have config-list.h from before
4173df5187 (submodule: introduce extensions.submodulePathConfig,
2026-01-12), which added submodule.<name>.gitdir to the list. Without
it, t9902-completion.sh fails. Regenerating the config-list.h artifact
from sources fixes the artifact and the test.

Teach the meson build to depend on the Documentation files that
generate-configlist.sh reads by having it use the output of
generate-configlist-deps.sh as a list of dependency files, since Meson
does not have (or want) builtin support for globbing like Make.

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---

Notes (benknoble/commits):
    I considered having generate-configlist.sh write its own dependency
    list, which Meson also supports… idk though. Input welcome :)

    This was also built on top of commits [1] on next, but should not depend on
    them despite what base-commit and prerequisite-patch-id say. Indeed, it
    applies cleanly to master @ 3e0db84c88 (Start 2.54 cycle, 2026-02-05).

    [1]: https://lore.kernel.org/git/20260207215924.28863-1-ben.knoble+github@gmail.com/

 generate-configlist-deps.sh | 5 +++++
 meson.build                 | 1 +
 2 files changed, 6 insertions(+)
 create mode 100755 generate-configlist-deps.sh

diff --git a/generate-configlist-deps.sh b/generate-configlist-deps.sh
new file mode 100755
index 0000000000..a873e976b6
--- /dev/null
+++ b/generate-configlist-deps.sh
@@ -0,0 +1,5 @@
+#! /bin/sh
+
+printf '%s\n' \
+  "$MESON_SOURCE_ROOT"/Documentation/*config.adoc \
+  "$MESON_SOURCE_ROOT"/Documentation/config/*.adoc
diff --git a/meson.build b/meson.build
index 3a1d12caa4..eb6a149c9f 100644
--- a/meson.build
+++ b/meson.build
@@ -720,6 +720,7 @@ endif
 
 builtin_sources += custom_target(
   output: 'config-list.h',
+  depend_files: run_command(meson.current_source_dir() + '/generate-configlist-deps.sh', check: true).stdout().strip().split('\n'),
   command: [
     shell,
     meson.current_source_dir() + '/generate-configlist.sh',

Diff-intervalle contre v1 :
1:  b03d70c9f3 ! 1:  c9ae171eed meson: regenerate config-list.h when Documentation changes
    @@ meson.build: endif
      
      builtin_sources += custom_target(
        output: 'config-list.h',
    -+  depend_files: run_command(meson.current_source_dir() + '/generate-configlist-deps').stdout().strip().split('\n'),
    ++  depend_files: run_command(meson.current_source_dir() + '/generate-configlist-deps.sh', check: true).stdout().strip().split('\n'),
        command: [
          shell,
          meson.current_source_dir() + '/generate-configlist.sh',

base-commit: 64333814d3ac6e46b6b9c308a6398a66743a4022
prerequisite-patch-id: 364ba1899740b93be5957262d3583348d030e8fa
-- 
2.52.0.rc0.1018.g3ad6585c12.dirty

