Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633AD27442
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 01:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769391206; cv=none; b=ZXK71j2eMT8rosbGxSbpS/8T8fWlQDXCuv4FawQJOGxN5rn5QJuLU4DnB5/qAXIfcFVudohwts9vRDJm030ZUvDd9jALC2KEJHpCU7XI+4I6JZ8vD22Dob2M9JL3zK0rJdcUs9SUQCpCXOPt7RBUnw/L0utVeLYWSvA7WTsVlWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769391206; c=relaxed/simple;
	bh=UQtpX8wBxrJNe6nP/A9BbYplPC2ulpULNiNXeLQLuyo=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=ZFAep3Ept+gRkmTfPQvi9rHv1JRNjqN2hJ8EJGRXPVCheDkj1mH5Z0HUZpSVPCeOru+US042MflZFuhwDQfeSXLiEASkhKovnYkH5GJZdOhk2FYVoS6sT/2+9t+IYr3Ckl6OlxvJHw972ptkQkZZa0qou8cTknNOEtKow2QkxyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijs3OUWd; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijs3OUWd"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-124566b6693so8978410c88.0
        for <git@vger.kernel.org>; Sun, 25 Jan 2026 17:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769391204; x=1769996004; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W1DMgfcOFVJxwzDlnGCBwP8bx2M5A5Hz1gJ4vcSrPns=;
        b=ijs3OUWdcIggsBJYjfZJ09jJGZpSjAWz2g2WwG51e8J5tlwt/eJWH2YEEV3Zrfi+gG
         +SgMdIusLhiPefz9m9iOcxVhewnd9ZvGXMwtZznh5wMh+SEnuuVnXbmGl+lqTQQ8fwoa
         Zz5EswbxiTfY3JWqPCHRokMYI9cva7S0ykMCsNEEouecBfHQHwo1s+e2FmhKtx2Mknav
         fBSwTTAF1f7EDXzfQbGI8/CJomLVdZ9IFW7fMOHNUvbNM8LS9kJ6qRuU6VCZ3T3TSXwO
         LGvehsAeHx1pri6xfRIoT74V1TGfxCYo/CRBdSxD4UscTzAWUIVl3oK5Dmt4dCtPGKiK
         DOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769391204; x=1769996004;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1DMgfcOFVJxwzDlnGCBwP8bx2M5A5Hz1gJ4vcSrPns=;
        b=XktHz0ldzMJL9eJR9+Jz36+VWZXhWXcBMrmgEzPakF3/CknKIvRnz66HhHRoT0RgvT
         ckHnF2DKyaWsiNAmcTexcsIgpwX7bFoK/g2mVs/Ne+7K//wvzfb0S7uvbt1JMfDz3v1J
         5i2v3LdGn8iavd1Zd65ytvee4VsotRZmAdzSLoHXOGSsP2KDS4P6wJrkquOu90pjHZ9h
         4b4ledGHi2r/oetEXPo++96DELR+VUiRevfgWdRqd1f01HNEKYL9Ub+6sR+rj2aEfkPj
         kqyNssV+D/VteK/34NCnRaoc4Q6uPH4X1g9mJz7V5VhFQ4YkiMyAAnbZoVWjC7kP+JI4
         Ej+g==
X-Gm-Message-State: AOJu0Yw0FjAVhQZanHGbQCiRmNc3zVfOMpJ5MZIak18JLb2aWF9yzkdo
	nC/lLq29mNFtWwNVp/de7A6OP5DtyYrkKO5YHdtFmBaiugrWnjrGIl/O1fu7+Q==
X-Gm-Gg: AZuq6aLIYCd0IalYxAM0SOvsEINy/3rK/8B4MkQzWxyojxZmzVM68Z5aurZvw1r2iD9
	wFTDD7ZapIb3lvyRrnEBmZagBu8LmCevv9WGdbHuIT7DmGUkwry/46EWbfb7Ey81j9qGjJ1yDWm
	zbe0iEeMBHK68bwvxMH8CKdYJthNJboC3uxfoYE7iq7sPfg2edBjpHmfIUgxKjoYuuy8RUmfixL
	iP9A3KmvXl00q+Kp7Ur9dptFOxjAGxUu3MJcdK2lKmoASHQU1OBgvqUC4/6ewTase3zrLAwSQ5a
	xs4mpP2QSyYHqmtMsRioccIC9MIX+AKoXNCS/qJo1+D9EsbbmuEhJIJoxwi6c+day+aygcLuZyj
	48RkDn5C08CdydLEh3FJ2klSUISDbYGZyuKwTi7Y2v52p2SwMUwbRtAPybt6nbRXaBmyjwp1BJb
	41S+exoGu/sm7uUA==
X-Received: by 2002:a05:7022:6190:b0:119:e569:f27a with SMTP id a92af1059eb24-1248ec62a7fmr1662383c88.35.1769391203928;
        Sun, 25 Jan 2026 17:33:23 -0800 (PST)
