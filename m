Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUt8AshL"
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B9C110
	for <git@vger.kernel.org>; Sat, 25 Nov 2023 23:51:33 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3316d3d11e1so1773037f8f.0
        for <git@vger.kernel.org>; Sat, 25 Nov 2023 23:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700985091; x=1701589891; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKiDs4wzEqpOjm8KyGGlsKLM9q8ZY3CW5U8mhRr+mGU=;
        b=lUt8AshLn5rbNNCvNGmk5+LVQlN5sX2xrT1yJXcYMqaD4RIhhM6rCk9W1G9nEL9vK+
         ivwdqv72svznpmy/Foeuof0E9wMb+k44WWrzA1KI1wl5YuhmN7sGfelsseHBXak2QnCe
         bb9kczWyIeiN7QtT9e4M6sOzpWxE7H6ke+cSxO/s4b0vmJ73KlXOtOshhZ1Hfh8Af4Z3
         jzj3s7eEAy/TdX2rSfwrBQGHWAeZicwqs9jeuKD0vpOnZZkWcJcQ1gpG3dtYlUYlsbww
         atr6qrXMBGboENvVyaHxcwdtNXrszS1crGDrBkAFRrH7386tFjwWBx6Vh6f2oUMbHEeH
         UxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700985091; x=1701589891;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKiDs4wzEqpOjm8KyGGlsKLM9q8ZY3CW5U8mhRr+mGU=;
        b=npRi0XNlyr+fUIzWAcDKuZLbl8eXDF7018zqv9tnftYUOZa55mhmEi0wE/f8pmYdyG
         DUU/vKfL6ENICBrG0JTEq/4N7UstB1parKNXSSLO6JyPjcwrKbwqAsMenJkinj2d3fCm
         vRnvmf1Wku2FMFh4cdkPCirTL6hdVV5D+HQ0AngWRDB+8vDWDbxT8+edtuXGzVv9ighP
         0LE7ZTetzgnkslUjSXrnF3uaaoi3xAjksYDbPZXz/H4/JSj8RkMLA1wnbIoREV8FPZHW
         YhP6d2uNkMjtu7jffFV888zBhA2TWa/OgCs81fRmkSy1XkXkgPpOHVxOwFRxeOY6egWL
         V4rQ==
X-Gm-Message-State: AOJu0YzY0cMHFtT8Qj0evT/R9fodzJK7707xhYbdR6SUMDDVwH81ws4d
	TyjtgVhZW1QE90A5Xh9S/YUri4osvfc=
X-Google-Smtp-Source: AGHT+IErJ9zyxCqbdUsOfm4RYuUdvBjhT0oJNV5mQAdjBJ9EEpPrw1XsfsweLGA4Vq8S7V2BwVOwYg==
X-Received: by 2002:a05:6000:120c:b0:332:e64a:5b7c with SMTP id e12-20020a056000120c00b00332e64a5b7cmr8143881wrx.26.1700985091484;
        Sat, 25 Nov 2023 23:51:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f9-20020a0560001b0900b003143867d2ebsm8583144wrz.63.2023.11.25.23.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 23:51:30 -0800 (PST)
Message-ID: <604f21dc827ab8f3378ff84e7ce7939ef82d78cd.1700985086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1349.v2.git.1700985086.gitgitgadget@gmail.com>
References: <pull.1349.git.1700761448.gitgitgadget@gmail.com>
	<pull.1349.v2.git.1700985086.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 26 Nov 2023 07:51:26 +0000
Subject: [PATCH v2 4/4] completion: avoid user confusion in non-cone mode
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
Cc: Elijah Newren <newren@gmail.com>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

It is tempting to think of "files and directories" of the current
directory as valid inputs to the add and set subcommands of git
sparse-checkout.  However, in non-cone mode, they often aren't and using
them as potential completions leads to *many* forms of confusion:

Issue #1. It provides the *wrong* files and directories.

For
    git sparse-checkout add
we always want to add files and directories not currently in our sparse
checkout, which means we want file and directories not currently present
in the current working tree.  Providing the files and directories
currently present is thus always wrong.

For
    git sparse-checkout set
we have a similar problem except in the subset of cases where we are
trying to narrow our checkout to a strict subset of what we already
have.  That is not a very common scenario, especially since it often
does not even happen to be true for the first use of the command; for
years we required users to create a sparse-checkout via
    git sparse-checkout init
    git sparse-checkout set <args...>
(or use a clone option that did the init step for you at clone time).
The init command creates a minimal sparse-checkout with just the
top-level directory present, meaning the set command has to be used to
expand the checkout.  Thus, only in a special and perhaps unusual cases
would any of the suggestions from normal file and directory completion
be appropriate.

Issue #2: Suggesting patterns that lead to warnings is unfriendly.

