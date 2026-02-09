Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CAC2D8767
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 17:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658548; cv=none; b=EP660FE7M4GL6D5FH+s37t534OCSJsrjV+ZnK9GPWSyMA0YSK8vNvJYn6JNxblqh2UU9u00akkCBaG3aWHls8Ncxx6lcaSe5wwTGn1lvd8ilEyA0vIg24j7yvGyhu7d1Xy8yn7duQToORp8kPLJQkG2IZAXeBy9vJ+OJ4VP+R/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658548; c=relaxed/simple;
	bh=5oLsXSM6FOMgxMiMW9MBbOTkbnQ3D39qZJv9Meb2+2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hboM0eAbLBTwfaFCjW+oHcV8xStOCI4F5Yw451QmaG7TnCL+NoMqEfrUEeaouDCLBDhXvTrXO6YYFx2cJU2I7eq3QKa8HoLQYWVrIwZLYVjpXAeKCP+biSuatIULJgTwnZObgSj9yaDfYEAGJ2nvwt9JnNQBt4YIs8llNWuhEdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=psp6ndKd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=spsYKnWo; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="psp6ndKd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="spsYKnWo"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 8FECCEC05FB;
	Mon,  9 Feb 2026 12:35:47 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 09 Feb 2026 12:35:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770658547;
	 x=1770744947; bh=WS4Z6glvjavQDVY9qvYvoOei56PdI23NJYCc5z+HvtA=; b=
	psp6ndKdpT58/4ZOsgP3kMFdorerxL1BYzF1X6noELa0FZUfCwtjaTIy0EFsCu5W
	eY4dhHJgbD3tuUsdsssNwa/UsjyU2t+cOZoZOvYRNC6BZzqcuqEb+XUIAaUfDXmN
	kUwocKVIyLEwe1SLK5VyFINxJIvpUrnafFNCGLblVVRTk+Tif75nAn6ijK7CezYM
	MGyoRndxy/0ATeUn0r1wSRx7VS5HJloWVAPXKe+4NxEG5xiOiEIpg8wAoYH2WUwv
	37wuHtW4i1jOlPG1Y8a62/GNg/DeA3vyfNv78GrC0dI9dOCbFcgy+xLVyYjTdesn
	9bR2vMAUmygtLWCdNzZxOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770658547; x=
	1770744947; bh=WS4Z6glvjavQDVY9qvYvoOei56PdI23NJYCc5z+HvtA=; b=s
	psYKnWoY+7fX2x0udNGEkVrmS/sLxiTUpe0lb8fZSK/HxEw4iJxwRK2L9bDTvcjw
	+1hDOBNGut0UyFD9JH3qp8nr19eBEXewbiH8QxBwbyeifl6IplgkTYrJybV6O0Ay
	Hc85HL2UGBuddAE/BGkNopy8xoVQn3PTUoo6Fl1gvENgn5UxB2Jv/XLvG9fZUxe8
	PwEPkS6sw46M+6QV6ArZNFsnJtEREevLkwE8o3KYSDGmdKfOb/o8jEiypd/oQaXA
	YZFUlMl0MFPkWDWnSRD7NbBvNW5d7Vp8iz16IgM1RikbE1MUTASMS8PRuiHD5HXD
	DTbIgFC6Ez6p3cxUqSHEw==
X-ME-Sender: <xms:8xqKaUf_xKy29YuhHmBD-TJbDEnyjilfi3VTNPAcuAWunz3MQo0X1TI>
    <xme:8xqKacMaQk2gfB65lqTQC-XI_U1_gyWwxhGanGpF926rdTe3r255PqttvLkvHG1y5
    r8YqMEVXt29BrD-0PBlkUljRY9nmNIw6Hg5gkTZUTcxRkdIyLaybv4>
