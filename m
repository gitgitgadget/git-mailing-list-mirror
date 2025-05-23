Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505522BCF44
	for <git@vger.kernel.org>; Fri, 23 May 2025 19:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748028714; cv=none; b=DuJ4dxw6VshXt5l8lo+G9SaSgsKoHQU4J7U3ioxAheuVyKcRWToee6oOIe/Zr8NjHFFJ/JvAoPHWdaH8kTJX+WlTfSaWSyQY3rF0v1GeHv8+Y3TB4lF0BvhA1nk/61PviVnzxAairJG6JTDU+VcC8cQzGbEO5l/B7fn3yS+gnPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748028714; c=relaxed/simple;
	bh=5D1BdQbgmKh/0o/CpiZfgluO+WsDaAd88F3nJecyIP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K8wchtWXSD126toHkKDQjI3XuH8kv87XwT/P0/oN/XRkTxdN27jph9iCCYuID7xbxF1mzqgu1pfAVo2n5196XD839Hh1Pgsqe+kdxdI3aM6WUuCPXBFh3uCD61EVzLywYapUV8ueMCLvNZt7Tkcv1cgNaYI7nFyLo7al+t2fLr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=EFzAXb6P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gs0s2aBM; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="EFzAXb6P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gs0s2aBM"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 417CF11400CE;
	Fri, 23 May 2025 15:31:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 23 May 2025 15:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748028710;
	 x=1748115110; bh=yUhNmtFLU9Xy2rBxbCC4s2GEhn9xxWvUXHPtb6pITY0=; b=
	EFzAXb6PdK/1R+Y4oT8sqlThUdagQW/xfHGik7n+EvtrHZNh7Pzly4StdJu68hBd
	4dISskD0U7dgRGY+7W5v7R9JOrErmajitOVWpCzGFFdgCz5Zuh7hNtMmWe29G5W3
	h9PWdKv5BBBD4cuqT5rqaSQAtBDEHN8ipz9mA7RFDU6mARWtJ3DBosHsQYiCPgO7
	XWnk2hcV5g1ifaeoXyWqqewjrnZt73Th1AO7UsYA/pt3G+3VqTpAJc9E6c2rsuXS
	XSPcz8if4Q7Kug/0t3h3YEHVQMsLiQdbeTl8H/TYkR8MAyvDhOuyHRe2Yal0cgeS
	AvhuGBcJy1QclVSJr8SP+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1748028710; x=
	1748115110; bh=yUhNmtFLU9Xy2rBxbCC4s2GEhn9xxWvUXHPtb6pITY0=; b=G
	s0s2aBMBi5zZGIv4zXLJiku4UkYa3tmbFQx6VU1CtoK4Ayb1ExhdX34/kRYkkq+b
	mlSiHId11An52+8b9aTPw3foOxl1vCDIhOa0sKn4d4gFqLtW3g/TWMjNE8pHrTC4
	KEfN5mBxeXhGFfmepmdFfWPyoYldmdvE/EeMUT8hFR964jlTIOVx2K2U11np+iNa
	1z7MsUxVjB+w7UyQAO5Y0OxWRVJ7rbUEIYaOMm1IOBhQcnClpGXPHafYvLEn+XHo
	24bhRefhPHjwijgYuuI4hUatzhm17xVNGdE1dFnV++WJNA1x/NrcjWetA2YAbfq4
	RuWGZBWcbkxTsV70l74fA==
X-ME-Sender: <xms:Jc0waGIEppWotRvWXwTNlFMKXwuJH7xazlW7ZtBvpmu0B885hfc6Zqk>
    <xme:Jc0waOIF7i1Ot-SjP-YXdcFPKnUBZ_psgv392qXAlHry7CC7zDyxgjs7u58ByVty6
    DHMmCpi32cPoV510A>
