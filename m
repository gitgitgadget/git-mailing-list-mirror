Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC6B2F12AE
	for <git@vger.kernel.org>; Sun,  1 Feb 2026 12:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769948011; cv=none; b=n1i7lk0xeyYgIIksNBxXh6N4zX2zR3uBPDJeSYq6ozUg6UEajOOkQEn2NSZErGyW7yqfNW3TgU/zMunVlpQE4/UspwMjVgg3DrXRDxGSk20s2gfwnuC3NQ9TJ0DIfx+UdLNH/RgHUIUvjDDTzR0KDsfJTyarEib2/c46vCtQ4ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769948011; c=relaxed/simple;
	bh=p8Mvm7FCQ5tBN65/zA64Xq3xCvIuKlWgjPz6rinRlBI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lzRL2wDz7UU95HRN1EudZoPDlbALEF3o+AkspljcAWcaMBPENekSGVWdgiQbdiEz0ph0+l2R40CqK/gAQA1jkU+BpBNWLRvrO4/kGUZvLTZFh1lXlOX7Ov1Z94MFi/oI9bCd6MSoXVC07iHUiLIdouznxQoQU3MBz8CgKWGDjdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=YHfEVldF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J5d+caYO; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="YHfEVldF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J5d+caYO"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C3191EC0017;
	Sun,  1 Feb 2026 07:13:28 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Sun, 01 Feb 2026 07:13:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1769948008;
	 x=1770034408; bh=yC91YMyVMtbgq9DwoZ6IQMzlGNStwQQWzaMIjMtWcik=; b=
	YHfEVldFgIiKRT58VYbU9zzz5LIC0XnykgAViQldM44bKNLfaQRJiVywvP1BVlfD
	bgHVc+SvXDytlg+Z+S3ChQePtO10hT+l57Dr5SdUeB2xKoi9sfp2Tw/5UiMvBFbQ
	UMCRtFw8hgmmw7kyIEoYUtTL72JMhmyUm9B38a3oHlIiruJAPEbn5mlnQz0hCKH+
	9mJYtIdEqeZPsBij2RhUCj/liDDb6JXWRzb6ELeM1a88UlxjEsc3nYCgo7xniNYk
	V4P1wFhGNmDgnB2DSvXioTtt/SRmumQTW1oxQ45PWNOEsjzHdKfGSQx2dv6sVnqy
	Frx6EtbFJK13vkYifgRD4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1769948008; x=
	1770034408; bh=yC91YMyVMtbgq9DwoZ6IQMzlGNStwQQWzaMIjMtWcik=; b=J
	5d+caYOH8tlmL/M2tdmhKRCpUcfeni7P9Z6CGTDWpPaLM1k0XKsvxwWTwBbdDfx4
	nNJUKICwRZ+3CqNz3giFHDh64K/kvEIEhBIm79rGXheftnG+l1/cg2DNJsPNKRgA
	Wbf+ipQTF0Q7QXfhIVudW4xrPCjbJ1QXd/Lj2JlF8TXL1ZrEP5RDKqBpl6dBXqBD
	SeXsxlr4o+IDgttbrB9Oy1eSpsM4GU6Vj4hzGHZThYLDtGD5Wi5MM0KfpYtXC82N
	x64xd+BlO0mTLCbjJmwUjDkt4vpZLYzME02FoVpozQymFbJkFkviF3NvZdb4cgpR
	Pooy1uhSK6r2Sih3WIn8g==
