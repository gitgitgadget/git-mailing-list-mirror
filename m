Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9221A3142
	for <git@vger.kernel.org>; Sat,  5 Apr 2025 22:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743891383; cv=none; b=TxQI046tLlhENerz0VhFWnPKvgLbR8/Ch8svqC5yoByX7cTGO4ahjMJcQcDaXvwJdESITsPHABrQkLfCtVm/YM7LInJOHwPrcnZ61EX3pIzIe89km+U8jUuvn6l9Nx4dpEioHxWUeRKJrACgvS6H/rIC2cj+C2FkTRk+KuzPy18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743891383; c=relaxed/simple;
	bh=z8LfGgLUPat5lQgkwY5bahZbvOjNOBCfro/4+Vavk78=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Dun7RLsUkl1+eOWLZIfC5ScyX1QLAP4SMTLNnTXHnXjUxkMG+DG877T/P8FGnRKj/ACr6wUnL9zPpBRgVahRC5qMRGjy21UPsyjCl8qwmrivHzTyI82ebldCEeafmctZtxv9S4axmpvITB6L6/AC14oQ0ghmPWd6r6KoDeDIFFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eg5qVOE2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eg5qVOE2"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43edb40f357so10597335e9.0
        for <git@vger.kernel.org>; Sat, 05 Apr 2025 15:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743891378; x=1744496178; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQyn0+ygKamw+2iRagveNFiC1G8x3BKb3kCx/Hvn/tU=;
        b=Eg5qVOE2PFL7Y6/VGyCce9SEYp+KCFpGyC+V1NXnewa03Wuq0Cfa8Dcjg57LgemW9X
         aKbmLFUh3oi1jvE4sH8nrh1dN22YUnA/5Sl5S32CgjrMTRpL6KjR7JMsBC/lam94JjRD
         VYF+Uj2uYaSA8JZAax0nW2yGwc4cywpMcMAa281eV4n6XfdJCf2mR/QiMdowlzo0k8Gn
         cYJ/EGGr3+uGYPGUB2xQRONuml2sWUkXtc1Mtb+qiJYGoFyNNQtYHhOCWg3dZWOfR9y2
         YoWIlzEv0On59BuCwvxpcugJHfBqUTeEp01iR58X1x6I6nfMfSwCQNz9Tmps20f0nkIs
         5BZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743891378; x=1744496178;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQyn0+ygKamw+2iRagveNFiC1G8x3BKb3kCx/Hvn/tU=;
        b=ZYjVAIJ/dwDgya9druknqLNLmsZb4GVdXKOilxC6T82WiKRsHlessEsh3Y/TyrZlcd
         ToQ2wqzcSWwuo8jl0RkBS6ZC+lwGZqrE1qAyPxNqLX/+s40C2ET9ftALCU1xv1jMiufv
         eh0yQHptrLo0As6y1Pjs61wROGMJBEi4A2+PHrt1yWtTQVFk15qMMCO1AtR362KDN/Y5
         ajBQ/bUaY8DGeJGqX3PHsBIq8Q9pZ59tfn8jpUcfGfDt55uJA98jCMgJ87NTIvikbFZK
         nZpn0uZeXFDM2pSwPnfRFfXiWA6EVY+45xncL8kLP6eN/LX5b1RNt+G3N8lWKvyZf9Bb
         ca2Q==
X-Gm-Message-State: AOJu0YwxTzOygAImq79qYJNa12HRHs5XEV9cx/9EIERWtR6p4b6gxlZ5
	UGLBNccYZzddsesYJDcwXP2Qn+fLrhIYA32GS+lKPLzdJWZyN97SOCdyvw==
X-Gm-Gg: ASbGncs9V+IQlmyh7BunCdEsoekLFO1rrPjgfQ0IHzbPbzsQn/PjzcOUFM2jLIH/6C7
	JRg3GDblLfp2vH2iTqrlQx3yF1uhkoYvysYdlHTb3LEgUEau6hvh1leOF6961FbgqtgFMA4oV4q
	dD+vowd5FFPWzUaK9VJ95xnRRubDVovrB2B5yfDa2aMJgvjcu7Dn6D5stSk5myM391NdyivjK5Q
	w8xaO7AcR2jTzVKBbtErouMMGK7+3dnPShJ+AMdSBcVLwnTIcOJqLIWpDF27IwYdTfwlYmr3Roq
	C/bb/+NqHWucSnaIpRiczAvFHgrEeSHsePl+lESAo9WsQA==
X-Google-Smtp-Source: AGHT+IFspcqCjB51ciRTn5Rt4a4viEUFHw/+ePOsWjym0N6OibkxZdU6s6IS6ejDhrffCRQzY5bhug==
X-Received: by 2002:a05:600c:a013:b0:43c:f8fc:f686 with SMTP id 5b1f17b1804b1-43ee0616fedmr45837225e9.3.1743891378517;
        Sat, 05 Apr 2025 15:16:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec163106fsm88959215e9.4.2025.04.05.15.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 15:16:18 -0700 (PDT)
Message-Id: <0e150ee90659c89399bec614902077729cb2c917.1743891375.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1898.v2.git.1743891374.gitgitgadget@gmail.com>
References: <pull.1898.git.1743436279.gitgitgadget@gmail.com>
	<pull.1898.v2.git.1743891374.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 05 Apr 2025 22:16:07 +0000
Subject: [PATCH v2 1/8] checkout: replace merge_trees() with
 merge_ort_nonrecursive()
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Replace the use of merge_trees() from merge-recursive.[ch] with the
merge-ort equivalent.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/checkout.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 01ea9ff8b28..67879e72362 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -17,7 +17,7 @@
 #include "merge-ll.h"
 #include "lockfile.h"
 #include "mem-pool.h"
-#include "merge-recursive.h"
+#include "merge-ort-wrappers.h"
 #include "object-name.h"
 #include "object-store-ll.h"
 #include "parse-options.h"
@@ -907,10 +907,10 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			o.branch1 = new_branch_info->name;
 			o.branch2 = "local";
 			o.conflict_style = opts->conflict_style;
-			ret = merge_trees(&o,
-					  new_tree,
-					  work,
-					  old_tree);
+			ret = merge_ort_nonrecursive(&o,
+						     new_tree,
+						     work,
+						     old_tree);
 			if (ret < 0)
 				exit(128);
 			ret = reset_tree(new_tree,
-- 
gitgitgadget

