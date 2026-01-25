Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004FD2F3612
	for <git@vger.kernel.org>; Sun, 25 Jan 2026 19:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769369283; cv=none; b=RgaI6wm5Zv5Wfwgdk/smSthqt1ms4b+gxOLdBp015sNJLgIzAPEK4Omv/+gqsrANVvBRpVBxYkCHGUEP3l1oBW1ftNxN1lCN9AUlN79gI6KSGLCiCZG0AIKyd46l4+ZU0n0a7dsJesgjbBoKsnd9aabUMHg4Hix6axsKfvm5zJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769369283; c=relaxed/simple;
	bh=Djl2m3yyl8XWKsxNkUF58P4wIkBK0l1D9+DqlKHVI50=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bKYpgFMzCCVLY2sQLJc9kcGa1u6eewvsdeTzC3AsV8kDzrHbU9v8X6YjlAHI+/KnAcqWbmC+tJKK2ngj84DjHs/GUNx93NA5k9DIUAlq+d5pzl+eKJrxhO979S9g9cRxMJ1q+ybSAbwJnVWPXyP1jhRINKEzH8zXK8uPHb4t0DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=BtEaSB0H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fcBBCMDl; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="BtEaSB0H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fcBBCMDl"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2EA3B1400031;
	Sun, 25 Jan 2026 14:28:00 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Sun, 25 Jan 2026 14:28:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1769369280;
	 x=1769455680; bh=tKEjkDCmnrAoqvD2zP0Vmzh5xwmt0STNENjJT5LWPR0=; b=
	BtEaSB0H/KdDDsa8HYd74TTR8dH97BZk6e8cwWhBola5clq6Ok+Et4KxKcWQXvoS
	3ZqdMy9mBuiTmWCBMqeQYOjp3pKJeTyV4YTBXn8nPeQtpxm83B9hut4zwLIYQXUL
	xQBdEbjoMT+mo9oKOH6rdglO+P79t5FI7DWQuGNYgE3GbnB3n/ZY9oqRcG/YJzU/
	5r9uHtSs0t/3SNOWsbhguU9/Nl5KBuwHblUnD0csoCi+JQKFCb3pc6AjbQyiTCkv
	Ay0TQ8hTSMg/9tQkZ7kdCnN8I3NfH+h5upviA1DZ0aAStPLeTtGxc/jBTilNJWh8
	jU2uH/6ImoLhpI+d8WAWVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769369280; x=
	1769455680; bh=tKEjkDCmnrAoqvD2zP0Vmzh5xwmt0STNENjJT5LWPR0=; b=f
	cBBCMDlw7fXxusctpY0WObCtoBYrECHnhmtA5vGQCsPgCxcFi7o59BWC3Dzjsy5P
	WObraFBzFbJcfOnW9xwPrdH3rgBOzKC6Gb4GDsqwThb3qjNMh5Vk/QdnuSmWMReu
	K3k577GvxlYYkamOF4j07bAE7LGECCl0S3FLUEwov2QT5/GRwuhB1oKInooXt5TP
	eSPETh7YwKyuFtW73fjxM9lpk3qSG69VsH+xuHYDaj9aSEMTMIk3a9ZAI86/M06a
	EJK9sMfbaJ2UeOz7rjmqmre0L5lKm5zXaQBRUsYDpmeUz+wq/eV4wq3NVh5erUVz
	PjVlRUy543rO2+uKXCQgQ==
X-ME-Sender: <xms:wG52aS3IUj5VWbYyd2Wn4JBiE2s92uZr9olKhtd0Zcg7p6qZHMAp1vs>
    <xme:wG52af58IlTOsxnf3T8_sHV31mANLsyu_NpKVgrNDYaVmF3TFLvTBcbvy1X33M80U
    fIDtO32Q9N6Kw6wvMGE0AYWgl375rxTnDmsUCtg8T-3KQN7YVZ3Tw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheehieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepheehieelvdeh
    hfdtgfehgffhudettdehfeejhfduhedtieevueeufeehgffhledunecuffhomhgrihhnpe
    gtohhnfhdrihhnnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtoh
    hmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehj
    nhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtghhithhgrggughgvth
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:wG52aVy3eJOfYr7t7e5FaS985E29vacjUbQga34SleYHkoPOO6aPwg>
    <xmx:wG52adA9vfgJS8B2wLKjEfZ_6qycuCvmCjkdUxWyw-1UkKJRwhbViA>
    <xmx:wG52aSatPbRIowF94qDnfwamcjqiKP3K6l7yREuvUbbjUX6wK6K2tA>
    <xmx:wG52aVhebMVs_uND1OF3KQyykB7EpgteX-18jOIBjceMuYz5Bym_Pw>
    <xmx:wG52abskCNDj1lPaeEM887XWoPQCoO4mAKSgHXxX5lt0jFoPB4ze_j4b>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F32381EA006C; Sun, 25 Jan 2026 14:27:59 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AC2L5HFm1BQs
