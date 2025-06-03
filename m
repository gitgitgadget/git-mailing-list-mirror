Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC66239E94
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 14:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748959288; cv=none; b=JDX4OJu+QWVwVL+8FcQx81bTN9gbJodTRNgzEus+3PHn5CTRsQ+nsjESDM8Q625TZYYYowIWlaRIXwjKCJn8sX3KliSLFbPdRbbYWxg3o64MTt9dFDvSx2iMtcNGMvj4Mcf165HLetMLwDN++eJEdkcylteVvtT2ND5c3q/WVLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748959288; c=relaxed/simple;
	bh=GFWsG1UUCUuoy84O8y7Rl2h3eHbD9mDWtcmoCpPrmsY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E1AtPyMZ4o8LobPUWJmzmWFrXaAjZ51plnhzvuasOOnthQiCOwkWpBkJDCpWfE9f6Gu34+/ARwCqDByjkyJk28eNy38oHA7qN3m9dSeriO6Hk0dh2AyD0RslVjl1ctik6N1Smn+PL/lg/Fz0EGfjOeaehvm6Oj3a+CSCOdx8GSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z2IIgbJ3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IZmbTWna; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z2IIgbJ3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IZmbTWna"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A911425400F2;
	Tue,  3 Jun 2025 10:01:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 03 Jun 2025 10:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748959284;
	 x=1749045684; bh=Z5eGkM+6OjG6MdQohVAxETNiHWJ2jjvee26DiptQIkc=; b=
	Z2IIgbJ3giczd88+ptWK9qxipfuNgg6JnxdkJevAOXlK3ejc9TeJ/bR3FbfylCa9
	+ibEO1MkbIcYzed7BAObDqBjL9BbRy4WaAELZbxtJPNrjswqtnP+CTCs1hh2YUk9
	SVx3nmiNKEfdLn90pGq6/T2RWM1XzYZDILLeWsiCElH3lKktwqOXJv3TnpksARQw
	MSe0pfDqSdE87DCl9N4B+e6sTSpdVyz7uc6lFZhHfg9m1mJUhjIxofuq8uuhkZ8u
	WgGd1Vp9Gv7FfhYOmeWEJMmqmgiomgikXk0nU26niq6c7b20bcTpT0wAE9IREJTh
	rdtfcDr1D3FKKaFuR4GknA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748959284; x=
	1749045684; bh=Z5eGkM+6OjG6MdQohVAxETNiHWJ2jjvee26DiptQIkc=; b=I
	ZmbTWnaj/S8P2fA5ajls6OTsTca7bSnKpSfWTq+xPKWQ6DZ3TVQmhNhiqS/95GbH
	3qzNjLEFGjPUIYzdA5HP42xgAdyMtbLJE8HdeGvN5P9DeT6SDfbOib0BHKvSgA8L
	dcTRNAe7f5+8AewDvTIxev94Qq8MsTA8H0jwAnvt6AT/O4rkpjsspGHzfPayo+iY
	zz9j3X9xt1YU8H41ObvSRawoeJr4XXZ0YBdg95ZBvxPjqOqtZX97LcvRNCqY3vwj
	jrsiKV9D1lzo1G9v4jQ71UHbstzrMk3v7WLf2SJDCCNe1+YZNwR5H7CpQcSaxIi2
	IjmwLcoG+EfMDubawSRRQ==
X-ME-Sender: <xms:NAA_aIEm6nyMwPZ3Apgapr6jnVr5upw42TESBf_XKpDwAL4gJmUBgA>
    <xme:NAA_aBVnLDPozS-Xo936dInC6uvDCpcy06bfYvaNUKEwKTMN4e_5eby4mI5R-QnP_
    5MaqNyvr73lP0BGng>
X-ME-Received: <xmr:NAA_aCIaQePDDAc_FlrXpdoski7OUTBsiFMslvr8Rbc1MMqYu4VOjKwzOemFtkqPnn_a38sycsgOCXHgNFmIaMkGZH8_XIZALujmdNWILQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplh
    hushdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
    pdhrtghpthhtohephihrohhthhesphgrlhhorghlthhonhgvthifohhrkhhsrdgtohhmpd
    hrtghpthhtohepnhgrshgrmhhufhhfihhnsehgohhoghhlvgdrtghomhdprhgtphhtthho
    pegurghsrhgrfhelsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslh
    gvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsth
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:NAA_aKEYbhiA6xuBHZFO09CKvJWff1elb3yRZuGdU3_cGgWrcSWIEw>
    <xmx:NAA_aOXmsN_Cl_Z46W0u1ZoCJJ5GSHmrFTCyxoSI1sJHpSQGK7J7Sw>
    <xmx:NAA_aNOpxh_8XJLbv1kL3Qd7MlDp2U_EBoGkSKzt9lMyTzoNbUfDGQ>
    <xmx:NAA_aF1yS_-3h3rahNDTKiSSm04GGII0wl-besYHNG68gLMaBfI53A>
    <xmx:NAA_aBXAT0TNp_JJVX_HnHyI2yttSrjd0Zszzu2kFxbHtkjbc2mHtogj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 10:01:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 91572d33 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 3 Jun 2025 14:01:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 03 Jun 2025 16:01:12 +0200
Subject: [PATCH v4 04/12] builtin/maintenance: mark "--task=" and
 "--schedule=" as incompatible
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-b4-pks-maintenance-ref-lock-race-v4-4-52f5cf7b7e99@pks.im>
References: <20250603-b4-pks-maintenance-ref-lock-race-v4-0-52f5cf7b7e99@pks.im>
In-Reply-To: <20250603-b4-pks-maintenance-ref-lock-race-v4-0-52f5cf7b7e99@pks.im>
To: git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, 
 david asraf <dasraf9@gmail.com>, Emily Shaffer <nasamuffin@google.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Ben Knoble <ben.knoble@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

The "--task=" option explicitly allows the user to say which maintenance
tasks should be run, whereas "--schedule=" only respects the maintenance
strategy configured for a specific repository. As such, it is not
sensible to accept both options at the same time.

Mark them as incompatible with one another. While at it, also convert
the existing logic that marks "--auto" and "--schedule=" as incompatible
to use `die_for_incompatible_opt2()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c           | 6 ++++--
 t/t7900-maintenance.sh | 7 ++++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index c4af9b11287..57d7602596a 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1785,8 +1785,10 @@ static int maintenance_run(int argc, const char **argv, const char *prefix,
 			     builtin_maintenance_run_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
-	if (opts.auto_flag && opts.schedule)
-		die(_("use at most one of --auto and --schedule=<frequency>"));
+	die_for_incompatible_opt2(opts.auto_flag, "--auto",
+				  opts.schedule, "--schedule=");
+	die_for_incompatible_opt2(selected_tasks.nr, "--task=",
+				  opts.schedule, "--schedule=");
 
 	gc_config(&cfg);
 	initialize_task_config(&selected_tasks, opts.schedule);
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 8cf89e285f4..1ada5246606 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -610,7 +610,12 @@ test_expect_success 'rerere-gc task with --auto honors maintenance.rerere-gc.aut
 
 test_expect_success '--auto and --schedule incompatible' '
 	test_must_fail git maintenance run --auto --schedule=daily 2>err &&
-	test_grep "at most one" err
+	test_grep "cannot be used together" err
+'
+
+test_expect_success '--task and --schedule incompatible' '
+	test_must_fail git maintenance run --task=pack-refs --schedule=daily 2>err &&
+	test_grep "cannot be used together" err
 '
 
 test_expect_success 'invalid --schedule value' '

-- 
2.50.0.rc0.629.g846fc57c9e.dirty

