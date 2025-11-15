Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDEA3093C9
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 18:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763232871; cv=none; b=AXarCSYKwpEb59JCSGQpK69U6sgAmr0fczsz3JYe86kSrNThkip+OXuJV9+efSPcnIoBWX2jHbZ1WR/Au6wRI+DagQ1mzeoI1xV01DaglyxzVwueeq1cQKESKUV6dtVZ6vzujLou/9ZSrNQSxtwxbQPskEIB6jfYnIp63t4NCv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763232871; c=relaxed/simple;
	bh=SPKnl6MtvtwXJxwkn5QngezAVIxv9n3L7XCC3WpDlO8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rNZf1ZImMJvXtxe5UTzOmLGIdqmj6+yCDo0Mr1FMiU2SSWmZSb5FEPXefnAlYilJJ1k4kLqlrER5WGrQPciNF5iuefoo88bFbU9pPOCfJmR0IAv3kAXZGhUSmr6gcfY+m9EeG8TyyUpYxmA0VeEJvZbxoKgMf6OkolmWS8T7w5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alEp9Ily; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alEp9Ily"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-bc0e6d91222so1930601a12.2
        for <git@vger.kernel.org>; Sat, 15 Nov 2025 10:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763232869; x=1763837669; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KZ+ra1NQk8uloIFN6XPiETfmW9dz6IEO8iSjpwSKvE=;
        b=alEp9Ilylq1r5hNnPIZK0S/AE0A03kpLTVucx1dTHVPSQjvSw6pf5OY3fuvNrVW1Dq
         9knGAD4Z8FhrX4HFlbwEBm2UCow6QRYZHYNoO/SBbIJzOAEEvjCrldop53TyVaYIqFNF
         O6qAw1Rs9nqQxRl4JWw/pNPRVx/WtTW+c+T2BwKMIy0g1MxEKqqszNY+/wSWvYWWh/dE
         6L1qcmi+X2bmeP5l7lxeJgZ+gpdWecyE/CANDVI+0R1TWcLPcgbyRXT3K6KBan4t83Ii
         qHzG3G7WuZpjD10blNNYa+XlPNJMlss+fnTZV4Tztw/P0JbMG6IZhdfISeW0M7EQOE6j
         QXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763232869; x=1763837669;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6KZ+ra1NQk8uloIFN6XPiETfmW9dz6IEO8iSjpwSKvE=;
        b=Q+9WvZ5c+mKBXbd97sMggOAaH5C995jO7SFxaefNdJYo61hRLoCq6vRZvbuMOwbs67
         CS7y12K23j/hGSg8JMsWty23JDMxXuWlonN2anEvMLvZy9HXFBbbEcd69vUUrBrptgLP
         eVULSEUpdJaAiiTiA7WM/HvpGIWHIxgJeN1jOzjv9jT8ciBLfk+2NOdycQaI0Y1RZ70e
         HXPyuDyRKT13dUG1qGdHCJD3QR5MoIZYcwEscYXuj+6XQndwVSbTo+y9sFNXycfS82rj
         zeiilxoqbjxXyDDzQWd6csMb6vG+WjysJl8XC7Cy+SXHJcsMmEp9sEuTcBwlOA+YNZ8g
         V1lg==
X-Gm-Message-State: AOJu0YzvRNs1OwM55Hb5p4DnznKspAZI1TxRh6D5aSDRkiNNbHePArJI
	/pcb9usOb8iCJM8eHx6JRNWAOl4S+RwX47oZrBbrmjeO7P78EvutiAWhRbpkJrnm
X-Gm-Gg: ASbGncsnqoZOySMLnAPy+flnXyegJ1cFLJmE7E/EoHJeIdf9nZgB0mX0xS3Y0hKcN43
	oexs+NozcsKLKzBoszbZcilsu7O+wl7UfGtwgip6MLNPPuPFnW30wx3ZOjHFIqsCFiNt36QyPeB
	g9fvTbcVSE0Nbr5J1V8DeJiO8/yJDlWReONhsDhKQL83SFymOhH8NkiopGsoMkqrsgluAkqoVWs
	uR2Y1JBtHrUridSy0sLIPsAj8j5d6ZxXXz+7PCy5eAkGMubd5JH292kcd7+TJYh+bkzqOm6XmEa
	1Prur6gaPCJ2Ks6HhYN7wE48rzPSBRMRrUioXy5t4hTroY0gDeqj/vVTxszkETYnC4VjZLCkOtn
	aMjNZnykOIiYEqHZ8oPcqieIuLqDEFKFoHz7QB40PueDoT5HEakLvrbG8ea7e9xzoEYz9BFplU+
	pzeA==
X-Google-Smtp-Source: AGHT+IEzc8LCUIfWLcGkjBP8qpk5Zzy5q9yQKKvLCecfr3sBZDgzQYzoauJc7v3ijnJM8XFRX7EVoA==
X-Received: by 2002:a05:7300:a218:b0:2a4:3593:6476 with SMTP id 5a478bee46e88-2a4abd50190mr2680921eec.38.1763232868510;
        Sat, 15 Nov 2025 10:54:28 -0800 (PST)
