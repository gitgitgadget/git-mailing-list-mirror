Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F019C626A2
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 20:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707857557; cv=none; b=s4FqKOEf0z6PlK3hxGw4M/PfhawokfUiIjRcA8QKS1d3vHQxK4hNHAq6TgX3pftmfOoGosi5uJRIaOxjDQoRMxxy1b9FqaqemcrBgysMok+wnDa19KSf2tSmYdSQ7TAv+urSt7EwQbiYXMAJ1AwCvNzMR5QUTwArDY7ig+TSJCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707857557; c=relaxed/simple;
	bh=uaZoASYt8j7Y2+Ka3otM10x+haDYsjdGwqhtVUdwX2s=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sQRq5ykilEozGIxI6d2G+BzBWSkWTvqF8iLtzdnxGnbYV0Ff9GwHK0MRB7nc47ZeoeQK4Z37k57FGw9D2aveY4aTk0am4ZoCsBAS12Jiu68cLxX6uIqXJgWqu7Pvp1EKS6hRBQqcuFKB2e4sXwhh/FzMSBvhXiBa7n3gb7P3R+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sew45Nq4; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sew45Nq4"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-411dd149bd9so1534925e9.1
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 12:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707857554; x=1708462354; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U99HAYnb6Ux+HIQV1PouI4Dctf15ABVlQ0E8tGdNkKw=;
        b=Sew45Nq4/0xn/LlaMhFOolCge2tbdiMzeHxKcLyfVwX+z+crVRZ78n510f9GWnnoZV
         3/K75D02u2f3M0XPbn+rVJgxIl8apFUmxOkByT4IsNhusHmcHApAx/ZlazzJAYhcsLsQ
         JncRbrRNBjnhP046jIuss46zRk/Y4uw36j4KBVX0sxlQBw8XykvRgytbU1TXim8Dfsww
         5j6Q7Zrnf1HdvYVKgmiJlFKaOlE3Q+hih9L8ODz1p9sEaXHcC0MZGaBW0EBgsSABWdOy
         DpFKatCH1mZRAFAEqtPqqsJ7WtQdZlr7GHjkt+fFfQ/lDMwNDAZk8fhcGVeYOGeb/vwC
         Qebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707857554; x=1708462354;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U99HAYnb6Ux+HIQV1PouI4Dctf15ABVlQ0E8tGdNkKw=;
        b=B7RtFJfnt4MkSdKVEntiOWW2klZohyHGxrehOUCuTWbFVy85/Qpcm9XBcj/DzUb/7v
         95vsiCZhOjBmEj4RLufK1qxND532wvInHfZjr3pYh+ih4X5va5aXSmRYrumrb/I6uUe+
         hYeaDTeyhL4uxevlGjLKWrr5NbkfyFMFAWYG+l19Ti+8RDzXgw/yDTzsgcQFPrUQKzdZ
         SoS8tXnhf6TWaALEjaPnd7NS7C7cbtqcTzS6rEcCTAi29YeCUvmx2TIhsGEqX4oJV0Qc
         tnEor8lXB6caD88al9fjNMeD4QZlI/t56Z7G4YnQ2P+exnzsXxtKYKUwMJk7nSsKnfV5
         +cVg==
X-Gm-Message-State: AOJu0YyVdqbaaP8c3YIye7b4WJk5iPEmXinr2kXqAPn5q4j8UtXnyE3v
	nA5ZK9RjZTPd/mqaKuWvbtdzlwTDuKS+FIV9pfTZpEJ+mLe7dIMa6tqy0Pwl
X-Google-Smtp-Source: AGHT+IGJEnyMvSCqvIuEX2QmxHcpJ6xwob6sqe+5YswXGPsCmCXJzUj3YZwN+Sx7uU4IhFkyF4cXEg==
X-Received: by 2002:a05:600c:a49:b0:410:d3d9:91a1 with SMTP id c9-20020a05600c0a4900b00410d3d991a1mr504010wmq.10.1707857553999;
        Tue, 13 Feb 2024 12:52:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id jw21-20020a05600c575500b004101543e843sm12575619wmb.10.2024.02.13.12.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 12:52:33 -0800 (PST)
