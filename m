Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09702389DEA
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 09:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768298092; cv=none; b=LkRCs+2txTpvvasyGhm7xgLnmS+MW+O9G7LdhYhP7C/1WhcRMCz7NhXtqP0jbIh6GGrrBWA+npjteHOLwBVZSwJdETCmksrlfLwqvuSVEptb3biQrD1P2tnUnYNTVEz3OdnwTB6p+WuEw6xIqzCfQTD5FoQABspsicvwppFlciU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768298092; c=relaxed/simple;
	bh=N6ubMocBrugp6WmoixG2AYPq/RwJ52YwFZdCOmrqaDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UM/w0dwwqPP40rJ6tHYCXTWbNCgZB8P6JV1YdFyEYNhn0zfzS+dVjrVAYhbeFtBD+tRgxiITSKt9hq0j7euO4AkXw/mH1MMhZxHhZcjIpYeqUpEEvJD/6xX5Wb6QwsLmub085pCSyLPrzgjxU2wk3eI0rSgHPxuZOfzpYuvvEfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fGQAYE5J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mGA4an7/; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fGQAYE5J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mGA4an7/"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 33154140009D;
	Tue, 13 Jan 2026 04:54:50 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 13 Jan 2026 04:54:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768298090;
	 x=1768384490; bh=GEg3zcnQP09DwnmZf+kv0xOCurxScjXeFgQdJthvH1Q=; b=
	fGQAYE5J+9lcxuuGw1dFfxYHiKOmhoWAZZBn4Snysj4sHx4vAM37eXqD/J8yRbXr
	kxqwWH1feNkgQfptXRTugoh4Ncz6aC4CmNH/w/w7Pr4Jfd0kVwjY9ouHSKB967Ho
	VgwE7xHOwq/ugI+mNLKFjM8PUxaUzdk6VenkOjhiqJx1WUvdHnYA8c9aRDHGdGMm
	vGSk3u+rXjUV6QBle9VMqwQ2lhJpmX+37ndxS1B1urrJG+6emkritDfilD+ni/rF
	8vclnpeVeC64Zw2oyH2J/KwP1GuftaJ15gWVO9IcPa8don4jo8ISN+xgYTFR7iPa
	7OvuDd1p9sWNrM8Bt/F7Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768298090; x=
	1768384490; bh=GEg3zcnQP09DwnmZf+kv0xOCurxScjXeFgQdJthvH1Q=; b=m
	GA4an7/SaJ8Kh0UiUlZLnFnMIG+1uA9wGnxdkVvUw3Xjo0PSIPct58fKgzw5VCH5
	C4Mq+g8unF2QfC/v6rjlbpVGmCy2dwZL4rESVPYna7uwhz1BuopaorE+OrXJ/I25
	odniT4Jfd+aLonZ/9xydndUgkojdgqbgRMBe6xyjo2u3FB93uUk+COFMxkjrENZm
	JM3Eh4Qy4VO+hpdYkp11bA2NOV1qof53IOsVQc7bvSFVWc8iSXFoGyMsMECaa6GZ
	622m5VLuzqy5pBGghfDdt0cUOt9qAMqQN0JEiZZ7+dKB3Erh3sFWb2NQ5fvIJxAd
	rH5Kh0N9TroCNfRxeQg6A==
X-ME-Sender: <xms:ahZmaW0CnetonD8DiNMNfukLheEJbvZ9tuwD0mfXbHzPm2L5PjblYw>
    <xme:ahZmaU5hteEGjhvVehJD_GrVpg22jRpYYPssB95ooHHXYyTlA4HlB2Ant_BY5xAB1
    gDyyohnTWQI9ETb4qMAn6-vIDzA6eHneyVxAAIwGc8quAQEu6POrg>
X-ME-Received: <xmr:ahZmaaS73y9ub5v2lsCB1qx_VucWxpgB5PVVHFETJboV1JT6h95j4EWl7itw_GzTcj9LVGk0QuQBpqHnWom_Jdf5dkE2zukPcO_c-o1RCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddttddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsohhrgh
    grnhhovhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepnhgv
    fihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrihhlsegsvgihvghrmhgrth
    hthhhirghsrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ahZmaRV6tspIUOALfN4JZWRecIHAC5qCni2peq2ObNUEp7YBMkE4Kw>
    <xmx:ahZmaXFvR0mh2p2OeQ2N_2TAwY1_wCbvbcAA557proQ_3rRDD0je_w>
    <xmx:ahZmacfKtEbp84lfogp-JC7oy0tYB7Q4-w5lYvQKEMdT28KCO_2VTA>
    <xmx:ahZmaYouNtSnHz8bpMcMsn0rF1_lsskLpYRMapzuQDaxwqmrjj8iig>
    <xmx:ahZmad2_JmYjMDM6QwpqVkKeZhGTg2Tsrheazwm7HRnJKToMGVgoUIQw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 04:54:48 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b7ec06b1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Jan 2026 09:54:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 13 Jan 2026 10:54:35 +0100
Subject: [PATCH v11 4/8] replay: support empty commit ranges
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260113-b4-pks-history-builtin-v11-4-e74ebfa2652d@pks.im>
References: <20260113-b4-pks-history-builtin-v11-0-e74ebfa2652d@pks.im>
In-Reply-To: <20260113-b4-pks-history-builtin-v11-0-e74ebfa2652d@pks.im>
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
replay will be identified implicitly via a single commit, and will
include all descendants of that commit to any branch. If that commit has
no descendants (because it's the tip of some branch), then the range of
revisions that we're asked to replay becomes empty. This case does not
make sense with git-replay(1), but with the new command it will.

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
index ae13b59abc..6680d50bd7 100644
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

