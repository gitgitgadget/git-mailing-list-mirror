Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD36B1DC98B
	for <git@vger.kernel.org>; Sat, 12 Apr 2025 12:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744460459; cv=none; b=uSrRD/ZTJ4Ad9Jy/CthYvo82bavgXENHfuUbwiM7wQJ6B6sGUVZ4OrGFuiBTE70fCR3LjvuZsuMylHGi5PvFx6WafokU2euPJQf1CHdCbZeBqzkF3UpH1GUAoBkiKLkA37vGJ9xC4SfkA62p3PreucRBwy/vIDqT0g75YID+xas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744460459; c=relaxed/simple;
	bh=kgd3FnPKqcGOVrBfmitKmUn72IOTMS3iAB0VCZuwJ34=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=Y+iwM3pWjfJukUXY/p9EeO4lxMH6hb6vElMLMtrs7pGJysoBus93ieWTZ7glGdnmnwcVavozJGFr9QvQA6289IaxkSMCeGrJlAWq5R3augpnxKfAm/5r1+nCRtJKhWYZyJLNJ2jJXN6PDRsXl9fE9ej9R0aUVIjS37FhY8fjLMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hctw2dO7; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hctw2dO7"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39c0e0bc733so2361472f8f.1
        for <git@vger.kernel.org>; Sat, 12 Apr 2025 05:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744460456; x=1745065256; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fScNan+Ond41LaX1EqUvHLJhdrFe2S3eahrTPKEZEUs=;
        b=Hctw2dO7fo+QCjw7tC4ydAM5hc+MjJ1iCGvxwng7gwJoqhy0a4FblSxLKsLcfzChEK
         1H5/sA9oUVj5jCiKJPZvY4aOcsLQuuNFnyTGWHT89S1iWsDyrpSLl+7s3R7s1kOdfXTm
         X3O8LhSFF76tlIViPaNlRDjVgTK5VPM7WigrBO+4t8raFg1n1We81vJ9D//Hdg05ULSX
         J6yBFCkKh8y4Rx7y0ljhLykHW3WvcXleSArOsEEzq2LLip21FsQPHSp1lc9KNWGs4wd1
         yr24p86b/7DJjkmPItab2kAib8ocyzZ7KeYhMPskQ0eDpdgY58gwtTJv/lToLDjMvFoI
         efHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744460456; x=1745065256;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fScNan+Ond41LaX1EqUvHLJhdrFe2S3eahrTPKEZEUs=;
        b=Rv5vFVI61XCS3LPe9UPs8TYB3uOXCs8BD8sTUfkvAEHkphPpxUcgIma+8lu4t6t2LF
         V5BcTXfK5nTYPUNw0CAQY3sbK+VLPelbyr+cwu103X5S/l1RwnR6RNj1YkjD7G64O6Ox
         D0Ip/V2BHtDW9GhNGhr6tfD7T32NATjuKuDhzpnxjfxmcazMc5TXqAB9iqenDB3Nyv3j
         3Yh9ghKRxyccAfBJxoYct1YLlbDbY6fBb64Uue2QdqYQVN/XP9wEwKHKjeJfrKuIrM7c
         vxl1KPQAJFKfXA4fE4re58Ar75TlVZXrzs+N4JMYBtnlrh4GTwLPwnDod7bC7C/d67+N
         plTA==
X-Gm-Message-State: AOJu0YxYCNvyZduWVpFdljl2rYl4mv71D17P7IWoR70IYMYiDiF0qWKq
	YV5p23oBHNdCmIXkYKc7VANMMvbAh1zV674t94zHMMk/ykkY4cxE09dYlA==
X-Gm-Gg: ASbGncvfD+yIflOLceUd9nhjMSAxCoBFz9VVBMw1zzKqReOxf6Pt4171PWAqiFARN+z
	66lHWg1nWZge5QoNMhI6DztdAU9XfOVNMqJEAMcKdSNBzcyUHQ9tNxIGZqxtcVAIrRhrDXYaaly
	5wTynVscubGDCCCukZ9mt68STj94r0Wqi2idCiNWrCNug1vrW91KwB+SeVJJnha0ydCHYl6HmQ3
	ns8OxoAgLNgnPdM8a4h09CZ/LN3tXOKuO0bHyzKGJ2JVeF8C9lC+Q0bEOgynDgcIlsZZlFlTVPY
	TnLdLw+yxAk9aZOR1oFWxxeiblxLzg1EJ6y4Q0kOrQ==
X-Google-Smtp-Source: AGHT+IHySarSIO4dEoOfnwMMdCujsMyBCjt45mOeuNg0O7yTgOpIlZ3GXOONoOSSc+hqm6wRdBgUcw==
X-Received: by 2002:a05:6000:420e:b0:39c:1f10:c74c with SMTP id ffacd0b85a97d-39eaaea801bmr5284829f8f.35.1744460455405;
        Sat, 12 Apr 2025 05:20:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf44571fsm4883257f8f.84.2025.04.12.05.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 05:20:54 -0700 (PDT)
Message-Id: <6814e98f71d60d72664e7419ba79b7b3b5bb39bd.1744460450.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1896.v2.git.1744460450.gitgitgadget@gmail.com>
References: <pull.1896.git.1743354964.gitgitgadget@gmail.com>
	<pull.1896.v2.git.1744460450.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 12 Apr 2025 12:20:46 +0000