Received: from [127.0.0.1] ([52.159.243.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d91ca0fsm15149892c88.8.2026.01.25.17.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 17:33:23 -0800 (PST)
Message-Id: <pull.2180.git.git.1769391202338.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Jan 2026 01:33:22 +0000
Subject: [PATCH] fsmonitor: fix two bugs in watchman hook retry path
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
Cc: Claude <noreply@anthropic.com>

From: Claude <noreply@anthropic.com>

The is_work_tree_watched() function in fsmonitor-watchman.sample has
two bugs:

1. Wrong variable in error check: After calling watchman_clock(), the
   result is stored in $o, but the code checks $output->{error} instead
   of $o->{error}. This means errors from the clock command are silently
   ignored.

2. Double output violates protocol: When the retry path triggers (the
   directory wasn't initially watched), output_result() is called with
   the "/" flag, then launch_watchman() is called recursively which
   calls output_result() again. This outputs two clock tokens to stdout,
   but git's fsmonitor v2 protocol expects exactly one response.

Fix #1 by checking $o->{error} after watchman_clock().

Fix #2 by removing the recursive launch_watchman() call. The "/"
"everything is dirty" flag already tells git to do a full scan, and
git will call the hook again on the next invocation with a valid clock
token.

Apply the same fixes to the test helper scripts in t/t7519/.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
    fsmonitor-watchman: fix variable reference and remove redundant code
    
    The is_work_tree_watched() function in fsmonitor-watchman.sample has two
    bugs:
    
     1. Wrong variable in error check: After calling watchman_clock(), the
        result is stored in $o, but the code checks $output->{error} instead
        of $o->{error}. This means errors from the clock command are
        silently ignored.
    
     2. Double output violates protocol: When the retry path triggers (the
        directory wasn't initially watched), output_result() is called with
        the "/" flag, then launch_watchman() is called recursively which
        calls output_result() again. This outputs two clock tokens to
        stdout, but git's fsmonitor v2 protocol expects exactly one
        response.
    
    Fix #1 by checking $o->{error} after watchman_clock().
    
    Fix #2 by removing the recursive launch_watchman() call. The "/"
    "everything is dirty" flag already tells git to do a full scan, and git
    will call the hook again on the next invocation with a valid clock
    token.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2180%2Fptarjan%2Fclaude%2Ffix-watchman-query-bug-sfbIw-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2180/ptarjan/claude/fix-watchman-query-bug-sfbIw-v1
Pull-Request: https://github.com/git/git/pull/2180

 t/t7519/fsmonitor-watchman                | 1 -
 t/t7519/fsmonitor-watchman-v2             | 5 +----
 templates/hooks/fsmonitor-watchman.sample | 5 +----
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/t/t7519/fsmonitor-watchman b/t/t7519/fsmonitor-watchman
index 264b9daf83..907bd1533c 100755
--- a/t/t7519/fsmonitor-watchman
+++ b/t/t7519/fsmonitor-watchman
@@ -109,7 +109,6 @@ sub launch_watchman {
 		close $fh;
 
 		print "/\0";
-		eval { launch_watchman() };
 		exit 0;
 	}
 
diff --git a/t/t7519/fsmonitor-watchman-v2 b/t/t7519/fsmonitor-watchman-v2
index 14ed0aa42d..2c59120c3d 100755
--- a/t/t7519/fsmonitor-watchman-v2
+++ b/t/t7519/fsmonitor-watchman-v2
@@ -141,15 +141,12 @@ sub is_work_tree_watched {
 		# Watchman query just to get it over with now so we won't pay
 		# the cost in git to look up each individual file.
 		my $o = watchman_clock();
-		$error = $output->{error};
+		$error = $o->{error};
 
 		die "Watchman: $error.\n" .
 		"Falling back to scanning...\n" if $error;
 
 		output_result($o->{clock}, ("/"));
-		$last_update_token = $o->{clock};
-
-		eval { launch_watchman() };
 		return 0;
 	}
 
diff --git a/templates/hooks/fsmonitor-watchman.sample b/templates/hooks/fsmonitor-watchman.sample
index 23e856f5de..21c81b6804 100755
--- a/templates/hooks/fsmonitor-watchman.sample
+++ b/templates/hooks/fsmonitor-watchman.sample
@@ -142,15 +142,12 @@ sub is_work_tree_watched {
 		# Watchman query just to get it over with now so we won't pay
 		# the cost in git to look up each individual file.
 		my $o = watchman_clock();
-		$error = $output->{error};
+		$error = $o->{error};
 
 		die "Watchman: $error.\n" .
 		"Falling back to scanning...\n" if $error;
 
 		output_result($o->{clock}, ("/"));
-		$last_update_token = $o->{clock};
-
-		eval { launch_watchman() };
 		return 0;
 	}
 

base-commit: 68cb7f9e92a5d8e9824f5b52ac3d0a9d8f653dbe
-- 
gitgitgadget
