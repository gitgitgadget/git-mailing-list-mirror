Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E4527056B
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 13:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754399047; cv=none; b=fVBDWWbJCUK/OQRzXq7v25dTPmax0IG6VprTKiDj2MkPrupH50voMadZvYtFqfeUNuBmbRbUg8i+CFoQ16VXCzRIbHpypRcezc+p9f42pjncpjdltUKSP8++ZxW9Bjgi7bmtpxcG0HZ0DGikO8VySFyWueq8D9/7pGs8ZIQ7i7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754399047; c=relaxed/simple;
	bh=nPCgSqiu42Hrg74tg2rHVPGPhkJ2esrgkRbQZP/arVY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=SGrAFekcyrNBkvLwtAXkeiAQsX2wF1zHdXDNys3vMef2ekWGsLYZXJ/bmDcVYkYRDRvQXmP83FMJJ+c1vKI3QeoSqahBAGAoszBY+wuE1iLoy7227JA29at9B/HvGFJZnxGXkWM0VSKpcoSdj43R7wPnmW+HwPGZv7VHDkdadjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJy0s7hN; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJy0s7hN"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-458b885d6eeso19261855e9.3
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 06:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754399041; x=1755003841; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3nCOTQw/5A7EKET34Mc5OcEiE5WWQDlXScUm88Kslk=;
        b=DJy0s7hNN+wNWTvDrZaESdRZCRyHpfMIQIkznWBc3du1Yb9/xfJbRVM7CKv/ivUvPH
         jpMnijWZCAQ0Le6L7RN5HfuhCGybZV8/aXCRKHJ2RAKDtaFd/KJW9CuNdfqrneBMy2Tp
         AqhvfttTx+TgcWBXg4DsZBliYDIhHBuhdjqb+EPtV7wvuDtWkokPaL0l63klhR3RfYYF
         LDg/snrCMvb409A9A1TZpedCLA0+90nNE/cv1WfLtDVbV5EIvsrFHTKDV1BDqKqInhRp
         3NBQZfOfavUdDNPDGu8MSHNfFBWJu/8lflgKpVox5rPWKojuPf3UXPX0d5yvO9ma/wkt
         OiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754399041; x=1755003841;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A3nCOTQw/5A7EKET34Mc5OcEiE5WWQDlXScUm88Kslk=;
        b=rQ8BPE9qDtHSWLoqS9aBGyVdt6O4E83o72nN46I59gEmEl4lsEjfovHJRQ/plfWu6r
         HsBs//4ysoxc/9Lzkit776QAFFBi2cSBC1xQ4rgjVccyNJufWjdLjg5KJnXITOh0eu3O
         UCjh9r2U7SfRm5bOgzTHHSpcvppr++SFAEPt6OEjS7WjA1pXcElZoihYd3kbaBsUuUrg
         +1g1Ig0DSTrkgFmBcp9ZraVNtmn8sooOR4Sq8BwF+Y/+zOftZvjGPGfhKKyKtCWomc3m
         Qf3KIvzP+KOdGP6Z4qn0Ks4regLt8xcQxHxWg/aVpPkn8pBlaw0yXiIXDkpffj9EKagE
         MYTg==
X-Gm-Message-State: AOJu0YyVDxeyMsDXzxoOgAaPhBjhl7D0evWyhBKgBW8Gu4z+kqb1G2yO
	pfIKgT89DrUHwYaUPLCk3WUtteML0H7C9hN4w66ATNhWaFkAoQRDqwJhj+gihQ==
X-Gm-Gg: ASbGnctWofRklSRdhaE1BNbuiv11adT/5qgjlt/xFcwZiy4PQq8WZOOWyg/sn/i7tgk
	kM1AeLjpXxqD1pNjn0VlVHTo2UNeanD0jAva/3N0QEhyrOePvLhqPOioSJ5axAO6liW2QMPUPtu
	TgXmg9Kx1PKU6sx7pTVcbWvIzf5QYu8GagMPs8mGu+eZpGvSzslhUgbTqrEZM2VD5l4EYEksIYY
	czXvHNkLi5bpbjcgAaGLERQJtvIbf2EYiTtx+Qb0rF6Mxwoo/kazldhvHL+ttvYo1RFIhwdRLo2
	KMkP5/MHJum9zxwQHlqwkt7Boa/fRquv2I5uWo10kjePYRStek4uy+wMAxexGt0rEcvzu/00Kyv
	y2HWMtNMZz3smiwfPKrg9l0Q=