Date: Sun, 25 Jan 2026 20:27:38 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: 
 =?UTF-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?= <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Message-Id: <51016c02-40de-431f-a4ba-e08cb1bb8235@app.fastmail.com>
In-Reply-To: 
 <d078e1d94fcf8511743787623f0c1abfd0321849.1769202903.git.gitgitgadget@gmail.com>
References: <pull.2036.git.1769202903.gitgitgadget@gmail.com>
 <d078e1d94fcf8511743787623f0c1abfd0321849.1769202903.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH 4/4] doc: convert git-show to synopsis style
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026, at 22:15, Jean-No=C3=ABl Avila via GitGitGadget wr=
ote:
> From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
>
>  * add synopsis block definition in asciidoc.conf.in

This is for e.g. ``<hash> <title-line>`` it looks like. Is the intent to
use italics on placeholders like `<hash>`?

>  * convert commands to synopsis style
>  * use _<placeholder>_ for arguments
>  * minor formatting fixes
>
> Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> ---
>  Documentation/asciidoc.conf.in    |   6 ++
>  Documentation/git-show.adoc       |  16 +--
>  Documentation/pretty-formats.adoc | 164 +++++++++++++++++-------------
>  3 files changed, 108 insertions(+), 78 deletions(-)
>
> diff --git a/Documentation/asciidoc.conf.in b/Documentation/asciidoc.c=
onf.in
> index ff9ea0a294..31b883a72c 100644
> --- a/Documentation/asciidoc.conf.in
> +++ b/Documentation/asciidoc.conf.in
>[snip]
> diff --git a/Documentation/git-show.adoc b/Documentation/git-show.adoc
> index 51044c814f..3b180e8c7a 100644
> --- a/Documentation/git-show.adoc
> +++ b/Documentation/git-show.adoc
> @@ -8,8 +8,8 @@ git-show - Show various types of objects
>
>  SYNOPSIS
>  --------
> -[verse]
> -'git show' [<options>] [<object>...]
> +[synopsis]
> +git show [<options>] [<object>...]

Looks good.

>
>  DESCRIPTION
>  -----------
> @@ -17,16 +17,16 @@ Shows one or more objects (blobs, trees, tags and =
commits).
>
>  For commits it shows the log message and textual diff. It also
>  presents the merge commit in a special format as produced by
> -'git diff-tree --cc'.
> +`git diff-tree --cc`.

Good.

>
>  For tags, it shows the tag message and the referenced objects.
>
> -For trees, it shows the names (equivalent to 'git ls-tree'
> -with --name-only).
> +For trees, it shows the names (equivalent to `git ls-tree`
> +with `--name-only`).

Again replacing (') with (`). Looks good.

>
>  For plain blobs, it shows the plain contents.
>
> -Some options that 'git log' command understands can be used to
> +Some options that `git log` command understands can be used to

Same here.

It could be nice to s/`git log` command/linkgit:git-log[1]/ either on
this commit or in a separate one.

>  control how the changes the commit introduces are shown.
>
>  This manual page describes only the most frequently used options.
> @@ -34,8 +34,8 @@ This manual page describes only the most frequently
> used options.
>
>  OPTIONS
>  -------
> -<object>...::
> -	The names of objects to show (defaults to 'HEAD').
> +`<object>...`::
> +	The names of objects to show (defaults to `HEAD`).

Looks correct in the HTML output.

>  	For a more complete list of ways to spell object names, see
>  	"SPECIFYING REVISIONS" section in linkgit:gitrevisions[7].
>
> diff --git a/Documentation/pretty-formats.adoc
> b/Documentation/pretty-formats.adoc
> index 2121e8e1df..5b73f03433 100644
> --- a/Documentation/pretty-formats.adoc
> +++ b/Documentation/pretty-formats.adoc
> @@ -18,54 +18,72 @@ config option to either another format name, or a
>  linkgit:git-config[1]). Here are the details of the
>  built-in formats:
>
> -* `oneline`
> -
> -	  <hash> <title-line>
> +`oneline`::
> ++
> +[synopsis]
> +--
> +`<hash> <title-line>`
> +--

