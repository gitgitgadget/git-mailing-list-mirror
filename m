Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F1125EF90
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 13:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908469; cv=none; b=dnuc+v0vGloBjVfXslWuNTd/0U3dcckC2QBTLYSbcswYcOnoBVXV9xR9ghvJfRlghjGDtFVIZ8XQhV8ixPLdgLp+lpW7V4Pn9/3hEgq41DyLT2gzXQu4mj7ihlUMtNeao74I//pxy9RG5uztN//ajKEWqfbVDRvG6HFaGL9exbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908469; c=relaxed/simple;
	bh=mnP/eIeyddsprQjbJ5j4kWT5R94K7zpMiz8gFfvNNhQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SVSdUqUpwqJ1uAw1sANugm+eDS1ZAjnB/k4tASr+fU7h3a710QcJF6+6s5CsyGYBzm2CufRtogZ4vrDAkqod5YFqFR9q1s/7vsLhMR4XJg/twcT4+SdW1YbyJRSqDReK85SVGyjhEOEiQupAatbeg4jjV1vzBP0MPH6O+IiPUes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YmL+182b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pGaNh9K3; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YmL+182b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pGaNh9K3"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 7CB551383842;
	Tue, 25 Mar 2025 09:14:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 25 Mar 2025 09:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1742908466;
	 x=1742994866; bh=06AlNuR4CTpgnkt91LHbVtA+Vq9aPaC5SAotSYkUmBY=; b=
	YmL+182beBCTEn5Fn/Eypn+XESjzobZNz/xJWiPZQgRyn0XuX8d1LtpJ6rfRXTmx
	rM15sHTYjuzltIUEVDEXnm/UPCG0+cnVPgKAPFaeHpO9+urI7cr94WlkHd7GjkN5
	pRIU3uQ90Vnj2Hme00es9uFc+untGAehAIJbYVV9+GI79PVAKXXxUlVw2Laqx8HD
	EA4SjnqG3gdS37vcvwdLlrvmyLhSWFCH9CXRgw9c5Bd/AoVirT3FwusKwYEFtu1r
	/GkZRGBTerq3HnpXVtKVXEIyql4gc5j41UyLfQX8hbFMsjXr36cle1Apl+Xq8FSj
	ndnfEaqELPYufiIlEAPngg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742908466; x=
	1742994866; bh=06AlNuR4CTpgnkt91LHbVtA+Vq9aPaC5SAotSYkUmBY=; b=p
	GaNh9K3n46ZHq6X+aUAqTx5OY09HTaladVR40ATarHI5YuQbVkLFO2UsuuSAh+Q3
	dr72TyzX8A/7AfkqJ7j76qfqsFmGzYbTakblDBHEDLgTbLYXOogslBwbaASDfpjl
	ALF5Awb+xCfKwUE7WHOv4brS8vzFTwOKL07ALFAFl3X6qusGXW2746RFd4RE+uMW
	Q6m82ttKtsMRp1ajH/r8KCW/gL9/nO7BDi+32HhQpls2c24EHOhorDkwEHr7YcyH
	Ij9qAKi4R9ueyHbwp3LzsDNOIoOzs1ai1qiessvUg6UEBA9K017rkuHw5aJAbbfT
	9JJkiZG4tjK05IEWt8CiA==
X-ME-Sender: <xms:MqziZ28XDGvcWLX9r-39GKI6XBhcQDIh-Mlx1K4gOe0woVvmazYk3w>
    <xme:MqziZ2vQfZUJNxrTBjETs8rRG6L7jgm6Qyko_bdUaVCqQeDpbzvtEFsxtL0CgT9Jh
    30Jku3__jWjIlnSaw>
X-ME-Received: <xmr:MqziZ8A31pPquEyOcGF7mqRCTpPmqNOYZrDqUr7KjO7qu5SSaTuHRkMVzDzPoDvTv74HPV39nxrMMRl2sEBlUYwh2lx4B_tji-keoEFLkmZD7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdr
    tghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhh
    rghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:MqziZ-eoL5IICqy3hnK51YnaE5F8BuQstr9ATEU2jVTnxFHXUJAPSg>
    <xmx:MqziZ7M4QlMCzRGJ00zBM2pmBhW2HcY_eDsLHupplZrOsMFdIiPthg>
    <xmx:MqziZ4mSDfK936LdHrD9Zqy7_HgwsQvbIx4xJQ-0ENCoGb3pA3B3ZA>
    <xmx:MqziZ9sLWJjPzT9O-l_1nJQIx99EyuJMjR1Y9W8VT7dHH6Z8ofUZ4g>
    <xmx:MqziZ211eiiYvrkljeYgLQDdZqtfiFgyDwcayHOQhXeXfJiO9gLcz7Fp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 09:14:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4a49ea95 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Mar 2025 13:14:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Mar 2025 14:14:20 +0100
Subject: [PATCH v2 02/20] t: refactor environment sanitization to not use
 Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-b4-pks-t-perlless-v2-2-4b87b8072670@pks.im>
References: <20250325-b4-pks-t-perlless-v2-0-4b87b8072670@pks.im>
In-Reply-To: <20250325-b4-pks-t-perlless-v2-0-4b87b8072670@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

Before executing tests we first sanitize the environment. Part of the
sanitization is to unset a couple of environment variables that we know
will change the behaviour of Git. This is done with a small Perl script,
which has the consequence that having a Perl interpreter available is a
strict requirement for running our unit tests.

The logic itself isn't particularly involved: we simply unset every
environment variable whose key starts with 'GIT_', but then explicitly
allow a subset of these.

Refactor the logic to instead use sed(1) so that it becomes possible to
execute our tests without Perl.

Based-on-patch-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/test-lib.sh | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1ce3b32fcac..a62699d6c79 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -499,24 +499,20 @@ EDITOR=:
 # /usr/xpg4/bin/sh and /bin/ksh to bail out.  So keep the unsets
 # deriving from the command substitution clustered with the other
 # ones.
-unset VISUAL EMAIL LANGUAGE $("$PERL_PATH" -e '
-	my @env = keys %ENV;
-	my $ok = join("|", qw(
-		TRACE
-		DEBUG
-		TEST
-		.*_TEST
-		PROVE
-		VALGRIND
-		UNZIP
-		PERF_
-		CURL_VERBOSE
-		TRACE_CURL
-		BUILD_DIR
-	));
-	my @vars = grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
-	print join("\n", @vars);
-')
+unset VISUAL EMAIL LANGUAGE $(env | sed -n \
+	-e '/^GIT_TRACE/d' \
+	-e '/^GIT_DEBUG/d' \
+	-e '/^GIT_TEST/d' \
+	-e '/^GIT_.*_TEST/d' \
+	-e '/^GIT_PROVE/d' \
+	-e '/^GIT_VALGRIND/d' \
+	-e '/^GIT_UNZIP/d' \
+	-e '/^GIT_PERF_/d' \
+	-e '/^GIT_CURL_VERBOSE/d' \
+	-e '/^GIT_TRACE_CURL/d' \
+	-e '/^GIT_BUILD_DIR/d' \
+	-e 's/^\(GIT_[^=]*\)=.*/\1/p'
+)
 unset XDG_CACHE_HOME
 unset XDG_CONFIG_HOME
 unset GITPERLLIB

-- 
2.49.0.472.ge94155a9ec.dirty

