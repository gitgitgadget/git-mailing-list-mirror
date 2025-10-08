Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808881339A4
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 19:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759952733; cv=none; b=VQXRbIiXA8H7J5Ut6MD3I+PwbSjyi1mwKSyNDZYWX8zzTu980NlzRxdv9pjZ910XrXRH4lLmf1S+4UXtB9CiIiHdSV1t7f5MTvMfpSdczcO5J4h+eYUoKsMdc7g9UktyJlMTkzSYdZln8793HOTmwsDn7czVs7g+KF5SbJjRjA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759952733; c=relaxed/simple;
	bh=iHGBLSQS9JiG3BRlTiLv4zijuSriaUUF/mSsdmZB5J0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lH8gd0zbNZlKy0wKEdgkawytH9sPzIxE/tuuuQivMw0x5597HKFPKds4uy+Gf/gqIVse/xXtG9y4gp0iApNVknlFeabTV2lKJZcZw+o3Eo2UqMo1NLyRw3QciZM09stqGk1h37cWUY1lM4K7lL2UZQuRI5dLbB+FbQtbDpkWxgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Tvjogr1i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=efxWxEJk; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Tvjogr1i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="efxWxEJk"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id AAE111D00149;
	Wed,  8 Oct 2025 15:45:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 08 Oct 2025 15:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759952729;
	 x=1760039129; bh=kiiP711JmPOh7FdXXdYUcqz0JjuuUT01O096AZcUY5U=; b=
	Tvjogr1ihcLqJaMjBjCkNkkmeCFA1fDHlJt+nGPzbToRLyvXTwlTTA1dXN/WchFY
	uTcl4Esd6SpL2pTZX0F630wvVie5wO48FWp3VvSOSdRI8f7/EB1Li8avHi0iModt
	RduMgM8gF+eHuMf1Pa/2iYc93ojFqePp392EIiTDpgRmHReG4vVBNN/GasHhbLJY
	08k7kynEZQVn1In+2PvoCaSScx7Qu0TEOFX+59/cRmCJb566bamqw7U6oLllCQsO
	hDO8s+e3OuB2zl7t1cXaPwFx4WYtBog40joICMlcAfGwYINSRMRjyrTswPQ6qU93
	GjrpMPd9ZGqsv+pUXqWi1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759952729; x=
	1760039129; bh=kiiP711JmPOh7FdXXdYUcqz0JjuuUT01O096AZcUY5U=; b=e
	fxWxEJk1XDggeV7/mgEuvt3eHmO7Z8/KHFe4fJt4WtYrennwWlrYLWEJ5JLZVY5r
	3xHSAlNF/RjubBeaE0KGOqjnsCOXNVFm0FbyDOyO1zT3ekoVQP5RkeTMukVo5qfg
	4BK6ZzyPhaQsicPdm5boEDNrA36QmZDTNFhFLqGe4vEMP726Ty/nhzPwrxbsVDvH
	4BbDDAKA0xLASUAu/3FlWki3z2zlanSkg3yu3MzwNMkh6AdR6836s7q1R3MoN9VE
	w8n2FGgnNGdqoyTWXz7tA5/alpYUcTTe99ShkSOnIkQJpWbk4nEifLQZfRMFBrme
	nFn1SLfgOSLDGt2mKrRBA==
X-ME-Sender: <xms:WL_maIDZl5ll2cJ1OSqoCFm1P41Bn1YzrAZeQFLKCNkmNqfoDFanLZ0>
    <xme:WL_maIWpMC57LofIGqiXKKvanXnR4wYtqStI-9GAGODbIMXhUU86hase-YSTQoo9z
    czVqJYPpiT5jhJBo923-hqx1dQdqfnrHlPknv-gmNLaWJm_DyPzDA>
X-ME-Received: <xmr:WL_maGDh4qw2nKAfCtaxmisilW9omEbn20Numr0CEF6qhdJoAQD2gIup_GlTxXpPEB8wK_2iVqE1Hzrj8aNyX_D48wW2KsmfBV0jVPZ0DJ6YPts4IvDrXgemiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdegudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesthekgi
    dtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhepffevffdtudefueefudeiheetieelve
    dtueeffeefgfffffdutdegffeihfelvdfgnecuffhomhgrihhnpehkvghrnhgvlhdrohhr
    ghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrh
    hishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjheitheskhgusg
    hgrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphh
    hilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukh
X-ME-Proxy: <xmx:WL_maL-DLMY2SYQVKIKbWH3LmKR-dVkHh9I0tHGd9ebMMZCWnvP2ag>
    <xmx:WL_maNHFUP1Cw1H59dZ2-X2Nahqz0BUKl3uJRCoRE7VgQD1we9WU8Q>
    <xmx:WL_maJPm9iIigr7AyXVHso_0bqrrtEt4CIW5PIbAah_VsF3mTM7J_w>
    <xmx:WL_maHfR3mKlWVb2tQPxdRXC9a-nEOMM5P38pEpn-n-buzP_JazadA>
    <xmx:Wb_maPyGf54WdR9eNDCvQc9_ExSz5Ex7zrU0VCHCRUNEzAUeFkfkQBJa>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 15:45:27 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: j6t@kdbg.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	phillip.wood@dunelm.org.uk
