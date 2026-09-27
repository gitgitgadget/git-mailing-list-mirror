Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFBF248880
	for <git@vger.kernel.org>; Sun, 27 Sep 2026 14:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790518365; cv=none; b=GZ0m0i3dfqPOMfl7yu0LLWHY59//Tw0cxaqk+n7qWVgReedt3J4KZ7hDtf+0f/UoYEzP+LFXH/ZOJ7g5IMedaKFDVM378pBfILwGsdBOfSO2Y7fISZWAmLccbTAhzNRas94MExYWyENbyEOJ6pDE4HctG72jeRDE91kD8e/8IJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790518365; c=relaxed/simple;
	bh=IhMwC9jlXFmtt0YF6nhiVmb0gwCdciB6c4u0KosluSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U5vwp80opZ/TWm/AsrAhe/+9yp+6qhoQx6mw48rUSlffbJ6XKqFuTxfxIeaDvg98cb6zHNjmv4K8NycJ3ma+BTZ/erhvZP0UG+ZJ6lYAiTUrZWwffoXKEoo6eL16wPT6Aw5yvVQk5LMbjR5J80heLWteWhvSEgy5j+jot/Ao1Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=bZCzqwpe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bznUtXfZ; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="bZCzqwpe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bznUtXfZ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 477DB1D00046;
	Sun, 27 Sep 2026 10:12:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 27 Sep 2026 10:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1790518362; x=1790604762; bh=UVxvFklC7guD03+/m28Pn
	i8fhSYpZ/pj0AmFUxnHtsI=; b=bZCzqwpesrapwnUE7BV+LnSqbLUNhXlCgY2xL
	N+zfsPpxTaknL9EitS9VwD3S2zadO5Kq7SzTLDhMl/xkqdD2YK66VyHVTLyVnUwA
	zFWLZEhZnr8GYRusC2Jf4H+Evcm24i9zyiZG1YjImAk8hbipf8J+HyrxN7U5cCBh
	Q1SRelgtOsW5hUHd21XcifQXUl75BE30fOQRFdRX5XVQMuW7T66iGUuOIcETPx1c
	uz7NwPqBg7oGyqxC27u3i6ND1vAbkyErN/m4yIV3RXpe/wQXWW75k9erIoqXpWmW
	ED0wG0LkkAU7d5BBdjV8niovG6YSujj7hFFjfXOOWboq8gGdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790518362; x=1790604762; bh=UVxvFklC7guD03+/m28Pni8fhSYpZ/pj0Am
	FUxnHtsI=; b=bznUtXfZFTCNyukgIKZHzWYyilkJ07kFNwNsC+pza7jCsIDK3SG
	W6HZSREtQ3qRFyj4nB5BI7nDYhGGZjHJq4POMYFFwknfwl3UCq14MDEudRdz3p+E
	YOo84u3MoJXhaZT93aTDoAeNYzpsg5RnvrI7lJQCQatHlUmjk3MCE2ErFWl3raom
	8/RnkzG148IHcA7p2ueVPbkhwp4wG+u4bPvPvjarO0Y7+K7cWV6ItuQ1f+PLFVXM
	HdsqFmsFs/3mR4MsQrfuruCwT/kTDn9Kf9z4tGKLh9DogbmUbHxNaWOTO5tpC2cN
	SMd+VptJhWL4kBcmZHRi/4vNsmaQVqZ8/PQ==
X-ME-Sender: <xms:WiS5asBMmCZ6pzKcUh0wfA1SbJhf8N9ciTGtdZu5AUj2YvNWTVpvnjI>
    <xme:WiS5al8lnzYrDAcNwIVPw-OZgJWytvqPcVmQhtsjQhoJkhxs9wev3hN7UeSrd1yaT
    BphXCJB1qjS3FIXxG247ad7aoIQCmDdojzM0ArekAQwq-aymH_3BV75>
