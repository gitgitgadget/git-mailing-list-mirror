Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C8038D40E
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 16:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780502754; cv=none; b=W5aTSs9oOQ4wOpmBawGQbSmA48VtCGHQNkFOQ7V3PlliWWkw/Utk1q/yfVWgv9ENxT56ie6JCuiMWV7E5DuWlo7WfH8JO2+C9BKkOdpfLpjk+r2MVU/iGN++OzJoZyKxR4dbjbpucMYrCEQYXZ6ZFEuB/4a9vLppTP8/WFvkqw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780502754; c=relaxed/simple;
	bh=gqnqWksUTxbbkmgZ1A0L6yDRpZQYOEUxG04AXeNvA5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wn4Cjt978TaByvSR9WsmwobvcsymEFW/5B/nr7CyGgFEZVjojVOZzFM4ccfYDit+I7kwiIJQS6TeorLJso/aNiBL1c3oHpg/A9IMDMA51P7Y8ByjXcTFJX2NxEP7Q8CNPZ1dWB/y4E2kwR5OYdDHYrqtt6Tjd/LxJRO7Kgont9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=a2B431BV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AosGseac; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="a2B431BV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AosGseac"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4B87F7A0086;
	Wed,  3 Jun 2026 12:05:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 03 Jun 2026 12:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780502752;
	 x=1780589152; bh=9yXI5w98j3dTf/cEth9a2EdzEygqf69l/kmbx9QvRH8=; b=
	a2B431BVaNGqLJ5GyeHZ81wc3P6ZSW3m8PwUu27Ghhxepc5RzPi1PspsvRykzLsz
	pri+Pjyjbvq1joSpEq2Z92oo56DWZR2wjTUWViAjGBexaXbJZq2oIksD0ZhSuuDG
	k5ZdX+/IW89cqYWXm410wGeK2tGKapU7iArG8aDaSw+w/Y4VeCGDb3gWf9/b1dto
	2p7eI3iyekzxUAplYIL2X2Lfj5jiPqLZt8OifPBhpeJcEqtEOxReovTjYP49i4+k
	XyjGkeo/AZXghxFOmIRNHJlJiT1A/j8oQItmtQk925McrFcDUDoM8grJCZouYGbJ
	iJ4S8CQQRWiqEoKSrpzu7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780502752; x=
	1780589152; bh=9yXI5w98j3dTf/cEth9a2EdzEygqf69l/kmbx9QvRH8=; b=A
	osGseacK1crfj1tPUg1HwadB1r4bJTKxvdLKg20KM/2KqN+BnzjpptnaIrVwymW7
	5AgtWuz4JGvU0clTKgzKqt9H3w1rrcr/qI8kQEA+0EJdScU894BvWPQkT/Y/daEt
	zh5honTerASjT+aWqtuT9VS5uhp/9fvlKo1D5t1FhMvMMAD5X1w3mrtE9AdsX9bW
	UkdUXWxVOvXJFbLAewN1JXUvhPQrKEz1vy5eDhEyHujKaKZdglOOdMM39cCGupsB
	S1U4rVdn4waolAZkbMgxb4YJqesNo5DKNlpVpq0w7QXP9F7fsZ7ZyNMfjv7Ld/kx
	ZujiOJJERJ7McqXxrfEig==
X-ME-Sender: <xms:4FAgaoPzTBSREkVvT5kTuiCMTG5x712eOubWkBttAZJWdkYhGu8fNRw>
    <xme:4FAgal8hfkEna13f03kpG2LsdjAq92LWM2a-hKxxGDKC7BEazPS7mpXjoZ7UCXSlw
    7SJxRxDNuGJTS2DqeLxnA-yA6UqU9rfZGrrSfHZlxgvh_3Zo02njE4>
