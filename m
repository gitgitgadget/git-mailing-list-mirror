Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B472611E
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 00:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770509510; cv=none; b=hH0wbn55MeL7JqTETpR6oKjqEIGzg3HiRNHAFjNgeanpzGGS4mNtctgmys/UDrVg9NpK2kIa6xIEb3kHgTX5wyM/5L8DMoZ7WCGkb5t7B4YPT+ZNfRisqG6ljRe2z9oB1BRlMWCPLehD+aNC0wBNEz3Lrlc1wnRNSlU2xlzkBkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770509510; c=relaxed/simple;
	bh=WcZezmDi0Y99YltKcGe7p8//gIvbp4JQP8LYsufoj9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hbUduCY2oXVvVOR3oznHrFZ6hJZVVcYDyzclgK3NRkZRfRpz+P8mAS9d6Rib5Ei5J4XYBOXQVMob+seBRIKKXyEnV91JbTRDqJnCF0EUTq62HwIOt3AWJPlF6ixj0igPzmF5hgUP2JiBHqP596AugztQrAgDAXOigisHfD2oyNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=BQ2m3xk0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M1Sfvleb; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="BQ2m3xk0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M1Sfvleb"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 27F151D00045;
	Sat,  7 Feb 2026 19:11:49 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sat, 07 Feb 2026 19:11:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770509508;
	 x=1770595908; bh=YjKBGOpkU459K5U7gN51jU6FnyCa9jQFeB8eWK7ygeA=; b=
	BQ2m3xk0MaRWKupGVhCtTQytZo64jEA6iI9BXNLqTZ3Wsm4SEwVvYCx3Wn9VM6SC
	ZDPej81NHoQp7VeqnATSt4nbGaNmdDo0F+V85DQno/xwXBTqDADbf5Orjad1kOPF
	sJ+0KpxgB9yw+WPhnFdHFirqf2DtMGtefmBlo25y8EufuxqB9JNxAziIlh50MpFn
	vZIXubOzFGVZKqjOmCxGrDmnJTBcuSuJevyMkTuQTi9nhAKrI+FCxfiH+mLSEw7T
	iN8LvBi47oPrQTSn92VMU0SMzp9+Arxa2xtJ8g/l1X4hnQaZFrXcSboAa5+b2yZ1
	JX7MqtlHRpiVPR/5hlZ6OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770509508; x=
	1770595908; bh=YjKBGOpkU459K5U7gN51jU6FnyCa9jQFeB8eWK7ygeA=; b=M
	1SfvlebaEuSNvrIbgNoR7JRimyu/s6SiYJa7TIg8/ZwrgsPIRLK8DhOneCwCQ7yn
	8JTeGQ7DZS7mjEOwTLLp9X7hV9bIi9fYOo9GWU/g/0fiFqh2y7cDJadN9Wx6d2ie
	LhIUS0Wgv6fvpMIw10WwXwZZYwQRe1Ti3NzriyIqRKqJWKo7Qon0P6Fc1PLaqz0O
	gc7Tvxq4si6o4ZwfOtdyaqSe83XmJ/0HLOBV9gMRfmWGOKLJwSLIyCrHTD0kn5Rd
	7t+8ffwZ5SO4yfGa0+nh1f5xroilkaMZG5hG6fSP/HNfJYILGtuuqtF4QoYBSxQa
	qPTCCvQc5LV6IuLKEUHkA==
X-ME-Sender: <xms:xNSHaV3A3GOJPCVP3m84kHC7JDuyAwxbbFGlhvij5Nkgdz1bPzI6Wgw>
    <xme:xNSHaeV5W9SN3XpmUNd1p0VLPf2lVtCnsAVJhEu7IX0pTOrV1GGFhH8xN4UFaG0ST
    c0MniC9IxqQlWKZ78zqaMidZTyDBnnvZBUdE0OPZ5cXB_8Duur1LA>