X-ME-Sender: <xms:aEN_ac6V2NCW6tGuqr3IIvfA3f3QHXjNg1mkrrH1DRdAbut2E-FTIpQ>
    <xme:aEN_aYuwRRx5e0qjp5mJeoueAHkNyqJcFXJPMks3lAun0W1BD49ysWKvPWusm112A
    Hbf2rMh5WRABjQElMINSil0w1pFr4sk3Su0JGWaQC7LsANSZ8_cxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeegjeeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:aEN_aTUYkhCCJlAOjZHOhQTl7-4bxQv9FsHw5G0j6OHI9k63tFOmJw>
    <xmx:aEN_aTVwmn8ufy7J9j7RfVjv7uvhgjlXArr-wVFEHDnsP_WU18FR-w>
    <xmx:aEN_aSfgzuYTdHKt7k7zoPNyvcQ3hEo0_ClJU-mhkMzGbN5Yz3CXow>
    <xmx:aEN_acX7_aMfP-BCJFB4OFhDfJMkBizUaW_1DzyPKBhzielNPT6_qw>
    <xmx:aEN_aezQ-HzBNhO5wCJBCQAgPYnitisVv47888UIjqIs1mGlAc-D8TwW>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9E3D11EA006B; Sun,  1 Feb 2026 07:13:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AC2L5HFm1BQs
Date: Sun, 01 Feb 2026 13:12:47 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Message-Id: <14561b83-c976-46b2-a441-45fdeced1912@app.fastmail.com>
In-Reply-To: 
 <f6314e580d62702d84c7b173800f6e09c9a16ed4.1769462744.git.gitgitgadget@gmail.com>
References: <pull.2036.git.1769202903.gitgitgadget@gmail.com>
 <pull.2036.v2.git.1769462744.gitgitgadget@gmail.com>
 <f6314e580d62702d84c7b173800f6e09c9a16ed4.1769462744.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH v2 4/4] doc: convert git-show to synopsis style
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026, at 22:25, Jean-No=C3=ABl Avila via GitGitGadget wr=
ote:
> From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
>
>  * add synopsis block definition in asciidoc.conf.in
>  * convert commands to synopsis style
>  * use _<placeholder>_ for arguments
>  * minor formatting fixes
>
> Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> ---

I will go through and discuss both the markup as well as the HTML
rendering at the same time when relevant.

(Confession. I never check the man page output since I haven=E2=80=99t m=
anaged
to set it up. I don=E2=80=99t know if that is a potential reviewer blind=
spot.)

>  Documentation/asciidoc.conf.in    |   6 ++
>  Documentation/git-show.adoc       |  16 +--
>  Documentation/pretty-formats.adoc | 164 +++++++++++++++++-------------
>  3 files changed, 108 insertions(+), 78 deletions(-)
>
> diff --git a/Documentation/asciidoc.conf.in b/Documentation/asciidoc.c=
onf.in
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

Ok.

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

Ok.

>
>  For tags, it shows the tag message and the referenced objects.
>
> -For trees, it shows the names (equivalent to 'git ls-tree'
> -with --name-only).
> +For trees, it shows the names (equivalent to `git ls-tree`
> +with `--name-only`).

More conversion to backticks. Ok.

>
>  For plain blobs, it shows the plain contents.
>
> -Some options that 'git log' command understands can be used to
> +Some options that `git log` command understands can be used to

Like what was discussed in the last round it makes sense to use `git
log` instead of `linkgit` here.

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

synopsis-style argument markup and backticks. Ok.

>  	For a more complete list of ways to spell object names, see
>  	"SPECIFYING REVISIONS" section in linkgit:gitrevisions[7].
>
> diff --git a/Documentation/pretty-formats.adoc
> b/Documentation/pretty-formats.adoc
> index 2121e8e1df..806c588658 100644
> --- a/Documentation/pretty-formats.adoc
> +++ b/Documentation/pretty-formats.adoc
> @@ -18,54 +18,72 @@ config option to either another format name, or a
>  linkgit:git-config[1]). Here are the details of the
>  built-in formats:
>
> -* `oneline`
> -
> -	  <hash> <title-line>

Okay. This now looks good in the HTML output.

> +`oneline`::
> ++
> +[synopsis]
> +--
> +<hash> <title-line>
> +--

Also good. The `[synopsis]` gives us verbatim typeface for code and
italics/emphasis for placeholders. Just like inline backticks.

>  +
>  This is designed to be as compact as possible.
>
> -* `short`
> -
> -	  commit <hash>
> -	  Author: <author>

