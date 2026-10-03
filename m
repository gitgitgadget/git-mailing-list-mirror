Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11041370AD8
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 11:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791026532; cv=none; b=sKZFZgptXfRJ1UAUFBY2bVSP2kYcETojbO1JFAzZ9VQANm9R1QrfDPGQWmK8fk65FvDj19GMElfB23Mch1yXnidRc5Hzhxo6YTumqdP4WT1d7nl39zdxGfHPmuIBcWT7TI4zuvpwBOq3pyWS+ks7Ik/LrR0ecgPbx8r80h+n4I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791026532; c=relaxed/simple;
	bh=nLR+5Ei3zCh0Lgnvgnm9t7J7dXQUlg5gASQQdO95zBY=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=NTEZeCT2jM2q11VFVmbjFj/LAzecHG/7vByRFhqIxCrF8aHBHOc2YpAeSOsdP2xZ03ArsrKnMLr3AlbbTuA14rWwTXCXHhUkpyj7SdFIAaBZkDTZQKiXVcrpPixDUF1idSC1ZyI5N+5hfXQlFYSMCgtdDGdQfxFj1r8XTBXvtjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeTmYG/q; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeTmYG/q"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4b37a36887bso187864b6e.2
        for <git@vger.kernel.org>; Sat, 03 Oct 2026 04:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791026530; x=1791631330; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pHOrv2EeUqa+MRoFMJhmvlCFYrWSxxoZpgvqcfEf0K0=;
        b=jeTmYG/qtBbiRzHqZP9oQ6BXraNL3NXmt1YBYvtv66fl3VzsV7VO5n07OcT7hilO5w
         X8351kCjCkZZkHPDqYU/1OQY9Jhy3wM9P/eNU9O+Fcxm/kNbPSjVFpclQ18PJJShSSeS
         JV0qC67UNG7xF+WUHg/VUa3hRoH7RE+SMWRQl6voX704sFpRy2Tqia/l9USc+0g07N+H
         5jGHH9b7qqz+GiX+mmdJIkhMixkLufJoo67CD+AkSdoIcTxIiuS+H2/uOC/efIYfH/4H
         q6TyxCiUq4NVy0/2t8jYm8GUkoM6e+8yJ77pHWCnitN9Mbkajm1B77+hTwexo0VaQ8eB
         kDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791026530; x=1791631330;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pHOrv2EeUqa+MRoFMJhmvlCFYrWSxxoZpgvqcfEf0K0=;
        b=xLNLkFH+Yox9UXrsnUuS1gmrrR1CqSfSXecsKslakFIz+ixn14yIRbO4HpV4AM8vyA
         vxZlvrVjOWz6D9oGVgsGYV7BR1ezoBlZxVgOU3Dy+M8YPLI9ssB8x+GjSwsBAsdwZLEc
         9vQmlrjeb8Yl2oNawAoc+vEJC8dQDaZnG3qs/Xr0beKSGGKxW5Coli4m6+SjzdtQHn7f
         amM8tJeSqQRjrUcc5WbUtUNCA3oHMWAhCt7cw5xM+uQD4ufx7KGYQyP8ewjAWdwAQHV1
         Q+ee2+OJd0NSlQVIhdoGZtFR0R5zv1W5AIytXXP4EVSi97JXLY8zpOz2MwnhygT1cG2k
         /oRQ==
X-Gm-Message-State: AFuF++mCwAj6nH7IZaDcIUr0MH1A3Ki5RiHYgzCruYrhMJL5yYIh0gq1
	b/u8BwZfzyInkhZAz18jICLjnWy5iuQp8FH9DEnM1Rq2knznFebDPgrg+04MacGj
