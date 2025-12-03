Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CC52F25E7
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 10:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764758930; cv=none; b=IpDskgfxM+0UwhQTuosbTYo08mZVRCBKvvyHhW4LCRY2j4Jnc6m4k5rWtEjV7fLyC7IPiADz3gyk4sBtWHz7SfdFPxVooyh+XOJ1UD/6IgyEfJOAj++s+fPuHYNYFmDTKlOIcBJG8SNrtkALfV/PKHXdes9UlH3WokAZ+QOK2KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764758930; c=relaxed/simple;
	bh=Qco2UBIPi8E5Mknfx+zSOeFj/iCETVtzFTy6lIatbRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JhjmndxTW2H/h3NFlZjPq1ojl7W0y7qDxXP/0Dvt2ZUr0s4Jqo/O3SLcyz7Y6hHbvQ4t7qThzVa9u162QJ2fws26NdOCOgroYEPPUaePPmcYhRhkUyiysqra2lFeex3XqsPavJCVpFMHWor+YGT2Vty/peLOBrsAKpH8dHnXzmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TgAOUXJt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AkmyqtcG; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TgAOUXJt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AkmyqtcG"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id DF107EC05E4;
	Wed,  3 Dec 2025 05:48:47 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 03 Dec 2025 05:48:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764758927;
	 x=1764845327; bh=KuCCU7VJR7+Rd+em8rtJPuXMsK86exscRWsTVGluhlY=; b=
	TgAOUXJt+8rSTOdlC9PqMICHtv4HTcGzw/OCNLPZD77Og4+XfbxaF4TJqAq7wtr2
	oxo0Rxd37krIuv9N6ZQsQEz2AtldKcN9DKNKcG1Sqbn1rkxd/JYZ99bPFYnxgqeG
	fp1LngS6DJ/Mou2boyE5DlpN1f07l+om9SB5QnV+zU49fiIgdcPTKXVpJA7WIuPj
	vGEi3qd9zFR65b0sfZ6NgF904I9JlaE3MrnX4UIY9syKaNzQlcSE+GrKabbSiiqu
	qaTm6sqY9zlB5J7hAb1SCP+gmciJzR21xMYeVjslgVLaCpobhidzEbGzOr67KQck
	sAWZtZv6xVTLPZmR8/sswQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764758927; x=
	1764845327; bh=KuCCU7VJR7+Rd+em8rtJPuXMsK86exscRWsTVGluhlY=; b=A
	kmyqtcG+LNyMlXJQi/bgP7k4B3AHEUL0PgkeanBCURhggzv4Hx1rDafPk3pNWkr4
	sFrZbAH0SwzjgCqN6acj1vtx+e2Xk63KTSg6vsfzEZZvKZ31TX1QRAG7AMoH/Mfh
	BbPnbywsJ3YXNq8+lqdT5ACqQ1Tl7gC69yv1j5lygHoHDm8/Dz/E+El00sLVNVsx
	hjbNeqkiSjpq7nihRrK5R3EuoE1KhRMv/n5oFmIX01PxDNDJ5XnrZ2YlbZ/4BMas
	o+ZaMtbdVI6UwPoU9iv5KAcXQln3Bx2Q6PpQntaeTtJgev9nTiYyC8VvU0HgbjFQ
	jAplADbQtOQl7ivo7UWGw==
X-ME-Sender: <xms:jxUwabFHbhYANf0u_LR3a3ggacxeCLmt1NCg-QSg81WmzIpMwHQIaA>
    <xme:jxUwaa5sPWkk9EZBGng2EhFHzhOt5erSA2DaSddrgBRgT9M2R6Zit5TpBCH-DbSce
    MV2XukHRwrpqKEPYZ1kiSvBFsYs2KH5MnPNyVwllU1_qtU-KQYQFg>
X-ME-Received: <xmr:jxUwaQxvUZod98h67jMbrFiQNTdr-ugZFGNDYcnv6FXovXbM5uWPPIIvck18XqZI0EyBrOv75_6bHlNoyjpZOM4XemyTFipCxmXTEsk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehmrghrthhinhhvohhnii
    esghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehsohhr
    ghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:jxUwaZPFDbP6uO7clS5J3IkNBtoTfPStrKDIE76qJkdwcoVnXXbnBQ>
    <xmx:jxUwaWlhY7snFeDjf9ni8GuivL_4rn-6ka43b9wGJg23QtN3n41log>
    <xmx:jxUwaeSFQv-MJxKGd8CVO4EDrHpadYC-uIM8AAeVJu3u8D9oAYkEGA>
    <xmx:jxUwaVXW1GJ1FFOG2HS2DA5hFmWOAYdJEYgBUyJagB0Wr-fMoFVCnQ>
    <xmx:jxUwaeyf1YJvs8iT5eowmzxU0YqnW3sBdS6goS5VcHR73Ps9etCR9FeD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Dec 2025 05:48:46 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4a9b6db2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Dec 2025 10:48:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 03 Dec 2025 11:48:30 +0100
Subject: [PATCH v7 03/12] replay: stop using `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-b4-pks-history-builtin-v7-3-9e9f849bfd0e@pks.im>
References: <20251203-b4-pks-history-builtin-v7-0-9e9f849bfd0e@pks.im>
In-Reply-To: <20251203-b4-pks-history-builtin-v7-0-9e9f849bfd0e@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

In `create_commit()` we're using `the_repository` even though we already
have a repository passed to use as an argument. Fix this.

Note that we still cannot get rid of `USE_THE_REPOSITORY_VARIABLE`. This
is because we use `DEFAULT_ABBREV and `get_commit_output_encoding()`,
both of which are stored as global variables that can be modified via
the Git configuration.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 replay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/replay.c b/replay.c
index fb906e9b51..13983dbc56 100644
--- a/replay.c
+++ b/replay.c
@@ -62,7 +62,7 @@ struct commit *replay_create_commit(struct repository *repo,
 	obj = parse_object(repo, &ret);
 
 out:
-	repo_unuse_commit_buffer(the_repository, based_on, message);
+	repo_unuse_commit_buffer(repo, based_on, message);
 	free_commit_extra_headers(extra);
 	free_commit_list(parents);
 	strbuf_release(&msg);

-- 
2.52.0.239.gd5f0c6e74e.dirty

