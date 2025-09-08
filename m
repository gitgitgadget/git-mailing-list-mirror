Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906C121578F
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 04:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757306206; cv=none; b=axms7Nm07fFb63/v6j3XoieWnQtH/SRLGexPWIxsrKoMAJx8UpkRW5H0PuvMS/kjqyFm4+bmjR3G+20Drddo69IbR0w7BU1oSnWgiTYW9sxaDoTf97BxpE5pma5Heq5a8KEYV0OGJux53stQnakobbQbrc01RXhXBK9jxwGDhtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757306206; c=relaxed/simple;
	bh=PLSCqPBol1mtnJkqOdtl8nBXEUQ8PZs0L8KQDBWPXrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RlAyibfer9rC/RSJyC6U9Xr9nxTNgxQzOrE7Dp4nXg9+xfpWX6E++Wem0CtEOZ5cQMtH4sCj1YdSH3xkmZkvRQK7uslOmoBdutWs7LHB1KjOX5x+nDeEW4YIVBR4lnsRZ1YwVdje5xNRPVeK6bSUdNtjyeLSHbe7nltG2XzXSik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NePBvf2F; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NePBvf2F"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2445806e03cso51443595ad.1
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 21:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757306203; x=1757911003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bIxdRe9IYPR6RJlqi+4do/Z8KSuIJ8EKCvrsE9DsNs=;
        b=NePBvf2FAAj+Gofviz6ohTUtvsFZA3JkqEuDwIMSX4BJXr2p2ApS66HdNK73u3U8Sv
         3tV3c43TGdw4xKQ9nKeKw548wsa2aXXXjPL7Wi4hZpswBpKYIIKmjir6B7K8v7wXrZeY
         taiKKv3zUbdT+p4+LrAwDmgSgN6xC2EMXp9UYFgeko20AbRth/sEdyQscbCQKVz2hbeB
         ewh8UEGDMCDqihF/JURCoDcXFzO/IHhqKJElkCbCznWZg8tLCUNOZQ9BM4zo8BR4ow9a
         8TJohOIDTcbjE5g0yNxCM3x1A9ZKJBWhMyMXWrHYCKKvwO77ppOWwuQD77n88+8yQlOy
         mkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757306203; x=1757911003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bIxdRe9IYPR6RJlqi+4do/Z8KSuIJ8EKCvrsE9DsNs=;
        b=MAB2+3DFftqUNHihNkuaSgOUmZ8XHMkHHxnqVh754tKl7yCmLZhf0vBzU2764BEuPC
         e+UsT0K3opQ4e0u+osApPp4rx0OWbHkDeYNd+ZnldGbw6bZiIuTaqIcz45ysEHOEir2e
         9yo+p6LPUNIBdAPZ3pFcYELdci8QOxqF/7UYlQCHGWaKAXsjSBHBby2+C/bjpHl3bWZs
         LkoKsorPSU0egMxKItTiyNUsuPqtqZQ5JAiDZ4M843WZ0d017JsvVS9H+yzxWN2V1LHd
         O6uCBG3R8D/A068xx5WCdeNWvFDOgUxr83x5M50eAMSPfKZk50NtW7Vei8dMapPJaYWY
         MoCg==
X-Gm-Message-State: AOJu0YxIhjCkYQ6NojLpwCM2HtmFpc5F9Zhy9CWLYGfZUNUsOkf77ohJ
	3WEnYb6i6nQIZEHEycfE1nWeM56y88p1Z097bvrzX3yRHIAKD2CQ8TxH9+iBUhnu
X-Gm-Gg: ASbGnctJ16dAH3bUJgoWj6igFsewePkJuXraZXt6yR5RXCSLQZ3024oY6DYF5W243sx
	nX2bH4u45svFpJGjSXdXKcXZpNAUjiDYbIrvKhopznw0zGtM1omeAhnCg/LOWVghI6vQkuYcI2L
	Nz0oAHNbbuBtuIdsfnHMW3g0aCuAPVS8P1V3jInnQWAEw+pVODUZ/nugl50ZGqNCotOu28BYAMn
	0zZfVHpuEpqY0+V86zX/03nhV+sVud24+IP/JiLx7Op8Gu2FzHuTKMI+zmL4qivKVzT845LYQy6
	c3LuyaH+Lp8xdA7LUBuz4A6jHy7A0efezxHx/BgmeNjTbAIbZaJknRPjR9bpUXe6tgjCT41OSDc
	0Oe3mZDcXr6vMVa3WNxqwHQq9oCQY/hj65SjHwsbCcvjKBctREbil9S5pWs7CzJyp
X-Google-Smtp-Source: AGHT+IGsd48X1blO+9Eo4ik66XaI9xzpqXKBmlZ93VEt4KYV5LjVCUKt9jtWK8NaZXoxGWyKqHLkpA==
X-Received: by 2002:a17:902:d2d2:b0:24c:a269:b6d7 with SMTP id d9443c01a7336-25173119564mr91181415ad.50.1757306203284;
        Sun, 07 Sep 2025 21:36:43 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:56:7e97:c01c:f128:b5c5:e0c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c9c2b1288sm127720805ad.106.2025.09.07.21.36.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 07 Sep 2025 21:36:42 -0700 (PDT)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Toon Claes <toon@iotcl.com>,
	John Cai <johncai86@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH 2/2] replay: document --update-refs and --batch options