X-Gm-Gg: AYBFou2jpZCLGuiIQt+187LpAhXSJf4rXhHrtYZYKVf2fDaVrz9ST9nBRVQgIsn3l4R
	0mHkt3B6KMEj4/++MO/Bzob+xgnQMu7QRYY3bXcmufNGq6JHKi8Jb64S7K32WtEblCTdrXLR2tq
	Klw2hOFr5P+9/wTs16igOzS6hAH8l1xVL4pLo42qKd/GUjPStPMFn8NhW4FJMUazHFpcVo2zU3j
	HKhEWEZf7VaETCkrt10BhEboYdWiO6vcOjO5tKzZCpidothCtY+ztiW+XupwIrTa5MqgsvUwcWr
	8iyBOGqzD8cDZLohdwn3CG/+xkqcVUsxCFLl48gTb4mhgOmCXV/4ut1cWyNg3S5Wi3onkeyTh37
	LVYwC5Te6zmLirJKksbhqqMZ+HYkXsGeNQtvrI81hiSzhY+JbfPrBHqwxACZwO/gErUSWPgUpTj
	ZDFv2CZyBVy94HuBOXC+IWhQFbj9ZQnQesLwATFzSbrdMXMWO4KjuTfpTzIQfJHCTBj4DV+l/gj
	K11ECBfDXcqMw==
X-Received: by 2002:a05:6808:c210:b0:4b9:a8ac:488 with SMTP id 5614622812f47-4f52aa7cf2amr5635910b6e.38.1791026529811;
        Sat, 03 Oct 2026 04:22:09 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.192.145])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4f5245d16c9sm5927904b6e.10.2026.10.03.04.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 04:22:08 -0700 (PDT)
Message-Id: <pull.2216.git.git.1791026527023.gitgitgadget@gmail.com>
From: "Fionn via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 03 Oct 2026 11:22:06 +0000
Subject: [PATCH] completion: exclude previous file arguments in Zsh
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
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
    Fionn <git@fionn.email>,
    Fionn Fitzmaurice <git@fionn.email>

From: Fionn Fitzmaurice <git@fionn.email>

When using the _git completion function bundled with Zsh
(https://sf.net/p/zsh/code/ci/master/tree/Completion/Unix/Command/_git),
duplicate files in an argument list will not be offered as completion
candidates.

For example, suppose we have untracked files aa and ab (only). Then with
the Zsh completion,

    git add aa a<tab>

would not offer both aa and ab as completion candidates, rather it would
complete ab only.

This behaviour is not present in git-completion.zsh shipped with Git,
which does not deduplicate arguments.

We can get this with minor changes, however. Here we introduce an array
__git_file_exclude which we populate with existing arguments and then
tell compadd to exclude them, which closely matches the Zsh _git
completion behaviour (as well as common programs such as rm).

Signed-off-by: Fionn Fitzmaurice <git@fionn.email>
---
    completion: exclude previous file arguments in Zsh

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2216%2Ffionn%2Fzsh-completion-exclude-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2216/fionn/zsh-completion-exclude-v1
Pull-Request: https://github.com/git/git/pull/2216

 contrib/completion/git-completion.zsh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index d5c526665b..26444923c1 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -117,7 +117,7 @@ __gitcomp_file ()
 	emulate -L zsh
 
 	compset -P '*[=:]'
-	compadd -f -p "${2-}" -- ${(f)1} && _ret=0
+	compadd -f -p "${2-}" -F __git_file_exclude -- ${(f)1} && _ret=0
 }
 
 __gitcomp_direct_append ()
@@ -284,6 +284,8 @@ __git_zsh_main ()
 
 		(( $+opt_args[--help] )) && command='help'
 
+		__git_file_exclude=(${words[2,-1]:#${words[CURRENT]}})
+
 		words=( ${orig_words[@]} )
 
 		__git_zsh_bash_func $command
@@ -296,6 +298,7 @@ _git ()
 	local _ret=1
 	local cur cword prev
 	local __git_repo_path
+	local -a __git_file_exclude
 
 	cur=${words[CURRENT]}
 	prev=${words[CURRENT-1]}

base-commit: c46c1e37724f0478939de636ab8ea5a89086d532
-- 
gitgitgadget
