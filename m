Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B171D89E4
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 20:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736972634; cv=none; b=cwgQq5r//M0ae3V5XSMO+xRQMd0jLaIonrXAE7fQ834fka2Omn30su3GzP9rSm9OuslHceMXQ3t8Bl7TBUesyAeZub0YcA+/kbLScz3l6+OxSimE5k3hn5nGvzGTwfUuT/EbdHsKPkYquC5DNLqp//SQ6z9q3CT917482fXI7N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736972634; c=relaxed/simple;
	bh=RwjxsO0SwqHhKVk8W5MPbd8KtABdKeyhh6w57dIYgEA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=ZtVCDuToSB0osETRyhzSAHa9qzyI3P2ip6a3Iy6d6jpwLqzbx3EpB/ms0pEp6Qwgur2hlIruKa+QWZ2RYf3E3MQqZ8YwLIm3WyOZpaHO/1qNJxfJHQgRFFMHBIFCAJh3BpvBayIoVS4dp8BgXRgr0kwXABj7vnB7CnfyF8qvTq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gm4kd2uM; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gm4kd2uM"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4362bae4d7dso724565e9.1
        for <git@vger.kernel.org>; Wed, 15 Jan 2025 12:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736972631; x=1737577431; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jpfGjaqS476uB/pP683nmwDCGVDOTfULqVN0aIxUFw=;
        b=gm4kd2uMQBc0o8zAKRhpvttw/cF+pTJ/N9lBeGgMN4cyWJ7t5yKMTKWgY0cKaZcZk8
         PEyL9tT/5BNt3NpLjy2xkR5i18PIfzHIL/UOedu3S00ZAHrDPhAWdJtbI3JrxZeA9Ew8
         ZAjg0I35qQyV2iGqAZkK3UJ/pd1lNWCVibKe5zKNLU+Zn2fKfly7T6DNjO4JzSsCQ3Dg
         6xz9mLGvnzfAqYotuXHd2oOixGMFkvJ0musuXEHTCsxIOD4jQZlEZm6v/UOtTz9uQjoA
         v8bc/U+nMOGWp7Y7phOkd5VtgX+quIIUW6lHHtnhfggsPAKPy0X3jGPLuzTUaS/2XNQE
         g0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736972631; x=1737577431;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jpfGjaqS476uB/pP683nmwDCGVDOTfULqVN0aIxUFw=;
        b=U9zmh0gHEDuHY0kLRDqqp6C7N+NrLfW0raA9jA1xikO1YjzOAvwG8kW05dbvI1g+/3
         pTen5B4EwBm32oZUl0K1RG4IrEJ0m4mHwD3YfES8ZP8WkOCJU+gG47KyudrBwXy4stjs
         90AXlo6E3uIfd+jwdHQzlw5fPZJjC6E0ObySsaQjTiHcz5CVWlQJZqyLzcReV/NA5sr1
         JYz+AhBE5GVop9BsFUSwtSrmvRZbwy1mVYV2sEeYzBapfazEXeDborAvgDuXlCcQkGGT
         6UniHSzC7NfDXpTvT5LaJv1ub5DxRzCD9kMVkSi3y0XpicNihel75OoGKYMreIwg9pN2
         NGYQ==
X-Gm-Message-State: AOJu0YzKyBjf68Jkso0LYAzH1Yt7hYzDvG9H0oPbtAuy8+EDCst+wYhu
	fgBmNvOrm7ZL7ytDUhVPxyRQtL0Y50girsH06QaBhIMGhuKkwPCnv2+TwQ==
X-Gm-Gg: ASbGncvJ1ijbNsQDzNVz6C1JoN/o4n1xIbmtcza2vVgSxCZAfj504/aTWzhwxjK67Yi
	rpqnUWZx5l4VK9eDVnyrOn9eVwLWeeDqYKBzRLwvTscP5JDqMa83h75QvLUNkFjqXjjyZ0I/e6c
	DRK6RMldyiZG9xhC3cefRmFHWLpkI6hIv3yc4bOEuKzpOEu2mE4NO4zItauxOhecqFOJkvbFqe3
	KUnhp8syurz/CLzfNw4XdjfzzsGYrZgUZHSfzLz4qKWwwPYV9QiazPqCA==
