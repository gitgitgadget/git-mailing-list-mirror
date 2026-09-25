Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA78149C7B
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 00:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790297558; cv=none; b=CPQV1y85MabhW7Y24FX2/+IC7iKUyCmy0YuSPBWogodxZS6hDPALUT8lvcDiFSUMWxt0LxjZVscmOVoS9gYONJYT9ibawYwu65iH6DKU7VuOCYAhtYl8B6627dkroTtzc3gQVddYRb6wF42Qwz+pOmBYw6EOXPJXiic3mqepyfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790297558; c=relaxed/simple;
	bh=TzxVePSVfSShERd00lqVb+LrXOIwxl6niEGTq/vamLs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JsnYXMddSoJZxYjo2YZTtdQaFTnDADtLBsWnCaeR+B4ZNR1LntPOrTcH0yG+2kNOU0f0Pn6j0l0w37GGE1/CLwgXq6loNTP+IFqpTT3CIFvd9ITn/acft4o02NkEATjmvIDvLzfg9hwiz6Y3S3k9iakVGRBbu3wO11iqtZb65JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWDwB9sF; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWDwB9sF"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664e051fso378743eec.1
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 17:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790297554; x=1790902354; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BUGN7sAyIE3m4md55jzXhKmvpUfEFCRSD6mcMzn7DS0=;
        b=ZWDwB9sFGQq2DG+RRezaZsOLjwPJSYunf2e1WR2hTKXL28iId2RbuqOO5JndAq1j6x
         yUetJUweXdpfZqmR4qKY5k97osW3EWCH6i1t+Ds2gtjVG/6JBWXfARXhewpxkH/aN4yG
         JL9OTrKx8w5HzEueXCw3ve8wf7B3MmVE5q7gfgk7cENirfF2VTPKrHV84QYc8qa7bi/1
         sOWq5T+u2wpKpuFyO0IddGcszRCbfN3yDhCzfxaddj3mdt9mGLBX1RKs37lyqwBTjMqN
         POIxrYavpQEXyUDhoPBmHQMGQhijXbrfZVQ3/4OFztyRXZCVKKUHHVLMNVD4VmNlxGAB
         iqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790297554; x=1790902354;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BUGN7sAyIE3m4md55jzXhKmvpUfEFCRSD6mcMzn7DS0=;
        b=fTsQCepzf26jk4fbsASlgdqZMZFX8ufSOHy4YUewMDI044dTB7hxsHbXPewSvIpMup
         T0PEYPqeWE5g3R2IT+AQdQu3JH6qstXzFv1iGaaxFkvz5bchz7V5VOaDR7j2ddeBNqzQ
         3Ce2Mm39872b3C5ON1aEpOBCXmt3rypjmBeDD8Z5EO117fKmm6jEhkXs9q8GgP+wGqNR
         JAktgZa57LIhtAOhklMTx5VyAyKw0R6NtYpRlKRbYFLiN51QjE/DaVRU+HVNWopx0RGA
         zzUMNgVlYJCUmDK161+KckHVnW8HP47ti+FS7fv1eybOXlQy6ayBSJaeprx4/XZO9Z/9
         oSIg==
X-Gm-Message-State: AFuF++lV0Icguzyv4cWvktsB+hn52ymLNko7/n8XrUy4bXOrjIStbiXf
	VBmhD1QE72asj60e1yFfZgGGNYo6Ss514JL13JRRIV37cODNC332CeWboy4uIaMw
X-Gm-Gg: AYBFou2smo40eVPSS3LBkrrMuLXy+0HCAwXl4cgTlSI+pK5Tddx5ArXz9HyWpOn1nCs
	nCc4o+X9luDfLhSxiPuS+cFyu+vfW/99WjTNjdKOPI9qGpQsOEgjvQ5FkrxNn5NviiJtGzJDz1X
	xyZhRFN3yAhoxjNcKCUkFiw4jac+cB+vALGKxcXpqPr1ycoG2lRIDYryaPFLR+9AjHh130Spb8z
	vDX+aqcOA5bGYcMY5Z0AQzR5ImpghDxxS3lvFesT1Zfy1+RY4bwUWkWC/UA8vuAUrwn+CBqTnX9
	ki5bOlTmStnU6k8QEexxs+4e2w5bS9gmfPmB7b8lCd1MkkVgfW/2xLqSgFfpk133eG17zXJ0RoP
	0re2qLm6jlxgpaptOGmhcaJD6rp8C5ouUbPGN7oxE9vP68m2mRdLt9YJYmc9mXIviSXvSlFxAB3
	eTkhz+u2EMoLMx93pQObyl6Tv3XglUH8P77M0mx/KNvUyQAFhJyARZ3WB25tbeM7LfTrqMpDHkw
	iRk
X-Received: by 2002:a05:7300:cf90:b0:339:7b3b:236d with SMTP id 5a478bee46e88-34001f081bcmr3267210eec.15.1790297548505;
        Thu, 24 Sep 2026 17:52:28 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.219.156])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3414456b496sm1968193eec.11.2026.09.24.17.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 17:52:27 -0700 (PDT)
Message-Id: <pull.2416.v2.git.git.1790297546771.gitgitgadget@gmail.com>
In-Reply-To: <pull.2416.git.git.1790105342890.gitgitgadget@gmail.com>
References: <pull.2416.git.git.1790105342890.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 25 Sep 2026 00:52:26 +0000
Subject: [PATCH v2] doc: add more AsciiDoc cross-references
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Jeff King <peff@peff.net>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Instead of saying "see EXAMPLES below", say "see <<EXAMPLES,EXAMPLES>>
below" to make the man pages easier to navigate on the web.

The reason for using the more verbose <<EXAMPLES,EXAMPLES>>
(instead of <<EXAMPLES>>) is that in some cases, <<EXAMPLES>> is
rendered as `the section called "EXAMPLES"` or `[EXAMPLES]`.
<<EXAMPLES,EXAMPLES>> is rendered as `EXAMPLES`, which gives us more
control over the output.

This also changes some of the HTML IDs of the headings from `_examples`
to `EXAMPLES`, which has the potential to break some links.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
    doc: add more AsciiDoc cross-references
    
    This version rewrites the commit message to be more accurate. The
    original message said that the problem was to do with included pages
    which wasn't true.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2416%2Fjvns%2Fanchors-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2416/jvns/anchors-v2
Pull-Request: https://github.com/git/git/pull/2416

Range-diff vs v1:

 1:  419aa1259f ! 1:  8f4e7bae85 doc: add more AsciiDoc cross-references
     @@ Commit message
          below" to make the man pages easier to navigate on the web.
      
          The reason for using the more verbose <<EXAMPLES,EXAMPLES>>
     -    (instead of <<EXAMPLES>>) is that if the header that `<<EXAMPLES>>`
     -    is referring to is in an included page (for example `REMOTES` in the
     -    `git-push` man page), then AsciiDoc will think it's a broken link even
     -    though it isn't. So it's easier to just make all of the links use the
     -    form with two parts.
     +    (instead of <<EXAMPLES>>) is that in some cases, <<EXAMPLES>> is
     +    rendered as `the section called "EXAMPLES"` or `[EXAMPLES]`.
     +    <<EXAMPLES,EXAMPLES>> is rendered as `EXAMPLES`, which gives us more
     +    control over the output.
     +
     +    This also changes some of the HTML IDs of the headings from `_examples`
     +    to `EXAMPLES`, which has the potential to break some links.
      
          Signed-off-by: Julia Evans <julia@jvns.ca>
      


 Documentation/fetch-options.adoc              |  4 +-
 Documentation/git-add.adoc                    |  3 +-
 Documentation/git-bundle.adoc                 |  7 +-
 Documentation/git-cat-file.adoc               | 12 ++--
 Documentation/git-checkout.adoc               | 11 +--
 Documentation/git-credential-cache.adoc       |  3 +-
 Documentation/git-credential-store.adoc       |  3 +-
 Documentation/git-fast-export.adoc            |  5 +-
 Documentation/git-fast-import.adoc            |  7 +-
 Documentation/git-fetch.adoc                  |  1 +
 Documentation/git-filter-branch.adoc          |  3 +-
 Documentation/git-for-each-ref.adoc           |  4 +-
 Documentation/git-format-patch.adoc           |  4 +-
 Documentation/git-gc.adoc                     | 12 ++--
 Documentation/git-grep.adoc                   |  9 ++-
 Documentation/git-http-backend.adoc           |  6 +-
 Documentation/git-ls-files.adoc               |  8 ++-
 Documentation/git-ls-tree.adoc                |  3 +-
 Documentation/git-maintenance.adoc            |  3 +-
 Documentation/git-merge-tree.adoc             |  2 +-
 Documentation/git-notes.adoc                  | 14 ++--
 Documentation/git-p4.adoc                     | 12 ++--
 Documentation/git-pack-objects.adoc           |  5 +-
 Documentation/git-prune.adoc                  |  3 +-
 Documentation/git-push.adoc                   | 10 +--
 Documentation/git-rebase.adoc                 | 69 +++++++++++--------
 Documentation/git-replay.adoc                 |  4 +-
 Documentation/git-repo.adoc                   |  5 +-
 Documentation/git-rev-parse.adoc              |  7 +-
 Documentation/git-send-email.adoc             |  5 +-
 Documentation/git-stash.adoc                  |  3 +-
 Documentation/git-svn.adoc                    | 10 +--
 Documentation/git-worktree.adoc               |  5 +-
 Documentation/gitremote-helpers.adoc          | 15 ++--
 Documentation/gitsubmodules.adoc              |  9 ++-
 Documentation/gitworkflows.adoc               |  6 +-
 .../howto/revert-a-faulty-merge.adoc          |  5 +-
 Documentation/revisions.adoc                  |  4 +-
 38 files changed, 190 insertions(+), 111 deletions(-)

diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index 035f780e58..47dea1de8e 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -199,7 +199,7 @@ endif::git-pull[]
 	providing the tag refspec.
 ifndef::git-pull[]
 +
-See the PRUNING section below for more details.
+See the <<PRUNING,PRUNING>> section below for more details.
 
 `-P`::
 `--prune-tags`::
@@ -210,7 +210,7 @@ See the PRUNING section below for more details.
 	a shorthand for providing the explicit tag refspec along with
 	`--prune`, see the discussion about that in its documentation.
 +
-See the PRUNING section below for more details.
+See the <<PRUNING,PRUNING>> section below for more details.
 
 endif::git-pull[]
 
diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
index 16b06e38e1..906db7ccf3 100644
--- a/Documentation/git-add.adoc
+++ b/Documentation/git-add.adoc
@@ -117,7 +117,7 @@ The intent of this option is to pick and choose lines of the patch to
 apply, or even to modify the contents of lines to be staged. This can be
 quicker and more flexible than using the interactive hunk selector.
 However, it is easy to confuse oneself and create a patch that does not
-apply to the index. See EDITING PATCHES below.
+apply to the index. See <<EDITING_PATCHES,EDITING PATCHES>> below.
 
 `-u`::
 `--update`::
@@ -375,6 +375,7 @@ diff::
   `HEAD` and index).
 
 
+[[EDITING_PATCHES]]
 EDITING PATCHES
 ---------------
 
diff --git a/Documentation/git-bundle.adoc b/Documentation/git-bundle.adoc
index 03cd36fe8d..cd722bd674 100644
--- a/Documentation/git-bundle.adoc
+++ b/Documentation/git-bundle.adoc
@@ -43,7 +43,7 @@ header indicating what references are contained within the bundle.
 
 Like the packed archive format itself bundles can either be
 self-contained, or be created using exclusions.
-See the "OBJECT PREREQUISITES" section below.
+See the <<OBJECT_PREREQUISITES,"OBJECT PREREQUISITES">> section below.
 
 Bundles created using revision exclusions are "thin packs" created
 using the `--thin` option to linkgit:git-pack-objects[1], and
@@ -94,7 +94,8 @@ unbundle <file>::
 
 <git-rev-list-args>::
 	A list of arguments, acceptable to 'git rev-parse' and