X-ME-Received: <xmr:WiS5as9LaEcxkYfsInSfQ7do8tWJwZG069Zz-Se1W0GUh2DRJZUcYpVlh-5YlsqlibTgu4uVhARNzOhor4aupbq858HoKkIhVwUVLhByWU9BhzNjElwtXlw>
X-ME-Proxy-Cause: dmFkZTFnJwXwvLPvr8FoDRQqa11Q8j4o1ZbG4g52o/zxoFG4S7s3KxqzURGjO3CnTVEfKh
    uuTP/9feoeH5/USiAIK0IyZB82ovSK03mR8cwTaN0Tjfc90Nso/fwu3tCO4M1y/LdfIXPX
    9ffHGztU78c1RFhZhfLLGDcUOpWxwqWtTyFInpKNOsMAv4446ARXL6EwiYAM5qMYCb/4iO
    y+WqMGoYMnNM8P2pPocLWMFSb/KlJ8HgGNUFUlbwhWNS1I2BChFo9UwKAnMXiELLMrl0Uh
    3E1Q/pPzwekAEk8JHwH/aWUJ2Mm3nERjZNT9fdTyJTFI1Klygt8+7HyQfUolKuAaEn2rpH
    41DXI2P2XrL7UmSF/IV48TJwsQMwfbCjFNLwyiHpLtq9jIj5Kr8W3jLwRDB7hI7dm3IoRm
    caabTAQ+7RnCYJpN7h8VgsyYBgWcmDWToCTZRoalJFJ+ShGRb754YZB+S0TON9Deu+b9Ed
    2RlSLSHG2VWq9eUDMEXHwSZ6Uk/671q2gDhIupDkMUje/5PTlGKxxpTshuEwLKRcb12SUN
    AesA3g+p+XGt6yD/hq2pNfzs9ldLGMnTELrYVePRIUwsh1fXDoxHK9T/MD4eHHGq0ieCX/
    MNVa0KnQ2+GPO/YFfHZvUZLxpWbVz2Y3WVmcESax64naf3xiS/gW3cUCRyAg
X-ME-Proxy: <xmx:WiS5asfEIml8AYOV6MVY7M9etxSnqq7fc6HRSDpWpEacBMjb0KoBIQ>
    <xmx:WiS5alEObmTbMAPMdWT3fKh6J0W_i8vTk62SqdHpYqcARyzO3tGOiA>
    <xmx:WiS5aqdf9h62xK74ANrVAjOGOytsQr_-9dDtxqj55Pk9J02V7VMbmw>
    <xmx:WiS5avHNnfbhsQz3Ttj3t5SohOK9y3MpDKEczr9Uv60XxuyXCrTatA>
    <xmx:WiS5al-cbvrXcD-Yt8s1IIGAbF3zkwGWrS-r_O6MlQR-boYVLteiJrS9>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Sep 2026 10:12:40 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	ZheNing Hu <adlternative@gmail.com>
Subject: [PATCH] doc: interpret-trailers: fix cmd examples
Date: Sun, 27 Sep 2026 16:12:27 +0200
Message-ID: <doc_trailers_cmd_examples.ce1@m5gid.xyz>
X-Mailer: git-send-email 2.55.0.793.gc667de3f2c5
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Fix `trailer.<key-alias>.cmd` examples which have remained unchanged
since they were written in c364b7ef (trailer: add new .cmd config
option, 2021-05-03). (Modulo formatting changes.)

Use this example as a guide for how to phrase it:

    Configure a `see` trailer with a command to show the subject of a
    commit that is related, and show how it works:

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Topic name: kh/doc-trailers-cmd-examples

 Documentation/git-interpret-trailers.adoc | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index 77b4f63b05c..3e81632b252 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -305,9 +305,8 @@ subject
 Fix #42
 ------------
 
-* Configure a `help` trailer with a cmd use a script `glog-find-author`
-  which search specified author identity from git log in git repository
-  and show how it works:
+* Configure a `help` trailer with a command that searches for an author
+  identity and show how it works:
 +
 ------------
 $ cat ~/bin/glog-find-author
@@ -329,9 +328,8 @@ Helped-by: Junio C Hamano <gitster@pobox.com>
 Helped-by: Christian Couder <christian.couder@gmail.com>
 ------------
 
-* Configure a `ref` trailer with a cmd use a script `glog-grep`
-  to grep last relevant commit from git log in the git repository
-  and show how it works:
+* Configure a `ref` trailer with a command that searches for the last
+  relevant commit and show how it works:
 +
 ------------
 $ cat ~/bin/glog-grep

base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
2.55.0.793.gc667de3f2c5

