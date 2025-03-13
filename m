Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AC42E338A
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 00:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741825277; cv=none; b=MFcLJbdg8SwzMaq7iQL7ejZkSqL2jm+sIk6M0n6o6+IgWgiAV8NGq/b0vcgyfu5Cl3OUrDBBdDRSMN2s6NSijV6UpHCiPeGZs3kb8Ghy2bvAKzJZuh+o/BhpQINcMKssPUF3ZaWJ8URjEE/pcHEpWxDwik6EOzp8hYCxNR9jENI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741825277; c=relaxed/simple;
	bh=opPvqbuSojM7C18Au7j9w0k+hzvHe5F6EHrCLfwU8KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Byue+duVuuJbKgarIXOxJ11guKVvB0bEBUIIf/7c6aVsbWAjwpocOsCABbAa37WlqQzupQZOQmb1/25EWZKlK98nQd6uI9bTcjl7BQOXD9R2QTf+ndZm1aBnka20x/tKCYSQaIXbt3zxDDs1rgxh5wqYNUUcIxNHHRGFIqbmceE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlXhfnyf; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlXhfnyf"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5fe8759153dso154287eaf.1
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 17:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741825275; x=1742430075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFid9FOUBgE6oHvchTwDzqtDPMt9SuyhXyG5MJ9m4c4=;
        b=UlXhfnyfgf8eBsOLpZkwDgHM2haogXzCqb5jv1XFOhAlM9mpGxvb1PnGF1qMXbxoYD
         3pcGzHT6u63wZcLaidtN3ZkBvkp4K2ZRm1jdj97Q/88tkTElevHfAPkIfR9JnKIGtC3p
         5QLGK2EB9eL8BtfbMFAXbNwAK9FIbNb5EvIgfMpMZ8MbKLbL2RVK5UhAjqSv4ETZ0xEW
         +x2I9LkydHEh1sjfvrRvZ9sR+Zz494QsR2L6R0oNXb8ZlpkzIdHG9GqA4YvsVOGgm8v8
         YZJ4TOwjbyIAjfkeFtKD+INKsDwPExWoaWXSfMW+a2FwF6zb68W32/EMWxFgQesa569E
         P8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741825275; x=1742430075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFid9FOUBgE6oHvchTwDzqtDPMt9SuyhXyG5MJ9m4c4=;
        b=t14JtOpWUKZnu5uaWVKJblzPuES74+Jc4fVij90cLQZVb2Xc/hbKC9cb0e9ems7RGN
         pm3yr4wW0UEp7kPdqPXGU+ipNDOZ8O2Rke2uLrz9c0P6lMBHWrM6Uvt5IkYNUY8zG17g
         n5BTlRXr3B/8Za7JFWuRfOOhZchTVdWwwSCfOcFtc2V4u/jhmSU6YluQmau2BbQ0p1WO
         At/Ky5T4nvQrWXYiCrlhfpkW+HVzKjsFXFSL6LN6K43gyy40lETdJYTwAA18MrOeCclP
         BCCI7Zn1y7d3jZSdUju7O+Vv4Vt6BP9Hk1gAJELbaMXB+Her2uyc23aj+2dF72HRUcLH
         228A==
X-Gm-Message-State: AOJu0YzqsPZrwLblaAeVVW+WClb4QbmBtMKekq2beiMPslEcRBLFPou5
	0b6KhVECCcrLXUz4Jsbwg9N7FvgPDASfUIp3j3wWYJeeT1Tyw1PpYMKd6an3
X-Gm-Gg: ASbGnctRavSWGgguJE46h59JglBZF8hkReE8qG+KwjfGrSxd6zGjOXyOUsY/jiv4fuL
	XsUtmG0Ng5PEGa6VLMibXwO4MxC6ho1QAShG0VlVvWOTpwmWKwyp4dw3kkOI6YNcb8zAATy2GEg
	eFASkmxc03E3Xpvd9cNsViRddFUkGASYvOiuPTFbomSPG6Jp2JsqvoFZUcdQP6p704vf+2N5lTp
	ceYwTqk4R41xH94JeHQuF8ELfCYnH8kz1Huur3nByyKvIsBI4YFdj3wM1vgqzIXD/q4fmhUuvx2
	UdphM22N4Zun8qUMQ/zx47TEjAnBL4QzX0PRSy+XSXJLP6psJBbV
X-Google-Smtp-Source: AGHT+IFpWLw2uJSIs6l5Ta2td7TB5ZK4ADvT3FaAIWR8SC3OsajkrpSJX7qr2P71dRMi4o4f5Zr9lg==
X-Received: by 2002:a05:6870:d285:b0:2c1:b58c:c0c with SMTP id 586e51a60fabf-2c26138a516mr13298320fac.34.1741825274901;
        Wed, 12 Mar 2025 17:21:14 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72bb267a8b4sm24028a34.9.2025.03.12.17.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 17:21:14 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	christian.couder@gmail.com,
	peff@peff.net,
	ben.knoble@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 2/6] rev-list: refactor early option parsing
Date: Wed, 12 Mar 2025 19:17:02 -0500
Message-ID: <20250313001706.3390502-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0.rc2
In-Reply-To: <20250313001706.3390502-1-jltobler@gmail.com>
References: <20250310192829.661692-1-jltobler@gmail.com>
 <20250313001706.3390502-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before invoking `setup_revisions()`, the `--missing` and
`--exclude-promisor-objects` options are parsed early. In a subsequent
commit, another option is added that must be parsed early.

Refactor the code to parse both options in a single early pass.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/rev-list.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index dcd079c16c..04d9c893b5 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -16,6 +16,7 @@
 #include "object-file.h"
 #include "object-store-ll.h"
 #include "pack-bitmap.h"
+#include "parse-options.h"
 #include "log-tree.h"
 #include "graph.h"
 #include "bisect.h"
@@ -639,19 +640,15 @@ int cmd_rev_list(int argc,
 		if (!strcmp(arg, "--exclude-promisor-objects")) {
 			fetch_if_missing = 0;
 			revs.exclude_promisor_objects = 1;
-			break;
-		}
-	}
-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
-		if (skip_prefix(arg, "--missing=", &arg)) {
-			if (revs.exclude_promisor_objects)
-				die(_("options '%s' and '%s' cannot be used together"), "--exclude-promisor-objects", "--missing");
-			if (parse_missing_action_value(arg))
-				break;
+		} else if (skip_prefix(arg, "--missing=", &arg)) {
+			parse_missing_action_value(arg);
 		}
 	}
 
+	die_for_incompatible_opt2(revs.exclude_promisor_objects,
+				  "--exclude_promisor_objects",
+				  arg_missing_action, "--missing");
+
 	if (arg_missing_action)
 		revs.do_not_die_on_missing_objects = 1;
 
-- 
2.49.0.rc2

