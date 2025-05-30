Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E17F235354
	for <git@vger.kernel.org>; Fri, 30 May 2025 15:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748617728; cv=none; b=lEXGnGnuSjoyIgTS5lGDlV4X4yVxtQfZeCFuP9VrEAzrUombhRGEV0Vy8WjcpWGvFM43OeQk+5X9pDFDCP6KWnySoIuA1jdIW2rN1Qvc9pDoLbt5kAUg2kHSc77pCiA1iKDK7Z8SQKv9ksX48kfPeQ8jaOeU/GUqGjVSHvijsfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748617728; c=relaxed/simple;
	bh=m52q7BAwSbQEqJZYsqL2SMxUjvvM+ytxkwHeuPKTSl8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CMTgV0qmBn6ahvBjuVMeePKzkuOPV5a+/GZv7gsloDA/anl+pfZTS0fDy6nmm13J2rwnw0dNHtajNEfPPeGI2vasZOeLo6jZ2fwXJCS0iAKcV9vE6hFYuDabed0AuOAyIFtCcedI8WzG2xGnu/yw/qjBGAHUKUHdinv8wBakHnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LXfokJHN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z8RuSb45; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LXfokJHN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z8RuSb45"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9FC41114015F;
	Fri, 30 May 2025 11:08:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 30 May 2025 11:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748617725;
	 x=1748704125; bh=EhhqOp5aqFrhOncfFgpzS1giyzDJSoIp1aCmrKMK/oQ=; b=
	LXfokJHNUy46Fm8XX+OegzjaTsJAk3jzV46sqs1Y+Wt0um7BX0Mz5/nhs9Wi6jen
	e9N1oFaz4QwoIdCdp8emKpqYDjURy4q1dWFTh578gCHBsLG3HazXTpFg/w6I7bGX
	GvjGL09qxWkFZP8ceLDx0BofxvzTnxI78oIZiLNfKNU4b884gtLEU8sSKp7tyZHs
	UM2jI4IkMLYOQMABITC5vemPURirWZ2YaDPaURw9bMo1r+7f1Tmsw+nc2Jr8HZ8H
	J3KKyemMOZoCAqlPJAje+IP2vhkdLEhUOa4dXnQAFQAjMyR3JEtxsXLL0i/+QOw7
	LbRO5BcnBtqTbi9VoG8iLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748617725; x=
	1748704125; bh=EhhqOp5aqFrhOncfFgpzS1giyzDJSoIp1aCmrKMK/oQ=; b=Z
	8RuSb45S5UVENKjjD+Og0Cl88SZDYE7ib04U+lbHz34ONTS574BCwAGzAdzij+gO
	ZamqUpKf+6UZaJE6niWHmeTQ+MdTd2Nbweje7hcv5qCLkfwcaykC6c9P+JpKHTtd
	1zO/osRSPFNoajBiRY7jCf3+BlSU7OPRIGCihkDloO4mUI+K3DeOjIk+c+ZCsE9o
	IzM2Y54noYTK3uF/YPpXz80vWsGsbTAqIibDUE9PD/XuiK9r8e5xeOQXvu/myAw1
	IH8OQ70QrrfdFBLUDxHSlKA/zqr4VX4zYsGgUPpNKA6QhHffVY/Gl0ib009cIHmV
	X9sXT1uHMLGXSpP2GLnZg==
X-ME-Sender: <xms:_ck5aHi8sVVb2hAyNxmG0Sbohje-quUlsMvBJhW2AX9jBm-NIP_A5g>
    <xme:_ck5aEArl0JSOjtSx0EjRc9t2SLFLGe21iBrEsYWAmnucODoLUp9IP_PzQiRdk7wj
    j_C09u4BRVUf7uTlg>
X-ME-Received: <xmr:_ck5aHFCmYEUrEHrZlF6kvA0PfD2RvFmZyjlmU-nOcUuv0E-duD8QW2ISrVKxwflNWo_w9Z54lW5lnbldGmP0IlLCTPx6Dq4Mv-vCaBCgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvleeffeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnrghsrghmuhhffhhinhesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohephihrohhthhesphgrlhhorghlthhonhgvthifohhrkh
    hsrdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhu
    shdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprh
    gtphhtthhopegurghsrhgrfhelsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:_ck5aEQ8AmMw9ouHpC73VRfeFkiYoZP3kr6IPnfutkNAKOUX_ct8eA>
    <xmx:_ck5aEyFDO0vmSxkJmwKWr7h1EM1EpPR1OhitddqGw2aLQWvv75HOw>
    <xmx:_ck5aK6lDXkt4l-KowGi30qj-WV1POjwtGrL34nayDXqlzMi5T3h8g>
    <xmx:_ck5aJxwr-DI9pzDh1p4DNGp2Ytwgf43EcxYQvOUGrMfPK-6u7Tcrg>
    <xmx:_ck5aBnOl14p2umuTmlmGegTrIPTNGAvCimzw-vRjr_F5QoSUlA5OpHl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 11:08:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e55fc18c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 30 May 2025 15:08:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 30 May 2025 17:08:33 +0200
Subject: [PATCH v2 07/12] builtin/maintenance: fix typedef for function
 pointers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-b4-pks-maintenance-ref-lock-race-v2-7-d04e2f93e51f@pks.im>
References: <20250530-b4-pks-maintenance-ref-lock-race-v2-0-d04e2f93e51f@pks.im>
In-Reply-To: <20250530-b4-pks-maintenance-ref-lock-race-v2-0-d04e2f93e51f@pks.im>
To: git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, 
 david asraf <dasraf9@gmail.com>, Emily Shaffer <nasamuffin@google.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Ben Knoble <ben.knoble@gmail.com>
X-Mailer: b4 0.14.2

The typedefs for `maintenance_task_fn` and `maintenance_auto_fn` are
somewhat confusingly not true function pointers. As such, any user of
those typedefs needs to manually add the pointer to make use of them.

Fix this by making these true function pointers.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index cfbf9d8a2b9..447e5800846 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1533,20 +1533,20 @@ static int maintenance_task_incremental_repack(struct maintenance_run_opts *opts
 	return 0;
 }
 
-typedef int maintenance_task_fn(struct maintenance_run_opts *opts,
-				struct gc_config *cfg);
+typedef int (*maintenance_task_fn)(struct maintenance_run_opts *opts,
+				   struct gc_config *cfg);
 
 /*
  * An auto condition function returns 1 if the task should run
  * and 0 if the task should NOT run. See needs_to_gc() for an
  * example.
  */
-typedef int maintenance_auto_fn(struct gc_config *cfg);
+typedef int (*maintenance_auto_fn)(struct gc_config *cfg);
 
 struct maintenance_task {
 	const char *name;
-	maintenance_task_fn *fn;
-	maintenance_auto_fn *auto_condition;
+	maintenance_task_fn fn;
+	maintenance_auto_fn auto_condition;
 };
 
 static const struct maintenance_task tasks[] = {

-- 
2.50.0.rc0.604.gd4ff7b7c86.dirty

