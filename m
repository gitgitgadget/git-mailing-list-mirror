Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4623832F747
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 13:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757597119; cv=none; b=l5xrUWJI3U6AgyGY1YJgS45FcdmjOP1UahN27/6JaFpZhPnuj3n47+uG8ZaRLKLe/auzQPoSd8ShGW8VeZ48rlbp6/Q5nsuToRKccAdzujtnPy+2XwoWRFV1ObzxELNehydK9oxZDDMqHEqlenxjOOjUNcT5/B1M+cG5/IgDK9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757597119; c=relaxed/simple;
	bh=Tft3AnLTRBg6z1+sOlgEA+Qvz0lx+oVIH5zyyvez8mg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O2NRBIk2vwYqtt/qpbZXtZV7VSNK6ixx795denWuiBXB0XcU8oukD5a3avUkgVkIicRMl7i9evhOyQKTc02SqHNmctHjNEQhSkNgOnPmH7hjntml6QeEzMhSZaYDRmOF1W3B/P1Bus1BeKOHwIwQHvRJ8+HmdhbFvVg9c0ePqRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P4t79i1H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gK/RHxIU; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P4t79i1H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gK/RHxIU"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9520614000CC;
	Thu, 11 Sep 2025 09:25:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 11 Sep 2025 09:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757597114;
	 x=1757683514; bh=rgnKTlD2kpJUe9MMNeUpmv6YUcN+wu1Inywn/E3KT2c=; b=
	P4t79i1HlOB4bhViwDUCDAqHavII303TmpCeFXFih7iajrY/za/nJXlr7d0C0BdK
	yll84aWJO/t4f0AiTu85ic3zHYNzmbgRD8WpqHiwsr5BXpTYsMldtRR9HixZyxSJ
	J+KhVTdlQ5OkH3P5SxMpwmNu2HJVQu0YRIcvUaqxFjzc1CW3nyh5sNeUd3kLnj4f
	5cJZqzfJkPpEJjct4rrwzFTkRsySmQod4/mWIIlC5ED+oNBOeHHglZXP/LUxQWw7
	vTTpQGPz2WhiHPuWJ1eMO8icjsdZ8zhGmVL3YjWOftjoqbK43T69+rp7nBxlPGo9
	b9TWKnWfY18yVU5IqMCFeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757597114; x=
	1757683514; bh=rgnKTlD2kpJUe9MMNeUpmv6YUcN+wu1Inywn/E3KT2c=; b=g
	K/RHxIUbn6Wi22QkuB74zJmDLG/BR29Fls1CsSC/CgdH6JdN/RAaUJPsfwDid12u
	MnSNbVRIyHVXPNJYO9zg4s8h+TEp9jCf1VvYZcRiaSN6zkJNZX8q8I4QI0FzPRnX
	iKDoPocg6L34g+XxmvaEusXLfoRMLb9T8tTh5y8CjEZNHe0IaVD/PcV+v0el994V
	OuBp3x+xXutkP3+FAYZ1PJIamGnhmM8OHk1czlyTjErLif55F4PUOcfU6nRXzq1z
	DkFOv/YifP08MeTLL1m2Cq06G6J0Qw+C+/Z50Jrits2T50PNRt/uj872VMsK4u+H
	+sVJpHTCNqPkE1ftVZBZQ==
X-ME-Sender: <xms:us3CaDPqfJNfL3kU_q4mLpi1qbukhjNBgAHjgiI5QHKx57i-q3wBiQ>
    <xme:us3CaBOSG1wf6KjEgjVSUMkt9BOeXCNsDZS-2sw2qB3mRQMEl-tP9gv1Nbjkiq9-d
    rhxDO8FG70HvEbxTA>
X-ME-Received: <xmr:us3CaLvHSAnrnC_tWmX_v_IMlAQCq0slBggakX-6fu3hFkp5oCPlW7ioQ7xVo41BE1e18u0MUZMq25xyEYqx-PEWXYxLVd9s15jcp0rS-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddviedvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:us3CaDWINAxyVd8EFt7aAPO9o03Ov1lMCaVWvLHbZdAMB2MITnD79Q>
    <xmx:us3CaLsdK_bJ3UCIC0BMhM8jGywoxwAUHO79CnRYgLuQq5KAdgh-Jw>
    <xmx:us3CaHW0SI2-9o7N72i8nVMDnMJGQC6lYjobNuFi69aUNc0ojnD4Ig>
    <xmx:us3CaGm0IK-4lPtZYELaAIw8yv4MR_NqKd7ED0f6PJm29u6ocbkTUg>
    <xmx:us3CaF08QSjx6kTD2xAGhfpDKqUhx54AAcQ8EHAgmqpMLa4CMDjDYU5N>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Sep 2025 09:25:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 526a9ddc (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 11 Sep 2025 13:25:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 11 Sep 2025 15:24:58 +0200
Subject: [PATCH 5/5] builtin/config: do not spawn pager when printing color
 codes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-pks-config-color-v1-5-3a7c79df65b1@pks.im>
References: <20250911-pks-config-color-v1-0-3a7c79df65b1@pks.im>
In-Reply-To: <20250911-pks-config-color-v1-0-3a7c79df65b1@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

With `git config get --type=color` the user asks us to parse a specific
configuration key and turn the value into an ANSI color escape sequence.
The printed string can then for example be used as part of shell scripts
to reuse the same colors as Git.

Right now though we set up the auto-pager though, which means that the
string may instead be written to the pager command. This is of course
quite nonsensical: there shouldn't be any use case where the color code
should end up in the pager instead of in the TTY.

Fix this by disabling the pager in case the user is asking us to print
color sequences.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c  | 3 ++-
 t/t1300-config.sh | 9 +++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/config.c b/builtin/config.c
index f50c11df57..6708d91814 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -919,7 +919,8 @@ static int cmd_config_get(int argc, const char **argv, const char *prefix,
 	location_options_init(&location_opts, prefix);
 	display_options_init(&display_opts);
 
-	setup_auto_pager("config", 1);
+	if (display_opts.type != TYPE_COLOR)
+		setup_auto_pager("config", 1);
 
 	if (url)
 		ret = get_urlmatch(&location_opts, &display_opts, argv[0], url);
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 40f170cf40..26111c175c 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -9,6 +9,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
 
 for mode in legacy subcommands
 do
@@ -1100,6 +1101,14 @@ test_expect_success 'get --type=color with default value only' '
 	test_cmp actual.raw actual-subcommand.raw
 '
 
+test_expect_success TTY 'get --type=color does not use a pager' '
+	test_config core.pager "echo foobar" &&
+	test_terminal git config get --type=color --default="red" "" >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	echo "<RED>" >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'set --type=color' '
 	cat >expect <<EOF &&
 [foo]

-- 
2.51.0.450.g87641ccf93.dirty

