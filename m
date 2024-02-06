Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E1E56B68
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 02:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707185376; cv=none; b=ams4+6AU2ENAF6+wDoQ55j1vH7V43/XLBje/KMDZeGjTTys0DWQGqvXNmbwl/mGbfmhPdlQxPkgQzzo5fPfRCkVvAfH6WXPwxoCfnncjbpc6Werw4GqJ1UOiAvPtcOxS+fUEFLMXU0/8NHEqkqCIV887//OUV0mBbZrYOMdrCCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707185376; c=relaxed/simple;
	bh=It5gCIbSeOT89nUeP4WauYwQ68Qq8cs3daDHgcLoVUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T0ZfBueXj1QVkeJYwn1CjyCy4srrM69FBm42soPL+pd5W9gZOOzTaqrDEclMBR76x+njY1RIjs1T+V7qelf6ng6VEqwGlo3Z7In5F9KiN5b/XT9ylJjX7AB/LBWEVgVxh9bFvsEzEXrH0SAmkILFe0tXVvCF9tug541ilauJGNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+agI3I5; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+agI3I5"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d8aadc624dso38228185ad.0
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 18:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707185374; x=1707790174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXtmhqYFFwTSutZKMF97JDHxuH9zThRsF3fiEBpbgGw=;
        b=Q+agI3I5eQnRocCCOUb/4W+JwQNXRgqG6yvFQxqphVMm8cEHthOw7mszfqx1izTmJ2
         TQi4Z3gvPf9HzQtfhD3vgV92NGe9VJi5UzWsGdvKDz5CKtKrd4HAwwoVT8rkTN+26dph
         Vw7KHjtPULm6Z6vgBIBYNoXb496hnI/YwWmB+jQv8EJ7S9aLGRwOP1lNkWft/x57PcIP
         IhuRl60dspwMEHfCUF16vwNmnkltWF26/Ffy8F8knHeh8P4wyTwKg2OKYxNC4uV7rLjf
         OeIrlgoIHma7XRaGxTXNV5kMDK3q2C6mqCXPPdjynZkeiegyrK/qIicp/g49fLyO7hes
         X0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707185374; x=1707790174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXtmhqYFFwTSutZKMF97JDHxuH9zThRsF3fiEBpbgGw=;
        b=uMoVKrtYMrf24dF9BwJ5usD+VlPQTclLQi1OZn8pRrPAiuM6ykDlCsJJ4JQnSxZAa1
         vNKr0T5T78DXiAIRU9DUnjzBXVfAgbosQe2C1SdNg1bItNmY4tQ63ZULr5jE06NTTmEY
         5k7rOtYrkZcyQNBjF6G0J0vHThhYECy3elS9mExOTT/HpPYdR1k78w7beEfJ8/d3v7iW
         Yr2xCuiqoFSF/DR4xSJabNpIeb7c+tLqVeDSZOmObd4eODV22gwUxr6KfnoNgZJ2ll5I
         bfm8YmcVmF7ZFLjAu9UqL/nT4df58lJxyOG9BghfmjK7NJ1empetCMvYSQVkzsFYTVy/
         sL+w==
X-Gm-Message-State: AOJu0YyKb/TqC42ik5njzq6hIbRc4rkvt2+m2DZbBbMw91DNhU5lCMfZ
	+itB/gWiwwGqhxIfkAZ3PuayNyo3wwQmDx1kgXf2gYQhIs7NiL6w
X-Google-Smtp-Source: AGHT+IGy9WNqIbzrQGl9ysFFBKg0RFmmMjCy9XYyIIMu6lLQWObt6lo8L5wvXCUfIF9yPXgrqGiLEA==
X-Received: by 2002:a17:902:d902:b0:1d9:a527:608f with SMTP id c2-20020a170902d90200b001d9a527608fmr254111plz.64.1707185374423;
        Mon, 05 Feb 2024 18:09:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWxh35ByCW7t3PxOIo5E9FVTdY4RBxV+C2bu+7dfdmnp+9HbjYO71G8J/YOgVEqzI/VVA5hEK6FItwSFBFc4u39SN3ayWWPlNYf+ONDGG7o1w0E
