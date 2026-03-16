Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FD3247DE1
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 21:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773697797; cv=none; b=FKFb2AqZGI3WV7WmtJxYRfCaG2VW/rUg2VZiT2oIqCBPQ/dHNSFlntgkK9OVvO9s9LbMrBT7fcKqrgcxXto/W2bA1YEFI86t37PaUPM8/39pob8UAimWdJJ/HXKy57aAMzbQ7tONc1v44PeaOF3qPfeXU5X07hVXwziEkUjFqpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773697797; c=relaxed/simple;
	bh=fIS7/mHoczeZG5LVPS/4BuChxEXcbXbLk+7+LwPi5eE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sYyw2C3RU1LC20LhdkFuz7wcLjyy69JcbYmT5ITeCtFePl1I0VyOZZZTC05PhZ9DOCmFT1iAvWqGWdZUqJjMK2suIWy0pchRv3YGvPTzMPji7p8OhR5zNwpeJ/+3X0qrRd+/V9n1M7FeK9pIu7ipZJGfXDHv3siefO29kKE/GvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=WCwLA0Ul; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L1eDrNN+; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="WCwLA0Ul";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L1eDrNN+"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 9A73C1D002EF;
	Mon, 16 Mar 2026 17:49:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 16 Mar 2026 17:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773697795;
	 x=1773784195; bh=f97Nqsbq7cyG1i8aFh1SQ3hoxAH6yi7UCqKRS950/vg=; b=
	WCwLA0UlGEmZ4YPYvij1iFJH2eqdPNXk+JSfkT5bcs6ujESVvwIgBkdGAtFz/V/W
	T9UqBBabMESb8qdoQp8mdgerHFF7Q8n8uLE4SzVp10z0NToJLWLS0nUF5plsWpq3
	aRBflV1SLsl7NSaMLQFc58X1U9fy9UssYFTCGnpAog+uDk84CD6QNZmkaxMfyJUG
	5WLdO7/wXpUIVHelX8QMp0ptXpmcTOiW0pMTi0yCl44eq8/AnQrxqQXsDdgclTTo
	+58m23DlkYqKj4Lgdo8feu6rqFY+B2o1kO0TQKgJsLDkNl3JMun41C+SzHcha3MU
	JAfdeR61Qh2x+2BAO7m6AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773697795; x=
	1773784195; bh=f97Nqsbq7cyG1i8aFh1SQ3hoxAH6yi7UCqKRS950/vg=; b=L
	1eDrNN+fxHLrf5BCQXhUYB0yADHgnA4Zr1rGWNRbVCLan+B6BxBby5kBf/mguWQG
	eul9OElvZC8x+8dAHSFpWnKqY9riIqAqYz9LfM8WAoHHp+1j6REswESoMfc8p7mQ
	/UlWtvAql5ACWdv6WuWBtZZFP48qn+leo02iE2TzZo7EsshCerngEp6dP3xbP415
	6DaabYQD7FfHPl44F0HL66QcRWA8p3x4vXKMlDZhhCCsaDi7MY8oprutlFuXaUbc
	cxxH2sg9isOUMmWhSqk5vGuGwNUfRuwYyZe46nvrkEHz2oCvjq+9UbXd6jyWOXyc
	eLjoXI6QcpUOb9a45VVwg==
X-ME-Sender: <xms:A3u4aTy72NocyaWLSAAYElX1Pcycx-iSVjy3Qm6xwi7MXs8mgmcDxaQ>
    <xme:A3u4aSuYoTvmECVHGgXIVmwKOAm2T8_Xr-_wjP2WfAxezsvP1rurURedCFSbWkUXm
    uChOiAGX6iEz4SCrXoTPTnFqS9xNXwKg2bUTsr9R_iLfVLUtuYhug>
X-ME-Received: <xmr:A3u4aat0plg62YO_svYH2R4bal2OhiU7kdyk730VfVkJ-iIOIuZD17r3WSQDBC-yHBYDFZmKq4VHrMyy-_Q0CnKUw2PAHSVt-2_1FiIj_oYkWFpY8PaQm4pWkw>
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
X-ME-Proxy: <xmx:A3u4aXPSHwx-pr8IsUPxu6WUlzKzCVTB-jLAiTOaJuE-LKitMPRbLA>
    <xmx:A3u4aY1oBeeajmc3YKZ3_8rj3wCWvWiiwDxz887yDUQHB8PcJfQvJg>
    <xmx:A3u4aTOzyevnkfErvpwiwb1YXlgqA_CaqupO7YEfg3lDbtm4njEBaA>
    <xmx:A3u4aY0ouHZX7GfkmgWTOH1KRAl38Dd9zg12jSeOIsg7YPF2xUlVXw>
    <xmx:A3u4aZUvcsrOUSMChx361i0pmQeFHLnnwtNlD8pTGw6IlAkY6S2DPOBB>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 17:49:54 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH v2 3/4] doc: config: convert trailers section to synopsis style