X-Google-Smtp-Source: AGHT+IEO2rDlbH4cJrqtJWNCD9/UERmmpeVkwldjKdILFgTOOu2XTqJ7i2iB2RyLfGTUbjvUvB/2TQ==
X-Received: by 2002:a05:6000:1885:b0:3a3:7ba5:93a5 with SMTP id ffacd0b85a97d-3b8d9486256mr9153666f8f.26.1754399041339;
        Tue, 05 Aug 2025 06:04:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3b9eddsm19149056f8f.22.2025.08.05.06.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 06:04:00 -0700 (PDT)
Message-Id: <713c86dae92bd54824cb90e359c025c6f4236c17.1754399033.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1945.git.1754399033.gitgitgadget@gmail.com>
References: <pull.1945.git.1754399033.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 Aug 2025 13:03:52 +0000
Subject: [PATCH 5/6] doc:git-for-each-ref: fix styling and typos
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
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

This commit fixes the synopsis syntax and changes the wording of a few
descriptions to be more consistent with the rest of the documentation.

It is a prepartion for the next commit that checks that synopsis style is
applied consistently across a manual page.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-for-each-ref.adoc | 264 ++++++++++++++--------------
 1 file changed, 132 insertions(+), 132 deletions(-)

diff --git a/Documentation/git-for-each-ref.adoc b/Documentation/git-for-each-ref.adoc
index 060940904da2..b69080c4a000 100644
--- a/Documentation/git-for-each-ref.adoc
+++ b/Documentation/git-for-each-ref.adoc
@@ -14,101 +14,98 @@ git for-each-ref [--count=<count>] [--shell|--perl|--python|--tcl]
 		   [--merged[=<object>]] [--no-merged[=<object>]]
 		   [--contains[=<object>]] [--no-contains[=<object>]]
 		   [(--exclude=<pattern>)...] [--start-after=<marker>]
-		   [ --stdin | <pattern>... ]
+		   [ --stdin | (<pattern>...)]
 
 DESCRIPTION
 -----------
 
-Iterate over all refs that match `<pattern>` and show them
-according to the given `<format>`, after sorting them according
-to the given set of `<key>`.  If `<count>` is given, stop after
-showing that many refs.  The interpolated values in `<format>`
+Iterate over all refs that match _<pattern>_ and show them
+according to the given _<format>_, after sorting them according
+to the given set of _<key>_.  If _<count>_ is given, stop after
+showing that many refs.  The interpolated values in _<format>_
 can optionally be quoted as string literals in the specified
 host language allowing their direct evaluation in that language.
 
 OPTIONS
 -------
-<pattern>...::
-	If one or more patterns are given, only refs are shown that
-	match against at least one pattern, either using fnmatch(3) or
+`<pattern>...`::
+	If one or more _<pattern>_ parameters are given, only refs are shown that
+	match against at least one pattern, either using `fnmatch`(3) or
 	literally, in the latter case matching completely or from the
 	beginning up to a slash.
 
---stdin::
-	If `--stdin` is supplied, then the list of patterns is read from
-	standard input instead of from the argument list.
+`--stdin`::
+	The list of patterns is read from standard input instead of from
+	the argument list.
 
---count=<count>::
-	By default the command shows all refs that match
-	`<pattern>`.  This option makes it stop after showing
-	that many refs.
+`--count=<count>`::
+	Stop after showing _<count>_ refs.
 
---sort=<key>::
-	A field name to sort on.  Prefix `-` to sort in
+`--sort=<key>`::
+	Sort on the field name _<key>_.  Prefix `-` to sort in
 	descending order of the value.  When unspecified,
-	`refname` is used.  You may use the --sort=<key> option
+	`refname` is used.  You may use the `--sort=<key>` option
 	multiple times, in which case the last key becomes the primary
 	key.
 
---format=<format>::
+`--format[=<format>]`::
 	A string that interpolates `%(fieldname)` from a ref being shown and
 	the object it points at. In addition, the string literal `%%`
 	renders as `%` and `%xx` - where `xx` are hex digits - renders as
 	the character with hex code `xx`. For example, `%00` interpolates to