Received: from brittons-large-Vivobook ([2600:380:4635:872e:d8c9:9f5d:4e33:1b6a])
        by smtp.gmail.com with ESMTPSA id w5-20020a170902d3c500b001d91b6175afsm577297plb.18.2024.02.05.18.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 18:09:33 -0800 (PST)
Received: by brittons-large-Vivobook (Postfix, from userid 1000)
	id 7A94052028D; Mon,  5 Feb 2024 17:09:31 -0900 (AKST)
From: Britton Leo Kerin <britton.kerin@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Britton Leo Kerin <britton.kerin@gmail.com>
Subject: [PATCH v5 2/7] completion: bisect: complete bad, new, old, and help subcommands
Date: Mon,  5 Feb 2024 17:09:25 -0900
Message-ID: <20240206020930.312164-3-britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206020930.312164-1-britton.kerin@gmail.com>
References: <20240128223447.342493-1-britton.kerin@gmail.com>
 <20240206020930.312164-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bad, new, old and help subcommands to git-bisect(1) are not
completed.

Add the bad, new, old, and help subcommands to the appropriate lists
such that the commands and their possible ref arguments are completed.
Add tests.

Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.c
---
 contrib/completion/git-completion.bash |  4 +-
 t/t9902-completion.sh                  | 71 ++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 185b47d802..06d0b156e7 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1449,7 +1449,7 @@ _git_bisect ()
 {
 	__git_has_doubledash && return
 
-	local subcommands="start bad good skip reset visualize replay log run"
+	local subcommands="start bad new good old skip reset visualize replay log run help"
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__git_find_repo_path
@@ -1462,7 +1462,7 @@ _git_bisect ()
 	fi
 
 	case "$subcommand" in
-	bad|good|reset|skip|start)
+	bad|new|good|old|reset|skip|start)
 		__git_complete_refs
 		;;
 	*)
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index a5d4e900a2..7388c892cf 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1264,6 +1264,77 @@ test_expect_success 'git switch - with no options, complete local branches and u
 	EOF
 '
 
+test_expect_success 'git bisect - when not bisecting, complete only replay and start subcommands' '
+	test_completion "git bisect " <<-\EOF
+	replay Z
+	start Z
+	EOF
+'
+
+test_expect_success 'setup for git-bisect tests requiring a repo' '
+	git init git-bisect &&
+	(
+		cd git-bisect &&
+		echo "initial contents" >file &&
+		git add file &&
+		git commit -am "Initial commit" &&
+		git tag initial &&
+		echo "new line" >>file &&
+		git commit -am "First change" &&
+		echo "another new line" >>file &&
+		git commit -am "Second change" &&
+		git tag final
+	)
+'
+
+test_expect_success 'git bisect - start subcommand arguments before double-dash are completed as revs' '
+	(
+		cd git-bisect &&
+		test_completion "git bisect start " <<-\EOF
+		HEAD Z
+		final Z
+		initial Z
+		master Z
+		EOF
+	)
+'
+
+# Note that these arguments are <pathspec>s, which in practice the fallback
+# completion (not the git completion) later ends up completing as paths.
+test_expect_success 'git bisect - start subcommand arguments after double-dash are not completed' '
+	(
+		cd git-bisect &&
+		test_completion "git bisect start final initial -- " ""
+	)
+'
+
+test_expect_success 'setup for git-bisect tests requiring ongoing bisection' '
+	(
+		cd git-bisect &&
+		git bisect start --term-new=custom_new --term-old=custom_old final initial
+	)
+'
+
+test_expect_success 'git-bisect - when bisecting all subcommands are candidates' '
+	(
+		cd git-bisect &&
+		test_completion "git bisect " <<-\EOF
+		start Z
+		bad Z
+		new Z
+		good Z
+		old Z
+		skip Z
+		reset Z
+		visualize Z
+		replay Z
+		log Z
+		run Z
+		help Z
+		EOF
+	)
+'
+
 test_expect_success 'git checkout - completes refs and unique remote branches for DWIM' '
 	test_completion "git checkout " <<-\EOF
 	HEAD Z
-- 
2.43.0