HTML looks wrong in git-show(1) and others that include it. Something
like this:

    oneline
        __<hash>__ __<title-line>__

This doesn=E2=80=99t happen when I run asciidoc(1) or asciidoctor(1) dir=
ectly.

>  +
>  This is designed to be as compact as possible.
>
> -* `short`
> -
> -	  commit <hash>
> -	  Author: <author>
> -
> -	      <title-line>
> -
> -* `medium`
> -
> -	  commit <hash>
> -	  Author: <author>
> -	  Date:   <author-date>
> -
> -	      <title-line>
> +`short`::
> ++
> +[synopsis]
> +--
> +commit <hash>
> +Author: <author>
>
> -	      <full-commit-message>
> +    <title-line>
> +--
>
> -* `full`
> +`medium`::
> ++
> +[synopsis]
> +--
> +commit <hash>
> +Author: <author>
> +Date:   <author-date>
>
> -	  commit <hash>
> -	  Author: <author>
> -	  Commit: <committer>
> +    <title-line>
>
> -	      <title-line>
> +    <full-commit-message>
> +--
>
> -	      <full-commit-message>
> +`full`::
> ++
> +[synopsis]
> +--
> +commit <hash>
> +Author: <author>
> +Commit: <committer>
>
> -* `fuller`
> +    <title-line>
>
> -	  commit <hash>
> -	  Author:     <author>
> -	  AuthorDate: <author-date>
> -	  Commit:     <committer>
> -	  CommitDate: <committer-date>
> +    <full-commit-message>
> +--
>
> -	       <title-line>
> +`fuller`::
> ++
> +[synopsis]
> +--
> +commit <hash>
> +Author:     <author>
> +AuthorDate: <author-date>
> +Commit:     <committer>
> +CommitDate: <committer-date>
>
> -	       <full-commit-message>
> +     <title-line>
>
> -* `reference`
> +     <full-commit-message>
> +--
>
> -	  <abbrev-hash> (<title-line>, <short-author-date>)
> +`reference`::
> ++
> +[synopsis]
> +--
> +<abbrev-hash> (<title-line>, <short-author-date>)
> +--

(For these pretty formats) The diff got confused I think but the
conversion looks correct.


>  +
>  This format is used to refer to another commit in a commit message and
>  is the same as ++--pretty=3D\'format:%C(auto)%h (%s, %ad)'++.  By def=
ault,

