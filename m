Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD3C6125
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 00:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741910506; cv=none; b=GMqsFtQ6M4H42R9Sj7p/BAcL48nhSU4y/i2GytkkhE++iUE6AncSxm39KP9XeHl7vKZdyJIPiJ2oS3HLDGOZvV9AtOnrd6LgxhiEjtiZCchSEWW2gEaSqm5iyGUtCWPcXRqbmEMTYDiJi2l3YFr4KqvL7cjol+xzJQfhXDzW5rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741910506; c=relaxed/simple;
	bh=opPvqbuSojM7C18Au7j9w0k+hzvHe5F6EHrCLfwU8KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BlUSktoIFBXwM6wdXL6llAEi1gIuWxOMy80mNuZUxEFfuzTGyLLtTMxfyaK4MQ6I6x0ZXCzyrwwEXURQuah0IVCPhOM9Ma0x7FKUN3nQhPWwK/BKcYOkIVa4t8UMSZqmzWJLuO9M2hKWB0+KUP9u9aEOUhEJWTBI6dgvTEmq1jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZh5S/9s; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZh5S/9s"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-72726a65cbaso1044736a34.0
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 17:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741910503; x=1742515303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFid9FOUBgE6oHvchTwDzqtDPMt9SuyhXyG5MJ9m4c4=;
        b=GZh5S/9sddXdcfK+Y+tghBBW6bZVlQpKPGDxKhX8iFwYGnWWp9Z0ypGOWRY/7Fmy7k
         cy1GC65YznxVhGa427ZHTuyuTp1T0PYRhZweEZenYBb0w4iQCSjblfesFdt55ecpSkam
         gfDnblmSP/wwrrBc96/oEJNMye8H/TQvnkuuizRHq0bXSoYJQbJsvqXd9pdA1+nRBU8G
         Yyvjjroz5J1G9is+91u59NguG7TBnaPhpcre3uHZJyWn11vvWmVmYQY0V41q8vOzdU/A
         0VuxNbYA/0SsWRzSkBXz8EvvWO2m/+VsP32A5PzEjhNtub2sxOFM0Uuc+QyugWP4HT6t
         vMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741910503; x=1742515303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFid9FOUBgE6oHvchTwDzqtDPMt9SuyhXyG5MJ9m4c4=;
        b=XotBVdDsQfeIHd4ORAwfvjWVZft3z3DQRyyHr0Rfd0HzpNrJ380Llr9e389Pk3A0vK
         D9172iTUY6ufAAWrRHccoRwHUnSSJDDESPwpqIYwIuWOQwWnJpJa+8ncWVoUsavRIjhf
         6nKGuPVocS2JgUU4QCeav4M0KaQc5DDDni7g+t+AEzuD9xJgH22291amBLAy3REy5yXL
         4g75ekRJV9ZADnZBPIgpndjOUCfJexmSE1MaUcFeCagcTd1wDIwUqzdm0GzwMY/8opV5
         mywlfgaBqx3fWC2NcSpxzoz2piNRCFYtSCOFDEhuev4oqeQ05srJLjSGIpoQlc/VvcfU
         i7Bg==
X-Gm-Message-State: AOJu0Yy4Z839s9GBWFvAFFY29oxT9ZUcQdknBMFDECDOX/0DyYCT9R7T
	xN6xGEAJmI2DnHsAwo0c6kFewbkGYubGfC8s7o/qAPYOQPcOBCtBRUOQRg==
X-Gm-Gg: ASbGncuFrs3Qgnzm9W51TOHlOX4B80BpxpxJuefaspsSX9W1+kQnGVdKqmOmnNASP5d
	xAOhevmr8cKZtdh1hP1pZTC3M54GtW8QCgz+4VeZ1GMGEsTP4Nt22cZVXriiOx8Ev4dmKNuJ5mE
	8h5lpUFQTexPsjfrECK/PBPmZro+f3TYMA51lUnFasieVMqlysR6q2FhdVVmpxwWqtlNE2lCjCz
	8P6dtHP0cT9fbsH/YKc4n9CFIKSxUv8pNDtQy1kOwKfMHcuJvIPS6a1fZ5+u7SV8WBV+BAU7sXV
	6z2uF2kr0MPuz5ardQ+X2pkFKbWlRAtVNuFvIJqfiqfL8aVbtXCI
X-Google-Smtp-Source: AGHT+IEAwhe15YGMuqY4OplZv+lxUEsA8kHKx2IKkR273OGEhPbbL2qCVrEUKA0/Z7iX4LVPtuXf0g==
X-Received: by 2002:a05:6830:6995:b0:72a:3a7:a07c with SMTP id 46e09a7af769-72bbc254470mr249406a34.13.1741910503357;
        Thu, 13 Mar 2025 17:01:43 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72bb274e973sm423485a34.43.2025.03.13.17.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 17:01:42 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	christian.couder@gmail.com,
	peff@peff.net,
	ben.knoble@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 2/6] rev-list: refactor early option parsing
Date: Thu, 13 Mar 2025 18:57:43 -0500
Message-ID: <20250313235747.9583-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0.rc2
In-Reply-To: <20250313235747.9583-1-jltobler@gmail.com>
References: <20250313001706.3390502-1-jltobler@gmail.com>
 <20250313235747.9583-1-jltobler@gmail.com>
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

