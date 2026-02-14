Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2313E18DB35
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 11:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771070226; cv=none; b=UGEat4Cv3XBsBMCdvg5DuioTLZNWaJDPNrDrfZEFCtxFlK+zroGTGzZCk5A1dtnWDMetUg8GKgsDyxBRJb9g8Wdg5pCGJjN+u0tXBVEcmUD8ldSK2J9UIBmcwUTOdMyEu+YP33gn4VdV2d4Om9yNUZdbcCaCHshiWqRCJqN3dBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771070226; c=relaxed/simple;
	bh=AbWanuhOvdlQUBBHThiApNY+jzDIT02hZMU+9wnGF90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c7yJP96kKntQNRYB7p+PJNhCw+E38MBQWXdv3QTNFRNpBujtHdOmzIJA6FmEHd9q4oVS/ZiixtyPqZ3YqkX9MO4Z7zY4h/9CqnGeOhhUUwY9eGCo+QZOFN8UvsuzPNDoa47hC1/UNfkYJYu/tJjhNExPqkDjF9CwlsWgGDqfwL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=gTzSlkI9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MTIpS1/u; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="gTzSlkI9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MTIpS1/u"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 4B9451D0006C;
	Sat, 14 Feb 2026 06:57:04 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sat, 14 Feb 2026 06:57:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771070224;
	 x=1771156624; bh=lGVaLedmPT7FRMN8vUV177quFsNhIJEWW/PRmbC79VM=; b=
	gTzSlkI9k5d/1YF2XXGjXeZdVxPHbxa7nc+wOT8Vo6CowKWe5UjNActRCYJ5mKsw
	X5Wo8/QtTaTfsRklPRKFd6rXQcVYZUyaKcoHP4TB+kL5YGzzAkKQxtlny7WyXpB+
	GTXa9XycvHnLVUDI0cs+xU+yyUumwbf2A4gADA7NJqGfkDr8lqL37EIo2Z3F8Jcq
	rWIn2vUK/0HQEtgFhRsUXgFMSJuiDNKesooTBwdclRKQSR19x52r9ZFyil7qmKzS
	iRM67oL9Bva7v2+bKR550lYYEVKoC5T2YLKXnibiZKBUkxqrqvlud1ljmJa+gy86
	efpigFGW07Zfv9oxVJIdIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771070224; x=
	1771156624; bh=lGVaLedmPT7FRMN8vUV177quFsNhIJEWW/PRmbC79VM=; b=M
	TIpS1/u6jhw5aYZXTAJEDPShta17XfOu08S36+Q5GdPEjpCmBHRTDGlT7oyVMasH
	u2qNYZxMp6UuTs/jI/hFYiQTvYiDnGxZso8pG2mWAkKEKg0Xqb3SJ+1SyjvLwk7k
	hbxSflK9EXHwYKvYqWCJmtlGzLotP6486JKH1E1xKslc1gB1zPXfA4Hex2U10/zL
	IbllDQTs88RdvBZargcKWUbial4P6cn1yOktm8WJ+D8O2ZdPKJfFPN5OzdKNASEK
	zW16LgUHVZJo+9OdTXt6OgcuC23ThkuT+0Lp5bG4x9MnM7w2BqGFdVXxkvvIobbm
	uecDid9Jze2a2/AcuQ9BQ==
X-ME-Sender: <xms:EGOQaRQmZYIUKj3r-QSN9LgRPkZD6NuRzasrkWq-JQRJCU88GokWwF8>
    <xme:EGOQaRzv5TqAoeDPPOXoh7QLtp2XaGjldtgASkJehHiiATc69H2BbAJ2aLIlqfvOJ
    eC1djYK0Rth03VAv3Zi7sbVIJGjX0jFE3iEqSLGBX8dbNuFbA>
