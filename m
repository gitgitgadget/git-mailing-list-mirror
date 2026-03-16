Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6907364EA1
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 21:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773697744; cv=none; b=to4SUpR0gKQc7xTdRI6JaerofHTYPjPZbh/OgcXPcnCdgGeXa6jZxZCe+n+NSMmfX2Ai2vfHD29t5Et8jgamcvjAcYZHITaehGY1GFdrc5Av99CLjjLnmTBE732FsaIrjyxlAjG31UL6R+INteoJJUx9svSKe8CNHdxIRJP0/QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773697744; c=relaxed/simple;
	bh=W8WorUUrKh2Yik9O3X2SmdvphuAzSw+2aa7Mx8T0+LI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fm+0lSLbOUpsVyoLeIwQ6PhoRDaYQB8IUYZudrZYFr5/iVT+6TFgze0AxGXpTVSb6DF4C9w2ov8NprRmoXief8kiNtQxOan23Ny9pspo3JPfWARVKO0GSPoc+x88+CXm6/+kyZnO6zuaODLHI5AZSkNSkA/526kqdqmzbQpyMKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=URVqngIk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uJOZkeum; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="URVqngIk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uJOZkeum"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id BE9261D002ED;
	Mon, 16 Mar 2026 17:49:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 16 Mar 2026 17:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773697740;
	 x=1773784140; bh=DiIHidP/Mwy/+g4ciUsdZS+apRPfhCVoZFtkeOrMxvg=; b=
	URVqngIk5UoubSpVHxXG5E0fLNjP0c4Wj6eLLW1teb/b3mXzVfnQgWBOgzdBqpIt
	meIypT/a9APg1XY18m2AWR4MUWzZGS2Xsl0cJvZo3sBdxhDg4FAuwT4hWj2Ayqzu
	1+VQPJe52couhJRDHZjc7Bn3QMqX0Q9ju5US0g7XHvtUK/dRYfuHQXRbGbYW7+pT
	9SQLAVwcSDnrgst4CrY6vFlZTDRaPQ0nGkIH2MtsS0bBmDwL3ZU0YeIG9lGf5jhw
	wR3trqydB3QDazjp95TkkLUTg3BE+P0X9LwJz2PU6KRKSXfpAFeRQv1+4ECJZLKv
	9v8qbdJ34taNAe+wJE1ztg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773697740; x=
	1773784140; bh=DiIHidP/Mwy/+g4ciUsdZS+apRPfhCVoZFtkeOrMxvg=; b=u
	JOZkeum0i9ZGhBRMNQ0NZG2OVgjZLVg988tdDgD2OxsbFF5vql0GR9VD5skoBFVE
	esp9iZTIwuLzaZhQRmeM8qUleECq51vswjWRa11TVdwKHCuaOfbeaxS9FwUHr2tH
	IYuYUss6E/YVAyzz3q8O6VHrYCqHUAxpoGv4bYNgQut7NZgytwRfz0EG+aBtWK3m
	B1frYFdINkIBmJHoY4mGKvBoBSKLKLzSgEzyAhcSdRuZrtv1+vOovBVDPB5aFBCB
	JvDqnvDqtbFZfLwFAQd4yjU4KeT3eAMs14BTULZTV54kitWpxXO4+i7HX1vknf3X
	2oRUR7M9c3RuUlVE2htFg==
X-ME-Sender: <xms:zHq4aS1JF9wS2NOTrEvjQTnGZGlYE80CGFZYZJmBaKm58AY-0S2xKcQ>
    <xme:zHq4aciN9s59xAvAsdVX1_u122-ureS7C3V9j6T6FiQrX8qSktBgKWwMGAgGtbfA-
    o9tVmKY3VHxpj7wX5-UK0_NolbbtOlcfeKro9TO49wQI4Ej1NIopN0>
X-ME-Received: <xmr:zHq4aYQWOvtEq7u_G74nW6cuqhx5KzDBrhQFhw3Tc-cSIVS4U64raEQk35AC_DwHBSk8lFwgHoh1UyC5SryHWWJG6XDs44ri_wH0wjc-rEHxuPc3y5OWSRTTYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleelhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmnecuggftrfgrthhtvghrnhephffggeelhfejkefgteelteejhfetieehgeef
    tdduudffgeejhfektedugefghfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepjhhnrdgrvhhilhgrse
    hfrhgvvgdrfhhr