Subject: [PATCH] doc: warn against --committer-date-is-author-date
Date: Wed,  8 Oct 2025 21:45:20 +0200
Message-ID: <d17060d9b72.1759952528.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.352.g356bc2d8d49
In-Reply-To: <6af09726-e3bf-4903-87ae-9524ad334678@kdbg.org>
References: <6af09726-e3bf-4903-87ae-9524ad334678@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This option has legitimate uses but could create a commit history which
violates the assumption that commits are strictly increasing in terms of
commit timestamps. Warn against that in both git-am(1) and git-rebase(1).

❦

The genesis of this option is 3f01ad66 (am: Add --committer-date-is-
author-date option, 2009-01-22). The commit message doesn’t give us an
example of a use case, but the thread starter does:[1]

    I've a big set of patches in a mbox file: there's sufficient info
    inside for git-am to work.

    Yet, each time I do import these, my sha1sums are changing because of
    different commit dates.

    I'd like to force the commit date to match the info/date from the time
    I received the email (and therefore always get back the right
    sha1sums).

So the motivation was to treat git-am(1) as an import command that
creates the same commit IDs given the same base and committer.

[1]: https://lore.kernel.org/git/46d6db660901221441q60eb90bdge601a7a250c3a247@mail.gmail.com/

Suggested-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Topic name: kh/committer-author-date
    
    Topic summary: "--committer-date-is-author-date" can create a history
    with commit timestamps that are not strictly increasing. That doesn't
    play well with the revision walking machinery. Warn against that.
    
    (See https://lore.kernel.org/git/cover.1759873165.git.me@ttaylorr.com/ )
    
    -----
    
    I thought about marking it as deprecated but eventually found out why it
    was added. And it wasn’t for some (still unknown) dedication or
    not-explained *want* to keep the committer date and author date in synch
    just-because (as I thought[1]).
    
    Hannes asked[2] why it is a porcelain option? (You can after all script
    the same behavior with a little effort.) Personally I think the Git
    porcelain is not shy about providing facilities for crafting made-up
    histories to its users. And I personally think that’s a good thing.
    
    This does seem to indicate that this option doesn’t make much sense for
    git-rebase(1) though, no? Given that it will `--force-rebase`, i.e. will
    force new commit IDs.
    
    🔗 1: https://lore.kernel.org/git/93041214-4774-49eb-b8bd-24648134cded@app.fastmail.com/
    🔗 2: https://lore.kernel.org/git/6af09726-e3bf-4903-87ae-9524ad334678@kdbg.org/

 Documentation/git-am.adoc     | 17 ++++++++++++-----
 Documentation/git-rebase.adoc | 14 +++++++++++---
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-am.adoc b/Documentation/git-am.adoc
index 221070de481..c36ae679cfb 100644
--- a/Documentation/git-am.adoc
+++ b/Documentation/git-am.adoc
@@ -156,11 +156,18 @@ Valid <action> for the `--whitespace` option are:
 	See also linkgit:githooks[5].
 
 --committer-date-is-author-date::
-	By default the command records the date from the e-mail
-	message as the commit author date, and uses the time of
-	commit creation as the committer date. This allows the
-	user to lie about the committer date by using the same
-	value as the author date.
+	NOTE: The history walking machinery assumes that commits have
+	strictly increasing commit timestamps, with some tolerance for
+	clock skew (see linkgit:git-rev-list[1]). You should only use
+	this option to lie about the committer date when applying
+	commits on top of a base which commit is older (in terms of the
+	commit date) than the oldest patch you are applying.
++
+By default the command records the date from the e-mail
+message as the commit author date, and uses the time of
+commit creation as the committer date. This allows the
+user to lie about the committer date by using the same
+value as the author date.
 
 --ignore-date::
 	By default the command records the date from the e-mail
diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index 956d3048f5a..336ee90f7e3 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -504,9 +504,17 @@ merge backend;;
 See also INCOMPATIBLE OPTIONS below.
 
 --committer-date-is-author-date::
-	Instead of using the current time as the committer date, use
-	the author date of the commit being rebased as the committer
-	date. This option implies `--force-rebase`.
+	NOTE: The history walking machinery assumes that commits have
+	strictly increasing commit timestamps, with some tolerance for
+	clock skew (see linkgit:git-rev-list[1]). You should only use
+	this option to lie about the committer date when applying
+	commits on top of a base which commit is older (in terms of the
+	commit date) than the oldest commit you are applying (in
+	terms of the author date).
++
+Instead of using the current time as the committer date, use
+the author date of the commit being rebased as the committer
+date. This option implies `--force-rebase`.
 
 --ignore-date::
 --reset-author-date::

base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
-- 
2.51.0.352.g356bc2d8d49

