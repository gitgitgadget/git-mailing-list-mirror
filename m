Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65318213E77
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 21:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752008780; cv=none; b=pXfdRXwtrOUmWxkx3vNP0jLYNnquVGWQvKb/kTUJg98HjjyWbTPl8YY3xO4n46mwrJVNg4wjcJgi50aSizlGCahMnf4eINxQiaC71usZX5zYDaMqxL8I3tuiMygkumiw3vJk747rQuSfcF9CRJfkEf1sLWVBHWh2f/JiDlOJrBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752008780; c=relaxed/simple;
	bh=dIzfy0ZRK6Ab2nw8s1W6Waj1tWbyNLMD0R1leNMNIr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CofadbCmyI/se6Ys4XyacQHNePNscNXJLzWgIYPSljBKGHxCci+Nc7GiTUEMYXNC21iMjHyqsUEaN8uPoy6EzvxQzvRevMPlmrZXVDg1gKWIL7HyDmAb3OXCMf+cLBj+vskWROUkkNfI7KfgZKydNbgqu8830stdP7FQ5FzlUpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rQ3Hlu2t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A6PCJUsy; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rQ3Hlu2t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A6PCJUsy"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7C30D14003BA;
	Tue,  8 Jul 2025 17:06:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 08 Jul 2025 17:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1752008776; x=
	1752095176; bh=Bu3mtoQHVaIDRqc3cegm875fAI510cQfaqwfyF8LNFQ=; b=r
	Q3Hlu2t9+bThuIo2XhhaflTkfWxaE0TSLiUuDzJ/jXR9TQdXsgozO2cJjVoflqIT
	qbrijTwZWmafUhJ6+DY8WSaTh8rd9cp2NNNOEW0Nei0k9/wP73N5wlVKy5poMZfn
	xhVyOeJYkflNwRsbbwjSFOlvH0yvfxf9rtbQp0OD0q4PdTGOy/53A40ROo1L4RI1
	4o23llIQHxaAgzf2sUVsblpAEcf3Hw2RW8CycUlkAEqIuZFrulfv/oi86RWFKYEr
	53j1o+Zw9qoyx0nqMT3WLQJHwbdN5DTkhTGu/jJ5UunUpwqtKi2U6288VYUoSXPC
	OXSNx50nXx2Ccxi2QeRPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1752008776; x=1752095176; bh=B
	u3mtoQHVaIDRqc3cegm875fAI510cQfaqwfyF8LNFQ=; b=A6PCJUsyIb0+bgPJG
	zZTcHajaKU8yxBtVEhbFVQiTDqloFDQ/7JF6QX9qz6slTXPwzsJrjKcKW9tqhfa7
	+KRCmTSUzrOsZ8mMW+wyua6TllZ4oNyBtDKUbJVqFVoceQnhrfgE/CEo4ey/YZ2I
	smbl8uS7ENfHaaailuhLr25clcCv16e1bpzF2JDjwoGXdszUu4/dZP+VA7G32Lc7
	cqoQcInSP5dE60sdQ4laxx38Kiwri9nMI6Nxh9RSJJrhd9ajdvAl+h1UubqsQsh8
	qnlBBbv4yjYlHGvMtW53YNdUNUW09L8fhrW7VwENign1oiwyIV9QBxI1n9rkEiD0
	XjrCQ==
X-ME-Sender: <xms:SIhtaB9yOXJ0T8k1powvaIQFYZBf6z_ijKeP_54dlxCR0oTSZp_XWA>
    <xme:SIhtaI95D4p-bLem1bLhXw85ja3ZcxO5f5JoyrxXrxvFfEc6b9MYKVKaboPCi4Q-c
    BLwnNPfzdZiH5jHWQ>
