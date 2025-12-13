Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D4F2AEF5
	for <git@vger.kernel.org>; Sat, 13 Dec 2025 13:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765633633; cv=none; b=cwrJgMSqRcKcQcCHPQ7V4TNJiyvRsbN9up5c6l+n4rhEr03juHlklvP2yPtv5rkR4FUdBTs9rx5tNeRdvbIG35iMvGLtyoMBW8KY8xWP9n4KoADNcucftR7gdiyhMhTMvi7OeMv7jQqGKi5d0hPuHjYdvcnhsMuc4z8Q48abYts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765633633; c=relaxed/simple;
	bh=0wCv/ALoyOSVg/4SmWE19/okUAReUeAo/xyujB3VpkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EfZKCglagYMefqKe7jFz45bWRiKtdw4WI9a977kI8K5cqZPIsTek9pIGJ0huUMkdpL7mrGA9s1Dl7jkHGPx4DASwXOYPfJWFau018svEpBaFuCrI00LAJIitjDEeSwm2rwuPJTZt4xIh3YdrhP1n5FYmU9jWVgQNyO+W/EfYH2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=kFd+0Asg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=olk1U4Rw; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="kFd+0Asg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="olk1U4Rw"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 809F97A003A;
	Sat, 13 Dec 2025 08:47:09 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 13 Dec 2025 08:47:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765633629;
	 x=1765720029; bh=Qsahztkf2bi5jWVcZglSv230CCRkGrLM+THXi6jjZfw=; b=
	kFd+0AsgQmkTgwsAY5rYV/6pVpu9uHECr39aIiTaJQltxfHpUqAbqdwMXrvRwSxq
	hscDyD4Hsp+Phr99YaL7ZNlTryeMDAszEbEiaPvDeVf9iMsqgFUmVq1Nn6cXaEAk
	3KZNjLEzT2JdpVUVKQNfBpgmebFXlBO+IPFbmGFbEmahBTFokfU23cuAChw6UzS+
	ohzqpjjMLnmUmgGPpHxM1XB1gWYJ38sTo8mdtYiCH8twDe//6iZ4tU9cVYcdhXW2
	eYrWcZr6GPaXhlxZ7TImZNxrBN2dZ1hBqXzOfViYjidnzXl2NQPOB/7rJy9ha0oa
	0ocd6SelyMHfsF+yNl0qLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765633629; x=
	1765720029; bh=Qsahztkf2bi5jWVcZglSv230CCRkGrLM+THXi6jjZfw=; b=o
	lk1U4RwAlJuBxoPbO4SQDxXYMRVpK0r4eT79XTp58+mVIeGNV/kaObGba9TrSRHe
	MULV1EVtzP7ayMdd8tkcbRGtfSYhl0FzxOwj6CcN7E4oYZrG6QIYUt2Z0L8J3IM8
	5AulSAQtaf1FjBuIQ8Q91l3q48bj4TZFcel4C+SmAy2tK79x17YWjxkN8qU2Njsd
	Pys2DxP7Gw4KESyC6pN6cHX8C5ycenfQQ8b2dr561iEjZNpwu0Z1O80CSISIP9DY
	EUSYqDCCX6SEZQWVmOf3J6vFvHYnQ83K74zSzNSKHeIpJb6j61YhHeTYx+D66NTO
	NXbDjwgYCkW0rHSB4ZEYw==
X-ME-Sender: <xms:XG49aZ9XZDpHVdVCekoSrQo0NvpCuv1Pu-_U-MMmQeLlUTK3kMfCLZc>
    <xme:XG49aeaWtTpKboyULHqYbY70WeL3Uw0i2y97oZsnheaImHJpX8Z0V4Pxr9FPwNbYz
    odwYI39chbXwHRKBQ1jPzA6TpDRC7mdsTZrxrpBHCATxXbGm2t3Ww>
X-ME-Received: <xmr:XG49aVO4oPz-p5C3osbpWCkQtd7PTVqvVSzBoZAv8ANUU5hurdBNy4j5hdX32qCvcXz4HdTWz5gVVSuJvTP2fIyzA5YjZRG0QHXeGb4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
    cuvffnffculdefhedmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdej
    necuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhenucggtffrrghtthgvrhhnpefhgfeglefhjeekgfetleetjefhteeiheegfedt
    udduffegjefhkeetudeggffhkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegtohguvges
    khhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdr
    ohhrghdruhhkpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepshhiugguhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:XW49aSBt2i4ErhCmorKZFCMxp_xJ-CO9hZhk4Luu01_QS3ID_f0rjQ>
    <xmx:XW49aUKSZf4tU3sqlKzECH692-5EpmpPZuWnTjx2Tl8CIHEVPnGisA>
    <xmx:XW49aTON5zGuAWrKJ_1rDbSlM2_aTUJP9JQfvHpQxdsNSXpQ52JPhA>
    <xmx:XW49aa6uA0EAe7Fcyjtrg9H28ZZl5Tqpe8_8e_BMpECFaDWk5tjQjA>
    <xmx:XW49aUol6H0UfzT_L6loav3lIhF0GJvhYgX4J-VfqS06sWQPa9Gniyav>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Dec 2025 08:47:06 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	christian.couder@gmail.com,
	newren@gmail.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v2 0/3] doc: replay: improvements like "mention no output on conflicts"