X-ME-Proxy: <xmx:zHq4adixcErzrqKafAezVjeTLO_d7HiThSweRKiUyptM1XTHYzU8Cg>
    <xmx:zHq4aY5ERZ_uHibJL_niXIt0p1YkjGDnsaHvESvePUchZgGDJThk7A>
    <xmx:zHq4aaBFj22RnFho9fgn9mscNLC1tPH3FrenuGF3qmxmM_M-ND1rVw>
    <xmx:zHq4afZu4bul_89PxHy2fE7O_jKCO3elO5z0AcvYlCc9o2JqPi0qgQ>
    <xmx:zHq4aSJNbGUtrgxYCYQTu71SrlqzbnZRP60WscgRk65Gl6GFpri7jZcY>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 17:48:58 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH v2 0/4] doc: interpret-trailers: convert to synopsis and update options
Date: Mon, 16 Mar 2026 22:48:23 +0100
Message-ID: <V2_CV_doc_interpret-tr_synopsis.50a@msgid.xyz>
X-Mailer: git-send-email 2.53.0.32.gf6228eaf9cc
In-Reply-To: <CV_doc_interpret-tr_synopsis.48a@msgid.xyz>
References: <CV_doc_interpret-tr_synopsis.48a@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Topic name (applied): doc-interpret-trailers-1

Topic summary: Convert to synopsis style and update options.

§ Changes in v2

Apply changes from reviews by Jean-Noël and Junio. See the notes on the
patches for details.

The last patch is new. To use `trailer.<key-alias>` instead of `trailer.*`
in the source code (translation strings), in line with the docs.

[1/4] doc: interpret-trailers: convert to synopsis style
[2/4] doc: interpret-trailers: normalize and fill out options
[3/4] doc: config: convert trailers section to synopsis style
[4/4] interpret-trailers: use placeholder instead of *

 Documentation/config/trailer.adoc         | 121 +++++++-------
 Documentation/git-interpret-trailers.adoc | 193 ++++++++++++----------
 builtin/interpret-trailers.c              |   2 +-
 3 files changed, 169 insertions(+), 147 deletions(-)

Interdiff against v1:
diff --git a/Documentation/config/trailer.adoc b/Documentation/config/trailer.adoc
index a382f68fe9e..1bc70192d3a 100644
--- a/Documentation/config/trailer.adoc
+++ b/Documentation/config/trailer.adoc
@@ -70,13 +70,13 @@ With `add`, a new trailer will be added.
 +
 With `doNothing`, nothing will be done.
 
-`trailer.<keyAlias>.key`::
-	Defines a _<keyAlias>_ for the _<key>_. The _<keyAlias>_ must be a
+`trailer.<key-alias>.key`::
+	Defines a _<key-alias>_ for the _<key>_. The _<key-alias>_ must be a
 	prefix (case does not matter) of the _<key>_. For example, in `git
 	config trailer.ack.key "Acked-by"` the `Acked-by` is the _<key>_ and
-	the `ack` is the _<keyAlias>_. This configuration allows the shorter
+	the `ack` is the _<key-alias>_. This configuration allows the shorter
 	`--trailer "ack:..."` invocation on the command line using the "ack"
-	`<keyAlias>` instead of the longer `--trailer "Acked-by:..."`.
+	`<key-alias>` instead of the longer `--trailer "Acked-by:..."`.
 +
 At the end of the _<key>_, a separator can appear and then some
 space characters. By default the only valid separator is `:`,
@@ -86,24 +86,24 @@ variable.
 If there is a separator in the key, then it overrides the default
 separator when adding the trailer.
 
-`trailer.<keyAlias>.where`::
+`trailer.<key-alias>.where`::
 	This option takes the same values as the `trailer.where`
 	configuration variable and it overrides what is specified by
-	that option for trailers with the specified _<keyAlias>_.
+	that option for trailers with the specified _<key-alias>_.
 
-`trailer.<keyAlias>.ifexists`::
+`trailer.<key-alias>.ifexists`::
 	This option takes the same values as the `trailer.ifexists`
 	configuration variable and it overrides what is specified by
-	that option for trailers with the specified _<keyAlias>_.
+	that option for trailers with the specified _<key-alias>_.
 
-`trailer.<keyAlias>.ifmissing`::
+`trailer.<key-alias>.ifmissing`::
 	This option takes the same values as the `trailer.ifmissing`
 	configuration variable and it overrides what is specified by
-	that option for trailers with the specified _<keyAlias>_.
+	that option for trailers with the specified _<key-alias>_.
 
