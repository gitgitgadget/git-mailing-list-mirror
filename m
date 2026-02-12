Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8953327FB21
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 22:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770935336; cv=none; b=nJe9cEpeYjtwf4rGon6xF2UrCI3HnvEjToer6CFVn7TCSvAUQq0h/UfR8/R1GANr6FBzwK/iHy+OdY0Q9ND7fZWgCiVBIh2Qf0mIrH8+aVe/fUF1cYKmNsdXt+tQ9qR+eKaoCMF0QOu0ZKzDtYxuwDVLD9ePbHY7xRrSgeh6fLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770935336; c=relaxed/simple;
	bh=Ltey0SJPt6I2yEE5DXOtY37eOfjvSNtjrXVg7iD5/Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M7mqY0fuhr+yhm2geiGMED+Ibjr3cVbdvbibLWJS7Yf5lTdNzHPVt1SSyYFMm4UaMPURED8ZrnR9+Oz3K5j1RMldani/uYiOAlB/uGOdOu1HtP7Won9mBsiVR8MeYTuvp7XnBybprkKk3GaZVFPMTsIvmDaFn5Zue1Jx15toma4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=eB3JSWyA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AiiP8hRa; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="eB3JSWyA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AiiP8hRa"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CF99A14001B5;
	Thu, 12 Feb 2026 17:28:53 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 12 Feb 2026 17:28:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770935333;
	 x=1771021733; bh=0WMAVI/R9penUU6dSmYA2gdzpeK8lNg4StPYFExH16Q=; b=
	eB3JSWyA3Q1AQABltSOBTcucHzgOCHTHeaUdgfnhhJW2ryHJjBjvLtUl1gWX745K
	nby26+JLKzdDSRVKhUm1vpBw+uLMMzO9HRhU9aJ7/RBxszFjnFKKH/iyZW2EeUgw
	RAF3MHpUuaJVmVaVT6JttFIMf02WRmgW3wIh8Y7VjPuQertNzEMoq7BcGKAAHVlP
	k3xZAVBtDVI0c23AR5QpdnSgDioiBDeBwTdSqTZhNTiMZZPOYp8toImLLQjNo/uZ
	yq2TOe5UJAN3jbe/v0Yg7UOQKKZIYvmcZXhHJELOQKU1zTLM0K+e8t61fkMKPR+Y
	2qMluEvp4/rh+pZiVP4q5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770935333; x=
	1771021733; bh=0WMAVI/R9penUU6dSmYA2gdzpeK8lNg4StPYFExH16Q=; b=A
	iiP8hRajSJpYe1oeRHy8p+SmRJUsaKZb01ePrdx8LyZcotiq4aN7KdB1eqTghyaA
	vcXcbL1oQ5bkDs0kCSQam87w/GLBWvuf/Udh71DSu+/t8hVEl3Y6nX2YbWhVVtsd
	CkbHAOaoFPnkWz4Q8eZNiKu8Xsq64V6Q+JDFXUP//e/BpG/5y0BMuIYdUTknH4qN
	ZtaZp2WsCTbidUk3RVVTl/jSIn1GBPGTfAas9swfyYrj+KIKdsXjFD8WcMeNRSNF
	ToK4pmT5E/KBTPCHzkB4YqcBIJzUU0n8z3dgC1ECoDMXCKCJWn1sFKQc0pWXsQVW
	2dFyFIFGtKlEiH62RvwOQ==
X-ME-Sender: <xms:JFSOaUu95LiQASgcKXxvtkxLZtrUve0eEEJ4KoX04NVw7Ysu9EnCpiA>
    <xme:JFSOabcYgztCXHzg6ik-lYv4uKL9SCeH18uLGxfAoSVBSzHEM62wrLmlkkwIEMbY9
    G5EDyYBQzjZKNXQiYIJroWE8MnWKcxj7x3USrntVE0vr3OILbSXjXU>
