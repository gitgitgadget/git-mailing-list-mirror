Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B14F163
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 22:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770676645; cv=none; b=aD0FjQjKNgBGIKlhYG0jHtZYp+zOwboB8PBS8xtUx6geNXPJNuHaJNKCAN2Gumd1igwZErM4imDHbHx6Ltyu0+3tiSwruARArxYaJuXD13n+wEkFbOYbJ+qwUDLXhZ2jRxXpWFDU54I22A9J1KtYAt5muDpLzNqdQG/zalEi714=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770676645; c=relaxed/simple;
	bh=nMQFIWC5SZyzvKSHRUysAUZ4SU2bMCpLpd7SfWYr6tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CDtgAEYbZ9f5FPfpEkMDPTkgntS8zOSMWmpLtrjBJIpjA0jWqvfZH3nr0VH7YjNKcamI21KhW7yWGufSEIc67VLxnQ6v6pD9pTlgwfGGyRZTWwk9qX6WeqzMmDUGbduEy8ZQSfiEXKzvxHJb+zrjseYaurRVL8OT9CMBge59YLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=qPo4h0C4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XJQYY6GV; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="qPo4h0C4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XJQYY6GV"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id D81B7EC022D;
	Mon,  9 Feb 2026 17:37:21 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 09 Feb 2026 17:37:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770676641;
	 x=1770763041; bh=p7UEfY4+TzM/MR5YzmGKyZlS5JVrwTFGzIg+GI0FVWs=; b=
	qPo4h0C4HLdP97IhWu83YYk8YL454vlkEz+rJLBEYGYSOhLr1Lw/WsCNWWxdpOCF
	7tFduDnSq8yuluazyvVsPF364j+fhZZywVh1dQR+X+tfj6O5Ll26ALKBWrxOMdVC
	5zZn02I/6yuvT7lexiPuWOKJpzfLuol7nl7vqRdbSYVx90aWxxtNla32Db3MzAH3
	zCWAU6CKp0AIA/WHgp4xYSrAxa6QUpYaEJOaqttyqcbTKl0hq7JA11ou073uFCn7
	CCNq1I6OBhubVrPb4+Nh1rsEmlsH+gL3XyJiyF87dkBMgoXfv8jNIfvw05pXP9BZ
	lCiL/ht8DyBVmH62woxJzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770676641; x=
	1770763041; bh=p7UEfY4+TzM/MR5YzmGKyZlS5JVrwTFGzIg+GI0FVWs=; b=X
	JQYY6GVwZHeB+A440u6A8CnfSdgWkNvbhaxdpHdTt/R49DDKJbPo3lZdxAlFwp4j
	2zwarkNKBJ0V4J15YEo0XxjoLYZddF5O+xO4TQvfvuQejlipIic9Yybfwf8SLVGn
	NjMFrybM22/Ihk5bRysdIqx7ef/VrMAB5U4wfiYZX2dUAyzJtncjnUXNIpCkCU2f
	Fo2+epm4NTAQ4qjmTWujanXb2pHsd6emXX59XHju+J4ouyFNUz4qMezNyzcnAtih
	HbaHCimbyrNaIk96sdw+yZAFfCoq2GZi153XmHBe6pHDPjIciSZPQHT3d213+KU2
	IKe7loqfw6iEf0G9YE5JA==
X-ME-Sender: <xms:oWGKaW4vqU7KTzP8BMPxXRZWaAkYGBZmyUMrpr2p3OSm-STjSbn1OF0>
    <xme:oWGKaZ4j9xBXsuDh-NeTC3WN3MAITlrHfOBA4AyX5uqyim9T1RtSCLZYj_J6ZSp3M
    FL4pi3ddnRxopcbLzZR9_audqgL3LPjCtUhfiEmmcbQDbs0V6zn8A>
