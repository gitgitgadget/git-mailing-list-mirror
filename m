Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD382DFF04
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 22:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773268339; cv=none; b=r+gH1e93SJFZd14+VULXPRzR9XpmWQhTl5jBHNxNjc+yb2jK/VMNgfRQt0ktUNF97LFgSkJfFK4va7UhcrL6nay390jgZDZrMN7fnPvJkvvRjQTcw3a8bzTKOg/xODWKoid8jiCEwy1ILvDquwPeTvqqA0qtICX3T3VWM3LwmcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773268339; c=relaxed/simple;
	bh=6vITHfTQBa1y25D24RznJ8wv6ZIZCdFGBxwuA7OngUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mhcBMqker8+awOnta6i/FsQT4jIgM/hB6F9W8E2+Qkb09vC4xX3ddP8BlL80Isf89e8k2MFCmGH+PtGJQaDX30fmQuyqqFaagTnmSpSG7qV7bx97zz0pmBH3I0ODm1CxMUjOOfl+CAAPIowU2k638zWB2N7S/AyDY4SSm06T6pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=EhW1gACa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bhDzKDHg; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="EhW1gACa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bhDzKDHg"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7DBFF7A01B9;
	Wed, 11 Mar 2026 18:32:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 11 Mar 2026 18:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1773268337; x=
	1773354737; bh=kc/xUfernlWq8LCniHZlZy8yu/UrBT+WjxihjFzfp2o=; b=E
	hW1gACah/Hu5qUOPYf0En4DxxS/kzkW2QFgBAnL1gJdMTggNtwh9B6ya4X9VWR7A
	HHVj4Uk36KyhoYWb2+cwNoWMDaB1s29vDamnk7/HDToaSoFnnhbRpONdmIHuHtgi
	YiDzUjqnrTcLOXgowLqCnRqBsTBzWZ7woMFOIR6l2lZR71AnAkYIE7v2342uml8l
	T/VtwZ9FZ0jd5Pxy9UgU3V1bzZYqXZWsqbzMLhSCsJDzp9fttinD+v2TVl+Cd262
	5HILnwOesqdjgTcbI0T7Rn/A5RWzVb70fUlpoLL0/flz83OjDsgXueI3b2ObH+d+
	SxTkFyecK60NaoKOMlXBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773268337; x=1773354737; bh=k
	c/xUfernlWq8LCniHZlZy8yu/UrBT+WjxihjFzfp2o=; b=bhDzKDHgdFAko7Izi
	S1x8uwmm8+otdWXliyVypOsS/tgPzEpfIuS9OPjxJZ1maKhCAsUsyAh7uOsX7vjD
	4xY7sAkymW7JcKWuSaYZnwWi28jzCD02xha8mS9gvSvPvgNrBKWG3JmsiLauM/Jo
	rI3/0LomS9T2XkwQsWQb+zWfTVehw6bDnpJEUAqfDe0gFcYeBpme6E486EOBrf/v
	+MkoBIdJyfN/OVjzGGZyUx5KWdPclPtOriEG6D/dFB/3geK3uRvZtH8mbv7T6/pV
	xufWvVEeTSBYzkTW7g9F1XBFDZCfMEajXQd4U//nVZAgce0ExXZZ2X3tlxoIbMeP
	mlvjw==
X-ME-Sender: <xms:ce2xaaDuRxThx50MipMlyAr8UG2st_-eMTB2S8XAbGdxxWa5O0zKoUk>
    <xme:ce2xab9RVrBtI2rQ6ZHbE5FRzOgyvEhpwTCZSVbPCriaTXwupeomRzmaIeK7n6qIQ
    eWee-3Zqi9wr5i-pg-xMi80YnjypYDhn7hXzQwOYeOqkxJb28T-7w>
X-ME-Received: <xmr:ce2xaa9wxNRG47f7a62i_UXQwZHaGZLPNa0nUqazVvCyZ5SW_TlkrS2XhMTTQEOHHytLyGwQNFguORER4iGVwyjo2zl6pTiXkNjnKJlqOmToIZhEUEXq71L5NQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeehudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhenucggtffrrghtthgvrhhnpeefheetkeeftdeiffdvjeetueethfeugfetgfdt
    veehhfevffeuffdtheeitdefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgu
    vgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehjnhdrrghvihhlrgesfh
    hrvggvrdhfrh
X-ME-Proxy: <xmx:ce2xaSe4_6DODMJT3gjXQJ8T3UpcgCCrS5eh_d_MarU6QDxCnSxOtA>
    <xmx:ce2xaTHuqUxNPkpqpFAVoJ-eorxhrZd4sP9VLz-ihDv5qKUa5vILtA>
    <xmx:ce2xaQfyF24UGlPqZsv8TZNU8-PPZoMbpXi4HuXOp5vPMjtZl5QvRw>
    <xmx:ce2xadFg6wEjAzHf9oaBxmtWxyPED9nUHHS6mfZ-MiMacsGr4IJKLQ>
    <xmx:ce2xaekuQ8LlV5_o0t0e0aqBsvayb0iVqTdzvolPsRXINZM2okzv43sv>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 18:32:16 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH 3/3] doc: config: convert trailers section to synopsis style
