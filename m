Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FB320F5A5
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 12:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730980846; cv=none; b=q4VJhEGyO+x+1NrwNVUkqKb/AycvtzmncgsvzyP8QbFyrQUPILOmQ3ACijxJ3rfD5C4RXq2njR93FQ9IO2bru7omLnKkk51wIxXRNiAccb2Yo1uobKMqjIMOZYLpHKUifwqWSU8QJV7HGfNy2WGyrLQ5+Vc0RC0UAlF44KzZfIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730980846; c=relaxed/simple;
	bh=ihxY1Ll0gOW4dUodiVosM/moP0HBdM0feWN563iIjfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uz/sdM2pQAiAjY5uXZySCGBGGccf5ThkYHrMVe6sBsUELejVbEQgQ3vVIKhFj2qSZ/9uN4Ml89OJXKzsNSJpcIQhMsJsoP4VFb/GPGP4aDSaeD9Tj1NZJTtWrehxwfbcwrwOuA23uVmT65dh4x+otEAcdM192YKx/43Urd6gvWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=UjLah4hr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KfoQgadY; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="UjLah4hr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KfoQgadY"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 9E36D11400DE;
	Thu,  7 Nov 2024 07:00:43 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 07 Nov 2024 07:00:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730980843;
	 x=1731067243; bh=VQTWZttrBfD84A6NdA0B7m3cO/brhSxUx2WqWO6I6xY=; b=
	UjLah4hrLPLyYK3HP/yK1lTecWtw236TBvSA9gj3ssJ170LptqUnk598JyREkZHL
	cHMqepRLJKAjndZ7Moso9+YERTA5jOd/1UkroJ6Qc5praiHBs9QV13HB6RzQx49i
	MHAa3xOAoa28D8Orm//tO9Ojj9nTl3YHydsb/i+uqqx2NtalUlLERLR6iKa0iA9r
	r4LiOH2crtGpfMWulmthBo/x9EozkevLPt5j5hcoWs0QE9aDMhLKse6cpl3+Bb2H
	I0rYcDJwrR+YG97eoujAU7fDZ1V3BT2A2S9HfOhHI1s3BOHxRLuhtMe1t/UVzvMK
	qqCZti09RpmNQiqlluBGPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730980843; x=
	1731067243; bh=VQTWZttrBfD84A6NdA0B7m3cO/brhSxUx2WqWO6I6xY=; b=K
	foQgadYiUtLBi9uJ5KDw5zs7QQuPYje5ApIwwNsb0fTv+P0SceaEyqJtB9Bhz2Aw
	Z7d/nR0E8h9aBxVlLeGNtrIy8Xvggzp7cmCFeIGzyy2h5faIRhz8bRtCfVyRUDHm
	Zdr6vRNfyDJZ9ihKNMniT9+am5a0M4Mlb5H0OLjZTb1loI21fojSUtch/8pPAnHY
	9sf1SQGrzRYcp8qHyYgvFOWOKiHwPGQORcttTEW0Nc8XHreRbUdi3oGvM7LF3iAA
	K7yB+4ctTCa+rRO9n8UyRj37cnxWCZgi8WzzbHW2fex9F/FV9yobBWCACoArHga/
	6dWqggDBkRYa/fn9l/wzA==
X-ME-Sender: <xms:66ssZ5B-9B14d9P9kD7EBwhsD4qKv5CVBOiMR7_GyQmuBlecNtkEBQI>
    <xme:66ssZ3hfhT_SO7YGJQK-9mj4n3HD9aGS27pUGdYlUEdOk0AA3V9zalLgJV6iYNUvG
    0pXUlBt92QQKkGQYw>
X-ME-Received: <xmr:66ssZ0nOj-lUYRbMnNF0WYkQm3A2t2ci9VmXxodqmzdqHRPE4hdg6XKxbQ_HuN09Ku45iD0iZuyC8ORlNUp-cY8r0FpvDYmPNR9ZJ25cQ8FhebuNEEQRSEBZ2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeggdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefuff
    fkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpedulefgue
    eiueetkeelieefgedufeehteekhfejffekvdeuhedtvefhkeeikefhgfenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggv
    sehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtoheprghvrghrrggssehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:66ssZzzXv2Nf5ZDzV8tzQ5UGyfbYUB7cqn3wNEfqL7hm2s1Bs3AWAw>
    <xmx:66ssZ-RQooPx0NH5YNcMLhVUEc2OxYt4tEygbrMYKW3ca4PzoKa47g>
    <xmx:66ssZ2bl36uVI_rQ8KllIp77gLOJe0ZOk9ME8XdC2302iN7WHMgr8w>
    <xmx:66ssZ_ThE7c7XUQ1UAWKUOD2m3VIjIbyGNqNEwgLukaCfRXAb6VHKg>
    <xmx:66ssZ7JjUCUIeRJCZDwRGFALz17IoHUi26rPy87A827bsF0yUdKBTQbq>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Nov 2024 07:00:42 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	avarab@gmail.com,
	me@ttaylorr.com,
	gitster@pobox.com
Subject: [PATCH v3 4/4] =?UTF-8?q?Documentation/git-bundle.txt:=20discuss?= =?UTF-8?q?=20na=C3=AFve=20backups?=
Date: Thu,  7 Nov 2024 12:57:36 +0100
Message-ID: <0ab05a4cf09ba02016b4493936ad1b092b1326aa.1730979849.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <cover.1730979849.git.code@khaugsbakk.name>
References: <cover.1730234365.git.code@khaugsbakk.name> <cover.1730979849.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: 0ab05a4cf09ba02016b4493936ad1b092b1326aa
X-Previous-Commits: c50f9d405f9043a03cb5ca1855fbf27f9423c759 63a431537b78e2d84a172b5c837adba6184a1f1b
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

It might be naïve to think that those who need this education would end
up here in the first place.  But I think it’s good to mention this
high-level concept here on a command which provides a backup strategy.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v3:
    • Use `cp -r` instead of `cp -a` since the former is more widely
      supported (even though it is just an example)
    • Mention what this “full backup” does not cover here as well (see first
      patch)
    v2:
    • Fix gitfaq(7) link
    
      Link: https://lore.kernel.org/git/ZxfhAAgNlbEq60VB@nand.local/#t
    v1:
    Correct mention of the section?  All-caps seems to be the convention.

 Documentation/git-bundle.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index d95bdd0429c..ad9ab3247f5 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -337,6 +337,24 @@ You can also see what references it offers:
 $ git ls-remote mybundle
 ----------------
 
+DISCUSSION
+----------
+
+A naive way to make a full backup of a repository is to use something to
+the effect of `cp -r <repo> <destination>`.  This is discouraged since
+the repository could be written to during the copy operation.  In turn
+some files at `<destination>` could be corrupted.
+
+This is why it is recommended to use Git tooling for making repository
+backups, either with this command or with e.g. linkgit:git-clone[1].
+But keep in mind that these tools will not help you backup state other
+than refs and commits.  In other words they will not help you backup
+contents of the index, working tree, per-repository configuration,
+hooks, etc.
+
+See also linkgit:gitfaq[7], section "TRANSFERS" for a discussion of the
+problems associated with file syncing across systems.
+
 FILE FORMAT
 -----------
 
-- 
2.46.1.641.g54e7913fcb6