X-ME-Received: <xmr:oWGKacGsIEW8y5C5StcMAiY-f6z9fwcFn7MKkJ6-mjbE3v5oPoAzHANEDV3CSfcjNv-QyTm5WwWor-nlnSb15J19xJ05xfTCILLQE7x1p0JaRTnfCgiMI7Omcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleektdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlvdefmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmnecuggftrfgrthhtvghrnhepieeuuedvieffvdelffegtdfgvddvieehhfet
    fedufedvuefhffetjeejtdfhvdejnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhh
    gruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepmhgrihhlsegsvgihvghrmhgrthht
    hhhirghsrdguvgdprhgtphhtthhopegtrghlvghsthihohesshgtihgvnhhtihgrrdhorh
    hgpdhrtghpthhtohepmhgrthhhvghushdrthgrvhgssehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepjhhuughgvgdrphgrtghkhhgrmhesghhmrghilhdrtghomhdprhgtphhtthhope
    hsuhhrhehrsehsuhhrhehrrdhnvghtpdhrtghpthhtohepphhhihhllhhiphdrfihoohgu
    seguuhhnvghlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:oWGKaRXywkrUWVTfWXowzQsgRDzEVNErmV9iS7BEMVr-5vWvhtu6Vg>
    <xmx:oWGKaYVBn96zXn4vwo1KcTuEAoUACs-RCl1m3BU1mZ8S8DutxbiNtQ>
    <xmx:oWGKafJD_M37LqLDXDbMayX3P8MMJNXkF8PLCxmvQYDnFlyR0ykhug>
    <xmx:oWGKaQAvql9Udm1z0pZ8gid2xK9QOaPqIkUHyeSPYW_9qV6qs5innQ>
    <xmx:oWGKaeNdpyOgQi94TA6AeUA39X5w7mEEnRhzMI4Off2YgL0a7USfaDGv>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 17:37:19 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Matthias Beyer <mail@beyermatthias.de>,
	Christoph Anton Mitterer <calestyo@scientia.org>,
	Matheus Tavares <matheus.tavb@gmail.com>,
	Chris Packham <judge.packham@gmail.com>,
	Jakob Haufe <sur5r@sur5r.net>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2] doc: add caveat about roundtripping format-patch
Date: Mon,  9 Feb 2026 23:37:05 +0100
Message-ID: <V2_format-patch_caveats.34b@msgid.xyz>
X-Mailer: git-send-email 2.53.0.26.g2afa8602a26
In-Reply-To: <format-patch_caveats.281@msgid.xyz>
References: <format-patch_caveats.281@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

git-format-patch(1) and git-am(1) deal with formatting commits as
patches and applying them, respectively. Naturally they use a few
delimiters to mark where the commit message ends. This can lead to
surprising behavior when these delimiters are used in the commit
message itself.

git-format-patch(1) will accept any commit message and not warn or error
about these delimiters being used.[1]

Especially problematic is the presence of unindented diffs in the commit
message; the patch machinery will naturally (since the commit message
has ended) try to apply that diff and everything after it.[2]

It is unclear whether any commands in this chain will learn to warn
about this. One concern could be that users have learned to rely on
the three-dash line rule to conveniently add extra-commit message
information in the commit message, knowing that git-am(1) will
ignore it.[4]

All of this is covered already, technically. However, we should spell
out the implications.

† 1: There is also git-commit(1) to consider. However, making that
     command warn or error out over such delimiters would be disruptive
     to all Git users who never use email in their workflow.
† 2: Recently patch(1) caused this issue for a project, but it was noted
     that git-am(1) has the same behavior[3]
† 3: https://github.com/i3/i3/pull/6564#issuecomment-3858381425
† 4: https://lore.kernel.org/git/xmqqldh4b5y2.fsf@gitster.g/
     https://lore.kernel.org/git/V2_format-patch_caveats.34b@msgid.xyz/

Reported-by: Matthias Beyer <mail@beyermatthias.de>
Reported-by: Christoph Anton Mitterer <calestyo@scientia.org>
Reported-by: Matheus Tavares <matheus.tavb@gmail.com>
Reported-by: Chris Packham <judge.packham@gmail.com>
Helped-by: Jakob Haufe <sur5r@sur5r.net>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>

---

v2:

Address feedback from Phillip Wood.

Cc: Phillip Wood <phillip.wood@dunelm.org.uk>

• Drop the code blocks with the diffs; the prose speaks for itself, no need
  to take up space
• Don’t discuss git-send-email(1). We already know that git-format-patch(1)
  is the generator. It is mentioned in git-send-email(1).