Not changed in this patch but this doesn=E2=80=99t render correctly for =
me. It=E2=80=99s
not inline verbatim/code all the way through. But it is correct if I
remove the `\`.

I don=E2=80=99t know why `++` was used either.

> @@ -74,23 +92,24 @@ is explicitly specified.  As with any `format:` wi=
th format
>  placeholders, its output is not affected by other options like
>  `--decorate` and `--walk-reflogs`.
>
> -* `email`
> -
> -	  From <hash> <date>
> -	  From: <author>
> -	  Date: <author-date>
> -	  Subject: [PATCH] <title-line>
> +`email`::
> ++
> +[synopsis]
> +--
> +From <hash> <date>
> +From: <author>
> +Date: <author-date>
> +Subject: [PATCH] <title-line>
>
> -	  <full-commit-message>
> +<full-commit-message>
> +--

Good.

By the way. It renders with nice italic for placeholders. Again back to
the presumed point of these `[synopsis]` blocks.

>
> -* `mboxrd`
> -+
> +`mboxrd`::
>  Like `email`, but lines in the commit message starting with "From "
>  (preceded by zero or more ">") are quoted with ">" so they aren't
>  confused as starting a new commit.
>
> -* `raw`
> -+
> +`raw`::
>  The `raw` format shows the entire commit exactly as
>  stored in the commit object.  Notably, the hashes are
>  displayed in full, regardless of whether `--abbrev` or
> @@ -101,8 +120,7 @@ commits are displayed, but not the way the diff is
> shown e.g. with
>  `git log --raw`. To get full object names in a raw diff format,
>  use `--no-abbrev`.
>
> -* `format:<format-string>`
> -+
> +`format:<format-string>`::
>  The `format:<format-string>` format allows you to specify which
> information
>  you want to show. It works a little bit like printf format,
>  with the notable exception that you get a newline with `%n`
> @@ -120,13 +138,18 @@ The title was >>t4119: test autocomputing -p<n>
> for traditional diff input.<<
>  The placeholders are:
>
>  - Placeholders that expand to a single literal character:
> ++
> +--
>  ++%n++:: newline
>  ++%%++:: a raw ++%++
>  ++%x00++:: ++%x++ followed by two hexadecimal digits is replaced with=
 a
>  	 byte with the hexadecimal digits' value (we will call this
>  	 "literal formatting code" in the rest of this document).
> +--
>
>  - Placeholders that affect formatting of later placeholders:
> ++
> +--

The HTML structure here is correct.

>  ++%Cred++:: switch color to red
>  ++%Cgreen++:: switch color to green
>  ++%Cblue++:: switch color to blue
> @@ -181,8 +204,11 @@ The placeholders are:
>  ++%><|(++_<m>_++)++:: similar to ++%<(++_<n>_++)++, ++%<|(++_<m>_++)++
>  			 erespectively, but padding both sides
>  			  (i.e. the text is centered)
> +--
>
>  - Placeholders that expand to information extracted from the commit:
> ++
> +--
>  +%H+:: commit hash
>  +%h+:: abbreviated commit hash
>  +%T+:: tree hash
> @@ -233,36 +259,34 @@ colon and zero or more comma-separated options.
> Option values may contain
>  literal formatting codes. These must be used for commas (`%x2C`) and
> closing
>  parentheses (`%x29`), due to their role in the option syntax.

This looks correct just looking quickly over.

>
> -** `prefix=3D<value>`: Shown before the list of ref names.  Defaults =
to
> "{nbsp}++(++".

All of these use the "(" style which doesn=E2=80=99t look good in my
opinion. But I=E2=80=99m guessing it has to do with some of them using s=
paces in
them and `"` being used as a boundary.

> -** `suffix=3D<value>`: Shown after the list of ref names.  Defaults to
> "+)+".
> -** `separator=3D<value>`: Shown between ref names.  Defaults to
> "+,+{nbsp}".
> -** `pointer=3D<value>`: Shown between HEAD and the branch it points t=
o,
> if any.
> -		      Defaults to "{nbsp}++->++{nbsp}".
> -** `tag=3D<value>`: Shown before tag names. Defaults to "`tag:`{nbsp}=
".
> +`prefix=3D<value>`;; Shown before the list of ref names.  Defaults to
> "{nbsp}++(++".
> +`suffix=3D<value>`;; Shown after the list of ref names.  Defaults to
> "+)+".
> +`separator=3D<value>`;; Shown between ref names.  Defaults to
> "+,+{nbsp}".
> +`pointer=3D<value>`;; Shown between HEAD and the branch it points to,=
 if
> any.
> +	      Defaults to "{nbsp}++->++{nbsp}".
> +`tag=3D<value>`;; Shown before tag names. Defaults to "`tag:`{nbsp}".
>
>  +
> ---
>  For example, to produce decorations with no wrapping
>  or tag annotations, and spaces as separators:
> -
> ++
>  ++%(decorate:prefix=3D,suffix=3D,tag=3D,separator=3D )++
> ---
>
> -++%(describe++`[:<option>,...]`++)++::
> +++%(`describe++``[:<option>,...]`++)++::

This renders with backticks in HTML:

    %(describe++`[:<option>,...]`)++

