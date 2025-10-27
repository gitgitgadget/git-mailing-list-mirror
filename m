Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7FB2ED164
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 08:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761553875; cv=none; b=PDtxrUoSlttzCkdMM/+t514YE1hi6VzBg/d+3s3YKg/ctEGZ25RGw/1laAMJPtnxOiP8LsPAF2ZPrfk9I+Vx2rur+oD+em7C9DSIkXB3S8AcS72LIIenvw5lWn3CtrhIg9o/LEsXHEG2X/jDBbb25C1kzxSREjSEUm7yAvMvD/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761553875; c=relaxed/simple;
	bh=Aguiv0m7pN8TixWKFuxDDXIRcNbnsSlxx2zwsEOb9v8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T7BvV6acCC405k0H9BIFQG/N7P5Iibf9clDXwwxIV3YXfLwtQZHLzGarB6fcTRB9BhQEXN8bregjjO0Cfv7r1oPeoz6/wkagYfdOLRT3FeolxN1GecpyW+JoLlO0fgVREreL9T70qEU4h9kOnn9nwuHMnu7QTGh1yvoxfZ6aSko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AMQKai5R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jQUcJ0tB; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AMQKai5R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jQUcJ0tB"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id C0B7BEC02A9;
	Mon, 27 Oct 2025 04:31:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 27 Oct 2025 04:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761553872;
	 x=1761640272; bh=jRMo3SOng68TMq9rwlplHG6P7HrMxLHw6ucVu/9n71U=; b=
	AMQKai5RQBgOFWrK/4wfBhyl06bEY788YurvTVdYYm6yDa3mWUaf+CJg+Px6yP5V
	LcauGZiLDSMm3FJ4cFFjYlyiiLk4cYyx8pz8l5FDgg3VBL5fAFEGUn0AeuwIpopV
	i3XEfXrFIuAMXnrpHs5H6vsRzwSvyUl2G3blMpVkTfWfqcNbKsFFWwCudGJmhbgn
	uNYeB7zglJ4J0vxnInnIBcmEv70G0OTNpgZtpm/NSy6A6H/LsV4Z5ae6GbyyK9+2
	e4OQdmcZO9OBorBFcJA6gpLd+hVax3IqzU3EzLBxiyHGflNMWQF1BWhKRvQOgaxK
	qsY0xdkVdlGGqjcHoEaLIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761553872; x=
	1761640272; bh=jRMo3SOng68TMq9rwlplHG6P7HrMxLHw6ucVu/9n71U=; b=j
	QUcJ0tBjxDh0KZLtWey5DzrYBt5oTE9CUn9ZFdNFGIkPsGf95hoFqeldQcVrl1wU
	Z7gTqVqusTwnBTD9DGX2oEOESpQBv2fVBiXR5okE35kA2wPW1L4yz8Xvyh5BL5Tq
	emkq8jvgQUofcbS+bf9TsnqLNaZy0SsJ/1LPoGVYmL5BW6qY8Qf9psqB8S9pD/ET
	btuhWBkMTHPZokEvzGzawmwKfzQ8MtfYnX/PiYFU6FvioTNjm8p1g6PcTHBlwxkM
	djkxh5Dc3yHIzUTS4GSGujEHVBVP1g+sDmjXTJXH+pjcvqis1MjdBr8nk3jjvGGW
	hn0ZlI8+XoJQjmfAd888w==
X-ME-Sender: <xms:0C3_aI2GTE3b_NaZR8qaNwL9qFyHzJ_09LRVVmF2z6VyOnvConFGQA>
    <xme:0C3_aJ_eoBWzx_GecsUmZN4CLCBeaGBGoq5gjthGSjDEQAMjI-Q47SzpkboHkz-4E
    yFI9GS8nhdPd7fOiCTlqYPQDeErSzjtwRVkH4rmanVlKyXYm5ZQ4A>
X-ME-Received: <xmr:0C3_aJM2KH2Tgur5mQi89jdpMCIs4eiJPbYrn5540TItkAO0qc34UTkm5O3WIe2pF2IqrEEYJAi_f3TSU4i0lNiEuERuRSKrkGUL8VSs9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvg
    gvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepjhhlth
    hosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:0C3_aNd4TLryLS-Dxq2AiLwqX7eopfy_xQeyV4GE-eWl85aWwRj3ag>
    <xmx:0C3_aIVaahQ9D2NI4Npn_O65aN_JOR6kNoBhH7bjq7O-JgjpitGYOA>
    <xmx:0C3_aFhiNAuzqXbFtUCmPdt3N3_VHneteMeVnQ5rdYd6Jmg_f7JPhQ>
    <xmx:0C3_aH83AiUKI_MNyk9MCe12fCBYdXFSnYor34WrByS4x6_2dVh55g>
    <xmx:0C3_aL3QHK5FKe4Asn0hrY2XFCHB7txHs2zfz6GxzNdaV8BLt0xGifB7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 04:31:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9169b9a3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 27 Oct 2025 08:31:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 27 Oct 2025 09:30:55 +0100
Subject: [PATCH v4 05/10] builtin/maintenance: don't silently ignore
 invalid strategy
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-pks-maintenance-geometric-strategy-v4-5-18049e4a0adf@pks.im>
References: <20251027-pks-maintenance-geometric-strategy-v4-0-18049e4a0adf@pks.im>
In-Reply-To: <20251027-pks-maintenance-geometric-strategy-v4-0-18049e4a0adf@pks.im>
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
index 8fda6b1a6f7..211350bf54e 100755
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