• Try to be more clear about the case where someone might be applying a
  diff. Use the example from Matthias Beyer in:

      https://lore.kernel.org/git/gfxpnecn2cdtmeiape2d4x5aybuyyqi4c7m6te3khgct34dd44@wqusigna2nsp/

  Hopefully I explained it correctly?
• Add a “this goes to show...”... which seems to emphasize the point
  without being redundant. Hopefully.

Try to address feedback from Junio C Hamano by adding more nuance: the diff
in the commit message might be applied as well, or the patch machinery
might trip on something and fail.

Finally, in the middle of discussing the three possible cmt. message
delimiters, I noticed that the three points were drifting apart. So I
decided to use the list already used in git-am(1) and be done with it in
one place.

---

It seems that the section break in git-format-patch(1) does not get
applied in the man output (according to `Documentation/doc-diff`
apparently)? Maybe this is the wrong construct? I couldn’t find any
other thematic breaks here (though there are several variations).
---
 Documentation/format-patch-caveats.adoc       | 36 +++++++++++++++++++
 .../format-patch-end-of-commit-message.adoc   |  3 ++
 Documentation/git-am.adoc                     | 15 ++++++--
 Documentation/git-format-patch.adoc           |  4 +++
 Documentation/git-send-email.adoc             |  5 +++
 5 files changed, 60 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/format-patch-caveats.adoc
 create mode 100644 Documentation/format-patch-end-of-commit-message.adoc

diff --git a/Documentation/format-patch-caveats.adoc b/Documentation/format-patch-caveats.adoc
new file mode 100644
index 00000000000..c666d709742
--- /dev/null
+++ b/Documentation/format-patch-caveats.adoc
@@ -0,0 +1,36 @@
+Patches produced by linkgit:git-format-patch[1] are inline. This means
+that the output from that command can lead to a different commit message
+when applied with linkgit:git-am[1]. It can also mean that the patch
+that is applied is not the same as the one that was generated, or that
+the patch application fails outright.
+ifdef::git-am[]
+See the <<discussion,DISCUSSION>> section above for the syntactic rules.
+endif::git-am[]
+
+ifndef::git-am[]
+Any line that is of the form:
+
+include::format-patch-end-of-commit-message.adoc[]
+
+will terminate the commit message and cause the patch machinery to start
+searching for patches to apply.
+endif::git-am[]
+
+Note that this is especially problematic for unindented diffs that occur
+in the commit message; the diff in the commit message might get applied
+along with the patch section, or the patch application machinery might
+trip up because the patch target doesn't apply. This could for example
+be caused by a diff in a GitHub Markdown code block.
+
+This loss of fidelity might be simple to notice if you are applying
+patches directly from a mailbox. However, changes originating from Git
+could be applied in bulk, in which case this would be much harder to
+notice. This could for example be a Linux distribution which uses patch
+files to apply changes on top of the commits from the upstream
+repositories. This goes to show that this behavior does not only impact
+email workflows.
+
+Given these limitations, one might be tempted to use a general-purpose
+utility like patch(1) instead. However, patch(1) will not only look for
+unindented diffs (like linkgit:git-am[1]) but will try to apply indented
+diffs as well.
diff --git a/Documentation/format-patch-end-of-commit-message.adoc b/Documentation/format-patch-end-of-commit-message.adoc
new file mode 100644
index 00000000000..47399ae7266
--- /dev/null
+++ b/Documentation/format-patch-end-of-commit-message.adoc
@@ -0,0 +1,3 @@
+* three-dashes and end-of-line, or
+* a line that begins with "diff -", or
+* a line that begins with "Index: "
diff --git a/Documentation/git-am.adoc b/Documentation/git-am.adoc
index 0c94776e296..756dfd722b9 100644
--- a/Documentation/git-am.adoc
+++ b/Documentation/git-am.adoc
@@ -231,10 +231,11 @@ applying.
 --allow-empty::
 	After a patch failure on an input e-mail message lacking a patch,
 	create an empty commit with the contents of the e-mail message
 	as its log message.
 
+[[discussion]]
 DISCUSSION
 ----------
 
 The commit author name is taken from the "From: " line of the
 message, and commit author date is taken from the "Date: " line
@@ -252,17 +253,18 @@ where the patch begins.  Excess whitespace at the end of each
 line is automatically stripped.
 
 The patch is expected to be inline, directly following the
 message.  Any line that is of the form:
 