X-ME-Received: <xmr:Jc0waGvlWcdq7qMyIIVNPw6nmm6k5abeVjxvW7cMluLMOWlTTDRjhaIhxf7-IR9OqJdZ5ov_558EybVn2FtZ5h-K7AxRn-AQXvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdelieelucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgj
    fhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpedulefgueeiueet
    keelieefgedufeehteekhfejffekvdeuhedtvefhkeeikefhgfenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhh
    gruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdp
    rhgtphhtthhopeguhihrohhnvghtvghnghesghhmrghilhdrtghomhdprhgtphhtthhope
    gsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Jc0waLY87DJr0MZ9torhE750gNW7L5hiJ_rS61celS4n-z4chFH0RA>
    <xmx:Js0waNYhLfVNgTmi_vknUbeJyFJWvX8AjFyW-5BeMBDcJwkhLs838g>
    <xmx:Js0waHBIzDZAu9MF7jUlElF3DlEZlsroJMipjtdhowwzIdYnowAtPA>
    <xmx:Js0waDYJ7TepXeG18iHOM1-njXiOoZ2CKkErWpb07Jx0J0jlBEwWxw>
    <xmx:Js0waHUbtMs00eG5mVEuZpTKB3v4h61FQHxOCFz-PBOLzTp0NihZVT6a>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 May 2025 15:31:48 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>,
	Teng Long <dyroneteng@gmail.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v2 0/9] doc: --stdin on notes and core.commentChar mentions
Date: Fri, 23 May 2025 21:29:46 +0200
Message-ID: <cover.1748028010.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.49.0.780.g892193c3f50
In-Reply-To: <cover.1747763769.git.code@khaugsbakk.name>
References: <cover.1747763769.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

I wanted to fix `--stdin` in the git-notes(1) documentation.  Then I
found some other things on that doc as well as things to do with
`core.commentChar`.

§ Changes v2

Address the feedback on v1.

I discovered that patch “doc: notes: mention comment character
configuration” was misguided since

1. Mentioning the comment character isn’t really relevant anywhere
2. The text conflates `--[no-]stripspace` with handling comment lines,
   which is wrong

That patch is replaced with patches 4 and 5.

See the notes on the patches for details.

Kristoffer Haugsbakk (9):
  doc: stripspace: mention where the default comes from
  doc: config: mention core.commentChar on commit.cleanup
  doc: notes: split out options with negated forms
  doc: notes: rework --[no-]stripspace
  doc: notes: remove stripspace discussion from other options
  doc: notes: clearly state that --stripspace is the default
  doc: notes: point out copy --stdin use with argv
  doc: notes: treat --stdin equally between copy/remove
  doc: notes: use stuck form throughout

 Documentation/config/commit.adoc  |  7 +++--
 Documentation/git-notes.adoc      | 51 ++++++++++++++++++-------------
 Documentation/git-stripspace.adoc |  3 +-
 3 files changed, 36 insertions(+), 25 deletions(-)

Interdiff against v1:
diff --git a/Documentation/git-notes.adoc b/Documentation/git-notes.adoc
index 1542850eaaa..43436daeccc 100644
--- a/Documentation/git-notes.adoc
+++ b/Documentation/git-notes.adoc
@@ -151,26 +151,18 @@ OPTIONS
 	Use the given note message (instead of prompting).
 	If multiple `-m` options are given, their values
 	are concatenated as separate paragraphs.
-	Lines starting with `#` and empty lines other than a
-	single line between paragraphs will be stripped out.
-	If you wish to keep them verbatim, use `--no-stripspace`.
 
 `-F <file>`::
 `--file=<file>`::
 	Take the note message from the given file.  Use `-` to
 	read the note message from the standard input.
-	Lines starting with `#` and empty lines other than a
-	single line between paragraphs will be stripped out.
-	If you wish to keep them verbatim, use `--no-stripspace`.
 
 `-C <object>`::
 `--reuse-message=<object>`::
 	Take the given blob object (for example, another note) as the
 	note message. (Use `git notes copy <object>` instead to
-	copy notes between objects.).  By default, message will be
-	copied verbatim, but if you wish to strip out the lines
-	starting with `#` and empty lines other than a single line
-	between paragraphs, use with `--stripspace` option.
+	copy notes between objects.)  Implies `--no-stripspace` since
+	the default behavior is to copy the message verbatim.
 
 `-c <object>`::
 `--reedit-message=<object>`::
