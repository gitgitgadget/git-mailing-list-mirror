Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1804E34F24A
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 12:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770984385; cv=none; b=bbATXzDarNfBq/ZcYfKLrGEio1qmjZOo5oJtN76MSc9gX0mFdbYq9nWdaQPbFfDsmx0ajTSxpk9NmtN+2t06/AZ08YHe+oJQBAZLUIxLfPzH6IKtN5H/o/s8KOAmXeJfBMIZBYb3wM8Cnz8JLdeeVhK75vqyOIKy7JDUgRdS1Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770984385; c=relaxed/simple;
	bh=rCfm5xrVrSg9LBkKSI6RonQGZmn+cOUMJBWOjZTpo48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fX0tJm8CwVLlnrFd3jNpJdtGMq3wlUqIyYTfTj9THPZrk6wpQaIgVuZSDyZVwVFaJE+qr68+4gan6szp7okj73m/oySEa+VyAvcm+ozgU9t7o/vA9FbXkNrTgOftEwuOuW5w14xqOYyAFtwPu+U8ePe0dn6s9Q46niJBEvYc848=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOHh5TJH; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOHh5TJH"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-824b5f015bcso1166339b3a.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 04:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770984383; x=1771589183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dFEsRsFrh0rem2Vy3gH9vFNJ1Xn7L7CNlXdGClR1zyY=;
        b=YOHh5TJHK753gLlWSn34yimXIkq3c+9TZYCMG967HFYUlJ0Y6wGkCXo8HzoYacvy95
         Ugf1/FnCyGpeMhd2xWi+MZ/RkmbBlARnCnQrdTrHBpumB0Kwk0f7xe3XbaA5MQjzU5FL
         5ixfUHOZDqmFpsMP5RCYKYWW54FfXmARViDSI23I2yceA+mJDCAzx7BYFtg0pK4DNje/
         VS1pH/4ci94co5+61eQCwoETSXCFLO0kSm9ZMVTw2y1jK723moUevp1SM4E/B7nLRXFs
         HHqp6aszQtig2JEQNVSDojR0jnR+uWPJGTd6jRDApSmRbKT0p9C8bH+sDw5RZYbRSu/q
         S1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770984383; x=1771589183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFEsRsFrh0rem2Vy3gH9vFNJ1Xn7L7CNlXdGClR1zyY=;
        b=LRtjyzKsw3zzX6/AjG7WbQC16oiZ+FlSsmaW4vE8KQD7dUhlDZZO4INsGc2bAO3QBj
         CnU7DHwoSdUoVN/mt0Tk1uB1IkSOuWR+S9CrAtiJ9z0wzYXSkqzIxQLrf7E2qU26sHqp
         SatOCPK7RwiqYbily07ax1jOaM3wUAfBI170+axqPinQxXFLSnchjrvixTXkmzNz8tMr
         n5FKLPRkUKF3HFRiAQyxmy7gobn1Tdb9q14qY6tQr6RRDy8plUy8Q64v1YGKtQs8JiuO
         MunzT0CHkAwjaFHgCoxFWmfwMRRL49x4lOJHodcN+UFZbkUQ9vi79lpOXE0w+yPQ767V
         hQBw==
X-Gm-Message-State: AOJu0YzxNjbOB+FV4HmTOXrCUB+3E1N3QbEbDfLcV5OJr8F+/SbQYFNU
	LVhbP9Tac0jEsJDb3hVhCfZ9sYHt8mWZ/Can4ysaq3xNY+S0O/0+wc7BFbf+2Q==
X-Gm-Gg: AZuq6aJ7xAaw8PtO4zFcYNWrf6K93lumVbH10BtjQ9uhEv4UjtTmsqsn6zOjLjJeBXx
	Pch+7r9uboROt12yE2ub4xCMuYXjCM344op0rFTh+RzMxjGvjRPvsKo5mOJ+Ckawomru5GEq0gs
	Sdb5N/vd4IPohndAocvvyfe+oXPSOHPWfi37BUDxI/S+GKoFFzuM78n7h324L6BNU3RHby1qMGz
	Sxtgsom0UdVLEQYz6a37o0VAXMWZMGI8QFyVbMTN3NKoFEN9bzxDoT6gBoRB8ogT9b8x+rFsyxZ
	5RuW9P+3sbsCeO5H53eB/U3MgJHBOEaWG8IH9K0LzV1A2Gs3GZTGvSPO6iomvcOmXInyvzQPYh/
	LlK/cEXfvZYoSWWq0/tdYQ55Lc70shLMPFE/z2gajDQAD6VnB2FLmPjDBrz8ipo6xHXQUkVyXHk
	EmTunxFw1GEug/hQ+RqF6XAdvkcemgDQTM567HCV+4VwMH2ZJTpugfN7WTtx8=
X-Received: by 2002:a05:6a00:3286:b0:81e:e09d:2687 with SMTP id d2e1a72fcca58-824c5ea28fbmr2253057b3a.1.1770984383119;
        Fri, 13 Feb 2026 04:06:23 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:375b:8f0a:9a89:5610:9cd3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b9a0c3sm2303078b3a.51.2026.02.13.04.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 04:06:22 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [RFC][PATCH 0/2] worktree: change representation and usage of primary worktree
Date: Fri, 13 Feb 2026 17:29:52 +0530
Message-ID: <20260213120529.15475-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While working on reducing global state in wt-status [1], it became clear
that some cleanup in the worktree API would be helpful before moving ahead.

As of now Primary worktree is represented in three ways,

* by passing NULL as a worktree
* by a struct worktree whose wt->id is NULL, and
* in the ref-store map, by using "/" as the key.

This creates ambiguity, callers and helpers often need extra checks for a
NULL worktree, and the implicit NULL form makes it harder to rely on
fields like wt->repo without falling back to global state.

So this patch series involves making the worktree API more robust by
removing the usage of NULL as the representation and using wt->id = '/'
as the marker for a primary worktree.

In patch 1/2, change the internal representation in worktree.c so that the
main worktree is identified by '/' instead of NULL.

In patch 2/2, update the API usage by modifying callers to obtain the
primary worktree via helper and pass an actual struct worktree rather than
NULL.

I would like to get feedback whether this implementation is in the right direction,
and if there is anything else that I should be doing in this cleanup series.

[1]- https://lore.kernel.org/git/20260209134439.14492-1-shreyanshpaliwalcmsmn@gmail.com/T/#u

Shreyansh Paliwal (2):
  worktree: represent the primary worktree with "/" instead of NULL
  worktree: stop passing NULL as primary worktree

 builtin/fsck.c     |  2 +-
 builtin/worktree.c | 10 +++++++---
 path.c             | 27 +++++++++++++--------------
 path.h             |  9 +++------
 refs.c             |  4 ++--
 revision.c         |  6 ++++--
 worktree.c         | 43 +++++++++++++++++++++++++------------------
 worktree.h         |  7 +++++++
 wt-status.c        | 22 ++++++++++++----------
 9 files changed, 74 insertions(+), 56 deletions(-)

--
2.53.0
