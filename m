Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EB12309B3
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 19:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741635136; cv=none; b=kp2IUQDonPPAW5eub3BuiDZsEYcgEKwxpFitkZu36pIgUMTMMsIwqC8Q3cY2j68m6Ot56hMn1KgcDYirnoyiRaTM1ZwpVSrrvN6SEs5NvF4xN1mRFy/qT0t79jbvo86dX9jlge5Mubrp8mTiM52HnAVgePUbn//QkuX+HF0Qd48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741635136; c=relaxed/simple;
	bh=opPvqbuSojM7C18Au7j9w0k+hzvHe5F6EHrCLfwU8KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0MtdOYuLstPMtyHMWPI9J0QROdl3lBHia572oE0TQmug3dXmTU0PVBqeWcduFuvIuzaKhVeut+psrV6cONuRP1AUwxBWTUAu83y4gfPscWDdEziGXChcW6DhjhGOb52E0S5hbPOTY0Zna7JUmQF2ySyXz3mds05Qyq2zKPMdRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKMY+dxf; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKMY+dxf"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3f682a2c3c8so2333661b6e.1
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 12:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741635134; x=1742239934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFid9FOUBgE6oHvchTwDzqtDPMt9SuyhXyG5MJ9m4c4=;
        b=eKMY+dxfAtiW8TuzyjQSge0//n9A6zZC+A2KDv+HCDlB3IxKDWVwjaC37UibUaC7th
         7OrBnfu+Jz5wzTNpWjSWllQQq83Z1L+baHFBsStNbFBpfFMLnS7pmr2GjV8cAK6cuLOd
         YsLLMHr5fJ17B1Jy5tODTR4PEfRxcxU1yuF3dT8fQflg5wmTeW/c3Gdm5uEfpoi21jya
         gs/rnYFt9NmLNbS6m3VqczIoc4z5wOb4oKdMURt9Vu0C0rSGt6vWAEW22eUrvf+EYPRE
         gzgIWSmIYDvluvYT4wFsADjx918kdkN/UMmHMzdmgCF77Z40EQnMPkD1svIYygSK00vU
         IFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741635134; x=1742239934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFid9FOUBgE6oHvchTwDzqtDPMt9SuyhXyG5MJ9m4c4=;
        b=AUAno0SK3sR7MQlaFcHzUQ9LMWw9FTuBkXPtA7VzTqBoXdgUp+bq6c76+THTj8w1dV
         uHhygg34fMUwkpO5XGv276LHiXhClFwtU0dBEFHdJhmC4mikrvIh6+2hrP18dePpUCgE
         jPrycpXFb374O7BE4uqNaqd3UlE2zIf5FFOJaT+ocHfDxviuGiWvYfyEnR+r2cFbC+op
         pJP+6E1UonGxlOmUTWOtg549ZJzuCv6yz/hbhHcl+dveQgOjJtTkwh+QfXaRWGje+0UB
         EIa8v8UPT1ef6Uq6rlahCnTW7yfLdQU5YcSVESjlPsh5dlvb5i2fX/lfYjnYL9cXJMpR
         MPmg==
X-Gm-Message-State: AOJu0Yy6sIt9PsmydCOSM4DBTwKWn+DaAU0dLKqNQbcopCBNw7xHnBZP
	uzXA3p8/bVQy0W9kjH1Gq50pK4/2NWD4UIjwqK60bGJsuQshrWcoJI2KVg==
X-Gm-Gg: ASbGncs6jl32mYRGt/RMJGa9BMwVYoxF63mWLOa4YjqckS+VWoRMHJNfkRLPvbrMe1w
	oSRk8/OFQLJAWf7GBEM/EN6XbTpQJpUR/9sagfQhaSKUqzLUeUja5XJ0wseWKIKVDT1/+rJg5oB
	PBuat7WZx0QP+wZ4w0eWE/ez/3q9B2Fy958Jr+1g0igZeECbXTLBPEvub6NpF+KIfPQXkELGxYd
	TRjWh8kYpaWSKyHotsgCne7IKk1QNMlMojkVIBKN/h0mxeubZnQwu9IOltWwl3a/gjPFPRQuKog
	KDMyiSNx0H/ZfH5kcJWsZ/rvVY4jW+f5tayqaorUdnUMMOZc7AQtNGTR9MbfdCw=
X-Google-Smtp-Source: AGHT+IFpgLFAhSSsOw7eyfWH8JN4HnAWJ0nj0k015YpLeDVib//luh8dx6NHx1bLrWGpf+83NQbBNg==
X-Received: by 2002:a05:6808:1526:b0:3fa:3a0:137a with SMTP id 5614622812f47-3fa03a05480mr902335b6e.17.1741635133672;
        Mon, 10 Mar 2025 12:32:13 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f861f30de5sm697819b6e.46.2025.03.10.12.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 12:32:12 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	christian.couder@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 2/4] rev-list: refactor early option parsing
Date: Mon, 10 Mar 2025 14:28:27 -0500
Message-ID: <20250310192829.661692-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0.rc2
In-Reply-To: <20250310192829.661692-1-jltobler@gmail.com>
References: <20250310192829.661692-1-jltobler@gmail.com>
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

