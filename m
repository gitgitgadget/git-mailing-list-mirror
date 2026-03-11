Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECB02DFF04
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 22:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773268302; cv=none; b=WMvtpq3vCju0Gs/4r5IxfZXFK2KHVaGWLdiY6iIpx9kYTepuwoKk0bKfFcor5Ed+P3Nvspmo/jDV51VrokH40ewBGEorwRszAX6cxH6eupYQeHAZD37Yhajk+ZGKEsQMENoVO7Q41PR0n85y6jkE3dornUlHKtr24mgvas0XUN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773268302; c=relaxed/simple;
	bh=nGfRQicz74V9PsUjcbBsSSWyzCUrTHNExzX5xfb7FNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AUZ90JqZSZ22Ry0BX0p36v8dsvBvuxwABNZctvaIL5MMOekv/iYP3R4a7RNVjVYFdS4ErbxgH1XkwnAhkscp7/ZrF2csXmWqIbLDF+SUxW8QxLLmE4P/TZbZC08Cv9B910wj/lqwWtpAc1kYe31IWimjwXoK+o+XFAobzCNspnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=afoFNtDO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=umODls89; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="afoFNtDO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="umODls89"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8092C7A01C4;
	Wed, 11 Mar 2026 18:31:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 11 Mar 2026 18:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773268300;
	 x=1773354700; bh=O3BLcDQsPUJZAn7jWsukqDYWeQ3Hznzg/DdXxv9BcpE=; b=
	afoFNtDOSzbggsuwa55196BE+zRxqwgOaH35FdfjQcfG3r6ayc0bncpORT765uQU
	+Hm8TmabgjMBBwyeqm34gs+ZF4hVVfZRD+uJKNJGKfM9L9obYQVagh7m7QVLojs3
	p1C6xFsa8voSyGpmwmjdTAdygI4col+PBwaIUu7g3uqVohWvgZq4TpWzl3Kq42/r
	afprP1ZITmUpAlhja2O0JBnvoOT92Ljp3Hsz8H6VtnnPWUxDs5RR1nzwwQfnIyCf
	5JzxsGGM+9YcatkbgSajRM8S0cT3jTJvjFsXkOBQdrkglYNRAXFXSRYq+5OseuYv
	d23PZ/M8XuYWMqgEeWkZqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773268300; x=
	1773354700; bh=O3BLcDQsPUJZAn7jWsukqDYWeQ3Hznzg/DdXxv9BcpE=; b=u
	mODls89d9Un0VfJ2MeadGi2tvFl7NdPrzNtbuwdi4t9wU8j+IpFKmD0NKwdUyzmV
	pKeIzaXfhz7dy2VJ4Jcb6z/Jqu0JZIVww2jdw6x52YzNPeWtpmdWVBu9KlOVnynd
	3BFaZklSi2dw0V98yqx4uBQ8C6dys3VXM2/R8JJM8iX+wD9mpNnQY6mhD4Cs6FOi
	goFbm2DV2ocGX07/cLxToXfjZin8xtTxvqxYou8zFEQavsA/EvRcRZxRuPSO/rmL
	UDoV/aFueP5hPoiuFsj6hRe9N/T0Q+Cc/qyCc8D40xaxRzulKK8h87baPktJpfti
	HefWOtULNDOtGTQ+Jun0w==
X-ME-Sender: <xms:TO2xaZwhYq3kRl1pc65kFx-YGAmZkAFWX4xh1DMOQVxtB3w1z6fD9K0>
    <xme:TO2xaQtvnPKZFpVAUFlrAfp_1p8lCdRFJXxrVd2CDCi_oTaCJIhVkRSn5BvDbwEA0
    0hoJjTp5YBp53cRp4acdM2HHPaT6oroF-_xM_AwQigJB7GSes7atg>