X-ME-Received: <xmr:8xqKaTKNPUNiSFxkmtcg_F99rltxoOqcPdpsVVkvTKbx9_-xZq9HVLM7jI3FK_BuuuILKjc1ilqgFbRgY0nimCshPAgp4h7Ws-oOISc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevuf
    ffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhephffgge
    elhfejkefgteelteejhfetieehgeeftdduudffgeejhfektedugefghfeknecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvg
    hrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:8xqKaVFTApylvGB9-AzkO3xnUnxy3WuPB0bFjOoyV21Oqm_dkrSeCA>
    <xmx:8xqKaTS9SnpWQ0Af205jlHI0mAnHRQum9qnbu0PiKlOx4XxcP3T1Hg>
    <xmx:8xqKaZEyV1k0Gevfj0bU07LLCPGmQNFJvX7My-0DokhIPmWDBdJc9Q>
    <xmx:8xqKaX-Az5iAFrCeJACZcEgin8W1Gaew9XdaiKv3UDjTRVdl2uMfwA>
    <xmx:8xqKaf08RnQ-GIX8G78M0ICkmcPU1hwvozmuKNek3ZrU8T7PfJu2Zt0H>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 12:35:46 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 1/4] doc: am: normalize git(1) command links
Date: Mon,  9 Feb 2026 18:34:34 +0100
Message-ID: <git-am_gitlinks.322@msgid.xyz>
X-Mailer: git-send-email 2.53.0.26.g2afa8602a26
In-Reply-To: <doc_am_gitlinks_and_am.messageId.321@msgid.xyz>
References: <doc_am_gitlinks_and_am.messageId.321@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

There are many mentions of commands using inline-verbatim or
emphasis ('). We just mention the command themselves, not specific
invocations like `git am <opts>`. Let’s link to them instead.

There are also many such mentions which then link to the command right
afterwards. Simplify to just using a link.

Also remove “see <gitlink>” phrases where they have now already
been mentioned.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/config/am.adoc | 18 +++++++++---------
 Documentation/git-am.adoc    | 31 +++++++++++++++----------------
 2 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/Documentation/config/am.adoc b/Documentation/config/am.adoc
index 5bcad2efb11..19ef5aa00c4 100644
--- a/Documentation/config/am.adoc
+++ b/Documentation/config/am.adoc
@@ -1,14 +1,14 @@
 am.keepcr::
-	If true, git-am will call git-mailsplit for patches in mbox format
-	with parameter `--keep-cr`. In this case git-mailsplit will
+	If true, linkgit:git-am[1] will call linkgit:git-mailsplit[1]
+	for patches in mbox format with parameter `--keep-cr`. In this
+	case linkgit:git-mailsplit[1] will
 	not remove `\r` from lines ending with `\r\n`. Can be overridden
 	by giving `--no-keep-cr` from the command line.
-	See linkgit:git-am[1], linkgit:git-mailsplit[1].
 
 am.threeWay::
-	By default, `git am` will fail if the patch does not apply cleanly. When
-	set to true, this setting tells `git am` to fall back on 3-way merge if
-	the patch records the identity of blobs it is supposed to apply to and
-	we have those blobs available locally (equivalent to giving the `--3way`
-	option from the command line). Defaults to `false`.
-	See linkgit:git-am[1].
+	By default, linkgit:git-am[1] will fail if the patch does not
+	apply cleanly. When set to true, this setting tells
+	linkgit:git-am[1] to fall back on 3-way merge if the patch
+	records the identity of blobs it is supposed to apply to and we
+	have those blobs available locally (equivalent to giving the
+	`--3way` option from the command line). Defaults to `false`.
diff --git a/Documentation/git-am.adoc b/Documentation/git-am.adoc
index 0c94776e296..70c605b4156 100644
--- a/Documentation/git-am.adoc
+++ b/Documentation/git-am.adoc
@@ -43,14 +43,14 @@ OPTIONS
 
 -k::
 --keep::
-	Pass `-k` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]).
+	Pass `-k` flag to linkgit:git-mailinfo[1].
 
 --keep-non-patch::
-	Pass `-b` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]).
+	Pass `-b` flag to linkgit:git-mailinfo[1].
 
 --keep-cr::
 --no-keep-cr::
