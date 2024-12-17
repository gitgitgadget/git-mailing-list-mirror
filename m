Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CF91DF732
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 06:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417868; cv=none; b=E52lzafh11jX0y3aXOMRNgABYt6RJvCm+eevbOdZRG8hkXdEVMdVG9lM3qxP8Ci5NgbK+AzzUIZxUVYch8j4pQEJsQo1WTDKFKsxHBaxITzjmjDETSGtUjuJNu3wKonD4IRyHYkN76A9lJ92pqQkxNt6H5jEW9Lz2J8WsTE0q9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417868; c=relaxed/simple;
	bh=TLd71eyC3WHUYt9su9NCSw3IU8r4hbGcpMVjr5vFofA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W5/RyTb7/KanPBwFOQldtIdvnB+8TclibtYV+bATnl3sMKMmlTknL0b/isfmeJT8wPyQXfa71GSJZIbUgZzXehbfAZ/Ds5soo4U0bULPmCSQN9ojd92bCB7y7o6lBvMUkIyox9tChQKSWmn064TN7BLt75ecF1ywu4owajclvqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=w9o8VuKT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MOenCpPT; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="w9o8VuKT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MOenCpPT"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E37161140254
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 01:44:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 17 Dec 2024 01:44:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734417865;
	 x=1734504265; bh=nLwWo5jJpMJnrYUmlJeoeUu3rDTHxyT8aDBawdKqRXk=; b=
	w9o8VuKT6I6rrKTpt6uXyvZuOmkhy+U7SvHy/rGwJd75Vvl8PsP7Pp0tc3paK7mG
	QjcS8L/fqo+wjxdMF2CHR9fUST4PbFRFg9FZCy8ujh/PfGvjv2gQ0n9XSrVvrvv+
	+N7XAzCaj8Jj9fPJ0bTkUzELeD4Q506zLCf+Y2Tzl4IOJM8X5ZW1OHiFi0IwLfFq
	qKixWhY8z1ekozo1lm6FAJ3x8nXyncCsgFxvrbrSL801dSSAtZDRaGfi2V3dGhhn
	GOhc2K6Chxu8cne5wcQuJf7GZO+FxZxLvc9rIUcvnbgsprdYhQPFM3mJ7RW/dLUk
	Xx4WeByNY81K87TfAe2ghA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734417865; x=
	1734504265; bh=nLwWo5jJpMJnrYUmlJeoeUu3rDTHxyT8aDBawdKqRXk=; b=M
	OenCpPTvkLqpRmsIqVHRcYtiBO7dCTdZ8DLDBH7cgeltoa5Enl0XrOjxdJId5enR
	i1uTRRKbWJtRSinXR6bTEvRCgNpbZvvKlGgyAm6eNIgW628cHl5ge1i2cU+z9fwS
	KKIsNkrcrNEebVm2Dwt/yhyA3hmnv0pPKIBdZ7XD6JVLvzXBjOvZUCsB2VWA5dGL
	fTtFwyqnmYZQr9PRysNYb0dRmupV4F9bmdAt0lrxocycgY+eJWIpNYaqWXGMpoCA
	/+dg4cECMqORko+gaj1tSO4KJ818kONx+blRAI2dgXxBClOKoRzmxx+hUh+aZEbH
	0/yqNzTncyGF3PvQBPL4Q==
X-ME-Sender: <xms:yR1hZwyVtQ8Ex29a3sZNL0MfjSGzSiYtBI4TjDVQudCmDmnze1qhsA>
    <xme:yR1hZ0RaP-vmkb2YbM13YZ0Z7UjjglbaRE8vHneAlair9cEqqN7I8fSgTeByS1-wL
    YE_mV7C3x6T8LvBJQ>
X-ME-Received: <xmr:yR1hZyXfIju_J8QczzlfbYR91F-QM8MGLrJqJxUDizaGpkSFVndxI7QbMO2RhKVDwwWiQtV9jcBukcu5nmCjC9UCyU80xNH7CxsfU4_vaMNsT_I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleeggdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:yR1hZ-isU5PWNljLcp7TQ9r6kESkGFKW65yrJ-u8HsvyXt1GJyRwiA>
    <xmx:yR1hZyDTHLq1SZq9f2I8I-isOJnXkt9LCYdFOLqYtqgmzxOHg2geew>
    <xmx:yR1hZ_JAWwZVGdAIbPS3_41AgVD4L7yiKIZaOXDnwLPvIDo2iiauTg>
    <xmx:yR1hZ5Ck6d4Xf9p7aruNSUNCnAyqW3YVPyuaXLtvjjf58HpjgqYQ7w>
    <xmx:yR1hZz5tDCfY9ZUKU2Ah0iKxLmOSduEm6SuVWnpXO7Reca0S73Vc74Te>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 17 Dec 2024 01:44:25 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 683afbc9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 17 Dec 2024 06:42:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 17 Dec 2024 07:44:00 +0100
Subject: [PATCH 13/14] graph: stop using `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-pks-use-the-repository-conversion-v1-13-0dba48bcc239@pks.im>
References: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
In-Reply-To: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Stop using `the_repository` in the "graph" subsystem by reusing the
repository we already have available via `struct rev_info`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 graph.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/graph.c b/graph.c
index 52205f75c37cf3467ac5e9de1574425d6c203359..26f6fbf000aef5ef1fa46aeed5851a8fbb2d8fe3 100644
--- a/graph.c
+++ b/graph.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -351,7 +350,7 @@ struct git_graph *graph_init(struct rev_info *opt)
 
 	if (!column_colors) {
 		char *string;
-		if (git_config_get_string("log.graphcolors", &string)) {
+		if (repo_config_get_string(opt->repo, "log.graphcolors", &string)) {
 			/* not configured -- use default */
 			graph_set_column_colors(column_colors_ansi,
 						column_colors_ansi_max);

-- 
2.48.0.rc0.184.g0fc57dec57.dirty