-`trailer.<keyAlias>.command`::
-	Deprecated in favor of `trailer.<keyAlias>.cmd`.
-	This option behaves in the same way as `trailer.<keyAlias>.cmd`, except
+`trailer.<key-alias>.command`::
+	Deprecated in favor of `trailer.<key-alias>.cmd`.
+	This option behaves in the same way as `trailer.<key-alias>.cmd`, except
 	that it doesn't pass anything as argument to the specified command.
 	Instead the first occurrence of substring `$ARG` is replaced by the
 	_<value>_ that would be passed as argument.
@@ -111,27 +111,27 @@ separator when adding the trailer.
 Note that `$ARG` in the user's command is
 only replaced once and that the original way of replacing `$ARG` is not safe.
 +
-When both `trailer.<keyAlias>.cmd` and `trailer.<keyAlias>.command` are given
-for the same _<keyAlias>_, `trailer.<keyAlias>.cmd` is used and
-`trailer.<keyAlias>.command` is ignored.
+When both `trailer.<key-alias>.cmd` and `trailer.<key-alias>.command` are given
+for the same _<key-alias>_, `trailer.<key-alias>.cmd` is used and
+`trailer.<key-alias>.command` is ignored.
 
-`trailer.<keyAlias>.cmd`::
+`trailer.<key-alias>.cmd`::
 	This option can be used to specify a shell command that will be called
-	once to automatically add a trailer with the specified _<keyAlias>_, and then
-	called each time a `--trailer <keyAlias>=<value>` argument is specified to
+	once to automatically add a trailer with the specified _<key-alias>_, and then
+	called each time a `--trailer <key-alias>=<value>` argument is specified to
 	modify the _<value>_ of the trailer that this option would produce.
 +
 When the specified command is first called to add a trailer
-with the specified _<keyAlias>_, the behavior is as if a special
-`--trailer <keyAlias>=<value>` argument was added at the beginning
+with the specified _<key-alias>_, the behavior is as if a special
+`--trailer <key-alias>=<value>` argument was added at the beginning
 of linkgit:git-interpret-trailers[1], where _<value>_ is taken to be the
 standard output of the command with any leading and trailing whitespace
 trimmed off.
 +
-If some `--trailer <keyAlias>=<value>` arguments are also passed
+If some `--trailer <key-alias>=<value>` arguments are also passed
 on the command line, the command is called again once for each
-of these arguments with the same _<keyAlias>_. And the _<value>_ part
+of these arguments with the same _<key-alias>_. And the _<value>_ part
 of these arguments, if any, will be passed to the command as its
 first argument. This way the command can produce a _<value>_ computed
-from the _<value>_ passed in the `--trailer <keyAlias>=<value>`
+from the _<value>_ passed in the `--trailer <key-alias>=<value>`
 argument.
diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index e5da0462fad..77b4f63b05c 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -35,11 +35,12 @@ If `--parse` is specified, the output consists of the parsed trailers
 coming from the input, without influencing them with any command line
 options or configuration variables.
 
-Otherwise, this command applies `trailer.*` configuration variables
-(which could potentially add new trailers, as well as reposition them),
-as well as any command line arguments that can override configuration
-variables (such as `--trailer=...` which could also add new trailers),
-to each input file. The result is emitted on the standard output.
+Otherwise, this command applies `trailer.<key-alias>` configuration
+variables (which could potentially add new trailers, as well as
+reposition them), as well as any command line arguments that can
+override configuration variables (such as `--trailer=...` which could
+also add new trailers), to each input file. The result is emitted on the
+standard output.
 
 This command can also operate on the output of linkgit:git-format-patch[1],
 which is more elaborate than a plain commit message. Namely, such output
@@ -65,11 +66,11 @@ key: value
 ------------------------------------------------
 
 This means that the trimmed _<key>_ and _<value>_ will be separated by
-": " (one colon followed by one space).
+"`:`{nbsp}" (one colon followed by one space).
 
 For convenience, a _<key-alias>_ can be configured to make using `--trailer`
 shorter to type on the command line. This can be configured using the
-`trailer.<key-alias>.key` configuration variable. The _<keyAlias>_ must be a prefix
+`trailer.<key-alias>.key` configuration variable. The _<key-alias>_ must be a prefix
 of the full _<key>_ string, although case sensitivity does not matter. For
 example, if you have
 
