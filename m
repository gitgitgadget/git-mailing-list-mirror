Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDF51AA7A6
	for <git@vger.kernel.org>; Sun, 12 Jan 2025 11:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736682887; cv=none; b=SZaf8XhXoxNvhtgSnGzN77RJIUy5T0c30sEm8+zF+v2s0ZofWOwt27VPm35eW8nFEhO2w21brbjHelKodreKhuFhlh3dk/SNXwl6xEzWPXlEZIBOfxsH1EVjNjoQOo4071+jVVwccQuziWpMaPdUqnMuN8tTzNkEt3fpiyDbuJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736682887; c=relaxed/simple;
	bh=lG92nfYZba8qSR+6CUTZWN4Gf+A6xGCq0HBrvzZ08lU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XuVs0dUc2//KptchNpo9G8q3ACzrEHzLy2WmrB4UZOcyRL3FK36TE19QCvbkpl19il6slFmiUZyMYr/S3GhEZzrLGn07hYOqkx3l5y0FvlilhbAtWnZ6rrjr3GVjiCoPdQNkL8x5Pff8Vv0FF9GZkowqtplm53GihV/BNkTvzl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ejeXFyMl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lNnRddeq; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ejeXFyMl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lNnRddeq"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3B704114015D;
	Sun, 12 Jan 2025 06:54:44 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sun, 12 Jan 2025 06:54:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1736682884; x=1736769284; bh=f8
	xM8vsucjsrqQNNvdxDv1/rwaSmv0g5DnIIPe6alVc=; b=ejeXFyMlMgoQ9K0Yoq
	LuEx3rxsjc7pdPOH0FORVHg8xXsoBE97GV2NM7SzsaOSTPTRPDz21xGCy5d/TMHb
	0QBtOv+2YZYEQOk7x87UCFXHpYueIfzkffmHGFLlLesbt3VlHd9dqe8j/Oa/vQ3k
	fPeALnKJAqU3q6++Pm8mFxCnHgwTtOesXGyAO/Rxu6ovOTWHNm872D8/JRNM+JAX
	JLfk2UcuxgS68VouyZ1I9CNHxupH0Nxtf6VwD27YWfxTQvQ8BtA7o8BkhLYLDjFk
	r901FoKRsz5XUnh575z32dHwK/ScA5+VuXFKgzmDrJS8AXcRB7qNloVB3RbVGeFM
	LUZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1736682884; x=1736769284; bh=f8xM8vsucjsrqQNNvdxDv1/rwaSm
	v0g5DnIIPe6alVc=; b=lNnRddeq3gWwEu1ZwjSTvGQCIpc6R4dIRmCK75nELpLc
	F++dCX0sl6FsSy/JFR7A23WllG6aakVF6tDbBt/kpym8UqJduix1MU4sWoHtg+vV
	cV6nNmNmQBXoKkLJxqpioha3CuX3/IaY4wY9o3zdyizjZmNS+Q4ItuqXfQAHIYf2
	jRO2S6GXis4FDQFEeTaoVRx5dQMQB2mqLGbxw5ROAwrEiaq+UfJyJrbjJO79Nrko
	ZCd+aFyIeocj3jdId6I/lOsabYN3RM/Lju60u7ChUZKGKV1TukaR6g4WBpA35Boj
	KhPHsqjLW62aLMclqi1RUQZT6XwPn4EPGpmL5R0U7A==
X-ME-Sender: <xms:hK2DZ3Us4j4LILc3b59l2vLzWYX_9q4UjSS3hU6dK1yD-SW5SYT_4mA>
    <xme:hK2DZ_knELTyi69mA5-wacvd9lVmrysDl8V9dOXo6o-6lI0v1w9QVftPYi6_sRv8r
    NPAt2_jgIPzDItArQ>
