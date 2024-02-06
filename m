Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502605820A
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 02:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707185378; cv=none; b=qJQf47ZUxfUl1qoNl7UpA/cJn9GlaRBUkUnHldFizcSOAalKFQ4l0fdbpgG6N4C8fAs0r7ltjDWZtTPKSNgmdVSxCUyUfO0Z2ZKP6+JZLMB09iYWhN+xuIyIHxnku2BgnlUeuu64mtYI9a6IjBgjIKZEicCremEixULoGEK3jng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707185378; c=relaxed/simple;
	bh=w+EC6JsgpUDKCJ9efaO85nfI2eywx0+7e4oz6qm1a50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmXRcUER5cSwh2vc7/j/yBHhEFou6MCpMdRW920IKMuJaVJzstu+7YAVeEZyTD4Ol1tk43CiPch+oELY6BDyCtFtT+hcLsZzE/cJO283eJ7pL0czZSfLEWEk2NEFVXY+iYel1hpHHNCSmvtTfI+faAkLmy+qLzOhYGyEnKWhjBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6CaZ2Q3; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6CaZ2Q3"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-296c562ac70so288867a91.2
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 18:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707185376; x=1707790176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYU1pUnsExAG/G+Z1gtK5ljLqNb7sAB0Fvf7qCLD2Hc=;
        b=W6CaZ2Q3Ia3JTIAgRU+ckke1TTHT2KZzidxVapHs1KG9FpUNy+O7nthGhMNShzLxe3
         6c46oP+61F/AUirTXdSSz/E8kENgpeISN4ePe2Mk1AalDDMlkbKYQlWm1H7F1E+mRSQg
         j6jt0dAe5RQiNVQje3VFgX1WeUOugovnB/HTwvQAeTd0A4GH1/22e1m/myRJxh7JH0hs
         6xVX3Hw4yP9A9pElF/Aq+2NCvRorwJN9ulC0jTWuirjit97bqiCJQF6D6MJXtd4DPh07
         yBcu96QYW0tPFkDc6rFviqp1mwuVNEAa3Rqd3x79TUdTDSPe1lXri/bwQRDPQ0XGmom+
         lmag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707185376; x=1707790176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dYU1pUnsExAG/G+Z1gtK5ljLqNb7sAB0Fvf7qCLD2Hc=;
        b=V6WpRCnruJ5h2fTb7aNJdy4C4dJH0UU3RL1N4sc+tUb5PwX4MGABJNAeaU9abhVFB/
         sLP96/Nbxp3Rp3PZkzgSwWRapE6bVcwVPDCgiPUHokQtYWdSD8mdFvGhQWaRlgTYkmhj
         XA/uYaMHrRnk6/LkEmXRH/Xdc0AqhKp3C1YVrbj8MuI09gkAEbQ2aRAf5BIu2G3jNQiD
         odLjIKdpPtT4j6TCsvgF/oWb5pY9eHfizjm1xOuJakjW6VjDeL6hdcQQDk93a8vUqfWb
         UHQtce/ajVosLILSVeBnVGSCnUo0OiY0OpqszWYWfZBjdwL/ELuL3JNXG4sQKOzn2OxG
         k45g==
X-Gm-Message-State: AOJu0YyPrHWowp4r+4ckCBLAfW+E0x89sHXdmkt7fPfql8NM4oDPm2Ct
	JbdYxqaHBCfy/+43uw5xlApkQaHT1cYQZi2tRI1SjNNgYY1N3T8n
X-Google-Smtp-Source: AGHT+IGp9x80r8FQyAW3w+kBKZKAfrc58334sFTEeJUERV0GcUamAchKWsf3WNsi8W4T3ypzRtgnXg==
X-Received: by 2002:a17:90a:6f46:b0:294:8eb6:85f9 with SMTP id d64-20020a17090a6f4600b002948eb685f9mr1339110pjk.17.1707185376638;
        Mon, 05 Feb 2024 18:09:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWSKVZZd3wMsZ5R2Pr2FQoduD8hCiQre79EO79a5ipBtPYWIUY2D3Ea3YiezaWKawW+IvSfqMwDDmjFgoWTx3qsS9poxXc8z7nRQU4NuqwkLixF
