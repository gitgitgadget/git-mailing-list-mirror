Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D30242AA4
	for <git@vger.kernel.org>; Sat, 30 Nov 2024 13:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732973284; cv=none; b=iygwGB6fB2NVcv9mDqcVtnZjbkMqNj+IvjnxWSZSyqsYUspa6zEF+76OxrfaYSU4DW+gApJNqsEvI1dsnebkkw0My92h+pcVhj/V4kSmPXRcKOHmUuz3i7qYIg4OHM3dKa9XWjglnGn8NsWmm5B0ikXqMAh4pEKro/44tUrUy7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732973284; c=relaxed/simple;
	bh=nQzUJpfyMBnIWt1HrF8uOgbickdGWum7N4qQpjc0VOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XtFaK/aJ3IH+qmUHDRoVX4PtsGYLPIm6Rocw6ZvNVc2kgNGu5svtwKnnAvGrtfLdz6tuGRLmxDncQ5ZMlGAbwmAbLKj99QFFk4pEgQaxUzAdbQS0OIG5gvA87f965l7Fgi3Ej7Oct3HCyxphWDNgzNwJTsxHsfLfYuDX4E/DhRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=IIfeKsWv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VbhtMWOl; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="IIfeKsWv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VbhtMWOl"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4D3742540112;
	Sat, 30 Nov 2024 08:28:00 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Sat, 30 Nov 2024 08:28:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1732973280; x=1733059680; bh=10
	beaGrMLTDsW371CAziXq/vZEas+3L/L6Jo8m5O/so=; b=IIfeKsWvtYk9HlMIDL
	Yw7bJJtuWdP1Sk6GxAcuQJCBu2lqDoLqgkCpPPCM9/G0tqKkna4TIPHBviFecfXq
	JpnOtEhQrrzBU8tRM/mbPYU2B/4LUz1xFfz46e/XpfbbxZOoZW6fcGuNDVvQ+h9s
	rjnWrH3/MtUrqKphEvfUO+7ZPgIuWatdU8knXzwOB3SnZAtb5QWCfVyQYGF4vN6V
	uLX59JGo5qV2154Uwtc/kPapMbx8SSzUAu85q9w1pepBG0zuAcRRZHwTbXQE1jSD
	10FYdo+5EXG2zSKPRNwKfzRX36hvhbBa9kRFXJGTOtFLYMojZC/Fl0m/y8cGWhqw
	6itw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1732973280; x=1733059680; bh=10beaGrMLTDsW371CAziXq/vZEas
	+3L/L6Jo8m5O/so=; b=VbhtMWOlPvfwPmUmRuTJuuOH2r1tNn9x5Wf50dNsQ8gD
	Y3dmRzUjCtddIY4eEKvYHR748ChRlH7hspde5XtS7jlm3+lLUYx/2/mUy6DNTRw6
	7Luwa70e6Yb2mMELnsMWW18FTN4vcruZX6jvteajtehXe2k1nlYqYxBMavNxS8U6
	a45DRtdWEXowzn0Q3vxs05PwI0zjxACiP0k+G66ouksH9XqOoLDnisQ0ecs5ovJJ
	81kZJO1OqEzwI3/aWU8m1wHccfQ9YaBaWuVqQc56xWIbjaqKwFjsOVeh+qAOw18x
	KGtxzMjxa8oE4cpiodvQPGGDkmZI/HPdzXtHeJcd6A==
X-ME-Sender: <xms:3xJLZ3QDvmLzQbFksiACsQvdVz-Nd-DPko0fkVYQXH3-XY-QUf3SMEs>
    <xme:3xJLZ4zM59DFf3nXuBzBOuewZJ2v2A7sMlWzaWJji3tBF_xxRrGjejwx5Z6eHBmM3
    pToHNkeLT9TP0m_zg>
X-ME-Received: <xmr:3xJLZ8036CS6cdDP9_-vnTGkJnuHxXgr-_PjGK7BjuZvpXmUAlWMA759ZIgWk5js63PRMZ9MEBdWxS5KoGMp7JSLp3V1qlBmRIsaIlzRoA7KUIyyYn4wxe9LAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheehgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffogggtgfesthekredtredtjeenucfh
    rhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtoh
    hmnecuggftrfgrthhtvghrnhepheelhefhieeuheejveeftdfgiedtueevhfdugedvheek
    vedvuedtueeffeeigeevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgv
    rhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepge
    dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprh
    gtphhtthhopegurghnihgvlhhssehumhgrnhhovhhskhhishdrshgvpdhrtghpthhtohep
    phgtlhhouhgushesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:3xJLZ3Bc4dSTnAVyjRcY1eP6lNgB9AoHwIppgG1SgI571ETSgBVbOg>
    <xmx:3xJLZwjAhLDFdON9eqEg0UXanIcqwLBfCyXIi12Qhrbs2z8BnpEkCw>
    <xmx:3xJLZ7qPU-UYCPSwdwpesGf8EXYmBEGioIMuTEA64ia8jOOWQ9df2g>
    <xmx:3xJLZ7jfyvXFrFo4RzRl7VOa2r43mBX6vdg_yjFhi3TIeIXDSQLS1w>
    <xmx:4BJLZ4eto6Lg4pZOw0ZDCPzX2iv4tb_obuljpegOtMrqM5ZikxVUCTGk>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 30 Nov 2024 08:27:58 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Daniels Umanovskis <daniels@umanovskis.se>,
	Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH] Revert "doc: move git-cherry to plumbing"
Date: Sat, 30 Nov 2024 14:27:41 +0100
Message-ID: <e5b20f9ceb437a82c422136cb81b05a0521cab07.1732973210.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.47.0
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
2.47.0