X-Google-Smtp-Source: AGHT+IFR600/B0nhXZ4xsg05hoLtK/IqyOV0T8AwdVesOZ/8serzPeAVJLCwrNQLIHldixYxYCcqzA==
X-Received: by 2002:a05:600c:4f0d:b0:434:ffe3:bc7d with SMTP id 5b1f17b1804b1-436e26ba521mr333685105e9.16.1736972630390;
        Wed, 15 Jan 2025 12:23:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c7525ee9sm34144335e9.32.2025.01.15.12.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 12:23:49 -0800 (PST)
Message-Id: <pull.1845.v2.git.1736972628.gitgitgadget@gmail.com>
In-Reply-To: <pull.1845.git.1735912046.gitgitgadget@gmail.com>
References: <pull.1845.git.1735912046.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Jan 2025 20:23:43 +0000
Subject: [PATCH v2 0/5] Doc git commit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>

This series continues the effort of rewriting the documentation with
uniformization and better formatting of the man pages. This time, git-commit
is processed, taking advantage of previous experiences.

Jean-Noël Avila (5):
  doc: apply new documentation guidelines to git commit
  doc: the mode param of -u of git commit is optional
  doc: make more direct explanations in git commit options
  doc: convert git commit config to new format
  doc: migrate git-commit manpage secondary files to new format

 Documentation/config/commit.txt  |  25 +--
 Documentation/git-commit.txt     | 281 +++++++++++++++----------------
 Documentation/i18n.txt           |   4 +-
 Documentation/signoff-option.txt |   8 +-
 builtin/commit.c                 |   2 +-
 5 files changed, 161 insertions(+), 159 deletions(-)


base-commit: 1b4e9a5f8b5f048972c21fe8acafe0404096f694
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1845%2Fjnavila%2Fdoc_git-commit-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1845/jnavila/doc_git-commit-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1845

