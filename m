Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0C11E9B25
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 21:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740865654; cv=none; b=ZJ0TeFp+YEFhRpIYJf2RoStUu6b1EzSq8chBlhvCyllEe5UOoujnST044a/Qx2Fk5sDB6iETgKkF3SvOA8vT4S5n1greZgoo6e+3IddfXUpnvraerUdmubblpvHQuwoHt0DZK3WK8RN0jWoTQzOSOj9S3mOaY9CBbWVhX7yyoQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740865654; c=relaxed/simple;
	bh=QV07DhJIMHxtWRq1CGFNNT9rjGGofi0HiskOrHvY828=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CxgUNXKbw3TVKgsTMBXShsB+X5SvH/bYyTJP1YlRGW0A44rmcwKTDMPgyIz4CLHdvJsaGXSO5AnAjac2oLFefLVcOqqTr/yxNZ+ldome4tVIq4GIUDhp5/qT/ZIaHuK4MW8WtheTOpXM+6wglG7GnN0XwTUq46d778HmD8bxHAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRZBfuhO; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRZBfuhO"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4397e5d5d99so20747425e9.1
        for <git@vger.kernel.org>; Sat, 01 Mar 2025 13:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740865650; x=1741470450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0rEahlvEtGF93YYTHC3INBotz2Tk0t9NarOhMgL+pQ=;
        b=mRZBfuhOt5ptTPYjRUpfoTxvlK73eqW3IpEkGzuzhML6QhTvw/15rTqu/LmWVmvjBw
         D8flCaUTYvy6OjqVfaeq7LqlO+74clFHqVnafrl8+4mTe3YK1hFUezeMb56oOZAG3cxl
         z0vVYYl/nurwQECuyCOMZ16svqy8WRTWMBiAcnpcl4nCTDjxH4Ghk7THudZKgMWL24tc
         U96ICkV6jBhGz9sGmGB3bncu7k4WaFSIB4jOPcO1Ku1HRg9ZTkDEGboLMELpb9lnicYL
         4lYOrZ8s0PQ88+SvImsYEFLU2mo9iwZFVks7fTK3T9Mwp35ON9bpa0bAsesDCybQucTp
         ODBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740865650; x=1741470450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0rEahlvEtGF93YYTHC3INBotz2Tk0t9NarOhMgL+pQ=;
        b=M0Ex4HCNVzG70iT8F/wMUyIeFqFrTYKjoa1//N0HJyvccKxDgURXYQfqNrOIj0Xvtk
         GbHAdVc7B0Sw5XQwHNqeceo56K6mvNBI/Nk4gzIBTRn0GFJyzLhY2qxmfyVqfEnf7fSV
         pslckl72HSzXOMICfCAZkaJwhIgkji8rAqvCDOjBHhWOL4cUrY/nt7HNBn8bwI/tLMdF
         9yLn9kW5/zGcGQLhCPO/T0dpXWEe+SPARiB0+/gqYF+YmnTiU9Ygw4DKBfIBNb/zwL7c
         YAGmL6yPm2ldCTC6xrnbd2pxyPJ8Gn7+NSxxKBBCYOYu2fFHdRPyu4P+0yQE3wAH4912
         Dl9g==
X-Gm-Message-State: AOJu0YzfrCwRaGs8Df36pSrjJyjUsnf321HPQR6fp1j9mf/CQWk1AP+2
	rJ4dbMlxharXrxb2ZhOv2uC6wHktcHlRD0R5oNX5eFnZBOVxJVk41mqZocH9
