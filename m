Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD16F328241
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767780630; cv=none; b=rBVx2ZzGkC/6HgZC+Ph1/lI2aBpJfjfiaSklX3rf94QfLK/oEE/wPUjn3Q/MwB4pJHyx7FipyWf5MVrws7Leg6Ku+WRzLsRTWUF2WtQfvW70PuACS57f3aCY826QYxJRgYj6sE4JIyZVICAXmjXnpAoyZYLJYNUn6GvpXNoCTfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767780630; c=relaxed/simple;
	bh=Dx8X0UxRR8yC/YVk8c6Cm/v5Y0n7zZ99m6+mCiaCuDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LwefSHkIUgVR2WrR3BNoUZQ6+qJtot5v+0MglnhgWcpBmu9wbH6y1w9+uASMxxw2+Edik0Q6+hr4fVW46fuV37SLbHWoYyhgpBJPcaPYIW7vHE+aqNOJ+9Hn6BF9R/la1DnNCS21aKOqq9QDzHRTUumhzb1dGXQNqd/2DNOpj3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Qfjm0Jm4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h8bEY1Z7; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Qfjm0Jm4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h8bEY1Z7"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0DF3C140016A;
	Wed,  7 Jan 2026 05:10:28 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 07 Jan 2026 05:10:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767780628;
	 x=1767867028; bh=QhCpNk3amIOsE8TZeoyYV7qAdg24pdvjNyL/H/jfo0I=; b=
	Qfjm0Jm4MDNWD/nCC6YVgb+94bCAxBvHjg/d80G3h1Fqe8NkCX3/Pnt2myKwP7v3
	gZumqMOJ2S0n8Z1Ikms4ftbQJO+sdoeMvdNBP/Z4a1KmDZbB+cKoRGx6XuWQUNX5
	MqESZXp5nT3tfJvd/JMVMDUMSs8uPIvVZRSGvnqZGlfba13VI0p5FrykYuzd70gE
	DZl5C8QC5Jt4qISyQAivOwYxIo23jxvHkQ3m+SDG89s3NPTEpaiivBUqw+3oEyY3
	mtHYgwtSAPIUvX3kVn02h/ExMeQCjFge+K3bBm1Zv99OuySY8olzraAjrkvxkSmg
	2VHIC7VH5EmXpJfRT91v8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767780628; x=
	1767867028; bh=QhCpNk3amIOsE8TZeoyYV7qAdg24pdvjNyL/H/jfo0I=; b=h
	8bEY1Z7VaKE55Nx/qZ5s8oy/iPOgLF8/axutsjeG0uyGXC6EWf5Ps6kKqmcUhNSC
	FO+K222512NTT8xWrxOQ4C+tiOJ36TNWnvVsZZVjHXDm1oKaB5hRiX4z+2YIU+Ao
	OtYDggz3lsm6PSJ9vkjsyAPu+cRCc6qAIa0jnmZ2e0h9AxaXrY7zlS3/35a8+OCy
	7pDt1ETqHYvSa8N0GvwJszY7lZBe1dudVMAymn8UrvZAjGo0iTHgwY+k7HFbPOOp
	Ui9Qy05b7mIapskEJZEOSObFJpyqK+QpjW+HSr+ERZKrzQfIC58eXA6Og3mISG0x
	LE+rCP1Kc6qm9BvttAwcA==
X-ME-Sender: <xms:EzFeacb9bQkLp5FxjOMPUwDFv54hFTv7bhHAW01ul-zTFHBAKXCOVg>
    <xme:EzFeaTNcjjlBDlZc9cUUChhUVRLLB_K5kf98fYGcE6XK8rcX3R5AbrjdkW2v7n8Lv
    oY7CIpS0uGShkdeAjD3-K3wIAHJOxPytBkj1JIFYecvCz8OdUW9>
X-ME-Received: <xmr:EzFeaSVNyGms4S490yEHWYFIm33y4t4mepF6fI93KDgfZs4dbZQS6oEWB8cdkjajXjnaLJjf-IP-y7VtdZLT2qqZQ4A1bJsNLkCNq8qXeWs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddvjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehmrg
    hrthhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehjnhdrrghvihhlrges
    fhhrvggvrdhfrhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshii
    vgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhorhhgrghnohhvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrihhlsegsvgihvghrmhgrthhthhhirghs
    rdguvgdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsth
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:EzFeaQJUYmbr-U9bd8MRA68Achu8JE2HsVSTepLsqKjcsmYtqMjH5w>
    <xmx:FDFeaVonumPfF30Uwl5oLBQNvOJZriJFXaHSIaWXSXrMpfN8tGPu-Q>
    <xmx:FDFeafxulDMIzGVIzLOywW2Ixrb_QxcaNGz3T-2tkqo_MrU7dC7g6A>
    <xmx:FDFeaRu30vM-JJunwHiezdU0xulNzwn_YH7n3vsPUSEYUGF4iOPCdg>
    <xmx:FDFeaWYVPRy5QhOh-iD9ddIMGOwh30aks3GO6h9ohFetW0-A19v29UjI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jan 2026 05:10:26 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 21f7655f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Jan 2026 10:10:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 07 Jan 2026 11:10:12 +0100
Subject: [PATCH v8 4/7] replay: yield the object ID of the final rewritten
 commit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-b4-pks-history-builtin-v8-4-18e9779e3a26@pks.im>
References: <20260107-b4-pks-history-builtin-v8-0-18e9779e3a26@pks.im>
In-Reply-To: <20260107-b4-pks-history-builtin-v8-0-18e9779e3a26@pks.im>
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

In a subsequent commit we'll introduce a new git-history(1) command that
uses the replay machinery to rewrite commits. One of its supported modes
will only want to update the "HEAD" reference, but that is not currently
supported by the replay machinery.

Allow implementing this use case by exposing a `final_oid` field for the
reference updates. This field will be set to the last commit that was
rewritten, which is sufficient information for us to implement this mode
in git-history(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 replay.c |  2 ++
 replay.h | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/replay.c b/replay.c
index 367951395a..8c2f2d3710 100644
--- a/replay.c
+++ b/replay.c
@@ -330,6 +330,8 @@ int replay_revisions(struct repository *repo, struct rev_info *revs,
 		updates->nr++;
 	}
 
+	updates->final_oid = last_commit->object.oid;
+
 	ret = 0;
 
 out:
diff --git a/replay.h b/replay.h
index bc7a321a5e..e00bb4214e 100644
--- a/replay.h
+++ b/replay.h
@@ -43,6 +43,22 @@ struct replay_ref_updates {
 		struct object_id new_oid;
 	} *items;
 	size_t nr, alloc;
+
+	/*
+	 * The final object ID that was rewritten. Note that this field has
+	 * somewhat special semantics and may or may not be what you want:
+	 *
+	 *   - If no commits were rewritten it will remain uninitialized.
+	 *
+	 *   - If a thicket of branches is rewritten it is undefined in which
+	 *     order those branches will be rewritten, and thus the final object
+	 *     ID may point to a different commit than you'd expect.
+	 *
+	 * That being said, this field can still be useful when you know that
+	 * you only replay a single strand of commits. In that case, the final
+	 * commit will point to the tip of the rewritten strand of commits.
+	 */
+	struct object_id final_oid;
 };
 
 void replay_ref_updates_release(struct replay_ref_updates *updates);

-- 
2.52.0.542.g9473a8513b.dirty