Received: from [127.0.0.1] ([68.220.58.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49db7a753sm23957044eec.6.2025.11.15.10.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 10:54:28 -0800 (PST)
Message-Id: <39b17bc64ff0d2e4162437ab745845c055315037.1763232863.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.git.git.1763232863.gitgitgadget@gmail.com>
References: <pull.2101.git.git.1763232863.gitgitgadget@gmail.com>
From: "Kiril Ivanov via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 15 Nov 2025 18:54:23 +0000
Subject: [PATCH 3/3] git-prompt: add quiet upstream indicator option
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
Cc: Kiril Ivanov <ivanovkirilg@gmail.com>,
    Kiril Ivanov <ivanovkirilg@gmail.com>

From: Kiril Ivanov <ivanovkirilg@gmail.com>

Other single-char state indicators (e.g. stash, dirty) as well as
pipe-delimited indicators (e.g. '|CONFLICT') are only shown when
they are actionable.

OTOH, the upstream '=' (up-to-date with the upstream) is simply a
neutral state, which git-prompt is usually quiet about. Therefore,
allow users to hide it.

The 'verbose quiet' combination sounds weird but it may be what the
user wants, and does not conflict with anything else, so why not.

Signed-off-by: Kiril Ivanov <ivanovkirilg@gmail.com>
---
 contrib/completion/git-prompt.sh | 14 ++++++++++----
 t/t9903-bash-prompt.sh           | 10 +++++-----
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 6186c474ba..be23c522da 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -55,13 +55,14 @@
 # enabled.
 #
 # If you would like to see the difference between HEAD and its upstream,
-# set GIT_PS1_SHOWUPSTREAM="auto".  A "<" indicates you are behind, ">"
-# indicates you are ahead, "<>" indicates you have diverged and "="
-# indicates that there is no difference. You can further control
+# set GIT_PS1_SHOWUPSTREAM to a nonempty value.  A "<" indicates you are
+# behind, ">" indicates you are ahead, "<>" indicates you have diverged
+# and "=" indicates that there is no difference.  You can further control
 # behaviour by setting GIT_PS1_SHOWUPSTREAM to a space-separated list
 # of values:
 #
 #     verbose       show number of commits ahead/behind (+/-) upstream
+#     quiet         omit '=' when there is no difference to the upstream
 #     name          if verbose, then also show the upstream abbrev name
 #     legacy        don't use the '--count' option available in recent
 #                   versions of git-rev-list
@@ -157,7 +158,7 @@ __git_ps1_show_upstream ()
 {
 	local key value
 	local svn_remotes="" svn_url_pattern="" count n
-	local upstream_type=git legacy="" verbose="" name=""
+	local upstream_type=git legacy="" verbose="" quiet="" name=""
 	local LF="$__git_LF"
 
 	# get some config options from git-config
@@ -187,6 +188,7 @@ __git_ps1_show_upstream ()
 		case "$option" in
 		git|svn) upstream_type="$option" ;;
 		verbose) verbose=1 ;;
+		quiet)   quiet=1   ;;
 		legacy)  legacy=1  ;;
 		name)    name=1 ;;
 		esac
@@ -262,6 +264,8 @@ __git_ps1_show_upstream ()
 		"") # no upstream
 			p="" ;;
 		"0	0") # equal to upstream
+			[ "$quiet" ] &&
+			p="" ||
 			p="=" ;;
 		"0	"*) # ahead of upstream
 			p=">" ;;
@@ -275,6 +279,8 @@ __git_ps1_show_upstream ()
 		"") # no upstream
 			upstream="" ;;
 		"0	0") # equal to upstream
+			[ "$quiet" ] &&
+			upstream="|u" ||
 			upstream="|u=" ;;
 		"0	"*) # ahead of upstream
 			upstream="|u+${count#0	}" ;;
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 3997012d1c..855428f007 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -520,11 +520,11 @@ test_expect_success 'prompt - untracked files status indicator - not shown insid
 
 ################################################################
 # Show Upstream
-options=(          short  verbose   'verbose name'    )
-expected_equal=(   ' ='   '|u='     '|u= origin/main' )
-expected_ahead=(   ' >'   '|u+1'    '|u+1 origin/main')
-expected_behind=(  ' <'   '|u-1'    '|u-1 origin/b1'  )
-expected_diverged=(' <>'  '|u+1-1'  '|u+1-1 origin/b1')
+options=(          short  verbose   'verbose name'      quiet   'verbose quiet'  'verbose name quiet')
+expected_equal=(   ' ='   '|u='     '|u= origin/main'   ''      '|u'             '|u origin/main'    )
+expected_ahead=(   ' >'   '|u+1'    '|u+1 origin/main'  ' >'    '|u+1'           '|u+1 origin/main'  )
+expected_behind=(  ' <'   '|u-1'    '|u-1 origin/b1'    ' <'    '|u-1'           '|u-1 origin/b1'    )
+expected_diverged=(' <>'  '|u+1-1'  '|u+1-1 origin/b1'  ' <>'   '|u+1-1'         '|u+1-1 origin/b1'  )
 
 for i in ${!options[@]}
 do
-- 
gitgitgadget