Subject: [PATCH v2 3/7] doc: convert git-rm to new documentation format
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
Cc: Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

- Switch the synopsis to a synopsis block which will automatically
  format placeholders in italics and keywords in monospace
- Use _<placeholder>_ instead of <placeholder> in the description
- Use `backticks` for keywords and more complex option
descriptions. The new rendering engine will apply synopsis rules to
these spans.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-rm.adoc | 56 +++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/Documentation/git-rm.adoc b/Documentation/git-rm.adoc
index 363a26934f5..b5ead867963 100644
--- a/Documentation/git-rm.adoc
+++ b/Documentation/git-rm.adoc
@@ -7,10 +7,10 @@ git-rm - Remove files from the working tree and from the index
 
 SYNOPSIS
 --------
-[verse]
-'git rm' [-f | --force] [-n] [-r] [--cached] [--ignore-unmatch]
-	  [--quiet] [--pathspec-from-file=<file> [--pathspec-file-nul]]
-	  [--] [<pathspec>...]
+[synopsis]
+git rm [-f | --force] [-n] [-r] [--cached] [--ignore-unmatch]
+       [--quiet] [--pathspec-from-file=<file> [--pathspec-file-nul]]
+       [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -30,7 +30,7 @@ sparse-checkouts are in use (see linkgit:git-sparse-checkout[1]),
 
 OPTIONS
 -------
-<pathspec>...::
+`<pathspec>...`::
 	Files to remove.  A leading directory name (e.g. `dir` to remove
 	`dir/file1` and `dir/file2`) can be given to remove all files in
 	the directory, and recursively all sub-directories, but this
@@ -43,57 +43,57 @@ directories `d` and `d2`, there is a difference between using
 `git rm 'd*'` and `git rm 'd/*'`, as the former will also remove all
 of directory `d2`.
 +
-For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
+For more details, see the _<pathspec>_ entry in linkgit:gitglossary[7].
 
--f::
---force::
+`-f`::
+`--force`::
 	Override the up-to-date check.
 
--n::
---dry-run::
+`-n`::
+`--dry-run`::
 	Don't actually remove any file(s).  Instead, just show
 	if they exist in the index and would otherwise be removed
 	by the command.
 
--r::
+`-r`::
         Allow recursive removal when a leading directory name is
         given.
 
-\--::
+`--`::
 	This option can be used to separate command-line options from
 	the list of files, (useful when filenames might be mistaken
 	for command-line options).
 
---cached::
+`--cached`::
 	Use this option to unstage and remove paths only from the index.
 	Working tree files, whether modified or not, will be
 	left alone.
 
---ignore-unmatch::
+`--ignore-unmatch`::
 	Exit with a zero status even if no files matched.
 
---sparse::
+`--sparse`::
 	Allow updating index entries outside of the sparse-checkout cone.
 	Normally, `git rm` refuses to update index entries whose paths do
 	not fit within the sparse-checkout cone. See
 	linkgit:git-sparse-checkout[1] for more.
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	`git rm` normally outputs one line (in the form of an `rm` command)
 	for each file removed. This option suppresses that output.
 
---pathspec-from-file=<file>::
-	Pathspec is passed in `<file>` instead of commandline args. If
-	`<file>` is exactly `-` then standard input is used. Pathspec
-	elements are separated by LF or CR/LF. Pathspec elements can be
+`--pathspec-from-file=<file>`::
+	Pathspec is passed in _<file>_ instead of  args. If
+	_<file>_ is exactly `-` then standard input is used. Pathspec
+	elements are separated by _LF_ or _CR_/_LF_. Pathspec elements can be
 	quoted as explained for the configuration variable `core.quotePath`
 	(see linkgit:git-config[1]). See also `--pathspec-file-nul` and
 	global `--literal-pathspecs`.
 
---pathspec-file-nul::
+`--pathspec-file-nul`::
 	Only meaningful with `--pathspec-from-file`. Pathspec elements are
-	separated with NUL character and all other characters are taken
+	separated with _NUL_ character and all other characters are taken
 	literally (including newlines and quotes).
 
 
@@ -153,15 +153,15 @@ SUBMODULES
 ----------
 Only submodules using a gitfile (which means they were cloned
 with a Git version 1.7.8 or newer) will be removed from the work
-tree, as their repository lives inside the .git directory of the
+tree, as their repository lives inside the `.git` directory of the
 superproject. If a submodule (or one of those nested inside it)
-still uses a .git directory, `git rm` will move the submodules
+still uses a `.git` directory, `git rm` moves the submodules
 git directory into the superprojects git directory to protect
-the submodule's history. If it exists the submodule.<name> section
+the submodule's history. If it exists the `submodule.<name>` section
 in the linkgit:gitmodules[5] file will also be removed and that file
-will be staged (unless --cached or -n are used).
+will be staged (unless `--cached` or `-n` are used).
 
-A submodule is considered up to date when the HEAD is the same as
+A submodule is considered up to date when the `HEAD` is the same as
 recorded in the index, no tracked files are modified and no untracked
 files that aren't ignored are present in the submodule's work tree.
 Ignored files are deemed expendable and won't stop a submodule's work
-- 
gitgitgadget

