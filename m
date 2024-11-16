Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC79EAF1
	for <git@vger.kernel.org>; Sat, 16 Nov 2024 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731768956; cv=none; b=VkMOkwMoiVE5k6TGGTGqtT7z2y5cmFmeEsACZOItq0OWH9BmJxyoEwwXsrg/e8Ma5/qPlCKWtYgeLbbAWe71eZXiAbSRLAVQjDK9ZUNNuSUBa2FyxDDt5yzs3uZ85I+0UGGQnBQEJAPMotyU4tWFps+3CJpnryECOn3SCiTQNRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731768956; c=relaxed/simple;
	bh=EUxCExiIEXSwq5Wv4Pcp90aR7qzCWTZZy/R5VscDT8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ic9aYS+TrY0PpFUm5N+cAnGKj0ccyEevEpGxGmBE4a2vxsbIhY+/UzY8SssYCVbQVZtrJ/Hn+mxjjNChaE4Bv2C3BkR+Ag4lLsjtieKzc9l5wLFpfTocwPXpGo9JfKIzA5dsms2IPElRtz6vd5lfNGorcnlfWw6sptDniaxyzAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=sGs2Nln9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DZibOQnP; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="sGs2Nln9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DZibOQnP"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A588711400D7;
	Sat, 16 Nov 2024 09:55:53 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Sat, 16 Nov 2024 09:55:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731768953;
	 x=1731855353; bh=cAjUF5GHpjMfV3YCSXHy3IXQC29NP2pvlw8/YrXONFw=; b=
	sGs2Nln9fwj0e9br4GPENdb3cs/jt1soXRqEWfEf4NoTQkKD1/pT8wfd1D39aLf0
	hBVcvEDAftqhm06mCJeJZ7rENxE0A37moDpsv+bwhk5b/1eJkGuj6AfnJrsOmJzi
	34cUt3ES/KTPG8vXKvlwMA0IWKkRTh9BIo+mj7qyiBlh3v0QuEZ4Qgi0yOC6w20w
	hmIYiiL718ued24A5ZT+FXFffZT1SB/mK3zdFZTgowJTvOvqGTXcE2BL+/kC70kM
	bIDRy9h3K9UtqYPkB/bGOlRUCRYXg/oLP9bSOeFylqtvcS7DNftmBBmBmqpH59Bh
	jgbd/TVnDbPdO78gO168aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731768953; x=
	1731855353; bh=cAjUF5GHpjMfV3YCSXHy3IXQC29NP2pvlw8/YrXONFw=; b=D
	ZibOQnPAQk3tNtjfWD/myY03QWQAtAd63e7n+WXmzq84q5T2P4MJ6pBMhIJx+TKu
	aPbD5Gmypp9hhafZqeXxFGEjDcLjhIJLAep4vuKwAudEFjuLcNUEMCS8GKISVdSI
	VlSl5b41lCJnauE21YIfRLXtYmOW3lMPJ3s665WNzWgq4QIjFSMh7rmByWYwAv+4
	J8I76ecwd/PbXD68eGnRkjNWzlMCwjdM1NiWgPrBD+IjxPvtMr4veI+nCa7hf1+y
	oAfA7Fl+catHnl6gI9lPN7G/jfkfq1i82UVSfj3+4RhsBPjpMhbnFCNz0zpHiTou
	3LHdM4Skq+dXZUwcD2Ksg==
X-ME-Sender: <xms:ebI4ZzRJNUBWkTgsxI5-1va6NTxJt20eM8UA-OTSGYSgj4g7HDdf-rw>
    <xme:ebI4Z0z_WhLVAbKPIC2WhwUz8BHl70Q5VTYo2FkeHYMmo0lbcoMr5hLN2Can6WM6v
    jmyvV4_s6_u_dsSUA>
