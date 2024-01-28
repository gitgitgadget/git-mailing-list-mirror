Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFBD4597B
	for <git@vger.kernel.org>; Sun, 28 Jan 2024 22:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706481299; cv=none; b=HtlucELysj9OQb5Ji5WzzOqg1SYxQLvYYRHZZ+cMG9OXJWTzyVgIOrPrKDHDPwADsnuUaizHC9GrjdnMQNVdTqL8JiGrpzLLWzZZhNNwSkhpdEEreT44Nw7x5gOKuwFEM1IY58BCNpjjuO/I0HYUEHfAxT7uv8L+2lvPtPemWCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706481299; c=relaxed/simple;
	bh=yI4ODXVmuJ6pyU9eRaG7IWPstsjTDUP7V+DfNO3Kjgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PvNrwyZLrWRbhFhKYsWbeuEgEST4nuQYqgizHSNk0etA0PHGuzdu22iE0phesaWaq9USsR74GfYQopKk5U9UtZV97jnDqdRxGC83fmr+fhPcfoCdGJV9MENYwcn2AiMzgqf1fkoOTotuFf0U0ZXCB2XiDs9SEUewlO3gmxUyVsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWR75Vs8; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWR75Vs8"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bda741ad7dso2160845b6e.1
        for <git@vger.kernel.org>; Sun, 28 Jan 2024 14:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706481297; x=1707086097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BkTK08UOPOjv6AcR+XQol2vKWuh1ulYF3/6efR4Nhc=;
        b=SWR75Vs8DjP3B7ojb+ZfChakqe21E93pg5Uo3uR702rQt5g65J2eZM/KRaa5aeMJ4L
         pYft268t6ht+01ZLDUZsUCtzZA6EpSEDUPShvBnHasTwuarvPgcsjdY8F9M6rkEEuDc/
         qN/o0hp0nisR0xvu1Q75PMXkYgMlusPi+DJDvS8Obmwpg4MguHHcfJqwKyReLcfbLTT/
         Kk/C15RaZg5TM+zW9s3AKiUssCUDhA3juVqjblZTgIfjkWUsThChnooMePsdizeROHfc
         O25nA7Q5UwCN73XVnBQCBsEnXifji5N4dIW5ly/w+uCzMy+s/7EcoVmkxUuUqKydfzTI
         Bsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706481297; x=1707086097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BkTK08UOPOjv6AcR+XQol2vKWuh1ulYF3/6efR4Nhc=;
        b=pTPxZ6YfUZDg2/y3hY4fPz3AQJFSUTx3UO2aUbaXtjlFoxkaUN6RI8a+ufOcQQ1Tfa
         gkqrjxBZaq0wxZPMM43ZhwftfbbAGybe0THMWTsDDOiamR3XDUXx6Bz8BxsqqQJaDtgh
         g7TYWYnaPp6EoprQ4EP3/7EsUtQfX6LXo5vB9+pmk17L3358cu9dSdG4UaNraBV8Z4JZ
         FJZgFpFV4ym/K2ZfWyZi6hO8KFYLvnP3pI2lHQGbZpfU6pvtN58EEXV1gDb7vSOMtLeA
         DoZYcQj6YlEXk5ocXd5ahlsaMWdK5XYSZvsKWOc6y5WM+CTOVa0cRf6pj7cm6aT/bZll
         8VSw==
X-Gm-Message-State: AOJu0YwhSLHF4VXcDHDg7RwoKZlEsAJ6hllPxldq57d2KBsyn2ofSewI
	3XPkPbc8iyo5mUrAqiQgSII0ACKDL2HSE3z9HOssUU6HmjNPfeI4c/rv//L/
X-Google-Smtp-Source: AGHT+IFxwfJA/S3TmbXXqh83xFJUZ16ehAbbgwr0Dsin2fBvzJcMALsHe8kPF0NsyPwPcZF8AF2OIA==
X-Received: by 2002:a05:6808:23ca:b0:3be:453d:7654 with SMTP id bq10-20020a05680823ca00b003be453d7654mr2889619oib.48.1706481297027;
        Sun, 28 Jan 2024 14:34:57 -0800 (PST)
