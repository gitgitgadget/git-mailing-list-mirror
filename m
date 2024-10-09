Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C084192B6D
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 11:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728474594; cv=none; b=ARPB6qL1ecR+aL9dGtM2nq6cUwLFTEzNeeg5U7fABmThMzU7z67ITnFQk54Ejnzq3EiAZ0odEDFuE0JKgYqVdFhlrD81f4WaE8FPjjh0qpi1ORf2/EGTGQkhkxIv2wyYAyhgvvQ4jrUkUqCdvPVjJgS9MiXRkMX421wlZ+guujs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728474594; c=relaxed/simple;
	bh=z4ltqboBE1OWE/O5ZSaDRqAR21e1zcvcrl7X64Lx5JE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OTGQrlbiaSLHANyUfWRAPIGaD2V81WJh3U8LNxdvEsV8MCMwHGIu3wKGYY9mh1jG4HX/JBVx56O/2uGSSIIwCWjtbKeJKYoBcAnQUrrtDFnrE2Qtkgx057LFGNkerK7IrtXqdfWtKtf9UKzwa3nJiuPkVI9oHd+tPfrrbHXo1vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2Ws9vTQ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2Ws9vTQ"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a994cd82a3bso510658766b.2
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 04:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728474591; x=1729079391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyacuLypCTBfP6IiHEggVFxQ1wOadkPx7srF2VO262k=;
        b=U2Ws9vTQc29F9GF1rEYZPx5sLll450UC5kiblVHKCt51sFgWe27t+X79NrWRn2ZyxP
         9hIuT3FRyQCJ1CHieTkGLwl5vWkXMx44P1l3QKV7rAGqL4nEpyUOhaLEviSwXa9hxIKf
         OCrLTTld5N7ED1aQ3o7G00q60zwWy+yxEo4dD9fTOsJ7zD5dP8MH7o1Bf/XID1gzzZOH
         le81mWY90CdkmIc4lnBAp3VDPQGYAySfS24KcU+ANYwl0mTHXYMG9vtZCpAvAiw3z6Ak
         FgSpcBSmFxInEtzVEoE226B3RE6Wal3ZW/aiJVrqbXuoHFHShjKtLeel0HgZqKNy5L4p
         yqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728474591; x=1729079391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wyacuLypCTBfP6IiHEggVFxQ1wOadkPx7srF2VO262k=;
        b=btYaAJDfL5rDjbnQElorCIcS66e1nkdCixEv0FMb7S1X/daogHSYM1KlC/gZ8HKIHM
         QhFexpLsuqtPXHwyFNo8GfnTlPLIW9pHGAoVPzrhm2IRNvE9Bws9O9WuN/Vh5PUZ3bM0
         iRdWm15SobsZaiwZN0r9P7HdBuHNKvdCOc3ZD+Nmfr4doJMRsmrQNZTetN3ZWKx73cCq
         peFBVkO89jvfb4BQX6vBywlmOoT1tTu4mx54xqxB+YnLL/H4t80g1fFw1mhXLYAR5Nyk
         45Eo0VEFDfbT1x+Iw/QXJUhPuvf9H5+ppWwl5vWaapzjr5SDHoWcKjdOFZDYNqUnfgcq
         LEgw==
X-Gm-Message-State: AOJu0Yzpf6ilS9XMsXkxa3Qwfaa1r5J8vnyzy3Al1A9ZQ4ocY24UKikr
	toQoLeootZ4C8U3R9wIPjl6dgvvIOx+Y5eF65O62Ot5VdkRW/VBxLD0pdZxB
X-Google-Smtp-Source: AGHT+IGSOk/E8SGW33OVnEvKua9s7PL+0KUkd1IAjaX4VlTbLia0y3esf/6xxhf5CZLCl8Tzi7CWhw==
X-Received: by 2002:a17:907:c7d1:b0:a8a:8d81:97b1 with SMTP id a640c23a62f3a-a998d20769bmr179725566b.27.1728474591399;
        Wed, 09 Oct 2024 04:49:51 -0700 (PDT)
Received: from void.void ([141.226.169.1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a993a4ff9f7sm595800566b.26.2024.10.09.04.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 04:49:50 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH 3/7] git-gui: Fix typos
Date: Wed,  9 Oct 2024 14:49:36 +0300
Message-Id: <20241009114940.520486-4-algonell@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241009114940.520486-1-algonell@gmail.com>
References: <20241009114940.520486-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos via codespell.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 git-gui/lib/status_bar.tcl | 2 +-
 git-gui/lib/themed.tcl     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-gui/lib/status_bar.tcl b/git-gui/lib/status_bar.tcl
index d32b14142f..a680452524 100644
--- a/git-gui/lib/status_bar.tcl
+++ b/git-gui/lib/status_bar.tcl
@@ -216,7 +216,7 @@ method _delete {current} {
 # activity, with the context that there are a few situations where multiple
 # overlapping asynchronous operations might want to display status information
 # simultaneously. Instances of status_bar_operation are created by calling
-# start on the status_bar, and when the caller is done with its stauts bar
+# start on the status_bar, and when the caller is done with its status bar
 # operation, it calls stop on the operation.
 
 class status_bar_operation {
diff --git a/git-gui/lib/themed.tcl b/git-gui/lib/themed.tcl
index f43d84e54f..68c999a9be 100644
--- a/git-gui/lib/themed.tcl
+++ b/git-gui/lib/themed.tcl
@@ -4,7 +4,7 @@
 
 namespace eval color {
 	# Variable colors
-	# Preffered way to set widget colors is using add_option.
+	# Preferred way to set widget colors is using add_option.
 	# In some cases, like with tags in_diff/in_sel, we use these colors.
 	variable select_bg				lightgray
 	variable select_fg				black
-- 
2.39.5