X-ME-Received: <xmr:JFSOaWZ--MH0lblAPZa4yTzQOET7xczeDeAR48Rf_x4fLPgBy0LbEtGyJbf4osMarSAh3eFo8wh40VLL4aW2TddhVqlqMwiIio-Y7RKR3cLRMt7D7zsrt2N9JA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdeiheejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:JFSOaVZzHbOacoD6oRdxKwsF945rnW9PmPrVhBq0hiuSaM_sOzgEBA>
    <xmx:JFSOaTKwNCN9I4PtqW36Uz3CJQRYaDVF2DezjaHI6fSOIF4f1D3N8g>
    <xmx:JFSOaZvRh1CSL3GZQWUZMCOhHKmOdOiMGlpARP7qK2U-eKyFz_-azg>
    <xmx:JFSOafVVJ3wN1LRfE4N7GSan1IEfIqYlx2uMg1iMNCrrnvGzx05VZA>
    <xmx:JVSOaR0XOSydcJlDdLjtQeIlS4aaZ5QMzVVAOGQAHWDKTPxs8cY1RsPq>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Feb 2026 17:28:50 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Matthias Beyer <mail@beyermatthias.de>,
	Christoph Anton Mitterer <calestyo@scientia.org>,
	Matheus Tavares <matheus.tavb@gmail.com>,
	Chris Packham <judge.packham@gmail.com>,
	Jakob Haufe <sur5r@sur5r.net>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3] doc: add caveat about round-tripping format-patch
Date: Thu, 12 Feb 2026 23:28:23 +0100
Message-ID: <V3_format-patch_caveats.354@msgid.xyz>
X-Mailer: git-send-email 2.53.0.26.g2afa8602a26
In-Reply-To: <V2_format-patch_caveats.34b@msgid.xyz>
References: <V2_format-patch_caveats.34b@msgid.xyz>
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
     https://lore.kernel.org/git/V3_format-patch_caveats.354@msgid.xyz/

Reported-by: Matthias Beyer <mail@beyermatthias.de>
Reported-by: Christoph Anton Mitterer <calestyo@scientia.org>
Reported-by: Matheus Tavares <matheus.tavb@gmail.com>
Reported-by: Chris Packham <judge.packham@gmail.com>
Helped-by: Jakob Haufe <sur5r@sur5r.net>
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>

---

v3:

Drop “[GitHub] Markdown” based on discussion with Phillip.

Address Junio’s feedback about not using a needless
“this means” construct.

Also:
• Pull out the whole syntactic rules section instead of just the list
• Add back the solution paragraph (indent diff or other problematic
  text) that I accidentally deleted in v2.
• Resolve the thematic break problem (not rendered in man) by using a
  subheading (Patch Application)
• Fine, Merriam Webster says that roundtripping is “less commonly
  used” (use round-trip)

Link to v2: https://lore.kernel.org/git/V2_format-patch_caveats.34b@msgid.xyz/
Link to v1: https://lore.kernel.org/git/format-patch_caveats.281@msgid.xyz/
---
 Documentation/format-patch-caveats.adoc       | 33 +++++++++++++++++++
 .../format-patch-end-of-commit-message.adoc   |  8 +++++
 Documentation/git-am.adoc                     | 19 +++++++----
 Documentation/git-format-patch.adoc           |  4 +++
 Documentation/git-send-email.adoc             |  5 +++
 5 files changed, 62 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/format-patch-caveats.adoc
 create mode 100644 Documentation/format-patch-end-of-commit-message.adoc

diff --git a/Documentation/format-patch-caveats.adoc b/Documentation/format-patch-caveats.adoc
new file mode 100644
index 00000000000..807a65b885b
--- /dev/null
+++ b/Documentation/format-patch-caveats.adoc
@@ -0,0 +1,33 @@
+The output from linkgit:git-format-patch[1] can lead to a different
+commit message when applied with linkgit:git-am[1]. The patch that is
+applied may also be different from the one that was generated, or patch
+application may fail outright.
+ifdef::git-am[]
+See the <<discussion,DISCUSSION>> section above for the syntactic rules.
+endif::git-am[]
+
+ifndef::git-am[]
+include::format-patch-end-of-commit-message.adoc[]
+endif::git-am[]
+
+Note that this is especially problematic for unindented diffs that occur
+in the commit message; the diff in the commit message might get applied
+along with the patch section, or the patch application machinery might
+trip up because the patch target doesn't apply. This could for example
+be caused by a diff in a Markdown code block.
+
+The solution for this is to indent the diff or other text that could
+cause problems.
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
index 00000000000..ec1ef79f5e3
--- /dev/null
+++ b/Documentation/format-patch-end-of-commit-message.adoc
@@ -0,0 +1,8 @@
+Any line that is of the form:
+
+* three-dashes and end-of-line, or
+* a line that begins with "diff -", or
+* a line that begins with "Index: "
+
+is taken as the beginning of a patch, and the commit log message
+is terminated before the first occurrence of such a line.
diff --git a/Documentation/git-am.adoc b/Documentation/git-am.adoc
index 0c94776e296..972398d4575 100644
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
@@ -250,18 +251,15 @@ The commit message is formed by the title taken from the
 "Subject: ", a blank line and the body of the message up to
 where the patch begins.  Excess whitespace at the end of each
 line is automatically stripped.
 
 The patch is expected to be inline, directly following the
