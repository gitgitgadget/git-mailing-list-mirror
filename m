Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC97D1B3950
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 20:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732565616; cv=none; b=mWhFF/0oXvcH7nvREP++5HdR43987ZK06sNuHVMedPLGtf5uJIUnuzkAvWebqA0F4zjjvCLcXB4D1hNxZ1iONTIuMaa/WlYJVW/aSsI3r/0ZlO8bWipNhINlyTAc+OHDDE3Bw+37K2/YMhXHYvPJoXB1pWlKhYtCiE8ap9aNrOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732565616; c=relaxed/simple;
	bh=HAvkXyTJo1gTP6vfM0LoXs5il27uhoiP2TGoSnLxG+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mk7ZxakJzkKx20Q189TqiY0Lj5iC2F/NC3/RcFc/h4pfxMWDzGTHTmVvgwEWvUl4ZMNd9FBBimMqQzL4ehZLjgcM9oXisEv4cLmyehl02T6x1UZIPslpBAhCleCFVfnavP3mIq5cjQZ5UT1w5Rh9sLYK6f8UbPM+LNG5/NMPv7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=cMcg2IpI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bkdNYheQ; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="cMcg2IpI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bkdNYheQ"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id D959913805EA;
	Mon, 25 Nov 2024 15:13:32 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 25 Nov 2024 15:13:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732565612;
	 x=1732652012; bh=6ofVTeg/PUqxmRjkcUgiO8h7ntFUYMBPI5SDy+l4nmU=; b=
	cMcg2IpI7K276K8T9tRmOo+/0X/SPgKC5AKob+TAAw+QhBEqgNBV3ADEBV/QunWI
	+P2XGEDRFeZzthTNLlQ1OAK7ay+D2Dx4JQ3VnrdKmxcBw+IkZwPpQRyAunLXUEbh
	CzKYeF45xXMGbS+7kdbY4WwPSa2qv0NU6C4weRijB8qrrHw/o4Fh4stnZUBdPmDL
	9PgUPfRh+KyD+NbnS7C02WCL65mhrhc/jlFU2xho3+0JgHIfWv4wg7XJPQj4ENVS
	tV03gysbifTiriz2ZC1dZf84Kbf9V2KkD+VS2DRJvUgAdrQB69cvMXCWhOJDEkLg
	pvAf1nOADjVV//m4EC7mVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732565612; x=
	1732652012; bh=6ofVTeg/PUqxmRjkcUgiO8h7ntFUYMBPI5SDy+l4nmU=; b=b
	kdNYheQGpkv1j180lJoHhn9dE0yANdDbd1H6qO+3xILcfL26U9vyW7GPRgpIlZhe
	WTq1VPdrB0okngWXddx0Tx682qY/8xu0QJbh/R+j4H9QTremmA3uDiPN4WkEuVEz
	bQ/MT/udXN9Lr14jXR0xG3n6B2m10nEHnlo5Kd6ARWdtvc+jcEN1KmTze95/EWWF
	X+tWFIam7JLeZy4yN77mN6JoLVDR3WAEkb3U+Kj/VSzTMfEqXB3GcgfAws73veyh
	SGzvsw0P7h+1+Z+N75o7o3dyC6tCNtwaU6UHcXeA21x3pk657Pkjt4KRXkcFpRxW
	1jzFiWt5By2SUq4udy3hg==
X-ME-Sender: <xms:bNpEZ7QuugqXWtuE-0HI-jLAY13F1ZR5ggyVWZWXO9iCxM9Eq5Jpob8>
    <xme:bNpEZ8y2IUWLBY7cTLJdJoB383GJiotMjKnBHPFymCAoCQ9VN7jsad5chjRQG8gQ6
    0WQt_Zal4RBadrTww>
X-ME-Received: <xmr:bNpEZw11Bh1ZvC_JxK-MPji4Acm9yIBupKBEYwPArWQVGxoCuEC13KxiK-Lc7P8vZgYCWivNebPMggygpHivzFIpzQs0-dW3vdw6p1JH76sxBbeq6H_9a6WZcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgddufedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhepudelgf
    euieeuteekleeifeegudefheetkefhjeffkedvueehtdevhfekieekhffgnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegtohguvges
    khhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtth
    hopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:bNpEZ7DwyJtq7jrFd99lDmf--WOAZhWy_lx7XpVM53Ogw3mIEvmrXw>
    <xmx:bNpEZ0hfUJtlXeyzoMfMfUNA2y6iEJn0forOmaWIbF2fV0frWd7Oqw>
    <xmx:bNpEZ_rdGR6DujjtfRIGXpr2ewtt5rRs4gQu7RiTHQZak4c7uo3sCw>
    <xmx:bNpEZ_iwh-8FF-J9UPsYueMZOsBPfC2XaNbD98UxvDRA5627Klg4Qw>
    <xmx:bNpEZ_WooIIoeHzBsBtEBteBWdwPgl4sPTRkA7oioIhi-IOKlAjB2DO3>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 15:13:30 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: gitster@pobox.com
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	stolee@gmail.com,
	phillip.wood123@gmail.com,
	me@ttaylorr.com