@@ -135,7 +136,7 @@ Use `--no-trailer` to reset the list.
 `--no-where`::
 	Specify where all new trailers will be added.  A setting
 	provided with `--where` overrides the `trailer.where` and any
-	applicable `trailer.<keyAlias>.where` configuration variables
+	applicable `trailer.<key-alias>.where` configuration variables
 	and applies to all `--trailer` options until the next occurrence of
 	`--where` or `--no-where`. Possible placements are `after`,
 	`before`, `end` or `start`.
@@ -148,7 +149,7 @@ such that the relevant configuration variables are no longer overridden.
 	Specify what action will be performed when there is already at
 	least one trailer with the same _<key>_ in the input.  A setting
 	provided with `--if-exists` overrides the `trailer.ifExists` and any
-	applicable `trailer.<keyAlias>.ifExists` configuration variables
+	applicable `trailer.<key-alias>.ifExists` configuration variables
 	and applies to all `--trailer` options until the next occurrence of
 	`--if-exists` or `--no-if-exists`. Possible actions are `addIfDifferent`,
 	`addIfDifferentNeighbor`, `add`, `replace` and `doNothing`.
@@ -162,7 +163,7 @@ longer overridden.
 	Specify what action will be performed when there is no other
 	trailer with the same _<key>_ in the input.  A setting
 	provided with `--if-missing` overrides the `trailer.ifMissing` and any
-	applicable `trailer.<keyAlias>.ifMissing` configuration variables
+	applicable `trailer.<key-alias>.ifMissing` configuration variables
 	and applies to all `--trailer` options until the next occurrence of
 	`--if-missing` or `--no-if-missing`. Possible actions are
 	`doNothing` or `add`.
@@ -179,7 +180,7 @@ longer overridden.
 `--only-input`::
 `--no-only-input`::
 	Output only trailers that exist in the input; do not add any
-	from the command-line or by applying `trailer.*` configuration
+	from the command-line or by applying `trailer.<key-alias>` configuration
 	variables. The default is `--no-only-input`.
 
 `--unfold`::
@@ -260,8 +261,8 @@ $ git interpret-trailers --trailer 'Cc: Alice <alice@example.com>' --trailer 'Re
 ------------
 
 * Configure a `sign` trailer with a command to automatically add a
-  "Signed-off-by: " with the author information only if there is no
-  "Signed-off-by: " already, and show how it works:
+  "`Signed-off-by:`{nbsp}" with the author information only if there is no
+  "`Signed-off-by:`{nbsp}" already, and show how it works:
 +
 ------------
 $ cat msg1.txt
@@ -379,8 +380,8 @@ See-also: fe3187489d69c4 (subject of related commit)
 * Configure a commit template with some trailers with empty values
   (using sed to show and keep the trailing spaces at the end of the
   trailers), then configure a commit-msg hook that uses
-  linkgit:git-interpret-trailers[1] to remove trailers with empty values and
-  to add a `git-version` trailer:
+  git-interpret-trailers(1) to remove trailers with empty values and to
+  add a `git-version` trailer:
 +
 ------------
 $ cat temp.txt
diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 41b0750e5af..4b617c3ecb0 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -211,7 +211,7 @@ int cmd_interpret_trailers(int argc,
 			     N_("action if trailer is missing"), option_parse_if_missing),
 
 		OPT_BOOL(0, "only-trailers", &opts.only_trailers, N_("output only the trailers")),