X-ME-Received: <xmr:xNSHaYKA1nryPsXqJku0hFBHOPSnj5ItL6aQ3EeKiMMr3I-mAPAM5iFziEvRrAv-rzx28sgXrTFGMKj2Yyy3d74gtIBy9pG80sBTXL5O1faSnOBm7VShtHBgpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduledvgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdludejmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmnecuggftrfgrthhtvghrnhepieeuuedvieffvdelffegtdfgvddvieehhfet
    fedufedvuefhffetjeejtdfhvdejnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhh
    gruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepmhgrihhlsegsvgihvghrmhgrthht
    hhhirghsrdguvgdprhgtphhtthhopegtrghlvghsthihohesshgtihgvnhhtihgrrdhorh
    hgpdhrtghpthhtohepmhgrthhhvghushdrthgrvhgssehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepjhhuughgvgdrphgrtghkhhgrmhesghhmrghilhdrtghomhdprhgtphhtthhope
    hsuhhrhehrsehsuhhrhehrrdhnvght
X-ME-Proxy: <xmx:xNSHaY3xUMc8zVD6EA48d3XvhLrmUUx0iVZlYGVCfOlRSEp0Wz4S9Q>
    <xmx:xNSHaW5bLNLBcwFRIsWEb0daL7u9W9dohiplq-Ffm67rhkY2qA3s5Q>
    <xmx:xNSHaZ8hvVaJJbCwhB7tutiensy9-oS1C2zW15_91gmkYgTT9j14pQ>
    <xmx:xNSHaVWGKi_dWPKUhc1-8w_gmWQN-oEVw_YYCa6tsVqGex-pbaqDYQ>
    <xmx:xNSHaZpvKLDG7Senan1aU_OtpmuE50UJ47oeYUPKaDVu67Q9AhN0Ju-2>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Feb 2026 19:11:46 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Matthias Beyer <mail@beyermatthias.de>,
	Christoph Anton Mitterer <calestyo@scientia.org>,
	Matheus Tavares <matheus.tavb@gmail.com>,
	Chris Packham <judge.packham@gmail.com>,
	Jakob Haufe <sur5r@sur5r.net>
Subject: [PATCH] doc: add caveat about roundtripping format-patch
Date: Sun,  8 Feb 2026 01:11:17 +0100
Message-ID: <format-patch_caveats.281@msgid.xyz>
X-Mailer: git-send-email 2.53.0.26.g2afa8602a26
In-Reply-To: <bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7qk7dldf@fij5calmscvm>
References: <bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7qk7dldf@fij5calmscvm>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

git-format-patch(1), git-send-email(1), and git-am(1) deal with
formatting commits as patches, sending them (perhaps directly), and
applying them, respectively. Naturally they use a few delimiters to mark
where the commit message ends. This can lead to surprising behavior when
these delimiters are used in the commit message itself.

git-format-patch(1) and git-send-email(1) will accept any commit message
and not warn or error about these delimiters being used.[1]

Moreover, the presence of unindented diffs in the commit message will
cause git-am(1) to apply both the diffs from the commit message as well
as the patch section.[2]

It is unclear whether any commands in this chain will learn to warn
about this. One concern could be that users have learned to rely on
the three-dash line rule to conveniently add extra-commit message
information in the commit message, knowing that git-am(1) will
ignore it.[4]

All of this is covered already, technically, However, we should spell
out the implications.

† 1: There is also git-commit(1) to consider. However, making that
     command warn or error out over such delimiters would be disruptive
     to all Git users who never use email in their workflow.
[2]: Recently patch(1) caused this issue for a project, but it was noted
     that git-am(1) has the same behavior[3]
[3]: https://github.com/i3/i3/pull/6564#issuecomment-3858381425
[4]: https://lore.kernel.org/git/xmqqldh4b5y2.fsf@gitster.g/