-	'git rev-list' (and containing a named ref, see SPECIFYING REFERENCES
+	'git rev-list' (and containing a named ref, see
+	<<SPECIFYING_REFERENCES,SPECIFYING REFERENCES>>
 	below), that specifies the specific objects and references
 	to transport.  For example, `master~10..master` causes the
 	current master reference to be packaged along with all objects
@@ -127,6 +128,7 @@ unbundle <file>::
 	This flag makes the command not to report its progress
 	on the standard error stream.
 
+[[SPECIFYING_REFERENCES]]
 SPECIFYING REFERENCES
 ---------------------
 
@@ -169,6 +171,7 @@ $ git bundle create master-yesterday.bundle master~10..master~5
 fatal: Refusing to create empty bundle.
 ----------------
 
+[[OBJECT_PREREQUISITES]]
 OBJECT PREREQUISITES
 --------------------
 
diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
index 514bfc0032..c4ea2524cf 100644
--- a/Documentation/git-cat-file.adoc
+++ b/Documentation/git-cat-file.adoc
@@ -115,7 +115,7 @@ are not of the requested type.
 --
 	* When used with `--textconv` or `--filters`, the input lines
 	  must specify the path, separated by whitespace. See the section
-	  `BATCH OUTPUT` below for details.
+	  <<BATCH_OUTPUT,`BATCH OUTPUT`>> below for details.
 
 	* When used with `--use-mailmap`, for commit and tag objects, the
 	  contents part of the output shows the identities replaced using the
@@ -133,7 +133,7 @@ are not of the requested type.
 --
 	* When used with `--textconv` or `--filters`, the input lines must
 	 specify the path, separated by whitespace. See the section
-	 `BATCH OUTPUT` below for details.
+	 <<BATCH_OUTPUT,`BATCH OUTPUT`>> below for details.
 
 	* When used with `--use-mailmap`, for commit and tag objects, the
 	  printed object information shows the size of the object as if the
@@ -149,7 +149,7 @@ are not of the requested type.
 --
 	* When used with `--textconv` or `--filters`, the input lines must
 	  specify the path, separated by whitespace. See the section
-	  `BATCH OUTPUT` below for details.
+	  <<BATCH_OUTPUT,`BATCH OUTPUT`>> below for details.
 
 	* When used with `--use-mailmap`, for commit and tag objects, the
 	  `contents` command shows the identities replaced using the
@@ -295,6 +295,7 @@ If `-p` is specified, the contents of `<object>` are pretty-printed.
 If `<type>` is specified, the raw (though uncompressed) contents of the `<object>`
 will be returned.
 
+[[BATCH_OUTPUT]]
 BATCH OUTPUT
 ------------
 
@@ -333,12 +334,12 @@ newline. The available atoms are:
 
 `objectsize:disk`::
 	The size, in bytes, that the object takes up on disk. See the
-	note about on-disk sizes in the `CAVEATS` section below.
+	note about on-disk sizes in the <<CAVEATS,`CAVEATS`>> section below.
 
 `deltabase`::
 	If the object is stored as a delta on-disk, this expands to the
 	full hex representation of the delta base object name.
-	Otherwise, expands to the null OID (all zeroes). See `CAVEATS`
+	Otherwise, expands to the null OID (all zeroes). See <<CAVEATS,`CAVEATS`>>
 	below.
 
 `rest`::
@@ -447,6 +448,7 @@ are replaced with NUL terminators. This ensures that output will be parsable if
 the output itself would contain a linefeed and is thus recommended for
 scripting purposes.
 
+[[CAVEATS]]
 CAVEATS
 -------
 
diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index a8b3b8c2e2..2aefea0228 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -27,7 +27,8 @@ DESCRIPTION
 2. **Restore a different version of a file**, for example with
    `git checkout <commit> <filename>` or `git checkout <filename>`
 
-See ARGUMENT DISAMBIGUATION below for how Git decides which one to do.
+See <<ARGUMENT_DISAMBIGUATION,ARGUMENT DISAMBIGUATION>> below
+for how Git decides which one to do.
 
 `git checkout [<branch>]`::
 	Switch to _<branch>_. This sets the current branch to _<branch>_ and
@@ -68,7 +69,7 @@ uncommitted changes.
 
 	The same as `git checkout <branch>`, except that instead of pointing
 	`HEAD` at the branch, it points `HEAD` at the commit ID.
-	See the "DETACHED HEAD" section below for more.
+	See the <<DETACHED_HEAD,"DETACHED HEAD">> section below for more.
 +
 Omitting _<branch>_ detaches `HEAD` at the tip of the current branch.
 
@@ -210,8 +211,8 @@ variable.
 	Rather than checking out a branch to work on it, check out a
 	commit for inspection and discardable experiments.
 	This is the default behavior of `git checkout <commit>` when
-	_<commit>_ is not a branch name.  See the "DETACHED HEAD" section
-	below for details.
+	_<commit>_ is not a branch name.  See the
+	<<DETACHED_HEAD,"DETACHED HEAD">> section below for details.
 
 `--orphan <new-branch>`::
 	Create a new unborn branch, named _<new-branch>_, started from
@@ -372,6 +373,7 @@ leave out at most one of _<rev-a>_ and _<rev-b>_, in which case it defaults to `
 +
 For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
 
+[[DETACHED_HEAD]]
 DETACHED HEAD
 -------------
 `HEAD` normally refers to a named branch (e.g. `master`). Meanwhile, each
@@ -504,6 +506,7 @@ $ git reflog -2 HEAD # or
 $ git log -g -2 HEAD
 ------------
 
+[[ARGUMENT_DISAMBIGUATION]]
 ARGUMENT DISAMBIGUATION
 -----------------------
 
diff --git a/Documentation/git-credential-cache.adoc b/Documentation/git-credential-cache.adoc
index 54fa7a27e1..2f6395937d 100644
--- a/Documentation/git-credential-cache.adoc
+++ b/Documentation/git-credential-cache.adoc
@@ -24,7 +24,7 @@ user by filesystem permissions.
 
 You probably don't want to invoke this command directly; it is meant to
 be used as a credential helper by other parts of Git. See
-linkgit:gitcredentials[7] or `EXAMPLES` below.
+linkgit:gitcredentials[7] or <<EXAMPLES,`EXAMPLES`>> below.
 
 OPTIONS
 -------
@@ -54,6 +54,7 @@ credentials before their timeout, you can issue an `exit` action:
 git credential-cache exit
 --------------------------------------
 
+[[EXAMPLES]]
 EXAMPLES
 --------
 
diff --git a/Documentation/git-credential-store.adoc b/Documentation/git-credential-store.adoc
index 71864a8726..3f8a426f93 100644
--- a/Documentation/git-credential-store.adoc
+++ b/Documentation/git-credential-store.adoc
@@ -24,7 +24,7 @@ Git programs.
 
 You probably don't want to invoke this command directly; it is meant to
 be used as a credential helper by other parts of git. See
-linkgit:gitcredentials[7] or `EXAMPLES` below.
+linkgit:gitcredentials[7] or <<EXAMPLES,`EXAMPLES`>> below.
 
 OPTIONS
 -------
@@ -67,6 +67,7 @@ written to.
 
 When erasing credentials, matching credentials will be erased from all files.
 
+[[EXAMPLES]]
 EXAMPLES
 --------
 
diff --git a/Documentation/git-fast-export.adoc b/Documentation/git-fast-export.adoc
index 719aeca244..0c2ce385c4 100644
--- a/Documentation/git-fast-export.adoc
+++ b/Documentation/git-fast-export.adoc
@@ -148,12 +148,12 @@ by keeping the marks the same across runs.
 --anonymize::
 	Anonymize the contents of the repository while still retaining
 	the shape of the history and stored tree.  See the section on
-	`ANONYMIZING` below.
+	<<ANONYMIZING,`ANONYMIZING`>> below.
 
 --anonymize-map=<from>[:<to>]::
 	Convert token `<from>` to `<to>` in the anonymized output. If
 	`<to>` is omitted, map `<from>` to itself (i.e., do not
-	anonymize it). See the section on `ANONYMIZING` below.
+	anonymize it). See the section on <<ANONYMIZING,`ANONYMIZING`>> below.
 
 --reference-excluded-parents::
 	By default, running a command such as `git fast-export
@@ -219,6 +219,7 @@ referenced by that revision range contains the string
 'refs/heads/master'.
 
 
+[[ANONYMIZING]]
 ANONYMIZING
 -----------
 
diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
index fd165e11d2..c5e1cec1a5 100644
--- a/Documentation/git-fast-import.adoc
+++ b/Documentation/git-fast-import.adoc
@@ -31,6 +31,7 @@ imports are supported from a particular foreign source depends on
 the frontend program in use.
 
 
+[[OPTIONS]]
 OPTIONS
 -------
 
@@ -456,7 +457,7 @@ and control the current import process.  More detailed discussion
 	supports the specified feature, and aborts if it does not.
 
 `option`::
-	Specify any of the options listed under OPTIONS that do not
+	Specify any of the options listed under <<OPTIONS,OPTIONS>> that do not
 	change stream semantic to suit the frontend's needs. This
 	command is optional and is not needed to perform an import.
 
@@ -1242,7 +1243,7 @@ no-relative-marks::
 force::
 	Act as though the corresponding command-line option with
 	a leading `--` was passed on the command line
-	(see OPTIONS, above).
+	(see <<OPTIONS,OPTIONS>>, above).
 
 import-marks::
 import-marks-if-exists::
@@ -1291,7 +1292,7 @@ options the user may specify to git fast-import itself.
 ....
 
 The `<option>` part of the command may contain any of the options
-listed in the OPTIONS section that do not change import semantics,
+listed in the <<OPTIONS,OPTIONS>> section that do not change import semantics,
 without the leading `--` and is treated in the same way.
 
 Option commands must be the first commands on the input (not counting
diff --git a/Documentation/git-fetch.adoc b/Documentation/git-fetch.adoc
index db03541915..61fed797af 100644
--- a/Documentation/git-fetch.adoc
+++ b/Documentation/git-fetch.adoc
@@ -103,6 +103,7 @@ The latter use of the `remote.<repository>.fetch` values can be
 overridden by giving the `--refmap=<refspec>` parameter(s) on the
 command line.
 
+[[PRUNING]]
 PRUNING
 -------
 
diff --git a/Documentation/git-filter-branch.adoc b/Documentation/git-filter-branch.adoc
index 5a4f853785..80a55b3706 100644
--- a/Documentation/git-filter-branch.adoc
+++ b/Documentation/git-filter-branch.adoc
@@ -125,7 +125,7 @@ OPTIONS
 	This is the filter for rewriting the index.  It is similar to the
 	tree filter but does not check out the tree, which makes it much
 	faster.  Frequently used with `git rm --cached
-	--ignore-unmatch ...`, see EXAMPLES below.  For hairy
+	--ignore-unmatch ...`, see <<EXAMPLES,EXAMPLES>> below.  For hairy
 	cases, see linkgit:git-update-index[1].
 
 --parent-filter <command>::
@@ -243,6 +243,7 @@ rewrite, the exit status is `2`.  On any other error, the exit status may be
 any other non-zero value.
 
 
+[[EXAMPLES]]
 EXAMPLES
 --------
 
diff --git a/Documentation/git-for-each-ref.adoc b/Documentation/git-for-each-ref.adoc
index c02cb7f886..a7b31e8aaf 100644
--- a/Documentation/git-for-each-ref.adoc
+++ b/Documentation/git-for-each-ref.adoc
@@ -64,7 +64,8 @@ For all objects, the following names can be used:
 `objectsize`::
 	The size of the object (the same as 'git cat-file -s' reports).
 	Append `:disk` to get the size, in bytes, that the object takes up on
-	disk. See the note about on-disk sizes in the 'CAVEATS' section below.
+	disk. See the note about on-disk sizes in the
+	<<CAVEATS,'CAVEATS'>> section below.
 `objectname`::
 	The object name (aka SHA-1).
 	For a non-ambiguous abbreviation of the object name append `:short`.
@@ -448,6 +449,7 @@ This prints the authorname, if present.
 git for-each-ref --format="%(refname)%(if)%(authorname)%(then) Authored by: %(authorname)%(end)"
 ------------
 
+[[CAVEATS]]
 CAVEATS
 -------
 
diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
index 191f64b77d..a78fe564f0 100644
--- a/Documentation/git-format-patch.adoc
+++ b/Documentation/git-format-patch.adoc
@@ -430,7 +430,8 @@ you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
 `--no-base`::
 `--base[=<commit>]`::
 	Record the base tree information to identify the state the
-	patch series applies to.  See the BASE TREE INFORMATION section
+	patch series applies to.  See the
+	<<BASE_TREE_INFORMATION,BASE TREE INFORMATION>> section
 	below for details. If _<commit>_ is `auto`, a base commit is
 	automatically chosen. The `--no-base` option overrides a
 	`format.useAutoBase` configuration.
@@ -702,6 +703,7 @@ This should help you to submit patches inline using KMail.
 5. Back in the compose window: add whatever other text you wish to the
    message, complete the addressing and subject fields, and press send.
 
+[[BASE_TREE_INFORMATION]]
 BASE TREE INFORMATION
 ---------------------
 
diff --git a/Documentation/git-gc.adoc b/Documentation/git-gc.adoc
index 6fed646dd8..5788a43215 100644
--- a/Documentation/git-gc.adoc
+++ b/Documentation/git-gc.adoc
@@ -39,14 +39,15 @@ OPTIONS
 	space utilization and performance.  This option will cause
 	'git gc' to more aggressively optimize the repository at the expense
 	of taking much more time.  The effects of this optimization are
-	mostly persistent. See the "AGGRESSIVE" section below for details.
+	mostly persistent. See the <<AGGRESSIVE,"AGGRESSIVE">>
+	section below for details.
 
 --auto::
 	With this option, 'git gc' checks whether any housekeeping is
 	required; if not, it exits without performing any work.
 +
-See the `gc.auto` option in the "CONFIGURATION" section below for how
-this heuristic works.
+See the `gc.auto` option in the <<CONFIGURATION,"CONFIGURATION">>
+section below for how this heuristic works.
 +
 Once housekeeping is triggered by exceeding the limits of
 configuration options such as `gc.auto` and `gc.autoPackLimit`, all
@@ -83,7 +84,7 @@ be performed as well.
 	overridable by the config variable `gc.pruneExpire`).
 	--prune=now prunes loose objects regardless of their age and
 	increases the risk of corruption if another process is writing to
-	the repository concurrently; see "NOTES" below. --prune is on by
+	the repository concurrently; see <<NOTES,"NOTES">> below. --prune is on by
 	default.
 
 --no-prune::
@@ -102,6 +103,7 @@ be performed as well.
 	a single pack. When this option is used, `gc.bigPackThreshold`
 	is ignored.
 
+[[AGGRESSIVE]]
 AGGRESSIVE
 ----------
 
@@ -128,6 +130,7 @@ more time, and the resulting space/delta optimization may or may not
 be worth it. Not using this at all is the right trade-off for most
 users and their repositories.
 
+[[CONFIGURATION]]
 CONFIGURATION
 -------------
 
@@ -135,6 +138,7 @@ include::includes/cmd-config-section-all.adoc[]
 
 include::config/gc.adoc[]
 
+[[NOTES]]
 NOTES
 -----
 
diff --git a/Documentation/git-grep.adoc b/Documentation/git-grep.adoc
index 19b3ade16d..dd4a7cc9e9 100644
--- a/Documentation/git-grep.adoc
+++ b/Documentation/git-grep.adoc
@@ -58,7 +58,7 @@ OPTIONS
 	in linkgit:gitglossary[7] for more information.
 +
 This option cannot be used together with `--cached` or `--untracked`.
-See also `grep.fallbackToNoIndex` in 'CONFIGURATION' below.
+See also `grep.fallbackToNoIndex` in <<CONFIGURATION,'CONFIGURATION'>> below.
 
 `--no-exclude-standard`::
 	Also search in ignored files by not honoring the `.gitignore`
@@ -256,8 +256,9 @@ providing this option will cause it to die.
 	a non-zero status.
 
 `--threads <num>`::
-	Number of `grep` worker threads to use.  See `NOTES ON THREADS`
-	and `grep.threads` in 'CONFIGURATION' for more information.
+	Number of `grep` worker threads to use. See
+	<<NOTES_ON_THREADS,`NOTES ON THREADS`>> and `grep.threads` in
+	<<CONFIGURATION,'CONFIGURATION'>> for more information.
 
 `-f <file>`::
 	Read patterns from _<file>_, one per line.
@@ -337,6 +338,7 @@ EXAMPLES
 `git grep solution -- :^Documentation`::
 	Looks for `solution`, excluding files in `Documentation`.
 
+[[NOTES_ON_THREADS]]
 NOTES ON THREADS
 ----------------
 
@@ -348,6 +350,7 @@ with multiple threads might perform slower than single-threaded if `--textconv`
 is given and there are too many text conversions.  Thus, if low performance is
 experienced in this case, it might be desirable to use `--threads=1`.
 
+[[CONFIGURATION]]
 CONFIGURATION
 -------------
 
diff --git a/Documentation/git-http-backend.adoc b/Documentation/git-http-backend.adoc
index 1dea426852..5fabc85d12 100644
--- a/Documentation/git-http-backend.adoc
+++ b/Documentation/git-http-backend.adoc
@@ -18,7 +18,7 @@ The program supports clients fetching using both the smart HTTP protocol
 and the backwards-compatible dumb HTTP protocol, as well as clients
 pushing using the smart HTTP protocol. It also supports Git's
 more-efficient "v2" protocol if properly configured; see the
-discussion of `GIT_PROTOCOL` in the ENVIRONMENT section below.
+discussion of `GIT_PROTOCOL` in the <<ENVIRONMENT,ENVIRONMENT>> section below.
 
 It verifies that the directory has the magic file
 "git-daemon-export-ok", and it will refuse to export any Git directory
@@ -69,6 +69,7 @@ manually in the web server configuration.  If GIT_PROJECT_ROOT is not
 set, 'git http-backend' reads PATH_TRANSLATED, which is also set
 automatically by the web server.
 
+[[EXAMPLES]]
 EXAMPLES
 --------
 All of the following examples map `http://$hostname/git/foo/bar.git`
@@ -257,6 +258,7 @@ $HTTP["url"] =~ "^/git/private" {
 ----------------------------------------------------------------
 
 
+[[ENVIRONMENT]]
 ENVIRONMENT
 -----------
 'git http-backend' relies upon the `CGI` environment variables set
@@ -290,7 +292,7 @@ via the `HTTP_GIT_PROTOCOL` variable, and `git-http-backend` will
 automatically copy that to `GIT_PROTOCOL`. However, some webservers may
 be more selective about which headers they'll pass, in which case they
 need to be configured explicitly (see the mention of `Git-Protocol` in
-the Apache config from the earlier EXAMPLES section).
+the Apache config from the earlier <<EXAMPLES,EXAMPLES>> section).
 
 The backend process sets GIT_COMMITTER_NAME to '$REMOTE_USER' and
 GIT_COMMITTER_EMAIL to '$\{REMOTE_USER}@http.$\{REMOTE_ADDR\}',
diff --git a/Documentation/git-ls-files.adoc b/Documentation/git-ls-files.adoc
index 2b175388e1..14ebad8b71 100644
--- a/Documentation/git-ls-files.adoc
+++ b/Documentation/git-ls-files.adoc
@@ -98,7 +98,7 @@ OPTIONS
 
 -z::
 	\0 line termination on output and do not quote filenames.
-	See OUTPUT below for more information.
+	See <<OUTPUT,OUTPUT>> below for more information.
 
 --deduplicate::
 	When only filenames are shown, suppress duplicates that may
@@ -110,8 +110,8 @@ OPTIONS
 -x <pattern>::
 --exclude=<pattern>::
 	Skip untracked files matching pattern.
-	Note that pattern is a shell wildcard pattern. See EXCLUDE PATTERNS
-	below for more information.
+	Note that pattern is a shell wildcard pattern.
+	See <<EXCLUDE_PATTERNS,EXCLUDE PATTERNS>> below for more information.
 
 -X <file>::
 --exclude-from=<file>::
@@ -231,6 +231,7 @@ followed by the  ("attr/<eolattr>").
 	Files to show. If no files are given all files which match the other
 	specified criteria are shown.
 
+[[OUTPUT]]
 OUTPUT
 ------
 'git ls-files' just outputs the filenames unless `--stage` is specified in
@@ -292,6 +293,7 @@ eolattr::
 path::
 	The pathname of the file which is recorded in the index.
 
+[[EXCLUDE_PATTERNS]]
 EXCLUDE PATTERNS
 ----------------
 
diff --git a/Documentation/git-ls-tree.adoc b/Documentation/git-ls-tree.adoc
index 6572095d8d..29bde9366d 100644
--- a/Documentation/git-ls-tree.adoc
+++ b/Documentation/git-ls-tree.adoc
@@ -54,7 +54,7 @@ OPTIONS
 
 -z::
 	\0 line termination on output and do not quote filenames.
-	See OUTPUT FORMAT below for more information.
+	See <<OUTPUT_FORMAT,OUTPUT FORMAT>> below for more information.
 
 --name-only::
 --name-status::
@@ -99,6 +99,7 @@ OPTIONS
 	implicitly uses the root level of the tree as the sole path argument.
 
 
+[[OUTPUT_FORMAT]]
 Output Format
 -------------
 
diff --git a/Documentation/git-maintenance.adoc b/Documentation/git-maintenance.adoc
index bda616f14c..85f208031c 100644
--- a/Documentation/git-maintenance.adoc
+++ b/Documentation/git-maintenance.adoc
@@ -95,6 +95,7 @@ in that order. Otherwise, the tasks are determined by which
 `maintenance.<task>.enabled` config options are true. By default, only
 `maintenance.gc.enabled` is true.
 
+[[TASKS]]
 TASKS
 -----
 
@@ -215,7 +216,7 @@ OPTIONS
 	specified tasks in the specified order. If no `--task=<task>`
 	arguments are specified, then only the tasks with
 	`maintenance.<task>.enabled` configured as `true` are considered.
-	See the 'TASKS' section for the list of accepted `<task>` values.
+	See the <<TASKS,'TASKS'>> section for the list of accepted `<task>` values.
 
 --scheduler=auto|crontab|systemd-timer|launchctl|schtasks::
 	When combined with the `start` subcommand, specify the scheduler
diff --git a/Documentation/git-merge-tree.adoc b/Documentation/git-merge-tree.adoc
index 4391bbee47..c5351f9699 100644
--- a/Documentation/git-merge-tree.adoc
+++ b/Documentation/git-merge-tree.adoc
@@ -35,7 +35,7 @@ linkgit:git-merge[1], including:
   * etc.
 
 After the merge completes, a new toplevel tree object is created.  See
-`OUTPUT` below for details.
+<<OUTPUT,`OUTPUT`>> below for details.
 
 OPTIONS
 -------
diff --git a/Documentation/git-notes.adoc b/Documentation/git-notes.adoc
index 46a232ca71..22d59ada86 100644
--- a/Documentation/git-notes.adoc
+++ b/Documentation/git-notes.adoc
@@ -28,8 +28,9 @@ Adds, removes, or reads notes attached to objects, without touching
 the objects themselves.
 
 By default, notes are saved to and read from `refs/notes/commits`, but
-this default can be overridden.  See the OPTIONS, CONFIGURATION, and
-ENVIRONMENT sections below.  If this ref does not exist, it will be
+this default can be overridden.  See the <<OPTIONS,OPTIONS>>,
+<<CONFIGURATION,CONFIGURATION>>, and <<ENVIRONMENT,ENVIRONMENT>>
+sections below. If this ref does not exist, it will be
 quietly created when it is first needed to store a note.
 
 A typical use of notes is to supplement a commit message without
@@ -114,7 +115,8 @@ line.
 	any) into the current notes ref (called "local").
 +
 If conflicts arise and a strategy for automatically resolving
-conflicting notes (see the "NOTES MERGE STRATEGIES" section) is not given,
+conflicting notes (see the
+<<NOTES_MERGE_STRATEGIES,"NOTES MERGE STRATEGIES">> section) is not given,
 the `manual` resolver is used. This resolver checks out the
 conflicting notes in a special worktree (`.git/NOTES_MERGE_WORKTREE`),
 and instructs the user to manually resolve the conflicts there.
@@ -139,6 +141,7 @@ the command line.
 	Print the current notes ref. This provides an easy way to
 	retrieve the current notes ref (e.g. from scripts).
 
+[[OPTIONS]]
 OPTIONS
 -------
 `-f`::
@@ -225,7 +228,8 @@ future.
 	strategy. The following strategies are recognized: `manual`
 	(default), `ours`, `theirs`, `union` and `cat_sort_uniq`.
 	This option overrides the `notes.mergeStrategy` configuration setting.
-	See the "NOTES MERGE STRATEGIES" section below for more
+	See the <<NOTES_MERGE_STRATEGIES,"NOTES MERGE STRATEGIES">>
+	section below for more
 	information on each notes merge strategy.
 
 `--commit`::
@@ -278,6 +282,7 @@ object, in which case the history of the notes can be read with
 `git log -p -g <refname>`.
 
 
+[[NOTES_MERGE_STRATEGIES]]
 NOTES MERGE STRATEGIES
 ----------------------
 
@@ -361,6 +366,7 @@ include::includes/cmd-config-section-rest.adoc[]
 include::config/notes.adoc[]
 
 
+[[ENVIRONMENT]]
 ENVIRONMENT
 -----------
 
diff --git a/Documentation/git-p4.adoc b/Documentation/git-p4.adoc
index 59edd24134..acf14cd03d 100644
--- a/Documentation/git-p4.adoc
+++ b/Documentation/git-p4.adoc
@@ -119,7 +119,8 @@ importing directly from p4 is considerably slower than pulling changes
 from a Git remote, this can be useful in a multi-developer environment.
 
 If there are multiple branches, doing 'git p4 sync' will automatically
-use the "BRANCH DETECTION" algorithm to try to partition new changes
+use the <<BRANCH_DETECTION,"BRANCH DETECTION">> algorithm
+to try to partition new changes
 into the right branch.  This can be overridden with the `--branch`
 option to specify just a single branch to update.
 
@@ -245,7 +246,7 @@ Git repository:
 
 --detect-branches::
 	Use the branch detection algorithm to find new paths in p4.  It is
-	documented below in "BRANCH DETECTION".
+	documented below in <<BRANCH_DETECTION,"BRANCH DETECTION">>.
 
 --changesfile <file>::
 	Import exactly the p4 change numbers listed in 'file', one per
@@ -297,7 +298,7 @@ Git repository:
 
 --use-client-spec::
 	Use a client spec to find the list of interesting files in p4.
-	See the "CLIENT SPEC" section below.
+	See the <<CLIENT_SPEC,"CLIENT SPEC">> section below.
 
 -/ <path>::
 	Exclude selected depot paths when cloning or syncing.
@@ -475,6 +476,7 @@ p4 revision specifier on the end:
 See 'p4 help revisions' for the full syntax of p4 revision specifiers.
 
 
+[[CLIENT_SPEC]]
 CLIENT SPEC
 -----------
 The p4 client specification is maintained with the 'p4 client' command
@@ -505,6 +507,7 @@ normal p4 mechanisms of determining the client are used:  environment
 variable `P4CLIENT`, a file referenced by `P4CONFIG`, or the local host name.
 
 
+[[BRANCH_DETECTION]]
 BRANCH DETECTION
 ----------------
 P4 does not have the same concept of a branch as Git.  Instead,
@@ -643,7 +646,8 @@ git-p4.labelImportRegexp::
 git-p4.useClientSpec::
 	Specify that the p4 client spec should be used to identify p4
 	depot paths of interest.  This is equivalent to specifying the
-	option `--use-client-spec`.  See the "CLIENT SPEC" section above.
+	option `--use-client-spec`.
+	See the <<CLIENT_SPEC,"CLIENT SPEC">> section above.
 	This variable is a boolean, not the name of a p4 client.
 
 git-p4.pathEncoding::
diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index 65cd00c152..ccad938c5b 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -363,8 +363,8 @@ raise an error.
 	Keep unreachable objects in loose form. This implies `--revs`.
 
 --delta-islands::
-	Restrict delta matches based on "islands". See DELTA ISLANDS
-	below.
+	Restrict delta matches based on "islands".
+	See <<DELTA_ISLANDS,DELTA ISLANDS>> below.
 
 --name-hash-version=<n>::
 	While performing delta compression, Git groups objects that may be
@@ -411,6 +411,7 @@ request. The `--path-walk` option supports the `--filter=<spec>` forms
 `combine:<spec>+<spec>` form.
 
 
+[[DELTA_ISLANDS]]
 DELTA ISLANDS
 -------------
 
diff --git a/Documentation/git-prune.adoc b/Documentation/git-prune.adoc
index 9a45571b90..d7836e625f 100644
--- a/Documentation/git-prune.adoc
+++ b/Documentation/git-prune.adoc
@@ -15,7 +15,7 @@ DESCRIPTION
 -----------
 
 NOTE: In most cases, users should run 'git gc', which calls
-'git prune'. See the section "NOTES", below.
+'git prune'. See the section <<NOTES,"NOTES">>, below.
 
 This runs 'git fsck --unreachable' using all the refs
 available in `refs/`, optionally with an additional set of
@@ -67,6 +67,7 @@ borrows from your repository via its
 $ git prune $(cd ../another && git rev-parse --all)
 ------------
 
+[[NOTES]]
 NOTES
 -----
 
diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
index aa221c3909..e5b1023855 100644
--- a/Documentation/git-push.adoc
+++ b/Documentation/git-push.adoc
@@ -132,7 +132,8 @@ as well as various other special refspec forms:
     linkgit:git-config[1]) suggest what refs/ namespace you may have
     wanted to push to.
 
