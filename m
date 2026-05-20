Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17070371071
	for <git@vger.kernel.org>; Wed, 20 May 2026 20:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779308683; cv=none; b=nzCAb5tRROthe28aEG0pDBdbehBvk5li+lL3j+oRGi3uRKVJzfPbe6z4nZZbgTvchFd+uvmOqRY5UDw1fNfqWL8FcC6WkpOwkoRPwqqHj0+j7KsKht0k3PHWCpG+q/J5GrFkrz2m3fGA07sbIqHMjkHetEVe1/rqdw733OElIxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779308683; c=relaxed/simple;
	bh=f99AD7TawmqV5UJXo875e5oQ6rzW+LIq9V7HwYrcIEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bwFqwe+y86/n10c91vEXR6ZOCmksbprtI2XlzlVjJcfQ0oiOL+oaagrYeJway6NlzleEDA187GVA6saKHjp/FwpjXX8VAqECwqJskydIdaQPzSqJY9XYtHTazlAhf6i/Wo4WGFrski3memXoa9MBQ5OL3pT2cr/kS73Xj6CMZig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNZ+NoKo; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNZ+NoKo"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8cc0ef7c306so11250586d6.3
        for <git@vger.kernel.org>; Wed, 20 May 2026 13:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779308681; x=1779913481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OJA2NwvPCZMx+SiP6PLh8WE82pAtJZBXDxoYKJJXtY=;
        b=RNZ+NoKo4vMexEVMtx6ZaYFE8hwciCpjzX5t2Us3MgyMRD8fCUVWfNq6qZIa4+tGry
         CmrAhYgx4fsy+zeDmg5iW69g9LtqQQYbBQVftttLg+FAQNyW5EjHLNeUYX3L9niHt7r4
         Bw5j/Rne96dcXEEHpeDu6FqLKb3mheXQvjiKMd4U29julA+z1AXP2mI50didZUihde7k
         Jih0vYklKzcELQFbD6782RX+Z3Oug8b5rd/nya2PUOth4AobwvfxDMdRYDIHyra3i3ME
         zFI4oVzJyQPcW5g8x3AJnkPtTq6BgMx29lGrHeNu+io5iYV9Q5UAKt+AIjCytM/4Hc5H
         TKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779308681; x=1779913481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2OJA2NwvPCZMx+SiP6PLh8WE82pAtJZBXDxoYKJJXtY=;
        b=oViGOpfoUzzBD5WL5Vij5Sxm5LyZiMDw8OSOqMg2s+dQk6JEmOR3Ds/clFUlbmxwUq
         zwZRufxzd53FLtGebBaQaqToYEFIGMclJsP0DKFoO6IokQkj7q+GvSnotMdtT+MQxKLt
         0EIxtk8ovyBwAiaQIc2Xz6h5aS/q/UDDp1dN/55PHIT1NV0JRY7i39K4NLiFYGM8Hem5
         lXNXVagLKRP0lX1hF48/BjBqWuIGDMhx2HFf27Y0fLkLgb/wtY1vBwAB84N61WGR6uLS
         nS277Uhg34HzBZQZbyfDki1mxU1hUduET+vor+q1dzU+ac2iD6AppFmFl6Y9KehYPElt
         h7uA==
X-Gm-Message-State: AOJu0YxiGBzuuWhLg+XJwlpnGLrhRCaFCGJ8tApbOq9qHyV0G2acHaXw
	08j+Rg+v4yG6Rm5qD4hLUf0Wbom/bk1UvfyC3nqGTt9MtDvEPJeNeiwl6+Dobkvd
X-Gm-Gg: Acq92OE+gm55VGwTlV10lhy/mNA/iibTQTI70//UCvzlod20lhbMRr5prn79WCiLMBB
	CHodUUjRDJhNiktaSZ2HzPC+1dBDlT9fcT2Lce+6Xv5ULyZJWpNMkkYvsrNPkFlt/QpxLEBKkd/
	XkzNhk19BK+2zIDwQkhCRor4H4E/8EIZaVln2wnh7Lj4bG22BTPsFwZuZ8SeC+8z3jrpxqtqBeB
	l4l/56GNs5X4I89asQQb4mwsMILrP64N2aL+FGNKg/4X9wfxbZkpIZpWV1ssWyeEJvBEhHky0qk
	u9wdICfnp3xjTUtUN1/O368qymaEvxvkgpd9HnEvk3dBMsiCKwpYIiGEqxaVo/sebgTwG8N07dy
	HqfRuP6Wmudu5SReGAsjkEldL9TTYTfdrfsk+VrfBS06guUc1hq2DNH/f/LNhlJxQKeaodYv9sO
	KEvRYTRU9XZH055T5qfuEJj36sTw==
