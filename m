Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A9520898D
	for <git@vger.kernel.org>; Tue, 29 Oct 2024 20:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234520; cv=none; b=bK0+MCX3nhmGRSP8xhlljXrelgeMdYqNx6iFxS5OskAhL+iO+/xV0OfQeRjFXl9TbmoUEVWIDSsZNrWmZke26NwephY8a1abyBQIdmhxFh6UfpoS0EaFVWXvPJKdIqNKPOgsD76wCTU1yqjoFecWCUqhzVSa8uVuL4bJYRqCrrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234520; c=relaxed/simple;
	bh=A2osqUr0Q82gKuoMAvgU2q+hln8ffEVgVSHpItg2qaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S6dV7fdrsDhXd98mKqHj35Xf1BdwjOjy4OA3KaNcWLHauCbxdko3+b55eq4r8sFAocJ0mm8nL2jE5wLz/6fmP5SWQg1mJ+nwKkweYQGeqAA/+lmB7srmegh8WV5lTJVtZ84w9KfQN83WYP1oeCI5x+CG6TIDSU9Jqt02G3nPOJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=agBr8zjm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HGuNJRWt; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="agBr8zjm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HGuNJRWt"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 50BE81140106;
	Tue, 29 Oct 2024 16:41:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 29 Oct 2024 16:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730234517;
	 x=1730320917; bh=ok82hs0GYpVdQZvH04p7+sCnxRd9ReVNKhoMXMpywgs=; b=
	agBr8zjmdL8yCTx34utWWZR4DG+s+YJvsnNMBom96kbqWH60lZp6pjCoW98/RMh6
	/YAXm+Jixepw5DgoIaK/WKPBvDTfsGA+J3fvu9D9TxFCmRmSaW4ugk26fv9UEjUc
	L4Kh3XLqK64ubvOIjLXGRS54HqA74czW2Z1HKuEvPKKfvB+UePA5Ng8GqJQRZhb7
	4oIcFS1uvsOEv5SyVgp2esgQKsrRKUNDNBcCRb0Z46gbo9zQmUE1u4MW97h9AVxE
	7m4D1J7SO6cI/rCwaHMpE0eCyKGejV+8iCKz7MZ9P8Wx/mmCozWEfgOt4AOkjLdG
	n5+G9iY+uV3YZWthRLjzZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730234517; x=
	1730320917; bh=ok82hs0GYpVdQZvH04p7+sCnxRd9ReVNKhoMXMpywgs=; b=H
	GuNJRWt4eO0ewMaRzIEGxEbkd6BQrce4d1u2qFsON3aBQyxAWMyspa7Qg7QFxzZT
	Q3796iAxd0EaZUtDFLzY4jmm+Zoob3e7U4X8ulV0UQXTjRd+PIIrgTbEIzK1JXNA
	gZGbGcjHKnyYjXy3EWDwXmdrsoZxqZDGczRqOSeum89BFXpZaJCQS/s0VphJyCxn
	C05q0Mv5wn7jP4hvHCQ0Vt9BPjyDnzRTc+Xws55NmMA0E5b0eVnZLfVIYU72YpyQ
	xO8uBW6gh3SyeO5U/AFpkprlEKJ3Iidovmf0CtY40cl8P8eDSTToBqJZYOQ6BPHX
	xtjo1mlNcse3jS/Y4uEjQ==
X-ME-Sender: <xms:lUghZ_zIwUJ4FJv-tSuN3ABPDHJdDRe6S4GB983NeWqEEahYDqdW4ag>
    <xme:lUghZ3QXW58oolLdrA3tsfU2nQuWTZEzJX1Dd3U1tlhdBtLT_p6x18ADI1l9_vAYc
    a9lTpF_4he97uUilw>
