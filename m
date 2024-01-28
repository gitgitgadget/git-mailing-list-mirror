Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4448D45BE9
	for <git@vger.kernel.org>; Sun, 28 Jan 2024 22:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706481301; cv=none; b=P4XlWJLXNDPDsjbkFtG+DA5pNX39w4B3PDeMl0pqThHIz3JC7/FotsKiXu2q7u/ME8BEccPusngn97ncyOXWSi/MfBv+QGmAmwwF+Q9KrAC6uZYtYkOT4G8G3+2L1uuv4OF25Ipg+veKVVpRsn5yXApUTad/D88faukDotSGH2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706481301; c=relaxed/simple;
	bh=6DeqdR0FDSo4xrhOBEf5P3jC+c4poSkaHL0OdhoL/os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSoCwIg7M8R3wlFiDkVNOOwKkqY2F/dv48Ra6w5uwjd0rDk7uwf5NRevYzIlwhDkl6J8z/cawzo5JHrJma6Pr6N4CYceQggNSRot8s3JofTZaLchviz3mglwlH2v+5QNzSVzSSV+0xqqOkXwWHskGUvdtctkrhaH3qJ5/E+7eKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCsvnk4F; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCsvnk4F"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ddcfbc5a5fso1971047b3a.2
        for <git@vger.kernel.org>; Sun, 28 Jan 2024 14:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706481299; x=1707086099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+ifp6pK/q+XHI+srjS5uN1ERWLivbtwW/FOa11u8A8=;
        b=WCsvnk4FeKkqQABmBY17HFR+uVVtWH8FmNHrp8/DtYJ3uUmJbtvsvMTLATMxoecuxy
         wIJ8Ez/e8saxuE0E4WhTD+darEeTdJkkFwlJi+k+Y40DUUCJtO8YtTa33PD9bT7xWww3
         N4+ObV5OtnDtBT2ExnR5djN60T9UXK9jb5xElXcZDUhE46DM8OvfJasUllZSerRbDCX5
         ZJ+Q3yzj4I/J4r1u6m95bwAwoldLAwh28pEwnx44ihCLBLxisoUSV+Qb1JErnXBRWsLi
         fQzyqH0ao1NIn6xUgKlW6Mts3ACEEij6vok79rsz7csYNsys29uu784ZI+FfN/9JCJke
         DgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706481299; x=1707086099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+ifp6pK/q+XHI+srjS5uN1ERWLivbtwW/FOa11u8A8=;
        b=GM77sP7lfZ71heXjorFfuDewMzJBbm0CyYPy0dfghixl4SwpIhav8IDYsyPtQo+WQt
         1sbvNzrhaHVxTvVjFDCs1hSlY9Mqz9gmG8FATKdk8ZHL2wLV+Pk+YynVjfy5IsOyrQeg
         CIrTqD+dnc+7GeoUtaqAN/B8+s9hIR34cWa6fB21hdaodXXhG7cRVR1mg6c1a3WUvBYO
         R10B/E0j20s0CbGmNVNbJlH/xcyKYDp8JQuuiFlku+qGDdjxtX1O4csya4U+Y6yje3Lf
         4EIhGazTcanwmvwKFT8ExVWufhpiNASAzV9COKKNstuYVOWIRhFRAEN30WxcZgz3itG9
         ME8w==
X-Gm-Message-State: AOJu0YzdD3mPYH2Gg14oCE6RuT8Uawpzt07d+hPsrRbk8BOeisnfGq7A
	KBuM71K3ZXKUrUjxOMUwVZdCRQ7V9/8XdkOErp4IBTVTpG5xFZ0F
X-Google-Smtp-Source: AGHT+IG7p9RFX6QVcZ0+Q/th/D+Nv5nfEhVoxj1/qaPzkusdmDtzWSncfbKCX3SrXeqFB/889/3EQw==
X-Received: by 2002:a05:6a00:80c4:b0:6dd:a004:c193 with SMTP id ei4-20020a056a0080c400b006dda004c193mr3011930pfb.12.1706481299534;
        Sun, 28 Jan 2024 14:34:59 -0800 (PST)