-Not all updates are allowed: see PUSH RULES below for the details.
+Not all updates are allowed: see
+<<PUSH_RULES,PUSH RULES>> below for the details.
 
 `--all`::
 `--branches`::
@@ -337,9 +338,9 @@ allowing a forced update.
 	Usually, `git push` will refuse to update a branch that is not an
 	ancestor of the commit being pushed.
 +
-This flag disables that check, the other safety checks in PUSH RULES
-below, and the checks in `--force-with-lease`. It can cause the remote
-repository to lose commits; use it with care.
+This flag disables that check, the other safety checks in
+<<PUSH_RULES,PUSH RULES>> below, and the checks in `--force-with-lease`.
+It can cause the remote repository to lose commits; use it with care.
 +
 Note that `--force` applies to all the refs that are pushed, hence
 using it with `push.default` set to `matching` or with multiple push
@@ -568,6 +569,7 @@ reason::
 	refs, no explanation is needed. For a failed ref, the reason for
 	failure is described.
 
+[[PUSH_RULES]]
 PUSH RULES
 ----------
 
diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index f6c22d1598..6536ebdc90 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -17,8 +17,8 @@ SYNOPSIS
 DESCRIPTION
 -----------
 Transplant a series of commits onto a different starting point.
-You can also use `git rebase` to reorder or combine commits: see INTERACTIVE
-MODE below for how to do that.
+You can also use `git rebase` to reorder or combine commits: see
+<<INTERACTIVE_MODE,INTERACTIVE MODE>> below for how to do that.
 
 For example, imagine that you have been working on the `topic` branch in this
 history, and you want to "catch up" to the work done on the `master` branch.