Received: from brittons-large-Vivobook (mobile-166-171-250-223.mycingular.net. [166.171.250.223])
        by smtp.gmail.com with ESMTPSA id gm3-20020a17090b100300b002955eff3182sm190471pjb.10.2024.02.05.18.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 18:09:33 -0800 (PST)
Received: by brittons-large-Vivobook (Postfix, from userid 1000)
	id 7C812520296; Mon,  5 Feb 2024 17:09:31 -0900 (AKST)
From: Britton Leo Kerin <britton.kerin@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Britton Leo Kerin <britton.kerin@gmail.com>
Subject: [PATCH v5 3/7] completion: bisect: complete custom terms and related options
Date: Mon,  5 Feb 2024 17:09:26 -0900
Message-ID: <20240206020930.312164-4-britton.kerin@gmail.com>
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

git bisect supports the use of custom terms via the --term-(new|bad) and
--term-(old|good) options, but the completion code doesn't know about
these options or the new subcommands they define.

Add support for these options and the custom subcommands by checking for
BISECT_TERMS and adding them to the list of subcommands.  Add tests.

Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
---
 contrib/completion/git-completion.bash | 32 ++++++++++++++++++++++++--
 t/t9902-completion.sh                  | 15 ++++++++++++
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 06d0b156e7..6a3d9c7760 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1449,7 +1449,20 @@ _git_bisect ()
 {
 	__git_has_doubledash && return
 
-	local subcommands="start bad new good old skip reset visualize replay log run help"
+	__git_find_repo_path
+
+	# If a bisection is in progress get the terms being used.
+	local term_bad term_good
+	if [ -f "$__git_repo_path"/BISECT_TERMS ]; then
+		term_bad=$(__git bisect terms --term-bad)
+		term_good=$(__git bisect terms --term-good)
+	fi
+
+	# We will complete any custom terms, but still always complete the
+	# more usual bad/new/good/old because git bisect gives a good error
+	# message if these are given when not in use, and that's better than
+	# silent refusal to complete if the user is confused.
+	local subcommands="start bad new $term_bad good old $term_good terms skip reset visualize replay log run help"
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__git_find_repo_path
@@ -1462,7 +1475,22 @@ _git_bisect ()
 	fi
 
 	case "$subcommand" in
-	bad|new|good|old|reset|skip|start)
+	start)
+		case "$cur" in
+		--*)
+			__gitcomp "--term-new --term-bad --term-old --term-good"
+			return
+			;;
+		*)
+			__git_complete_refs
+			;;
+		esac
+		;;
+	terms)
+		__gitcomp "--term-good --term-old --term-bad --term-new"
+		return
+		;;
+	bad|new|"$term_bad"|good|old|"$term_good"|reset|skip)
 		__git_complete_refs
 		;;
 	*)
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 7388c892cf..409a5a49d5 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1321,9 +1321,12 @@ test_expect_success 'git-bisect - when bisecting all subcommands are candidates'
 		test_completion "git bisect " <<-\EOF
 		start Z
 		bad Z
+		custom_new Z
+		custom_old Z
 		new Z
 		good Z
 		old Z
+		terms Z
 		skip Z
 		reset Z
 		visualize Z
@@ -1334,6 +1337,18 @@ test_expect_success 'git-bisect - when bisecting all subcommands are candidates'
 		EOF
 	)
 '
+test_expect_success 'git-bisect - options to terms subcommand are candidates' '
+	(
+		cd git-bisect &&
+		test_completion "git bisect terms --" <<-\EOF
+		--term-bad Z
+		--term-good Z
+		--term-new Z
+		--term-old Z
+		EOF
+	)
+'
+
 
 test_expect_success 'git checkout - completes refs and unique remote branches for DWIM' '
 	test_completion "git checkout " <<-\EOF
-- 
2.43.0

