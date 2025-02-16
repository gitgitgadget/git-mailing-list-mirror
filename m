Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B70B672
	for <git@vger.kernel.org>; Sun, 16 Feb 2025 07:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739690989; cv=none; b=MEUThzQozPn+TaTB7zAGME5/OdBJXPkT5KgArmqDv1wnY7GEEXa/NivF4CFGJBuAIoP/TJD1bEXVEUPezZMnJs13m9gDfahDX/gSMmlPl3TZopzHBMK8UWVB4NPXLfy2KOfjXYHH8AqEB6fOk4HcUWmoY1JPqsLYmNWeSAbfRwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739690989; c=relaxed/simple;
	bh=I6/qTJKimc2lx3D5F8J6AHpzZi/Ubqt2qpfNgAnG6vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7306wNn5aYxbszdqbqrpg2dLHC/KVf8KNzYcoRPtVci8G58hPXmqtZnXPkN32J/nul1tUDxk2PlCpY1r10Gxv7MOokExRTBQqKUJaWZvFgjIFbtgApOe9Og3BrZ0WJyt7AiZah6OEzSW8Jmy+nw1tvnELTtNlMigJfjLD6/2rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPoOAwJ1; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPoOAwJ1"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2fa5af6d743so5176981a91.3
        for <git@vger.kernel.org>; Sat, 15 Feb 2025 23:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739690987; x=1740295787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3Ud96/WWgCSe13VufGNvNpJdf4zmX/kgo7RJSv8AJM=;
        b=IPoOAwJ112SFkVWXFGIlPA1UX5xWARnVOBtwsik3vxv1wmrf1PYUlX3k33iIUgac2N
         BJeLEqWq1XvnrhCZbeqeXYt9mbdKWMmizAuSXjr/Qjg8N0RGrhgOM3Qf9aCn+inRgLck
         sBH8gWvYICbLPbAbk+ePP/s4JckQX4apz7k0vlQ3xBMM+YsdxjkECrAoOEeBokWHTCl9
         oJpER4J9yMlrb0ekB9bSOPnzds9LCALIGSo48VotCzfQaCjje8yvkVK+fTDm9kDEWKmd
         K9l4Mbxe7etyAdDchLR5ZJdWn/2i/xTqxCGuD6fYtyELFq77cCnd3lmx1QBtNnO/r5Ob
         2NFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739690987; x=1740295787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3Ud96/WWgCSe13VufGNvNpJdf4zmX/kgo7RJSv8AJM=;
        b=T/D9SOwl22DG9hZk8QZPNbLaDBdjX0NPtdj+6blPmlUTQon3r3gYWWXtCsdWnsTm6E
         NB7jVfA1vQN/Db+52yAGMJh0svUAl4Ek0wct6IFsCpm6SPKbsWrWYh38xYLSu5dh2SVm
         hvtP5G7/qLYjVeFazs0M6/eqY8OpIQ9JRKgmnAa2jEwHKs9yEZVE5kvZZgTQOvX5qgGH
         33SkoeDm2sXqHX+TFlyI44I3WErhKKYSI2QlF+DPgwGZf1XZKeRnBPW5vP4xvZVLHJz2
         w1CVSssLD8f/+Dh6XXnr38jyFN/kri8qk5g+6tvMQo1U4L2Z/q81JXmiqr8qhRBeQOxQ
         4ewg==
X-Gm-Message-State: AOJu0Yz3HxZewdR4ZZF1WqnV2ouOxRbCS4WCeJkC0mb07oMgjzIQPOdZ
	Mhu1idsROhos6JexAZCA7qQnZNerHsaaLnKr9B9R5M7lItLsHT/6
X-Gm-Gg: ASbGnctMZMBHFUqfhpXVri6+IvsC+h827GLNFShDnK+iibuCXS6VCebqJHnXX+zYsrS
	YEeAQHEjlAiNAxKHQ2yJNYj8SzUybY/qB0qOrpC5h5g/NHbCz4SqEGnBWO0iNeqnrjKKEyu2fBC
	yspqeSq3O8tM9c/qAIS+Tqplgmz9iS0yVTVBeYD9QQsNxENxCxHKgZIWbEDVzlU/P3MZejHhVlK
	OfbyRPCaubFKgeG5YsHFSsyabVJ/D34lvVXSAQftpqnRpygmvk8Z3CMHBbFB99QoaJnNcGWC5WZ
	IU4eRKp/gfiKvza9rr7T/phaGjbMyPC5ttgO+jxWbvWmkDWpDC0C4b94dWEmYYuJ3+UhniLDai9
	3hVE14H+YAAbpZDSbd/RreAYD1B0jhSMdLA==
X-Google-Smtp-Source: AGHT+IFvFSdTx78Jt0XZWFkdK3EMK/TM8+3II2dumvo1CMzNZG+TAjx9RhL7fMlbjSSd/m7KJdn+iw==
X-Received: by 2002:a17:90b:1b46:b0:2f8:4a3f:dd2d with SMTP id 98e67ed59e1d1-2fc40f22bf0mr8312042a91.15.1739690986961;
        Sat, 15 Feb 2025 23:29:46 -0800 (PST)
Received: from Ubuntu-ROG-Strix-G512LV.. (ec2-18-166-75-244.ap-east-1.compute.amazonaws.com. [18.166.75.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc327a9d68sm4483243a91.1.2025.02.15.23.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 23:29:46 -0800 (PST)
From: Zejun Zhao <jelly.zhao.42@gmail.com>
To: jelly.zhao.42@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	newren@gmail.com,
	ps@pks.im,
	karthik.188@gmail.com
Subject: [PATCH v3 6/6] apply: enable -Wsign-comparison checks
Date: Sun, 16 Feb 2025 07:28:43 +0000
Message-ID: <20250216072843.72385-7-jelly.zhao.42@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216072843.72385-1-jelly.zhao.42@gmail.com>
References: <20250205014055.737190-1-jelly.zhao.42@gmail.com>
 <20250216072843.72385-1-jelly.zhao.42@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the `#define DISABLE_SIGN_COMPARE_WARNINGS` header line.

Signed-off-by: Zejun Zhao <jelly.zhao.42@gmail.com>
---
 apply.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/apply.c b/apply.c
index 4c26f608ee..f1113d830d 100644
--- a/apply.c
+++ b/apply.c
@@ -8,7 +8,6 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "abspath.h"
-- 
2.43.0

