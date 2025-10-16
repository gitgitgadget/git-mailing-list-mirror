Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9642FA0F2
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 07:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760599620; cv=none; b=hi4aKHJtxXiLdrOeDjj3pxf09gRK7Wf3aRFOvgnicrUdkYJxMQvO5ysa1WGfY3VG6RFz2UIfqfVBWvVnjbB3cTZW90EJhu0EC2deVjGL0uBC8nKWoJ2hcVoAfvVKcR7AJ96ZlSLacCxyAwa/lzJSeaQMuT2NSRJN8e9DjW/ASHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760599620; c=relaxed/simple;
	bh=7IOOa2XcdD3NzxXtFzZXl1MFLBWx+ciEwsR/gN4WoJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=quoP44PUkcwOP+og+RFjNxNLPwjdWena+9hG6+g7QEQUd9ZI5EeBSAFY1OfmAep5JvKwXTvOShQ9Uo7r6wbx/SXdDh4cyfwslNDCC/eM4HtysI5FjzowbauBUTQ5LB/JbFrb3jBf/1GTMee1jC06tPznn8aPi94C1LipkmVfWzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QFOApote; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VgNHx0wN; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QFOApote";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VgNHx0wN"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1656D1400097;
	Thu, 16 Oct 2025 03:26:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 16 Oct 2025 03:26:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760599618;
	 x=1760686018; bh=W0jNNtvjb3kvgdsyq/b8MTFMLmTa65TVZ8Jt2I8JJkk=; b=
	QFOApoteXbR9Bx8dDqNob6equPDg4nGBxogOXSRTsWU0QlGDD0FAgvLZNFkiiHgH
	jVk+EhZjkLrTR7Wd/nT23aD95DshjMXTeBjdfWkQdVNNX2DZ3PdUup0ZGXJYgxuT
	SCZAbudjxLYvfENsChuN6yH36la/6Aoz7OOF3GpF1yXnTIdkizOwQN1aMydriRtG
	PNPP9PB9EYBpceHuoDiuj746zKV753SZ2ik6VAfewK0uI4cqnKsmF9kFYNdMv1mi
	92JigGI0dxaxPMn6/TzEkZNaPnZXg8ElAqFy1I1e8jMwo9L7WQmONMc1dAC6YlI3
	gjD9RgvHjGvM+rG+idPtkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760599618; x=
	1760686018; bh=W0jNNtvjb3kvgdsyq/b8MTFMLmTa65TVZ8Jt2I8JJkk=; b=V
	gNHx0wN19SgekdWgHaJwVUSCNBIACJle06ps/cCi4jHmhjeHxCM5DcmDhrlxgINY
	9m8KhVIOVuS6TinxcsP0Jm9RXWj7tycbckltxVDBj0ju0aMhxKZ21PE7EmhpTpDO
	CD7VZDOtVfos4AIqeScxct+v5nqKhh+X9QDb1OT5xlZzedn9V9ay1qoksiZujC96
	LUnlrDQsBGw+91Pw6l+crs84lEZH8tugY4RpONeXlZ1D3EdoS4eGQu1e+yjnFPkl
	S+UUM/sSwiY8EQdbnf1chH1J87maD02cCLsu4GqM0nBK1MvNWBa0XGT8pQBAOtkW
	m6wof4XPSUveoNRXpdUWQ==
X-ME-Sender: <xms:QZ7waGIQXzbKlNTbcH9jWiZ9EB53MRB6ALyak8DYvX1tsp609eP9wQ>
    <xme:QZ7waFn9W1cIX2jhGDi1Ziqme3BjdvPpoRNi7QSbVnIKb8yozhjl4I-OyRhmWnZlo
    XSxuXB2ydxFQmDAw7B2KIT1biTt7v_2ETjIQDMzxzAvUvrykGW0>
X-ME-Received: <xmr:QZ7waEHdUsitf3d7AclCVpfI8MLKAyuTfMVCIgr0ycPooh6-Gnseb5m3qDuX9TogVtEBET5XMWoK3FW_i0rtXYLuK9AvVTjC3G-EjBHW-dlRsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdehieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvg
    gvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:QZ7waFEex_xMtfAl-nbtRDWOfs827ZzyYE5rPsuq2NLSyblnwgXi0w>
    <xmx:QZ7waBMqEiFpIiwgxL6iEUpbbkWMjoQ_O_RKDFjyDa_KOGek7ItESg>
    <xmx:QZ7waEF9nrSxoBebTmfCx4NrVZhpjLTtWjG2_AD86v8JfrO1fOHgsw>
    <xmx:QZ7waIPEwo84NAYZkXd1YAWhIlM5boLH2cZ51wXVefBmHt6lOc-F9g>
    <xmx:Qp7waNAnjP4kRcT9kU5QpxJhxE5apB3CoFHQotGkkw4g9M1CuNG-KAfA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 03:26:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 823a443a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 16 Oct 2025 07:26:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Oct 2025 09:26:35 +0200
Subject: [PATCH 4/8] builtin/maintenance: don't silently ignore invalid
 strategy
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-pks-maintenance-geometric-strategy-v1-4-18943d474203@pks.im>
References: <20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im>
In-Reply-To: <20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

When parsing maintenance strategies we completely ignore the
user-configured value in case it is unknown to us. This makes it
basically undiscoverable to the user that scheduled maintenance is
devolving into a no-op.

Change this to instead die when seeing an unknown maintenance strategy.
While at it, pull out the parsing logic into a separate function so that
we can reuse it in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c           | 17 +++++++++++------
 t/t7900-maintenance.sh |  5 +++++
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 2c9ecd464d2..e358e8d13b4 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1848,6 +1848,13 @@ static const struct maintenance_strategy incremental_strategy = {
 	},
 };
 
+static struct maintenance_strategy parse_maintenance_strategy(const char *name)
+{
+	if (!strcasecmp(name, "incremental"))
+		return incremental_strategy;
+	die(_("unknown maintenance strategy: '%s'"), name);
+}
+
 static void initialize_task_config(struct maintenance_run_opts *opts,
 				   const struct string_list *selected_tasks)
 {
@@ -1883,12 +1890,10 @@ static void initialize_task_config(struct maintenance_run_opts *opts,
 	 * override specific aspects of our strategy.
 	 */
 	if (opts->schedule) {
-		strategy = none_strategy;
-
-		if (!repo_config_get_string_tmp(the_repository, "maintenance.strategy", &config_str)) {
-			if (!strcasecmp(config_str, "incremental"))
-				strategy = incremental_strategy;
-		}
+		if (!repo_config_get_string_tmp(the_repository, "maintenance.strategy", &config_str))
+			strategy = parse_maintenance_strategy(config_str);
+		else
+			strategy = none_strategy;
 	} else {
 		strategy = default_strategy;
 	}
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 83a373fe94b..45334f7ad3a 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -1230,6 +1230,11 @@ test_expect_success 'fails when running outside of a repository' '
 	nongit test_must_fail git maintenance unregister
 '
 
+test_expect_success 'fails when configured to use an invalid strategy' '
+	test_must_fail git -c maintenance.strategy=invalid maintenance run --schedule=hourly 2>err &&
+	test_grep "unknown maintenance strategy: .invalid." err
+'
+
 test_expect_success 'register and unregister bare repo' '
 	test_when_finished "git config --global --unset-all maintenance.repo || :" &&
 	test_might_fail git config --global --unset-all maintenance.repo &&

-- 
2.51.0.869.ge66316f041.dirty