-* three-dashes and end-of-line, or
-* a line that begins with "diff -", or
-* a line that begins with "Index: "
+include::format-patch-end-of-commit-message.adoc[]
 
 is taken as the beginning of a patch, and the commit log message
 is terminated before the first occurrence of such a line.
 
+This means that the contents of the commit message can inadvertently
+interrupt the processing (see the <<caveats,CAVEATS>> section below).
+
 When initially invoking `git am`, you give it the names of the mailboxes
 to process.  Upon seeing the first patch that does not apply, it
 aborts in the middle.  You can recover from this in one of two ways:
 
 . skip the current patch by re-running the command with the `--skip`
@@ -281,10 +283,17 @@ Before any patches are applied, ORIG_HEAD is set to the tip of the
 current branch.  This is useful if you have problems with multiple
 commits, like running 'git am' on the wrong branch or an error in the
 commits that is more easily fixed by changing the mailbox (e.g.
 errors in the "From:" lines).
 
+[[caveats]]
+CAVEATS
+-------
+
+:git-am: 1
+include::format-patch-caveats.adoc[]
+
 HOOKS
 -----
 This command can run `applypatch-msg`, `pre-applypatch`,
 and `post-applypatch` hooks.  See linkgit:githooks[5] for more
 information.
diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
index 9a7807ca71a..36851aaf5e1 100644
--- a/Documentation/git-format-patch.adoc
+++ b/Documentation/git-format-patch.adoc
@@ -796,10 +796,14 @@ CAVEATS
 Note that `format-patch` will omit merge commits from the output, even
 if they are part of the requested range. A simple "patch" does not
 include enough information for the receiving end to reproduce the same
 merge commit.
 