X-ME-Received: <xmr:ebI4Z41TjcsGeMhjeMjMcNLuSOqIUDv3iLmBrDtfdWv12KOBZpeDeEG0Noktq-8ocFhKClu1VIPi3MHHrQOLC2JPWx4S9UWBjjK6_RaWzLHf3KNkMLdBwlYU_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdeigdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefuff
    fkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpeelleekte
    ffheffhfffieeuleeggfegvefhleetieefleeiuddtveettdetfeetueenucffohhmrghi
    nhepshhtrggtkhhovhgvrhhflhhofidrtghomhdpkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhf
    vghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhope
    ehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpd
    hrtghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvseht
    thgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:ebI4ZzCtHDUTPVV1GXEIgb2LVrF0OjLRWyxR3CRRHVdcKhi3-dbZGA>
    <xmx:ebI4Z8ihUuUH1KCHj0NK4FmPrd8MzuPJK7lsOdEH--T6cmjpXntdFQ>
    <xmx:ebI4Z3ouz_YBlS13WWsx0d4IP98Z2-waoZotHYJSgEG6w0mi_kknwg>
    <xmx:ebI4Z3j3DVHokCq-AeSaBZNBjAQ2B_2X_7fmwWolkR0Xy3RTpgYSNw>
    <xmx:ebI4Z2aXS9M0fGvgz-Ef-GWV2fdGeY_54d71ezBW8Ws9ODyCfrdC14fD>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 16 Nov 2024 09:55:51 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	avarab@gmail.com,
	me@ttaylorr.com,
	gitster@pobox.com
Subject: [PATCH v4 0/4] Documentation/git-bundle.txt: promote --all for full backup
Date: Sat, 16 Nov 2024 15:54:50 +0100
Message-ID: <cover.1731768344.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.47.0.317.g7d2562b9734
In-Reply-To: <cover.1730979849.git.code@khaugsbakk.name>
References: <cover.1730979849.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The documentation for git-bundle(1) now prominently covers `--all`, the
option from git-rev-list(1) that can be used to package all refs.  A
"Discussion" section has also been added to address the naive backup
strategy of copying a Git repository manually with cp(1) or some other
non-Git tool.

---

The part above was for the-topic-summary.

I was prompted by SO questions like this one:

    https://stackoverflow.com/questions/5578270/fully-backup-a-git-repo

I then compared VonC’s answer to the man page.

Cheers

§ Changes in v4

• Tell how to recover the backup (patch 1/4)
• Fix confusion regarding `refs/stash` (patches 1/4 and 4/4)

Kristoffer Haugsbakk (4):
  Documentation/git-bundle.txt: mention full backup example
  Documentation/git-bundle.txt: remove old `--all` example
  Documentation/git-bundle.txt: mention --all in spec. refs
  Documentation/git-bundle.txt: discuss naïve backups

 Documentation/git-bundle.txt | 59 ++++++++++++++++++++++++++++++------
 1 file changed, 50 insertions(+), 9 deletions(-)

Interdiff against v3:
diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index ad9ab3247f5..504b8a8143a 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -216,21 +216,28 @@ EXAMPLES
 We'll discuss two cases:
 
 1. Taking a full backup of a repository
-2. Transfer the history of a repository to another machine when the two
-   machines have no direct connection
+2. Transferring the history of a repository to another machine when the
+   two machines have no direct connection
 
 First let's consider a full backup of the repository.  The following
 command will take a full backup of the repository in the sense that all
-refs are included in the bundle (except `refs/stash`, i.e. the stash):
+refs are included in the bundle:
 
 ----------------
-$ git bundle create <file> --all
+$ git bundle create backup.bundle --all
 ----------------
 
 But note again that this is only for the refs, i.e. you will only
 include refs and commits reachable from those refs.  You will not
 include other local state, such as the contents of the index, working
-tree, per-repository configuration, hooks, etc.
+tree, the stash, per-repository configuration, hooks, etc.
+
+You can later recover that repository by using for example
+linkgit:git-clone[1]:
+
+----------------
+$ git clone backup.bundle <new directory>
+----------------
 
 For the next example, assume you want to transfer the history from a
 repository R1 on machine A to another repository R2 on machine B.
