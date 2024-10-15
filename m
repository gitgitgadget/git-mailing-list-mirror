Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCFF1F80CC
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 19:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019115; cv=none; b=Z+9NblTeGylJs8iE769lWsPQkkjWDNUIr/X6e+c2cqq4qqHKhTBMB/B4NZbU807fMBvc+Tyj+V6MnvJt0Fe14JspH5K7F/tpgcz/br9ur2VPyxUYVOOYO0dbHl5T/mXPTIrMghz9u2zb8VsnSBVuX4gO0J/uNXI/Kde19li22Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019115; c=relaxed/simple;
	bh=mQWXbJCo3ZthSAMX1YkIYlCRwPG5xAphUX33efYRg00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQLJUkgMh1N5aDZb1wGmM02vA9u1wSJQMqNx+qezg59uBnMhjUlTgoIJWaFQW99jZJZMLDttGZLXHpFXEbu6prmpZrqv8Kp9c/xrA4vjQC8/DTIJZeZwcRROlk0OvIAIZSj6TH1NjQiHmXcjruH3++tATJAEotU0GFsO5oMrq1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=LYU3L5xU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oKafn06U; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="LYU3L5xU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oKafn06U"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 9093A138010C;
	Tue, 15 Oct 2024 15:05:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 15 Oct 2024 15:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729019112;
	 x=1729105512; bh=8npD8EdiYf6ydygU9OnYqaJXF5OLp1GzMK34kNOvddw=; b=
	LYU3L5xUChjimRr5ZYFNkwVoHSsGXa+xR2iRUye8VIfMNEVF7kOHtqaFWCnWSyMk
	tihj7c/0dnmNN7Tp6bcCbmq+w2V18T5m4NszEQ6Fd7de0yE+gbMeWF3PQxqvqa/Q
	Nh8G6Q2i5qWMLgAUtDOfjS5xgi8CT9t8MJ9kvC/tFDSfmYfH6fTDFiibnsHYKaYD
	5iRpIqGSaT/r24UajNLBuLVwx8jnRod1BktTJkweibntlzfgz+e0ZU4zES54ars4
	AyT4zL4CnHeV0ZO/jufcjTsLeS+ryRob56kYUx07TVy0mdJLVhY0VhOLEK/wvSrN
	uaStBmHEUZJs4QiMWXZE9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729019112; x=
	1729105512; bh=8npD8EdiYf6ydygU9OnYqaJXF5OLp1GzMK34kNOvddw=; b=o
	Kafn06ULqp6/5DU2MAK4ZFCoWI3PLENWNdi2nAhJ7HqTJCXAHaK3hopC3udSFY31
	4Bv3U9gVcnmCq1M+FL2Ed40Q1DDQrunKave9nqnT2s495GBpqu6fWVI2HUF3zalb
	trja54FNms2anHNMFrHp2y1PX4jTUgzozA/JW+HWyQ4520q8foJByoxxVtlNZ5G7
	sc/5v8jjWDEPMV7Py29YM3VWXSd6JL1pMSfTrrnRz9FcmKHc/GVp+/YczDMk/sEn
	Foac/hSOakHxIbTeginB9qleWKxEHJQUSUoTP3aMSxCwXaFMgo6BLJ28ARwKeOh9
	WB4QlKo0f2307W+/AkFsg==
X-ME-Sender: <xms:6LwOZ_FKSX9vbTQ94AL5WImxtBNloUb4yJ9AUs_0eQBAYeRp6-AZ5Y4>
    <xme:6LwOZ8WKq2eOMmz_BsUR9Cw-0tnt3WWbFGuo0aLW6wpAu02GWb5HfYBQgBToqVc5D
    BcPcRbFCPgIlLk2nA>
X-ME-Received: <xmr:6LwOZxJss_30ReqlxPUMUPNPaAl7PNF7epvtBUmwXTQxuz6Ng38cxFalZYoYe5eab-uQgTzkU3iCLB48xeO1S--YRHl4mv-KthKOCVKRIw>
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
X-ME-Proxy: <xmx:6LwOZ9Gb-LkAO7eR2aT4MjX37jfhRR0KKadOOkApXuV0zopa6WOdSg>
    <xmx:6LwOZ1Xix6lFx8vM29R4w9ZkCySO_OCNb5S7HoQYfYsJVn294Nm8vg>
    <xmx:6LwOZ4NYtrxIHfgiNrbQjnNJxP0X7OKaL2f3vZUHabx7YJS-9K3Pew>
    <xmx:6LwOZ03zitLANGV68RmMvAZ-DIwWR_m45wYQC4gN2cHBmg5GP5Sd4g>
    <xmx:6LwOZ3JO0-RxgvnSCCM-emjOGMeCw8-IiPmXuDGSEL_3Y0NhBjz_Y5WH>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 15:05:11 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	phillip.wood@dunelm.org.uk,
	gitster@pobox.com,
	bence@ferdinandy.com,
	karthik.188@gmail.com
Subject: [PATCH 3/6] doc: update-ref: demote symlink to last section
Date: Tue, 15 Oct 2024 21:03:12 +0200
Message-ID: <3f43ddfed24e89ab9931b83e549f0eb8bc829928.1729017728.git.code@khaugsbakk.name>
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
X-Commit-Hash: 3f43ddfed24e89ab9931b83e549f0eb8bc829928
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Move the discussion of file system symbolic links to a new “Notes”
section (inspired by the one in git-symbolic-ref(1)) since this is
mostly of historical note at this point, not something that is needed in
the main section of the documentation.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-update-ref.txt | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index ec268b1426d..c03e65404e8 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -29,14 +29,6 @@ It also allows a "ref" file to be a symbolic pointer to another
 ref file by starting with the four-byte header sequence of
 "ref:".
 
-More importantly, it allows the update of a ref file to follow
-these symbolic pointers, whether they are symlinks or these
-"regular file symbolic refs".  It follows *real* symlinks only
-if they start with "refs/": otherwise it will just try to read
-them and update them as a regular file (i.e. it will allow the
-filesystem to follow them, but will overwrite such a symlink to
-somewhere else with a regular filename).
-
 If --no-deref is given, <ref> itself is overwritten, rather than
 the result of following the symbolic pointers.
 
@@ -185,6 +177,17 @@ An update will fail (without changing <ref>) if the current user is
 unable to create a new log file, append to the existing log file
 or does not have committer information available.
 
+NOTES
+-----
+
+Symbolic refs were initially implemented using symbolic links.  This is
+now deprecated since not all filesystems support symbolic links.
+
+This command follows *real* symlinks only if they start with "refs/":
+otherwise it will just try to read them and update them as a regular
+file (i.e. it will allow the filesystem to follow them, but will
+overwrite such a symlink to somewhere else with a regular filename).
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
2.46.1.641.g54e7913fcb6