X-Received: by 2002:ad4:5ae7:0:b0:8cb:e78f:21ab with SMTP id 6a1803df08f44-8cc6e32f044mr422086d6.15.1779308681011;
        Wed, 20 May 2026 13:24:41 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca361905d4sm129891136d6.32.2026.05.20.13.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 13:24:40 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	egg_mushroomcow@foxmail.com,
	bootaina702@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v2 10/11] git-gui: adapt blame/browser parsing for bare operation
Date: Wed, 20 May 2026 16:24:09 -0400
Message-ID: <20260520202411.108764-11-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.54.0.99.14
In-Reply-To: <20260520202411.108764-1-mlevedahl@gmail.com>
References: <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260520202411.108764-1-mlevedahl@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git-gui's blame and browser subcommands do not work with bare
repositories, but they should per commit c52c94524b ("git-gui: Allow
blame/browser subcommands on bare repositories", 2007-07-17). Assuming
that commit worked, something changed since reintroducing a hard-coded
dependency upon a worktree.

The basic issue goes back to 3e45ee1ef2 ("git-gui: Smarter command line
parsing for browser, blame", 2007-05-08), which seeks to implement
command line parsing similar to git blame. That commit introduces
depencies upon the worktree to decide which argument is rev or path.

Looking at builtin/blame.c in git around line 1120:

	 * (1) if dashdash_pos != 0, it is either
	 *     "blame [revisions] -- <path>" or
	 *     "blame -- <path> <rev>"
	 *
	 * (2) otherwise, it is one of the two:
	 *     "blame [revisions] <path>"
	 *     "blame <path> <rev>"

shows the clear intent: rev and path may be swapped in input so both
meanings must be tried, but -- may be used to designate which is the
path forcing or precluding trying the swapped arguments.

With a worktree, git gui correctly swaps the arguments if the given path
exists in the worktree. git blame does this using the git repository.
But, git-gui sometimes interprets the -- to have an exactly opposite
meaning:

    git blame       Makefile gitgui-0.19.0       works
    git gui blame   Makefile gitgui-0.19.0       works

    git blame       -- Makefile gitgui-0.19.0    works
    git gui blame   -- Makefile gitgui-0.19.0    works

    git blame       Makefile -- gitgui-0.19.0    fails (correctly)
    git gui blame   Makefile -- gitgui-0.19.0    works (should fail)

    git blame       gitgui-0.19.0 -- Makefile    works (correctly)
    git gui blame   gitgui-0.19.0 -- Makefile    fails (should work)

It is possible to patch the code to operate without a worktree, but this
will make the commands operate differently with and without a worktree,
won't fix the parsing issues above, and won't address the issues that
can arise when using a worktree to help decisions on a different rev
with file/directory conflicts, etc.

So, let's rework the parser so that it uses -- as does git blame, and
uses git ls-tree to query the given revision for existence and type of
path rather than basing this upon a possibly unrelated worktree. Also,
abort early when the given path is not found, or does not match the need
(file or directory). This fixes some current cases where git-gui will
open a window with no content, possibly also with an error message.

This does not change whether or how git-gui uses staged and unstaged
content in the current worktree for blame display.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui.sh | 151 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 87 insertions(+), 64 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index d373457901..ae609f86f1 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -3014,100 +3014,123 @@ proc normalize_relpath {path} {
 	}
 }
 
+proc find_path_type {head path} {
+	if {$path eq {./}} {
+		# the root-tree exists in every rev, ls-tree gives data on the contents,
+		# not the type of tree itself. So, if the rev exists, return {tree}
+		if {[catch {set objtype [git ls-tree $head]}]} {
+			set objtype {}
+		} else {
+			set objtype {tree}
+		}
+	} else {
+		# test that the path exists in head, ls-tree gives info on the path only
+		if {[catch {set objtype [git ls-tree {--format=%(objecttype)} $head $path]}]} {
+			set objtype {}
+		}
+	}
+	return $objtype
+}
+
 # -- Not a normal commit type invocation?  Do that instead!
 #
 switch -- $subcommand {
 browser -
 blame {
 	if {$subcommand eq "blame"} {
-		set subcommand_args {[--line=<num>] rev? path}
+		set subcommand_args {[--line=<num>] <[rev] [--] filename | [--] filename rev>}
+		set required_objtype blob
 	} else {
-		set subcommand_args {rev? path}
+		set subcommand_args {<[rev] [--] directory | [--] directory rev>}
+		set required_objtype tree
 	}
-	if {$argv eq {}} usage
+	set maxargs [llength $subcommand_args]
+	set nargs [llength $argv]
+	if {$nargs < 1 || $nargs > $maxargs} usage
 	set head {}
+	set althead {}
 	set path {}
+	set altpath {}
+	set canswap 1
 	set jump_spec {}
-	set is_path 0
-	foreach a $argv {
-		set p [file join $_prefix $a]
 
-		if {$is_path || [file exists $p]} {
-			if {$path ne {}} usage
-			set path [normalize_relpath $p]
-			break
-		} elseif {$a eq {--}} {
-			if {$path ne {}} {
-				if {$head ne {}} usage
-				set head $path
-				set path {}
+	# assume: [--line=num] [head] [--] path as the possible arguments, in order.
+	# head and path may need a swap later.
+	for {set iarg 0} {$iarg < $nargs} {incr iarg} {
+		set arg [lindex $argv $iarg]
+		if {$arg eq {--}} {
+			# next arg is the path, prevent or FORCE swap?
+			if {$iarg == $nargs - 2} {
+				set canswap 0
+			} elseif {$iarg == $nargs - 3} {
+				set canswap 2
+			} else {
+				usage
 			}
-			set is_path 1
-		} elseif {[regexp {^--line=(\d+)$} $a a lnum]} {
-			if {$jump_spec ne {} || $head ne {}} usage
+		} elseif {[regexp {^--line=(\d+)$} $arg arg lnum]} {
+			# --line can only be the first arg
+			if {$iarg != 0 || $maxargs < 4} usage
 			set jump_spec [list $lnum]
+		} elseif {$iarg == $nargs - 1} {
+			# assume final argument is path
+			set path [normalize_relpath [file join $_prefix $arg]]
+			set althead $arg
 		} elseif {$head eq {}} {
-			if {$head ne {}} usage
-			set head $a
-			set is_path 1
+			# assume the other argument is head
+			set head $arg
+			set altpath [normalize_relpath [file join $_prefix $arg]]
 		} else {
 			usage
 		}
 	}
-	unset is_path
-
-	if {$head ne {} && $path eq {}} {
-		if {[string index $head 0] eq {/}} {
-			set path [normalize_relpath $head]
-			set head {}
-		} else {
-			set path [normalize_relpath $_prefix$head]
-			set head {}
-		}
-	}
 
+	# no swapping allowed if head not given, use current branch (HEAD)
 	if {$head eq {}} {
 		load_current_branch
-	} else {
-		if {[regexp [string map "@@ [expr $hashlength - 1]" {^[0-9a-f]{1,@@}$}] $head]} {
-			if {[catch {
-					set head [git rev-parse --verify $head]
-				} err]} {
-				if {[tk windowingsystem] eq "win32"} {
-					tk_messageBox -icon error -title [mc Error] -message $err
-				} else {
-					puts stderr $err
-				}
-				exit 1
-			}
+		set head $current_branch
+		set canswap 0
+	}
+
+	# -- before "rev" arg means we got -- path head
+	if {$canswap == 2} {
+		set head $althead
+		set path $altpath
+		set canswap 0
+	}
+
+	set objtype [find_path_type $head $path]
+	if {$objtype eq {} && $canswap} {
+		set objtype [find_path_type $althead $altpath]
+		if {$objtype ne {}} {
+			set head $althead
+			set path $altpath
 		}
-		set current_branch $head
+	}
+	set current_branch $head
+
+	# check that path exists in head, and objtype matches need
+	if {$objtype ne $required_objtype} {
+		switch -- $required_objtype {
+			tree {set err [strcat \
+				[mc "'%s' is not a directory in rev '%s'" $path $head]]}
+			blob {set err [strcat \
+				[mc "'%s' is not a filename in rev '%s'" $path $head]]}
+		}
+		if {[tk windowingsystem] eq "win32"} {
+			catch {wm withdraw .}
+			error_popup $err
+		} else {
+			puts stderr $err
+		}
+		exit 1
 	}
 
 	wm deiconify .
 	switch -- $subcommand {
 	browser {
-		if {$jump_spec ne {}} usage
-		if {$head eq {}} {
-			if {$path ne {} && [file isdirectory $path]} {
-				set head $current_branch
-			} else {
-				set head $path
-				set path {}
-			}
-		}
 		browser::new $head $path
 	}
-	blame   {
-		if {$head eq {} && ![file exists $path]} {
-			catch {wm withdraw .}
-			tk_messageBox \
-				-icon error \
-				-type ok \
-				-title [mc "git-gui: fatal error"] \
-				-message [mc "fatal: cannot stat path %s: No such file or directory" $path]
-			exit 1
-		}
+	blame {
 		blame::new $head $path $jump_spec
 	}
 	}
-- 
2.54.0.99.14