-message.  Any line that is of the form:
+message.
+include::format-patch-end-of-commit-message.adoc[]
 
-* three-dashes and end-of-line, or
-* a line that begins with "diff -", or
-* a line that begins with "Index: "
-
-is taken as the beginning of a patch, and the commit log message
-is terminated before the first occurrence of such a line.
+This means that the contents of the commit message can inadvertently
+interrupt the processing (see the <<caveats,CAVEATS>> section below).
 
 When initially invoking `git am`, you give it the names of the mailboxes
 to process.  Upon seeing the first patch that does not apply, it
 aborts in the middle.  You can recover from this in one of two ways:
 
@@ -281,10 +279,17 @@ Before any patches are applied, ORIG_HEAD is set to the tip of the
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
index 9a7807ca71a..bac9b818f3b 100644
--- a/Documentation/git-format-patch.adoc
+++ b/Documentation/git-format-patch.adoc
@@ -796,10 +796,14 @@ CAVEATS
 Note that `format-patch` will omit merge commits from the output, even
 if they are part of the requested range. A simple "patch" does not
 include enough information for the receiving end to reproduce the same
 merge commit.
 
+=== PATCH APPLICATION
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

Interdiff against v2:
  diff --git a/Documentation/format-patch-caveats.adoc b/Documentation/format-patch-caveats.adoc
  index c666d709742..807a65b885b 100644
  --- a/Documentation/format-patch-caveats.adoc
  +++ b/Documentation/format-patch-caveats.adoc
  @@ -1,28 +1,25 @@
  -Patches produced by linkgit:git-format-patch[1] are inline. This means
  -that the output from that command can lead to a different commit message
  -when applied with linkgit:git-am[1]. It can also mean that the patch
  -that is applied is not the same as the one that was generated, or that
  -the patch application fails outright.
  +The output from linkgit:git-format-patch[1] can lead to a different
  +commit message when applied with linkgit:git-am[1]. The patch that is
  +applied may also be different from the one that was generated, or patch
  +application may fail outright.
   ifdef::git-am[]
   See the <<discussion,DISCUSSION>> section above for the syntactic rules.
   endif::git-am[]
   
   ifndef::git-am[]
  -Any line that is of the form:
  -
   include::format-patch-end-of-commit-message.adoc[]
  -
  -will terminate the commit message and cause the patch machinery to start
  -searching for patches to apply.
   endif::git-am[]
   
   Note that this is especially problematic for unindented diffs that occur
   in the commit message; the diff in the commit message might get applied
   along with the patch section, or the patch application machinery might
   trip up because the patch target doesn't apply. This could for example
  -be caused by a diff in a GitHub Markdown code block.
  +be caused by a diff in a Markdown code block.
  +
  +The solution for this is to indent the diff or other text that could
  +cause problems.
   
   This loss of fidelity might be simple to notice if you are applying
   patches directly from a mailbox. However, changes originating from Git
   could be applied in bulk, in which case this would be much harder to
   notice. This could for example be a Linux distribution which uses patch
  diff --git a/Documentation/format-patch-end-of-commit-message.adoc b/Documentation/format-patch-end-of-commit-message.adoc
  index 47399ae7266..ec1ef79f5e3 100644
  --- a/Documentation/format-patch-end-of-commit-message.adoc
  +++ b/Documentation/format-patch-end-of-commit-message.adoc
  @@ -1,3 +1,8 @@
  +Any line that is of the form:
  +
   * three-dashes and end-of-line, or
   * a line that begins with "diff -", or
   * a line that begins with "Index: "
  +
  +is taken as the beginning of a patch, and the commit log message
  +is terminated before the first occurrence of such a line.
  diff --git a/Documentation/git-am.adoc b/Documentation/git-am.adoc
  index 756dfd722b9..972398d4575 100644
  --- a/Documentation/git-am.adoc
  +++ b/Documentation/git-am.adoc
  @@ -251,17 +251,13 @@ The commit message is formed by the title taken from the
   "Subject: ", a blank line and the body of the message up to
   where the patch begins.  Excess whitespace at the end of each
   line is automatically stripped.
   
   The patch is expected to be inline, directly following the
  -message.  Any line that is of the form:
  -
  +message.
   include::format-patch-end-of-commit-message.adoc[]
   
  -is taken as the beginning of a patch, and the commit log message
  -is terminated before the first occurrence of such a line.
  -
   This means that the contents of the commit message can inadvertently
   interrupt the processing (see the <<caveats,CAVEATS>> section below).
   
   When initially invoking `git am`, you give it the names of the mailboxes
   to process.  Upon seeing the first patch that does not apply, it
  diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
  index 36851aaf5e1..bac9b818f3b 100644
  --- a/Documentation/git-format-patch.adoc
  +++ b/Documentation/git-format-patch.adoc
  @@ -796,11 +796,11 @@ CAVEATS
   Note that `format-patch` will omit merge commits from the output, even
   if they are part of the requested range. A simple "patch" does not
   include enough information for the receiving end to reproduce the same
   merge commit.
   
  -'''
  +=== PATCH APPLICATION
   
   include::format-patch-caveats.adoc[]
   
   SEE ALSO
   --------

Range-diff against v2:
1:  c54f394bb33 ! 1:  b51273c82c9 doc: add caveat about roundtripping format-patch
    @@ Metadata
     Author: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Commit message ##
    -    doc: add caveat about roundtripping format-patch
    +    doc: add caveat about round-tripping format-patch
     
         git-format-patch(1) and git-am(1) deal with formatting commits as
         patches and applying them, respectively. Naturally they use a few
    @@ Commit message
              that git-am(1) has the same behavior[3]
         † 3: https://github.com/i3/i3/pull/6564#issuecomment-3858381425
         † 4: https://lore.kernel.org/git/xmqqldh4b5y2.fsf@gitster.g/
    -         https://lore.kernel.org/git/V2_format-patch_caveats.34b@msgid.xyz/
    +         https://lore.kernel.org/git/V3_format-patch_caveats.354@msgid.xyz/
     
         Reported-by: Matthias Beyer <mail@beyermatthias.de>
         Reported-by: Christoph Anton Mitterer <calestyo@scientia.org>
         Reported-by: Matheus Tavares <matheus.tavb@gmail.com>
         Reported-by: Chris Packham <judge.packham@gmail.com>
         Helped-by: Jakob Haufe <sur5r@sur5r.net>
    +    Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
         ---
     
    -    v2:
    +    v3:
     
    -    Address feedback from Phillip Wood.
    +    Drop “[GitHub] Markdown” based on discussion with Phillip.
     
    -    Cc: Phillip Wood <phillip.wood@dunelm.org.uk>
    +    Address Junio’s feedback about not using a needless
    +    “this means” construct.
     
    -    • Drop the code blocks with the diffs; the prose speaks for itself, no need
    -      to take up space
    -    • Don’t discuss git-send-email(1). We already know that git-format-patch(1)
    -      is the generator. It is mentioned in git-send-email(1).
    -    • Try to be more clear about the case where someone might be applying a
    -      diff. Use the example from Matthias Beyer in:
    +    Also:
    +    • Pull out the whole syntactic rules section instead of just the list
    +    • Add back the solution paragraph (indent diff or other problematic
    +      text) that I accidentally deleted in v2.
    +    • Resolve the thematic break problem (not rendered in man) by using a
    +      subheading (Patch Application)
    +    • Fine, Merriam Webster says that roundtripping is “less commonly
    +      used” (use round-trip)
     
    -          https://lore.kernel.org/git/gfxpnecn2cdtmeiape2d4x5aybuyyqi4c7m6te3khgct34dd44@wqusigna2nsp/
    -
    -      Hopefully I explained it correctly?
    -    • Add a “this goes to show...”... which seems to emphasize the point
    -      without being redundant. Hopefully.
    -
    -    Try to address feedback from Junio C Hamano by adding more nuance: the diff
    -    in the commit message might be applied as well, or the patch machinery
    -    might trip on something and fail.
    -
    -    Finally, in the middle of discussing the three possible cmt. message
    -    delimiters, I noticed that the three points were drifting apart. So I
    -    decided to use the list already used in git-am(1) and be done with it in
    -    one place.
    -
    -    ---
    -
    -    It seems that the section break in git-format-patch(1) does not get
    -    applied in the man output (according to `Documentation/doc-diff`
    -    apparently)? Maybe this is the wrong construct? I couldn’t find any
    -    other thematic breaks here (though there are several variations).
    +    Link to v2: https://lore.kernel.org/git/V2_format-patch_caveats.34b@msgid.xyz/
    +    Link to v1: https://lore.kernel.org/git/format-patch_caveats.281@msgid.xyz/
     
      ## Documentation/format-patch-caveats.adoc (new) ##
     @@
    -+Patches produced by linkgit:git-format-patch[1] are inline. This means
    -+that the output from that command can lead to a different commit message
    -+when applied with linkgit:git-am[1]. It can also mean that the patch
    -+that is applied is not the same as the one that was generated, or that
    -+the patch application fails outright.
    ++The output from linkgit:git-format-patch[1] can lead to a different
    ++commit message when applied with linkgit:git-am[1]. The patch that is
    ++applied may also be different from the one that was generated, or patch
    ++application may fail outright.
     +ifdef::git-am[]
     +See the <<discussion,DISCUSSION>> section above for the syntactic rules.
     +endif::git-am[]
     +
     +ifndef::git-am[]
    -+Any line that is of the form:
    -+
     +include::format-patch-end-of-commit-message.adoc[]
    -+
    -+will terminate the commit message and cause the patch machinery to start
    -+searching for patches to apply.
     +endif::git-am[]
     +
     +Note that this is especially problematic for unindented diffs that occur
     +in the commit message; the diff in the commit message might get applied
     +along with the patch section, or the patch application machinery might
     +trip up because the patch target doesn't apply. This could for example
    -+be caused by a diff in a GitHub Markdown code block.
    ++be caused by a diff in a Markdown code block.
    ++
    ++The solution for this is to indent the diff or other text that could
    ++cause problems.
     +
     +This loss of fidelity might be simple to notice if you are applying
     +patches directly from a mailbox. However, changes originating from Git
    @@ Documentation/format-patch-caveats.adoc (new)
     
      ## Documentation/format-patch-end-of-commit-message.adoc (new) ##
     @@
    ++Any line that is of the form:
    ++
     +* three-dashes and end-of-line, or
     +* a line that begins with "diff -", or
     +* a line that begins with "Index: "
    ++
    ++is taken as the beginning of a patch, and the commit log message
    ++is terminated before the first occurrence of such a line.
     
      ## Documentation/git-am.adoc ##
     @@ Documentation/git-am.adoc: applying.
    @@ Documentation/git-am.adoc: applying.
      DISCUSSION
      ----------
      
    -@@ Documentation/git-am.adoc: line is automatically stripped.
    +@@ Documentation/git-am.adoc: where the patch begins.  Excess whitespace at the end of each
    + line is automatically stripped.
    + 
      The patch is expected to be inline, directly following the
    - message.  Any line that is of the form:
    +-message.  Any line that is of the form:
    ++message.
    ++include::format-patch-end-of-commit-message.adoc[]
      
     -* three-dashes and end-of-line, or
     -* a line that begins with "diff -", or
     -* a line that begins with "Index: "
    -+include::format-patch-end-of-commit-message.adoc[]
    - 
    - is taken as the beginning of a patch, and the commit log message
    - is terminated before the first occurrence of such a line.
    - 
    +-
    +-is taken as the beginning of a patch, and the commit log message
    +-is terminated before the first occurrence of such a line.
     +This means that the contents of the commit message can inadvertently
     +interrupt the processing (see the <<caveats,CAVEATS>> section below).
    -+
    + 
      When initially invoking `git am`, you give it the names of the mailboxes
      to process.  Upon seeing the first patch that does not apply, it
    - aborts in the middle.  You can recover from this in one of two ways:
     @@ Documentation/git-am.adoc: commits, like running 'git am' on the wrong branch or an error in the
      commits that is more easily fixed by changing the mailbox (e.g.
      errors in the "From:" lines).
    @@ Documentation/git-format-patch.adoc: if they are part of the requested range. A
      include enough information for the receiving end to reproduce the same
      merge commit.
      
    -+'''
    ++=== PATCH APPLICATION
     +
     +include::format-patch-caveats.adoc[]
     +

base-commit: 3e0db84c88c57e70ac8be8c196dfa92c5d656fbc
-- 
2.53.0.26.g2afa8602a26

