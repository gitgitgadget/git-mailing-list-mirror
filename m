Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA7F139579
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756312283; cv=none; b=kwiiijj5holSopIjgLDkQahJc2E3WwrIfKKiJ2lKuKe4TcYMqrzAQid+GCmqr8A7hwnW7VEUoNWGJVKhFUqbi1uiwKlgExJXKGoBAatdrDGSBxwo/7jxgqqcqHOO+BBkNnN5bYiWnVFToxSdMgFP6nE5i+D7OQXR8DBvqLCQMNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756312283; c=relaxed/simple;
	bh=Y1vB6YS+gcU3vtg8O6hSfqFxDpDx43z2d5qUBZwHSyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1AU1TZYzshCD+ELt9GTcymmFRUuEe7ujieSgi/Aj3C2pRLEOx69usrQooh5U2Ar1CI7LNnwsCgUSeEWg8pzgEG5BNwVI3Qz4wanDsmBPgq3561ozrCM1zMPm791aonadrs8XxoqF+N6pUyBSQpXUvsgA3axULKPbiHgZN3mr3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=a0ZTSqA+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WY0vXDrs; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="a0ZTSqA+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WY0vXDrs"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7B8F31400141;
	Wed, 27 Aug 2025 12:31:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 27 Aug 2025 12:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1756312281; x=
	1756398681; bh=eNN/pPLDRlcb+jsXvgv//Mb29GypsB7McSZ9FNcAXKI=; b=a
	0ZTSqA+E2246sDVtfLe2dNoTSCpfOBiXEnD5hk0CCyHbIwQXuls7Xr4bgDhvlz/z
	OgoL/6+nwJzAFw8v+7lwcDXUID8fcfjW2H49ppWrTp1krX8nkdzPrtTPsrPTjH3k
	ELyUyKrWDOP6/Is6f8wuIG4nIolmxDjuLU4obBQA9zgftSdOUXyGm9kiBUV67QBU
	3TZ8VDEeBtbdjpjWTjltpo5jtvSvBjR/9UXlPPkLDW9fGlKzC3JLYNqquHKn8vZL
	pPy6pC0HUOiXgiYj/b33xmBCYjQb2D1ewLLFcuorp1zLbV8d+xOwn3brmeaF++Ro
	M0qEioaqSV+e9uPYn1PUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1756312281; x=1756398681; bh=e
	NN/pPLDRlcb+jsXvgv//Mb29GypsB7McSZ9FNcAXKI=; b=WY0vXDrsrQvnVbAXD
	9Yq4h6C4WE2a9iFo6geGEdk9IkC1I9E2HW4npaui/q0A2nImm5kQY8lwgDo6LqMl
	l0BKO3O9ist0YvwrK8eZPxYUl+qd0LqeGYOc7FC5cou45p/hLsDWM9TCU7Q1acFn
	UWWPaLazKzxayFNDuy6f44hSqX7lY81EDoajENfXUKSMX2TxZ37dJrp6jjAOUM3+
	4EtuKo7x+MXGtpU4U3k65+nqmffNJIYqH3J3ciSBENCPZeGH0uubX3zHFTkm08md
	3YWErvfovvK8VFvDx3j5VswlPZEhm5kzn+S5vV8KegTAZntKH15u80On/5vxKjm+
	bUeoA==
X-ME-Sender: <xms:2TKvaMfYUxftM64DABErmCDsuVDqizVEi4d_jCMpRgSkwyNLFO4sU24>
    <xme:2TKvaOYMM-E8YlOAAI3NRrSvz23R9PIX0e0K0f2r_41agCU2lSrLeyPXfqyAsNOSf
    MDoW0nJ1eBtkmxTzQ>
X-ME-Received: <xmr:2TKvaPVqNUBYedf1VTb_mk7d2BroaffR56ITi86pnR6azweB_g1-C5y_xwTdhAQW5yemDiq48mjluJH8yFE-0M7pLNb8kCqR0kJGkFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeekieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhenucggtffrrghtthgvrhhnpeefheetkeeftdeiffdvjeetueethfeugf
    etgfdtveehhfevffeuffdtheeitdefudenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    gtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:2TKvaAgmeU4ynzoOEEv3EtjhZv0r0v_ZJ4sLI4MYubI-Cui3ug2MfA>
    <xmx:2TKvaNVMuN6SPS5orCPrEntY3KE58SJ-8oDhTYhNgHGNIIhyVZ6XSA>
    <xmx:2TKvaHPHcM9IOTw0AEmKqK3PiQuf-a8l0zfTGVy8fisQOwf6JMdIAw>
    <xmx:2TKvaJY1DPBMATlFQM7Pqr7SJ-qQhfixLPdvt-glEMEKRvFOpmlpvA>
    <xmx:2TKvaPDDGxIjGypXbbKheug7aap9PASELgkDvmcgqmg9Bu2qXxUIQszi>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Aug 2025 12:31:20 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 4/4] BreakingChanges: remove claim about whatchanged reports
Date: Wed, 27 Aug 2025 18:29:49 +0200
Message-ID: <f1bf0ea3846852eb8df0d0d0f6cba72a493e8c1b.1756311355.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.11.g23cedd8a747
In-Reply-To: <cover.1756311355.git.code@khaugsbakk.name>
References: <cover.1756311355.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This was written in e836757e14b (whatschanged: list it in
BreakingChanges document, 2025-05-12) which was on the same
topic that added the `--i-still-use-this` requirement.[1]

Maybe it was a work-in-progress comment/status.

[1]: jc/you-still-use-whatchanged

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Footnote solely to avoid awkward paragraph wrapping...

 Documentation/BreakingChanges.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
index f8d2eba061c..c4985163c3c 100644
--- a/Documentation/BreakingChanges.adoc
+++ b/Documentation/BreakingChanges.adoc
@@ -235,7 +235,7 @@ These features will be removed.
   equivalent `git log --raw`.  We have nominated the command for
   removal, have changed the command to refuse to work unless the
   `--i-still-use-this` option is given, and asked the users to report
-  when they do so.  So far there hasn't been a single complaint.
+  when they do so.
 +
 The command will be removed.
 
-- 
2.51.0.11.g23cedd8a747