Date: Sat, 13 Dec 2025 14:46:55 +0100
Message-ID: <V2_CV_replay_conflict.12f@msgid.xyz>
X-Mailer: git-send-email 2.52.0.10.g08704017180
In-Reply-To: <CV_replay_conflict.101@msgid.xyz>
References: <CV_replay_conflict.101@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Explicitly say that conflicts do not give any output. I found this a bit
confusing with the current doc since I am used to other commands
complaining loudly.

§ Changes in v2

Patch 2/3: improve `--contained` and mention that it requires `--onto`.

Kristoffer Haugsbakk (3):
  doc: replay: mention no output on conflicts
  replay: improve --contained and add to doc
  doc: replay: link section using markup

 Documentation/git-replay.adoc | 11 ++++++++++-
 builtin/replay.c              |  2 +-
 2 files changed, 11 insertions(+), 2 deletions(-)

Interdiff against v1:
diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index 04944a5fa23..22fd1b271af 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -43,7 +43,8 @@ point at the tip of the resulting history. This is different from `--onto`,
 which uses the target only as a starting point without updating it.
 
 --contained::
-	Advance all branches contained in <revision-range>.
+	Update all branches that point at commits in
+	<revision-range>. Requires `--onto`.
 
 --ref-action[=<mode>]::
 	Control how references are updated. The mode can be:
diff --git a/builtin/replay.c b/builtin/replay.c
index 6606a2c94bc..9e5ad64cad6 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -377,7 +377,7 @@ int cmd_replay(int argc,
 			   N_("revision"),
 			   N_("replay onto given commit")),
 		OPT_BOOL(0, "contained", &contained,
-			 N_("advance all branches contained in revision-range")),
+			 N_("update all branches that point at commits in <revision-range>")),
 		OPT_STRING(0, "ref-action", &ref_action,
 			   N_("mode"),
 			   N_("control ref update behavior (update|print)")),
Range-diff against v1:
1:  b9ec24c8b8f = 1:  b9ec24c8b8f doc: replay: mention no output on conflicts
2:  02a80ee87b5 ! 2:  27bf2ac7a0b doc: replay: document --contained
    @@ Metadata
     Author: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Commit message ##
    -    doc: replay: document --contained
    +    replay: improve --contained and add to doc
     
    -    Copy the text from `replay_options` in `builtin/replay.c`.
    +    There is no documentation for `--contained`.
     
    +    Start by copying the text from `replay_options` in `builtin/
    +    replay.c`. But some people think that the existing text is a
    +    bit unclear; what does it mean for a branch to be contained
    +    in a revision range? Let’s include the implied commits here:
    +    the branches that point at commits in the range.
    +
    +    Also use “update” instead of “advance”. “Update” is the verb
    +    commonly used in this context.
    +
    +    Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
    +
    + ## Notes (series) ##
    +    v2:
    +
    +    Don’t just copy `--contained` over. Improve it on both sites after discussing
    +    with reviewers.
    +
    +    Also mention that `--onto` is required.
    +
      ## Documentation/git-replay.adoc ##
     @@ Documentation/git-replay.adoc: The history is replayed on top of the <branch> and <branch> is updated to
      point at the tip of the resulting history. This is different from `--onto`,
      which uses the target only as a starting point without updating it.
      
     +--contained::
    -+	Advance all branches contained in <revision-range>.
    ++	Update all branches that point at commits in
    ++	<revision-range>. Requires `--onto`.
     +
      --ref-action[=<mode>]::
      	Control how references are updated. The mode can be:
      +
    +
    + ## builtin/replay.c ##
    +@@ builtin/replay.c: int cmd_replay(int argc,
    + 			   N_("revision"),
    + 			   N_("replay onto given commit")),
    + 		OPT_BOOL(0, "contained", &contained,
    +-			 N_("advance all branches contained in revision-range")),
    ++			 N_("update all branches that point at commits in <revision-range>")),
    + 		OPT_STRING(0, "ref-action", &ref_action,
    + 			   N_("mode"),
    + 			   N_("control ref update behavior (update|print)")),
3:  ca83b00343d = 3:  4e851fdff34 doc: replay: link section using markup

base-commit: bdc5341ff65278a3cc80b2e8a02a2f02aa1fac06
-- 
2.52.0.10.g08704017180

