Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBEC20A5DA
	for <git@vger.kernel.org>; Tue, 29 Oct 2024 20:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234524; cv=none; b=mF4HBjtFVBW/smD4qpHPkXvuLYbjtFeVerBGzXd49LH1FxIviFzCnvb2MlTQ0KmN+3aTRDb0s88njQqhasHSxmawgy9M7LqHGC8y63pAl53IdeJPQNS0gl4/CibE2QcPlqIi0es9J7430sRiDKCHvpthIJsTGvo70XAecquZskU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234524; c=relaxed/simple;
	bh=BCUq9k7s+lf8RGWILukt8xZoYWzgtnTpWgDrA8hCbgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bhh+ncohm3MiwaFZp3L7CsnFh2DquFR+rNu02WVsxrxkMyOgluF5NUnf79gBQT2d7PLAPki8vwTcjGkaP4G+1YDzsgOqMq2+HsoFpaNYBlen9JTFUFbBFyicX5XTSeqoMRGM8d3EDf3iN1DBoQFAZ+HeUIERjNhCFgNfpOV9Gz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Ql36j5yi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ii7I1PRM; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Ql36j5yi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ii7I1PRM"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 6850A1380145;
	Tue, 29 Oct 2024 16:42:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 29 Oct 2024 16:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730234521;
	 x=1730320921; bh=U5+7OrOSCN8Hz1IKFFLpRiQs7OHR9WzDhifh9b72vOA=; b=
	Ql36j5yiOrGqHGgqewbPOMbQqrwXJMnsmXZcp1DyPDrJuAuQxkB4oVr31C9qoeSU
	lhdMnuP6c59fdFH2fi3R13tKIrj5+26nvfsfzs8aOKW/gAWXyxzE4bu0M9Bm9hHo
	IDwaUGDcPPBe4WRn198kNqKoM1obfYmQitls5dEHMagpP2GVUFsAOQJHcnSMWsFy
	yhM8PMEuLfZLedY5hNGHiSgB4201qXWM7J7occpPWkIai1hwQsmaf9n4C9PqfsFO
	BSdr5vAU6biyU5zHTmpfk3dhrL6+pve4qV/5nlNS1JZIGio6ce+gxab6tWdp9ZJu
	uty9ah4t0z9tBg5MDPyV2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730234521; x=
	1730320921; bh=U5+7OrOSCN8Hz1IKFFLpRiQs7OHR9WzDhifh9b72vOA=; b=I
	i7I1PRM01GgiQrekV+W47IYJswXzMiWx4djFxRsUpx4gioJ1mw7Kgd3TwWdFowQ6
	WZ8O3AopHDny10V2ipPK5fTKYMNBQqv4HMMnrdxri3Q8ZlpMDj+Tar1V91MQkkuv
	SlIPALzxBe2G76K+R/2lAzbLJRTtLEt8aOOAuuIn5lQdoe2urSwS4khQV5KmieBg
	MfvO0ZV8292c2pSY8kN9rCN+/lD9vHHqZiQ4nIZR0nM2HJ/uyCJeFVYV58vrsxAO
	+5a4grEd27d2O3e/hS0voeepjNAMgDzR/fY8sAy8ACzOpKihqMny0SforG+wcqQ2
	i0n3MU8fwAD6wf13m7fEA==
X-ME-Sender: <xms:mUghZwaZBVXPTrihyza6xm5WjHp0h_ANtPiDSuwmR0cxQdMnSBHpL04>
    <xme:mUghZ7anW8hkulrXORcEfr0au7VAA6ICVzaUfZjD2PdO6rQNpkmkfln21KBjeSspM
    qFZ1ipzNgL0XFxHvA>
X-ME-Received: <xmr:mUghZ69E3A7hLIE6ecZgvilFP7Ypc1yiHHn5yzVK7XZ_0kYdNtsTO7DzQKKMb7B-zRQvf4bQdUzyfEWYdpoeYUfp-jy5WmHlxyPu0XxPLsVUnNHdTtvQXriz5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekuddgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhh
    rghughhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpefhgf
    eglefhjeekgfetleetjefhteeiheegfedtudduffegjefhkeetudeggffhkeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffh
    gvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohep
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdp
    rhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesth
    htrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:mUghZ6rktZHCPRwmU4aexD_VOjnml_6QKKAtPYPMTYVtrKEuhgaH2A>
    <xmx:mUghZ7rc3uprVldVJqifm-JnjJ3ozZCVw4UN_FxCR_2r80hwseLCbg>
    <xmx:mUghZ4SzkYNSGNCgKuQiqBEt0KyIqTm_tZrfpvpChBfgVBzFpLS55g>
    <xmx:mUghZ7qYn1TNAnOV06iOnNduLG4DBHsEzQim-tb0DE6hV-MNSS0ISg>
    <xmx:mUghZ8nEQfaR6WMXTaClnknSow_TAJffMWi2CoyCXF4EldDR8npHcetu>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Oct 2024 16:41:59 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	avarab@gmail.com,
	me@ttaylorr.com
Subject: [PATCH v2 2/3] Documentation/git-bundle.txt: mention --all in spec. refs
Date: Tue, 29 Oct 2024 21:41:45 +0100
Message-ID: <f18f8ca453d04a65149deb8a25f34b51158c4933.1730234365.git.code@khaugsbakk.name>
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
X-Commit-Hash: f18f8ca453d04a65149deb8a25f34b51158c4933
X-Previous-Commits: 33980a47d132c9ea56238641031e72c5c7e2565a
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Mention `--all` as an alternative in “Specifying References”.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-bundle.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 0fa181c749d..bce62bc8309 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -132,7 +132,7 @@ SPECIFYING REFERENCES
 ---------------------
 
 Revisions must be accompanied by reference names to be packaged in a
-bundle.
+bundle.  Alternatively `--all` can be used to package all refs.
 
 More than one reference may be packaged, and more than one set of prerequisite objects can
 be specified.  The objects packaged are those not contained in the
-- 
2.46.1.641.g54e7913fcb6