+'''
+
+include::format-patch-caveats.adoc[]
+
 SEE ALSO
 --------
 linkgit:git-am[1], linkgit:git-send-email[1]
 
 GIT
diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
index ebe8853e9f5..0b118df6498 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -690,10 +690,15 @@ Links of a few such community maintained helpers are:
 	  (cross platform client that can send emails using the ProtonMail API)
 
 	- https://github.com/AdityaGarg8/git-credential-email[git-msgraph]
 	  (cross platform client that can send emails using the Microsoft Graph API)
 
+CAVEATS
+-------
+
+include::format-patch-caveats.adoc[]
+
 SEE ALSO
 --------
 linkgit:git-format-patch[1], linkgit:git-imap-send[1], mbox(5)
 
 GIT

Interdiff against v1:
  diff --git a/Documentation/format-patch-caveats.adoc b/Documentation/format-patch-caveats.adoc
  index 2accf2763fd..c666d709742 100644
  --- a/Documentation/format-patch-caveats.adoc
  +++ b/Documentation/format-patch-caveats.adoc
  @@ -1,39 +1,36 @@
  -Patches produced by linkgit:git-format-patch[1] or
  -linkgit:git-send-email[1] are inline. This means that the output of
  -these two commands can lead to a different commit message when applied
  -with linkgit:git-am[1]. It can also mean that the patch is not applied
  -correctly.
  +Patches produced by linkgit:git-format-patch[1] are inline. This means
  +that the output from that command can lead to a different commit message
  +when applied with linkgit:git-am[1]. It can also mean that the patch
  +that is applied is not the same as the one that was generated, or that
  +the patch application fails outright.
  +ifdef::git-am[]
  +See the <<discussion,DISCUSSION>> section above for the syntactic rules.
  +endif::git-am[]
   
  -The commit message might contain a three-dash line (`---`) which was
  -perhaps meant to be a thematic break. That means that the commit message
  -will be cut short. The presence of a line starting with "Index: " can
  -cause the patch not to be found, giving an error about an empty patch.
  +ifndef::git-am[]
  +Any line that is of the form:
   
  -Furthermore, the presence of an unindented diff in the commit message
  -will not only cut the message short but cause that very diff to be
  -applied, along with the patch in the patch section. The commit message
  -might for example have a diff in a GitHub MarkDown code fence:
  +include::format-patch-end-of-commit-message.adoc[]
   
  -----
  -```
  -diff ...
  -```
  -----
  +will terminate the commit message and cause the patch machinery to start
  +searching for patches to apply.
  +endif::git-am[]
   
  -The solution for this is to indent the diff instead:
  -
  -----
  -    diff ...
  -----
  +Note that this is especially problematic for unindented diffs that occur
  +in the commit message; the diff in the commit message might get applied
  +along with the patch section, or the patch application machinery might
  +trip up because the patch target doesn't apply. This could for example
  +be caused by a diff in a GitHub Markdown code block.
   
   This loss of fidelity might be simple to notice if you are applying
  -patches directly from a mailbox. However, a commit authored long ago
  -might be applied in a different context, perhaps because many changes
  -are being integrated via patch files and the
  -linkgit:git-format-patch[1] format is trusted to import changes of a
  -Git origin.
  +patches directly from a mailbox. However, changes originating from Git
  +could be applied in bulk, in which case this would be much harder to
  +notice. This could for example be a Linux distribution which uses patch
  +files to apply changes on top of the commits from the upstream
  +repositories. This goes to show that this behavior does not only impact
  +email workflows.
   
  -One might want to use a general-purpose utility like patch(1) instead,
  -given these limitations. However, patch(1) will not only look for
  +Given these limitations, one might be tempted to use a general-purpose
  +utility like patch(1) instead. However, patch(1) will not only look for
   unindented diffs (like linkgit:git-am[1]) but will try to apply indented
   diffs as well.
  diff --git a/Documentation/format-patch-end-of-commit-message.adoc b/Documentation/format-patch-end-of-commit-message.adoc
  new file mode 100644
  index 00000000000..47399ae7266
  --- /dev/null
  +++ b/Documentation/format-patch-end-of-commit-message.adoc
  @@ -0,0 +1,3 @@
  +* three-dashes and end-of-line, or
  +* a line that begins with "diff -", or
  +* a line that begins with "Index: "
  diff --git a/Documentation/git-am.adoc b/Documentation/git-am.adoc
  index 18f5b950825..756dfd722b9 100644
  --- a/Documentation/git-am.adoc
  +++ b/Documentation/git-am.adoc
  @@ -231,10 +231,11 @@ applying.
   --allow-empty::
   	After a patch failure on an input e-mail message lacking a patch,
   	create an empty commit with the contents of the e-mail message
   	as its log message.
   
  +[[discussion]]
   DISCUSSION
   ----------
   
   The commit author name is taken from the "From: " line of the
   message, and commit author date is taken from the "Date: " line
  @@ -252,18 +253,16 @@ where the patch begins.  Excess whitespace at the end of each
   line is automatically stripped.
   
   The patch is expected to be inline, directly following the
   message.  Any line that is of the form:
   
  -* three-dashes and end-of-line, or
  -* a line that begins with "diff -", or
  -* a line that begins with "Index: "
  +include::format-patch-end-of-commit-message.adoc[]
   
   is taken as the beginning of a patch, and the commit log message
   is terminated before the first occurrence of such a line.
   
  -This means that the content of the commit message can inadverently
  +This means that the contents of the commit message can inadvertently
   interrupt the processing (see the <<caveats,CAVEATS>> section below).
   
   When initially invoking `git am`, you give it the names of the mailboxes
   to process.  Upon seeing the first patch that does not apply, it
   aborts in the middle.  You can recover from this in one of two ways:
  @@ -288,10 +287,11 @@ errors in the "From:" lines).
   
   [[caveats]]
   CAVEATS
   -------
   
  +:git-am: 1
   include::format-patch-caveats.adoc[]
   
   HOOKS
   -----
   This command can run `applypatch-msg`, `pre-applypatch`,

Range-diff against v1:
1:  4bed8f55b98 ! 1:  c54f394bb33 doc: add caveat about roundtripping format-patch
    @@ Metadata
      ## Commit message ##
         doc: add caveat about roundtripping format-patch
     
    -    git-format-patch(1), git-send-email(1), and git-am(1) deal with
    -    formatting commits as patches, sending them (perhaps directly), and
    -    applying them, respectively. Naturally they use a few delimiters to mark
    -    where the commit message ends. This can lead to surprising behavior when
    -    these delimiters are used in the commit message itself.
    +    git-format-patch(1) and git-am(1) deal with formatting commits as
    +    patches and applying them, respectively. Naturally they use a few
    +    delimiters to mark where the commit message ends. This can lead to
    +    surprising behavior when these delimiters are used in the commit
    +    message itself.
     
    -    git-format-patch(1) and git-send-email(1) will accept any commit message
    -    and not warn or error about these delimiters being used.[1]
    +    git-format-patch(1) will accept any commit message and not warn or error
    +    about these delimiters being used.[1]
     
    -    Moreover, the presence of unindented diffs in the commit message will
    -    cause git-am(1) to apply both the diffs from the commit message as well
    -    as the patch section.[2]
    +    Especially problematic is the presence of unindented diffs in the commit
    +    message; the patch machinery will naturally (since the commit message
    +    has ended) try to apply that diff and everything after it.[2]
     
         It is unclear whether any commands in this chain will learn to warn
         about this. One concern could be that users have learned to rely on
    @@ Commit message
         information in the commit message, knowing that git-am(1) will
         ignore it.[4]
     
    -    All of this is covered already, technically, However, we should spell
    +    All of this is covered already, technically. However, we should spell
         out the implications.
     
         † 1: There is also git-commit(1) to consider. However, making that
              command warn or error out over such delimiters would be disruptive
              to all Git users who never use email in their workflow.
    -    [2]: Recently patch(1) caused this issue for a project, but it was noted
    +    † 2: Recently patch(1) caused this issue for a project, but it was noted
              that git-am(1) has the same behavior[3]
    -    [3]: https://github.com/i3/i3/pull/6564#issuecomment-3858381425
    -    [4]: https://lore.kernel.org/git/xmqqldh4b5y2.fsf@gitster.g/
    +    † 3: https://github.com/i3/i3/pull/6564#issuecomment-3858381425
    +    † 4: https://lore.kernel.org/git/xmqqldh4b5y2.fsf@gitster.g/
    +         https://lore.kernel.org/git/V2_format-patch_caveats.34b@msgid.xyz/
     
         Reported-by: Matthias Beyer <mail@beyermatthias.de>
         Reported-by: Christoph Anton Mitterer <calestyo@scientia.org>
    @@ Commit message
         Helped-by: Jakob Haufe <sur5r@sur5r.net>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
    +    ---
    +
    +    v2:
    +
    +    Address feedback from Phillip Wood.
    +
    +    Cc: Phillip Wood <phillip.wood@dunelm.org.uk>
    +
    +    • Drop the code blocks with the diffs; the prose speaks for itself, no need
    +      to take up space
    +    • Don’t discuss git-send-email(1). We already know that git-format-patch(1)
    +      is the generator. It is mentioned in git-send-email(1).
    +    • Try to be more clear about the case where someone might be applying a
    +      diff. Use the example from Matthias Beyer in:
    +
    +          https://lore.kernel.org/git/gfxpnecn2cdtmeiape2d4x5aybuyyqi4c7m6te3khgct34dd44@wqusigna2nsp/
    +
    +      Hopefully I explained it correctly?
    +    • Add a “this goes to show...”... which seems to emphasize the point
    +      without being redundant. Hopefully.
    +
    +    Try to address feedback from Junio C Hamano by adding more nuance: the diff
    +    in the commit message might be applied as well, or the patch machinery
    +    might trip on something and fail.
    +
    +    Finally, in the middle of discussing the three possible cmt. message
    +    delimiters, I noticed that the three points were drifting apart. So I
    +    decided to use the list already used in git-am(1) and be done with it in
    +    one place.
    +
    +    ---
    +
    +    It seems that the section break in git-format-patch(1) does not get
    +    applied in the man output (according to `Documentation/doc-diff`
    +    apparently)? Maybe this is the wrong construct? I couldn’t find any
    +    other thematic breaks here (though there are several variations).
    +
      ## Documentation/format-patch-caveats.adoc (new) ##
     @@
    -+Patches produced by linkgit:git-format-patch[1] or
    -+linkgit:git-send-email[1] are inline. This means that the output of
    -+these two commands can lead to a different commit message when applied
    -+with linkgit:git-am[1]. It can also mean that the patch is not applied
    -+correctly.
    -+
    -+The commit message might contain a three-dash line (`---`) which was
    -+perhaps meant to be a thematic break. That means that the commit message
    -+will be cut short. The presence of a line starting with "Index: " can
    -+cause the patch not to be found, giving an error about an empty patch.
    ++Patches produced by linkgit:git-format-patch[1] are inline. This means
    ++that the output from that command can lead to a different commit message
    ++when applied with linkgit:git-am[1]. It can also mean that the patch
    ++that is applied is not the same as the one that was generated, or that
    ++the patch application fails outright.
    ++ifdef::git-am[]
    ++See the <<discussion,DISCUSSION>> section above for the syntactic rules.
    ++endif::git-am[]
     +
    -+Furthermore, the presence of an unindented diff in the commit message
    -+will not only cut the message short but cause that very diff to be
    -+applied, along with the patch in the patch section. The commit message
    -+might for example have a diff in a GitHub MarkDown code fence:
    ++ifndef::git-am[]
    ++Any line that is of the form:
     +
    -+----
    -+```
    -+diff ...
    -+```
    -+----
    ++include::format-patch-end-of-commit-message.adoc[]
     +
    -+The solution for this is to indent the diff instead:
    ++will terminate the commit message and cause the patch machinery to start
    ++searching for patches to apply.
    ++endif::git-am[]
     +
    -+----
    -+    diff ...
    -+----
    ++Note that this is especially problematic for unindented diffs that occur
    ++in the commit message; the diff in the commit message might get applied
    ++along with the patch section, or the patch application machinery might
    ++trip up because the patch target doesn't apply. This could for example
    ++be caused by a diff in a GitHub Markdown code block.
     +
     +This loss of fidelity might be simple to notice if you are applying
    -+patches directly from a mailbox. However, a commit authored long ago
    -+might be applied in a different context, perhaps because many changes
    -+are being integrated via patch files and the
    -+linkgit:git-format-patch[1] format is trusted to import changes of a
    -+Git origin.
    ++patches directly from a mailbox. However, changes originating from Git
    ++could be applied in bulk, in which case this would be much harder to
    ++notice. This could for example be a Linux distribution which uses patch
    ++files to apply changes on top of the commits from the upstream
    ++repositories. This goes to show that this behavior does not only impact
    ++email workflows.
     +
    -+One might want to use a general-purpose utility like patch(1) instead,
    -+given these limitations. However, patch(1) will not only look for
    ++Given these limitations, one might be tempted to use a general-purpose
    ++utility like patch(1) instead. However, patch(1) will not only look for
     +unindented diffs (like linkgit:git-am[1]) but will try to apply indented
     +diffs as well.
     
    + ## Documentation/format-patch-end-of-commit-message.adoc (new) ##
    +@@
    ++* three-dashes and end-of-line, or
    ++* a line that begins with "diff -", or
    ++* a line that begins with "Index: "
    +
      ## Documentation/git-am.adoc ##
    -@@ Documentation/git-am.adoc: message.  Any line that is of the form:
    +@@ Documentation/git-am.adoc: applying.
    + 	create an empty commit with the contents of the e-mail message
    + 	as its log message.
    + 
    ++[[discussion]]
    + DISCUSSION
    + ----------
    + 
    +@@ Documentation/git-am.adoc: line is automatically stripped.
    + The patch is expected to be inline, directly following the
    + message.  Any line that is of the form:
    + 
    +-* three-dashes and end-of-line, or
    +-* a line that begins with "diff -", or
    +-* a line that begins with "Index: "
    ++include::format-patch-end-of-commit-message.adoc[]
    + 
      is taken as the beginning of a patch, and the commit log message
      is terminated before the first occurrence of such a line.
      
    -+This means that the content of the commit message can inadverently
    ++This means that the contents of the commit message can inadvertently
     +interrupt the processing (see the <<caveats,CAVEATS>> section below).
     +
      When initially invoking `git am`, you give it the names of the mailboxes
    @@ Documentation/git-am.adoc: commits, like running 'git am' on the wrong branch or
     +CAVEATS
     +-------
     +
    ++:git-am: 1
     +include::format-patch-caveats.adoc[]
     +
      HOOKS

base-commit: 3e0db84c88c57e70ac8be8c196dfa92c5d656fbc
-- 
2.53.0.26.g2afa8602a26

