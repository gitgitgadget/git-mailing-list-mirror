Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCD93644AD
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 21:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773697761; cv=none; b=fNAM7ix36gxRDqQ3sO4HpHGaBnsApifFZP9OrWzTW4ZHw6lgL8wPYV3zhzA4HsRjt1h39hH+NdlWdgSI8G4cZ8Hq164F9+K0OkWmji+jN8udwgDj4JtFD484vSGHFI188HAsZr9q/c99OfYyOtBPP1I0YZCj5ci5c1cRY2HPH+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773697761; c=relaxed/simple;
	bh=Q8ILnMdWKqjtwxHUKCerVAS+fIuLooPbkmumm5B8A6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nVP5brgxC2CPFQ2CH3++cOOLwQzF0cjI7dpZaxfYbIC3AQvjUcCld3zeUamY9jm03shNsQfiIWk/g2OcwgBfPMlaimbWZ5kOV0pm5QRbqHWAzZJnhVMLN7L6I17YKapethkodhqCkOxuW2fDdLhVyVhugZqOygU1PdN6BOPiB6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=KPFpMgmq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yewijFiC; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="KPFpMgmq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yewijFiC"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 34B061D0029D;
	Mon, 16 Mar 2026 17:49:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 16 Mar 2026 17:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773697759;
	 x=1773784159; bh=riwU/3a7ZXs+vIJIIYuTV0ee5PnRkoZ/1JVkuV79pMo=; b=
	KPFpMgmqPT7P4rLtairwsi7aGsfLvYyLVRIzK5IT4B2Lfv7cJWCWZUVO2G1Zmnal
	rmr6KuEP/Qpq0dF+ld4C2Vf1dy5SG6HHpHFtEbMYRPO36HeXjb73YcH2u1jcAbiW
	bU9/wpk+SF9qlQRRw2hoFWsSvaCNtYkaCKw12M0KNPPx8rpo81NX1SxjN1lzUwwy
	r/5HP/lX2DNIxzeiGI5OIFcFgi9BuIgMXELnV568i9+2kj5hVQWY8rFNWxFXcFcN
	HYnW2tF4CXtgTXvYalrcPtWC15k6/wnIZ4i7h5R4PKJESBgJf12ms6VEfXnauNPg
	thQhnWCEjQKrtjprN9Nk4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773697759; x=
	1773784159; bh=riwU/3a7ZXs+vIJIIYuTV0ee5PnRkoZ/1JVkuV79pMo=; b=y
	ewijFiC1zvPmOI2sHmb5USBJll9cP5N/iWWmBgAqGqdiEyidXwpOZR8/zK0FE3Ak
	6PBG2C4zZ7aK8bWbBuzXz6mTLZd+VkY8RCGb1trtPdOsx3f9zXBbXamSU1aCk3dq
	72pDSlfyZTYCMWGStV5Id7+RKC54xqVTaFVSgoDQrd7FSesS4DrkCm04cUYKRC6+
	QrJ9M6MDAYQg2Ndvhsks4fbsVrwL917IWniciSkS1QnPKfSAOaa4gRL2HAtPasgZ
	fUY13TOlTphMmGUp6FfJsSwIkMisFGTf2JRRbeAK0IpwrttkRMhqAmP13A0rNBn4
	UsHVcAMZMWOShoZ3rBjjw==
X-ME-Sender: <xms:3nq4ab4a5eYwr2UAD7SG5XrhQzDKjoL8NULiM2H_9kUY9bC_3BeroEc>
    <xme:3nq4aYUOjUK-jUdNsYgQCd1niE_q_u8XZqQPgk-4KqcNiwbldsz_Tb1gZiz_aIubW
    BR0vdW6oMRtxykMKtxdn2pBS9jHXSytgoW_Kk41rw8lgzEZJ6agsg>