X-ME-Received: <xmr:EGOQab0EdMw56yLlZGvJ7r4XuDF6jNH4IixfkgjtQikTSd5f54SGWvYEGDKOKvNTPYyq1m0rEKDFJ92MjZkQhw1pLfxD6V0XZEGELOc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvuddutdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlvdefmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmnecuggftrfgrthhtvghrnhepudelgfeuieeuteekleeifeegudefheetkefh
    jeffkedvueehtdevhfekieekhffgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishht
    ohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpth
    htohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrg
    hmvgdprhgtphhtthhopehtohhrvhgrlhgusheslhhinhhugidqfhhouhhnuggrthhiohhn
    rdhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:EGOQaX7gA2fCSMPD0Wgc3hRN31ckDYwrNoF9nDfeWpNZvHrpdmfBKw>
    <xmx:EGOQaWX_wD22IIxa6JwXevOcGtsEMiD0IkRCwJ_IiSSaNdlROfWDZA>
    <xmx:EGOQaeDJUwbwj-MQQdNhtX08YomHQQ-c-g9Cp_yqz8j1mwSTGtjufg>
    <xmx:EGOQad5Hd9uEkclfUOOdWp0_1uLNgQwiqpRazGlxMudylLgg-epXhw>
    <xmx:EGOQaWURCvaTlWUT5_3EfFAwGgFJG7y6AyeBX3mrYvU8B4blorM80c3G>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Feb 2026 06:57:02 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	ben.knoble@gmail.com
Subject: [PATCH v2 2/3] doc: patch-id: add script example
Date: Sat, 14 Feb 2026 12:55:42 +0100
Message-ID: <V2_mapper_example.373@msgid.xyz>
X-Mailer: git-send-email 2.53.0.26.g2afa8602a26
In-Reply-To: <V2_CV_doc_patch-id_4.371@msgid.xyz>
References: <CV_doc_patch-id_4.275@msgid.xyz> <V2_CV_doc_patch-id_4.371@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The utility and usability of git-patch-id(1) was discussed
relatively recently:[1]

    Using "git patch-id" is definitely in the "write a script for it"
    category. I don't think I've ever used it as-is from the command
    line as part of a one-liner. It's very much a command that is
    designed purely for scripting, the interface is just odd and baroque
    and doesn't really make sense for one-liners.

    The typical use of patch-id is to generate two *lists* of patch-ids,
    then sort them and use the patch-id as a key to find commits that
    look the same.

The command doc *could* use an example, and since it is a mapper command
it makes sense for that example to be a little script.

Mapping the commits of some branch to an upstream ref allows us to
demonstrate generating two lists, sorting them, joining them, and
finally discarding the patch ID lookup column with cut(1).

† 1: https://lore.kernel.org/workflows/CAHk-=wiN+8EUoik4UeAJ-HPSU7hczQP+8+_uP3vtAy_=YfJ9PQ@mail.gmail.com/

Inspired-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • Delete temporary files
    • Use my weird daggers consistently for footnotes
    v1:
    The script will not list the commits in rev-list order because of
    the sorting.

 Documentation/git-patch-id.adoc | 40 +++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/git-patch-id.adoc b/Documentation/git-patch-id.adoc
index e95391cd255..1618994e76c 100644
--- a/Documentation/git-patch-id.adoc
+++ b/Documentation/git-patch-id.adoc
@@ -68,6 +68,46 @@ This is the default if `patchid.stable` is set to `true`.
 +
 This is the default.
 
+EXAMPLES
+--------
+
+linkgit:git-cherry[1] shows what commits from a branch have patch ID
+equivalent commits in some upstream branch. But it only tells you
+whether such a commit exists or not. What if you wanted to know the
+relevant commits in the upstream? We can use this command to make a
+mapping between your branch and the upstream branch:
+
+----
+#!/bin/sh
+
+upstream="$1"
+branch="$2"
+test -z "$branch" && branch=HEAD
+limit="$3"
+if test -n "$limit"
+then
+    tail_opts="$limit".."$upstream"
+else
+    since=$(git log --format=%aI "$upstream".."$branch" | tail -1)
+    tail_opts=--since="$since"' '"$upstream"
+fi
+for_branch=$(mktemp)
+for_upstream=$(mktemp)
+
+git rev-list --no-merges "$upstream".."$branch" |
+    git diff-tree --patch --stdin |
+    git patch-id  --stable | sort >"$for_branch"
+git rev-list --no-merges $tail_opts |
+    git diff-tree --patch --stdin |
+    git patch-id  --stable | sort >"$for_upstream"
+join -a1 "$for_branch" "$for_upstream" | cut -d' ' -f2,3
+rm "$for_branch"
+rm "$for_upstream"
+----
+
+Now the first column shows the commit from your branch and the second
+column shows the patch ID equivalent commit, if it exists.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
2.53.0.26.g2afa8602a26

