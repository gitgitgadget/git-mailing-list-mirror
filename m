Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA29828EC
	for <git@vger.kernel.org>; Sun, 25 Feb 2024 23:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708905222; cv=none; b=S0rlOrHPiUDaaRjFXjccXzy7u9thnAbgDbpmuFD2x8aeu386StBAU665BaJ+h0AYU9USuPIxcyX2h/zQEOQzFlGdZz2BqWZ+mn1q8N5M7uHFRqRIUMHtY0DcL7zSLIqZtQ97psJofJi/uBWmQx1S2o5KIr/BchIqFxLqkVPyV/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708905222; c=relaxed/simple;
	bh=P3Yo1cHeXNK3pSxdOkAOAo5PZY3rxqvSIHJAF4IFcT8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=X+zUjpl7xUhvlcWVgGgYdl9UkkoIuSK0YhLNvbr2ruCo15YrkWtxC259ZI3R5vgcWeo5zEPC9QAic1wQRI7OHReLf903fXdZiXrPpE3BvsNF5LU+8fuw5r2lT7pcnlE8oFDjc2CAVgP2zZ2Gw3+MNjBJ4asEbOJjQ7tJTx7kwdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1R6Cb46; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1R6Cb46"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412a4a932f4so3061265e9.0
        for <git@vger.kernel.org>; Sun, 25 Feb 2024 15:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708905219; x=1709510019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d7p6MLF+lf/yqHgK3IhuSGHFGsD4soiPB11aMOr2fUs=;
        b=C1R6Cb46iXGNBRdDrOHI7aWKE0volrjZ46ggOCibg51V/Fjbm1f6NqtuYgLtRdCHOP
         QuMKu4vCqPjmrAjfmNTY0gBW2Ecx5CscixsREsZ2B9XI0SRZyP4nl7aY+zPUPFvbCJvW
         VxURN9DN8tWzNmyBXcWQcOEpVBC7fGKrlD2gqWtOF9eT1bKJ3WGbXtsVB/sP3duS7g35
         a0aLlImOSZMBvhnWM1YM2mB9buc+edGiPqL1aUXXolja9PMEkAQSwMBIkyoitNb1w36u
         EZbER63zZ7CLbCAt75GTDhAWPwLq1qOSO0ptBqV4zgjGB3HdjWnyCAFkKWR+bdiIEkvs
         rEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708905219; x=1709510019;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d7p6MLF+lf/yqHgK3IhuSGHFGsD4soiPB11aMOr2fUs=;
        b=uf6w8xH2qhCO4Sm9mjtdvzg6sn3JoS2sanf03LwoK43CI/rAwJVdzN4FjEzbpnfFbF
         lOtCqswYv6Wo/Yoxm39zgqbE1NFzIl0k3/awfIEmpvgSI9JxDEWnvUX+HXNCkRT4SPnv
         CnNFU1uphu6E33tcRqBT/NhA5NUkhF0FmNCfgxvB2cp7vjgz3475SPlc7RBWla3SCe3Y
         LrZAw0FsA5BzL+eC/wlX1BTRrLVUbTYkMEWCxeoDLcTXnMNR7Q2hWvsKj0L9PmFpqKLv
         SLYLIiItkMc+sTIcdt6Gy9s9GZ7L+924B+6+w9rz5MiNqkm+f7zHL4Ul2yRB/5N81kv2
         DFEg==
X-Gm-Message-State: AOJu0Yz5pSeqLJKGAv1Mcc6cYAarhZ0OR+gNiXOyaucSu0EtwU0RazmE
	CfdpoPHz8yItpR/px5fZDhkj3oWf0glwoo7q5sLAa1iLQB5tjfEydiadFuj0
X-Google-Smtp-Source: AGHT+IHHulONeD1en8/7xwWcA7S4xEMzklEKx4FWhJC+lUW/+GgywzRBcduGOP22q94p+j7/ieNLNQ==
X-Received: by 2002:a05:600c:49a7:b0:412:96ee:a67d with SMTP id h39-20020a05600c49a700b0041296eea67dmr3604691wmp.39.1708905218981;
        Sun, 25 Feb 2024 15:53:38 -0800 (PST)