X-ME-Received: <xmr:TO2xaQsyAfWQ7fcmtBeob8lL2vF3KjvAqU2r1G-GTlj6rrEXeqXXDvuvBlJQ7vFgCYFRbMfq1Kltjn6Wyse9oAv79seubZ9GRU_twDV6LA-1nbqgq4XPW4rwIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeehudduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:TO2xaVO0ZvlpLMZ1G8d4vgZ6i7OM4xi8RkLZOaL6S8kTrOr2lN3tQw>
    <xmx:TO2xae3Uohc5v355PId18AWxzmhG2SLlqjINsTdrRW8Qf3cPLzeBdA>
    <xmx:TO2xaRMYrzYZ_IaQgjpSjrqm5JjSYl78l5dv0eyvyVlayiK7En1-Kw>
    <xmx:TO2xae1bhbGUvMa2OIfdxBLgm5yTIZ8gGXYh4CXxkrejBGZehS60Hg>
    <xmx:TO2xaXVAjZJ-nnMK3C1gZEMuaWxKLdL7TyagE_m3UsHa8Zp1mnWBup-j>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 18:31:38 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH 1/3] doc: interpret-trailers: convert to synopsis style
Date: Wed, 11 Mar 2026 23:31:04 +0100
Message-ID: <doc_interpret-tr_synopsis.48b@msgid.xyz>
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

See e.g. 0ae23ab5 (doc: convert git worktree to synopsis style,
2025-10-05) for the markup rules for this style.