X-ME-Received: <xmr:3nq4af20NP7wC9pq2BWVUxK1ts7vcEe1IZs42Aefc5eTfnGtecssp4FLdHf7LTJKDZqzorVxQX-3uaPXY_VmbAM3rZVpU2Gi29dUagsjrWpfSea-8ozVuI2eVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleelhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlvdefmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmnecuggftrfgrthhtvghrnhepudelgfeuieeuteekleeifeegudefheetkefh
    jeffkedvueehtdevhfekieekhffgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishht
    ohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpth
    htohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrg
    hmvgdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrh
X-ME-Proxy: <xmx:3nq4aV3hEr-_BeW6MeVzQbJpiepJ_SVNqwurvX5E4IswiZYq_anG7w>
    <xmx:3nq4aS_-oCPF1Jr40SZEt3gPNfUN-ZlrLvQLqVegAYOPyIVb9fyIsQ>
    <xmx:3nq4aS31z--UWq33Pia5eJKwyXc80CKCUMs5zI-pGVNil2SHtCPdsQ>
    <xmx:3nq4af_bIGuhPjnco0W1VmC__NxGQnS5xVwd6ppaRpNQDckefUo2mA>
    <xmx:33q4ac8bAwM1ntM91H1aWI8KjYhkaLRdPX_fSiS9RbID0hXSRaSgYTI9>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 17:49:17 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH v2 1/4] doc: interpret-trailers: convert to synopsis style
Date: Mon, 16 Mar 2026 22:48:24 +0100
Message-ID: <V2_doc_interpret-tr_synopsis.50b@msgid.xyz>
X-Mailer: git-send-email 2.53.0.32.gf6228eaf9cc
In-Reply-To: <V2_CV_doc_interpret-tr_synopsis.50a@msgid.xyz>
References: <CV_doc_interpret-tr_synopsis.48a@msgid.xyz> <V2_CV_doc_interpret-tr_synopsis.50a@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

See e.g. 0ae23ab5 (doc: convert git worktree to synopsis style,
2025-10-05) for the markup rules for this style.