Date: Mon,  8 Sep 2025 10:06:20 +0530
Message-ID: <20250908043620.57848-3-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908043620.57848-1-siddharthasthana31@gmail.com>
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation for the new --update-refs option which performs
ref updates directly using Git's ref transaction API, eliminating
the need for users to pipe output to git update-ref --stdin.

Also document the --batch option which can be used with --update-refs
to allow partial failures in ref updates.

Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 Documentation/git-replay.adoc | 62 +++++++++++++++++++++++++++++++----
 1 file changed, 56 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index 0b12bf8aa4..cc9f868c2f 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -9,16 +9,17 @@ git-replay - EXPERIMENTAL: Replay commits on a new base, works with bare repos t
 SYNOPSIS
 --------
 [verse]
-(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch>) <revision-range>...
+(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch>) [--update | --update-refs [--batch]] <revision-range>...
 
 DESCRIPTION
 -----------
 
 Takes ranges of commits and replays them onto a new location. Leaves
-the working tree and the index untouched, and updates no references.
-The output of this command is meant to be used as input to
+the working tree and the index untouched, and by default updates no 
+references. The output of this command is meant to be used as input to
 `git update-ref --stdin`, which would update the relevant branches
-(see the OUTPUT section below).
+(see the OUTPUT section below). Alternatively, with `--update`, the
+refs can be updated directly.
 
 THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
 
@@ -42,6 +43,24 @@ When `--advance` is specified, the update-ref command(s) in the output
 will update the branch passed as an argument to `--advance` to point at
 the new commits (in other words, this mimics a cherry-pick operation).
 
+--update::
+	Update the relevant refs directly instead of outputting
+	update-ref commands. When this option is used, no output is
+	produced on successful completion, and the refs are updated
+	immediately. If any ref update fails, the command will exit
+	with a non-zero status.
+
+--update-refs::
+	Update the relevant refs using ref transactions instead of outputting
+	update-ref commands. By default, uses atomic mode where all ref updates
+	succeed or all fail. Use with `--batch` to allow partial updates.
+	When this option is used, no output is produced on successful completion.
+
+--batch::
+	Can only be used with `--update-refs`. Enables batch mode for ref
+	updates, allowing some refs to be updated successfully even if others
+	fail. Failed updates are reported as warnings rather than errors.
+
 <revision-range>::
 	Range of commits to replay. More than one <revision-range> can
 	be passed, but in `--advance <branch>` mode, they should have
@@ -54,8 +73,9 @@ include::rev-list-options.adoc[]
 OUTPUT
 ------
 
-When there are no conflicts, the output of this command is usable as
-input to `git update-ref --stdin`.  It is of the form:
+When there are no conflicts and neither `--update` nor `--update-refs` 
+is used, the output of this command is usable as input to `git update-ref --stdin`.  
+It is of the form:
 
 	update refs/heads/branch1 ${NEW_branch1_HASH} ${OLD_branch1_HASH}
 	update refs/heads/branch2 ${NEW_branch2_HASH} ${OLD_branch2_HASH}
@@ -66,6 +86,15 @@ the shape of the history being replayed.  When using `--advance`, the
 number of refs updated is always one, but for `--onto`, it can be one
 or more (rebasing multiple branches simultaneously is supported).
 
+When `--update` is used, no output is produced and the refs are updated
+directly using individual ref updates. This is equivalent to piping the normal output to 
+`git update-ref --stdin`.
+
+When `--update-refs` is used, no output is produced and the refs are updated
+using ref transactions. In atomic mode (default), all ref updates succeed 
+or all fail. In batch mode (with `--batch`), some updates may succeed while 
+others fail, with failed updates reported as warnings.
+
 EXIT STATUS
 -----------
 
@@ -91,6 +120,27 @@ $ git replay --advance target origin/main..mybranch
 update refs/heads/target ${NEW_target_HASH} ${OLD_target_HASH}
 ------------
 
+To rebase `mybranch` onto `target` and update the ref directly:
+
+------------
+$ git replay --update --onto target origin/main..mybranch
+# No output; mybranch is updated directly
+------------
+
+To rebase `mybranch` onto `target` using atomic ref transactions:
+
+------------
+$ git replay --update-refs --onto target origin/main..mybranch
+# No output; mybranch is updated atomically
+------------
+
+To rebase multiple branches with partial failure tolerance:
+
+------------
+$ git replay --update-refs --batch --contained --onto origin/main origin/main..tipbranch
+# No output; refs updated in batch mode, warnings for any failures
+------------
+
 Note that the first two examples replay the exact same commits and on
 top of the exact same new base, they only differ in that the first
 provides instructions to make mybranch point at the new commits and
-- 
2.51.0