@@ -76,8 +76,8 @@ Here is a simplified description of what `git rebase <upstream>` does:
 2. Check out `<upstream>` with the equivalent of
    `git checkout --detach <upstream>`.
 3. Replay the commits, one by one, in order. This is similar to running
-   `git cherry-pick <commit>` for each commit. See REBASING MERGES for how merges
-   are handled.
+   `git cherry-pick <commit>` for each commit.
+   See <<REBASING_MERGES,REBASING MERGES>> for how merges are handled.
 4. Update your branch to point to the final commit with the equivalent
    of `git checkout -B <branch>`.
 
@@ -89,6 +89,7 @@ point to that commit at the end of the rebase if other commands that change
 tip, however, is accessible using the reflog of the current branch (i.e. `@{1}`,
 see linkgit:gitrevisions[7]).
 
+[[TRANSPLANTING]]
 TRANSPLANTING A TOPIC BRANCH WITH --ONTO
 ----------------------------------------
 
@@ -218,7 +219,8 @@ As a special case, you may use "A\...B" as a shortcut for the
 merge base of A and B if there is exactly one merge base. You can
 leave out at most one of A and B, in which case it defaults to HEAD.
 
-See TRANSPLANTING A TOPIC BRANCH WITH --ONTO above for examples.
+See <<TRANSPLANTING,TRANSPLANTING A TOPIC BRANCH WITH --ONTO>>
+above for examples.
 
 --keep-base::
 	Set the starting point at which to create the new commits to the
