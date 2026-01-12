Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8842D259C80
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768227443; cv=none; b=gJEmZdRp3CcMIxUfFXPB1BJXXCB/Nd5OE61Bpl3b3kWj1a158WuHRcLYpqlqGzlnMD2Ma+6gP084AtUIntMA7+FGCYCLc93cTN2sSl3L6pSz2U+BdSxxOc3j3lPhQfh9DIzkNmXotMFmr3j5Bac8STCtYlrqmhXW93lMD0QgV5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768227443; c=relaxed/simple;
	bh=p3Lty5k//ACoMYISR8JKyqem29Cv5AX6wFA5DW/JQC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G6ON3hTvXVwICTrJqNHniUtIRrTorLn6IeyaKARHh3g8bk7xDADIVCj89qTiSpE6jgcTpRsYkjPzm0i5ZLS0quVVJiZiy42kxmXwwW3Jlg64srhamrSqSJRdeYk5SxmF04lSFz0KABZR7a/b9x70toeBPCfEidLmfaCBl1Fq84M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=g7y3djtZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VgQ7zCY2; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="g7y3djtZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VgQ7zCY2"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id E0CDCEC0591;
	Mon, 12 Jan 2026 09:17:15 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 12 Jan 2026 09:17:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768227435;
	 x=1768313835; bh=4wzVCKS7TJpYTtOhUB6Mwqa+qUTMT2JQY5mQsbAn8aQ=; b=
	g7y3djtZby4w2Um0WSfIo9TBGy8lPUu0NnsMnG8s8EzviGfOKIT+HfxxwADkz6wx
	TE2W0/9jk1rdzKlp8LJqCEtepXX60qDB+1TFVC4ABgG7yG6q95EdrLRnta3/l9Kg
	1w/xCII5eZJYDLqEFFjSklykJkylp/jGcRBGJ6oFcv218yY0/lTcIeRTpSE9dja2
	O9aG9PHbplYEdd4RgXP9spK9/h+RyOA9e/BU7qd4lV4AmPx69Ia7Z1Jm+C/glrmt
	YDP/7VPGi90mMJnpInO2+MfOLuHdGIrNCeGqCqq/hLNPZc/Y89Nc95cBnVsy0HOq
	B1yZG8ZAj+LPxzR2Atr0sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768227435; x=
	1768313835; bh=4wzVCKS7TJpYTtOhUB6Mwqa+qUTMT2JQY5mQsbAn8aQ=; b=V
	gQ7zCY2gbB3eguU1+ChGCqMZn6R0YHbDo99ztGyzQpngkOQ7NcSXNk84ZSo5SHPi
	9xRLRIB3dlA+Dg7B0jczu0I4RfVx0AZAO/368OyHWv0qV65P3RYGR+Rx3kPj6zNi
	6g1U5H4TMuDOXzy61gfLThphCcCzFKFUtTZfJ94YxzkeLq3QVY4Xhs8Z8CIA6vSQ
	tRRjXeLQkGMwJEiK+vv0DjnewGo26UjC66IGjQkZ1hWLlzJOdA8t8iyRaDT6VthV
	qFefWbZMXPcjt7zqOaNhyv/WRaM4Ho0wXO2jmWqrTy05xw0o1Wm9Qmbdy3bfVcxn
	LIgRPuTr/vadzxxkzW5Qg==
X-ME-Sender: <xms:awJlaYpQBiMQmELRxkLZwsVzrDFZ_51S5-wBaEX86H0Y_31-sQtJzg>
    <xme:awJlaTCAlUlNZFau-FKFrcQQ_38aKqm7CkdQGr0emqX87WgWykqrglLlCsBqr5b6I
    5JrdUXU907FVIccAW-7ROlSGlh1LjnGqT-f0VLfaB-7yKW4AfeSRA>
X-ME-Received: <xmr:awJlabHxwKQkkm1twHvhSmaeJaWglZowrBgY-PN2E2HLDVgd-bnf6BVH6SvNKAoqNFIdH6LiICT3os4etb9hsOW7VX_kCb3VmxOiPRyZCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepmhgrihhlsegsvgihvghrmhgrthhthhhirghsrdguvgdprhgtphhtthhopehphh
    hilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhs
    thhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoh
    epnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnvhhonhii
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilh
    drtghomhdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnh
    drkhhnohgslhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:awJlad2EAhN5rc7pr0HmJsklpHiJSKK7hE03YnMButcv1Y3LsqsIlA>
    <xmx:awJlacPxK6i0fhOLhIuY9PaZlty-R42BJP-ojejpetQb2RlnujvP1g>
    <xmx:awJladYvSNmvaQTIkwQa-FbCjxTOIngqj779pf3B-XHvLOiWJM8wCg>
    <xmx:awJlaawgaV6BvSnz4Yvcw7NjCyeqnBps9Dkpa9ndnLnRPA1abFryvQ>
    <xmx:awJlaVcXPI-PRiuHHucaiF5lmtiCyuFRZ5SPi4tCfbq28wK4WxOV-UPw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 09:17:13 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d9e82f20 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 14:17:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 12 Jan 2026 15:15:16 +0100
Subject: [PATCH v10 4/8] replay: support empty commit ranges
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-b4-pks-history-builtin-v10-4-e3c6aa5b4cec@pks.im>
References: <20260112-b4-pks-history-builtin-v10-0-e3c6aa5b4cec@pks.im>
In-Reply-To: <20260112-b4-pks-history-builtin-v10-0-e3c6aa5b4cec@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Matthias Beyer <mail@beyermatthias.de>
X-Mailer: b4 0.14.3

In a subsequent commit we're about to introduce a new user of the replay
subsystem. With that new user, the range of commits that we'll want to
replay will be identified implicitly via "HEAD". With such implicit
ranges it becomes likely that the range of revisions that we're asked to
replay becomes empty. This case does not make sense with git-replay(1),
but with the new command it will.

This case is not currently supported by `replay_revisions()` though
because we zero-initialize `struct merge_result`. This includes its
`.clean` member, which indicates whether the merge ran into a conflict
or not. But given that we don't have any revision to replay, we won't
ever perform any merge at all, and consequently that member will never
be set to `1`. We thus later think that there's been a merge conflict
and return an error from `replay_commits()`.

Address this issue by initializing the `.clean` member to `1`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 replay.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/replay.c b/replay.c
index 1e660171d2..a8e6d5b30b 100644
--- a/replay.c
+++ b/replay.c
@@ -266,7 +266,9 @@ int replay_revisions(struct rev_info *revs,
 	struct commit *commit;
 	struct commit *onto = NULL;
 	struct merge_options merge_opt;
-	struct merge_result result;
+	struct merge_result result = {
+		.clean = 1,
+	};
 	char *advance;
 	int ret;
 
@@ -282,7 +284,6 @@ int replay_revisions(struct rev_info *revs,
 	}
 
 	init_basic_merge_options(&merge_opt, revs->repo);
-	memset(&result, 0, sizeof(result));
 	merge_opt.show_rename_progress = 0;
 	last_commit = onto;
 	replayed_commits = kh_init_oid_map();

-- 
2.52.0.590.g1f87b77810.dirty

