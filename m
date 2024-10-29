Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94ED20A5F8
	for <git@vger.kernel.org>; Tue, 29 Oct 2024 20:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234529; cv=none; b=LAYfLGtRuQHpMkbg6A3Gs0R7zS6q8gxssaCyAH0BVTE9RL6T1+BY1uvNws+vKKMZHPEqfbJsLnqwQRu2B60J3Jnq8Li62ky8iC07uMA1qpU3Wq7xhWTWdsGYC3NmL1sCOVgKZhutCQDxKk9bgxajo11ZpxD9vmjykRzJB3yYEAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234529; c=relaxed/simple;
	bh=oR5oz57jViqRkFGVH0kcFg8bqjS6Xv08V/0RLBZNXAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E7qrfLPq3lnY9QDyTWzON/UjMGghiTpZ3iWmFq2aSwPNWyWa59WA3Yn0ahLG7rO1PFh9KsbV6p8xBTtTmNI4Mv1r83voRTO30c8XBx90JLm/qHbyRAChkc4kTigezYS2pQ3Fs6GSvDQJwu5FwSoYCJFni80+grHbQ/VxOCHymtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=l4luyKOb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BtMEuRVr; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="l4luyKOb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BtMEuRVr"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id C718D138019D;
	Tue, 29 Oct 2024 16:42:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 29 Oct 2024 16:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730234524;
	 x=1730320924; bh=XX1gm/ptQfCIzW0m/8BY7dIYEkLGI81LOv/KDky2eRk=; b=
	l4luyKObo0t1Zf184W95qyyahImiqZ/6cj/ORRS/gPAwl/VA4xCjFzGK+t4Ge8P1
	FDaOy73/KqVSHO7BRoAX79jVEk3II7Hv+5QLDFdU+rUPVvRIaTijPxTm+qqtPiA0
	ZoZZpJZ/L0oIobO67lWkz1xjm6joWoFiBtg9/Gzrl/VynY4j1IHwyEV62kHIeIvg
	AHS6Wq/R02SpCu2/5Q37A9SJXLMoDOIKCvJNPne5RWp8PDKB23WOSnL6GD/gqcPL
	epH00x+p1hH9bIDe5NFzC+Bf/dYhRoKTYKuiUt8vgpfgg8QsIoBVwGqfx7EDaOir
	6SACY9er1tMJiqOkvfd66A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730234524; x=
	1730320924; bh=XX1gm/ptQfCIzW0m/8BY7dIYEkLGI81LOv/KDky2eRk=; b=B
	tMEuRVrg+zFs9AD57EyNNovlfLnM6x2hImdeahhVEFn6NhlO7g31rujQ5ZDqKGQu
	KhnWPxSMymxwkWz/6gL6ItKCBVc0bjApddE7VUIXra39gHAJRX8PhYLfvJm9Xs4+
	R91DB2390bU/5WRkULjzzJJP3in5nmyx3cuhfnftxF1P+al6yFrruRw4GNrAABZD
	sdXdZ+8W0X53Owxiai7pQzUFXLo+/c644bjfUmD9HeyaFwTo++xB3s0e3D9fUV9m
	8a3E+T11FVc9pd3ZyqCZ8XGSjE7EmFyrbQLNV+ZbX5e9A1ffHXfNd1UjgCCKrKNr
	Qpdly6/iltmmL3K4W/7lw==
X-ME-Sender: <xms:nEghZw967ggMENrv99M3qXX7XkWPrn3p2THxiXLR6NJ1-aa1-NWG76M>
    <xme:nEghZ4uO_d4TJx1i2PW-XN8MYcRpdc2GdejudBCaSkpGc0lYZRySwR2w7m5SCdrjT
    ls9v6bV1SQ0DGYPjA>
X-ME-Received: <xmr:nEghZ2DriqnnTIXTOeX6FjabPMlDbPG8DdmqzFUfc2z34tBTccCkDyS0jZH6BGHWvBVf4rssZBO05Q0FqGrQX_6j6MoixEY9bBoBI-zDSK76JJfg4b8ssK5p_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekuddgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhh
    rghughhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpedule
    fgueeiueetkeelieefgedufeehteekhfejffekvdeuhedtvefhkeeikefhgfenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtoheprghvrghrrggssehgmh
    grihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:nEghZwfkAYFifN0RioWCd1dEiqa46MdXBMaqfocQgEtnScnbj6Jjyg>
    <xmx:nEghZ1MlZCUsPL4e42YPiXcxJcsPH9cvT9GzOX8_wRO9yoTOFjBHyQ>
    <xmx:nEghZ6kSl8iPqRtrpc8UJVgB3Tsdd_LbFa-qOXBtKYmUzC48tv3xjg>
    <xmx:nEghZ3tZgFdjNcLc11m4sKneXRSgkCRBY5mrG1uEbKWYUIgxebhjWA>
    <xmx:nEghZ6p816fn6LpuTvAr86RoM0HqLXbwf5OhQB1MUB9m3OiNKhb75HfW>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Oct 2024 16:42:03 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	avarab@gmail.com,
	me@ttaylorr.com
Subject: [PATCH v2 3/3] =?UTF-8?q?Documentation/git-bundle.txt:=20discuss?= =?UTF-8?q?=20na=C3=AFve=20backups?=
Date: Tue, 29 Oct 2024 21:41:46 +0100
Message-ID: <c50f9d405f9043a03cb5ca1855fbf27f9423c759.1730234365.git.code@khaugsbakk.name>
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
X-Commit-Hash: c50f9d405f9043a03cb5ca1855fbf27f9423c759
X-Previous-Commits: 63a431537b78e2d84a172b5c837adba6184a1f1b
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

It might be naïve to think that those who need this education would end
up here in the first place.  But I think it’s good to mention this
high-level concept here on a command which provides a backup strategy.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • Fix gitfaq(7) link
    
      Link: https://lore.kernel.org/git/ZxfhAAgNlbEq60VB@nand.local/#t
    v1:
    Correct mention of the section?  All-caps seems to be the convention.

 Documentation/git-bundle.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index bce62bc8309..7bffd2e4a05 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -319,6 +319,20 @@ You can also see what references it offers:
 $ git ls-remote mybundle
 ----------------
 
+DISCUSSION
+----------
+
+A naive way to make a full backup of a repository is to use something to
+the effect of `cp -a <repo> <destination>`.  This is discouraged since
+the repository could be written to during the copy operation.  In turn
+some files at `<destination>` could be corrupted.
+
+This is why it is recommended to use Git tooling for making repository
+backups, either with this command or with e.g. linkgit:git-clone[1].
+
+See also linkgit:gitfaq[7], section "TRANSFERS" for a discussion of the
+problems associated with file syncing across systems.
+
 FILE FORMAT
 -----------
 
-- 
2.46.1.641.g54e7913fcb6

