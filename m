Received: from mail-yx1-f68.google.com (mail-yx1-f68.google.com [74.125.224.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2283002D8
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 21:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770501593; cv=none; b=t7A+fO+ZuB9GxuFQmpGTEEsFlq+GgMRJHtsZFBjweWBN6UCla5JnonTvNKwkRPfouALpruVDeXXRt31Gm3bo+M1ipD96wQwzODz6+OXrJq1qY/RAxWAFyqLnr4IprZh95PfPoQYZB+f5CgRfraD7dT97QNeVUb/X7lpYJjbWpys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770501593; c=relaxed/simple;
	bh=hBO7OPbefuq77g7/cakTEYd+/56t6UPeNnzKCypemDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U8Jqhi4QLpUlILeFX/NZr9jKhYpHFdYBZBcWhuw9QTZlnjdiGk+HxZu9v/EwQvfElZIJ693LGMJjuWvMDkH01iJ4Lvmqedtf+P6389LrLKL4svF8iU6Nw5TRKA/0Qst01HFwDnSBLrEmlY8OT2M9jWVvIbbfXbuXRLMBl/o8T1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtpmI1JX; arc=none smtp.client-ip=74.125.224.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtpmI1JX"
Received: by mail-yx1-f68.google.com with SMTP id 956f58d0204a3-64ad9238d8fso533280d50.3
        for <git@vger.kernel.org>; Sat, 07 Feb 2026 13:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770501592; x=1771106392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vf4QaGAKbY0VaVfLj5TFMfQOPi0FcFxZU9EhUnlXb0Y=;
        b=VtpmI1JXW00T7xeIk+bHU1vYeofMCDKIZOIH8VdaTlUqB4QS43j4qBu4DmQbOE7nlg
         0+dzJSp19RraVfAZDUNdKcLTfR6I/MyV9rJ8l7olYgjvAYHTQxEEXDqqPTUtORDFxPmq
         ASPYR/uWFndELPw4uWVnrR6bySglld/1dareCu3A8oEsCgwLt8jhBvDsAlz7CmOjUzPs
         WB7sChsYH50mAr9+Uj1HklHIsNxLr/g4KySWWIiqG5TUnkb4xjfihBhDJBbq/hKWwYz+
         BsKHndO0GQfKUv2H8XendTBSv4RZumbUCQhZuvevO4zxOUv0oqRLvPB9Y/JptfqKoHeN
         dU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770501592; x=1771106392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vf4QaGAKbY0VaVfLj5TFMfQOPi0FcFxZU9EhUnlXb0Y=;
        b=shSMYHRwmlt2Nlkdt3JUVqx784d3NsxkgdEJ2Zkvk7Pw8qRNDkoxbKFfQd+Y9VPbNM
         HwnXXsD+sYQ1QWORPQbMz00UKp104NiKD8+0aY/m1RN+aaKFa8t1JSwOBEEnoerlT9Ru
         eNrRTr/wXZmUslozjYckltvXHgRIDKOlAaXfVznCJd3pThQH5wz6f6EfGyuBjN31Sk0I
         iwHhIe8FnMSGiGu3O4SfcE3bTnQgplkAs7xoHi6JPjhnXZKq0bvYlQpyH5lRI4h6i+Lh
         OHE/jphCJnqNoy62H7iTWBoHxshE2bVRt3Lgy9c2NTlNU37xfsH/z/TyHexBiaybnX0+
         qrEA==
X-Gm-Message-State: AOJu0YxKfquCy0zlDzwxe+fpCOkH5NxR9zIcLDysVYmOYIovrWqMS+jK
	PransFAWHZHpwMs3Rz7ijm4ZGyXiTNMdQatfAPxD+2+/ucjSCH6oNY4aaOuKu4OS
X-Gm-Gg: AZuq6aKVc7oZ/tE7ImjXm9RapJDCJYqbJUjjQPpPqvvE/KQ5m4lWbEr8afv1fiZnT5T
	oKtmAB3WE843P1rB/1bc8tfN13XWwXabBofXqTu4TRiWgMwUVudbiTd36y0O+W76fkBF27fCftk
	R5hgzoQesnkAxjK3jSCTIqXttm55hT+fF4COAg6h4oq3RAroJqgz1JJy0mQRfE9h3jhW5TvWguG
	IM0ouBkHDbruR/JLMEgetEHUn42Xl7mANJgnu9WaGzz5F9TpJYozEvamGSc8nKmkAfjnpnG1E4E
	9kBdEqaS3lipD5zoIDpuPiTyGGu61Uh6oJ9WWK8Ro1WyKogbLI7IoQEHpaFXwj+YZsvY+oCUN3G
	gkSU3JyWcxljxTJG6hGYHnsPPJnqTYsVo0a1bWNooVmgVCRg0r17DLm28yfINut8/MuyYa2gr+l
	1B02JbrRCRNvKgOSc5oI6gOg4AtLvSy437UtB2QEUbr7E0OL3X3ywAmxoE9uAZOMr7wFtlwWln2
	qR8
X-Received: by 2002:a05:690e:134c:b0:649:c2a5:c6f2 with SMTP id 956f58d0204a3-64a1c29cd44mr5712225d50.86.1770501592443;
        Sat, 07 Feb 2026 13:59:52 -0800 (PST)
Received: from localhost.localdomain ([2605:a601:90eb:5600::9])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649f255ea25sm6005262d50.17.2026.02.07.13.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 13:59:52 -0800 (PST)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Evan Martin <evan.martin@gmail.com>
Subject: [PATCH] meson: regenerate config-list.h when Documentation changes
Date: Sat,  7 Feb 2026 16:59:17 -0500
Message-ID: <20260207215924.28863-2-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.52.0.rc0.971.g305ecc6b61.dirty
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
index 3a1d12caa4..4df7caa206 100644
--- a/meson.build
+++ b/meson.build
@@ -720,6 +720,7 @@ endif
 
 builtin_sources += custom_target(
   output: 'config-list.h',
+  depend_files: run_command(meson.current_source_dir() + '/generate-configlist-deps').stdout().strip().split('\n'),
   command: [
     shell,
     meson.current_source_dir() + '/generate-configlist.sh',
-- 
2.52.0.rc0.971.g305ecc6b61.dirty