There aren’t many subtleties to the transformation of this doc since it
doesn’t use any advanced constructs. The only thing is that `": "` is
used instead of `': '` to refer to effective inline-verbatim with
a space (␠). I also use (_) for emphasis although (') gives the
same result.

Also prefer linking to Git commands instead of saying
e.g. `git format-patch`.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-interpret-trailers.adoc | 126 +++++++++++-----------
 1 file changed, 63 insertions(+), 63 deletions(-)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index fd335fe772a..8a6c1bff472 100644
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
 
@@ -27,10 +27,10 @@ Signed-off-by: Alice <alice@example.com>
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
@@ -43,7 +43,7 @@ to each input file. The result is emitted on the standard output.
 
 This command can also operate on the output of linkgit:git-format-patch[1],
 which is more elaborate than a plain commit message. Namely, such output
-includes a commit message (as above), a "---" divider line, and a patch part.
+includes a commit message (as above), a `---` divider line, and a patch part.
 For these inputs, the divider and patch parts are not modified by
 this command and are emitted as is on the output, unless
 `--no-divider` is specified.
@@ -53,24 +53,24 @@ are applied to each input and the way any existing trailer in
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
+": " (one colon followed by one space).
 
-For convenience, a <key-alias> can be configured to make using `--trailer`
+For convenience, a _<key-alias>_ can be configured to make using `--trailer`
 shorter to type on the command line. This can be configured using the
-'trailer.<key-alias>.key' configuration variable. The <keyAlias> must be a prefix
-of the full <key> string, although case sensitivity does not matter. For
+`trailer.<key-alias>.key` configuration variable. The _<keyAlias>_ must be a prefix
+of the full _<key>_ string, although case sensitivity does not matter. For
 example, if you have
 
 ------------------------------------------------
@@ -91,13 +91,13 @@ least one Git-generated or user-configured trailer and consists of at
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
 
@@ -111,77 +111,77 @@ rules for RFC 822 headers. For example they do not follow the encoding rule.
 
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
+	provided with `--where` overrides the `trailer.where` and any
 	applicable `trailer.<keyAlias>.where` configuration variables
-	and applies to all '--trailer' options until the next occurrence of
-	'--where' or '--no-where'. Upon encountering '--no-where', clear the
-	effect of any previous use of '--where', such that the relevant configuration
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
+	least one trailer with the same _<key>_ in the input.  A setting
+	provided with `--if-exists` overrides the `trailer.ifExists` and any
 	applicable `trailer.<keyAlias>.ifExists` configuration variables
-	and applies to all '--trailer' options until the next occurrence of
-	'--if-exists' or '--no-if-exists'. Upon encountering '--no-if-exists', clear the
-	effect of any previous use of '--if-exists', such that the relevant configuration
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
+	trailer with the same _<key>_ in the input.  A setting
+	provided with `--if-missing` overrides the `trailer.ifMissing` and any
 	applicable `trailer.<keyAlias>.ifMissing` configuration variables
-	and applies to all '--trailer' options until the next occurrence of
-	'--if-missing' or '--no-if-missing'. Upon encountering '--no-if-missing',
-	clear the effect of any previous use of '--if-missing', such that the relevant
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
 	from the command-line or by applying `trailer.*` configuration
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
@@ -193,7 +193,7 @@ include::config/trailer.adoc[]
 EXAMPLES
 --------
 
-* Configure a 'sign' trailer with a 'Signed-off-by' key, and then
+* Configure a `sign` trailer with a `Signed-off-by` key, and then
   add two of these trailers to a commit message file:
 +
 ------------
@@ -230,8 +230,8 @@ Signed-off-by: Bob <bob@example.com>
 Acked-by: Alice <alice@example.com>
 ------------
 
-* Extract the last commit as a patch, and add a 'Cc' and a
-  'Reviewed-by' trailer to it:
+* Extract the last commit as a patch, and add a `Cc` and a
+  `Reviewed-by` trailer to it:
 +
 ------------
 $ git format-patch -1
@@ -239,9 +239,9 @@ $ git format-patch -1
 $ git interpret-trailers --trailer 'Cc: Alice <alice@example.com>' --trailer 'Reviewed-by: Bob <bob@example.com>' 0001-foo.patch >0001-bar.patch
 ------------
 
-* Configure a 'sign' trailer with a command to automatically add a
-  'Signed-off-by: ' with the author information only if there is no
-  'Signed-off-by: ' already, and show how it works:
+* Configure a `sign` trailer with a command to automatically add a
+  "Signed-off-by: " with the author information only if there is no
+  "Signed-off-by: " already, and show how it works:
 +
 ------------
 $ cat msg1.txt
@@ -272,7 +272,7 @@ body text
 Signed-off-by: Alice <alice@example.com>
 ------------
 
-* Configure a 'fix' trailer with a key that contains a '#' and no
+* Configure a `fix` trailer with a key that contains a `#` and no
   space after this character, and show how it works:
 +
 ------------
@@ -284,7 +284,7 @@ subject
 Fix #42
 ------------
 
-* Configure a 'help' trailer with a cmd use a script `glog-find-author`
+* Configure a `help` trailer with a cmd use a script `glog-find-author`
   which search specified author identity from git log in git repository
   and show how it works:
 +
@@ -308,7 +308,7 @@ Helped-by: Junio C Hamano <gitster@pobox.com>
 Helped-by: Christian Couder <christian.couder@gmail.com>
 ------------
 
-* Configure a 'ref' trailer with a cmd use a script `glog-grep`
+* Configure a `ref` trailer with a cmd use a script `glog-grep`
   to grep last relevant commit from git log in the git repository
   and show how it works:
 +
@@ -331,7 +331,7 @@ body text
 Reference-to: 8bc9a0c769 (Add copyright notices., 2005-04-07)
 ------------
 
-* Configure a 'see' trailer with a command to show the subject of a
+* Configure a `see` trailer with a command to show the subject of a
   commit that is related, and show how it works:
 +
 ------------
@@ -359,8 +359,8 @@ See-also: fe3187489d69c4 (subject of related commit)
 * Configure a commit template with some trailers with empty values
   (using sed to show and keep the trailing spaces at the end of the
   trailers), then configure a commit-msg hook that uses
-  'git interpret-trailers' to remove trailers with empty values and
-  to add a 'git-version' trailer:
+  linkgit:git-interpret-trailers[1] to remove trailers with empty values and
+  to add a `git-version` trailer:
 +
 ------------
 $ cat temp.txt
-- 
2.53.0.32.gf6228eaf9cc

