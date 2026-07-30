Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD703F12EC
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785405479; cv=none; b=N5kqsNhP78zQ0Bg7tVTF3ZCdL86xn/lIjTsxHxzHTwuysv7cvCgiTc/DKIA8oNJBuxA2MsyAQ4Jh1dN5MPDCR45f7ML9X2xzo53wnQLEnhpGwRJqaZuUCITcJ0fUwvwcnC2RhPZKFR+mWh37KQUrQShxDbLnBWPJV82kzV/lCwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785405479; c=relaxed/simple;
	bh=BkFGkKez8iHb/MusuO2AS4l4fIbjfWlhJnpTTSbUZhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DHv4qxDoxCIgpRwiEgd0xYiXSETZGtOZQh5GCDbj4O6QsaFNKR0mdD842XnLG/qY0VJBd04LUedPlxwJh3d8QY7zDdH0Qmt9jKUMLEli7bTqnY9DMWzPOJc2CBwZ6zKHTr8bkwNWfwQilwvq/q1oWp3M2+OkjacsPftStLdfbi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=JHMMpFrV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bnv+Hs41; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="JHMMpFrV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bnv+Hs41"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id ED7791D00100;
	Thu, 30 Jul 2026 05:57:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 30 Jul 2026 05:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1785405476; x=
	1785491876; bh=dqVTUHuM5NqzzXEhARYRIZwN7L3IqYN17j6YGL07Cx0=; b=J
	HMMpFrVQ3ccIgeEgqK/yoX5ZehOZGvhvjoaQAoe/r/xU+RrbCJWVuOY1OSnnTvbc
	Hq2izcju7YZ7e6VMhmYSl2ZnJcRLjmZ5ZuA6J59SMa4crKuLGmNCyBNvRnKEOEJF
	LfVLhkPHGGQAyNv8JQoz1ERptagqkrsfDq+e6lFuiH6Qrn60awqBg5FhT9UNx3LC
	3CHQv1YaD0dFOjQifIUyXqsw5Nz35obhcwNX7KPPNX4TSq2XFPVoMGhpZdMpB4db
	Hr0un+OLpfTtqPhx+RfQqPM5Czs4Pw0c7CnZHKfPrWMox2PjBh31Ox2bKwJT+/BH
	6Byl0pzwPPnghTjji21ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1785405476; x=1785491876; bh=d
	qVTUHuM5NqzzXEhARYRIZwN7L3IqYN17j6YGL07Cx0=; b=Bnv+Hs41C8ltx7rmw
	adPz5goCr+XRwQD3bHhBqj7Uih/6VixI3iajT3LKxRZ6nT5Bq8PcrFWIhLeExNPe
	HcZGzq5x4ixgsC8UX69b12alFYloFVq7kwY/hf6RuL08vgkhi0vxWJ8VltkK41aE
	yjjtyHTb2hPQ2wURUHVljTxjG6kOFoiYUB/9aqgwlCslVsdL+FmOdWpIzQS0WcZu
	b5qcdmZJ+667JsAqL+LxEA80CVdURsuLOmGnbOvU2O4eO4DiHn2UUVnSlxRx+5AO
	KsoxGj9JVDzVhfwFD2ThGlEAi2Rtz/f9vIgaG9jX0UvKldkSL/kO9ExY/xneLGLW
	+0wmA==
X-ME-Sender: <xms:JCBraoNHt1Lxv-rIYoGvouH_UVg1FKnoiMh71zQMENrbLgt8riZLvzs>
    <xme:JCBraipmfmD0HXcVZG3wkkbuqf_fE_luJdccyNTykHhCZ1B8BlrBuTMtRd46t_IZ_
    Nah5xquarrvxoeOWzNjmLJEHUAdAUTsd9ZesOsdFuFtudcEYO4n>
