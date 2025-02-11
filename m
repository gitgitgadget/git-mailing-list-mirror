Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0E81F1531
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 08:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739263866; cv=none; b=dIhpyqKSRjpgyfZLfVEXm4NEx5S7ouvjzJ9gOj4FJEPogFbCGYbRijkxzd+hOE7poE3O/SXk0+79tWmIdXGmIZNgEtqnm2DVufnRj5C/G3ylV4nvwp/lnHxkrdKieQdjz2qtBCrF/LIW2Chq/90VsaQ4BFekIfKJfkx1qV7HAAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739263866; c=relaxed/simple;
	bh=ZsWjGimXpmQn9cPBe7u+bT9hy9pA5OSNwTrDWZ4GmKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hEZcFduaf9EIESCMD9jt41Fm9mIK8gF5GJGVLjmSZ9aculH2+2WJkRZDC+ugjEyqn0vPefc5RIJWP9aXngVZ7AAazfPG6kBdpFQ7LhjD302yRbr57cxk4WSt21yjoeD7wBD817fN9W3PfiQr75VMR3fT15TD++MYs2vwqIcpIMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBGfy5Sm; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBGfy5Sm"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2f42992f608so8033805a91.0
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 00:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739263864; x=1739868664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDX88l6a351yJl4J67+MLD3V7wGrx+WJItQnoPZae5s=;
        b=KBGfy5SmKEJtAGNzDb2WeMbvSPQqIDFe0cqs9oMuwm5V8Y00fW9vBmrIdEJl4C1TX9
         UTNP0GBeIAjAM2TA0DS6zV5ZyGnUlqTvFi3BujFEkYiS5t/vqa1YoHawDVCrkB/cA+VO
         T+mN4TmEVC8xo1WLB+b91onFhWC8Xr/Bk1znlMOVdxinGhnQdAcnEKFdwGB8GnCwOe6c
         2p2YGf9dTFqeJP7Q5GwaByvKsgR3OAhIB9jSgtUUZ74UhaAzeSVipsz5Fcetf1vWkOlb
         jvkjD4qQQdQsef3zz4MyTtUGeOcKVTivcQmew4prPysWeiKsU5IYFBkyi22OhMzSRriY
         2RFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739263864; x=1739868664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDX88l6a351yJl4J67+MLD3V7wGrx+WJItQnoPZae5s=;
        b=Qp/GGvt1QSgtjiraicpJLNjH/rew/mQKTn28GE1kt5xjODov4UlNAHSzLOiC3o8f3T
         RQ4dytzB/RQLMfghX8awjCi+ViGEzxbWiok8XIAMNWtmxGfPkSG+ODgnZ7wK9nxzyH0H
         DU37cqzEaTNJIes0i38q+JMiSuCoyHDRBQXixe31/XA0i+Fmy293P23d5ETXObc/sIJ/
         x1QVWL8KwAfOgtQ7VqeOA7ELaE61mYq2e+1PTzbtIx3EOR1UFqf2LTxt7iDlJnq4Xwo0
         B6Uh4bTGCSQNVIwK5she+fCy6dJKknCxSLAYoy6WMJ6dmaxS0xveE0PEKGfn0lAJkuC8
         sRGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKSPxZIEzkNm/XLGSolcEtDg3w/oVTb8/ReXQyNdDliNJK0hM6/twYl1wZUrRL4uYPPmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRZZiJSFl9X6c9sxDOn5gosY7+GN4oLBb5dATMAOowhzVbso7f
	48gjSSvh7irPc168fFuLqEHAs3PyWQmK8jEX98e5GLNfVWYgSE0f
X-Gm-Gg: ASbGncvClba7jwtnfc4HnjALOI38El9rcMggKsl1WtxJ7pQ8ARM8wKKnEjAIxSED/Vu
	apCCHc194kLQXXt93fpAFWzhtV15U/oYPWt19/EJtbxxfna/r6s/YsLOWgF+s8gRmzDlr1dJwdc
	EYpDlkVqpenMjNMk1gECSW3RP6ZoNFXVnTVJvao7HBCy/VZ9cuCoTEJ+w8th98qSCuzl0k4VVIS
	sq2sbstIGLq9UHjx70qFeIQSiXfSlN85hobpzEI+u+TbfHFEM9VDm5sjZXjTNQJe8N1awoDioHv
	tlRI0r2O/vxlS8C7mh6dK0kNPSGZhr5/UKd/aj0=