@@ -191,16 +183,23 @@ OPTIONS
 
 `--stripspace`::
 `--no-stripspace`::
-	Strip leading and trailing whitespace from the note message.
-	Also strip out empty lines other than a single line between
-	paragraphs. Lines starting with the comment character
-	(default `#`) will be stripped out
-	in non-editor cases like `-m`, `-F` and `-C`, but not in
-	editor case like `git notes edit`, `-c`, etc.
+	Clean up whitespace. Specifically (see
+	linkgit:git-stripspace[1]):
 +
-See `core.commentChar` in linkgit:git-config[1].
+--
+- remove trailing whitespace from all lines
+- collapse multiple consecutive empty lines into one empty line
+- remove empty lines from the beginning and end of the input
+- add a missing `\n` to the last line if necessary.
+--
++
+`--stripspace` is the default except for
+`-C`/`--reuse-message`. However, keep in mind that this depends on the
+order of similar options. For example, for `-C <object> -m<message>`,
+`--stripspace` will be used because the default for `-m` overrides the
+previous `-C`.
 
-`--ref <ref>`::
+`--ref=<ref>`::
 	Manipulate the notes tree in _<ref>_.  This overrides
 	`GIT_NOTES_REF` and the `core.notesRef` configuration.  The ref
 	specifies the full refname when it begins with `refs/notes/`; when it
@@ -212,9 +211,7 @@ See `core.commentChar` in linkgit:git-config[1].
 	object that does not have notes attached to it.
 
 `--stdin`::
-	For `remove` and `copy`. See the respective subcommands. This
-	option can be combined with object names given via the command
-	line for `remove`. However, this is not the case for `copy`.
+	For `remove` and `copy`. See the respective subcommands.
 
 `-n`::
 `--dry-run`::
diff --git a/Documentation/git-stripspace.adoc b/Documentation/git-stripspace.adoc
index 1132a4cf9a9..37287f211f0 100644
--- a/Documentation/git-stripspace.adoc
+++ b/Documentation/git-stripspace.adoc
@@ -37,8 +37,8 @@ OPTIONS
 -------
 -s::
 --strip-comments::
-	Skip and remove all lines starting with a comment character (default `#`).
-	See `core.commentChar` in linkgit:git-config[1].
+	Skip and remove all lines starting with a comment character
+	(`core.commentChar`, default `#`).
 
 -c::
 --comment-lines::
