Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015F42ECE93
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780667855; cv=none; b=pXnDgENpm1AC1H9/AZaR0gOm6BTuGjPue0sHlDINYVTOXEX0EedMn5YFZOCStTkOqFGMaEsDV2IKAY73y4ewEM+ue9yybLFHNjeTAgniqGtWFQdqLsWe0Lkt/EhyaSTuJCYPs1dG0+mbgeK8CpdzKLPmHrIGv7T3M1pZirGkU/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780667855; c=relaxed/simple;
	bh=gqnqWksUTxbbkmgZ1A0L6yDRpZQYOEUxG04AXeNvA5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B3oNlmztfvmiBP1QuujhOLpshiROCDsVDsjx1oPd+0ze1FrS7QsaGSzNWWzHQNl0gosfCBNfvWTcfkC0raYqJeCEQ/CwwF5g+rfqo2dUCae725nO3MuVP0Jp9JiH5q6NsLwU6sSTLqwzUy/kAWbbHTyD/zGhPR4EoLM1kWrEAGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=FDVvIKWm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GPjzfzLF; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="FDVvIKWm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GPjzfzLF"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 38442140011F;
	Fri,  5 Jun 2026 09:57:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 05 Jun 2026 09:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780667853;
	 x=1780754253; bh=9yXI5w98j3dTf/cEth9a2EdzEygqf69l/kmbx9QvRH8=; b=
	FDVvIKWmhD4/CTr9EUzQMQGVlX5mxMcjWSJIdOgtKfqb5fF3yUx9zeR0Q994OZyV
	jXDEKmsuWJnN7IyTmZ40a+Y/El27Nn9a7tq9A6XRvJf/gwNwjWPIK3Tzt4r9fwES
	Ucb1dUS/CwK4J3Rpg6o57P2czK+esOW4exuCMeMhGh9RCp83rS5crAtbI3UBeKAn
	dxb/kMKL3gI3Y3TKZq1MozlxswJ15OCUHZBghwmKnruRe4NN0Oz42jmSDsb4muW/
	zlkZS/Q/7yNGLns8kblgQVMKPKZEKrlztBUczF0OVJV0h52/I3KlXqDFPs7LxEDy
	1x61mxqNwduyTWpi+yYkCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780667853; x=
	1780754253; bh=9yXI5w98j3dTf/cEth9a2EdzEygqf69l/kmbx9QvRH8=; b=G
	PjzfzLFy34bKUC7/eHSLmiyYOSpvhJjjqXpGe9hxwvWKOUZ/X3ERxbKRtHyeIVbI
	PAKFqwx1DRiiUBNr7ayKN7fsPeY9W7RfVNdm4CzeqT/1xSdJcbi3OfGYel6nzv/K
	atl8eB+4TpbCMryPvDGROpQryldwhjrHYfk0O8C/ghqLdF0u9Jvll47zDr0M+3Ke
	sdVacMJtv7Wu7phd6B/LCV4s/S+6arqQyipcj4cFTJTG2SCogO910SlXj5inaWkh
	n9D+63al/5bUGmTUTwg6YBLwclDdqRKtpg8k3Cchc0EWMNuVbHW1ZOn+HZ3adkWy
	JrRAJ7HmV4HPaWKQCM6bw==
X-ME-Sender: <xms:zdUiarEdClM3Hdh_bXGSWCwwWbSRY99XJSZDd5RLyIDNDMyLVYd_hn8>
    <xme:zdUiavOQVGrVq1COnenuvaikTjvnqLheB00Z0l06O7pzVeFE-bgrQvEQzmMBLwdtJ
    cqU9Vl-Bq6T1PV1eTyTXictx7bmI8E3YZj7WgfLOLtBES5RtnzQYC0>
X-ME-Received: <xmr:zdUialecUj1AV6sYfAR8brKy0WyePv338HiInYdB-wNVB-yNArYVzuWeRoFfb-DbjeNKC2ku5J-uR8XzpFQYNBPEU2Gq0QFOQhPNhCs>
X-ME-Proxy-Cause: dmFkZTEshTDB0xHp2F/Uq366/w5rJjOI6K/MSiArZyQ776hH8HQuBnE8eGT1XosVjEiTY0
    AiDyhWWgcaToJHp0jIVFiI3F7ZqdvH4x26UsKue1/KAAjMT5WKDq7sVOUS8/Z8elTCGSwY
    EDQ0SOxQkhavbUwjS7NYzr5JolA4hraiYGV2fd/kKoQ1JHYkt/duWvSFP3yzTBmSS+GLWP
    LMNy5w1Tg2On0SvtmjZWUtVJZ6JM5yn+/FGO1iSPS9hoBIE7HTFxBf/+sBdjBvhwzx/S5T
    GaL0n45+/JqlMZUBOe8xSp07imubQwj3TANMg+fPiiHxLg9AjNw/AgdKZAepbw3EbcxNAh
    kq1xaF136rXtOvPGWdExqtgnrMWcBy+k/qjHfD/Ph4vCgtst12icglUOWnFB0xzdNzuCy8
    P4kgbA0c1C1ZS2kht5TEA2OrY8DqTfWlhBYsIwa4uf5e5C5ugga30s4YaSXRH7MPUNvl7c
    1YpQxAmMdJWoDoesynAoObsCzL8rhj9dMeT583chBNIT1WI1bHwzPRQ4hiHv1XzCAF4/9V
    I1NUqi8m9QCXYMRazLui1oKnsxwX/kCXTjmqrypn8MIdrq+gw+ThCB4a57ltdDANa3GUHL
    Q5RlVSZ4UPjA+DzPBlTQ60zSyAptkOKgST42Gt95ShuMeLk7mmT5qfDd2e0g
X-ME-Proxy: <xmx:zdUiakvld2zoBTbN68JZySwaFje0h_0iABQNVSzG4y9r53oVD4zMFg>
    <xmx:zdUiaum_R4cR0nLPffzbMCbftCuQszhenHLshw6n0tH-pVbqwyIveQ>
    <xmx:zdUiauxlwAwSxLikOC7yf7BkPQ4wtFAF09ZAOYVtmCvME59B9K_-Dg>
    <xmx:zdUiaoO1Rj07Mq2J5QunV9kVW-MUhKJoUkCBmuASX5L7i8ygJDs67g>
    <xmx:zdUiaj-zQoyo5W8uwPc3KosZ6qKxjr0Qq31ohCmu1N9dl0RWmvE_gK_M>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 09:57:31 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 4/4] =?UTF-8?q?doc:=20replay:=20move=20=E2=80=9Cdefault?= =?UTF-8?q?=E2=80=9D=20to=20the=20right-hand=20side?=
Date: Fri,  5 Jun 2026 15:56:02 +0200
Message-ID: <V3_default_RHS.784@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V3_CV_doc_replay_config.780@msgid.xyz>
References: <V2_CV_doc_replay_config.767@msgid.xyz> <V3_CV_doc_replay_config.780@msgid.xyz>
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