X-Gm-Gg: ASbGncsyfMtjgXDC7koquZCBxtPY7cYmdJShz9yeKz+dnoTOS2pcYYaNGxNRHdVdp9U
	BkoOAqeQcGK9pohwLdZyK4vuABRNHP/z5+P/wu4FjSoR13ZuLmWwHcdGIv1iczv8MxORIlThQ77
	z6VPu6JMYcXE47agfIbLTBJ13noPOzcKQ+ud/gZeUXT8ipkWHkhOJshvRqYtdfZGitLXgQUX2gX
	dGmO6muUiDpktpBi3gK9ZQvTZ/v8YZBwDmiAGZ1mzuinMX1GYxnKAIjviZUNPdgY1g1acRLqEm5
	20YkdM5GvVqHXbWlZWg3TBVaT0fe54tX2NsKH4hxptZd7bniLbqyZLEn2yPUZmqv+Lu2q0VLtKI
	E3dET
X-Google-Smtp-Source: AGHT+IHWcBD/jCjgxfX48SOcUBpL/71l/thzCBVhPUkjNP8cosmBfNgwDP0zZ5DiGeptj38dHx8ImQ==
X-Received: by 2002:a5d:6486:0:b0:38d:e420:3984 with SMTP id ffacd0b85a97d-390eca0ee3cmr7958145f8f.39.1740865649663;
        Sat, 01 Mar 2025 13:47:29 -0800 (PST)