These have tab indent followed by two spaces. I=E2=80=99m guessing this =
is
intentional.

The HTML rendering looks good.

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
> +Author: <author><hash> <title-line>
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

Good. Things that are indented (like commit message) are correctly
indented here.

>  +
>  This format is used to refer to another commit in a commit message and
>  is the same as ++--pretty=3D\'format:%C(auto)%h (%s, %ad)'++.  By def=
ault,

Not a change here but while `--pretty...` has all the symbols it is
partly rendered, partly not.

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

>
> -* `mboxrd`
> -+
> +`mboxrd`::
>  Like `email`, but lines in the commit message starting with "From "
>  (preceded by zero or more ">") are quoted with ">" so they aren't
>  confused as starting a new commit.

Good.

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

All good.

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
>  ++%Cred++:: switch color to red
>  ++%Cgreen++:: switch color to green
>  ++%Cblue++:: switch color to blue

Good.

> @@ -181,8 +204,11 @@ The placeholders are:
>  ++%><|(++_<m>_++)++:: similar to ++%<(++_<n>_++)++, ++%<|(++_<m>_++)++
>  			  respectively, but padding both sides
>  			  (i.e. the text is centered)
> +--
>
>  - Placeholders that expand to information extracted from the commit:
> ++
> +--
>  +%H+:: commit hash
>  +%h+:: abbreviated commit hash
>  +%T+:: tree hash
> @@ -233,20 +259,18 @@ colon and zero or more comma-separated options.
> Option values may contain
>  literal formatting codes. These must be used for commas (`%x2C`) and
> closing
>  parentheses (`%x29`), due to their role in the option syntax.
>
> -** `prefix=3D<value>`: Shown before the list of ref names.  Defaults =
to
> "{nbsp}++(++".
> -** `suffix=3D<value>`: Shown after the list of ref names.  Defaults to
> "+)+".
> -** `separator=3D<value>`: Shown between ref names.  Defaults to
> "+,+{nbsp}".

These are rendered serviceably.

> -** `pointer=3D<value>`: Shown between HEAD and the branch it points t=
o,
> if any.
> -		      Defaults to "{nbsp}++->++{nbsp}".

This one is just `->` but it=E2=80=99s a bit confusing:

    " -> ".

(the spaces may be more narrow in the HTML?)

And the `-` has verbatim typeface while `>` does not.

I said the preceding ones were serviceable in the sense that they don=E2=
=80=99t
look great but you see what they are. This one is questionable.

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

Here I feel some deja vu.

>
>  +
> ---
>  For example, to produce decorations with no wrapping
>  or tag annotations, and spaces as separators:
> -
> ++
>  ++%(decorate:prefix=3D,suffix=3D,tag=3D,separator=3D )++
> ---

Here is a a problem. The pluses in `++...++` are apparently markup. But
the line starts with `+%` here:

    + %(decorate:prefix=3D,suffix=3D,tag=3D,separator=3D )

>
>  ++%(describe++`[:<option>,...]`++)++::
>  human-readable name, like linkgit:git-describe[1]; empty string for
> @@ -254,15 +278,15 @@ undescribable commits.  The `describe` string may
> be followed by a colon and
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

Need an edit here: s/<number>/_<number>_/

> or as many
>     digits as needed to form a unique object name.
> -** `match=3D<pattern>`: Only consider tags matching the given
> +`match=3D<pattern>`;; Only consider tags matching the given
>     `glob(7)` _<pattern>_, excluding the `refs/tags/` prefix.
> -** `exclude=3D<pattern>`: Do not consider tags matching the given
> +`exclude=3D<pattern>`;; Do not consider tags matching the given
>     `glob(7)` _<pattern>_, excluding the `refs/tags/` prefix.

Good.

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
> -   shows all trailer lines whose key is "Ticket" separated by a comma
> +   shows all trailer lines whose key is `Ticket` separated by a comma
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

All of this looks good.

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

Good.

> --
> gitgitgadget
