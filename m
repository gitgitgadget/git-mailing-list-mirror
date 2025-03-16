Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06041607A4
	for <git@vger.kernel.org>; Sun, 16 Mar 2025 06:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742108345; cv=none; b=aM03xF9WPfkirzC7XscWcqS8veiOBiqlqYJMskUxD0ACgBnqx27cy8jrOooaT5T+rp1zAwm+A/pvWP5nP168hEIRHAGSBX2WfVWZQNJotZGUtksccVgYK23ROwXC/U/wN5GDdvSN63ctTZL+B0SjOE/ug1vwoOJPQTCehrU4tz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742108345; c=relaxed/simple;
	bh=yHlLk9SgvXiUzsnoUISUW1/3AL21FRMC/Cu7Nxosh8k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=upei1zUWmjAHCZsWPj9ZYz4bMaLslg7YzZ5evLgsMww84DWicmrp/1EWY7oNfnO3SrmqPM4Mah+yW7WoPnLcLpUEDgQrlg6UOtsHbiPPpoWO0IvJUZlzV6hGMDcs0580BEdd+Qqw8Mp46eDAwkJrv/EL41kXjlp00OX820E3uC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fO8Oe4ma; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fO8Oe4ma"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3913d45a148so2894468f8f.3
        for <git@vger.kernel.org>; Sat, 15 Mar 2025 23:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742108341; x=1742713141; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CInsz9kDRFmiiZu/iUlaQANJTE+A5207nrZxmibar8g=;
        b=fO8Oe4maF7yursqGExJtjkx26WYXmlI0MIUr2kjT/kPd3jZ3eS6H9XDCbx1WrDob3K
         wX/SqFMpAWW5Y9Ba9p1PBOAgRcfwGezoDfYboeDC+Xs7vUX1F8zknfKQnbeaGeN/23AF
         JFFxMXa09w/hsB0iLEoXn06GNBKqPar7E3uux8ejH79KfdKWyusL7llAdukkPmnfaBBa
         4HF5Xzbh/U7hKQWCVB6pIMvvqBgoh3arvkdYd6Q3n6piLVNwf/EgjhYMzcRZZPHGXPkr
         dxkhqn5OjlOnveiZt8g7cTl1rir0YNNtBMLbm4V2QPXrHfEUOv/DQUJkKEp+lZJTYZ3v
         tiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742108341; x=1742713141;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CInsz9kDRFmiiZu/iUlaQANJTE+A5207nrZxmibar8g=;
        b=lyiWep9f4yScXl26RHdXTjQoRSM//SwnUlux/jlPoXRE0BBKquaTAQVMOUY3ZNtTD5
         g/+AVPIpMtO3USS3Sy3NHNc+uAhYljySPFIt/1bskBczaL00C5YqULT3px+5eTHSSiBm
         T+XizXFuXCyquH/LGr2Iee7lJeInKq4aDDHFTbZHky+RDmKn4FS+hOj9gcgIZ+WHkRzO
         oim+JrC6D+HiAOz4YLkDnamARs/Ue0zI92tvfZprtqtnIN1OsZDqLbzwfKxHEbZ247Ea
         XeNZPqYQyPEWpITEDrfPxzaiOXEdgOfQIThlFWht2tdFN6PX2DB6Cg/AzRLEXuOQMg0w
         1MeQ==
X-Gm-Message-State: AOJu0Yy7Lk866deIXJN3jee8tLOpcLpXIBLdPdccsfqjsyfD9rEkobCw
	/X3KoAnECkCWWwNCOFUcvu6r/x5ackGxDGpmw8LiJWC+xLhxZM059GJS3g==
X-Gm-Gg: ASbGncsWqVt3MgsoLq2zi/oNddUJI9Cf32vDusG6kZHh2ZMc9U3KqHpRoccmYONpwmr
	ytBUDU/TTAfwbXFuQgKfBFfHKudqgFXgRzyGGho7pX+S7ZrRlEt9yenXIVmQUA868laNqW0CBtf
	49u7DiuQhuuf2iBnZ6BqqSdhg+qWnu20vi9nt+gG9M0ypvBQy0Mhh1NM2y5ZnKCuBIPoqdmLkw1
	iUy8BmdgUOw6tDUQATS2vv6AX99zLDyKwcO4qnPa7/04CMiBIN9/ReqdzucIp9a01g9rN5ZffCF
	lGWcAWLND2j8nAKeKrdNl3yq4eMNci8uoW+714sdBvvCag==
X-Google-Smtp-Source: AGHT+IG6uRYodR0/i1c4rRgb32rSTHZzD7MszZDk4/V8+ksttJphOetb1QLDO0//U0y6e5fu7l/cjA==
X-Received: by 2002:a05:6000:156c:b0:391:456b:6ac8 with SMTP id ffacd0b85a97d-3971d8022f9mr10236435f8f.24.1742108341559;
        Sat, 15 Mar 2025 23:59:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df339asm11051715f8f.3.2025.03.15.23.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 23:59:00 -0700 (PDT)
Message-Id: <d5611e8d666520d174c3839c10d55484657bb1b7.1742108339.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1882.git.1742108339.gitgitgadget@gmail.com>
References: <pull.1882.git.1742108339.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 16 Mar 2025 06:58:55 +0000
Subject: [PATCH 1/5] stash: remove merge-recursive.h include
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
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

stash was modified to use merge_ort_nonrecursive() instead of
merge_recursive_generic() back in commit 874cf2a60444 (stash: apply
stash using 'merge_ort_nonrecursive()', 2022-05-10).  That makes the
inclusion of merge-recursive.h unnecessary.  In preparation for the
removal of merge-recursive.h, remove the unnecessary include.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/stash.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index dbaa999cf17..cfbd92852a6 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -13,7 +13,6 @@
 #include "lockfile.h"
 #include "cache-tree.h"
 #include "unpack-trees.h"
-#include "merge-recursive.h"
 #include "merge-ort-wrappers.h"
 #include "strvec.h"
 #include "run-command.h"
-- 
gitgitgadget