X-ME-Received: <xmr:JCBrapGWFomrw9eYfwVNdnMld6cOfF9DNG2j0-MZXj0pmuRwBN_KldiGFlzGB1zesq-s_cCzT8EYd5ZUVeU2dPQnHaUtEg6dPvu-svJBitaqUJFY0Zm9uyM>
X-ME-Proxy-Cause: dmFkZTGnmz8QIXcxc+OiTkMwXB5cjiJi3+F1K04IcHL92lc7Mluj59OWOGrLkvRl1LVma7
    2s8LJeZSVKV+/cSrVJyQ53wbCtNAQwhbdhtlGq0XLEFQKedXsgKcF8WvB1Azw6SU4SpO5c
    4jMVzJocoY9DOAVvg/C239GuxAX2KuBgy0q2shZwuieOPqJNOj6fXhFtLAS25vQAZzzgEE
    BoWsScwH+YkcffFabVSkMyNJCrRo4aNhwHBfVF16hbvb3fZuq4EioNhr/m/OG0XEGIxKKW
    Ak2kQpK0gHGwdChrAOFIuZhjAES/YV3W6p5X/VmW3tvJwlq7bJX3mM3+7u/ystECnbMKP8
    oJN5RIJnA07Kw4Gxi9k+OsREM/IHd1c4Elh0YB0fhyTah8UczVdhtw6fXUdTa1fBo7dDRv
    LkfT/3EiJQr7kLW98cjWPMTk5+p+fRQwqE39tnz7D9z8i0lDujIkK6y3E1J4Nh4rLop6PD
    1mmVIF3+Yyvpt02MgavJnrGMM+hmS0k+tycsSYun99e+CXuipr6Vg9u2qopIPDvqD0rquw
    V5JCJnBBqnLpG2X6C3RTBJ6kcEjbb4egDR6n4dUZ59td3WK9JyieYyMLTDufOIZvm91yMo
    PEu3Z3Hjccno+1LwbcBe2OuXjDNGoVjdyURJEGTQ8cCQXdtkDehWlEs5Zz1Q
X-ME-Proxy: <xmx:JCBranrRfRl_YP7uUTdRM63EOdHYYjYD5PgT0T1opaNblpfRPwzDVg>
    <xmx:JCBraiacszMK7nUtVMe9q8eOSitKFd6mZZmbDFBw2YRVtbaQjZGNTA>
    <xmx:JCBragW_-9foXq7M7VmtFpp3WR382iv7Xf1wFLEDeD0PKodmgrMQ3Q>
    <xmx:JCBrar9Jc6Dyp0tkBu1AW6JMolG9bQXUycI8X8RvVduuA0zRlkuwng>
    <xmx:JCBrapSTxbXFcivepbTe3K7r0Pe4qLjcMWJC9S_RT18BJOYi0u64hDXS>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 05:57:55 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Junio C Hamano <gitster@pobox.com>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Toon Claes <toon@iotcl.com>
Subject: [PATCH v4 1/4] doc: link to config for git-replay(1)
Date: Thu, 30 Jul 2026 11:57:13 +0200
Message-ID: <V4_doc_replay_link_config.af4@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V4_CV_doc_replay_config.af3@msgid.xyz>
References: <CV_doc_replay_config.709@msgid.xyz> <V4_CV_doc_replay_config.af3@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This config doc was added in 336ac90c (replay: add replay.refAction
config option, 2025-11-06) but never included anywhere. Include it in
git-replay(1) and git-config(1).

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/config.adoc     | 2 ++
 Documentation/git-replay.adoc | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/config.adoc b/Documentation/config.adoc
index 62eebe7c545..51fabecb9b0 100644
--- a/Documentation/config.adoc
+++ b/Documentation/config.adoc
@@ -511,6 +511,8 @@ include::config/remotes.adoc[]
 
 include::config/repack.adoc[]
 
+include::config/replay.adoc[]
+
 include::config/rerere.adoc[]
 
 include::config/revert.adoc[]
diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index a32f72aead3..f9ca2db2833 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -209,6 +209,10 @@ This replays the range `aabbcc..ddeeff` onto commit `112233` and updates
 `refs/heads/mybranch` to point at the result. This can be useful when you want
 to use bare commit IDs instead of branch names.
 
+CONFIGURATION
+-------------
+include::config/replay.adoc[]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
2.54.0.22.g9e26862b904