There aren’t many subtleties to the transformation of this doc since it
doesn’t use any advanced constructs. The only thing is that "`:`{nbsp}" is
used instead of `': '` to refer to effective inline-verbatim with
a space (␠).[1] I also use (_) for emphasis although (') gives the
same result.

Also prefer linking to Git commands instead of saying e.g. `git
format-patch`. But for this command we can type out git-interpret-
trailers(1) to avoid a self-reference.

Also replace camel case `<keyAlias>` with kebab case `<key-alias>`.
And while doing that make sure to replace `trailer.*` with
`trailer.<key-alias>`.

† 1: Similar to "`tag:`{nbsp}" in `Documentation/pretty-formats.adoc`

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • <keyAlias> → <key-alias> (no camelcase)
    • trailer.* → trailer.<key-alias>
    • No linkgit for this command (it would link to itself); replace with plain
      git-interpret-trailers(1)
    • Use "`:`{nbsp}" for the verbatim-but-ends-in-space case
    
      This is inspired by Documentation/pretty-formats.adoc:
    
          `tag=<value>`: Shown before tag names. Defaults to "`tag:`{nbsp}".
    
      See: https://lore.kernel.org/git/aa0664a5-09fe-4dee-b243-b3b5dff41b68@app.fastmail.com/
    • And also apply the NBSP treatment to two trailer mentions that originally
      had a trailing space

 Documentation/git-interpret-trailers.adoc | 145 +++++++++++-----------
 1 file changed, 73 insertions(+), 72 deletions(-)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index fd335fe772a..ea47f2f7ae5 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -7,14 +7,14 @@ git-interpret-trailers - Add or parse structured information in commit messages
 
 SYNOPSIS
 --------
-[verse]
-'git interpret-trailers' [--in-place] [--trim-empty]
+[synopsis]
+git interpret-trailers [--in-place] [--trim-empty]
 			[(--trailer (<key>|<key-alias>)[(=|:)<value>])...]
 			[--parse] [<file>...]
 
 DESCRIPTION
 -----------
-Add or parse 'trailer' lines that look similar to RFC 822 e-mail
+Add or parse _trailer_ lines that look similar to RFC 822 e-mail
 headers, at the end of the otherwise free-form part of a commit
 message. For example, in the following commit message
 
@@ -27,23 +27,24 @@ Signed-off-by: Alice <alice@example.com>
 Signed-off-by: Bob <bob@example.com>
 ------------------------------------------------
 
-the last two lines starting with "Signed-off-by" are trailers.
+the last two lines starting with `Signed-off-by` are trailers.
 
 This command reads commit messages from either the
-<file> arguments or the standard input if no <file> is specified.
+_<file>_ arguments or the standard input if no _<file>_ is specified.
 If `--parse` is specified, the output consists of the parsed trailers
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
-includes a commit message (as above), a "---" divider line, and a patch part.
+includes a commit message (as above), a `---` divider line, and a patch part.
 For these inputs, the divider and patch parts are not modified by
 this command and are emitted as is on the output, unless
 `--no-divider` is specified.
@@ -53,24 +54,24 @@ are applied to each input and the way any existing trailer in
 the input is changed. They also make it possible to
 automatically add some trailers.
 
-By default, a '<key>=<value>' or '<key>:<value>' argument given
+By default, a `<key>=<value>` or `<key>:<value>` argument given
 using `--trailer` will be appended after the existing trailers only if
-the last trailer has a different (<key>, <value>) pair (or if there
-is no existing trailer). The <key> and <value> parts will be trimmed
+the last trailer has a different (_<key>_, _<value>_) pair (or if there
+is no existing trailer). The _<key>_ and _<value>_ parts will be trimmed
 to remove starting and trailing whitespace, and the resulting trimmed
-<key> and <value> will appear in the output like this:
+_<key>_ and _<value>_ will appear in the output like this:
 
 ------------------------------------------------
 key: value
 ------------------------------------------------
 
-This means that the trimmed <key> and <value> will be separated by
-`': '` (one colon followed by one space).
+This means that the trimmed _<key>_ and _<value>_ will be separated by
+"`:`{nbsp}" (one colon followed by one space).
 
-For convenience, a <key-alias> can be configured to make using `--trailer`
+For convenience, a _<key-alias>_ can be configured to make using `--trailer`
 shorter to type on the command line. This can be configured using the
-'trailer.<key-alias>.key' configuration variable. The <keyAlias> must be a prefix
-of the full <key> string, although case sensitivity does not matter. For
+`trailer.<key-alias>.key` configuration variable. The _<key-alias>_ must be a prefix
+of the full _<key>_ string, although case sensitivity does not matter. For
 example, if you have
 
 ------------------------------------------------
@@ -91,13 +92,13 @@ least one Git-generated or user-configured trailer and consists of at
 least 25% trailers.
 The group must be preceded by one or more empty (or whitespace-only) lines.
 The group must either be at the end of the input or be the last
-non-whitespace lines before a line that starts with '---' (followed by a
+non-whitespace lines before a line that starts with `---` (followed by a
 space or the end of the line).
 
 When reading trailers, there can be no whitespace before or inside the
-<key>, but any number of regular space and tab characters are allowed
-between the <key> and the separator. There can be whitespaces before,
-inside or after the <value>. The <value> may be split over multiple lines
+_<key>_, but any number of regular space and tab characters are allowed
+between the _<key>_ and the separator. There can be whitespaces before,
+inside or after the _<value>_. The _<value>_ may be split over multiple lines
 with each subsequent line starting with at least one whitespace, like
 the "folding" in RFC 822. Example:
 
@@ -111,77 +112,77 @@ rules for RFC 822 headers. For example they do not follow the encoding rule.
 
 OPTIONS
 -------
---in-place::
+`--in-place`::
 	Edit the files in place.
 
---trim-empty::
-	If the <value> part of any trailer contains only whitespace,
+`--trim-empty`::
+	If the _<value>_ part of any trailer contains only whitespace,
 	the whole trailer will be removed from the output.
 	This applies to existing trailers as well as new trailers.
 
---trailer <key>[(=|:)<value>]::
-	Specify a (<key>, <value>) pair that should be applied as a
+`--trailer <key>[(=|:)<value>]`::
+	Specify a (_<key>_, _<value>_) pair that should be applied as a
 	trailer to the inputs. See the description of this
 	command.
 
---where <placement>::
---no-where::
+`--where <placement>`::
+`--no-where`::
 	Specify where all new trailers will be added.  A setting
-	provided with '--where' overrides the `trailer.where` and any
-	applicable `trailer.<keyAlias>.where` configuration variables
-	and applies to all '--trailer' options until the next occurrence of
-	'--where' or '--no-where'. Upon encountering '--no-where', clear the
-	effect of any previous use of '--where', such that the relevant configuration
+	provided with `--where` overrides the `trailer.where` and any
+	applicable `trailer.<key-alias>.where` configuration variables
+	and applies to all `--trailer` options until the next occurrence of
+	`--where` or `--no-where`. Upon encountering `--no-where`, clear the
+	effect of any previous use of `--where`, such that the relevant configuration
 	variables are no longer overridden. Possible placements are `after`,
 	`before`, `end` or `start`.
 
---if-exists <action>::
---no-if-exists::
+`--if-exists <action>`::
+`--no-if-exists`::
 	Specify what action will be performed when there is already at
-	least one trailer with the same <key> in the input.  A setting
-	provided with '--if-exists' overrides the `trailer.ifExists` and any
-	applicable `trailer.<keyAlias>.ifExists` configuration variables
-	and applies to all '--trailer' options until the next occurrence of
-	'--if-exists' or '--no-if-exists'. Upon encountering '--no-if-exists', clear the
-	effect of any previous use of '--if-exists', such that the relevant configuration
+	least one trailer with the same _<key>_ in the input.  A setting
+	provided with `--if-exists` overrides the `trailer.ifExists` and any
+	applicable `trailer.<key-alias>.ifExists` configuration variables
+	and applies to all `--trailer` options until the next occurrence of
+	`--if-exists` or `--no-if-exists`. Upon encountering `--no-if-exists`, clear the
+	effect of any previous use of `--if-exists`, such that the relevant configuration
 	variables are no longer overridden. Possible actions are `addIfDifferent`,
 	`addIfDifferentNeighbor`, `add`, `replace` and `doNothing`.
 
---if-missing <action>::
---no-if-missing::
+`--if-missing <action>`::
+`--no-if-missing`::
 	Specify what action will be performed when there is no other
-	trailer with the same <key> in the input.  A setting
-	provided with '--if-missing' overrides the `trailer.ifMissing` and any
-	applicable `trailer.<keyAlias>.ifMissing` configuration variables
-	and applies to all '--trailer' options until the next occurrence of
-	'--if-missing' or '--no-if-missing'. Upon encountering '--no-if-missing',
-	clear the effect of any previous use of '--if-missing', such that the relevant
+	trailer with the same _<key>_ in the input.  A setting
+	provided with `--if-missing` overrides the `trailer.ifMissing` and any
+	applicable `trailer.<key-alias>.ifMissing` configuration variables
+	and applies to all `--trailer` options until the next occurrence of
+	`--if-missing` or `--no-if-missing`. Upon encountering `--no-if-missing`,
+	clear the effect of any previous use of `--if-missing`, such that the relevant
 	configuration variables are no longer overridden. Possible actions are `doNothing`
 	or `add`.
 
---only-trailers::
+`--only-trailers`::
 	Output only the trailers, not any other parts of the input.
 
---only-input::
+`--only-input`::
 	Output only trailers that exist in the input; do not add any
-	from the command-line or by applying `trailer.*` configuration
+	from the command-line or by applying `trailer.<key-alias>` configuration
 	variables.
 
---unfold::
+`--unfold`::
 	If a trailer has a value that runs over multiple lines (aka "folded"),
 	reformat the value into a single line.
 
---parse::
+`--parse`::
 	A convenience alias for `--only-trailers --only-input
 	--unfold`. This makes it easier to only see the trailers coming from the
 	input without influencing them with any command line options or
 	configuration variables, while also making the output machine-friendly with
-	--unfold.
+	`--unfold`.
 
---no-divider::
+`--no-divider`::
 	Do not treat `---` as the end of the commit message. Use this
 	when you know your input contains just the commit message itself
-	(and not an email or the output of `git format-patch`).
+	(and not an email or the output of linkgit:git-format-patch[1]).
 
 CONFIGURATION VARIABLES
 -----------------------
@@ -193,7 +194,7 @@ include::config/trailer.adoc[]
 EXAMPLES
 --------
 
-* Configure a 'sign' trailer with a 'Signed-off-by' key, and then
+* Configure a `sign` trailer with a `Signed-off-by` key, and then
   add two of these trailers to a commit message file:
 +
 ------------
@@ -230,8 +231,8 @@ Signed-off-by: Bob <bob@example.com>
 Acked-by: Alice <alice@example.com>
 ------------
 
-* Extract the last commit as a patch, and add a 'Cc' and a
-  'Reviewed-by' trailer to it:
+* Extract the last commit as a patch, and add a `Cc` and a
+  `Reviewed-by` trailer to it:
 +
 ------------
 $ git format-patch -1
@@ -239,9 +240,9 @@ $ git format-patch -1
 $ git interpret-trailers --trailer 'Cc: Alice <alice@example.com>' --trailer 'Reviewed-by: Bob <bob@example.com>' 0001-foo.patch >0001-bar.patch
 ------------
 
-* Configure a 'sign' trailer with a command to automatically add a
-  'Signed-off-by: ' with the author information only if there is no
-  'Signed-off-by: ' already, and show how it works:
+* Configure a `sign` trailer with a command to automatically add a
+  "`Signed-off-by:`{nbsp}" with the author information only if there is no
+  "`Signed-off-by:`{nbsp}" already, and show how it works:
 +
 ------------
 $ cat msg1.txt
@@ -272,7 +273,7 @@ body text
 Signed-off-by: Alice <alice@example.com>
 ------------
 
-* Configure a 'fix' trailer with a key that contains a '#' and no
+* Configure a `fix` trailer with a key that contains a `#` and no
   space after this character, and show how it works:
 +
 ------------
@@ -284,7 +285,7 @@ subject
 Fix #42
 ------------
 
-* Configure a 'help' trailer with a cmd use a script `glog-find-author`
+* Configure a `help` trailer with a cmd use a script `glog-find-author`
   which search specified author identity from git log in git repository
   and show how it works:
 +
@@ -308,7 +309,7 @@ Helped-by: Junio C Hamano <gitster@pobox.com>
 Helped-by: Christian Couder <christian.couder@gmail.com>
 ------------
 
-* Configure a 'ref' trailer with a cmd use a script `glog-grep`
+* Configure a `ref` trailer with a cmd use a script `glog-grep`
   to grep last relevant commit from git log in the git repository
   and show how it works:
 +
@@ -331,7 +332,7 @@ body text
 Reference-to: 8bc9a0c769 (Add copyright notices., 2005-04-07)
 ------------
 
-* Configure a 'see' trailer with a command to show the subject of a
+* Configure a `see` trailer with a command to show the subject of a
   commit that is related, and show how it works:
 +
 ------------
@@ -359,8 +360,8 @@ See-also: fe3187489d69c4 (subject of related commit)
 * Configure a commit template with some trailers with empty values
   (using sed to show and keep the trailing spaces at the end of the
   trailers), then configure a commit-msg hook that uses
-  'git interpret-trailers' to remove trailers with empty values and
-  to add a 'git-version' trailer:
+  git-interpret-trailers(1) to remove trailers with empty values and to
+  add a `git-version` trailer:
 +
 ------------
 $ cat temp.txt
-- 
2.53.0.32.gf6228eaf9cc