Range-diff vs v1:

 1:  dfd907fc314 ! 1:  91cff84b5f8 doc: git-commit: apply new documentation guidelines
     @@ Metadata
      Author: Jean-Noël Avila <jn.avila@free.fr>
      
       ## Commit message ##
     -    doc: git-commit: apply new documentation guidelines
     +    doc: apply new documentation guidelines to git commit
      
     -    The documentation for git-commit has been updated to follow the new
     -    documentation guidelines. The following changes have been applied to
     -    the series of patches:
     -
     -    - switching the synopsis to a synopsis block which will automatically
     +    - switch the synopsis to a synopsis block which will automatically
            format placeholders in italics and keywords in monospace
          - use _<placeholder>_ instead of <placeholder> in the description
          - use `backticks for keywords and more complex option
          descriptions`. The new rendering engine will apply synopsis rules to
          these spans.
      
     -    Additionally, some option descriptions have been turned into
     -    imperative mood to make them more consistent with the rest of the
     -    documentation.
     -
          Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
      
       ## Documentation/git-commit.txt ##
     @@ Documentation/git-commit.txt: git-commit - Record changes to the repository
      -[verse]
      -'git commit' [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]
      +[synopsis]
     -+git commit [-a | --interactive | --patch] [-s] [-v] [-u[<mode>]] [--amend]
     ++git commit [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]
       	   [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>]
       	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
       	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
     @@ Documentation/git-commit.txt: summary of what is included by any of the above fo
       -------
      --a::
      ---all::
     --	Tell the command to automatically stage files that have
      +`-a`::
      +`--all`::
     -+	Automatically stage files that have
     + 	Tell the command to automatically stage files that have
       	been modified and deleted, but new files you have not
       	told Git about are not affected.
       
     @@ Documentation/git-commit.txt: summary of what is included by any of the above fo
       
      --F <file>::
      ---file=<file>::
     --	Take the commit message from the given file.  Use '-' to
      +`-F <file>`::
      +`--file=<file>`::
     -+	Take the commit message from _<file>_.  Use `-` to
     + 	Take the commit message from the given file.  Use '-' to
       	read the message from the standard input.
       
      ---author=<author>::
     @@ Documentation/git-commit.txt: summary of what is included by any of the above fo
       
      --m <msg>::
      ---message=<msg>::
     --	Use the given <msg> as the commit message.
      +`-m <msg>`::
      +`--message=<msg>`::
     -+	Use _<msg>_ as the commit message.
     + 	Use the given <msg> as the commit message.
       	If multiple `-m` options are given, their values are
       	concatenated as separate paragraphs.
       +
     @@ Documentation/git-commit.txt: summary of what is included by any of the above fo
      +`-t <file>`::
      +`--template=<file>`::
       	When editing the commit message, start the editor with the
     --	contents in the given file.  The `commit.template` configuration
     -+	contents in _<file>_.  The `commit.template` configuration
     + 	contents in the given file.  The `commit.template` configuration
       	variable is often used to give this option implicitly to the
     - 	command.  This mechanism can be used by projects that want to
     - 	guide participants with some hints on what to write in the message
      @@ Documentation/git-commit.txt: The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
       
       include::signoff-option.txt[]
     @@ Documentation/git-commit.txt: The `-m` option is mutually exclusive with `-c`, `
       
      --n::
      ---[no-]verify::
     --	By default, the pre-commit and commit-msg hooks are run.
     --	When any of `--no-verify` or `-n` is given, these are bypassed.
      +`-n`::
      +`--[no-]verify`::
     -+	Bypass the `pre-commit` and `commit-msg` hooks.
     + 	By default, the pre-commit and commit-msg hooks are run.
     + 	When any of `--no-verify` or `-n` is given, these are bypassed.
       	See also linkgit:githooks[5].
       
      ---allow-empty::
     @@ Documentation/git-commit.txt: The `-m` option is mutually exclusive with `-c`, `
              linkgit:git-commit-tree[1].
       
      ---cleanup=<mode>::
     --	This option determines how the supplied commit message should be
      +`--cleanup=<mode>`::
     -+	Determine how the supplied commit message should be
     + 	This option determines how the supplied commit message should be
       	cleaned up before committing.  The '<mode>' can be `strip`,
       	`whitespace`, `verbatim`, `scissors` or `default`.
       +
     @@ Documentation/git-commit.txt: default::
       
      --e::
      ---edit::
     --	The message taken from file with `-F`, command line with
     --	`-m`, and from commit object with `-C` are usually used as
     --	the commit log message unmodified. This option lets you
     --	further edit the message taken from these sources.
      +`-e`::
      +`--edit`::
     -+	Let the user further edit the message taken from  file
     -+	with `-F`, command line with `-m`, and from commit object
     -+	with `-C` are usually used as the commit log message unmodified.
     + 	The message taken from file with `-F`, command line with
     + 	`-m`, and from commit object with `-C` are usually used as
     + 	the commit log message unmodified. This option lets you
     + 	further edit the message taken from these sources.
       
      ---no-edit::
      +`--no-edit`::
     @@ Documentation/git-commit.txt: include::i18n.txt[]
       `VISUAL` environment variable, or the `EDITOR` environment variable (in that
       order).  See linkgit:git-var[1] for details.
       
     -
     - ## builtin/commit.c ##
     -@@
     - #include "trailer.h"
     - 
     - static const char * const builtin_commit_usage[] = {
     --	N_("git commit [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]\n"
     -+	N_("git commit [-a | --interactive | --patch] [-s] [-v] [-u[<mode>]] [--amend]\n"
     - 	   "           [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>]\n"
     - 	   "           [-F <file> | -m <msg>] [--reset-author] [--allow-empty]\n"
     - 	   "           [--allow-empty-message] [--no-verify] [-e] [--author=<author>]\n"
 -:  ----------- > 2:  d58526a9b39 doc: the mode param of -u of git commit is optional
 -:  ----------- > 3:  39db87ff906 doc: make more direct explanations in git commit options
 2:  9f518ec8f9d ! 4:  9216554bd70 doc: git-commit.txt: convert git commit config to new format
     @@ Metadata
      Author: Jean-Noël Avila <jn.avila@free.fr>
      
       ## Commit message ##
     -    doc: git-commit.txt: convert git commit config to new format
     +    doc: convert git commit config to new format
      
          Also prevent git-commit manpage to refer to itself in the config
          description by using a variable.
 3:  9f8d4e74b7b ! 5:  28316a709da doc: git-commit: migrate secondary files to new format
     @@ Metadata
      Author: Jean-Noël Avila <jn.avila@free.fr>
      
       ## Commit message ##
     -    doc: git-commit: migrate secondary files to new format
     +    doc: migrate git-commit manpage secondary files to new format
      
          Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
      

-- 
gitgitgadget