Message-ID: <63edb68303fdd9ddd1c2e31ccf158ef4219cd0b9.1707857541.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Feb 2024 20:52:21 +0000
Subject: [PATCH 12/12] t7527: update case-insenstive fsmonitor test
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
Cc: Jeff Hostetler <jeffhostetler@github.com>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

Now that the FSMonitor client has been updated to better
handle events on case-insenstive file systems, update the
two tests that demonstrated the bug.

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 t/t7527-builtin-fsmonitor.sh | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 5cd68b2ea82..03af8539ca8 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -1116,16 +1116,17 @@ test_expect_success CASE_INSENSITIVE_FS 'fsmonitor subdir case wrong on disk' '
 
 	grep -q "dir1/DIR2/dir3/file3.*pos -3" "$PWD/subdir_case_wrong.log1" &&
 
+	# Also verify that we get a mapping event to correct the case.
+	grep -q "map.*dir1/DIR2/dir3/file3.*dir1/dir2/dir3/file3" \
+		"$PWD/subdir_case_wrong.log1" &&
+
 	# The refresh-callbacks should have caused "git status" to clear
 	# the CE_FSMONITOR_VALID bit on each of those files and caused
 	# the worktree scan to visit them and mark them as modified.
 	grep -q " M AAA" "$PWD/subdir_case_wrong.out" &&
 	grep -q " M zzz" "$PWD/subdir_case_wrong.out" &&
 
-	# However, with the fsmonitor client bug, the "(pos -3)" causes
-	# the client to not update the bit and never rescan the file
-	# and therefore not report it as dirty.
-	! grep -q " M dir1/dir2/dir3/file3" "$PWD/subdir_case_wrong.out"
+	grep -q " M dir1/dir2/dir3/file3" "$PWD/subdir_case_wrong.out"
 '
 
 test_expect_success CASE_INSENSITIVE_FS 'fsmonitor file case wrong on disk' '
@@ -1246,12 +1247,14 @@ test_expect_success CASE_INSENSITIVE_FS 'fsmonitor file case wrong on disk' '
 	grep -q "fsmonitor_refresh_callback.*FILE-3-A.*pos -3" "$PWD/file_case_wrong-try3.log" &&
 	grep -q "fsmonitor_refresh_callback.*file-4-a.*pos -9" "$PWD/file_case_wrong-try3.log" &&
 
-	# Status should say these files are modified, but with the case
-	# bug, the "pos -3" cause the client to not update the FSM bit
-	# and never cause the file to be rescanned and therefore to not
-	# report it dirty.
-	! grep -q " M dir1/dir2/dir3/file-3-a" "$PWD/file_case_wrong-try3.out" &&
-	! grep -q " M dir1/dir2/dir4/FILE-4-A" "$PWD/file_case_wrong-try3.out"
+	# Also verify that we get a mapping event to correct the case.
+	grep -q "fsmonitor_refresh_callback map.*dir1/dir2/dir3/FILE-3-A.*dir1/dir2/dir3/file-3-a" \
+		"$PWD/file_case_wrong-try3.log" &&
+	grep -q "fsmonitor_refresh_callback map.*dir1/dir2/dir4/file-4-a.*dir1/dir2/dir4/FILE-4-A" \
+		"$PWD/file_case_wrong-try3.log" &&
+
+	grep -q " M dir1/dir2/dir3/file-3-a" "$PWD/file_case_wrong-try3.out" &&
+	grep -q " M dir1/dir2/dir4/FILE-4-A" "$PWD/file_case_wrong-try3.out"
 '
 
 test_done
-- 
gitgitgadget