X-ME-Received: <xmr:lUghZ5WMK98AJjhNsnsA-npDUQ-QouBH5jlQ0HJUX6tbE8YxYC30OaT-n0-Ng4HuaVOXpRAS1K6fxkMmJQhRNz1_Z82_bfvubh0GFE2aTs3DzqY-EgsUahgfXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekuddgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhh
    rghughhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpedtff
    dthfelieevgfethfdvffetffejfeejteetjeelveetgedtffdtgfehuddvffenucffohhm
    rghinhepshhtrggtkhhovhgvrhhflhhofidrtghomhdpkhgvrhhnvghlrdhorhhgpdgtrg
    hnrghlshhoohhpvghrrghtvghonhgsuhhnughlvghfihhlvghsrdhithenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgt
    phhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrg
    ihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:lUghZ5glGDo3FLuUyYny48EufgNM1-EOFfC_Mm7Rq__KEp0V8pCz9Q>
    <xmx:lUghZxBWciI8uIGWr2hiVUVATn6zIEoJjk4Jc63G81YYymWWqoZDXg>
    <xmx:lUghZyKhpxt3WFgbazN0xK4xEQ1vzdkchwjSU0EzHURA5WwY6ijnKg>
    <xmx:lUghZwC5GdsHMQBeVfyUL-Jx9dupKug5yGAYRFHqGu5MgpOKeYRHXw>
    <xmx:lUghZ89nKUp-3qjn9GMTHrirJ5FC-QKA7h4eNzm4KK_JyeTzNBE6_pYe>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Oct 2024 16:41:55 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	avarab@gmail.com,
	me@ttaylorr.com
Subject: [PATCH v2 1/3] Documentation/git-bundle.txt: mention full backup example
Date: Tue, 29 Oct 2024 21:41:44 +0100
Message-ID: <e9be866f33daab2d4038f8b3f1140fe41e5f49c5.1730234365.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <cover.1730234365.git.code@khaugsbakk.name>
References: <cover.1729451376.git.code@khaugsbakk.name> <cover.1730234365.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: e9be866f33daab2d4038f8b3f1140fe41e5f49c5
X-Previous-Commits: f7d9aa89c953ca7d15b5047487b4347ef62e77a9
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Tell the user how to make a full backup of the repository right at the
start of the doc.

This is a requested use-case.[1]  But the doc is a bit unassuming
about it:

  “ If you want to match `git clone --mirror`, which would include your
    refs such as `refs/remotes/*`, use `--all`.

The user cannot be expected to formulate “I want a full backup” as “I
want to match `git clone --mirror`” for a bundle file or something.
Let’s drop this mention of `--all` later in the doc and frontload it.

† 1: E.g.:

    • https://stackoverflow.com/questions/5578270/fully-backup-a-git-repo
    • https://stackoverflow.com/questions/11792671/how-to-git-bundle-a-complete-repo

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • Mention as a parenthetical on an existing paragraph (don’t create a
      new sentence and paragraph)
    • Remove the “mirror” mention
    
      Link (both): https://lore.kernel.org/git/ZxbIWEGS1UB3UIg+@nand.local/

 Documentation/git-bundle.txt | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 3ab42a19cae..0fa181c749d 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -23,8 +23,8 @@ the "offline" transfer of Git objects without an active "server"
 sitting on the other side of the network connection.
 
 They can be used to create both incremental and full backups of a
-repository, and to relay the state of the references in one repository
-to another.
+repository (`git bundle create <file> --all`), and to relay the state of
+the references in one repository to another.
 
 Git commands that fetch or otherwise "read" via protocols such as
 `ssh://` and `https://` can also operate on bundle files. It is
@@ -203,8 +203,6 @@ It is okay to err on the side of caution, causing the bundle file
 to contain objects already in the destination, as these are ignored
 when unpacking at the destination.
 
-If you want to match `git clone --mirror`, which would include your
-refs such as `refs/remotes/*`, use `--all`.
 If you want to provide the same set of refs that a clone directly
 from the source repository would get, use `--branches --tags` for
 the `<git-rev-list-args>`.
-- 
2.46.1.641.g54e7913fcb6