Received: from brittons-large-Vivobook ([209.112.166.194])
        by smtp.gmail.com with ESMTPSA id a15-20020a631a0f000000b005c662e103a1sm4763372pga.41.2024.01.28.14.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 14:34:53 -0800 (PST)
Received: by brittons-large-Vivobook (Postfix, from userid 1000)
	id 6455352019B; Sun, 28 Jan 2024 13:34:50 -0900 (AKST)
From: Britton Leo Kerin <britton.kerin@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Britton Leo Kerin <britton.kerin@gmail.com>
Subject: [PATCH v4 0/8] completion: improvements for git-bisect
Date: Sun, 28 Jan 2024 13:34:39 -0900
Message-ID: <20240128223447.342493-1-britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118204323.1113859-1-britton.kerin@gmail.com>
References: <20240118204323.1113859-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Relative to v3 this reworks the commit contents and descriptions
according to review suggestions, removes unnecessary case statements and
precondition, adds option completion for the terms subcommand, and adds
tests.

Britton Leo Kerin (8):
  completion: bisect: complete bad, new, old, and help subcommands
  completion: bisect: complete custom terms and related options
  completion: bisect: complete missing --first-parent and --no-checkout
    options
  completion: new function __git_complete_log_opts
  completion: log: use __git_complete_log_opts
  completion: bisect: complete log opts for visualize subcommand
  completion: bisect: recognize but do not complete view subcommand
  completion: add tests for git-bisect

 contrib/completion/git-completion.bash |  65 ++++++++++--
 t/t9902-completion.sh                  | 135 +++++++++++++++++++++++++
 2 files changed, 193 insertions(+), 7 deletions(-)

Range-diff against v3:
1:  e16264bfb9 ! 1:  66153024c3 completion: complete new old actions, start opts
    @@ Metadata
     Author: Britton Leo Kerin <britton.kerin@gmail.com>

      ## Commit message ##
    -    completion: complete new old actions, start opts
    +    completion: bisect: complete bad, new, old, and help subcommands
    +
    +    The bad, new, old and help subcommands to git-bisect(1) are not
    +    completed.
    +
    +    Add the bad, new, old, and help subcommands to the appropriate lists
    +    such that the commands and their possible ref arguments are completed.

         Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>

    @@ contrib/completion/git-completion.bash: _git_bisect ()
      	__git_has_doubledash && return

     -	local subcommands="start bad good skip reset visualize replay log run"
    -+	local subcommands="start bad new good old terms skip reset visualize replay log run help"
    ++	local subcommands="start bad new good old skip reset visualize replay log run help"
      	local subcommand="$(__git_find_on_cmdline "$subcommands")"
      	if [ -z "$subcommand" ]; then
      		__git_find_repo_path
    @@ contrib/completion/git-completion.bash: _git_bisect ()

      	case "$subcommand" in
     -	bad|good|reset|skip|start)
    -+	start)
    -+		case "$cur" in
    -+		--*)
    -+			__gitcomp "--term-new --term-bad --term-old --term-good --first-parent --no-checkout"
    -+			return
    -+			;;
    -+		*)
    -+			;;
    -+		esac
    -+		;;
    -+	esac
    -+
    -+	case "$subcommand" in
     +	bad|new|good|old|reset|skip|start)
      		__git_complete_refs
      		;;