@@ -239,7 +241,7 @@ Although both this option and `--fork-point` find the merge base between
 point_ on which new commits will be created, whereas `--fork-point` uses
 the merge base to determine the _set of commits_ which will be rebased.
 +
-See also INCOMPATIBLE OPTIONS below.
+See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
 
 <upstream>::
 	Upstream branch to compare against.  May be any valid commit,
@@ -254,7 +256,7 @@ See also INCOMPATIBLE OPTIONS below.
 	internally).  This option may become a no-op in the future
 	once the merge backend handles everything the apply one does.
 +
-See also INCOMPATIBLE OPTIONS below.
+See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
 
 --empty=(drop|keep|stop)::
 	How to handle commits that are not empty to start and are not
@@ -282,7 +284,7 @@ by `git log --cherry-mark ...`) are detected and dropped as a
 preliminary step (unless `--reapply-cherry-picks` or `--keep-base` is
 passed).
 +
-See also INCOMPATIBLE OPTIONS below.
+See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
 
 --no-keep-empty::
 --keep-empty::
@@ -303,7 +305,7 @@ tools generate many empty commits and you want them all removed.
 For commits which do not start empty but become empty after rebasing,
 see the `--empty` flag.
 +
-See also INCOMPATIBLE OPTIONS below.
+See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
 
 --reapply-cherry-picks::
 --no-reapply-cherry-picks::
@@ -325,7 +327,7 @@ linkgit:git-config[1]).
 `--reapply-cherry-picks` allows rebase to forgo reading all upstream
 commits, potentially improving performance.
 +
-See also INCOMPATIBLE OPTIONS below.
+See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
 
 --allow-empty-message::
 	No-op.  Rebasing commits with an empty message used to fail
@@ -333,7 +335,7 @@ See also INCOMPATIBLE OPTIONS below.
 	with empty messages to be rebased.  Now commits with an empty
 	message do not cause rebasing to halt.
 +
-See also INCOMPATIBLE OPTIONS below.
+See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
 
 -m::
 --merge::
@@ -345,7 +347,7 @@ conflict happens, the side reported as 'ours' is the so-far rebased
 series, starting with `<upstream>`, and 'theirs' is the working branch.
 In other words, the sides are swapped.
 +
-See also INCOMPATIBLE OPTIONS below.
+See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
 
 -s <strategy>::
 --strategy=<strategy>::
@@ -357,7 +359,7 @@ on top of the `<upstream>` branch using the given strategy, using
 the `ours` strategy simply empties all patches from the `<branch>`,
 which makes little sense.
 +
-See also INCOMPATIBLE OPTIONS below.
+See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
 
 -X <strategy-option>::
 --strategy-option=<strategy-option>::
@@ -366,7 +368,7 @@ See also INCOMPATIBLE OPTIONS below.
 	specified, `-s ort`.  Note the reversal of 'ours' and
 	'theirs' as noted above for the `-m` option.
 +
-See also INCOMPATIBLE OPTIONS below.
+See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
 
 include::rerere-options.adoc[]
 
@@ -408,7 +410,7 @@ include::rerere-options.adoc[]
 	context exist they all must match.  By default no context is
 	ever ignored.  Implies `--apply`.
 +
-See also INCOMPATIBLE OPTIONS below.
+See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
 
 --no-ff::
 --force-rebase::
@@ -443,7 +445,7 @@ If your branch was based on `<upstream>` but `<upstream>` was rewound and
 your branch contains commits which were dropped, this option can be used
 with `--keep-base` in order to drop those commits from your branch.
 +
-See also INCOMPATIBLE OPTIONS below.
+See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
 
 --ignore-whitespace::
 	Ignore whitespace differences when trying to reconcile
@@ -468,7 +470,7 @@ merge backend;;
 	(see linkgit:git-apply[1]) that applies the patch.
 	Implies `--apply`.
 +
-See also INCOMPATIBLE OPTIONS below.
+See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
 
 --committer-date-is-author-date::
 	Instead of using the current time as the committer date, use
@@ -488,14 +490,14 @@ applying (in terms of the author date).
 	the current time as the	author date of the rebased commit.  This
 	option implies `--force-rebase`.
 +
-See also INCOMPATIBLE OPTIONS below.
+See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
 
 --signoff::
 	Add a `Signed-off-by` trailer to all the rebased commits. Note
 	that if `--interactive` is given then only commits marked to be
 	picked, edited or reworded will have the trailer added.
 +
-See also INCOMPATIBLE OPTIONS below.
+See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
 
 --trailer=<trailer>::
 	Append the given trailer to every rebased commit message, processed
@@ -508,13 +510,13 @@ See also INCOMPATIBLE OPTIONS below.
 --interactive::
 	Make a list of the commits which are about to be rebased.  Let the
 	user edit that list before rebasing.  This mode can also be used to
-	split commits (see SPLITTING COMMITS below).
+	split commits (see <<SPLITTING_COMMITS,SPLITTING COMMITS>> below).
 +
 The commit list format can be changed by setting the configuration option
 rebase.instructionFormat.  A customized instruction format will automatically
 have the commit hash prepended to the format.
 +
-See also INCOMPATIBLE OPTIONS below.
+See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
 
 -r::
 --rebase-merges[=(rebase-cousins|no-rebase-cousins)]::
@@ -542,7 +544,8 @@ It is currently only possible to recreate the merge commits using the
 `ort` merge strategy; different merge strategies can be used only via
 explicit `exec git merge -s <strategy> [...]` commands.
 +
-See also REBASING MERGES and INCOMPATIBLE OPTIONS below.
+See also <<REBASING_MERGES,REBASING MERGES>> and
+<<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
 
 -x <cmd>::
 --exec <cmd>::
@@ -567,14 +570,14 @@ squash/fixup series.
 This uses the `--interactive` machinery internally, but it can be run
 without an explicit `--interactive`.
 +
-See also INCOMPATIBLE OPTIONS below.
+See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
 
 --root::
 	Rebase all commits reachable from `<branch>`, instead of
 	limiting them with an `<upstream>`.  This allows you to rebase
 	the root commit(s) on a branch.
 +
-See also INCOMPATIBLE OPTIONS below.
+See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
 
 --autosquash::
 --no-autosquash::
@@ -600,7 +603,7 @@ Setting configuration variable `rebase.autoSquash` to true enables
 auto-squashing by default for interactive rebase.  The `--no-autosquash`
 option can be used to override that setting.
 +
-See also INCOMPATIBLE OPTIONS below.
+See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
 
 --autostash::
 --no-autostash::
@@ -617,8 +620,9 @@ See also INCOMPATIBLE OPTIONS below.
 +
 This option applies once a rebase is started. It is preserved for the whole
 rebase based on, in order, the command line option provided to the initial `git
-rebase`, the `rebase.rescheduleFailedExec` configuration (see
-linkgit:git-config[1] or "CONFIGURATION" below), or it defaults to false.
+rebase`, the `rebase.rescheduleFailedExec` configuration
+(see linkgit:git-config[1] or <<CONFIGURATION,"CONFIGURATION">> below),
+or it defaults to false.
 +
 Recording this option for the whole rebase is a convenience feature. Otherwise
 an explicit `--no-reschedule-failed-exec` at the start would be overridden by
@@ -635,8 +639,9 @@ rebase --continue` is invoked. Currently, you cannot pass
 If the configuration variable `rebase.updateRefs` is set, then this option
 can be used to override and disable this setting.
 +
-See also INCOMPATIBLE OPTIONS below.
+See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
 
+[[INCOMPATIBLE_OPTIONS]]
 INCOMPATIBLE OPTIONS
 --------------------
 
@@ -813,7 +818,8 @@ NOTES
 -----
 
 You should understand the implications of using `git rebase` on a
-repository that you share.  See also RECOVERING FROM UPSTREAM REBASE
+repository that you share.
+See also <<RECOVERING_FROM_UPSTREAM_REBASE,RECOVERING FROM UPSTREAM REBASE>>
 below.
 
 When the rebase is run, it will first execute a `pre-rebase` hook if one