X-Google-Smtp-Source: AGHT+IGtztw2BiPIDW6cnXq6xkfl6L7Z8UhhhYhU+uoTm8dgJibI3vSry5Y+/WcwDk0CEhxwNJhT2w==
X-Received: by 2002:a17:90b:1d52:b0:2ee:aa28:79aa with SMTP id 98e67ed59e1d1-2fa23f423e4mr21066957a91.6.1739263864284;
        Tue, 11 Feb 2025 00:51:04 -0800 (PST)
Received: from gamma.hsd1.ca.comcast.net ([2601:647:5580:5760:3858:1e16:caad:e1d4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09a46534sm10201701a91.21.2025.02.11.00.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 00:51:03 -0800 (PST)
From: Illia Bobyr <illia.bobyr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Illia Bobyr <illia.bobyr@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH v4 10/10] diff: docs: Use --patch-{grep,modifies} over -G/-S
Date: Tue, 11 Feb 2025 00:50:22 -0800
Message-ID: <20250211085028.3923875-11-illia.bobyr@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250206014324.1839232-1-illia.bobyr@gmail.com>
References: <20250206014324.1839232-1-illia.bobyr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Long argument names are easier to read, compared to short ones.  So
while short arguments are great when you want to type a command quickly,
the documentation readability is improved if we use long argument names.

Note for reviewers:  All changes are just a replacement of `-G` with
`--patch-grep` and `-S` with `--patch-modifies`.  But as the text was
reformatted to fit the same width in a few places it might look like
there are more changes, if the diff is only line-wise and not word-wise.

The only an exception are changes in `gitdiffcore.adoc`, where I did
rephrase a sentence.  I've moved introduction of the short versions of
the `--patch-{grep,modifies}` into a subsequent paragraph.  The reason
is that I wanted to keep a note on the `-G` mnemonic, and it was awkward
if I would repeat the short definition twice over a span of two
paragraphs.
---
 Documentation/diff-options.adoc | 34 ++++++++++----------
 Documentation/git-blame.adoc    |  2 +-
 Documentation/gitdiffcore.adoc  | 55 +++++++++++++++++----------------
 3 files changed, 46 insertions(+), 45 deletions(-)

diff --git a/Documentation/diff-options.adoc b/Documentation/diff-options.adoc
index 07413d..c9f7c 100644
--- a/Documentation/diff-options.adoc
+++ b/Documentation/diff-options.adoc
@@ -658,8 +658,8 @@ renamed entries cannot appear if detection for those types is disabled.
 It is useful when you're looking for an exact block of code (like a
 struct), and want to know the history of that block since it first
 came into being: use the feature iteratively to feed the interesting
-block in the preimage back into `-S`, and keep going until you get the
-very first version of the block.
+block in the preimage back into `--patch-modifies`, and keep going until
+you get the very first version of the block.
 +
 Binary files are searched as well.
 
@@ -668,9 +668,9 @@ Binary files are searched as well.
 	Look for differences whose patch text contains added/removed
 	lines that match _<regex>_.
 +
-To illustrate the difference between `-S<regex>` `--pickaxe-regex` and
-`-G<regex>`, consider a commit with the following diff in the same
-file:
+To illustrate the difference between `--patch-modifies=<regex>
+--pickaxe-regex` and `--patch-grep=<regex>`, consider a commit with the
+following diff in the same file:
 +
 ----
 +    return frotz(nitfol, two->ptr, 1, 0);
@@ -678,9 +678,9 @@ file:
 -    hit = frotz(nitfol, mf2.ptr, 1, 0);
 ----
 +
-While `git log -G"frotz\(nitfol"` will show this commit, `git log
--S"frotz\(nitfol" --pickaxe-regex` will not (because the number of
-occurrences of that string did not change).
+While `git log --patch-grep="frotz\(nitfol"` will show this commit, `git
+log --patch-modifies="frotz\(nitfol" --pickaxe-regex` will not (because the
+number of occurrences of that string did not change).
 +
 Unless `--text` is supplied patches of binary files without a textconv
 filter will be ignored.
@@ -689,22 +689,22 @@ See the 'pickaxe' entry in linkgit:gitdiffcore[7] for more
 information.
 
 `--find-object=<object-id>`::
-	Look for differences that change the number of occurrences of
-	the specified object. Similar to `-S`, just the argument is different
-	in that it doesn't search for a specific string but for a specific
-	object id.
+	Look for differences that change the number of occurrences of the
+	specified object. Similar to `--patch-modifies`, just the argument
+	is different in that it doesn't search for a specific string but
+	for a specific object id.
 +
 The object can be a blob or a submodule commit. It implies the `-t` option in
 `git-log` to also find trees.
 
 `--pickaxe-all`::