-	With `--keep-cr`, call 'git mailsplit' (see linkgit:git-mailsplit[1])
+	With `--keep-cr`, call linkgit:git-mailsplit[1]
 	with the same option, to prevent it from stripping CR at the end of
 	lines. `am.keepcr` configuration variable can be used to specify the
 	default behaviour.  `--no-keep-cr` is useful to override `am.keepcr`.
@@ -65,7 +65,7 @@ OPTIONS
 	Ignore scissors lines (see linkgit:git-mailinfo[1]).
 
 --quoted-cr=<action>::
-	This flag will be passed down to 'git mailinfo' (see linkgit:git-mailinfo[1]).
+	This flag will be passed down to linkgit:git-mailinfo[1].
 
 --empty=(drop|keep|stop)::
 	How to handle an e-mail message lacking a patch:
@@ -83,7 +83,7 @@ OPTIONS
 
 -m::
 --message-id::
-	Pass the `-m` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]),
+	Pass the `-m` flag to linkgit:git-mailinfo[1],
 	so that the Message-ID header is added to the commit message.
 	The `am.messageid` configuration variable can be used to specify
 	the default behaviour.
@@ -98,7 +98,7 @@ OPTIONS
 
 -u::
 --utf8::
-	Pass `-u` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]).
+	Pass `-u` flag to linkgit:git-mailinfo[1].
 	The proposed commit log message taken from the e-mail
 	is re-coded into UTF-8 encoding (configuration variable
 	`i18n.commitEncoding` can be used to specify the project's
@@ -108,8 +108,7 @@ This was optional in prior versions of git, but now it is the
 default.   You can use `--no-utf8` to override this.
 
 --no-utf8::
-	Pass `-n` flag to 'git mailinfo' (see
-	linkgit:git-mailinfo[1]).
+	Pass `-n` flag to linkgit:git-mailinfo[1].
 
 -3::
 --3way::
@@ -132,9 +131,8 @@ include::rerere-options.adoc[]
 --exclude=<path>::
 --include=<path>::
 --reject::
-	These flags are passed to the 'git apply' (see linkgit:git-apply[1])
-	program that applies
-	the patch.
+	These flags are passed to the linkgit:git-apply[1] program that
+	applies the patch.
 +
 Valid <action> for the `--whitespace` option are:
 `nowarn`, `warn`, `fix`, `error`, and `error-all`.
@@ -205,7 +203,8 @@ applying.
 	to the screen before exiting.  This overrides the
 	standard message informing you to use `--continue`
 	or `--skip` to handle the failure.  This is solely
-	for internal use between 'git rebase' and 'git am'.
+	for internal use between linkgit:git-rebase[1] and
+	linkgit:git-am[1].
 
 --abort::
 	Restore the original branch and abort the patching operation.
@@ -223,7 +222,7 @@ applying.
 	failure again.
 
 --show-current-patch[=(diff|raw)]::
-	Show the message at which `git am` has stopped due to
+	Show the message at which linkgit:git-am[1] has stopped due to
 	conflicts.  If `raw` is specified, show the raw contents of
 	the e-mail message; if `diff`, show the diff portion only.
 	Defaults to `raw`.
@@ -261,7 +260,7 @@ message.  Any line that is of the form:
 is taken as the beginning of a patch, and the commit log message
 is terminated before the first occurrence of such a line.
 
-When initially invoking `git am`, you give it the names of the mailboxes
+When initially invoking linkgit:git-am[1], you give it the names of the mailboxes
 to process.  Upon seeing the first patch that does not apply, it
 aborts in the middle.  You can recover from this in one of two ways:
 
@@ -279,8 +278,8 @@ names.
 
 Before any patches are applied, ORIG_HEAD is set to the tip of the
 current branch.  This is useful if you have problems with multiple
-commits, like running 'git am' on the wrong branch or an error in the
-commits that is more easily fixed by changing the mailbox (e.g.
+commits, like running linkgit:git-am[1] on the wrong branch or an error
+in the commits that is more easily fixed by changing the mailbox (e.g.
 errors in the "From:" lines).
 
 HOOKS
-- 
2.53.0.26.g2afa8602a26

