Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3567C24211
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813724; cv=none; b=gzPuGsTfDkg4rRYGSTiw6Dgn9w+okV4qOEj4OQPYnBM586O/QngOo6MVEySLUwXN0+KHi1PLP0Q8mC6Ggff8L+Cp5vFgN0cvfgjLX7p6Tn9+46J/JCV75dKPuXUaOJhll9d2tDoI2pbebY+X+KNe+b7Iq/dKXau6fqpuKQEHJhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813724; c=relaxed/simple;
	bh=4tXWpJHmXJ81JORgGGgPuPoD0yIYiVuZcz0S4p1MMlo=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FyLq8pvbPsbM61ADxzQYk1LMnMpYqAIe4JLvT2lUqb8dq6NyKSi0dtd1TEu3VUvcAkmIYkHSYPr59zR93VwH4Yoh19W51pWMNnNVN2UJqB5aPGpCRrRAFwk9oqS8t4TzwLQGClS3355IxOijuC45UD04vYXbsmtkZCsipuo8Pv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGGNWFTU; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGGNWFTU"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-410db155e57so12086075e9.1
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 00:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707813721; x=1708418521; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dayC9VH7FeXOIUaYFGKaD/5B9RiZ/xqRFScCbcT5yN4=;
        b=MGGNWFTUGvi/eKrEiIpVqE15kbl22irhTa5otXEHjoeRjZRaYaNdxoG7SxvaD+xaCG
         VtKvoYQsmc26BLp4uTkTcNrE0V0fq491byPsypRPCEG6M4WEelb+560WGDdMpPcLTnCj
         QX7kE1XP5Es5nzlkBTL2WNAtR0U4bqr+oniT2iS6RSmnbnOer3CcmXZ862Qo+7BB1TS6
         SwGMyklzAkBUMuJZlRYq/2Y+BTl+VC2kUKEAZe58lpIx2MwFjNYAxy5tmfrw/YW0sZps
         GDiBwOogXLzMYubITZpUDthDU5YwnhakPkYtyw7/g8nRVloAZH5R9UC/teQwo1dkvryn
         /Axg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707813721; x=1708418521;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dayC9VH7FeXOIUaYFGKaD/5B9RiZ/xqRFScCbcT5yN4=;
        b=VCAEzIJFhOmHeaer4BwmhB4oLI5Sw6FMWqeD81eGzc6FZRw9KTAcddlaCDY2cs+O5K
         jYYSwpUUaJa7poJHWGfyviVd4Hyv24RccqoUP+ZKD8ZEuMzJpmBLfsgxdeOwjuLpYIjd
         58ruUV9sDtSQmOqfhMPhwQbvn9VG8hrMv53syZqedo2Ao4iaOFjpDK9YgI46qYgw1Zpi
         e7wv7o3KD7mgiUyzgp4h9sSlopREzMnxxIKPjjui+telP6GFkD1pBrc61porl4bCOEI9
         RtWVl7NtW7EQNQnKvIQrgq7FGZJ2r4Dipiu71IM3pLOwPaeMJYD0TEdGQVN+2HZc9jY5
         KVmQ==
X-Gm-Message-State: AOJu0YxQoDSPwrOodaiH5Jml5i0KOGrFnUy8b6MtkOPLmgLkzLa/DVfN
	W8yLT8gtIuDjj8cDjV5Mslb5iBQmjLDabXFhRgn+HEzUWk2duADM3lLS+0mV
X-Google-Smtp-Source: AGHT+IGTiBoubDh9u4yqHY68BJ1qtmo+1yuL/ZoY6rN7xGBjg1S0KPch1Y2GDmhFewGHFzKXXQPA3Q==
X-Received: by 2002:a5d:47ab:0:b0:33b:523f:2aa7 with SMTP id 11-20020a5d47ab000000b0033b523f2aa7mr8468513wrb.45.1707813721173;
        Tue, 13 Feb 2024 00:42:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ba24-20020a0560001c1800b0033cdf4bea19sm323515wrb.9.2024.02.13.00.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 00:42:00 -0800 (PST)
Message-ID: <33894600ae77156ba022ebba6cec4f2b24c77cd2.1707813709.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
References: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Feb 2024 08:41:48 +0000
Subject: [PATCH 12/12] paint_down_to_common(): special-case shallow/partial
 clones
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In shallow/partial clones, we _expect_ commits to be missing. Let's
teach the merge-base logic to ignore those and simply go ahead and
treat the involved commit histories as cut off at that point.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 commit-reach.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/commit-reach.c b/commit-reach.c
index 25b39c302a8..4af60c2501d 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -10,6 +10,8 @@
 #include "tag.h"
 #include "commit-reach.h"
 #include "ewah/ewok.h"
+#include "shallow.h"
+#include "promisor-remote.h"
 
 /* Remember to update object flag allocation in object.h */
 #define PARENT1		(1u<<16)
@@ -115,7 +117,9 @@ static int paint_down_to_common(struct repository *r,
 				 * dispatched with a `die()`.
 				 */
 				free_commit_list(*result);
-				if (ignore_missing_commits)
+				if (ignore_missing_commits ||
+				    is_repository_shallow(r) ||
+				    repo_has_promisor_remote(r))
 					return 0;
 				return error(_("could not parse commit %s"),
 					     oid_to_hex(&p->object.oid));
-- 
gitgitgadget