X-ME-Received: <xmr:SIhtaIe_a6rs_iNKAN9HvrOqcJ_0iQ0sSp8fXNAU1qUesLP4bDau43WOj75s2aRCSGcnwraunei4rcFUWz300pMmFS8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefheejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohguugcukghu
    lhhlihhnghgvrhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    eukedulefhleehgeelffehledujeeigfffvddvhfevvdeggfegjeekueehkeegteenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepthhmiiesphhosghogidrtghomhdpnhgspghrtghpthht
    ohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:SIhtaBFSyWpNc7aup1wdF6rTHDQYfM1QUq6jW1GgcsHrlrOkPFBBXw>
    <xmx:SIhtaGe4sMdO8H44cbSLg97ctpXk-Acwgx_5A_CK8dur7rNNEkWWeQ>
    <xmx:SIhtaLEXsoqcSBGNBQaVRSUbyMQkoBWbcrJ6uGg_KRXKU6fxIneg2g>
    <xmx:SIhtaPXcd8c5N7yGcqH_oRDPTYLrN5S68X9ZC7LUFFOOUgzUQZbxJw>
    <xmx:SIhtaNnWVsqKLOVHw9yuXrPla5sN64lDTvpWUjIZO_vhlAzzbFh9pT67>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 17:06:15 -0400 (EDT)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH] t: avoid git config syntax from newer releases
Date: Tue,  8 Jul 2025 17:05:27 -0400
Message-ID: <20250708210529.1214574-1-tmz@pobox.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <aG1_eqSpH46UddZJ@teonanacatl.net>
References: <aG1_eqSpH46UddZJ@teonanacatl.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a recent security release, 05e9cd64ee (config: quote values
containing CR character, 2025-05-19) added calls to `git config get`,
`git config set`, and `git config unset` which are not present on the
maint-2.43 branch.

These subcommands were added in the following commits, released in
git-2.46.0:

  4e51389000 (builtin/config: introduce "get" subcommand, 2024-05-06),
  00bbdde141 (builtin/config: introduce "set" subcommand, 2024-05-06),
  95ea69c67b (builtin/config: introduce "unset" subcommand, 2024-05-06)

Revert to the previous `git config` syntax for older maintenance
branches.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---

This is based on maint-2.43.  I tested that it merges cleanly to 2.44 and 2.45.
I have only run a build with 2.45.4 so far.  I pushed this to a github fork,
which looks like it will run the CI for each branch:

    https://github.com/tmzullinger/git/actions

 t/t1300-config.sh           | 4 ++--
 t/t7450-bad-git-dotfiles.sh | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 1010410b7e..baf9b48231 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2595,8 +2595,8 @@ test_expect_success 'writing value with trailing CR not stripped on read' '
 
 	printf "bar\r\n" >expect &&
 	git init cr-test &&
-	git -C cr-test config set core.foo $(printf "bar\r") &&
-	git -C cr-test config get core.foo >actual &&
+	git -C cr-test config core.foo $(printf "bar\r") &&
+	git -C cr-test config --get core.foo >actual &&
 
 	test_cmp expect actual
 '
diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
index 2026285566..d1546e3311 100755
--- a/t/t7450-bad-git-dotfiles.sh
+++ b/t/t7450-bad-git-dotfiles.sh
@@ -362,10 +362,10 @@ test_expect_success SYMLINKS,!WINDOWS,!MINGW 'submodule must not checkout into d
 	git -C repo mv sub $(printf "sub\r") &&
 
 	# Ensure config values containing CR are wrapped in quotes.
-	git config unset -f repo/.gitmodules submodule.sub.path &&
+	git config --unset -f repo/.gitmodules submodule.sub.path &&
 	printf "\tpath = \"sub\r\"\n" >>repo/.gitmodules &&
 
-	git config unset -f repo/.git/modules/sub/config core.worktree &&
+	git config --unset -f repo/.git/modules/sub/config core.worktree &&
 	{
 		printf "[core]\n" &&
 		printf "\tworktree = \"../../../sub\r\"\n"
-- 
2.50.1
