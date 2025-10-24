Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E364287259
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 06:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761289058; cv=none; b=ZngEjj0j8Rg8UR+3LjyEpwt8NP/KJKyeMFDPr0W8v/x0ZUrnxnFXQXVXRa90y8JkxacD1Y6ZroPova7Mp3NHHsfYNUDpY9ggZHtcewxTSTr9utNQJ9xZLXiGe2dhp4XDXXPOiByV0LMxWwGAJlBcD2RUoMsfmr25ItHzGCVyldc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761289058; c=relaxed/simple;
	bh=fnZr+RDIL2+Yb6aq4gbClOJVDv59V5IeexHkyApnhU0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lh7yMK5A2YfqgiLmP9tqa46lwEiqxC8hIEyBSYXe4iVFPZHNt4LImkFxUYuQ/I2v+uqBJVd60y5df3CH6ZWc/CPc6NL+X0g4Y4aNE9jiAI9Om2ipdMsPBYT1rg+tgu1TUSOUqopbg5FkVJg39n/9ltrBjhjKwVaNtfTmjUxdqXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E8lGsFJ0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BfcN0zLF; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E8lGsFJ0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BfcN0zLF"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5F72C1400151;
	Fri, 24 Oct 2025 02:57:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 24 Oct 2025 02:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761289056;
	 x=1761375456; bh=JGiRWD8YOtNH9DA0Gr25pzoBxlS1LafZwsTLQBCK/Mc=; b=
	E8lGsFJ09XSV/1W9UXcRc6KyrhcomO2G6Uy+E5O9e56C18ms9MRbaxFuyC+XZwCi
	pejAXnstyt+3OvVA/W6Br2eb9xfrclUqfYWHrdsnvIypP/yCibQWvrxgvP416w0/
	QFTGOnVdPNuiZe8VmaReO8qXqHgyT1GI/5WBqqs7BDaXqOccc0ynK5OdQvvphhfy
	NYpf4WVKiROgaLDnDM+3e43GHmDvnRJgDKhSttxqw1//frUBgGmJosX9OzHRhxyd
	M502M3shQeTxMoDFrfpCOjGBFCIrZCEOlRhhoc/RLvsAszc82roE5Y/8iH6tkGNr
	nUL3KvZAZV7A2POlM6ppvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761289056; x=
	1761375456; bh=JGiRWD8YOtNH9DA0Gr25pzoBxlS1LafZwsTLQBCK/Mc=; b=B
	fcN0zLFg0ObUCR/jWxCJDyB5JE+678KKMlizS29A9JM5WozH5tbZCzYLV6jwDSxv
	yNTEdIdRsiRDjTEYhc8zdpYwDZGzs1dKjNHL9AC/V6MPYx+UwUO6YoRC0lgMScjg
	1nUtyFW0EhTyudOfxccRJsd48AaNPBtt0ui5GkSxyufY9tuyVogK4SeRqT1lu2xP
	kvsI2aNa1877hxMpuAIKybm+z/b9o6mOQd2RnLeeLsQUTs7OuFfKfLxq2P16Kbfz
	f4QTt+i7LlfqH9wIJYGei1yDtmhZ3/tHbULbwE1or3YjODRgdb5k7/a5HB49+1sJ
	41jYSSy0YbGcuFGPqMrhQ==
X-ME-Sender: <xms:YCP7aMtJ4c01HNYP_8yKmd_-1-PgkmGiVf3JvZ7OBANE1OahHrN03w>
    <xme:YCP7aAW0iT3GnWcLhXKVwz15oCVjAkGrUfvsXBBaH01PG4Pc0Kda9jpUnqjmMrPtX
    nEWwuvRUEkB1Y_sflqRkZJV959q8Ps2La3S8NPBBwMiNRxwm_twsLw>
X-ME-Received: <xmr:YCP7aAG3DNkKmnNtK7DXPHRmjiJvYC72Pg7HX_BfekKA12pQPP3ENZkuGU4o0ItGDpWtLRSpigE_z5GGeDsTQ3J_hVoIk5Ohvs0xAqxktA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeekieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:YCP7aK37Ye_isnfXPuO2p0kjuwma-peIiM4UvPrsULUvYG_xhJuQYw>
    <xmx:YCP7aKNTZzP3-2x0phCOih1_EY8bFugq-u2dgza2oW2wBzed1Q0L2w>
    <xmx:YCP7aB5oYzCiZyjgWMpJzx5921RbfDy8Csg5t5xBf_qw3_BhQ_sy9w>
    <xmx:YCP7aM2Qvz8zoRcD8RnJRoDC7H_zYOvK33kdfUsxLsSU0UQkQwYiqw>
    <xmx:YCP7aNPy5RBmFEwq8thexXsAQvGg62suieuAU-8dJkmSxrywioJlP20F>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 02:57:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 50941b02 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 24 Oct 2025 06:57:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 24 Oct 2025 08:57:18 +0200
Subject: [PATCH v3 05/10] builtin/maintenance: don't silently ignore
 invalid strategy
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-pks-maintenance-geometric-strategy-v3-5-9b5b3bdb4387@pks.im>
References: <20251024-pks-maintenance-geometric-strategy-v3-0-9b5b3bdb4387@pks.im>
In-Reply-To: <20251024-pks-maintenance-geometric-strategy-v3-0-9b5b3bdb4387@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
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
index fb1a82e0304..726d944d3bd 100644
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
index e0352fd1965..0fb917dd7b7 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -1263,6 +1263,11 @@ test_expect_success 'fails when running outside of a repository' '
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
2.51.1.930.gacf6e81ea2.dirty

