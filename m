Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7053D1F80BE
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 19:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019112; cv=none; b=S8ovDXdJ3iXLRT1wAiHofQYM0RPWjZyqT58vCnoE3fH/C+mBkIGBBQ8WyGk8Mbx8MK5foUWZqLPJVQfSOfEsiEtfBfddhDAynyASCZ85P3H1F8HW5k6RmMDt57RUFBdG5BDkTHiSWIVumIa4WzHlclT/Kb5ABz5bisKhxV8a4Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019112; c=relaxed/simple;
	bh=Vc70rSkACb+z9LN3VBa9wiuQtXp+uCaKgpKZHMWS284=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YYMS9Qc0gp6bxkRk33HLd1o+loxLOts1meXw3LC6ONFQW0MIWUvBQ0XxxNu2aQUv9U9kBc4ohED0OTmWvpVEnUo47GdvJ0iu/OylqLOuztcEwmGBaXMO0zcvOAFwtuKQxiYZmzwWtOs72xr0OCSxjRIs3kSVlhVNUKItKOSbnRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ZqJWkIg6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WPDs15Re; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ZqJWkIg6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WPDs15Re"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8AA9F1140155;
	Tue, 15 Oct 2024 15:05:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 15 Oct 2024 15:05:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729019109;
	 x=1729105509; bh=Bhrv7252ZG4qY1DnpP0qMysTLtZ7/itaY1GIjmU7wzQ=; b=
	ZqJWkIg6nP0sgAYfQ8Cdbi/obToh0nCxgNuaNEfQYCHBQS8WUU9Pv751ETn609f/
	vMXHOKXAM718xQh66a30oLsdJ3FhMS5yc3aq4XVpz+Y7evMCssd0TC88UvsJ75Ii
	ryFec4uQeg9+BaKRPdGOqYAYiQRl3mmKXUGgrYpan3F6X1tPQA8q6garEIMU71I0
	szBu/H2DlGdC8YWhteaD7waPoU7exsN3mJ8cC7UA79pexl6o+Gi6D/e8l+LMkOUI
	HbRmkaX9HBCTc4WN6P0BvuYAcu2eYDZqQA6IyQk3nx9ov/SptMhHhVkocKd+p/3/
	TwDZKsKtXd520x0XKPgM5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729019109; x=
	1729105509; bh=Bhrv7252ZG4qY1DnpP0qMysTLtZ7/itaY1GIjmU7wzQ=; b=W
	PDs15RenO5tC62VOerDP7+9JQg+TONPsQJ9V3E/qNveOmWHLRotTNAqdFEaoZIcd
	jJzuzWoeNikAnDD8TUxIsIeS64bPNPYFp0SCyHiCTNV4DBodLbHy5wtxtvV+lFYs
	zL41PwOlVjFhLAqrJa4/VIxF1FNjQwB4E9XQ82zBrB7VLGE3YiG1gNdF62i/Jmk1
	ED1Fx5opwCPUKKxpYkDitFItcHlGkjC/Quq5tsEOhPQHyRev/KSad3orAAZbHTm8
	FxNyKLGkieg10R3kQtxFgmp4atskW682BRu5nygS6sDkzdHwP3U+3VcybsceD9tm
	/sFLBKa6dCMronktVnGLA==
X-ME-Sender: <xms:5bwOZ2T8ol0aPfvQSz91VUJaOOWpM0acVhHqtaqKweI_loXZ9hRWQRM>
    <xme:5bwOZ7xqTflBOAufYqnGepMVPY7mCJn51GyPaWbd2z0JDXoKsctu4Mmj0y-4PS-mB
    cyNdQVxrGhEktcvQQ>
X-ME-Received: <xmr:5bwOZz2yixhqaMgBW6jsSZGDK_MJmQAHDvlOL6PwwdrJK1RERXzg076I9K3SQiMNDHz7Z_WHf0chfB6kUnHSiRc_WiVqX-PByBzB6PWcpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhh
    rghughhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpefhgf
    eglefhjeekgfetleetjefhteeiheegfedtudduffegjefhkeetudeggffhkeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffh
    gvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohep
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdp
    rhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepsggvnhgt
    vgesfhgvrhguihhnrghnugihrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:5bwOZyAevXDkWVMR9zCLCwQzaxsaniwwkiJs9Uo8mGcbjeryBdyl1w>
    <xmx:5bwOZ_hXWqvkq--1TJSL8Ca0ZNh39Eadqt3-V6ntYMNJpdZoLPNobg>
    <xmx:5bwOZ-rgBsoIxYqRyXJ4gvmT191vlSMN2Sbb_o3SSIbx9nP6GByWSQ>
    <xmx:5bwOZyiRVel3aRC8nbjaBzbl_7kQkW9TKT8XScJInznjfFimiDAAdQ>
    <xmx:5bwOZ6VCGJW_jmLKZNgZ260tSRadfzxsdDa4tqz3qwyjN1HQS9j8Fw5V>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 15:05:07 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	phillip.wood@dunelm.org.uk,
	gitster@pobox.com,
	bence@ferdinandy.com,
	karthik.188@gmail.com
Subject: [PATCH 2/6] doc: update-ref: remove safety paragraphs
Date: Tue, 15 Oct 2024 21:03:11 +0200
Message-ID: <c4bc0553a30ac16bd242edf387280eea37aa3a07.1729017728.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <cover.1729017728.git.code@khaugsbakk.name>
References: <CAOLa=ZQJy1ZkQqBoWwJJvL0f+NCP=3SAfyeSNuztgApzNH1mGg@mail.gmail.com> <cover.1729017728.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: c4bc0553a30ac16bd242edf387280eea37aa3a07
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Remove paragraphs which explain that using this command is safer than
echoing the branch name into `HEAD`.

These paragraphs have been part of the documentation since the
documentation was created in 129056370ab (Add missing documentation.,
2005-10-04), back when the command synopsis was a lot simpler:

    `git-update-ref` <ref> <newvalue> [<oldvalue>]

These paragraphs don’t interrupt the flow of the document on that
revision since it is at the end.  Now though it is placed after the
description of `--no-deref` and before `-d` and `--stdin`.  Covering all
the options is more generally interesting than a safety note about a
naïve `HEAD` management.

Such a safety warning is also much less relevant now, considering that
everyone who isn’t intentionally poking at the internal implementation
is using porcelain commands to manage `HEAD`.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-update-ref.txt | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index fe5967234e9..ec268b1426d 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -40,21 +40,6 @@ somewhere else with a regular filename).
 If --no-deref is given, <ref> itself is overwritten, rather than
 the result of following the symbolic pointers.
 
-In general, using
-
-	git update-ref HEAD "$head"
-
-should be a _lot_ safer than doing
-
-	echo "$head" > "$GIT_DIR/HEAD"
-
-both from a symlink following standpoint *and* an error checking
-standpoint.  The "refs/" rule for symlinks means that symlinks
-that point to "outside" the tree are safe: they'll be followed
-for reading but not for writing (so we'll never write through a
-ref symlink to some other tree, if you have copied a whole
-archive by creating a symlink tree).
-
 With `-d`, it deletes the named <ref> after verifying it
 still contains <old-oid>.
 
-- 
2.46.1.641.g54e7913fcb6