Received: from gmail.com (198.red-88-14-62.dynamicip.rima-tde.net. [88.14.62.198])
        by smtp.gmail.com with ESMTPSA id 19-20020a05600c249300b00411e1574f7fsm9966930wms.44.2024.02.25.15.53.36
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Feb 2024 15:53:38 -0800 (PST)
Message-ID: <eaf3649e-30cf-4eba-befa-5be826c828a8@gmail.com>
Date: Mon, 26 Feb 2024 00:53:31 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] completion: fix __git_complete_worktree_paths
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <a1561e02-40dc-4ac3-ae7a-666db0f810ed@gmail.com>
Content-Language: en-US
In-Reply-To: <a1561e02-40dc-4ac3-ae7a-666db0f810ed@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use __git to invoke "worktree list" in __git_complete_worktree_paths, to
respect any "-C" and "--git-dir" options present on the command line.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---

I stumbled upon this in a situation like:

   $ git init /tmp/foo && cd /tmp/foo
   $ git worktree add --orphan foo_wt

   $ git init /tmp/bar && cd /tmp/bar
   $ git worktree add --orphan bar_wt

   $ cd /tmp/foo
   $ git -C /tmp/bar worktree remove <TAB>
   ... expecting /tmp/bar/wt, but ...
   $ git -C /tmp/bar worktree remove /tmp/foo_wt

In this iteration, v2, some tests are included.

The function __git was introduced in 1cd23e9e05 (completion: don't use
__gitdir() for git commands, 2017-02-03).  It is a small function, so
I'll include here to ease the review of this patch:

	# Runs git with all the options given as argument, respecting any
	# '--git-dir=<path>' and '-C <path>' options present on the command line
	__git ()
	{
		git ${__git_C_args:+"${__git_C_args[@]}"} \
			${__git_dir:+--git-dir="$__git_dir"} "$@" 2>/dev/null
	}


 contrib/completion/git-completion.bash |  2 +-
 t/t9902-completion.sh                  | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 444b3efa63..86e55dc67f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3571,7 +3571,7 @@ __git_complete_worktree_paths ()
 	# Generate completion reply from worktree list skipping the first
 	# entry: it's the path of the main worktree, which can't be moved,
 	# removed, locked, etc.
-	__gitcomp_nl "$(git worktree list --porcelain |
+	__gitcomp_nl "$(__git worktree list --porcelain |
 		sed -n -e '2,$ s/^worktree //p')"
 }
 
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index b16c284181..7c0f82f31a 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1263,6 +1263,30 @@ test_expect_success '__git_complete_fetch_refspecs - fully qualified & prefix' '
 	test_cmp expected out
 '
 
+test_expect_success '__git_complete_worktree_paths' '
+	test_when_finished "git worktree remove other_wt" &&
+	git worktree add --orphan other_wt &&
+	run_completion "git worktree remove " &&
+	grep other_wt out
+'
+
+test_expect_success '__git_complete_worktree_paths - not a git repository' '
+	(
+		cd non-repo &&
+		GIT_CEILING_DIRECTORIES="$ROOT" &&
+		export GIT_CEILING_DIRECTORIES &&
+		test_completion "git worktree remove " "" 2>err &&
+		test_must_be_empty err
+	)
+'
+
+test_expect_success '__git_complete_worktree_paths with -C' '
+	test_when_finished "rm -rf to_delete" &&
+	git -C otherrepo worktree add --orphan otherrepo_wt &&
+	run_completion "git -C otherrepo worktree remove " &&
+	grep otherrepo_wt out
+'
+
 test_expect_success 'git switch - with no options, complete local branches and unique remote branch names for DWIM logic' '
 	test_completion "git switch " <<-\EOF
 	branch-in-other Z
-- 
2.44.0.1.g0da3aa8f7f
