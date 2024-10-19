Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067D8191F88
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 20:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729368018; cv=none; b=uGsKPkOPzxpa1GoyA7PQEJZiEkM4OBGYJmSBYzMVcsc2xVCQGXPKW5k10EKX2Otc7KgeTcg6uUGjKcA5F7XxWfbteWqZ8eqYqZtGKCQzoLgtFww/D5jSZyNLBUEVlPkSq9paG1z9V+iRkLVFwmDckM8h3iotwjuwWTnOH9ut6Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729368018; c=relaxed/simple;
	bh=chLQwNz3xs/H16nhjkyS3P/EGl+FJ9vMm38yIsq7iuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JZimDeAXkgq0kAFAKk9Kv6lvYRAP6AmD0fsru92c09k1lnSV3rXRSwoPLvkOunx5tlSZxwCntxBKowufFnhbO28fC47e/BcyzEEWx5T9dUbDvhnI+fVdWS2eaDwj/QhbQizQbDz5sTMtbSegRBIU1K3H/b7J54HLczOc40Tw5sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=QA73jxit; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DJJcYS52; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="QA73jxit";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DJJcYS52"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id E6450114009A;
	Sat, 19 Oct 2024 16:00:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 19 Oct 2024 16:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729368014;
	 x=1729454414; bh=Z14gVIs4Y8c//RffccW3WyNzl67TwhP/w6enOp1t+kQ=; b=
	QA73jxita4VBffj8bR/NBoTAOmfbwc+YUGaySssZ3kfkYj4Qb21b8dnUitL/+XdJ
	1NG48FuvBKMciYsQ6SDYfuOUAXm+zTLnRYAR3WZjhFXV29FAQNqQz5Xaqk+PJJrT
	5WLUqFGw8WYOsL43mwKGETxxYcpfeqG4hf5TsnUY3SbfUaFKKGxYrllZS9Xb+VMA
	yHa9RQ9uaV8QCPz0t4/u5zCRmJ45GE97Ycf1rtrfzjF2ObPKa9ULnR6DiTC06ltI
	z3z8Fi+HRYPjeC3OCzvX2LJAhf69pSFd5pjHeSAvKY6WOzhYL0BZZ6jg1kmdEcu4
	zPiZB1FJew83ZZCBmnJdYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729368014; x=
	1729454414; bh=Z14gVIs4Y8c//RffccW3WyNzl67TwhP/w6enOp1t+kQ=; b=D
	JJcYS52G0m0G4V079H9bG53ljLJgZiWW2180JsW2CbXBMJVZt8mMS4WuvTjqNnre
	GQKiDPOmuebZAWl9c9WgmUHM34aPYM/8jzoMwhy3pn0Rx4Fx060eIkmrV5/U01PK
	y6lYIwXeyhpwjXunP0j1EUYvcFP79zfc+3WTSBr7Ga73oQ67lypFOo1p7V5XWRnP
	XXEIELtlayhVL48xaDBQNKuk9SGeZFeXVH0znrrTF4rPWBvnpSTGngmjDo+jQbEY
	ZQ+BARXmyMk51jdbP/Kx4rfvgljHe3ignJN++mS7Lnr9TwrY7GQtddTJB7V3wqqf
	cCgeZIqVjLO5YrFwGYZLg==
X-ME-Sender: <xms:zg8UZ5KdLEG83XA7sL3_F9iSFjQhTgjD7pOSegVBWDZEmAc86z0836c>
    <xme:zg8UZ1JfHvyw_ipmHcso9yYgNpy2T7mWAzbTqjOcmaupqSWLV0WsZpI7E-5Sz4wN8
    KMSSc9JoeHeoSKubA>
X-ME-Received: <xmr:zg8UZxuaipUDFtPSnhkTCZ08o--Jm2tfHOm1vqQjem0Dimtl68K6it7xEyzYvicvqbezRBeCWOxerwTalIPy-r7wlmBZxpw5VY9YowgIQ3wU2jBryuJ2pUz10Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehhedgudegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhh
    rghughhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpefhgf
    eglefhjeekgfetleetjefhteeiheegfedtudduffegjefhkeetudeggffhkeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffh
    gvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohep
    kedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdp
    rhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepsggvnhgt
    vgesfhgvrhguihhnrghnugihrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:zg8UZ6ZLP_IffBn82WyEMAuc1GHr4vx929bjYjov9lxAbSjKD6l4DA>
    <xmx:zg8UZwYeNvA_4zaS6a8m2VkoqeuPiqYxlyayL_1fMLaHMDeAyh0mAw>
    <xmx:zg8UZ-DIckidvPivUHDR0hAGqrGx9QtcnNBFX-bJotcmMMUemnKbCA>
    <xmx:zg8UZ-ZYdtr9jYHne0LmyPz3MRMDFyC51Qim03RFEqj7iB3s2a8M6g>
    <xmx:zg8UZ2M_UDlpveAbzumEa7Jd8rQTo68U1mBSS8nh9dgx2n9pA5JhgGvK>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Oct 2024 16:00:12 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	phillip.wood@dunelm.org.uk,
	gitster@pobox.com,
	bence@ferdinandy.com,
	karthik.188@gmail.com,
	me@ttaylorr.com,
	sunshine@sunshineco.com
Subject: [PATCH v2 1/6] =?UTF-8?q?Documentation/git-update-ref.txt:=20drop?= =?UTF-8?q?=20=E2=80=9Cflag=E2=80=9D?=
Date: Sat, 19 Oct 2024 21:59:18 +0200
Message-ID: <91c1cae32098e82033f9b20ead6d1bc8e315da22.1729367469.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <cover.1729367469.git.code@khaugsbakk.name>
References: <cover.1729017728.git.code@khaugsbakk.name> <cover.1729367469.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: 91c1cae32098e82033f9b20ead6d1bc8e315da22
X-Previous-Commits: ad9ee00a2a971522968f95dd413deae24839ef71
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The other paragraphs on options say “With <option>,”.  Let’s be uniform.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • Message: tweak
    • Not done: paragraph wrapping.  I found something else in this
      paragraph: missing “that”: “after verifying *that*”.  I will fix that
      in an upcoming series since there were four other missing instances of
      this word and I did not want to add another patch to this series.

 Documentation/git-update-ref.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index afcf33cf608..fe5967234e9 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -55,7 +55,7 @@ for reading but not for writing (so we'll never write through a
 ref symlink to some other tree, if you have copied a whole
 archive by creating a symlink tree).
 
-With `-d` flag, it deletes the named <ref> after verifying it
+With `-d`, it deletes the named <ref> after verifying it
 still contains <old-oid>.
 
 With `--stdin`, update-ref reads instructions from standard input and
-- 
2.46.1.641.g54e7913fcb6