X-ME-Received: <xmr:4FAgakSdLciOJu7XAXABKg8nPan3hvAkEXAgQJYOzidyJQ-xIKwsJru-vOBY5FYcLDUxVxvTs6e8VJRdArt4BL9JKsxstjEbHjwUlkQ>
X-ME-Proxy-Cause: dmFkZTFBnHuhQocGhNR3wnteGW0eB7gMQ6zFxf8jocqy5zqVQXLKCvfdvnfGeFTu82Wybz
    SAtT5q2hFB3NpAesYJAeqNw7REUrj6oUruvF+ifl29kHCZ5rytRbLXeiLOyTd/MksV1nKK
    gRMxQl0HmIPlwbD56e3wczxxaD7BYTajM7eKmgjodPCjFjmqe2qgC56BNexz/M6ErsCVDg
    Yylx54sNG+Jes832AX8jIWqd1r36wKJ9oAffZpI5kk7OcC4Rmigf6sEgSoWHGv8pEodIhh
    amvoOutxoXvU9VVCyDwcWHG7p0tTE86OjQ053zpbJUkOGT4ozLXFyT6WAbXVO/gWTZ0RUV
    ZD/QFQiljizbR0hTTZTiCnWn8+iPzN+wTC++dFkYtIOrtI8oyUvB6WCtcKnaYgMtyTvmbs
    RV9YTVpE1XuGPnxAkEhruzi3mpSoQSnH7OgQ88Dwh3MRMfZEcLIco81xZ//2VVLEqk4A0X
    botCnUe+FgEF99RJaPT0OOTQJxcCAE09wWBZxXKvqeQqAjylBY82BHJZciOs+qVhGJk+1C
    Xtno4Tctp3T+dGY6xvRaDviT8R+mpzCGQCfY8U7flYIHqQMd6EQjQTqIlP11kEFaSTTEz2
    5YIFcPtzmbFokXKRV0RfIEXl7FhHmxavDifNPIoqU76fuwuAdhIvFzWxhHzA
X-ME-Proxy: <xmx:4FAgavkbhwIhuV6rDnizO6y7p8lWILh7m1VvCWkeWAzlKHzoRCkJJA>
    <xmx:4FAgasTUddsSPCu5f73vnGx9q5zJVkAmYkUAnujooSPgZjECZ5laCQ>
    <xmx:4FAgalP9mbkhSWU0A4qiC9YH162NSzaFk5ulrFlhaI_2t0J1lE97Eg>
    <xmx:4FAgatWBmGq6Fx5YDJMY7o1XNDl3Vqhr7IMFSQPZHeRUkGlRL3NgQg>
    <xmx:4FAganyAPBnQSw1CKSYzUJsVbgiOuDR9inQg0bcWfS8STx2P80UU0Pqv>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 12:05:50 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH v2 4/4] =?UTF-8?q?doc:=20replay:=20move=20=E2=80=9Cdefault?= =?UTF-8?q?=E2=80=9D=20to=20the=20right-hand=20side?=
Date: Wed,  3 Jun 2026 18:04:25 +0200
Message-ID: <V2_default_RHS.76b@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V2_CV_doc_replay_config.767@msgid.xyz>
References: <CV_doc_replay_config.709@msgid.xyz> <V2_CV_doc_replay_config.767@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This is now a description list (see previous commit) and parentheticals
like this do not go on the left-hand side. Moving it to the other side
makes it stand out just as much and is also more consistent with the
rest of the documentation.

Let’s also do the same for the `replay.refAction` description list.
That makes the two desc. lists identical in the first sentence. Let’s
add a comment about that for future editors.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • It’s “description list”, not “definition list”
      • (Same mistake I have done for “line continuation” (it’s “list”))
    • It’s e.g. “right-hand side” (drop “-side” hyphen)
    • Change `replay.refAction` “default” placement
    • Now that these two description lists are so similar, add an
      AsciiDoc comment about it for future editors. Note that I
      outright deleted this list in the previous version because I
      didn’t want to keep them in synch. But we can remain aware of
      these with two comments.
    
    ---
    
    v1:
    > do not go on the left-hand-side.
    
    At least I haven’t seen it.

 Documentation/config/replay.adoc | 5 ++++-
 Documentation/git-replay.adoc    | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/replay.adoc b/Documentation/config/replay.adoc
index 7328da9537d..40d1695782a 100644
--- a/Documentation/config/replay.adoc
+++ b/Documentation/config/replay.adoc
@@ -3,7 +3,10 @@ replay.refAction::
 	The value can be:
 +
 --
-`update`;; Update refs directly using an atomic transaction (default behavior).
+////
+These use the first sentences from the description list in git-replay(1).
+////
+`update`;; (default) Update refs directly using an atomic transaction.
 `print`;; Output update-ref commands for pipeline use.
 --
 +
diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index b4fe43ec687..ea4d14baddb 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -80,7 +80,10 @@ incompatible with `--contained` (which is a modifier for `--onto` only).
 	Control how references are updated. The mode can be:
 +
 --
-`update` (default);; Update refs directly using an atomic transaction.
+////
+Expanded description list compared to 'replay.refAction'.
+////
+`update`;; (default) Update refs directly using an atomic transaction.
 	All refs are updated or none are (all-or-nothing behavior).
 `print`;; Output update-ref commands for pipeline use. This is the
 	traditional behavior where output can be piped to `git update-ref --stdin`.
-- 
2.54.0.22.g9e26862b904

