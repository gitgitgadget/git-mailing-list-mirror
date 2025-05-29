Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B04C23183F
	for <git@vger.kernel.org>; Thu, 29 May 2025 19:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748546464; cv=none; b=MUEqL5yCSCRsA29OXzlWnsIDqtYtnoIQ2Dd8BmTnhbIU/OIfbmoaju8BJM4wFqFC3fDEk5vrjzsRVeTqb9femt/TyiKM3oQpctFSrmXR69fJscT7ugMIZDH/bGFXlDcAKdVm4kBVP6q7jXBXhVysevQ9Xq7pIswWiYUUY6yK9w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748546464; c=relaxed/simple;
	bh=pnIfoQOsoXXIlOxR4A0F/C7tmB1WdNDoxeaOYDOUzk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SK1HDXBlNqlE+dSqoA/qadnRVexNkQjwHS5P+qy3Wl38F82sEx/8nMupiFjSqPUMD3B6jICyipTbUfCSoyxmJ7pRDBI45/Oa7guu/mPmBh8/nBXI1Wc9HQPM9HZpsp7w5YIemt/fF/iRQtR5SRdUUoYLxPJfRvT3a0gqWZ9+QH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ypz6FOe9; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ypz6FOe9"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5240b014f47so423775e0c.1
        for <git@vger.kernel.org>; Thu, 29 May 2025 12:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748546461; x=1749151261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exA3udEdYw6Y0hafrFGqwDQqcYdBP1ohi6B8FVoBwE0=;
        b=Ypz6FOe9wxK+RarkpqHe0Liiw51Z6d2AqGzPTWhIFAX7vrJ0vM0ST0CROl0aYvfRLq
         /t19XCzWpc2vfRcLXDb06HecFktXYMplmaodF8VEkODEsi3Kx4d+uiY3oyErEzJlHXc8
         AC51GjVmQCSeTybLJVujfpg1nr0xGEKJM3ne7bNa7UrG7oDyf/0gCpTC3wmCImghJBzD
         4mqQbkLzzo+cvxlmPFnqvgKmdYvcgcD/Bzgt+3cPzAUrbaKo/Db9kJmgouH0raAFZQyf
         LCOI+kkBHoUeE2mpcPXMwHUQx1iCChUkkxxccALYQ/tALx263+XHaNaRaj9I1kEp2aO0
         2RFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748546461; x=1749151261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exA3udEdYw6Y0hafrFGqwDQqcYdBP1ohi6B8FVoBwE0=;
        b=wErOnbU+NLd2M8zzcVzv1DVDbQTtg343zW0wRFR+N7lsLqYW3ssjtv415Z11P7k83+
         zRHxzSTWT50J8rn2kEwlu++T7JWQcYxOAdcq3D5XLCvmz0wXflGxrWg9kVQnh/YsMZ2V
         iJQ/YpMVPyed5PPnVJIQ120mxZKueW18OHBh5vIhOMiHJhPfxeOIN+XneJf7dFWoRCy5
         Ax8FyZijQuxOXRd9CZvh0YqQZbopjT1lX6DBBa7Q9a3XxqWJMQyiRaOTDh3TqPB32WZ+
         h9BSe6ApP1fTER3VwT8q32njwfJ9TUK1l7niEpAT77j+G0vDraR+Hysb5hfnhnIysGwE
         n9HA==
X-Gm-Message-State: AOJu0YzOvBP2jJrn7BGVm50FZPo2Q1ik9Atj/aUjwzT3+xyr0j0ivQzb
	n/BXaHVzRV3BauVOgtZliL1g+WSVoSGwyX0nixfO3OjEp6Y+Lihx1PH19sUO3rnC
X-Gm-Gg: ASbGnctt6zsNrWXqOiM3JyEtuAgJqV/yIzHZPLR6sCKwkCRi5HE+dFkROLq5SvsCokl
	8QYDVJxL97a3lPgQ4oLW2TOToNNanrbLDdcmstVqOr8reh+5lzfWJPJg/wotOs7d3LkNe6wgbwJ
	srpdA1BCKOrltwLbTr9UK+tTob5Wt3SeOcMlw3c+koFWRMSlzsKjc6QfBiGQ/vREM5l+8oJfTzD
	rpLevH+iizoC3bsNA28a9f/vZWyfc9p98tt0K04ze8lLek2BvVsBDFiRE72XcTofejs918pyUqB
	++8D8vhiCNf9RcSI3mcWACOK0NYK3kiDA2C5JQnNEKq+by2k3Rk/9QI+4H2BTyGK/HNixzKtGR8
	c/wJ9aQ==
X-Google-Smtp-Source: AGHT+IED3YMt3Y8VLiyfubnqYsBdw/3M4PZ/lSAjCUTbZAdmmKCY5iaSNXm07ONdrK6jKL0giIF7sg==
X-Received: by 2002:a05:6122:1acd:b0:530:7a17:88ce with SMTP id 71dfb90a1353d-530810f19bcmr906739e0c.9.1748546461556;
        Thu, 29 May 2025 12:21:01 -0700 (PDT)
Received: from localhost.localdomain ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53074ad9dc8sm1754464e0c.20.2025.05.29.12.21.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 May 2025 12:21:01 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH 2/2] MyFirstContribution: add walken.c to meson.build
Date: Thu, 29 May 2025 16:20:36 -0300
Message-Id: <20250529192036.75408-3-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250529192036.75408-1-lucasseikioshiro@gmail.com>
References: <20250529192036.75408-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instruct in the documentation to also add an entry in meson.build for
builtin/walken.c, as currently both Meson and Make are supported.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/MyFirstObjectWalk.adoc | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/MyFirstObjectWalk.adoc b/Documentation/MyFirstObjectWalk.adoc
index 29d26abb47..3b66e48dd9 100644
--- a/Documentation/MyFirstObjectWalk.adoc
+++ b/Documentation/MyFirstObjectWalk.adoc
@@ -96,12 +96,19 @@ maintaining alphabetical ordering:
 { "walken", cmd_walken, RUN_SETUP },
 ----
 
-Add it to the `Makefile` near the line for `builtin/worktree.o`:
+Add an entry for the new command in the file of our two build systems (Make
+and Meson) before the entry for `worktree`:
 
+- In the `Makefile`:
 ----
 BUILTIN_OBJS += builtin/walken.o
 ----
 
+- In the `meson.build` file:
+----
+  'builtin/walken.c',
+----
+
 Build and test out your command, without forgetting to ensure the `DEVELOPER`
 flag is set, and with `GIT_TRACE` enabled so the debug output can be seen:
 
-- 
2.39.5 (Apple Git-154)

