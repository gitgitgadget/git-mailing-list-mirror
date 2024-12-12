Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30822181B8F
	for <git@vger.kernel.org>; Thu, 12 Dec 2024 06:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733986062; cv=none; b=MuUUMlMDZvpzQfscgAIzWu5nTYd2HqrWa0IwKcmFxE9t7lpAHYwbabzy9AzpOUuW6rwFxsGakh8exXAAem45hQinlPcvbaq/2ItbEl2JY+M40jEIaYNrwZoZL/6JRgFN1HnS46CTlpsDOtNglXUPfCrrskCUMVqJHXxEbUnyjEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733986062; c=relaxed/simple;
	bh=iepnD6c0NlBrD/LuEoP8J3lXrzLO/j2QBhCmOwHhtVU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aEhIZ534IkvI4N7AbTCX2xH2kSbFCwD1lSEIgkd+HTUscoCqvNzEW8Pe9VIL78P6N2c7NXjDo1FdTGJyfLV5murE0tmnWbu5T4pAe6QZmMphd9aW3fIT4fJqO0c9p3zSPMkMG/k1A0rH0GOx0cJQ65rQTzDLasfSS/ZfbNPIVW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e4ybURAk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LhNxif4j; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e4ybURAk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LhNxif4j"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 26F641140173;
	Thu, 12 Dec 2024 01:47:38 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 12 Dec 2024 01:47:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733986058;
	 x=1734072458; bh=uabs0UdoJGVls4d5+ll2f3Cb972T+SboaXhMfUQ0MzE=; b=
	e4ybURAkcJwZhkhHFz7dy+NiMpmFZEqQ96w7vpYggRk0/vmK+APXx6HRlEc+28Ro
	fb7X6vMhoi23JsjuRB1O3I3ZQinc2asRsFVC6gzVaeBZpC4pOSjytvkDGfRfDQvU
	W9MW3hXGXlV9ZiSOhqV5qGxtk2bNLZ0FYNLIc1H10eHCc8jXpyrJCqzbyxdXsSw5
	Bmtxf1iONIRsY+WHgQyelghpddRTWKBOux292MMCtR8lAc2oXkr+ltCI+2ZhNUCn
	aTOXfjY7ocukM9A9XsGCVwhtIFBzdipoPoFBM90KbkjOD4O0Yj7ohcpWacQ496tq
	lrf2ekzA5PBRAH1uPTYPsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733986058; x=
	1734072458; bh=uabs0UdoJGVls4d5+ll2f3Cb972T+SboaXhMfUQ0MzE=; b=L
	hNxif4j5XvXra5QGW+AGhJX6IvyibtY4YSMnuUtlL+wosh+vuQyVLGkfR7SMrWcm
	M3ZLPbWwAQrNeV3nEQPXF0Bu56dE73lYn6xV/ltydQuKA9jF45bJ3WFkMAAsJYaI
	NkTXzClqpofS/0IHjh1D5TNzB2y+evkmfi2TaJGFFMhMUHZ2ts6dJkp6+ej4a91L
	S0e7sqcE1KLI4ujKYuTfg1kUeDdCRp39ZiCPj2ueOcqPwNOoaSvefkEbTBPGWJL0
	vTeyFyVT+9w6RgTJ6am6YVYFmwjOF2+iqLq8oJPKQGbnYGTiKwjxm5+PSGxRf6Vb
	Gi+lJ1jYXBd1VGaX+qOUg==
X-ME-Sender: <xms:CYdaZ2L9eiN-H-XBg6svQJ7mXkZu3mhwYEhbg00sPGpDUVeUzitZzQ>
    <xme:CYdaZ-IKUnUbh4uGl3z_E3A_hUZTBR7v4cGyYo1_rtOQS1paIt4XV5Rt_VTK5HOyN
    I65E2zpU884g-oZ6A>
X-ME-Received: <xmr:CYdaZ2sGbqV_SJ5SHcGjqlz1sh1EovNun-fpEg2qZ6-qzfEdQ57m-ts3nW8_wF5p4rlZfMf83zJQwJREk0kzvA01lB6ai9qQWoW5gQtoGa6MX_Lx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeeggddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhsfigrlhgurdgsuhguuggvnh
    hhrghgvghnsehgmhigrdguvg
X-ME-Proxy: <xmx:CodaZ7ZJJEO2BoNGzBFxt-b_CgbwYqpKNWGgU-EVJYqp99uIg_UHXA>
    <xmx:CodaZ9aquDSYiNc_D1DjcSnduVLgdybR6y0zl-8TzfqO-YJyP0fw3Q>
    <xmx:CodaZ3CdS-7Gy5OXuyU6n8vhb6nF-nqvdm7XaoLSaWZPGvOGyxbCEw>
    <xmx:CodaZzY6ghuICCdzGQ02FJbatN3eqG5kfQwFkrsd6x_3MfFTWQZMmw>
    <xmx:CodaZ8WZsLbePT5Q6WAoGKq3f_J9V7_GjhdZ7TpxUH0pgRe8mFnPm2Lj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Dec 2024 01:47:37 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a5691f2d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Dec 2024 06:45:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 12 Dec 2024 07:47:17 +0100
Subject: [PATCH v3 4/4] ci/lib: fix "CI setup" sections with GitLab CI
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-pks-ci-section-fixes-v3-4-d9fe6baee21e@pks.im>
References: <20241212-pks-ci-section-fixes-v3-0-d9fe6baee21e@pks.im>
In-Reply-To: <20241212-pks-ci-section-fixes-v3-0-d9fe6baee21e@pks.im>
To: git@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, 
 karthik nayak <karthik.188@gmail.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

Whenever we source "ci/lib.sh" we wrap the directives in a separate
group so that they can easily be collapsed in the web UI. And as we
source the script multiple times during a single CI run we thus end up
with the same section name reused multiple times, as well.

This is broken on GitLab CI though, where reusing the same group name is
not supported. The consequence is that only the last of these sections
can be collapsed.

Fix this issue by including the name of the sourcing script in the
group's name.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index d403ada911722af554df6255e5cd3fa01b56fd22..5440eb6dc02784c03a5e4919f97dd7f07881f5c7 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -57,7 +57,7 @@ group () {
 	return $res
 }
 
-begin_group "CI setup"
+begin_group "CI setup via $(basename $0)"
 
 # Set 'exit on error' for all CI scripts to let the caller know that
 # something went wrong.
@@ -395,5 +395,5 @@ esac
 
 MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
 
-end_group "CI setup"
+end_group "CI setup via $(basename $0)"
 set -x

-- 
2.47.1.447.ga7e8429e30.dirty