Reported-by: Matthias Beyer <mail@beyermatthias.de>
Reported-by: Christoph Anton Mitterer <calestyo@scientia.org>
Reported-by: Matheus Tavares <matheus.tavb@gmail.com>
Reported-by: Chris Packham <judge.packham@gmail.com>
Helped-by: Jakob Haufe <sur5r@sur5r.net>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    There might be other things to do here. Mention it in gitfaq(5)?
    
    § Trailers
    
    • Reported-by: Matthias Beyer <mail@beyermatthias.de>
      • From this thread
    Reported-by: Christoph Anton Mitterer <calestyo@scientia.org>
      • From https://lore.kernel.org/git/ca13705ae4817ffba16f97530637411b59c9eb19.camel@scientia.org/T/#u
    Reported-by: Matheus Tavares <matheus.bernardino@usp.br>
      • From https://lore.kernel.org/git/d0b577825124ac684ab304d3a1395f3d2d0708e8.1662333027.git.matheus.bernardino@usp.br/#t
    Reported-by: Chris Packham <judge.packham@gmail.com>
      • From https://lore.kernel.org/git/CAFOYHZC6Qd9wkoWPcTJDxAs9u=FGpHQTkjE-guhwkya0DRVA6g@mail.gmail.com/
    
    (These were all linked in https://lore.kernel.org/git/20260206090358.GA2761602@coredump.intra.peff.net/ )
    
    Helped-by: Jakob Haufe <sur5r@sur5r.net>
      • For the part about patch(1): https://lore.kernel.org/git/f6e4cdb4-ff82-4853-aca5-0c152f287286@app.fastmail.com/T/#mc389dbd2ae02a007cbe57cd16ca4790ecc5a84f7

 Documentation/format-patch-caveats.adoc | 39 +++++++++++++++++++++++++
 Documentation/git-am.adoc               |  9 ++++++
 Documentation/git-format-patch.adoc     |  4 +++
 Documentation/git-send-email.adoc       |  5 ++++
 4 files changed, 57 insertions(+)
 create mode 100644 Documentation/format-patch-caveats.adoc

diff --git a/Documentation/format-patch-caveats.adoc b/Documentation/format-patch-caveats.adoc
new file mode 100644
index 00000000000..2accf2763fd
--- /dev/null
+++ b/Documentation/format-patch-caveats.adoc
@@ -0,0 +1,39 @@
+Patches produced by linkgit:git-format-patch[1] or
+linkgit:git-send-email[1] are inline. This means that the output of
+these two commands can lead to a different commit message when applied
+with linkgit:git-am[1]. It can also mean that the patch is not applied
+correctly.
+
+The commit message might contain a three-dash line (`---`) which was
+perhaps meant to be a thematic break. That means that the commit message
+will be cut short. The presence of a line starting with "Index: " can
+cause the patch not to be found, giving an error about an empty patch.
+
+Furthermore, the presence of an unindented diff in the commit message
+will not only cut the message short but cause that very diff to be
+applied, along with the patch in the patch section. The commit message
+might for example have a diff in a GitHub MarkDown code fence:
+
+----
+```
+diff ...
+```
+----
+
+The solution for this is to indent the diff instead:
+
+----
+    diff ...
+----
+
+This loss of fidelity might be simple to notice if you are applying
+patches directly from a mailbox. However, a commit authored long ago
+might be applied in a different context, perhaps because many changes
+are being integrated via patch files and the
+linkgit:git-format-patch[1] format is trusted to import changes of a
+Git origin.
+
+One might want to use a general-purpose utility like patch(1) instead,
+given these limitations. However, patch(1) will not only look for
+unindented diffs (like linkgit:git-am[1]) but will try to apply indented
+diffs as well.
diff --git a/Documentation/git-am.adoc b/Documentation/git-am.adoc
index 0c94776e296..18f5b950825 100644
--- a/Documentation/git-am.adoc
+++ b/Documentation/git-am.adoc
@@ -259,10 +259,13 @@ message.  Any line that is of the form:
 * a line that begins with "Index: "
 
 is taken as the beginning of a patch, and the commit log message
 is terminated before the first occurrence of such a line.
 
+This means that the content of the commit message can inadverently
+interrupt the processing (see the <<caveats,CAVEATS>> section below).
+
 When initially invoking `git am`, you give it the names of the mailboxes
 to process.  Upon seeing the first patch that does not apply, it
 aborts in the middle.  You can recover from this in one of two ways:
 
 . skip the current patch by re-running the command with the `--skip`
@@ -281,10 +284,16 @@ Before any patches are applied, ORIG_HEAD is set to the tip of the
 current branch.  This is useful if you have problems with multiple
 commits, like running 'git am' on the wrong branch or an error in the
 commits that is more easily fixed by changing the mailbox (e.g.
 errors in the "From:" lines).
 
+[[caveats]]
+CAVEATS
+-------
+
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

base-commit: 3e0db84c88c57e70ac8be8c196dfa92c5d656fbc
-- 
2.53.0.26.g2afa8602a26