Subject: [PATCH v4 0/3] sequencer: comment out properly in todo list
Date: Mon, 25 Nov 2024 21:13:10 +0100
Message-ID: <cover.1732565412.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1732481200.git.code@khaugsbakk.name>
References: <cover.1732481200.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Fix three places where the comment char/string is hardcoded (#) in the
todo list.

§ Changes in v4

• Use `test_grep`
• Fix commit message (`)
• Don’t need to cat(1)
  • Also use `-n4` in case `-4` is not widely supported

§ CC

• Stolee for the first patch
• Reviewers on the previous rounds

Kristoffer Haugsbakk (3):
  sequencer: comment checked-out branch properly
  sequencer: comment `--reference` subject line properly
  sequencer: comment commit messages properly

 sequencer.c                     | 26 ++++++++++++++++----------
 t/t3400-rebase.sh               | 19 +++++++++++++++++++
 t/t3437-rebase-fixup-options.sh | 15 +++++++++++++++
 t/t3501-revert-cherry-pick.sh   | 14 ++++++++++++++
 4 files changed, 64 insertions(+), 10 deletions(-)

Interdiff against v3:
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 711bd230695..7c47af6dcd9 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -471,8 +471,8 @@ test_expect_success 'git rebase --update-ref with core.commentChar and branch on
 	git checkout topic2 &&
 	GIT_SEQUENCE_EDITOR="cat >actual" git -c core.commentChar=% \
 		 rebase -i --update-refs base &&
-	grep "% Ref refs/heads/wt-topic checked out at" actual &&
-	grep "% Ref refs/heads/topic2 checked out at" actual
+	test_grep "% Ref refs/heads/wt-topic checked out at" actual &&
+	test_grep "% Ref refs/heads/topic2 checked out at" actual
 '
 
 test_done
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 43476236131..b84fdfe8a32 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -231,7 +231,7 @@ test_expect_success 'identification of reverted commit (--reference)' '
 test_expect_success 'git revert --reference with core.commentChar' '
 	test_when_finished "git reset --hard to-ident" &&
 	git checkout --detach to-ident &&
-	GIT_EDITOR="cat | head -4 >actual" git -c core.commentChar=% revert \
+	GIT_EDITOR="head -n4 >actual" git -c core.commentChar=% revert \
 		--edit --reference HEAD &&
 	cat <<-EOF >expect &&
 	% *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***
Range-diff against v3:
1:  a46767263f6 ! 1:  a8813b5f14c sequencer: comment checked-out branch properly
    @@ Commit message
     
     
      ## Notes (series) ##
    +    v4
    +    • Use `test_grep`
    +
    +      Link: https://lore.kernel.org/git/5267b9a9c8cc5cc66979117dc4c1e4d7329e2a03.1729704370.git.code@khaugsbakk.name/T/#me80519debcd013aa8c8a5e5003c58cff7281fac9
         v3:
         • Review feedback: check more in the test by inspecting the
           sequence editor
    @@ t/t3400-rebase.sh: test_expect_success 'rebase when inside worktree subdirectory
     +	git checkout topic2 &&
     +	GIT_SEQUENCE_EDITOR="cat >actual" git -c core.commentChar=% \
     +		 rebase -i --update-refs base &&
    -+	grep "% Ref refs/heads/wt-topic checked out at" actual &&
    -+	grep "% Ref refs/heads/topic2 checked out at" actual
    ++	test_grep "% Ref refs/heads/wt-topic checked out at" actual &&
    ++	test_grep "% Ref refs/heads/topic2 checked out at" actual
     +'
     +
      test_done
2:  7a452142666 ! 2:  4d10ad4ab55 sequencer: comment `--reference` subject line properly
    @@ Commit message
     
     
      ## Notes (series) ##
    +    v4:
    +    • Don’t need to cat(1)
    +      • Also use `-n4` in case `-4` is not widely supported
    +
    +      Link: https://lore.kernel.org/git/7739a6e2-8758-4d0f-b1d6-f0879a89590f@gmail.com/
         v3:
         • Review feedback: check more in the test by inspecting the
           proposed commit message.
    @@ t/t3501-revert-cherry-pick.sh: test_expect_success 'identification of reverted c
     +test_expect_success 'git revert --reference with core.commentChar' '
     +	test_when_finished "git reset --hard to-ident" &&
     +	git checkout --detach to-ident &&
    -+	GIT_EDITOR="cat | head -4 >actual" git -c core.commentChar=% revert \
    ++	GIT_EDITOR="head -n4 >actual" git -c core.commentChar=% revert \
     +		--edit --reference HEAD &&
     +	cat <<-EOF >expect &&
     +	% *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***
3:  4c342bc0422 ! 3:  42b9fbd12d6 sequencer: comment commit messages properly
    @@ Commit message
             fixup hash2 <msg>
             fixup -c hash3 <msg>
     
    -    This says that hash2` and hash3 should be squashed into hash1 and
    +    This says that hash2 and hash3 should be squashed into hash1 and
         that hash3’s commit message should be used for the resulting commit.
         So the user is presented with an editor where the two first commit
         messages are commented out and the third is not.  However this does
    @@ Commit message
     
     
      ## Notes (series) ##
    +    v4:
    +    • Fix commit message (`)
    +
    +      Link: https://lore.kernel.org/git/5267b9a9c8cc5cc66979117dc4c1e4d7329e2a03.1729704370.git.code@khaugsbakk.name/T/#me80519debcd013aa8c8a5e5003c58cff7281fac9
         v3:
         • Message: Explain to the best of my knowledge what is going on here in
           the message body

base-commit: b31fb630c0fc6869a33ed717163e8a1210460d94
-- 
2.47.0