Received: from aleksbgbg.communityfibre.co.uk ([103.205.25.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a72d5sm9603474f8f.31.2025.03.01.13.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 13:47:29 -0800 (PST)
From: Aleks Todorov <aleks.todorov.1337@gmail.com>
To: git@vger.kernel.org
Cc: Aleks Todorov <aleks.todorov.1337@gmail.com>
Subject: [PATCH 6/7] Documentation: Move placeholders to separate file
Date: Sat,  1 Mar 2025 21:45:05 +0000
Message-ID: <20250301214652.536439-7-aleks.todorov.1337@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250301214652.536439-1-aleks.todorov.1337@gmail.com>
References: <20250301214652.536439-1-aleks.todorov.1337@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move formatting placeholders to a separate file so they can be included
by multiple commands. In particular, git-blame will also need to include
the placeholder docs for the new --format option.

Signed-off-by: Aleks Todorov <aleks.todorov.1337@gmail.com>
---
 Documentation/placeholders.adoc   | 238 +++++++++++++++++++++++++++++
 Documentation/pretty-formats.adoc | 239 +-----------------------------
 2 files changed, 239 insertions(+), 238 deletions(-)
 create mode 100644 Documentation/placeholders.adoc

diff --git a/Documentation/placeholders.adoc b/Documentation/placeholders.adoc
new file mode 100644
index 0000000000..7f4d0b59c7
--- /dev/null
+++ b/Documentation/placeholders.adoc
@@ -0,0 +1,238 @@
+The placeholders are:
+
+- Placeholders that expand to a single literal character:
+'%n':: newline
+'%%':: a raw '%'
+'%x00':: '%x' followed by two hexadecimal digits is replaced with a
+	 byte with the hexadecimal digits' value (we will call this
+	 "literal formatting code" in the rest of this document).
+
+- Placeholders that affect formatting of later placeholders:
+'%Cred':: switch color to red
+'%Cgreen':: switch color to green
+'%Cblue':: switch color to blue
+'%Creset':: reset color
+'%C(...)':: color specification, as described under Values in the
+	    "CONFIGURATION FILE" section of linkgit:git-config[1].  By
+	    default, colors are shown only when enabled for log output
+	    (by `color.diff`, `color.ui`, or `--color`, and respecting
+	    the `auto` settings of the former if we are going to a
+	    terminal). `%C(auto,...)` is accepted as a historical
+	    synonym for the default (e.g., `%C(auto,red)`). Specifying
+	    `%C(always,...)` will show the colors even when color is
+	    not otherwise enabled (though consider just using
+	    `--color=always` to enable color for the whole output,
+	    including this format and anything else git might color).
+	    `auto` alone (i.e. `%C(auto)`) will turn on auto coloring
+	    on the next placeholders until the color is switched
+	    again.
+'%m':: left (`<`), right (`>`) or boundary (`-`) mark
+'%w([<w>[,<i1>[,<i2>]]])':: switch line wrapping, like the -w option of
+			    linkgit:git-shortlog[1].
+'%<( <N> [,trunc|ltrunc|mtrunc])':: make the next placeholder take at
+				  least N column widths, padding spaces on
+				  the right if necessary.  Optionally
+				  truncate (with ellipsis '..') at the left (ltrunc) `..ft`,
+				  the middle (mtrunc) `mi..le`, or the end
+				  (trunc) `rig..`, if the output is longer than
+				  N columns.
+				  Note 1: that truncating
+				  only works correctly with N >= 2.
+				  Note 2: spaces around the N and M (see below)
+				  values are optional.
+				  Note 3: Emojis and other wide characters
+				  will take two display columns, which may
+				  over-run column boundaries.
+				  Note 4: decomposed character combining marks
+				  may be misplaced at padding boundaries.
+'%<|( <M> )':: make the next placeholder take at least until Mth
+	     display column, padding spaces on the right if necessary.
+	     Use negative M values for column positions measured
+	     from the right hand edge of the terminal window.
+'%>( <N> )', '%>|( <M> )':: similar to '%<( <N> )', '%<|( <M> )' respectively,
+			but padding spaces on the left
+'%>>( <N> )', '%>>|( <M> )':: similar to '%>( <N> )', '%>|( <M> )'
+			  respectively, except that if the next
+			  placeholder takes more spaces than given and
+			  there are spaces on its left, use those
+			  spaces
+'%><( <N> )', '%><|( <M> )':: similar to '%<( <N> )', '%<|( <M> )'
+			  respectively, but padding both sides
+			  (i.e. the text is centered)
+
+- Placeholders that expand to information extracted from the commit:
+'%H':: commit hash
+'%h':: abbreviated commit hash
+'%T':: tree hash
+'%t':: abbreviated tree hash
+'%P':: parent hashes
+'%p':: abbreviated parent hashes
+'%an':: author name
+'%aN':: author name (respecting .mailmap, see linkgit:git-shortlog[1]
+	or linkgit:git-blame[1])
+'%ae':: author email
+'%aE':: author email (respecting .mailmap, see linkgit:git-shortlog[1]
+	or linkgit:git-blame[1])
+'%al':: author email local-part (the part before the '@' sign)
+'%aL':: author local-part (see '%al') respecting .mailmap, see
+	linkgit:git-shortlog[1] or linkgit:git-blame[1])
+'%ad':: author date (format respects --date= option)
+'%aD':: author date, RFC2822 style
+'%ar':: author date, relative
+'%at':: author date, UNIX timestamp
+'%ai':: author date, ISO 8601-like format
+'%aI':: author date, strict ISO 8601 format
+'%as':: author date, short format (`YYYY-MM-DD`)
+'%ah':: author date, human style (like the `--date=human` option of
+	linkgit:git-rev-list[1])
+'%cn':: committer name
+'%cN':: committer name (respecting .mailmap, see
+	linkgit:git-shortlog[1] or linkgit:git-blame[1])
+'%ce':: committer email
+'%cE':: committer email (respecting .mailmap, see
+	linkgit:git-shortlog[1] or linkgit:git-blame[1])
+'%cl':: committer email local-part (the part before the '@' sign)
+'%cL':: committer local-part (see '%cl') respecting .mailmap, see
+	linkgit:git-shortlog[1] or linkgit:git-blame[1])
+'%cd':: committer date (format respects --date= option)
+'%cD':: committer date, RFC2822 style
+'%cr':: committer date, relative
+'%ct':: committer date, UNIX timestamp
+'%ci':: committer date, ISO 8601-like format
+'%cI':: committer date, strict ISO 8601 format
+'%cs':: committer date, short format (`YYYY-MM-DD`)
+'%ch':: committer date, human style (like the `--date=human` option of
+	linkgit:git-rev-list[1])
+'%d':: ref names, like the --decorate option of linkgit:git-log[1]
+'%D':: ref names without the " (", ")" wrapping.
+'%(decorate[:<options>])'::
+ref names with custom decorations. The `decorate` string may be followed by a
+colon and zero or more comma-separated options. Option values may contain
+literal formatting codes. These must be used for commas (`%x2C`) and closing
+parentheses (`%x29`), due to their role in the option syntax.
++
+** 'prefix=<value>': Shown before the list of ref names.  Defaults to "{nbsp}`(`".
+** 'suffix=<value>': Shown after the list of ref names.  Defaults to "`)`".
+** 'separator=<value>': Shown between ref names.  Defaults to "`,`{nbsp}".
+** 'pointer=<value>': Shown between HEAD and the branch it points to, if any.
+		      Defaults to "{nbsp}`->`{nbsp}".
+** 'tag=<value>': Shown before tag names. Defaults to "`tag:`{nbsp}".
+
++
+For example, to produce decorations with no wrapping
+or tag annotations, and spaces as separators:
++
+`%(decorate:prefix=,suffix=,tag=,separator= )`
+
+'%(describe[:<options>])'::
+human-readable name, like linkgit:git-describe[1]; empty string for
+undescribable commits.  The `describe` string may be followed by a colon and
+zero or more comma-separated options.  Descriptions can be inconsistent when
+tags are added or removed at the same time.
++
+** 'tags[=<bool-value>]': Instead of only considering annotated tags,
+   consider lightweight tags as well.
+** 'abbrev=<number>': Instead of using the default number of hexadecimal digits
+   (which will vary according to the number of objects in the repository with a
+   default of 7) of the abbreviated object name, use <number> digits, or as many
+   digits as needed to form a unique object name.
+** 'match=<pattern>': Only consider tags matching the given
+   `glob(7)` pattern, excluding the "refs/tags/" prefix.
+** 'exclude=<pattern>': Do not consider tags matching the given
+   `glob(7)` pattern, excluding the "refs/tags/" prefix.
+
+'%S':: ref name given on the command line by which the commit was reached
+       (like `git log --source`), only works with `git log`
+'%e':: encoding
+'%s':: subject
+'%f':: sanitized subject line, suitable for a filename
+'%b':: body
+'%B':: raw body (unwrapped subject and body)
+ifndef::git-rev-list[]
+'%N':: commit notes
+endif::git-rev-list[]
+'%GG':: raw verification message from GPG for a signed commit
+'%G?':: show "G" for a good (valid) signature,
+	"B" for a bad signature,
+	"U" for a good signature with unknown validity,
+	"X" for a good signature that has expired,
+	"Y" for a good signature made by an expired key,
+	"R" for a good signature made by a revoked key,
+	"E" if the signature cannot be checked (e.g. missing key)
+	and "N" for no signature
+'%GS':: show the name of the signer for a signed commit
+'%GK':: show the key used to sign a signed commit
+'%GF':: show the fingerprint of the key used to sign a signed commit
+'%GP':: show the fingerprint of the primary key whose subkey was used
+	to sign a signed commit
+'%GT':: show the trust level for the key used to sign a signed commit
+'%gD':: reflog selector, e.g., `refs/stash@{1}` or `refs/stash@{2
+	minutes ago}`; the format follows the rules described for the
+	`-g` option. The portion before the `@` is the refname as
+	given on the command line (so `git log -g refs/heads/master`
+	would yield `refs/heads/master@{0}`).
+'%gd':: shortened reflog selector; same as `%gD`, but the refname
+	portion is shortened for human readability (so
+	`refs/heads/master` becomes just `master`).
+'%gn':: reflog identity name
+'%gN':: reflog identity name (respecting .mailmap, see
+	linkgit:git-shortlog[1] or linkgit:git-blame[1])
+'%ge':: reflog identity email
+'%gE':: reflog identity email (respecting .mailmap, see
+	linkgit:git-shortlog[1] or linkgit:git-blame[1])
+'%gs':: reflog subject
+'%(trailers[:<options>])'::
+display the trailers of the body as interpreted by
+linkgit:git-interpret-trailers[1]. The `trailers` string may be followed by
+a colon and zero or more comma-separated options. If any option is provided
+multiple times, the last occurrence wins.
++
+** 'key=<key>': only show trailers with specified <key>. Matching is done
+   case-insensitively and trailing colon is optional. If option is
+   given multiple times trailer lines matching any of the keys are
+   shown. This option automatically enables the `only` option so that
+   non-trailer lines in the trailer block are hidden. If that is not
+   desired it can be disabled with `only=false`.  E.g.,
+   `%(trailers:key=Reviewed-by)` shows trailer lines with key
+   `Reviewed-by`.
+** 'only[=<bool>]': select whether non-trailer lines from the trailer
+   block should be included.
+** 'separator=<sep>': specify the separator inserted between trailer
+   lines. Defaults to a line feed character. The string <sep> may contain
+   the literal formatting codes described above. To use comma as
+   separator one must use `%x2C` as it would otherwise be parsed as
+   next option. E.g., `%(trailers:key=Ticket,separator=%x2C )`
+   shows all trailer lines whose key is "Ticket" separated by a comma
+   and a space.
+** 'unfold[=<bool>]': make it behave as if interpret-trailer's `--unfold`
+   option was given. E.g.,
+   `%(trailers:only,unfold=true)` unfolds and shows all trailer lines.
+** 'keyonly[=<bool>]': only show the key part of the trailer.
+** 'valueonly[=<bool>]': only show the value part of the trailer.
+** 'key_value_separator=<sep>': specify the separator inserted between
+   the key and value of each trailer. Defaults to ": ". Otherwise it
+   shares the same semantics as 'separator=<sep>' above.
+
+NOTE: Some placeholders may depend on other options given to the
+revision traversal engine. For example, the `%g*` reflog options will
+insert an empty string unless we are traversing reflog entries (e.g., by
+`git log -g`). The `%d` and `%D` placeholders will use the "short"
+decoration format if `--decorate` was not already provided on the command
+line.
+
+The boolean options accept an optional value `[=<bool-value>]`. The
+values taken by `--type=bool` git-config[1], like `yes` and `off`,
+are all accepted.  Giving a boolean option without `=<value>` is
+equivalent to giving it with `=true`.
+
+If you add a `+` (plus sign) after '%' of a placeholder, a line-feed
+is inserted immediately before the expansion if and only if the
+placeholder expands to a non-empty string.
+
+If you add a `-` (minus sign) after '%' of a placeholder, all consecutive
+line-feeds immediately preceding the expansion are deleted if and only if the
+placeholder expands to an empty string.
+
+If you add a ` ` (space) after '%' of a placeholder, a space
+is inserted immediately before the expansion if and only if the
+placeholder expands to a non-empty string.
diff --git a/Documentation/pretty-formats.adoc b/Documentation/pretty-formats.adoc
index 07475de8c3..68c0cebd26 100644
--- a/Documentation/pretty-formats.adoc
+++ b/Documentation/pretty-formats.adoc
@@ -117,244 +117,7 @@ The title was >>t4119: test autocomputing -p<n> for traditional diff input.<<
 
 -------
 +