X-ME-Received: <xmr:hK2DZzYTt-1-mOiwAeY_iSNO1J1bqDLKF6uy2fDPA_3_5vIT3ns53A4k8Cq_WMfOgav6rOiUNREOP6CN6R2RTbDeilddGXDC0iOLcVd4Xg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehvddgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffogggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhepheelhefhie
    euheejveeftdfgiedtueevhfdugedvheekvedvuedtueeffeeigeevnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghi
    lhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvges
    khhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:hK2DZyUe4YDB5_Och80WSa9Osw6wBMoX9K-ikoq_7KyRCH-I7zvKJw>
    <xmx:hK2DZxnYTj163Rq_nki0hmV-DsrJaujh_uLcRhDMgSdbKz3kV0Ma9w>
    <xmx:hK2DZ_cUq1aOtpnwlucyf2_NHhUt9DGwHmDaFyBoV8J-d7BTejJ-DQ>
    <xmx:hK2DZ7Fo_5Ppcvgj1Gxo8ZJdzlSiVsi8BTRXyKGzbl_ozObbvFwGjQ>
    <xmx:hK2DZ2xvyV7MEwjn2vsDSalS8xNlVWCg33XSRRZZm-mLOjXLOp1mgaY9>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Jan 2025 06:54:43 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v2] Revert "doc: move git-cherry to plumbing"
Date: Sun, 12 Jan 2025 12:54:28 +0100
Message-ID: <e5b20f9ceb437a82c422136cb81b05a0521cab07.1736682716.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This reverts commit 61018fe9e005a54e18184481927519d64035220a.

git-cherry(1) is a high level command for checking what commits have and
have not been applied to some other branch.  Or at least as high level
as the git(1) suite offers.  In other words:

• it is a useful interrogator for a particular workflow; and
• there are no higher level commands on offer.

By contrast its use for scripting is somewhat narrow since it only
prints the patch application status and the hashes of the downstream
branch (not also the upstream branch equivalents).  git-patch-id(1)
gives a fuller picture by printing each hash and its corresponding
patch id.

Now this command is not nearly as convenient for the purpose of deleting
a *merged* branch as:

    git branch -d <branch>

Since that command will refuse to delete the branch if the commits are
not in the configured upstream ref.  But again it is the most convenient
command for the patch workflow.

This command might only be considered plumbing by way of the plumbing
contract that says that plumbing commands have stable output.  But
hopefully listing this command as Porcelain does not give the impression
that the output is not stable.  Output stability was in any case not the
motivation for moving this command to plumbing.

Users who need this interrogator should not have to look down in the
plumbing section in order to find it.

This also reverts its removal from Bash completion which Duy Nguyen
reported as a regression.[1]  The correct change for that plumbing move
would apparently have been to remove the `complete` category.

[1]: https://lore.kernel.org/git/CACsJy8AVGbS_NTZsUj_hD9D+t4YV1_S4KTD25Kda85syvoowyg@mail.gmail.com/

Reported-by: Duy Nguyen <pclouds@gmail.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    § v1
    
    Resend with CC dropped.  Neither of the two seem to have been active
    for years.
    
    § v2
    
    The `---` comment on the patch:
    
    > Up to discussion whether cherry should be considered plumbing.
    > I lean towards considering it a rarely-used porcelain command, but
    > a case could be made either way so let's see what the list thinks.
    
    I don’t know why rarely-used is relevant.  This change now lists
    git-cherry(1) down in the (Porcelain) Interrogators section, along with
    commands such as:
    
    • git-bugreport(1)
    • git-count-objects(1)
    • git-diagnose(1)
    • git-whatchanged(1)
    
    Not everyday tools.  And that’s okay.

 command-list.txt                       |  2 +-
 contrib/completion/git-completion.bash | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/command-list.txt b/command-list.txt
index e0bb87b3b5c..d73c8f59e63 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -72,7 +72,7 @@ git-check-mailmap                       purehelpers
 git-check-ref-format                    purehelpers
 git-checkout                            mainporcelain
 git-checkout-index                      plumbingmanipulators
-git-cherry                              plumbinginterrogators          complete
+git-cherry                              ancillaryinterrogators          complete
 git-cherry-pick                         mainporcelain
 git-citool                              mainporcelain
 git-clean                               mainporcelain
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3d4dff3185c..5026ef595cd 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1746,6 +1746,17 @@ _git_checkout ()
 
 __git_sequencer_inprogress_options="--continue --quit --abort --skip"
 
+_git_cherry ()
+{
+	case "$cur" in
+	--*)
+		__gitcomp_builtin cherry
+		return
+	esac
+
+	__git_complete_refs
+}
+
 __git_cherry_pick_inprogress_options=$__git_sequencer_inprogress_options
 
 _git_cherry_pick ()

base-commit: cc01bad4a9f566cf4453c7edd6b433851b0835e2
-- 
2.48.0