Date: Wed, 11 Mar 2026 23:31:06 +0100
Message-ID: <doc_interpret-tr_config.48d@msgid.xyz>
X-Mailer: git-send-email 2.53.0.32.gf6228eaf9cc
In-Reply-To: <CV_doc_interpret-tr_synopsis.48a@msgid.xyz>
References: <CV_doc_interpret-tr_synopsis.48a@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Convert this part of the configuration documentation to synopsis style
so that all of git-interpret-trailers(1) is consistent.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/config/trailer.adoc | 121 +++++++++++++++---------------
 1 file changed, 61 insertions(+), 60 deletions(-)

diff --git a/Documentation/config/trailer.adoc b/Documentation/config/trailer.adoc
index 60bc221c88b..a382f68fe9e 100644
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
+`trailer.<keyAlias>.key`::
+	Defines a _<keyAlias>_ for the _<key>_. The _<keyAlias>_ must be a
+	prefix (case does not matter) of the _<key>_. For example, in `git
+	config trailer.ack.key "Acked-by"` the `Acked-by` is the _<key>_ and
+	the `ack` is the _<keyAlias>_. This configuration allows the shorter
 	`--trailer "ack:..."` invocation on the command line using the "ack"
-	<keyAlias> instead of the longer `--trailer "Acked-by:..."`.
+	`<keyAlias>` instead of the longer `--trailer "Acked-by:..."`.
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
+`trailer.<keyAlias>.where`::
+	This option takes the same values as the `trailer.where`
 	configuration variable and it overrides what is specified by
-	that option for trailers with the specified <keyAlias>.
+	that option for trailers with the specified _<keyAlias>_.
 
-trailer.<keyAlias>.ifexists::
-	This option takes the same values as the 'trailer.ifexists'
+`trailer.<keyAlias>.ifexists`::
+	This option takes the same values as the `trailer.ifexists`
 	configuration variable and it overrides what is specified by
-	that option for trailers with the specified <keyAlias>.
+	that option for trailers with the specified _<keyAlias>_.
 
-trailer.<keyAlias>.ifmissing::
-	This option takes the same values as the 'trailer.ifmissing'
+`trailer.<keyAlias>.ifmissing`::
+	This option takes the same values as the `trailer.ifmissing`
 	configuration variable and it overrides what is specified by
-	that option for trailers with the specified <keyAlias>.
+	that option for trailers with the specified _<keyAlias>_.
 
-trailer.<keyAlias>.command::
-	Deprecated in favor of 'trailer.<keyAlias>.cmd'.
-	This option behaves in the same way as 'trailer.<keyAlias>.cmd', except
+`trailer.<keyAlias>.command`::
+	Deprecated in favor of `trailer.<keyAlias>.cmd`.
+	This option behaves in the same way as `trailer.<keyAlias>.cmd`, except
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
+When both `trailer.<keyAlias>.cmd` and `trailer.<keyAlias>.command` are given
+for the same _<keyAlias>_, `trailer.<keyAlias>.cmd` is used and
+`trailer.<keyAlias>.command` is ignored.
 
-trailer.<keyAlias>.cmd::
+`trailer.<keyAlias>.cmd`::
 	This option can be used to specify a shell command that will be called
-	once to automatically add a trailer with the specified <keyAlias>, and then
-	called each time a '--trailer <keyAlias>=<value>' argument is specified to
-	modify the <value> of the trailer that this option would produce.
+	once to automatically add a trailer with the specified _<keyAlias>_, and then
+	called each time a `--trailer <keyAlias>=<value>` argument is specified to
+	modify the _<value>_ of the trailer that this option would produce.
 +
 When the specified command is first called to add a trailer
-with the specified <keyAlias>, the behavior is as if a special
-'--trailer <keyAlias>=<value>' argument was added at the beginning
-of the "git interpret-trailers" command, where <value>
-is taken to be the standard output of the command with any
-leading and trailing whitespace trimmed off.
+with the specified _<keyAlias>_, the behavior is as if a special
+`--trailer <keyAlias>=<value>` argument was added at the beginning
+of linkgit:git-interpret-trailers[1], where _<value>_ is taken to be the
+standard output of the command with any leading and trailing whitespace
+trimmed off.
 +
-If some '--trailer <keyAlias>=<value>' arguments are also passed
+If some `--trailer <keyAlias>=<value>` arguments are also passed
 on the command line, the command is called again once for each
-of these arguments with the same <keyAlias>. And the <value> part
+of these arguments with the same _<keyAlias>_. And the _<value>_ part
 of these arguments, if any, will be passed to the command as its
-first argument. This way the command can produce a <value> computed
-from the <value> passed in the '--trailer <keyAlias>=<value>' argument.
+first argument. This way the command can produce a _<value>_ computed
+from the _<value>_ passed in the `--trailer <keyAlias>=<value>`
+argument.
-- 
2.53.0.32.gf6228eaf9cc