Date: Mon, 16 Mar 2026 22:48:26 +0100
Message-ID: <V2_doc_interpret-tr_config.50d@msgid.xyz>
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

Convert this part of the configuration documentation to synopsis style
so that all of git-interpret-trailers(1) is consistent.

See the commit message from two commits ago.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • <keyAlias> → <key-alias> (no camelcase)
    • Refer to two-commits-ago for an explanation of the changes

 Documentation/config/trailer.adoc | 121 +++++++++++++++---------------
 1 file changed, 61 insertions(+), 60 deletions(-)

diff --git a/Documentation/config/trailer.adoc b/Documentation/config/trailer.adoc
index 60bc221c88b..1bc70192d3a 100644
--- a/Documentation/config/trailer.adoc
+++ b/Documentation/config/trailer.adoc
@@ -1,21 +1,21 @@
-trailer.separators::
+`trailer.separators`::
 	This option tells which characters are recognized as trailer
-	separators. By default only ':' is recognized as a trailer
-	separator, except that '=' is always accepted on the command
+	separators. By default only `:` is recognized as a trailer
+	separator, except that `=` is always accepted on the command
 	line for compatibility with other git commands.
 +
 The first character given by this option will be the default character
 used when another separator is not specified in the config for this
 trailer.
 +
-For example, if the value for this option is "%=$", then only lines
-using the format '<key><sep><value>' with <sep> containing '%', '='
-or '$' and then spaces will be considered trailers. And '%' will be
+For example, if the value for this option is `%=$`, then only lines
+using the format _<key><sep><value>_ with _<sep>_ containing `%`, `=`
+or `$` and then spaces will be considered trailers. And `%` will be
 the default separator used, so by default trailers will appear like:
-'<key>% <value>' (one percent sign and one space will appear between
+`<key>% <value>` (one percent sign and one space will appear between
 the key and the value).
 
-trailer.where::
+`trailer.where`::
 	This option tells where a new trailer will be added.
 +
 This can be `end`, which is the default, `start`, `after` or `before`.
@@ -27,41 +27,41 @@ If it is `start`, then each new trailer will appear at the start,
 instead of the end, of the existing trailers.
 +
 If it is `after`, then each new trailer will appear just after the
-last trailer with the same <key>.
+last trailer with the same _<key>_.
 +
 If it is `before`, then each new trailer will appear just before the
-first trailer with the same <key>.
+first trailer with the same _<key>_.
 
-trailer.ifexists::
+`trailer.ifexists`::
 	This option makes it possible to choose what action will be
 	performed when there is already at least one trailer with the
-	same <key> in the input.
+	same _<key>_ in the input.
 +
 The valid values for this option are: `addIfDifferentNeighbor` (this
 is the default), `addIfDifferent`, `add`, `replace` or `doNothing`.
 +
 With `addIfDifferentNeighbor`, a new trailer will be added only if no
-trailer with the same (<key>, <value>) pair is above or below the line
+trailer with the same (_<key>_, _<value>_) pair is above or below the line
 where the new trailer will be added.
 +
 With `addIfDifferent`, a new trailer will be added only if no trailer
-with the same (<key>, <value>) pair is already in the input.
+with the same (_<key>_, _<value>_) pair is already in the input.
 +
 With `add`, a new trailer will be added, even if some trailers with
-the same (<key>, <value>) pair are already in the input.
+the same (_<key>_, _<value>_) pair are already in the input.
 +
-With `replace`, an existing trailer with the same <key> will be
+With `replace`, an existing trailer with the same _<key>_ will be
 deleted and the new trailer will be added. The deleted trailer will be
-the closest one (with the same <key>) to the place where the new one
+the closest one (with the same _<key>_) to the place where the new one
 will be added.
 +
 With `doNothing`, nothing will be done; that is no new trailer will be
-added if there is already one with the same <key> in the input.
+added if there is already one with the same _<key>_ in the input.
 
-trailer.ifmissing::
+`trailer.ifmissing`::
 	This option makes it possible to choose what action will be
 	performed when there is not yet any trailer with the same
-	<key> in the input.
+	_<key>_ in the input.
 +
 The valid values for this option are: `add` (this is the default) and
 `doNothing`.
@@ -70,67 +70,68 @@ With `add`, a new trailer will be added.
 +
 With `doNothing`, nothing will be done.
 
-trailer.<keyAlias>.key::
-	Defines a <keyAlias> for the <key>. The <keyAlias> must be a
-	prefix (case does not matter) of the <key>. For example, in `git
-	config trailer.ack.key "Acked-by"` the "Acked-by" is the <key> and
-	the "ack" is the <keyAlias>. This configuration allows the shorter
+`trailer.<key-alias>.key`::
+	Defines a _<key-alias>_ for the _<key>_. The _<key-alias>_ must be a
+	prefix (case does not matter) of the _<key>_. For example, in `git
+	config trailer.ack.key "Acked-by"` the `Acked-by` is the _<key>_ and
+	the `ack` is the _<key-alias>_. This configuration allows the shorter
 	`--trailer "ack:..."` invocation on the command line using the "ack"
-	<keyAlias> instead of the longer `--trailer "Acked-by:..."`.
+	`<key-alias>` instead of the longer `--trailer "Acked-by:..."`.
 +
-At the end of the <key>, a separator can appear and then some
-space characters. By default the only valid separator is ':',
+At the end of the _<key>_, a separator can appear and then some
+space characters. By default the only valid separator is `:`,
 but this can be changed using the `trailer.separators` config
 variable.
 +
 If there is a separator in the key, then it overrides the default
 separator when adding the trailer.
 
-trailer.<keyAlias>.where::
-	This option takes the same values as the 'trailer.where'
+`trailer.<key-alias>.where`::
+	This option takes the same values as the `trailer.where`
 	configuration variable and it overrides what is specified by
-	that option for trailers with the specified <keyAlias>.
+	that option for trailers with the specified _<key-alias>_.
 
-trailer.<keyAlias>.ifexists::
-	This option takes the same values as the 'trailer.ifexists'
+`trailer.<key-alias>.ifexists`::
+	This option takes the same values as the `trailer.ifexists`
 	configuration variable and it overrides what is specified by
-	that option for trailers with the specified <keyAlias>.
+	that option for trailers with the specified _<key-alias>_.
 
-trailer.<keyAlias>.ifmissing::
-	This option takes the same values as the 'trailer.ifmissing'
+`trailer.<key-alias>.ifmissing`::
+	This option takes the same values as the `trailer.ifmissing`
 	configuration variable and it overrides what is specified by
-	that option for trailers with the specified <keyAlias>.
+	that option for trailers with the specified _<key-alias>_.
 
-trailer.<keyAlias>.command::
-	Deprecated in favor of 'trailer.<keyAlias>.cmd'.
-	This option behaves in the same way as 'trailer.<keyAlias>.cmd', except
+`trailer.<key-alias>.command`::
+	Deprecated in favor of `trailer.<key-alias>.cmd`.
+	This option behaves in the same way as `trailer.<key-alias>.cmd`, except
 	that it doesn't pass anything as argument to the specified command.
-	Instead the first occurrence of substring $ARG is replaced by the
-	<value> that would be passed as argument.
+	Instead the first occurrence of substring `$ARG` is replaced by the
+	_<value>_ that would be passed as argument.
 +
-Note that $ARG in the user's command is
-only replaced once and that the original way of replacing $ARG is not safe.
+Note that `$ARG` in the user's command is
+only replaced once and that the original way of replacing `$ARG` is not safe.
 +
-When both 'trailer.<keyAlias>.cmd' and 'trailer.<keyAlias>.command' are given
-for the same <keyAlias>, 'trailer.<keyAlias>.cmd' is used and
-'trailer.<keyAlias>.command' is ignored.
+When both `trailer.<key-alias>.cmd` and `trailer.<key-alias>.command` are given
+for the same _<key-alias>_, `trailer.<key-alias>.cmd` is used and
+`trailer.<key-alias>.command` is ignored.
 
-trailer.<keyAlias>.cmd::
+`trailer.<key-alias>.cmd`::
 	This option can be used to specify a shell command that will be called
-	once to automatically add a trailer with the specified <keyAlias>, and then
-	called each time a '--trailer <keyAlias>=<value>' argument is specified to
-	modify the <value> of the trailer that this option would produce.
+	once to automatically add a trailer with the specified _<key-alias>_, and then
+	called each time a `--trailer <key-alias>=<value>` argument is specified to
+	modify the _<value>_ of the trailer that this option would produce.
 +
 When the specified command is first called to add a trailer
-with the specified <keyAlias>, the behavior is as if a special
-'--trailer <keyAlias>=<value>' argument was added at the beginning
-of the "git interpret-trailers" command, where <value>
-is taken to be the standard output of the command with any
-leading and trailing whitespace trimmed off.
+with the specified _<key-alias>_, the behavior is as if a special
+`--trailer <key-alias>=<value>` argument was added at the beginning
+of linkgit:git-interpret-trailers[1], where _<value>_ is taken to be the
+standard output of the command with any leading and trailing whitespace
+trimmed off.
 +
-If some '--trailer <keyAlias>=<value>' arguments are also passed
+If some `--trailer <key-alias>=<value>` arguments are also passed
 on the command line, the command is called again once for each
-of these arguments with the same <keyAlias>. And the <value> part
+of these arguments with the same _<key-alias>_. And the _<value>_ part
 of these arguments, if any, will be passed to the command as its
-first argument. This way the command can produce a <value> computed
-from the <value> passed in the '--trailer <keyAlias>=<value>' argument.
+first argument. This way the command can produce a _<value>_ computed
+from the _<value>_ passed in the `--trailer <key-alias>=<value>`
+argument.
-- 
2.53.0.32.gf6228eaf9cc