-The placeholders are:
-
-- Placeholders that expand to a single literal character:
-'%n':: newline
-'%%':: a raw '%'
-'%x00':: '%x' followed by two hexadecimal digits is replaced with a
-	 byte with the hexadecimal digits' value (we will call this
-	 "literal formatting code" in the rest of this document).
-
-- Placeholders that affect formatting of later placeholders:
-'%Cred':: switch color to red
-'%Cgreen':: switch color to green
-'%Cblue':: switch color to blue
-'%Creset':: reset color
-'%C(...)':: color specification, as described under Values in the
-	    "CONFIGURATION FILE" section of linkgit:git-config[1].  By
-	    default, colors are shown only when enabled for log output
-	    (by `color.diff`, `color.ui`, or `--color`, and respecting
-	    the `auto` settings of the former if we are going to a
-	    terminal). `%C(auto,...)` is accepted as a historical
-	    synonym for the default (e.g., `%C(auto,red)`). Specifying
-	    `%C(always,...)` will show the colors even when color is
-	    not otherwise enabled (though consider just using
-	    `--color=always` to enable color for the whole output,
-	    including this format and anything else git might color).
-	    `auto` alone (i.e. `%C(auto)`) will turn on auto coloring
-	    on the next placeholders until the color is switched
-	    again.
-'%m':: left (`<`), right (`>`) or boundary (`-`) mark
-'%w([<w>[,<i1>[,<i2>]]])':: switch line wrapping, like the -w option of
-			    linkgit:git-shortlog[1].
-'%<( <N> [,trunc|ltrunc|mtrunc])':: make the next placeholder take at
-				  least N column widths, padding spaces on
-				  the right if necessary.  Optionally
-				  truncate (with ellipsis '..') at the left (ltrunc) `..ft`,
-				  the middle (mtrunc) `mi..le`, or the end
-				  (trunc) `rig..`, if the output is longer than
-				  N columns.
-				  Note 1: that truncating
-				  only works correctly with N >= 2.
-				  Note 2: spaces around the N and M (see below)
-				  values are optional.
-				  Note 3: Emojis and other wide characters
-				  will take two display columns, which may
-				  over-run column boundaries.
-				  Note 4: decomposed character combining marks
-				  may be misplaced at padding boundaries.
-'%<|( <M> )':: make the next placeholder take at least until Mth
-	     display column, padding spaces on the right if necessary.
-	     Use negative M values for column positions measured
-	     from the right hand edge of the terminal window.
-'%>( <N> )', '%>|( <M> )':: similar to '%<( <N> )', '%<|( <M> )' respectively,
-			but padding spaces on the left
-'%>>( <N> )', '%>>|( <M> )':: similar to '%>( <N> )', '%>|( <M> )'
-			  respectively, except that if the next
-			  placeholder takes more spaces than given and
-			  there are spaces on its left, use those
-			  spaces
-'%><( <N> )', '%><|( <M> )':: similar to '%<( <N> )', '%<|( <M> )'
-			  respectively, but padding both sides
-			  (i.e. the text is centered)
-
-- Placeholders that expand to information extracted from the commit:
-'%H':: commit hash
-'%h':: abbreviated commit hash
-'%T':: tree hash
-'%t':: abbreviated tree hash
-'%P':: parent hashes
-'%p':: abbreviated parent hashes
-'%an':: author name
-'%aN':: author name (respecting .mailmap, see linkgit:git-shortlog[1]
-	or linkgit:git-blame[1])
-'%ae':: author email
-'%aE':: author email (respecting .mailmap, see linkgit:git-shortlog[1]
-	or linkgit:git-blame[1])
-'%al':: author email local-part (the part before the '@' sign)
-'%aL':: author local-part (see '%al') respecting .mailmap, see
-	linkgit:git-shortlog[1] or linkgit:git-blame[1])
-'%ad':: author date (format respects --date= option)
-'%aD':: author date, RFC2822 style
-'%ar':: author date, relative
-'%at':: author date, UNIX timestamp
-'%ai':: author date, ISO 8601-like format
-'%aI':: author date, strict ISO 8601 format
-'%as':: author date, short format (`YYYY-MM-DD`)
-'%ah':: author date, human style (like the `--date=human` option of
-	linkgit:git-rev-list[1])
-'%cn':: committer name
-'%cN':: committer name (respecting .mailmap, see
-	linkgit:git-shortlog[1] or linkgit:git-blame[1])
-'%ce':: committer email
-'%cE':: committer email (respecting .mailmap, see
-	linkgit:git-shortlog[1] or linkgit:git-blame[1])
-'%cl':: committer email local-part (the part before the '@' sign)
-'%cL':: committer local-part (see '%cl') respecting .mailmap, see
-	linkgit:git-shortlog[1] or linkgit:git-blame[1])
-'%cd':: committer date (format respects --date= option)
-'%cD':: committer date, RFC2822 style
-'%cr':: committer date, relative
-'%ct':: committer date, UNIX timestamp
-'%ci':: committer date, ISO 8601-like format
-'%cI':: committer date, strict ISO 8601 format
-'%cs':: committer date, short format (`YYYY-MM-DD`)
-'%ch':: committer date, human style (like the `--date=human` option of
-	linkgit:git-rev-list[1])
-'%d':: ref names, like the --decorate option of linkgit:git-log[1]
-'%D':: ref names without the " (", ")" wrapping.
-'%(decorate[:<options>])'::
-ref names with custom decorations. The `decorate` string may be followed by a
-colon and zero or more comma-separated options. Option values may contain
-literal formatting codes. These must be used for commas (`%x2C`) and closing
-parentheses (`%x29`), due to their role in the option syntax.
-+
-** 'prefix=<value>': Shown before the list of ref names.  Defaults to "{nbsp}`(`".
-** 'suffix=<value>': Shown after the list of ref names.  Defaults to "`)`".
-** 'separator=<value>': Shown between ref names.  Defaults to "`,`{nbsp}".
-** 'pointer=<value>': Shown between HEAD and the branch it points to, if any.
-		      Defaults to "{nbsp}`->`{nbsp}".
-** 'tag=<value>': Shown before tag names. Defaults to "`tag:`{nbsp}".
-
-+
-For example, to produce decorations with no wrapping
-or tag annotations, and spaces as separators:
-+
-`%(decorate:prefix=,suffix=,tag=,separator= )`
-
-'%(describe[:<options>])'::
-human-readable name, like linkgit:git-describe[1]; empty string for
-undescribable commits.  The `describe` string may be followed by a colon and
-zero or more comma-separated options.  Descriptions can be inconsistent when
-tags are added or removed at the same time.
-+
-** 'tags[=<bool-value>]': Instead of only considering annotated tags,
-   consider lightweight tags as well.
-** 'abbrev=<number>': Instead of using the default number of hexadecimal digits
-   (which will vary according to the number of objects in the repository with a
-   default of 7) of the abbreviated object name, use <number> digits, or as many
-   digits as needed to form a unique object name.
-** 'match=<pattern>': Only consider tags matching the given
-   `glob(7)` pattern, excluding the "refs/tags/" prefix.
-** 'exclude=<pattern>': Do not consider tags matching the given
-   `glob(7)` pattern, excluding the "refs/tags/" prefix.
-
-'%S':: ref name given on the command line by which the commit was reached
-       (like `git log --source`), only works with `git log`
-'%e':: encoding
-'%s':: subject
-'%f':: sanitized subject line, suitable for a filename
-'%b':: body
-'%B':: raw body (unwrapped subject and body)
-ifndef::git-rev-list[]
-'%N':: commit notes
-endif::git-rev-list[]
-'%GG':: raw verification message from GPG for a signed commit
-'%G?':: show "G" for a good (valid) signature,
-	"B" for a bad signature,
-	"U" for a good signature with unknown validity,
-	"X" for a good signature that has expired,
-	"Y" for a good signature made by an expired key,
-	"R" for a good signature made by a revoked key,
-	"E" if the signature cannot be checked (e.g. missing key)
-	and "N" for no signature
-'%GS':: show the name of the signer for a signed commit
-'%GK':: show the key used to sign a signed commit
-'%GF':: show the fingerprint of the key used to sign a signed commit
-'%GP':: show the fingerprint of the primary key whose subkey was used
-	to sign a signed commit
-'%GT':: show the trust level for the key used to sign a signed commit
-'%gD':: reflog selector, e.g., `refs/stash@{1}` or `refs/stash@{2
-	minutes ago}`; the format follows the rules described for the
-	`-g` option. The portion before the `@` is the refname as
-	given on the command line (so `git log -g refs/heads/master`
-	would yield `refs/heads/master@{0}`).
-'%gd':: shortened reflog selector; same as `%gD`, but the refname
-	portion is shortened for human readability (so
-	`refs/heads/master` becomes just `master`).
-'%gn':: reflog identity name
-'%gN':: reflog identity name (respecting .mailmap, see
-	linkgit:git-shortlog[1] or linkgit:git-blame[1])
-'%ge':: reflog identity email
-'%gE':: reflog identity email (respecting .mailmap, see
-	linkgit:git-shortlog[1] or linkgit:git-blame[1])
-'%gs':: reflog subject
-'%(trailers[:<options>])'::
-display the trailers of the body as interpreted by
-linkgit:git-interpret-trailers[1]. The `trailers` string may be followed by
-a colon and zero or more comma-separated options. If any option is provided
-multiple times, the last occurrence wins.
-+
-** 'key=<key>': only show trailers with specified <key>. Matching is done
-   case-insensitively and trailing colon is optional. If option is
-   given multiple times trailer lines matching any of the keys are
-   shown. This option automatically enables the `only` option so that
-   non-trailer lines in the trailer block are hidden. If that is not
-   desired it can be disabled with `only=false`.  E.g.,
-   `%(trailers:key=Reviewed-by)` shows trailer lines with key
-   `Reviewed-by`.
-** 'only[=<bool>]': select whether non-trailer lines from the trailer
-   block should be included.
-** 'separator=<sep>': specify the separator inserted between trailer
-   lines. Defaults to a line feed character. The string <sep> may contain
-   the literal formatting codes described above. To use comma as
-   separator one must use `%x2C` as it would otherwise be parsed as
-   next option. E.g., `%(trailers:key=Ticket,separator=%x2C )`
-   shows all trailer lines whose key is "Ticket" separated by a comma
-   and a space.
-** 'unfold[=<bool>]': make it behave as if interpret-trailer's `--unfold`
-   option was given. E.g.,
-   `%(trailers:only,unfold=true)` unfolds and shows all trailer lines.
-** 'keyonly[=<bool>]': only show the key part of the trailer.
-** 'valueonly[=<bool>]': only show the value part of the trailer.
-** 'key_value_separator=<sep>': specify the separator inserted between
-   the key and value of each trailer. Defaults to ": ". Otherwise it
-   shares the same semantics as 'separator=<sep>' above.
-
-NOTE: Some placeholders may depend on other options given to the
-revision traversal engine. For example, the `%g*` reflog options will
-insert an empty string unless we are traversing reflog entries (e.g., by
-`git log -g`). The `%d` and `%D` placeholders will use the "short"
-decoration format if `--decorate` was not already provided on the command
-line.
-
-The boolean options accept an optional value `[=<bool-value>]`. The
-values taken by `--type=bool` git-config[1], like `yes` and `off`,
-are all accepted.  Giving a boolean option without `=<value>` is
-equivalent to giving it with `=true`.
-
-If you add a `+` (plus sign) after '%' of a placeholder, a line-feed
-is inserted immediately before the expansion if and only if the
-placeholder expands to a non-empty string.
-
-If you add a `-` (minus sign) after '%' of a placeholder, all consecutive
-line-feeds immediately preceding the expansion are deleted if and only if the
-placeholder expands to an empty string.
-
-If you add a ` ` (space) after '%' of a placeholder, a space
-is inserted immediately before the expansion if and only if the
-placeholder expands to a non-empty string.
+include::placeholders.adoc[]
 
 * 'tformat:'
 +
-- 
2.43.0

