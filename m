Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE3679DA
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 07:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765178852; cv=none; b=kR9vvYVcjCWvlSmcof8VYy55eRi8CDJlmxZAJfzDPvaSGvOoBMsLEwmuGOLldej+TQJyzYp6FjAcH9Hst9cJN0WCReckQNdxUb6wSWYyv2IyOvNSMfnHtrVpKO/yL14wQqaG9MJrOfmJCAbOihkyaKl16jVCOzYD8cdNAM6oRTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765178852; c=relaxed/simple;
	bh=itfjVYjGz12iFvIIyT9a4A8TqeoFheQyoCINGQuA9oM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WnJPwNHbkpZv+dyyV3xm9tflx38ijwnjK04CHbojNFRtklv1H+FkOlf9zCZU/w7LtqoJqYdhKXhgSZwHZPmNzkimNLsB0qjQS7uCYOWmOlerRi3E/J1k+ool9GcaFwUsMRXzrv/HZ3iYIuK8OyMTKuRn1DQyri7hM+uuNzFiUhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Q5Rm/oya; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EpdR0YWF; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Q5Rm/oya";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EpdR0YWF"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 6B4D1EC01F7;
	Mon,  8 Dec 2025 02:27:29 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 08 Dec 2025 02:27:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1765178849; x=1765265249; bh=rn
	7BXIlO/DxqPkBsb24uc9qDrhEPXVBvokcIUEzTujQ=; b=Q5Rm/oyabgW4Pd3j9e
	K/e/ZlFkqj9/+d2Q5IRsURnD271a/AUpJ2VLtGGCgfkCIXh3kam8pPGrHETrCOTD
	irbZVPBWfVyUvk17W8hvkYfeEAnH3ondUTVNezVQr1Elf2N23FOTUzSFapAWnh69
	a1WW65q1woKtUxV6JzEjJ+F3ps/6h0W9LqeWAaLx1pJVfzLsu4S1AGPyxwjgivVA
	w+h2JNQyLMtZJ2DeCRvVHS2mwQGHBZVI8x6ko04T17O3cILT5V9fBREdYv+Up0j8
	md+ZXuIPjnFYOkzclsXLMgEC35UI/Oen7jbT6r45KAgpCFwSzrO3Kt5oG8iyIfKq
	VI9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1765178849; x=1765265249; bh=rn7BXIlO/DxqPkBsb24uc9qDrhEP
	XVBvokcIUEzTujQ=; b=EpdR0YWFmH/50/R+gCs+4JIFCjrPyHvQsWLR+2e7kCAe
	pLeU7m5A083z7V4+tKUkmbtoYSaCdmA5u+JcZkAylWqYQ0fKHiOO1vYZ8gTT8CYr
	/1zzO/95ar4tR460EeOZ4rkmyQBzFvM68aD/r19zEYuObJuVyjELyYTPp18caJli
	M/2wyw3uT7+qAan/rSAeAz2c7Xeq7pACvi8ZOtrL68oUu7af1LN7R4PCyiJlDajq
	pelYHBEnossT4rSyWAeCfBR+qwBGXVhFk0urBdsJRnhYFo9wcIN9+HiyVYnzviIS
	4XQwEHZ9MBBREa+v0rB4zdylQA+dLnq9wfOibWrijA==
X-ME-Sender: <xms:4X02aZ9ot8ZLedVACHtBJNIlGgA-n2oTnBqb1hiT1OZqEHspMA3puto>
    <xme:4X02aTsFPpFHBnXlB9IFlm0-VjOwCqt5UOMiJIWcBkTCVeddUqIQeTQIjH4Wj0qRJ
    J4FeEBoAKWAkzPoca0H-1NScHBGs4vmIeMqCZoTnRIUu7MIHsSktQ>
X-ME-Received: <xmr:4X02aUoyyMB6R9uppz2tVrzcVmU5UX-7qR-G0tO5nGI2LPuH_qN33LgI_t8bXM3xCyfddwHh49o85ln5rxi7l8pCuvaC43yn-qPpjMpWkUqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduiedtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephffvvefuff
    fkofggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhs
    sggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpeetgfekjeffud
    effeffgeekvefgvedvgeffueejjeelgeduhfdtffeikeelfefhgfenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrg
    hughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:4X02aYkufqL6ZvafOshc5NA7OOUzy1AwvAqR37dw71ypWr1oNCcRpg>
    <xmx:4X02aQxkmyuSUvlWUdA84xjhQ2Oo-S0ByGVimHNObvOy8FsGNVw_MA>
    <xmx:4X02aYlMtG2LXlgGrVBg_gmAKZK9JiLxOqWCMul9UlJFZGGUGiK0Qg>
    <xmx:4X02aRdfaOocaSWqND_hylu7o6YDvILvrj_N5nOwItqFyEtGyZ6cig>
    <xmx:4X02aVUyIG4n66X8ioOLbvNGgx03iPCKOwWNuPxWSsPepsH_EwYFv6e3>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Dec 2025 02:27:27 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH] doc: join default pre-commit paragraphs
Date: Mon,  8 Dec 2025 08:27:11 +0100
Message-ID: <pre-commit_when_enabled.10a@msgid.xyz>
X-Mailer: git-send-email 2.52.0.10.g08704017180
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Join two paragraphs that start with the standard “The default <hook>,
when enabled” into one and put it at the end of the “pre-commit”
section.

The trailing whitespace paragraph was added in the first commit for the
doc, in 6d35cc76 (Document hooks., 2005-09-02). Then 3e14dd2c (mention
use of "hooks.allownonascii" in "man githooks", 2019-02-20) updated the
“pre-commit” section to mention the non-ASCII check that was added in
d00e364d.[1] But this paragraph was added one-past the original
“default” paragraph, after the env. variable paragraph, and starts
exactly the same. That causes the flow of this section to feel
off (paragraphs in order):

1. Invoked by <cmd> and what parameters it takes
2. The default 'pre-commit' hook catches introduction of trailing
   whitespace
3. `GIT_EDITOR=:`
4. The default pre-commit' hook catches introduction of non-ASCII
   filenames

Let’s instead join these two paragrahs and explain the whole behavior of
the default script.

† 1: Extend sample pre-commit hook to check for non ascii filenames,
     2009-05-19

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/githooks.adoc | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
index 0397dec64d7..056553788d4 100644
--- a/Documentation/githooks.adoc
+++ b/Documentation/githooks.adoc
@@ -103,17 +103,14 @@ invoked before obtaining the proposed commit log message and
 making a commit.  Exiting with a non-zero status from this script
 causes the `git commit` command to abort before creating a commit.
 
-The default 'pre-commit' hook, when enabled, catches introduction
-of lines with trailing whitespaces and aborts the commit when
-such a line is found.
-
 All the `git commit` hooks are invoked with the environment
 variable `GIT_EDITOR=:` if the command will not bring up an editor
 to modify the commit message.
 
-The default 'pre-commit' hook, when enabled--and with the
-`hooks.allownonascii` config option unset or set to false--prevents
-the use of non-ASCII filenames.
+The default 'pre-commit' hook, when enabled, prevents the introduction
+of non-ASCII filenames and lines with trailing whitespace. The non-ASCII
+check can be turned off by setting the `hooks.allownonascii` config
+option to `true`.
 
 pre-merge-commit
 ~~~~~~~~~~~~~~~~

base-commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
-- 
2.52.0.10.g08704017180