>  human-readable name, like linkgit:git-describe[1]; empty string for
>  undescribable commits.  The `describe` string may be followed by a
> colon and
>  zero or more comma-separated options.  Descriptions can be
> inconsistent when
>  tags are added or removed at the same time.
>  +
> -** `tags[=3D<bool-value>]`: Instead of only considering annotated tag=
s,
> +`tags[=3D<bool-value>]`;; Instead of only considering annotated tags,
>     consider lightweight tags as well.
> -** `abbrev=3D<number>`: Instead of using the default number of
> hexadecimal digits
> +`abbrev=3D<number>`;; Instead of using the default number of hexadeci=
mal
> digits
>     (which will vary according to the number of objects in the
> repository with a
>     default of 7) of the abbreviated object name, use <number> digits,
> or as many
>     digits as needed to form a unique object name.
> -** `match=3D<pattern>`: Only consider tags matching the given
> +`match=3D<pattern>`;; Only consider tags matching the given
>     `glob(7)` _<pattern>_, excluding the `refs/tags/` prefix.
> -** `exclude=3D<pattern>`: Do not consider tags matching the given
> +`exclude=3D<pattern>`;; Do not consider tags matching the given
>     `glob(7)` _<pattern>_, excluding the `refs/tags/` prefix.
>
>  +%S+:: ref name given on the command line by which the commit was
> reached
> @@ -311,7 +335,7 @@ linkgit:git-interpret-trailers[1]. The `trailers`
> string may be followed by
>  a colon and zero or more comma-separated options. If any option is
> provided
>  multiple times, the last occurrence wins.
>  +
> -** `key=3D<key>`: only show trailers with specified <key>. Matching is
> done
> +`key=3D<key>`;; only show trailers with specified <key>. Matching is =
done
>     case-insensitively and trailing colon is optional. If option is
>     given multiple times trailer lines matching any of the keys are
>     shown. This option automatically enables the `only` option so that
> @@ -319,21 +343,21 @@ multiple times, the last occurrence wins.
>     desired it can be disabled with `only=3Dfalse`.  E.g.,
>     +%(trailers:key=3DReviewed-by)+ shows trailer lines with key
>     `Reviewed-by`.
> -** `only[=3D<bool>]`: select whether non-trailer lines from the trail=
er
> +`only[=3D<bool>]`;; select whether non-trailer lines from the trailer
>     block should be included.
> -** `separator=3D<sep>`: specify the separator inserted between trailer
> + `separator=3D<sep>`;; specify the separator inserted between trailer
>     lines. Defaults to a line feed character. The string <sep> may
> contain
>     the literal formatting codes described above. To use comma as
>     separator one must use `%x2C` as it would otherwise be parsed as
>     next option. E.g., +%(trailers:key=3DTicket,separator=3D%x2C )+
>     shows all trailer lines whose key is "Ticket" separated by a comma

Might as well s/"Ticket"/`Ticket`/ ?

>     and a space.
> -** `unfold[=3D<bool>]`: make it behave as if interpret-trailer's
> `--unfold`
> +`unfold[=3D<bool>]`;; make it behave as if interpret-trailer's `--unf=
old`
>     option was given. E.g.,
>     +%(trailers:only,unfold=3Dtrue)+ unfolds and shows all trailer lin=
es.
> -** `keyonly[=3D<bool>]`: only show the key part of the trailer.
> -** `valueonly[=3D<bool>]`: only show the value part of the trailer.
> -** `key_value_separator=3D<sep>`: specify the separator inserted betw=
een
> +`keyonly[=3D<bool>]`;; only show the key part of the trailer.
> +`valueonly[=3D<bool>]`;; only show the value part of the trailer.
> +`key_value_separator=3D<sep>`;; specify the separator inserted between
>     the key and value of each trailer. Defaults to ": ". Otherwise it
>     shares the same semantics as `separator=3D<sep>` above.
>
> @@ -360,9 +384,9 @@ placeholder expands to an empty string.
>  If you add a `' '` (space) after +%+ of a placeholder, a space
>  is inserted immediately before the expansion if and only if the
>  placeholder expands to a non-empty string.
> +--
>
> -* `tformat:`
> -+
> +`tformat:`::
>  The `tformat:` format works exactly like `format:`, except that it
>  provides "terminator" semantics instead of "separator" semantics. In
>  other words, each commit has the message terminator character (usuall=
y a
> --
> gitgitgadget

The rest looks okay.