-	`\0` (NUL), `%09` to `\t` (TAB), and `%0a` to `\n` (LF).
-+
-When unspecified, `<format>` defaults to `%(objectname) SPC %(objecttype)
+	`\0` (_NUL_), `%09` to `\t` (_TAB_), and `%0a` to `\n` (_LF_).
+
+When unspecified, _<format>_ defaults to `%(objectname) SPC %(objecttype)
 TAB %(refname)`.
 
---color[=<when>]::
+`--color[=<when>]`::
 	Respect any colors specified in the `--format` option. The
-	`<when>` field must be one of `always`, `never`, or `auto` (if
+	_<when__ field must be one of `always`, `never`, or `auto` (if
 	`<when>` is absent, behave as if `always` was given).
 
---shell::
---perl::
---python::
---tcl::
+`--shell`::
+`--perl`::
+`--python`::
+`--tcl`::
 	If given, strings that substitute `%(fieldname)`
 	placeholders are quoted as string literals suitable for
 	the specified host language.  This is meant to produce
-	a scriptlet that can directly be `eval`ed.
+	a scriptlet that can directly be "eval"ed.
 
---points-at=<object>::
+`--points-at=<object>`::
 	Only list refs which points at the given object.
 
---merged[=<object>]::
+`--merged[=<object>]`::
 	Only list refs whose tips are reachable from the
-	specified commit (HEAD if not specified).
-
---no-merged[=<object>]::
-	Only list refs whose tips are not reachable from the
-	specified commit (HEAD if not specified).
+	specified commit (`HEAD` if not specified).
 
---contains[=<object>]::
-	Only list refs which contain the specified commit (HEAD if not
+`--no-merged[=<object>]`::
+	Only list refs whose tips are not reachable from _<object>_(`HEAD` if not
 	specified).
 
---no-contains[=<object>]::
-	Only list refs which don't contain the specified commit (HEAD
+`--contains[=<object>]`::
+	Only list refs which contain _<object>_(`HEAD` if not specified).
+
+`--no-contains[=<object>]`::
+	Only list refs which don't contain _<object>_ (`HEAD`
 	if not specified).
 
---ignore-case::
+`--ignore-case`::
 	Sorting and filtering refs are case insensitive.
 
---omit-empty::
+`--omit-empty`::
 	Do not print a newline after formatted refs where the format expands
 	to the empty string.
 
---exclude=<pattern>::
-	If one or more patterns are given, only refs which do not match
-	any excluded pattern(s) are shown. Matching is done using the
-	same rules as `<pattern>` above.
+`--exclude=<excluded-pattern>`::
+	If one or more `--exclude` options are given, only refs which do not
+	match any _<excluded-pattern>_ parameters are shown. Matching is done
+	using the same rules as _<pattern>_ above.
 
---include-root-refs::
-	List root refs (HEAD and pseudorefs) apart from regular refs.
+`--include-root-refs`::
+	List root refs (`HEAD` and pseudorefs) apart from regular refs.
 
---start-after=<marker>::
+`--start-after=<marker>`::
     Allows paginating the output by skipping references up to and including the
     specified marker. When paging, it should be noted that references may be
     deleted, modified or added between invocations. Output will only yield those
@@ -126,44 +123,44 @@ keys.
 
 For all objects, the following names can be used:
 
-refname::
-	The name of the ref (the part after $GIT_DIR/).
+`refname`::
+	The name of the ref (the part after `$GIT_DIR/`).
 	For a non-ambiguous short name of the ref append `:short`.
-	The option core.warnAmbiguousRefs is used to select the strict
-	abbreviation mode. If `lstrip=<N>` (`rstrip=<N>`) is appended, strips `<N>`
+	The option `core.warnAmbiguousRefs` is used to select the strict
+	abbreviation mode. If `lstrip=<n>` (`rstrip=<n>`) is appended, strip _<n>_
 	slash-separated path components from the front (back) of the refname
 	(e.g. `%(refname:lstrip=2)` turns `refs/tags/foo` into `foo` and
 	`%(refname:rstrip=2)` turns `refs/tags/foo` into `refs`).
-	If `<N>` is a negative number, strip as many path components as
-	necessary from the specified end to leave `-<N>` path components
+	If _<n>_ is a negative number, strip as many path components as
+	necessary from the specified end to leave `-<n>` path components
 	(e.g. `%(refname:lstrip=-2)` turns
 	`refs/tags/foo` into `tags/foo` and `%(refname:rstrip=-1)`
 	turns `refs/tags/foo` into `refs`). When the ref does not have
 	enough components, the result becomes an empty string if
-	stripping with positive <N>, or it becomes the full refname if
-	stripping with negative <N>.  Neither is an error.
+	stripping with positive _<n>_, or it becomes the full refname if
+	stripping with negative _<N>_.  Neither is an error.
 +
 `strip` can be used as a synonym to `lstrip`.
 
-objecttype::
+`objecttype`::
 	The type of the object (`blob`, `tree`, `commit`, `tag`).
 
-objectsize::
+`objectsize`::
 	The size of the object (the same as 'git cat-file -s' reports).
 	Append `:disk` to get the size, in bytes, that the object takes up on
-	disk. See the note about on-disk sizes in the `CAVEATS` section below.
-objectname::
+	disk. See the note about on-disk sizes in the 'CAVEATS' section below.
+`objectname`::
 	The object name (aka SHA-1).
 	For a non-ambiguous abbreviation of the object name append `:short`.
 	For an abbreviation of the object name with desired length append
-	`:short=<length>`, where the minimum length is MINIMUM_ABBREV. The
+	`:short=<length>`, where the minimum length is `MINIMUM_ABBREV`. The
 	length may be exceeded to ensure unique object names.
-deltabase::
+`deltabase`::
 	This expands to the object name of the delta base for the
 	given object, if it is stored as a delta.  Otherwise it
 	expands to the null object name (all zeroes).
 
-upstream::
+`upstream`::
 	The name of a local ref which can be considered ``upstream''
 	from the displayed ref. Respects `:short`, `:lstrip` and
 	`:rstrip` in the same way as `refname` above.  Additionally
@@ -185,100 +182,103 @@ Has no effect if the ref does not have tracking information associated
 with it.  All the options apart from `nobracket` are mutually exclusive,
 but if used together the last option is selected.
 
-push::
+`push`::
 	The name of a local ref which represents the `@{push}`
 	location for the displayed ref. Respects `:short`, `:lstrip`,
 	`:rstrip`, `:track`, `:trackshort`, `:remotename`, and `:remoteref`
 	options as `upstream` does. Produces an empty string if no `@{push}`
 	ref is configured.
 
-HEAD::
-	'*' if HEAD matches current ref (the checked out branch), ' '
+`HEAD`::
+	`*` if `HEAD` matches current ref (the checked out branch), ' '
 	otherwise.
 
-color::
+`color`::
 	Change output color. Followed by `:<colorname>`, where color
 	names are described under Values in the "CONFIGURATION FILE"
 	section of linkgit:git-config[1].  For example,
 	`%(color:bold red)`.
 
-align::
+`align`::
 	Left-, middle-, or right-align the content between
-	%(align:...) and %(end). The "align:" is followed by
+	`%(align:...)` and `%(end)`. The "`align:`" is followed by
 	`width=<width>` and `position=<position>` in any order
-	separated by a comma, where the `<position>` is either left,
-	right or middle, default being left and `<width>` is the total
+	separated by a comma, where the _<position>_ is either `left`,
+	`right` or `middle`, default being `left` and _<width>_ is the total
 	length of the content with alignment. For brevity, the
 	"width=" and/or "position=" prefixes may be omitted, and bare
-	<width> and <position> used instead.  For instance,
+	_<width>_ and _<position>_ used instead.  For instance,
 	`%(align:<width>,<position>)`. If the contents length is more
 	than the width then no alignment is performed. If used with
-	`--quote` everything in between %(align:...) and %(end) is
+	`--quote` everything in between `%(align:...)` and `%(end)` is
 	quoted, but if nested then only the topmost level performs
 	quoting.
 
-if::
-	Used as %(if)...%(then)...%(end) or
-	%(if)...%(then)...%(else)...%(end).  If there is an atom with
-	value or string literal after the %(if) then everything after
-	the %(then) is printed, else if the %(else) atom is used, then
+`if`::
+	Used as `%(if)...%(then)...%(end)` or
+	`%(if)...%(then)...%(else)...%(end)`.  If there is an atom with
+	value or string literal after the `%(if)` then everything after
+	the `%(then)` is printed, else if the `%(else)` atom is used, then
 	everything after %(else) is printed. We ignore space when
-	evaluating the string before %(then), this is useful when we
-	use the %(HEAD) atom which prints either "*" or " " and we
-	want to apply the 'if' condition only on the 'HEAD' ref.
-	Append ":equals=<string>" or ":notequals=<string>" to compare
-	the value between the %(if:...) and %(then) atoms with the
+	evaluating the string before `%(then)`, this is useful when we
+	use the `%(HEAD)` atom which prints either "`*`" or " " and we
+	want to apply the 'if' condition only on the `HEAD` ref.
+	Append "`:equals=<string>`" or "`:notequals=<string>`" to compare
+	the value between the `%(if:...)` and `%(then)` atoms with the
 	given string.
 
-symref::
+`symref`::
 	The ref which the given symbolic ref refers to. If not a
 	symbolic ref, nothing is printed. Respects the `:short`,
 	`:lstrip` and `:rstrip` options in the same way as `refname`
 	above.
 
-signature::
+`signature`::
 	The GPG signature of a commit.
 
-signature:grade::
-	Show "G" for a good (valid) signature, "B" for a bad
-	signature, "U" for a good signature with unknown validity, "X"
-	for a good signature that has expired, "Y" for a good
-	signature made by an expired key, "R" for a good signature
-	made by a revoked key, "E" if the signature cannot be
-	checked (e.g. missing key) and "N" for no signature.
-
-signature:signer::
+`signature:grade`::
+	Show
+`G`;; for a good (valid) signature
+`B`;; for a bad signature
+`U`;; for a good signature with unknown validity
+`X`;;	for a good signature that has expired
+`Y`;; for a good signature made by an expired key
+`R`;; for a good signature made by a revoked key
+`E`;; if the signature cannot be checked (e.g. missing key)
+`N`;; for no signature.
+
+`signature:signer`::
 	The signer of the GPG signature of a commit.
 
-signature:key::
+`signature:key`::
 	The key of the GPG signature of a commit.
 
-signature:fingerprint::
+`signature:fingerprint`::
 	The fingerprint of the GPG signature of a commit.
 
-signature:primarykeyfingerprint::
+`signature:primarykeyfingerprint`::
 	The primary key fingerprint of the GPG signature of a commit.
 
-signature:trustlevel::
+`signature:trustlevel`::
 	The trust level of the GPG signature of a commit. Possible
 	outputs are `ultimate`, `fully`, `marginal`, `never` and `undefined`.
 
-worktreepath::
+`worktreepath`::
 	The absolute path to the worktree in which the ref is checked
 	out, if it is checked out in any linked worktree. Empty string
 	otherwise.
 
-ahead-behind:<committish>::
+`ahead-behind:<commit-ish>`::
 	Two integers, separated by a space, demonstrating the number of
 	commits ahead and behind, respectively, when comparing the output
-	ref to the `<committish>` specified in the format.
+	ref to the _<committish>_ specified in the format.
 
-is-base:<committish>::
-	In at most one row, `(<committish>)` will appear to indicate the ref
+`is-base:<commit-ish>`::
+	In at most one row, `(<commit-ish>)` will appear to indicate the ref
 	that is most likely the ref used as a starting point for the branch
-	that produced `<committish>`. This choice is made using a heuristic:
+	that produced _<commit-ish>_. This choice is made using a heuristic:
 	choose the ref that minimizes the number of commits in the
-	first-parent history of `<committish>` and not in the first-parent
+	first-parent history of _<commit-ish>_ and not in the first-parent
 	history of the ref.
 +
 For example, consider the following figure of first-parent histories of
@@ -312,29 +312,29 @@ common first-parent ancestor of `B` and `C` and ties are broken by the
 earliest ref in the sorted order.
 +
 Note that this token will not appear if the first-parent history of
-`<committish>` does not intersect the first-parent histories of the
+_<commit-ish>_ does not intersect the first-parent histories of the
 filtered refs.
 
-describe[:options]::
+`describe[:<option>,...]`::
 	A human-readable name, like linkgit:git-describe[1];
 	empty string for undescribable commits. The `describe` string may
 	be followed by a colon and one or more comma-separated options.
 +
 --
-tags=<bool-value>;;
+`tags=<bool-value>`;;
 	Instead of only considering annotated tags, consider
 	lightweight tags as well; see the corresponding option in
 	linkgit:git-describe[1] for details.
-abbrev=<number>;;
-	Use at least <number> hexadecimal digits; see the corresponding
+`abbrev=<number>`;;
+	Use at least _<number>_ hexadecimal digits; see the corresponding
 	option in linkgit:git-describe[1] for details.
-match=<pattern>;;
-	Only consider tags matching the given `glob(7)` pattern,
-	excluding the "refs/tags/" prefix; see the corresponding option
+`match=<pattern>`;;
+	Only consider tags matching the `glob`(7) _<pattern>_,
+	excluding the `refs/tags/` prefix; see the corresponding option
 	in linkgit:git-describe[1] for details.
-exclude=<pattern>;;
-	Do not consider tags matching the given `glob(7)` pattern,
-	excluding the "refs/tags/" prefix; see the corresponding option
+`exclude=<pattern>`;;
+	Do not consider tags matching the `glob`(7) _<pattern>_,
+	excluding the `refs/tags/` prefix; see the corresponding option
 	in linkgit:git-describe[1] for details.
 --
 
@@ -366,7 +366,7 @@ variable (see linkgit:gitmailmap[5]).
 
 The raw data in an object is `raw`.
 
-raw:size::
+`raw:size`::
 	The raw data size of the object.
 
 Note that `--format=%(raw)` can not be used with `--python`, `--shell`, `--tcl`,
@@ -376,10 +376,10 @@ variable type.
 The message in a commit or a tag object is `contents`, from which
 `contents:<part>` can be used to extract various parts out of:
 
-contents:size::
+`contents:size`::
 	The size in bytes of the commit or tag message.
 
-contents:subject::
+`contents:subject`::
 	The first paragraph of the message, which typically is a
 	single line, is taken as the "subject" of the commit or the
 	tag message.
@@ -387,19 +387,19 @@ contents:subject::
 	obtain same results. `:sanitize` can be appended to `subject` for
 	subject line suitable for filename.
 
-contents:body::
+`contents:body`::
 	The remainder of the commit or the tag message that follows
 	the "subject".
 
-contents:signature::
+`contents:signature`::
 	The optional GPG signature of the tag.
 
-contents:lines=N::
-	The first `N` lines of the message.
+`contents:lines=<n>`::
+	The first _<n>_ lines of the message.
 
 Additionally, the trailers as interpreted by linkgit:git-interpret-trailers[1]
-are obtained as `trailers[:options]` (or by using the historical alias
-`contents:trailers[:options]`). For valid [:option] values see `trailers`
+are obtained as `trailers[:<option>,...]` (or by using the historical alias
+`contents:trailers[:<option>,...]`). For valid _<option>_ values see `trailers`
 section of linkgit:git-log[1].
 
 For sorting purposes, fields with numeric values sort in numeric order
@@ -419,8 +419,8 @@ option to linkgit:git-rev-list[1] takes). If this formatting is provided in
 a `--sort` key, references will be sorted according to the byte-value of the
 formatted string rather than the numeric value of the underlying timestamp.
 
-Some atoms like %(align) and %(if) always require a matching %(end).
-We call them "opening atoms" and sometimes denote them as %($open).
+Some atoms like `%(align)` and `%(if)` always require a matching `%(end)`.
+We call them "opening atoms" and sometimes denote them as `%($open)`.
 
 When a scripting language specific quoting is in effect, everything
 between a top-level opening atom and its matching %(end) is evaluated
@@ -438,7 +438,7 @@ An example directly producing formatted text.  Show the most recent
 #!/bin/sh
 
 git for-each-ref --count=3 --sort='-*authordate' \
---format='From: %(*authorname) %(*authoremail)
+`--format='From: %(*authorname) %(*authoremail)
 Subject: %(*subject)
 Date: %(*authordate)
 Ref: %(*refname)
@@ -449,7 +449,7 @@ Ref: %(*refname)
 
 
 A simple example showing the use of shell eval on the output,
-demonstrating the use of --shell.  List the prefixes of all heads:
+demonstrating the use of `--shell`.  List the prefixes of all heads:
 
 ------------
 #!/bin/sh
@@ -517,7 +517,7 @@ eval "$eval"
 ------------
 
 
-An example to show the usage of %(if)...%(then)...%(else)...%(end).
+An example to show the usage of `%(if)...%(then)...%(else)...%(end)`.
 This prefixes the current branch with a star.
 
 ------------
@@ -525,7 +525,7 @@ git for-each-ref --format="%(if)%(HEAD)%(then)* %(else)  %(end)%(refname:short)"
 ------------
 
 
-An example to show the usage of %(if)...%(then)...%(end).
+An example to show the usage of `%(if)...%(then)...%(end)`.
 This prints the authorname, if present.
 
 ------------
-- 
gitgitgadget