Received: from brittons-large-Vivobook ([209.112.166.194])
        by smtp.gmail.com with ESMTPSA id f15-20020aa79d8f000000b006dd872c00dasm4719212pfq.96.2024.01.28.14.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 14:34:57 -0800 (PST)
Received: by brittons-large-Vivobook (Postfix, from userid 1000)
	id 6FD11520538; Sun, 28 Jan 2024 13:34:50 -0900 (AKST)
From: Britton Leo Kerin <britton.kerin@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Britton Leo Kerin <britton.kerin@gmail.com>
Subject: [PATCH v4 5/8] completion: log: use __git_complete_log_opts
Date: Sun, 28 Jan 2024 13:34:44 -0900
Message-ID: <20240128223447.342493-6-britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128223447.342493-1-britton.kerin@gmail.com>
References: <20240118204323.1113859-1-britton.kerin@gmail.com>
 <20240128223447.342493-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new __git_complete_log_opts function to handle option and
optiona rgument completion in _git_log.

Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
---
 contrib/completion/git-completion.bash | 95 +-------------------------
 1 file changed, 3 insertions(+), 92 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index dfd504c37e..41c76c1246 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2195,98 +2195,9 @@ _git_log ()
 	__git_has_doubledash && return
 	__git_find_repo_path
 
-	local merge=""
-	if [ -f "$__git_repo_path/MERGE_HEAD" ]; then
-		merge="--merge"
-	fi
-	case "$prev,$cur" in
-	-L,:*:*)
-		return	# fall back to Bash filename completion
-		;;
-	-L,:*)
-		__git_complete_symbol --cur="${cur#:}" --sfx=":"
-		return
-		;;
-	-G,*|-S,*)
-		__git_complete_symbol
-		return
-		;;
-	esac
-	case "$cur" in
-	--pretty=*|--format=*)
-		__gitcomp "$__git_log_pretty_formats $(__git_pretty_aliases)
-			" "" "${cur#*=}"
-		return
-		;;
-	--date=*)
-		__gitcomp "$__git_log_date_formats" "" "${cur##--date=}"
-		return
-		;;
-	--decorate=*)
-		__gitcomp "full short no" "" "${cur##--decorate=}"
-		return
-		;;
-	--diff-algorithm=*)
-		__gitcomp "$__git_diff_algorithms" "" "${cur##--diff-algorithm=}"
-		return
-		;;
-	--submodule=*)
-		__gitcomp "$__git_diff_submodule_formats" "" "${cur##--submodule=}"
-		return
-		;;
-	--ws-error-highlight=*)
-		__gitcomp "$__git_ws_error_highlight_opts" "" "${cur##--ws-error-highlight=}"
-		return
-		;;
-	--no-walk=*)
-		__gitcomp "sorted unsorted" "" "${cur##--no-walk=}"
-		return
-		;;
-	--diff-merges=*)
-                __gitcomp "$__git_diff_merges_opts" "" "${cur##--diff-merges=}"
-                return
-                ;;
-	--*)
-		__gitcomp "
-			$__git_log_common_options
-			$__git_log_shortlog_options
-			$__git_log_gitk_options
-			$__git_log_show_options
-			--root --topo-order --date-order --reverse
-			--follow --full-diff
-			--abbrev-commit --no-abbrev-commit --abbrev=
-			--relative-date --date=
-			--pretty= --format= --oneline
-			--show-signature
-			--cherry-mark
-			--cherry-pick
-			--graph
-			--decorate --decorate= --no-decorate
-			--walk-reflogs
-			--no-walk --no-walk= --do-walk
-			--parents --children
-			--expand-tabs --expand-tabs= --no-expand-tabs
-			$merge
-			$__git_diff_common_options
-			"
-		return
-		;;
-	-L:*:*)
-		return	# fall back to Bash filename completion
-		;;
-	-L:*)
-		__git_complete_symbol --cur="${cur#-L:}" --sfx=":"
-		return
-		;;
-	-G*)
-		__git_complete_symbol --pfx="-G" --cur="${cur#-G}"
-		return
-		;;
-	-S*)
-		__git_complete_symbol --pfx="-S" --cur="${cur#-S}"
-		return
-		;;
-	esac
+	__git_complete_log_opts
+	[ -z "$COMPREPLY" ] || return
+
 	__git_complete_revlist
 }
 
-- 
2.43.0

