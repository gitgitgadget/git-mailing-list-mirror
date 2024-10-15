Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7674F1F80D6
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 19:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019118; cv=none; b=GpD8JMPjHlHhVOf34gw1zKEJwIh7+CXxvkwrd20YsAMXIQYRSFPlaILjNrMSbYL5PNADe7WPrpimbffj+xWDGx4NlnQZlCc6Hx0dWiu9jDHX2E0DseAAJjDymGXl+HDygxxIceUwta8alS5A/Drwny0NYAheSP9I2OxSPnaZoXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019118; c=relaxed/simple;
	bh=XH03Q/6S5f3+U1XDnnPSNOAJM2a3z899KznDiJkvdnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=She/S6dI3O8p576412Lwexg+ghwf8DELcUsMdhR0tCwk42mpIBG4awPwDlQxEzPRcXa8glM0/6vzdyCZsGAvLwLYY8perGdc7QIkkzuK8c6aGbudMXg5WSWTvXMe3jyqKeipzDG3FHvFd6PCvfki1rvI6g3+2Mkt7QGQNJAPsLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=pxQztXoF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JsfcLQDf; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="pxQztXoF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JsfcLQDf"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id AB177138010C;
	Tue, 15 Oct 2024 15:05:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 15 Oct 2024 15:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729019115;
	 x=1729105515; bh=feCi2vp98FKxMXpE9+R2KruHO6AoQLoZqk3bBDpY0xg=; b=
	pxQztXoF9h0RJP1q/gTPUZi7esuH1I+ubje3dp26Qhtzgl3EXzBGqj5JkGAQ8VTt
	umlBobkTp4BCPFnuyHadfJxg8CcX6ETxbXD02VAW/GDDZwKxsJDpDckIjS0BT+V3
	/Wgo+zVcLFnvSVOjll6yIrTKZU6WY/uRkzeawkfwjwjg3TWP+O0CIHg9+S2a0ifI
	4O4zjt1E98FD2pFpAAh7BkXmCVsQRYN5/O1/Rc7LLZlkDOuV2NxOa0gci7z+MvBW
	2dnFtxVg5Sj0GEAO6W4E21FzkeGFiYxX9GyZu0gbxUsmlQim3tNcvBH1tS54NmZa
	kNSgsVkyRHAkACvGUT2ZcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729019115; x=
	1729105515; bh=feCi2vp98FKxMXpE9+R2KruHO6AoQLoZqk3bBDpY0xg=; b=J
	sfcLQDf9FK+fJ7uHB2i8At0FDI7xqGNI/mxylnG+y4S3DQWIXmoGRUDv51WJ9jXT
	FXoMNS9gy+5HNkPLv27VIg7xD2ud6xQG76lv+OyR7A3iewjvZ/xkN2q+vYzvuy0G
	Tgvecdz8yrkBn+oA6NiJfnYdIPvJS9uKV8PC0SxHi11FwuufQZn8ttWSo0cA3m8K
	fi4a10ad/zVFuJdX/khVFSKVIONM/AyQ2dUp1+9pBlNn43p7ao49QUkpL07KB+UW
	Wo1hZ4F10XY/7ZCnT5sWB72err5EA2pHmkjv7i+/rK05UdP+CHdgq59et4XqSmBY
	BFIwcIA/MoWxEG1K2oRCg==
X-ME-Sender: <xms:67wOZ5480YLAyhrPKcDUupgz9-1bxAq6Q2PCGy9oui1eZ0mkgRR9DTs>
    <xme:67wOZ27fKt0WkoBE1i8l1bZn5Rzbt7XxFaR0RveXCF6dFRbhyOctyda0qmFRqIZtc
    k46lznqcL9ftOrsEw>
X-ME-Received: <xmr:67wOZwdOxgRbENyZFCwMLqAzweRAiTRjkOLoXblJ1WsAFCJd_5R5BfP41JUOoqZHPSak9jSmh_baffo2avPkh7D5DvQooHNv_VbIQ_vvrA>
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
X-ME-Proxy: <xmx:67wOZyLv4HeuEbwfZoP51ErV-CaiHfRIBMp6zgHdkrgfmuPViNSe9Q>
    <xmx:67wOZ9IhOk1sh86uiidKTai0lhQQ6YS2snosTPy3vNmbsO9CySKg2w>
    <xmx:67wOZ7yuoebSLCrbAQqRD_KCMUmiEm4YCSdOIyb46sovuBTXZDULCg>
    <xmx:67wOZ5LfwQVNwJq_fOJDmlN_StozQhJTO5ZyPIekQsnPPPZ9jyE9LA>
    <xmx:67wOZ18Fnzw89nC2e2TEgnpWPXHH2rrU33RqKMHPgzhbR3CbuW3xs_Kz>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 15:05:14 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	phillip.wood@dunelm.org.uk,
	gitster@pobox.com,
	bence@ferdinandy.com,
	karthik.188@gmail.com
Subject: [PATCH 4/6] doc: update-ref: remove confusing paragraph
Date: Tue, 15 Oct 2024 21:03:13 +0200
Message-ID: <dec48e2d37cc4edafb51476284ce3fece4718ce7.1729017728.git.code@khaugsbakk.name>
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
X-Commit-Hash: dec48e2d37cc4edafb51476284ce3fece4718ce7
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This paragraph interrupts the flow of this section by going into detail
about what a symbolic ref file is and how it is implemented.  It is not
clear what the purpose is since symbolic refs were already mentioned
prior (“possibly dereferencing the symbolic refs”).  Worse, it can
confuse the reader about what argument can be a symbolic ref since it
just says “it” and not which of the parameters; in turn the reader can
be lead to try `<new-oid>` and then get a confusing error since
update-ref will just say that it is not a valid SHA1.

Reported-by: Bence Ferdinandy <bence@ferdinandy.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    This paragraph is also from the initial documentation: 129056370ab (Add
    missing documentation., 2005-10-04).

 Documentation/git-update-ref.txt | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index c03e65404e8..4bb3389cc7c 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -25,10 +25,6 @@ value is <old-oid>.  You can specify 40 "0" or an empty string
 as <old-oid> to make sure that the ref you are creating does
 not exist.
 
-It also allows a "ref" file to be a symbolic pointer to another
-ref file by starting with the four-byte header sequence of
-"ref:".
-
 If --no-deref is given, <ref> itself is overwritten, rather than
 the result of following the symbolic pointers.
 
-- 
2.46.1.641.g54e7913fcb6