@@ -349,8 +356,8 @@ This is why it is recommended to use Git tooling for making repository
 backups, either with this command or with e.g. linkgit:git-clone[1].
 But keep in mind that these tools will not help you backup state other
 than refs and commits.  In other words they will not help you backup
-contents of the index, working tree, per-repository configuration,
-hooks, etc.
+contents of the index, working tree, the stash, per-repository
+configuration, hooks, etc.
 
 See also linkgit:gitfaq[7], section "TRANSFERS" for a discussion of the
 problems associated with file syncing across systems.
Range-diff against v3:
1:  b222c6787a7 ! 1:  5121edfee67 Documentation/git-bundle.txt: mention full backup example
    @@ Commit message
     
     
      ## Notes (series) ##
    +    v4:
    +    • Drop the part about `refs/stash` since that is wrong.  What we want to
    +      communicate is that the state of the stash is not transferred since
    +      git-clone(1) does not include the reflogs.  We can just lump that in
    +      with the existin list of the index, working tree, … etc.
    +
    +      Link: https://lore.kernel.org/git/xmqqh68c3vr8.fsf@gitster.g/
    +    • Add para. describing how to recover the backup
    +
    +      Link: https://lore.kernel.org/git/xmqq1pzmqy97.fsf@gitster.g/
    +    • Correct tense: “transferring”
         v3:
         • Elaborate on “full backups” in Examples instead
         • Just point to the section in the second paragraph where everything is
    @@ Documentation/git-bundle.txt: bundle.
     +We'll discuss two cases:
     +
     +1. Taking a full backup of a repository
    -+2. Transfer the history of a repository to another machine when the two
    -+   machines have no direct connection
    ++2. Transferring the history of a repository to another machine when the
    ++   two machines have no direct connection
     +
     +First let's consider a full backup of the repository.  The following
     +command will take a full backup of the repository in the sense that all
    -+refs are included in the bundle (except `refs/stash`, i.e. the stash):
    ++refs are included in the bundle:
     +
     +----------------
    -+$ git bundle create <file> --all
    ++$ git bundle create backup.bundle --all
     +----------------
     +
     +But note again that this is only for the refs, i.e. you will only
     +include refs and commits reachable from those refs.  You will not
     +include other local state, such as the contents of the index, working
    -+tree, per-repository configuration, hooks, etc.
    ++tree, the stash, per-repository configuration, hooks, etc.
    ++
    ++You can later recover that repository by using for example
    ++linkgit:git-clone[1]:
    ++
    ++----------------
    ++$ git clone backup.bundle <new directory>
    ++----------------
     +
     +For the next example, assume you want to transfer the history from a
     +repository R1 on machine A to another repository R2 on machine B.
2:  f0dbe356ca6 = 2:  7e9f320fade Documentation/git-bundle.txt: remove old `--all` example
3:  8336b0f451e = 3:  4e9907f092e Documentation/git-bundle.txt: mention --all in spec. refs
4:  0ab05a4cf09 ! 4:  c8d5e3ee504 Documentation/git-bundle.txt: discuss naïve backups
    @@ Commit message
     
     
      ## Notes (series) ##
    +    v4:
    +    • Mention the stash (knock-on effect from patch 1/4)
         v3:
         • Use `cp -r` instead of `cp -a` since the former is more widely
           supported (even though it is just an example)
    @@ Documentation/git-bundle.txt: You can also see what references it offers:
     +backups, either with this command or with e.g. linkgit:git-clone[1].
     +But keep in mind that these tools will not help you backup state other
     +than refs and commits.  In other words they will not help you backup
    -+contents of the index, working tree, per-repository configuration,
    -+hooks, etc.
    ++contents of the index, working tree, the stash, per-repository
    ++configuration, hooks, etc.
     +
     +See also linkgit:gitfaq[7], section "TRANSFERS" for a discussion of the
     +problems associated with file syncing across systems.

base-commit: 34b6ce9b30747131b6e781ff718a45328aa887d0
-- 
2.47.0

