Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E8E3B38BA
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 09:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073777; cv=none; b=Gm5nhZqV00ZX2ltqXLyzp9mrB6rhNeee4Vnpirvlwl44LPrCHRwEFhyYzekf/8o8Owqyiv2d/lejWEXOkUE6uMxf82RTOs3U5nS34Mds88jJ6SkNuiGl87ruxoR15rD7jCEJN6RBA174Zg9pWOYvZ8vexxRGWqu//UAjOgMr5c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073777; c=relaxed/simple;
	bh=qCwlpYg30/8VxdunmmyIr29C9vHUcWYaQ/icpilo9V4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RRcWkEZ+vwBYpq0OWnon1eLa6L8y/jdKDJ1FOvin3XruD2cxXbEsLdOXXW0wgb3gEI4xoH3bLxaiGPF7lchDBmpRFaAUhxbC78WLGOrQDFImUVtOf0SGJmz2/TIwFGP1hun/FrPoPHARLMZ/z5HDT2b4VSUO1wJk7U+/8bwMFH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X0dvUhJI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TWrBU6g8; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X0dvUhJI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TWrBU6g8"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8D54A140018D;
	Mon, 13 Apr 2026 05:49:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 13 Apr 2026 05:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776073775;
	 x=1776160175; bh=P3T+tXpVTuDXl9ei4Kv9oFqv8P+RPRDU12Rp6Kik1JM=; b=
	X0dvUhJIStuzIbxA1T+pI4FtZe3ewTLkecf8hxkxgFNx8JyPPi15hW6hrAWfii3T
	mMabQMvAfvNDPo6DrGjtx+dDpiDX7cQpKzYtrjp0yU4us+WoawtrUSbUoShK9H9P
	7f92be50WmpePWGaMC2umT+6/szz/PAFf1cN0y5mKug6G7MydyTwXtjRZIakvDL0
	xbWdzZ1FFYEUhKyrluQIeCXptIXnrFga6G7q+ClLBOIONbcbmmbf/pLZh+p41+/q
	sORpvXL1g1ElSKI8tkehIX8Ix3y49ViwF2O6huLCaY/nuGxjPnyiRc9Sb6bPeuZI
	VbrDN8aqhSekb6gfi6i/mQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776073775; x=
	1776160175; bh=P3T+tXpVTuDXl9ei4Kv9oFqv8P+RPRDU12Rp6Kik1JM=; b=T
	WrBU6g8yoHG2RtVoRoTa4H1OirSyhGkLrdgq3ygYMxMShjyWi8StzehPMTDBtHlw
	kBMl+OE8Y1zy2LXZCqcdXkuIOA+d8MlOJXMN5+PVC3DU4YRn+X0AB7EnJHmeRO+0
	u68oqo/yVYdld/3Mp5Vg7aDIetMHLritzM+TkGOoc45TgCnPZk+bjUh7Z48YViQw
	5GHH08EUcZQcfYCXSBz4Qs72IB2k1uDThXEJtKA7omzpGYRCcOK5+w09uoR/mYaE
	POrM/K3hHvGatuIX9tVjlMugK0VKe935C+WHczG3q9kS+3PcEAcfbUOKHZ1SSUeA
	wlTWP4wgrh8LcBBh6CR3w==
X-ME-Sender: <xms:L7zcaboTqQyCQNZoRJWr0BZ_QTa7-duIrQsCfiz6NnOE78lL3qkz-g>
    <xme:L7zcabohwp-GDPx2Sr4-z-AAwd0UaEunfQscJbkLUagOoxwoyP5YJ1BWs-K82ccKa
    QF0AGDbuhBJHwCZEXbLQu-K2N66nmnmwx0iVIt74grX92h3nwCWLA>
X-ME-Received: <xmr:L7zcaV1utgfee2KG7TDSymkLHz7cuW6ZeLo3MkUwH9-RTP6Kif1VaPimUSZ-vGrJCqlMbDeZZxpcZekJPx0KhmEa8Gu3LUopsvkdhG-zGPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefjeeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:L7zcaaDUarvaFWCthgUFv2RCurS3fd7OLY_IwPRolPYb-FAFmjo3ig>
    <xmx:L7zcadfFynQQPixmDjMKp9Tpt9JtaPRarAqcILZIXRjzngw-x967Pw>
    <xmx:L7zcafhR4VltYLxOMKTUpKiyHde8ajXCzPZGubNRDJE7uF1CNeTJ8A>
    <xmx:L7zcaVppyTDz6TNGNABDgZOCzrIpegxczKC0Qg3JKwAvll1bpD_2_w>
    <xmx:L7zcafCGREQBXupbublqmfCJSeVdHV5OHIMgg63YBnwxTSn9iI9aogW3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 05:49:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8b46da3a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Apr 2026 09:49:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Apr 2026 11:49:24 +0200
Subject: [PATCH 03/12] t: prepare `stop_git_daemon ()` for `set -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-b4-pks-tests-with-set-e-v1-3-5b83763a0e84@pks.im>
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
In-Reply-To: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.1

We have a couple of calls to `stop_git_daemon ()` outside of specific
test cases that will kill a backgrounded git-daemon(1) process and
expect the process with a specific error code. While these function
calls do end up killing git-daemon(1), the error handling we have in
those contexts is basically ineffective. So while we expect the process
to exit with a specific error code, we will just continue with any error
in case it doesn't.

This will change once we enable `set -e` in a subsequent commit. There's
two issues though that will make this _always_ fail:

  - Our call to `wait` is expected to fail, but because it's not part of
    a condition it will cause us to bail out immediately with `set -e`.

  - We try to kill git-daemon(1) a second time via the pidfile. We can
    generally expect that this is the same PID though as we had in the
    "GIT_DAEMON_PID" environment variable, and thus it's more likely
    than not that we have already killed it, and the call to kill will
    fail.

Prepare for this change by making the call to `wait` part of a condition
and by silencing failures of the second call to `kill`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/lib-git-daemon.sh | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index e62569222b..91bcdd0bf7 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -85,14 +85,21 @@ stop_git_daemon() {
 
 	# kill git-daemon child of git
 	say >&3 "Stopping git daemon ..."
+
 	kill "$GIT_DAEMON_PID"
-	wait "$GIT_DAEMON_PID" >&3 2>&4
-	ret=$?
+	if wait "$GIT_DAEMON_PID" >&3 2>&4
+	then
+		ret=0
+	else
+		ret=$?
+	fi
+
 	if ! test_match_signal 15 $ret
 	then
 		error "git daemon exited with status: $ret"
 	fi
-	kill "$(cat "$GIT_DAEMON_PIDFILE")" 2>/dev/null
+
+	kill "$(cat "$GIT_DAEMON_PIDFILE")" 2>/dev/null || :
 	GIT_DAEMON_PID=
 	rm -f git_daemon_output "$GIT_DAEMON_PIDFILE"
 }

-- 
2.54.0.rc0.707.g0fbf48f4d6.dirty

