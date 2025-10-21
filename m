Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED3233B974
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056023; cv=none; b=YkujXloG2i5rdvqoDqppttkPPDmma6CSk9ykEl4rRwGj4iB4QD3Gcz0C2ovhYbUGPzHE4CwLftYoPEjHxdro0LkNLeGvWkeXP20V+jksQyt2GmgWjrqywBK32M7Xy9WKbdgySUtpAPLBYsANPli6nJVlS7sl5XlMBdfkNB9wvsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056023; c=relaxed/simple;
	bh=QpycSp8sGTUwtuBfQzBEahT07wZX8Ie9Ia0H93UiSDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dWyYaaOh/kcXY9xJL5D6u2ucMdq3Hz3brcO4IMIsmIm0CmUOH9DXfq4EJwEh2t6+FxKVoMVo2KO8QugJ1CMIKEkDFij8Oicw7BrSit54Dez4qJzoJ+hzB+we73Umcth0WtLUsSLSr2PhdKHyKj1/vFXqrIpSZWsRIVwjgkQbBbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aEeJZwnY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wzU6DcCc; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aEeJZwnY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wzU6DcCc"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 750481400184;
	Tue, 21 Oct 2025 10:13:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 21 Oct 2025 10:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761056021;
	 x=1761142421; bh=AfT7XhUAzENobC7Ye5tVPeKvy56fQXg+OpFMXJd/l14=; b=
	aEeJZwnYVK7ZbOT6EUx+/9Tzosytb+ljHrDqztjrYy29f9GpkpK5+lYSor6rj3JX
	JmDrVVth6eiPzDOaJo0Skd3nc4uIH71IPHiLoJKgb58kWRCEdSLmZUFCLrBhMGJA
	iF9jZRbkI2lrUr7O3dwgjjUuc+SSpwsS8n314JWe1Ws/t0zrJOqMu6R85gQxMyqY
	wS1XNx+PItdOPPxlQ8T+p+BJCWlNmDid+k5MVKcm2bdcn/hzJMN30ji2rA1YaD6v
	opAHMeI7667Q3pGjzY2YNd3Fk0r6ANXBiWjoARG0fpSPlfnKi/ECktSwmp79D3Uq
	tcWbJCF6wk4DXUkLLLC20Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761056021; x=
	1761142421; bh=AfT7XhUAzENobC7Ye5tVPeKvy56fQXg+OpFMXJd/l14=; b=w
	zU6DcCcTDlxdB0sAYZMx00yGiX7CS6s3bIwOM862jdxf7cXbslMb2L5/IBc+hkpb
	NuoogencSKHWIOdYwyp9UBGCtgWUnFIlP144wspPzxIJt9hD9Av8Dwz05lH2PCm5
	gaz4vOQYKUqebPRAgYZL7YkrT1533hVMkzibebdK8/p8KuRDLQCu3ziHtuMmnw/6
	qLbFsrk5ukBearWG7hcIcVkAk6pBcHTKViA39/4mD4HjUBOGl+SX68uLOLJkvcoZ
	bRtdybEXS2yJG1mxjlq/G6NycJFNCFOdquwfWwFfJBtFhkqui5hU9beuwi2iLh+a
	MLW+2Pt3lXxDF1kgKlP+A==
X-ME-Sender: <xms:FZX3aEINaCZUwPMN2nZyFVPAbnsgRbiDdTROESM2d2b6poy63SZJ1Q>
    <xme:FZX3aLno4Pxu71f3mMDexNX9GKgW6BkYaHwTsltmIA_td900hadrX-HqCj4pF_YXU
    W-_y1KmH0F0elrWVuOdIj3hna9kMfZ1yvj7W9ZsrSarsqMknYMI>
X-ME-Received: <xmr:FZX3aCFV4-khfzhaJsaQmbAo0f9cvjs3uYDLEYGPmYswTyQAzoI16ciMZK_UiPFivxa5esuKu2vjByX_XbrTFKSsnppNNocpNHVfsqrrKNQBgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:FZX3aLFofdXEeXWrDl6BJF5XdUe0wBV2mgq_5sg3HtugP7sabIKpgw>
    <xmx:FZX3aPMUAv6BN_Tnhoo6ehjopZlWbJpn05Wn83ncbs4xUBGVcv1vWQ>
    <xmx:FZX3aKG-Shq_u0LZHroOsjjU0EiGrcNQrnF5Wt4elNSNvtANvVI1PQ>
    <xmx:FZX3aGPaViGZ_rbtbd98G1dzmDXMG2THvftCPSbrC7UclgP3w9w7_w>
    <xmx:FZX3aDDFGacd75z1XODJbiJiSKub72dHq6Uo9DOkHpDKPRYQiZe7MJ2e>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 10:13:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8dac5aab (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 14:13:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 21 Oct 2025 16:13:27 +0200
Subject: [PATCH v2 5/9] builtin/maintenance: don't silently ignore invalid
 strategy
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-pks-maintenance-geometric-strategy-v2-5-f0d727832b80@pks.im>
References: <20251021-pks-maintenance-geometric-strategy-v2-0-f0d727832b80@pks.im>
In-Reply-To: <20251021-pks-maintenance-geometric-strategy-v2-0-f0d727832b80@pks.im>
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
index fb1a82e030..726d944d3b 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1855,6 +1855,13 @@ static const struct maintenance_strategy incremental_strategy = {
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
@@ -1890,12 +1897,10 @@ static void initialize_task_config(struct maintenance_run_opts *opts,
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
index 8f332e7fbb..69fb6e9ee2 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -1264,6 +1264,11 @@ test_expect_success 'fails when running outside of a repository' '
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
2.51.1.851.g4ebd6896fd.dirty