2:  130abe3460 < -:  ---------- completion: git-log opts to bisect visualize
-:  ---------- > 2:  7eb8c842a3 completion: bisect: complete custom terms and related options
-:  ---------- > 3:  5f5076bb93 completion: bisect: complete missing --first-parent and --no-checkout options
3:  d659ace9c2 ! 4:  c8ffa0e915 completion: move to maintain define-before-use
    @@ Metadata
     Author: Britton Leo Kerin <britton.kerin@gmail.com>

      ## Commit message ##
    -    completion: move to maintain define-before-use
    +    completion: new function __git_complete_log_opts
    +
    +    The options accepted by git-log are also accepted by at least one other
    +    command (git-bisect).  Prepare to factor out the common option and
    +    option argument completion code by defining a new function.

         Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>

      ## contrib/completion/git-completion.bash ##
    -@@ contrib/completion/git-completion.bash: _git_archive ()
    - 	__git_complete_file
    - }
    +@@ contrib/completion/git-completion.bash: __git_diff_merges_opts="off none on first-parent 1 separate m combined c dense-c
    + __git_log_pretty_formats="oneline short medium full fuller reference email raw format: tformat: mboxrd"
    + __git_log_date_formats="relative iso8601 iso8601-strict rfc2822 short local default human raw unix auto: format:"

    -+# Options that go well for log, shortlog and gitk
    -+__git_log_common_options="
    -+	--not --all
    -+	--branches --tags --remotes
    -+	--first-parent --merges --no-merges
    -+	--max-count=
    -+	--max-age= --since= --after=
    -+	--min-age= --until= --before=
    -+	--min-parents= --max-parents=
    -+	--no-min-parents --no-max-parents
    -+"
    -+# Options that go well for log and gitk (not shortlog)
    -+__git_log_gitk_options="
    -+	--dense --sparse --full-history
    -+	--simplify-merges --simplify-by-decoration
    -+	--left-right --notes --no-notes
    -+"
    -+# Options that go well for log and shortlog (not gitk)
    -+__git_log_shortlog_options="
    -+	--author= --committer= --grep=
    -+	--all-match --invert-grep
    -+"
    -+# Options accepted by log and show
    -+__git_log_show_options="
    -+	--diff-merges --diff-merges= --no-diff-merges --dd --remerge-diff
    -+"
    -+
    -+__git_diff_merges_opts="off none on first-parent 1 separate m combined c dense-combined cc remerge r"
    -+
    -+__git_log_pretty_formats="oneline short medium full fuller reference email raw format: tformat: mboxrd"
    -+__git_log_date_formats="relative iso8601 iso8601-strict rfc2822 short local default human raw unix auto: format:"
    -+
    -+# Check for only porcelain (i.e. not git-rev-list) option (not argument)
    -+# and selected option argument completions for git-log options and if any
    -+# are found put them in COMPREPLY.  COMPREPLY must be empty at the start,
    -+# and will be empty on return if no candidates are found.
    ++# Complete porcelain (i.e. not git-rev-list) options and at least some
    ++# option arguments accepted by git-log.  Note that this same set of options
    ++# are also accepted by some other git commands besides git-log.
     +__git_complete_log_opts ()
     +{
    -+	[ -z "$COMPREPLY" ] || return 1   # Precondition
    ++        COMPREPLY=""
     +
     +	local merge=""
     +	if [ -f "$__git_repo_path/MERGE_HEAD" ]; then
    @@ contrib/completion/git-completion.bash: _git_archive ()
     +	esac
     +}
     +
    - _git_bisect ()
    - {
    - 	__git_has_doubledash && return
    -@@ contrib/completion/git-completion.bash: _git_ls_tree ()
    - 	__git_complete_file
    - }
    -
    --# Options that go well for log, shortlog and gitk
    --__git_log_common_options="
    --	--not --all
    --	--branches --tags --remotes
    --	--first-parent --merges --no-merges
    --	--max-count=
    --	--max-age= --since= --after=
    --	--min-age= --until= --before=
    --	--min-parents= --max-parents=
    --	--no-min-parents --no-max-parents
    --"
    --# Options that go well for log and gitk (not shortlog)
    --__git_log_gitk_options="
    --	--dense --sparse --full-history
    --	--simplify-merges --simplify-by-decoration
    --	--left-right --notes --no-notes
    --"
    --# Options that go well for log and shortlog (not gitk)
    --__git_log_shortlog_options="
    --	--author= --committer= --grep=
    --	--all-match --invert-grep
    --"
    --# Options accepted by log and show
    --__git_log_show_options="
    --	--diff-merges --diff-merges= --no-diff-merges --dd --remerge-diff
    --"
    --
    --__git_diff_merges_opts="off none on first-parent 1 separate m combined c dense-combined cc remerge r"
    --
    --__git_log_pretty_formats="oneline short medium full fuller reference email raw format: tformat: mboxrd"
    --__git_log_date_formats="relative iso8601 iso8601-strict rfc2822 short local default human raw unix auto: format:"
    --
    --
    --# Check for only porcelain (i.e. not git-rev-list) option (not argument)
    --# and selected option argument completions for git-log options and if any
    --# are found put them in COMPREPLY.  COMPREPLY must be empty at the start,
    --# and will be empty on return if no candidates are found.
    --__git_complete_log_opts ()
    --{
    --	[ -z "$COMPREPLY" ] || return 1   # Precondition
    --
    --	local merge=""
    --	if [ -f "$__git_repo_path/MERGE_HEAD" ]; then
    --		merge="--merge"
    --	fi
    --	case "$prev,$cur" in
    --	-L,:*:*)
    --		return	# fall back to Bash filename completion
    --		;;
    --	-L,:*)
    --		__git_complete_symbol --cur="${cur#:}" --sfx=":"
    --		return
    --		;;
    --	-G,*|-S,*)
    --		__git_complete_symbol
    --		return
    --		;;
    --	esac
    --	case "$cur" in
    --	--pretty=*|--format=*)
    --		__gitcomp "$__git_log_pretty_formats $(__git_pretty_aliases)
    --			" "" "${cur#*=}"
    --		return
    --		;;
    --	--date=*)
    --		__gitcomp "$__git_log_date_formats" "" "${cur##--date=}"
    --		return
    --		;;
    --	--decorate=*)
    --		__gitcomp "full short no" "" "${cur##--decorate=}"
    --		return
    --		;;
    --	--diff-algorithm=*)
    --		__gitcomp "$__git_diff_algorithms" "" "${cur##--diff-algorithm=}"
    --		return
    --		;;
    --	--submodule=*)
    --		__gitcomp "$__git_diff_submodule_formats" "" "${cur##--submodule=}"
    --		return
    --		;;
    --	--ws-error-highlight=*)
    --		__gitcomp "$__git_ws_error_highlight_opts" "" "${cur##--ws-error-highlight=}"
    --		return
    --		;;
    --	--no-walk=*)
    --		__gitcomp "sorted unsorted" "" "${cur##--no-walk=}"
    --		return
    --		;;
    --	--diff-merges=*)
    --                __gitcomp "$__git_diff_merges_opts" "" "${cur##--diff-merges=}"
    --                return
    --                ;;
    --	--*)
    --		__gitcomp "
    --			$__git_log_common_options
    --			$__git_log_shortlog_options
    --			$__git_log_gitk_options
    --			$__git_log_show_options
    --			--root --topo-order --date-order --reverse
    --			--follow --full-diff
    --			--abbrev-commit --no-abbrev-commit --abbrev=
    --			--relative-date --date=
    --			--pretty= --format= --oneline
    --			--show-signature
    --			--cherry-mark
    --			--cherry-pick
    --			--graph
    --			--decorate --decorate= --no-decorate
    --			--walk-reflogs
    --			--no-walk --no-walk= --do-walk
    --			--parents --children
    --			--expand-tabs --expand-tabs= --no-expand-tabs
    --			$merge
    --			$__git_diff_common_options
    --			"
    --		return
    --		;;
    --	-L:*:*)
    --		return	# fall back to Bash filename completion
    --		;;
    --	-L:*)
    --		__git_complete_symbol --cur="${cur#-L:}" --sfx=":"
    --		return
    --		;;
    --	-G*)
    --		__git_complete_symbol --pfx="-G" --cur="${cur#-G}"
    --		return
    --		;;
    --	-S*)
    --		__git_complete_symbol --pfx="-S" --cur="${cur#-S}"
    --		return
    --		;;
    --	esac
    --}
    --
      _git_log ()
      {
      	__git_has_doubledash && return
4:  c5bee633b2 < -:  ---------- completion: custom git-bisect terms
5:  2bd0cb26f1 < -:  ---------- completion: git-bisect view recognized but not completed
-:  ---------- > 5:  733613d1ed completion: log: use __git_complete_log_opts
-:  ---------- > 6:  06f5973b3b completion: bisect: complete log opts for visualize subcommand
-:  ---------- > 7:  1dc9323f24 completion: bisect: recognize but do not complete view subcommand
-:  ---------- > 8:  451b7a4467 completion: add tests for git-bisect
--
2.43.0