Range-diff against v1:
 -:  ----------- >  1:  bf3ea7f23c0 doc: stripspace: mention where the default comes from
 2:  b43b78aba63 =  2:  e9cf956a824 doc: config: mention core.commentChar on commit.cleanup
 3:  d2b6864b707 !  3:  14dc58120e3 doc: notes: split out options with negations
    @@ Metadata
     Author: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Commit message ##
    -    doc: notes: split out options with negations
    +    doc: notes: split out options with negated forms
     
         Split these out so that they are easier to search for.[1]
     
    @@ Commit message
     
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
    +
    + ## Notes (series) ##
    +    v2:
    +    • Message: Use “negated form” since that seems more typical
    +
      ## Documentation/git-notes.adoc ##
     @@ Documentation/git-notes.adoc: OPTIONS
      	Allow an empty note object to be stored. The default behavior is
 4:  f3f54a3537f !  4:  c68a91f81ba doc: notes: mention comment character configuration
    @@ Metadata
     Author: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Commit message ##
    -    doc: notes: mention comment character configuration
    +    doc: notes: rework --[no-]stripspace
    +
    +    Document this option by copying the bullet list from git-stripspace(1).
    +    A bullet list is cleaner when there are this many points to consider.
    +    We also get a more standardized description of the multiple-blank-lines
    +    behavior.  Compare the repeating (git-notes(1)):
    +
    +        empty lines other than a single line between paragraphs
    +
    +    With (git-stripspace(1)):
    +
    +        multiple consecutive empty lines
    +
    +    And:
    +
    +        leading [...] whitespace
    +
    +    With:
    +
    +        empty lines from the beginning
    +
    +    Leading whitespace in the form of spaces (indentation) are not removed.
    +    However, empty lines at the start of the message are removed.
    +
    +    Note that we drop the mentions of comment line handling because they are
    +    wrong; this option does not control how lines which can be recognized as
    +    comment lines are handled.  Only interactivity controls that:
    +
    +    • Comment lines are stripped after editing interactively
    +    • Lines which could be recognized as comment lines are left alone when
    +      the message is given non-interactively
    +
    +    So it is misleading to document the comment line behavior on
    +    this option.
    +
    +    Further, the text is wrong:
    +
    +        Lines starting with `#` will be stripped out in non-editor cases
    +        like `-m`, [...]
    +
    +    Comment lines are still indirectly discussed on other options.  We will
    +    deal with them in the next commit.
     
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
    +
    + ## Notes (series) ##
    +    v2:
    +    • New
    +    • Together with one other other patch replaces v1 patch “doc: notes:
    +      mention comment character configuration”
    +    • I figured out that mentioning the comment character/comment lines
    +      doesn’t make sense here.  So all attempts to rephrase “comment
    +      character” or “lines that start with `#`” are gone
    +
      ## Documentation/git-notes.adoc ##
     @@ Documentation/git-notes.adoc: OPTIONS
    + 
    + `--stripspace`::
      `--no-stripspace`::
    - 	Strip leading and trailing whitespace from the note message.
    - 	Also strip out empty lines other than a single line between
    +-	Strip leading and trailing whitespace from the note message.
    +-	Also strip out empty lines other than a single line between
     -	paragraphs. Lines starting with `#` will be stripped out
    -+	paragraphs. Lines starting with the comment character
    -+	(default `#`) will be stripped out
    - 	in non-editor cases like `-m`, `-F` and `-C`, but not in
    - 	editor case like `git notes edit`, `-c`, etc.
    +-	in non-editor cases like `-m`, `-F` and `-C`, but not in
    +-	editor case like `git notes edit`, `-c`, etc.
    ++	Clean up whitespace. Specifically (see
    ++	linkgit:git-stripspace[1]):
     ++
    -+See `core.commentChar` in linkgit:git-config[1].
    ++- remove trailing whitespace from all lines
    ++- collapse multiple consecutive empty lines into one empty line
    ++- remove empty lines from the beginning and end of the input
    ++- add a missing `\n` to the last line if necessary.
      
      `--ref <ref>`::
      	Manipulate the notes tree in _<ref>_.  This overrides
 1:  630ef019786 !  5:  f4755040f38 doc: stripspace: mention where the default comes from
    @@ Metadata
     Author: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Commit message ##
    -    doc: stripspace: mention where the default comes from
    +    doc: notes: remove stripspace discussion from other options
     
    -    Also quote `#` in line with the modern formatting convention.
    +    Cleaning up whitespace in metadata is typical porcelain behavior and
    +    this default does not need to be pointed out.[1]  Only speak up when
    +    the default `--stripspace` is not used.
    +
    +    Also remove all misleading mentions of comment lines in the process;
    +    see the previous commit.
    +
    +    Also remove the period that trails the parenthetical here.
    +
    +    † 1: See `-F` in git-commit(1) which has nothing to say about whitespace
    +        cleanup.  The cleanup discussion is on `--cleanup`.
     
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
     
      ## Notes (series) ##
    -    “modern formatting convention”
    -
    -    It looks like characters are quoted with backticks in the commits I’ve
    -    seen by Jean-Noël Avila lately.
    -
    - ## Documentation/git-stripspace.adoc ##
    -@@ Documentation/git-stripspace.adoc: OPTIONS
    - -------
    - -s::
    - --strip-comments::
    --	Skip and remove all lines starting with a comment character (default '#').
    -+	Skip and remove all lines starting with a comment character (default `#`).
    -+	See `core.commentChar` in linkgit:git-config[1].
    +    v2:
    +    • New
    +    • Together with one other patch replaces v1 patch “doc: notes:
    +      mention comment character configuration”
    +    • I figured out that mentioning the comment character/comment lines
    +      doesn’t make sense here.  So all attempts to rephrase “comment
    +      character” or “lines that start with `#`” are gone
    +
    + ## Documentation/git-notes.adoc ##
    +@@ Documentation/git-notes.adoc: OPTIONS
    + 	Use the given note message (instead of prompting).
    + 	If multiple `-m` options are given, their values
    + 	are concatenated as separate paragraphs.
    +-	Lines starting with `#` and empty lines other than a
    +-	single line between paragraphs will be stripped out.
    +-	If you wish to keep them verbatim, use `--no-stripspace`.
    + 
    + `-F <file>`::
    + `--file=<file>`::
    + 	Take the note message from the given file.  Use `-` to
    + 	read the note message from the standard input.
    +-	Lines starting with `#` and empty lines other than a
    +-	single line between paragraphs will be stripped out.
    +-	If you wish to keep them verbatim, use `--no-stripspace`.
    + 
    + `-C <object>`::
    + `--reuse-message=<object>`::
    + 	Take the given blob object (for example, another note) as the
    + 	note message. (Use `git notes copy <object>` instead to
    +-	copy notes between objects.).  By default, message will be
    +-	copied verbatim, but if you wish to strip out the lines
    +-	starting with `#` and empty lines other than a single line
    +-	between paragraphs, use with `--stripspace` option.
    ++	copy notes between objects.)  Implies `--no-stripspace` since
    ++	the default behavior is to copy the message verbatim.
      
    - -c::
    - --comment-lines::
    + `-c <object>`::
    + `--reedit-message=<object>`::
 -:  ----------- >  6:  be89c3349d2 doc: notes: clearly state that --stripspace is the default
 5:  cbb177479ca =  7:  d8a22847a7d doc: notes: point out copy --stdin use with argv
 6:  68e5eb78040 !  8:  3e8ecf1b668 doc: notes: treat --stdin equally between copy/remove
    @@ Commit message
     
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
    +
    + ## Notes (series) ##
    +    v2:
    +    • On --stdin: just refer to the respective subcommands and stop there.
    +      As suggested.
    +
    +      Link: https://lore.kernel.org/git/xmqq34czhyz8.fsf@gitster.g/
    +
      ## Documentation/git-notes.adoc ##
     @@ Documentation/git-notes.adoc: When done, the user can either finalize the merge with
      	giving zero or one object from the command line, this is
    @@ Documentation/git-notes.adoc: When done, the user can either finalize the merge
      
      `prune`::
      	Remove all notes for non-existing/unreachable objects.
    -@@ Documentation/git-notes.adoc: See `core.commentChar` in linkgit:git-config[1].
    +@@ Documentation/git-notes.adoc: previous `-C`.
      	object that does not have notes attached to it.
      
      `--stdin`::
     -	Also read the object names to remove notes from the standard
     -	input (there is no reason you cannot combine this with object
     -	names from the command line).
    -+	For `remove` and `copy`. See the respective subcommands. This
    -+	option can be combined with object names given via the command
    -+	line for `remove`. However, this is not the case for `copy`.
    ++	For `remove` and `copy`. See the respective subcommands.
      
      `-n`::
      `--dry-run`::
 -:  ----------- >  9:  73bdcaecae5 doc: notes: use stuck form throughout

base-commit: cb96e1697ad6e54d11fc920c95f82977f8e438f8
-- 
2.49.0.780.g892193c3f50