@@ -823,6 +829,7 @@ for an example.
 
 Upon completion, `<branch>` will be the current branch.
 
+[[INTERACTIVE_MODE]]
 INTERACTIVE MODE
 ----------------
 
@@ -978,6 +985,7 @@ pick f4593f9 four
 exec make test
 --------------------
 
+[[SPLITTING_COMMITS]]
 SPLITTING COMMITS
 -----------------
 
@@ -1013,6 +1021,7 @@ consistent (they compile, pass the testsuite, etc.) you should use
 after each commit, test, and amend the commit if fixes are necessary.
 
 
+[[RECOVERING_FROM_UPSTREAM_REBASE]]
 RECOVERING FROM UPSTREAM REBASE
 -------------------------------
 
@@ -1138,6 +1147,7 @@ The ripple effect of a "hard case" recovery is especially bad:
 'everyone' downstream from 'topic' will now have to perform a "hard
 case" recovery too!
 
+[[REBASING_MERGES]]
 REBASING MERGES
 ---------------
 
@@ -1276,6 +1286,7 @@ merge tlsv1.3
 merge cmake
 ------------
 
+[[CONFIGURATION]]
 CONFIGURATION
 -------------
 
diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index 58b4c0c470..f3ac875bb7 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -20,7 +20,7 @@ the working tree and the index untouched. By default, updates the
 relevant references using an atomic transaction (all refs update or
 none). Use `--ref-action=print` to avoid automatic ref updates and
 instead get update commands that can be piped to `git update-ref --stdin`
-(see the <<output,OUTPUT>> section below).
+(see the <<OUTPUT,OUTPUT>> section below).
 
 THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
 
@@ -118,7 +118,7 @@ behavior of git-rebase(1)'s `--no-rebase-merges` option.)
 :git-replay: 1
 include::rev-list-options.adoc[]
 
-[[output]]
+[[OUTPUT]]
 OUTPUT
 ------
 
diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index ed7d80c690..cb8c1e7292 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -22,8 +22,8 @@ COMMANDS
 --------
 `info [--format=(lines|nul) | -z] [--all | <key>...]`::
 	Retrieve metadata-related information about the current repository. Only
-	the requested data will be returned based on their keys (see "INFO KEYS"
-	section below).
+	the requested data will be returned based on their keys
+	(see <<INFO_KEYS,"INFO KEYS">> section below).
 +
 The values are returned in the same order in which their respective keys were
 requested. The `--all` flag requests the values for all the available keys.
@@ -89,6 +89,7 @@ supported:
 +
 `-z` is an alias for `--format=nul`.
 
+[[INFO_KEYS]]
 INFO KEYS
 ---------
 In order to obtain a set of values from `git repo info`, you should provide
diff --git a/Documentation/git-rev-parse.adoc b/Documentation/git-rev-parse.adoc
index 5398691f3f..a6d4289e28 100644
--- a/Documentation/git-rev-parse.adoc
+++ b/Documentation/git-rev-parse.adoc
@@ -38,12 +38,13 @@ Operation Modes
 Each of these options must appear first on the command line.
 
 --parseopt::
-	Use 'git rev-parse' in option parsing mode (see PARSEOPT section below).
+	Use 'git rev-parse' in option parsing mode
+	(see <<PARSEOPT,PARSEOPT>> section below).
 	The command in this mode can be used outside a repository or
 	a working tree controlled by a repository.
 
 --sq-quote::
-	Use 'git rev-parse' in shell quoting mode (see SQ-QUOTE
+	Use 'git rev-parse' in shell quoting mode (see <<SQ_QUOTE,SQ-QUOTE>>
 	section below). In contrast to the `--sq` option below, this
 	mode only does quoting. Nothing else is done to command input.
 	The command in this mode can be used outside a repository or
@@ -354,6 +355,7 @@ Other Options
 
 include::revisions.adoc[]
 
+[[PARSEOPT]]
 PARSEOPT
 --------
 
@@ -460,6 +462,7 @@ An option group Header
     -C[...]               option C with an optional argument
 ------------
 
+[[SQ_QUOTE]]
 SQ-QUOTE
 --------
 
diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
index 5c9ab39944..4a5e0c359f 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -50,7 +50,7 @@ Composing
 
 `--annotate`::
 	Review and edit each patch you're about to send. Default is the value
-	of `sendemail.annotate`. See the CONFIGURATION section for
+	of `sendemail.annotate`. See the <<CONFIGURATION,CONFIGURATION>> section for
 	`sendemail.multiEdit`.
 
 `--bcc=<address>,...`::
@@ -78,7 +78,7 @@ removed.
 +
 Missing `From` or `In-Reply-To` headers will be prompted for.
 +
-See the CONFIGURATION section for `sendemail.multiEdit`.
+See the <<CONFIGURATION,CONFIGURATION>> section for `sendemail.multiEdit`.
 
 `--from=<address>`::
 	Specify the sender of the emails.  If not specified on the command line,
@@ -559,6 +559,7 @@ Information
 	address to standard output, one per line. See `sendemail.aliasFile`
 	for more information about aliases.
 
+[[CONFIGURATION]]
 CONFIGURATION
 -------------
 
diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
index fc6a9a008c..d6e8c4144c 100644
--- a/Documentation/git-stash.adoc
+++ b/Documentation/git-stash.adoc
@@ -133,7 +133,7 @@ with no conflicts.
 `clear`::
 	Remove all the stash entries. Note that those entries will then
 	be subject to pruning, and may be impossible to recover (see
-	'EXAMPLES' below for a possible strategy).
+	<<EXAMPLES,'EXAMPLES'>> below for a possible strategy).
 
 `drop [-q | --quiet] [<stash>]`::
 	Remove a single stash entry from the list of stash entries.
@@ -315,6 +315,7 @@ of the index, and `W` is a commit that records the state of the working
 tree.
 
 
+[[EXAMPLES]]
 EXAMPLES
 --------
 
diff --git a/Documentation/git-svn.adoc b/Documentation/git-svn.adoc
index 2a7fa60465..baaf3bff4e 100644
--- a/Documentation/git-svn.adoc
+++ b/Documentation/git-svn.adoc
@@ -126,7 +126,7 @@ your Perl's Getopt::Long is < v2.37).
 	command-line argument.
 +
 This automatically updates the rev_map if needed (see
-'$GIT_DIR/svn/\**/.rev_map.*' in the FILES section below for details).
+'$GIT_DIR/svn/\**/.rev_map.*' in the <<FILES,FILES>> section below for details).
 
 --localtime;;
 	Store Git commit times in the local time zone instead of UTC.  This
@@ -239,7 +239,7 @@ Like 'git rebase'; this requires that the working tree be clean
 and have no uncommitted changes.
 +
 This automatically updates the rev_map if needed (see
-'$GIT_DIR/svn/\**/.rev_map.*' in the FILES section below for details).
+'$GIT_DIR/svn/\**/.rev_map.*' in the <<FILES,FILES>> section below for details).
 
 -l;;
 --local;;
@@ -524,7 +524,7 @@ This will set the property 'svn:keywords' to 'FreeBSD=%H' for the file
 	way to repair the repo is to use 'reset'.
 +
 Only the rev_map and refs/remotes/git-svn are changed (see
-'$GIT_DIR/svn/\**/.rev_map.*' in the FILES section below for details).
+'$GIT_DIR/svn/\**/.rev_map.*' in the <<FILES,FILES>> section below for details).
 Follow 'reset' with a 'fetch' and then 'git reset' or 'git rebase' to
 move local branches onto the new tree.
 
@@ -946,7 +946,7 @@ copy history (including branches and tags) for repositories adopting a
 standard layout, it cannot yet represent merge history that happened
 inside git back upstream to SVN users.  Therefore it is advised that
 users keep history as linear as possible inside Git to ease
-compatibility with SVN (see the CAVEATS section below).
+compatibility with SVN (see the <<CAVEATS,CAVEATS>> section below).
 
 HANDLING OF SVN BRANCHES
 ------------------------
@@ -994,6 +994,7 @@ to r.199 (one containing trunk/, one containing trunk/sub/). Finally,
 it will create a branch 'sub@200' pointing to the new parent commit of
 branch 'sub' (i.e. the commit for r.200 and trunk/sub/).
 
+[[CAVEATS]]
 CAVEATS
 -------
 
@@ -1135,6 +1136,7 @@ or tag has appeared. If the subset of branches or tags is changed after
 fetching, then $GIT_DIR/svn/.metadata must be manually edited to remove
 (or reset) branches-maxRev and/or tags-maxRev as appropriate.
 
+[[FILES]]
 FILES
 -----
 $GIT_DIR/svn/\**/.rev_map.*::
diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
index 32787eacc3..e6e77252ab 100644
--- a/Documentation/git-worktree.adoc
+++ b/Documentation/git-worktree.adoc
@@ -50,8 +50,8 @@ at the same commit as the current branch.
 
 If a working tree is deleted without using `git worktree remove`, then
 its associated administrative files, which reside in the repository
-(see "DETAILS" below), will eventually be removed automatically (see
-`gc.worktreePruneExpire` in linkgit:git-config[1]), or you can run
+(see <<DETAILS,"DETAILS">> below), will eventually be removed automatically
+(see `gc.worktreePruneExpire` in linkgit:git-config[1]), or you can run
 `git worktree prune` in the main or any linked worktree to clean up any
 stale administrative files.
 
@@ -360,6 +360,7 @@ share to all worktrees:
 See the documentation of `extensions.worktreeConfig` in
 linkgit:git-config[1] for more details.
 
+[[DETAILS]]
 DETAILS
 -------
 Each linked worktree has a private sub-directory in the repository's
diff --git a/Documentation/gitremote-helpers.adoc b/Documentation/gitremote-helpers.adoc
index 39cdece16e..4d794f32ad 100644
--- a/Documentation/gitremote-helpers.adoc
+++ b/Documentation/gitremote-helpers.adoc
@@ -86,7 +86,7 @@ Capabilities
 
 Each remote helper is expected to support only a subset of commands.
 The operations a helper supports are declared to Git in the response
-to the `capabilities` command (see COMMANDS, below).
+to the `capabilities` command (see <<COMMANDS,COMMANDS>>, below).
 
 In the following, we list all defined capabilities and for
 each we list which commands a helper with that capability
@@ -124,7 +124,7 @@ Supported commands: 'list for-push', 'export'.
 
 If a helper advertises 'connect', Git will use it if possible and
 fall back to another capability if the helper requests so when
-connecting (see the 'connect' command under COMMANDS).
+connecting (see the 'connect' command under <<COMMANDS,COMMANDS>>).
 When choosing between 'push' and 'export', Git prefers 'push'.
 Other frontends may have some other order of preference.
 
@@ -173,7 +173,7 @@ Supported commands: 'list', 'import'.
 
 If a helper advertises 'connect', Git will use it if possible and
 fall back to another capability if the helper requests so when
-connecting (see the 'connect' command under COMMANDS).
+connecting (see the 'connect' command under <<COMMANDS,COMMANDS>>).
 When choosing between 'fetch' and 'import', Git prefers 'fetch'.
 Other frontends may have some other order of preference.
 
@@ -246,6 +246,7 @@ the remote repository.
 	side using an explicit hash algorithm extension.
 
 
+[[COMMANDS]]
 COMMANDS
 --------
 
@@ -269,8 +270,10 @@ Support for this command is mandatory.
 	unrecognized attributes are ignored. The list ends with a
 	blank line.
 +
-See REF LIST ATTRIBUTES for a list of currently defined attributes.
-See REF LIST KEYWORDS for a list of currently defined keywords.
+See <<REF_LIST_ATTRIBUTES,REF LIST ATTRIBUTES>> for a list of currently
+defined attributes.
+See <<REF_LIST_KEYWORDS,REF LIST KEYWORDS>> for a list of currently
+defined keywords.
 +
 Supported if the helper has the "fetch" or "import" capability.
 
@@ -435,6 +438,7 @@ completing a valid response for the current command.
 Additional commands may be supported, as may be determined from
 capabilities reported by the helper.
 
+[[REF_LIST_ATTRIBUTES]]
 REF LIST ATTRIBUTES
 -------------------
 
@@ -446,6 +450,7 @@ attributes are defined.
 	This ref is unchanged since the last import or fetch, although
 	the helper cannot necessarily determine what value that produced.
 
+[[REF_LIST_KEYWORDS]]
 REF LIST KEYWORDS
 -----------------
 
diff --git a/Documentation/gitsubmodules.adoc b/Documentation/gitsubmodules.adoc
index 2082296199..8e8165637b 100644
--- a/Documentation/gitsubmodules.adoc
+++ b/Documentation/gitsubmodules.adoc
@@ -21,7 +21,8 @@ A submodule is a repository embedded inside another repository.
 The submodule has its own history; the repository it is embedded
 in is called a superproject.
 
-On the filesystem, a submodule usually (but not always - see FORMS below)
+On the filesystem, a submodule usually
+(but not always - see <<FORMS,FORMS>> below)
 consists of (i) a Git directory located under the `$GIT_DIR/modules/`
 directory of its superproject, (ii) a working directory inside the
 superproject's working directory, and a `.git` file at the root of
@@ -102,8 +103,8 @@ remotes are configured in the submodule as usual in the `$GIT_DIR/config`
 file.
 
  * The configuration file `$GIT_DIR/config` in the superproject.
-   Git only recurses into active submodules (see "ACTIVE SUBMODULES"
-   section below).
+   Git only recurses into active submodules
+   (see <<ACTIVE_SUBMODULES,"ACTIVE SUBMODULES">> section below).
 +
 If the submodule is not yet initialized, then the configuration
 inside the submodule does not exist yet, so where to
@@ -122,6 +123,7 @@ If the submodule has never been initialized, this is the only place
 where submodule configuration is found. It serves as the last fallback
 to specify where to obtain the submodule from.
 
+[[FORMS]]
 FORMS
 -----
 
@@ -165,6 +167,7 @@ from another repository.
 To completely remove a submodule, manually delete
 `$GIT_DIR/modules/<name>/`.
 
+[[ACTIVE_SUBMODULES]]
 ACTIVE SUBMODULES
 -----------------
 
diff --git a/Documentation/gitworkflows.adoc b/Documentation/gitworkflows.adoc
index 59305265c5..4a4aea9fb4 100644
--- a/Documentation/gitworkflows.adoc
+++ b/Documentation/gitworkflows.adoc
@@ -245,8 +245,9 @@ tag to the tip of 'master' indicating the release version:
 `git tag -s -m "Git X.Y.Z" vX.Y.Z master`
 =====================================
 
-You need to push the new tag to a public Git server (see
-"DISTRIBUTED WORKFLOWS" below). This makes the tag available to
+You need to push the new tag to a public Git server
+(see <<DISTRIBUTED_WORKFLOWS,"DISTRIBUTED WORKFLOWS">> below).
+This makes the tag available to
 others tracking your project. The push could also trigger a
 post-update hook to perform release-related items such as building
 release tarballs and preformatted documentation pages.
@@ -324,6 +325,7 @@ announcement is not necessary since 'seen' is a throw-away branch, as
 described above.
 
 
+[[DISTRIBUTED_WORKFLOWS]]
 DISTRIBUTED WORKFLOWS
 ---------------------
 
diff --git a/Documentation/howto/revert-a-faulty-merge.adoc b/Documentation/howto/revert-a-faulty-merge.adoc
index 19f59cc888..fc9a330e9c 100644
--- a/Documentation/howto/revert-a-faulty-merge.adoc
+++ b/Documentation/howto/revert-a-faulty-merge.adoc
@@ -146,8 +146,8 @@ different resolution strategies:
    revert of a merge was rebuilt from scratch (i.e. rebasing and fixing,
    as you seem to have interpreted), then re-merging the result without
    doing anything else fancy would be the right thing to do.
-   (See the ADDENDUM below for how to rebuild a branch from scratch
-   without changing its original branching-off point.)
+   (See the <<ADDENDUM,ADDENDUM>> below for how to rebuild a branch
+   from scratch without changing its original branching-off point.)
 
 However, there are things to keep in mind when reverting a merge (and
 reverting such a revert).
@@ -184,6 +184,7 @@ ready yet, and I really need to undo _all_ of the merge"). So then you
 really should revert the merge, but when you want to re-do the merge, you
 now need to do it by reverting the revert.
 
+[[ADDENDUM]]
 ADDENDUM
 
 Sometimes you have to rewrite one of a topic branch's commits *and* you can't
diff --git a/Documentation/revisions.adoc b/Documentation/revisions.adoc
index 3fbfbd3d5f..3bb6dc85b6 100644
--- a/Documentation/revisions.adoc
+++ b/Documentation/revisions.adoc
@@ -1,3 +1,4 @@
+[[SPECIFYING_REVISIONS]]
 SPECIFYING REVISIONS
 --------------------
 
@@ -300,7 +301,8 @@ Dotted Range Notations
 The '..' (two-dot) Range Notation::
  The '{caret}r1 r2' set operation appears so often that there is a shorthand
  for it.  When you have two commits 'r1' and 'r2' (named according
- to the syntax explained in SPECIFYING REVISIONS above), you can ask
+ to the syntax explained in
+<<SPECIFYING_REVISIONS,SPECIFYING REVISIONS>> above), you can ask
  for commits that are reachable from r2 excluding those that are reachable
  from r1 by '{caret}r1 r2' and it can be written as 'r1..r2'.
 

base-commit: 3bc0341126508f78f5869cbfc0005e987efdf0c7
-- 
gitgitgadget