-		OPT_BOOL(0, "only-input", &opts.only_input, N_("do not apply trailer.* configuration variables")),
+		OPT_BOOL(0, "only-input", &opts.only_input, N_("do not apply trailer.<key-alias> configuration variables")),
 		OPT_BOOL(0, "unfold", &opts.unfold, N_("reformat multiline trailer values as single-line values")),
 		OPT_CALLBACK_F(0, "parse", &opts, NULL, N_("alias for --only-trailers --only-input --unfold"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG, parse_opt_parse),
Range-diff against v1:
1:  87ec90d0adb ! 1:  f9a4622feaf doc: interpret-trailers: convert to synopsis style
    @@ Commit message
         2025-10-05) for the markup rules for this style.
     
         There aren’t many subtleties to the transformation of this doc since it
    -    doesn’t use any advanced constructs. The only thing is that `": "` is
    +    doesn’t use any advanced constructs. The only thing is that "`:`{nbsp}" is
         used instead of `': '` to refer to effective inline-verbatim with
    -    a space (␠). I also use (_) for emphasis although (') gives the
    +    a space (␠).[1] I also use (_) for emphasis although (') gives the
         same result.
     
    -    Also prefer linking to Git commands instead of saying
    -    e.g. `git format-patch`.
    +    Also prefer linking to Git commands instead of saying e.g. `git
    +    format-patch`. But for this command we can type out git-interpret-
    +    trailers(1) to avoid a self-reference.
    +
    +    Also replace camel case `<keyAlias>` with kebab case `<key-alias>`.
    +    And while doing that make sure to replace `trailer.*` with
    +    `trailer.<key-alias>`.
    +
    +    † 1: Similar to "`tag:`{nbsp}" in `Documentation/pretty-formats.adoc`
     
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
    @@ Documentation/git-interpret-trailers.adoc: Signed-off-by: Alice <alice@example.c
      If `--parse` is specified, the output consists of the parsed trailers
      coming from the input, without influencing them with any command line
      options or configuration variables.
    -@@ Documentation/git-interpret-trailers.adoc: to each input file. The result is emitted on the standard output.
    + 
    +-Otherwise, this command applies `trailer.*` configuration variables
    +-(which could potentially add new trailers, as well as reposition them),
    +-as well as any command line arguments that can override configuration
    +-variables (such as `--trailer=...` which could also add new trailers),
    +-to each input file. The result is emitted on the standard output.
    ++Otherwise, this command applies `trailer.<key-alias>` configuration
    ++variables (which could potentially add new trailers, as well as
    ++reposition them), as well as any command line arguments that can
    ++override configuration variables (such as `--trailer=...` which could
    ++also add new trailers), to each input file. The result is emitted on the
    ++standard output.
      
      This command can also operate on the output of linkgit:git-format-patch[1],
      which is more elaborate than a plain commit message. Namely, such output
    @@ Documentation/git-interpret-trailers.adoc: are applied to each input and the way
     -This means that the trimmed <key> and <value> will be separated by
     -`': '` (one colon followed by one space).
     +This means that the trimmed _<key>_ and _<value>_ will be separated by
    -+": " (one colon followed by one space).
    ++"`:`{nbsp}" (one colon followed by one space).
      
     -For convenience, a <key-alias> can be configured to make using `--trailer`
     +For convenience, a _<key-alias>_ can be configured to make using `--trailer`
      shorter to type on the command line. This can be configured using the
     -'trailer.<key-alias>.key' configuration variable. The <keyAlias> must be a prefix
     -of the full <key> string, although case sensitivity does not matter. For
    -+`trailer.<key-alias>.key` configuration variable. The _<keyAlias>_ must be a prefix
    ++`trailer.<key-alias>.key` configuration variable. The _<key-alias>_ must be a prefix
     +of the full _<key>_ string, although case sensitivity does not matter. For
      example, if you have
      
    @@ Documentation/git-interpret-trailers.adoc: rules for RFC 822 headers. For exampl
     +`--no-where`::
      	Specify where all new trailers will be added.  A setting
     -	provided with '--where' overrides the `trailer.where` and any
    -+	provided with `--where` overrides the `trailer.where` and any
    - 	applicable `trailer.<keyAlias>.where` configuration variables
    +-	applicable `trailer.<keyAlias>.where` configuration variables
     -	and applies to all '--trailer' options until the next occurrence of
     -	'--where' or '--no-where'. Upon encountering '--no-where', clear the
     -	effect of any previous use of '--where', such that the relevant configuration
    ++	provided with `--where` overrides the `trailer.where` and any
    ++	applicable `trailer.<key-alias>.where` configuration variables
     +	and applies to all `--trailer` options until the next occurrence of
     +	`--where` or `--no-where`. Upon encountering `--no-where`, clear the
     +	effect of any previous use of `--where`, such that the relevant configuration
    @@ Documentation/git-interpret-trailers.adoc: rules for RFC 822 headers. For exampl
      	Specify what action will be performed when there is already at
     -	least one trailer with the same <key> in the input.  A setting
     -	provided with '--if-exists' overrides the `trailer.ifExists` and any
    -+	least one trailer with the same _<key>_ in the input.  A setting
    -+	provided with `--if-exists` overrides the `trailer.ifExists` and any
    - 	applicable `trailer.<keyAlias>.ifExists` configuration variables
    +-	applicable `trailer.<keyAlias>.ifExists` configuration variables
     -	and applies to all '--trailer' options until the next occurrence of
     -	'--if-exists' or '--no-if-exists'. Upon encountering '--no-if-exists', clear the
     -	effect of any previous use of '--if-exists', such that the relevant configuration
    ++	least one trailer with the same _<key>_ in the input.  A setting
    ++	provided with `--if-exists` overrides the `trailer.ifExists` and any
    ++	applicable `trailer.<key-alias>.ifExists` configuration variables
     +	and applies to all `--trailer` options until the next occurrence of
     +	`--if-exists` or `--no-if-exists`. Upon encountering `--no-if-exists`, clear the
     +	effect of any previous use of `--if-exists`, such that the relevant configuration
    @@ Documentation/git-interpret-trailers.adoc: rules for RFC 822 headers. For exampl
      	Specify what action will be performed when there is no other
     -	trailer with the same <key> in the input.  A setting
     -	provided with '--if-missing' overrides the `trailer.ifMissing` and any
    -+	trailer with the same _<key>_ in the input.  A setting
    -+	provided with `--if-missing` overrides the `trailer.ifMissing` and any
    - 	applicable `trailer.<keyAlias>.ifMissing` configuration variables
    +-	applicable `trailer.<keyAlias>.ifMissing` configuration variables
     -	and applies to all '--trailer' options until the next occurrence of
     -	'--if-missing' or '--no-if-missing'. Upon encountering '--no-if-missing',
     -	clear the effect of any previous use of '--if-missing', such that the relevant
    ++	trailer with the same _<key>_ in the input.  A setting
    ++	provided with `--if-missing` overrides the `trailer.ifMissing` and any
    ++	applicable `trailer.<key-alias>.ifMissing` configuration variables
     +	and applies to all `--trailer` options until the next occurrence of
     +	`--if-missing` or `--no-if-missing`. Upon encountering `--no-if-missing`,
     +	clear the effect of any previous use of `--if-missing`, such that the relevant
    @@ Documentation/git-interpret-trailers.adoc: rules for RFC 822 headers. For exampl
     ---only-input::
     +`--only-input`::
      	Output only trailers that exist in the input; do not add any
    - 	from the command-line or by applying `trailer.*` configuration
    +-	from the command-line or by applying `trailer.*` configuration
    ++	from the command-line or by applying `trailer.<key-alias>` configuration
      	variables.
      
     ---unfold::
    @@ Documentation/git-interpret-trailers.adoc: $ git format-patch -1
     -  'Signed-off-by: ' with the author information only if there is no
     -  'Signed-off-by: ' already, and show how it works:
     +* Configure a `sign` trailer with a command to automatically add a
    -+  "Signed-off-by: " with the author information only if there is no
    -+  "Signed-off-by: " already, and show how it works:
    ++  "`Signed-off-by:`{nbsp}" with the author information only if there is no
    ++  "`Signed-off-by:`{nbsp}" already, and show how it works:
      +
      ------------
      $ cat msg1.txt
    @@ Documentation/git-interpret-trailers.adoc: See-also: fe3187489d69c4 (subject of
        trailers), then configure a commit-msg hook that uses
     -  'git interpret-trailers' to remove trailers with empty values and
     -  to add a 'git-version' trailer:
    -+  linkgit:git-interpret-trailers[1] to remove trailers with empty values and
    -+  to add a `git-version` trailer:
    ++  git-interpret-trailers(1) to remove trailers with empty values and to
    ++  add a `git-version` trailer:
      +
      ------------
      $ cat temp.txt
2:  e24f8a3d37e ! 2:  e04853c499e doc: interpret-trailers: normalize and fill out options
    @@ Documentation/git-interpret-trailers.adoc: rules for RFC 822 headers. For exampl
      `--no-where`::
      	Specify where all new trailers will be added.  A setting
      	provided with `--where` overrides the `trailer.where` and any
    - 	applicable `trailer.<keyAlias>.where` configuration variables
    + 	applicable `trailer.<key-alias>.where` configuration variables
      	and applies to all `--trailer` options until the next occurrence of
     -	`--where` or `--no-where`. Upon encountering `--no-where`, clear the
     -	effect of any previous use of `--where`, such that the relevant configuration
    @@ Documentation/git-interpret-trailers.adoc: rules for RFC 822 headers. For exampl
      	Specify what action will be performed when there is already at
      	least one trailer with the same _<key>_ in the input.  A setting
      	provided with `--if-exists` overrides the `trailer.ifExists` and any
    - 	applicable `trailer.<keyAlias>.ifExists` configuration variables
    + 	applicable `trailer.<key-alias>.ifExists` configuration variables
      	and applies to all `--trailer` options until the next occurrence of
     -	`--if-exists` or `--no-if-exists`. Upon encountering `--no-if-exists`, clear the
     -	effect of any previous use of `--if-exists`, such that the relevant configuration
    @@ Documentation/git-interpret-trailers.adoc: rules for RFC 822 headers. For exampl
      	Specify what action will be performed when there is no other
      	trailer with the same _<key>_ in the input.  A setting
      	provided with `--if-missing` overrides the `trailer.ifMissing` and any
    - 	applicable `trailer.<keyAlias>.ifMissing` configuration variables
    + 	applicable `trailer.<key-alias>.ifMissing` configuration variables
      	and applies to all `--trailer` options until the next occurrence of
     -	`--if-missing` or `--no-if-missing`. Upon encountering `--no-if-missing`,
     -	clear the effect of any previous use of `--if-missing`, such that the relevant
    @@ Documentation/git-interpret-trailers.adoc: rules for RFC 822 headers. For exampl
      `--only-input`::
     +`--no-only-input`::
      	Output only trailers that exist in the input; do not add any
    - 	from the command-line or by applying `trailer.*` configuration
    + 	from the command-line or by applying `trailer.<key-alias>` configuration
     -	variables.
     +	variables. The default is `--no-only-input`.
      
3:  10f11ebb078 ! 3:  ed1eb37b935 doc: config: convert trailers section to synopsis style
    @@ Commit message
         Convert this part of the configuration documentation to synopsis style
         so that all of git-interpret-trailers(1) is consistent.
     
    +    See the commit message from two commits ago.
    +
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Documentation/config/trailer.adoc ##
    @@ Documentation/config/trailer.adoc: With `add`, a new trailer will be added.
     -	prefix (case does not matter) of the <key>. For example, in `git
     -	config trailer.ack.key "Acked-by"` the "Acked-by" is the <key> and
     -	the "ack" is the <keyAlias>. This configuration allows the shorter
    -+`trailer.<keyAlias>.key`::
    -+	Defines a _<keyAlias>_ for the _<key>_. The _<keyAlias>_ must be a
    ++`trailer.<key-alias>.key`::
    ++	Defines a _<key-alias>_ for the _<key>_. The _<key-alias>_ must be a
     +	prefix (case does not matter) of the _<key>_. For example, in `git
     +	config trailer.ack.key "Acked-by"` the `Acked-by` is the _<key>_ and
    -+	the `ack` is the _<keyAlias>_. This configuration allows the shorter
    ++	the `ack` is the _<key-alias>_. This configuration allows the shorter
      	`--trailer "ack:..."` invocation on the command line using the "ack"
     -	<keyAlias> instead of the longer `--trailer "Acked-by:..."`.
    -+	`<keyAlias>` instead of the longer `--trailer "Acked-by:..."`.
    ++	`<key-alias>` instead of the longer `--trailer "Acked-by:..."`.
      +
     -At the end of the <key>, a separator can appear and then some
     -space characters. By default the only valid separator is ':',
    @@ Documentation/config/trailer.adoc: With `add`, a new trailer will be added.
      
     -trailer.<keyAlias>.where::
     -	This option takes the same values as the 'trailer.where'
    -+`trailer.<keyAlias>.where`::
    ++`trailer.<key-alias>.where`::
     +	This option takes the same values as the `trailer.where`
      	configuration variable and it overrides what is specified by
     -	that option for trailers with the specified <keyAlias>.
    -+	that option for trailers with the specified _<keyAlias>_.
    ++	that option for trailers with the specified _<key-alias>_.
      
     -trailer.<keyAlias>.ifexists::
     -	This option takes the same values as the 'trailer.ifexists'
    -+`trailer.<keyAlias>.ifexists`::
    ++`trailer.<key-alias>.ifexists`::
     +	This option takes the same values as the `trailer.ifexists`
      	configuration variable and it overrides what is specified by
     -	that option for trailers with the specified <keyAlias>.
    -+	that option for trailers with the specified _<keyAlias>_.
    ++	that option for trailers with the specified _<key-alias>_.
      
     -trailer.<keyAlias>.ifmissing::
     -	This option takes the same values as the 'trailer.ifmissing'
    -+`trailer.<keyAlias>.ifmissing`::
    ++`trailer.<key-alias>.ifmissing`::
     +	This option takes the same values as the `trailer.ifmissing`
      	configuration variable and it overrides what is specified by
     -	that option for trailers with the specified <keyAlias>.
    -+	that option for trailers with the specified _<keyAlias>_.
    ++	that option for trailers with the specified _<key-alias>_.
      
     -trailer.<keyAlias>.command::
     -	Deprecated in favor of 'trailer.<keyAlias>.cmd'.
     -	This option behaves in the same way as 'trailer.<keyAlias>.cmd', except
    -+`trailer.<keyAlias>.command`::
    -+	Deprecated in favor of `trailer.<keyAlias>.cmd`.
    -+	This option behaves in the same way as `trailer.<keyAlias>.cmd`, except
    ++`trailer.<key-alias>.command`::
    ++	Deprecated in favor of `trailer.<key-alias>.cmd`.
    ++	This option behaves in the same way as `trailer.<key-alias>.cmd`, except
      	that it doesn't pass anything as argument to the specified command.
     -	Instead the first occurrence of substring $ARG is replaced by the
     -	<value> that would be passed as argument.
    @@ Documentation/config/trailer.adoc: With `add`, a new trailer will be added.
     -When both 'trailer.<keyAlias>.cmd' and 'trailer.<keyAlias>.command' are given
     -for the same <keyAlias>, 'trailer.<keyAlias>.cmd' is used and
     -'trailer.<keyAlias>.command' is ignored.
    -+When both `trailer.<keyAlias>.cmd` and `trailer.<keyAlias>.command` are given
    -+for the same _<keyAlias>_, `trailer.<keyAlias>.cmd` is used and
    -+`trailer.<keyAlias>.command` is ignored.
    ++When both `trailer.<key-alias>.cmd` and `trailer.<key-alias>.command` are given
    ++for the same _<key-alias>_, `trailer.<key-alias>.cmd` is used and
    ++`trailer.<key-alias>.command` is ignored.
      
     -trailer.<keyAlias>.cmd::
    -+`trailer.<keyAlias>.cmd`::
    ++`trailer.<key-alias>.cmd`::
      	This option can be used to specify a shell command that will be called
     -	once to automatically add a trailer with the specified <keyAlias>, and then
     -	called each time a '--trailer <keyAlias>=<value>' argument is specified to
     -	modify the <value> of the trailer that this option would produce.
    -+	once to automatically add a trailer with the specified _<keyAlias>_, and then
    -+	called each time a `--trailer <keyAlias>=<value>` argument is specified to
    ++	once to automatically add a trailer with the specified _<key-alias>_, and then
    ++	called each time a `--trailer <key-alias>=<value>` argument is specified to
     +	modify the _<value>_ of the trailer that this option would produce.
      +
      When the specified command is first called to add a trailer
    @@ Documentation/config/trailer.adoc: With `add`, a new trailer will be added.
     -of the "git interpret-trailers" command, where <value>
     -is taken to be the standard output of the command with any
     -leading and trailing whitespace trimmed off.
    -+with the specified _<keyAlias>_, the behavior is as if a special
    -+`--trailer <keyAlias>=<value>` argument was added at the beginning
    ++with the specified _<key-alias>_, the behavior is as if a special
    ++`--trailer <key-alias>=<value>` argument was added at the beginning
     +of linkgit:git-interpret-trailers[1], where _<value>_ is taken to be the
     +standard output of the command with any leading and trailing whitespace
     +trimmed off.
      +
     -If some '--trailer <keyAlias>=<value>' arguments are also passed
    -+If some `--trailer <keyAlias>=<value>` arguments are also passed
    ++If some `--trailer <key-alias>=<value>` arguments are also passed
      on the command line, the command is called again once for each
     -of these arguments with the same <keyAlias>. And the <value> part
    -+of these arguments with the same _<keyAlias>_. And the _<value>_ part
    ++of these arguments with the same _<key-alias>_. And the _<value>_ part
      of these arguments, if any, will be passed to the command as its
     -first argument. This way the command can produce a <value> computed
     -from the <value> passed in the '--trailer <keyAlias>=<value>' argument.
     +first argument. This way the command can produce a _<value>_ computed
    -+from the _<value>_ passed in the `--trailer <keyAlias>=<value>`
    ++from the _<value>_ passed in the `--trailer <key-alias>=<value>`
     +argument.
-:  ----------- > 4:  1feb6933662 interpret-trailers: use placeholder instead of *

base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
-- 
2.53.0.32.gf6228eaf9cc