If the user specifies any regular file and omits the leading '/', then
the sparse-checkout command will warn the user that their command is
problematic and suggest they use a leading slash instead.

Issue #3: Completion gets confused by leading '/', and provides wrong paths.

Users often want to anchor their patterns to the toplevel of the
repository, especially when listing individual files.  There are a
number of reasons for this, but notably even sparse-checkout encourages
them to do so (as noted above).  However, if users do so (via adding a
leading '/' to their pattern), then bash completion will interpret the
leading slash not as a request for a path at the toplevel of the
repository, but as a request for a path at the root of the filesytem.
That means at best that completion cannot help with such paths, and if
it does find any completions, they are almost guaranteed to be wrong.

Issue #4: Suggesting invalid patterns from subdirectories is unfriendly.

There is no per-directory equivalent to .gitignore with
sparse-checkouts.  There is only a single worktree-global
$GIT_DIR/info/sparse-checkout file.  As such, paths to files must be
specified relative to the toplevel of a repository.  Providing
suggestions of paths that are relative to the current working directory,
as bash completion defaults to, is wrong when the current working
directory is not the worktree toplevel directory.

Issue #5: Paths with special characters will be interpreted incorrectly

The entries in the sparse-checkout file are patterns, not paths.  While
most paths also qualify as patterns (though even in such cases it would
be better for users to not use them directly but prefix them with a
leading '/'), there are a variety of special characters that would need
special escaping beyond the normal shell escaping: '*', '?', '\', '[',
']', and any leading '#' or '!'.  If completion suggests any such paths,
users will likely expect them to be treated as an exact path rather than
as a pattern that might match some number of files other than 1.

Because of the combination of the above issues, turn completion off for
the `set` and `add` subcommands of `sparse-checkout` when in non-cone
mode, but leave a NEEDSWORK comment specifying what could theoretically
be done if someone wanted to provide completion rules that were more
helpful than harmful.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 contrib/completion/git-completion.bash | 62 ++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c614e5d4f07..1e07dc8b73e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3138,6 +3138,68 @@ _git_sparse_checkout ()
 		fi
 		if [[ "$using_cone" == "true" ]]; then
 			__gitcomp_directories
+		else
+			# NEEDSWORK: It might be useful to provide a
+			# completion function which:
+			#
+			#     1. Provides completions based on
+			#        files/directories that exist in HEAD (or in
+			#        the index since sparse-index isn't possible
+			#        in non-cone mode), not just those currently
+			#        present in the working tree.  Bash's
+			#        default file and directory completion is
+			#        totally useless for "git sparse-checkout
+			#        add" because of this.  It is likewise
+			#        problematic for "git sparse-checkout set"
+			#        except in those subset of cases when trying
+			#        to narrow scope to a strict subset of what
+			#        you already have checked out.
+			#
+			#     2. Always provides file/directory completions
+			#        with a prepended leading '/', so that
+			#        files/directories are only searched at the
+			#        relevant level rather than throughout all
+			#        trees in the hierarchy.  Doing this also
+			#        avoids suggesting the user run a
+			#        sparse-checkout command that will result in
+			#        a warning be thrown at the user.
+			#
+			#     3. Does not accidentally search the root of
+			#        the filesystem when a path with a leading
+			#        slash is specified.  ("git sparse-checkout
+			#        add /ho<TAB>" should not complete to
+			#        "/home" but to e.g. "/hooks" if there is a
+			#        "hooks" in the top of the repository.)
+			#
+			#     4. Provides no completions when run from a
+			#        subdirectory of the repository root.  (If we
+			#        did provide file/directory completions, the
+			#        user would just get a "please run from the
+			#        toplevel directory" error message when they
+			#        ran it.  *Further*, if the user did rerun
+			#        the command from the toplevel, the
+			#        completions we previously provided would
+			#        likely be wrong as they'd be relative to the
+			#        subdirectory rather than the repository
+			#        root.  That could lead to users getting a
+			#        nasty surprise based on trying to use a
+			#        command we helped them create.)
+			#
+			#     5. Provides escaped completions for any paths
+			#        containing a '*', '?', '\', '[', ']', or
+			#        leading '#' or '!'.  (These characters might
+			#        already be escaped to protect from the
+			#        shell, but they need an *extra* layer of
+			#        escaping to prevent the pattern parsing in
+			#        Git from seeing them as special characters.)
+			#
+			# Of course, this would be a lot of work, so for now,
+			# just avoid the many forms of user confusion that
+			# could be caused by providing bad completions by
+			# providing a fake completion to avoid falling back to
+			# bash's normal file and directory completion.
+
+			COMPREPLY=( "" )
 		fi
 	esac
 }
-- 
gitgitgadget
