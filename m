Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6DF1474CF
	for <git@vger.kernel.org>; Fri,  3 May 2024 07:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714720647; cv=none; b=iS4jUd6KEYVNIYXlEv71JPdQTJzQenS+N6uH/OTUeQugG8Jt7WrkWCHn+vhe1UA6qNKsGXVhHNwXCxfHv7j8SUTuW4EyWDDwkzgjBJOmouHeZdlDrB2/cxJ31X4UBzVb+WvJPbyf2UT1Meh6Cwk/u9O9t7HhcqoaQHx73SWI86I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714720647; c=relaxed/simple;
	bh=8aq8j9dHFTPw45R3gZvPZHxSI7ZpEbpJ6dBqzCFP3HY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cAZbEPpsbL+uzdG/HNsUiU01MgPpA3E+1QccGCiAzFTcg7s9k1ZxGt3VKR75IU8Gt9h+4Uh4raty5+N+YIMBfMDdvrr1XnDc9OBYkYJomYqP2W+Sl0gPYRtyg/vJm/NH7HWLQvcH8+iEBR/sMqwRHMHr5PulUK6/UnRIlXi+E28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=V2TBDMl8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GQWZUxmB; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="V2TBDMl8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GQWZUxmB"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 1E93B1800142;
	Fri,  3 May 2024 03:17:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 03 May 2024 03:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1714720644; x=
	1714807044; bh=uia4eDtX5HWa1+DC9nuPCGaC1YrEbp9Mjeqh6D0Yeog=; b=V
	2TBDMl8gPIVUg55iy2azbiDaJkWdi4ELfru1scNB6ZuKzEVi3DA5w3r2rbMmzhOs
	6Wc41LMrj/71YptiCzzrWlzHqQ2qv7QSSaBM0FscqHwa9mjtZE8Ba/ahEexeWhJl
	Sb0cYpwczk6waWu+gIXM+KzZzaookx+Dtr93MgaWXQ6esqhN82r5MdYKx/TBseJB
	eLU6sMxNqjbpuYDfZ60HXDZhnUzqOsVZoTbbXPvc4Wx3ed0GaipQPujqalTAzHi/
	iYkcwZ0SWHrevl8ckFO4qQE7EMhVDWSKN5zo1FLlfUme84zK5l1b6sB7RRsu7yy+
	Ef6QS7ROxw/RW1F0NNFhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714720644; x=
	1714807044; bh=uia4eDtX5HWa1+DC9nuPCGaC1YrEbp9Mjeqh6D0Yeog=; b=G
	QWZUxmBQ0f0b0CI0nOys/JOQ9qVRqZTHDSC31ztFr0O3f+Vyka0SZTCXnj6sEgVS
	N9aBn2CxTvQr3ECUwQUR6xy76JG7OaQOuCFgkAJsksxUMe7sLNghugPGZQJ2Enbi
	LbSw9OwuxZu0iaQGYnJm3qluv97BqUbq7piOb8S9Z0poUDTBCi2Eagzyd/Mzo3y0
	aK00JCjh8a0ZRiWIwQ11MUikP3Dg5Pul8UiYcKL+D2QR/Gf05/Sad0kc+Djp+9uX
	AyqZjy+VfUad8iakgJ+Fk8skRVg8PtLmyTKHFrvrrv6g6sYpzmvVkWRABrqp3Qqv
	79Wb75xe05UU2ZJT5s3GQ==
X-ME-Sender: <xms:hI80ZpM4dVG_uQkDNjs9FTU1EUR1QSs-6NrhcWnL59AnNfIwuVFDZQ>
    <xme:hI80Zr9EN-lRIX2O8IZG2plWRxu5FJmr_RzpoBxN0qwrl08FAwya3czhj_WQUyCsu
    T7i2-KaJO-GdkfUYg>
X-ME-Received: <xmr:hI80ZoQ3wO3lMeqMGXmWU8tzieeNnZAA8oPoNkGSKVMewaTt4aq7sz1L9vl1Xmi03x4MPmkP1fv9xkuVP2qvak82lqCPtrgJEAgHewiJ-FO2TYbQK9UmuTjI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduledguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
    ekredtredttdenucfhrhhomheplfgrmhgvshcunfhiuhcuoehjrghmvghssehjrghmvghs
    lhhiuhdrihhoqeenucggtffrrghtthgvrhhnpeeljedtuedugfetgeefieduheelueetvd
    fhueeuueehveeljeekleetteefvefhjeenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehjrghmvghssehjrghmvghslhhiuhdrihho
X-ME-Proxy: <xmx:hI80ZlunS9elgfpBvFrK74R2zW2SnebFUOszwK0Hn86mh4s1EzN1fQ>
    <xmx:hI80ZhfIuRHAUywTrWFKQsvATTfvQFqDu13eMzSxUXZAkdUtdqZHHA>
    <xmx:hI80Zh14-V32CH0ijzUGs0gtc3LtVONMR-3DuyYr3TnscY7ceDIzLw>
    <xmx:hI80Zt_De3gjE0t8-POOzwbt9TlGJ7Yq7neEzWy9o504ZLqUiC7oQQ>
    <xmx:hI80ZiohV51WTXv3AVn3RFbvPdxqEjYF3Gs4C5952-0DdhODAOFeXsdQ>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 May 2024 03:17:23 -0400 (EDT)
From: James Liu <james@jamesliu.io>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>
Subject: [PATCH v4 2/3] doc: add spacing around paginate options
Date: Fri,  3 May 2024 17:17:05 +1000
Message-ID: <20240503071706.78109-3-james@jamesliu.io>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240503071706.78109-1-james@jamesliu.io>
References: <20240430014724.83813-1-james@jamesliu.io>
 <20240503071706.78109-1-james@jamesliu.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the documentation page consistent with the usage string printed by
git.c

Signed-off-by: James Liu <james@jamesliu.io>
---
 Documentation/git.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 7fa75350b2..d11d3d0c86 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git' [-v | --version] [-h | --help] [-C <path>] [-c <name>=<value>]
     [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
-    [-p|--paginate|-P|--no-pager] [--no-replace-objects] [--no-lazy-fetch]
+    [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--no-lazy-fetch]
     [--no-optional-locks] [--bare] [--git-dir=<path>] [--work-tree=<path>]
     [--namespace=<name>] [--config-env=<name>=<envvar>] <command> [<args>]
 
-- 
2.44.0