-	When `-S` or `-G` finds a change, show all the changes in that
-	changeset, not just the files that contain the change
-	in _<string>_.
+	When `--patch-modifies` or `--patch-grep` finds a change, show all
+	the changes in that changeset, not just the files that contain the
+	change in _<string>_.
 
 `--pickaxe-regex`::
-	Treat the _<string>_ given to `-S` as an extended POSIX regular
-	expression to match.
+	Treat the _<string>_ given to `--patch-modifies` as an extended
+	POSIX regular expression to match.
 
 endif::git-format-patch[]
 
diff --git a/Documentation/git-blame.adoc b/Documentation/git-blame.adoc
index f75ed..10736a 100644
--- a/Documentation/git-blame.adoc
+++ b/Documentation/git-blame.adoc
@@ -41,7 +41,7 @@ a text string in the diff. A small example of the pickaxe interface
 that searches for `blame_usage`:
 
 -----------------------------------------------------------------------------
-$ git log --pretty=oneline -S'blame_usage'
+$ git log --pretty=oneline --patch-modifies='blame_usage'
 5040f17eba15504bad66b14a645bddd9b015ebb7 blame -S <ancestry-file>
 ea4c7f9bf69e781dd0cd88d2bccb2bf5cc15c9a7 git-blame: Make the output
 -----------------------------------------------------------------------------
diff --git a/Documentation/gitdiffcore.adoc b/Documentation/gitdiffcore.adoc
index e934b9..e7f98 100644
--- a/Documentation/gitdiffcore.adoc
+++ b/Documentation/gitdiffcore.adoc
@@ -245,33 +245,34 @@ diffcore-pickaxe: For Detecting Addition/Deletion of Specified String
 
 This transformation limits the set of filepairs to those that change
 specified strings between the preimage and the postimage in a certain
-way.  `--patch-modifies=<string>` (`-S<string>` for short) and
-`--patch-grep=<regex>` (`-G<regex>` for short) are used to specify
-different ways these strings are sought.
-
-`-S<string>` detects filepairs whose preimage and postimage
-have different number of occurrences of the specified _<string>_.
-By definition, it will not detect in-file moves.  Also, when a
-changeset moves a file wholesale without affecting the interesting
-string, diffcore-rename kicks in as usual, and `-S` omits the filepair
-(since the number of occurrences of that string didn't change in that
-rename-detected filepair).  When used with `--pickaxe-regex`, treat
-the _<string>_ as an extended POSIX regular expression to match,
-instead of a literal string.
-
-`-G<regex>` (mnemonic: grep) detects filepairs whose textual diff has
-an added or a deleted line that matches the given _<regex>_.  This
-means that it will detect in-file (or what rename-detection considers
-the same file) moves, which is noise.  The implementation runs diff
-twice and greps, and this can be quite expensive.  To speed things up,
-binary files without textconv filters will be ignored.
-
-When `-S` or `-G` are used without `--pickaxe-all`, only filepairs
-that match their respective criterion are kept in the output.  When
-`--pickaxe-all` is used, if even one filepair matches their respective
-criterion in a changeset, the entire changeset is kept.  This behavior
-is designed to make reviewing changes in the context of the whole
-changeset easier.
+way.  `--patch-modifies=<string>` and `--patch-grep=<regex>` are used
+to specify different ways these strings are sought.
+
+`--patch-modifies=<string>` (`-S<string>` for short) detects filepairs
+whose preimage and postimage have different number of occurrences of
+the specified _<string>_.  By definition, it will not detect in-file
+moves.  Also, when a changeset moves a file wholesale without
+affecting the interesting string, diffcore-rename kicks in as usual,
+and `--patch-modifies` omits the filepair (since the number of
+occurrences of that string didn't change in that rename-detected
+filepair).  When used with `--pickaxe-regex`, treat the _<string>_ as
+an extended POSIX regular expression to match, instead of a literal
+string.
+
+`--patch-grep=<regex>` (`-G<regex>` for short, mnemonic: grep) detects
+filepairs whose textual diff has an added or a deleted line that
+matches the given regular expression.  This means that it will detect
+in-file (or what rename-detection considers the same file) moves,
+which is noise.  The implementation runs diff twice and greps, and
+this can be quite expensive.  To speed things up, binary files without
+textconv filters will be ignored.
+
+When `--patch-modifies` or `--patch-grep` are used without
+`--pickaxe-all`, only filepairs that match their respective criterion
+are kept in the output.  When `--pickaxe-all` is used, if even one
+filepair matches their respective criterion in a changeset, the entire
+changeset is kept.  This behavior is designed to make reviewing
+changes in the context of the whole changeset easier.
 
 diffcore-order: For Sorting the Output Based on Filenames
 ---------------------------------------------------------
-- 
2.45.2

