Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640E82E8E0B
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 06:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759904852; cv=none; b=JPwefU3jvQmIoW/MqaW3VugWWtM6B+bxTdE0dofcZG2EqicCKKjbk3qVTn+ovZRJGm3uuSuPeyAirXelBWqx+rIJ0SIDV9eV4WYWNobicAtUBwTxoNnDkGiNWFiJYm/B7YTchkKp60luZMfsXDTe3UwjB34jaN0GwIOfThVCdEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759904852; c=relaxed/simple;
	bh=X48fVcXeWKLezWR5uO8U7U7OPweTAnWcyK7+CYgwNks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o5VPHTX0bX/coq4G2QNqu3ZZuv0CyxHNzKZAkYq1ofM/COOqTxouNHneq6TF/pCSk6TSrUt7ouEHAs0xVV+l4svB4XRPrEInpSO4sCcDJ4f2lxTbd1m+GjY5HbzVD0DOGddNVkPSkj7ur9iSWC3Rbxcc6CDiaJ0Oflvsd4smUnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lrGkOOsJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XbuvPZLG; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lrGkOOsJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XbuvPZLG"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 686427A02C1;
	Wed,  8 Oct 2025 02:27:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 08 Oct 2025 02:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759904849;
	 x=1759991249; bh=m8Rbpp5ZNaIJBLJ8IQzCb1aLUcdUb+V8HPltwOlrYeE=; b=
	lrGkOOsJvARHxjW+GENjoe7WZjqvoE96lwzVdzXWAKTBVZs8AxjS5kpJPrwziLMu
	9rz2NAYN3Qqr/ekzPmc2iGGmXCBDIHdjvE9SkJqqIHR4ctzaSOFFOOFTRuZLLC5S
	/g0oJwrBn39Di6Bd0hR3i6GEvKKf+6V33znpoxDFGiiRHY6UI6P67PrrVzIaF7QN
	g/5j2k7BT89Fe1TLRi4+wMJKdvjBa263syl/Y+BRhEBn7NvAOS4+U5slqoijx7hO
	WtImKxKCAaopIp+SOa8XUQnFq7P3Xe/TZiq/OekOgeR9a/efWZDvAHsjGvZ61sHt
	0eqLQ44VF2+jkWXT6RbDLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759904849; x=
	1759991249; bh=m8Rbpp5ZNaIJBLJ8IQzCb1aLUcdUb+V8HPltwOlrYeE=; b=X
	buvPZLGXKdW66p5piQ7n5DbhuNisUtkKAzvtZKrbcEYqYDbV9OWEZg1QIBLJaRw9
	iBT/4i1IM2PpkHOErxAQL2sBdiVfApIvJFdp2wRJZ0KIF6Wn4NAAqUK/NmDV7ri0
	/4UbBJyjKUb4x85V7pexiYExwsHOFjT8gG89h51vlh/o62r+RIlEimz+1V6tN8Rc
	pZnazWLlNgSreKJKj3uH6zTWXguE0Hf7v5D4FoeZU3UXLjwbhMnOthDUqZesQhKx
	gEFl//HFaj2K/fcdismImdArhipJg0EZd40hyR39w6uFQN5Fe9jn1Q26VL0x+Nkj
	9N5wOIKCmtL9G859VJz/Q==
X-ME-Sender: <xms:UQTmaG9pwrc0WlPHECoWE7rdyyatBB3zH8n6KYaLm1Vi3j_cl-umaw>
    <xme:UQTmaFyZPeulI9d_egOC2WmwKXqrOjvHKyiTOmp0wOOkYCfT2jY4YpLve-CCh4ojT
    OKxyBiL6SZ_KVRB8IjmhY7gR9satmzhp8Fxt5Rgwwzx5mpTLxpk4Q>
X-ME-Received: <xmr:UQTmaCOyXz3HhM55uuX_HLxxORnsNHkn97nvCMqmUuDECBkCa3e54ycw7GgZtfwB5HU5SWWr4ibh9uLMxHbSVODsSFvteR-GmlaTEdNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddvheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtph
    htthhopegvrhhitghsuhhnshhhihhnvgesghhmrghilhdrtghomhdprhgtphhtthhopegt
    hhhrihhsrdhtohhrvghksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:UQTmaK9o9yLiCEmg2PVsoziNc_EtTY1_wJjW0UgIm28GSm8MslXV9w>
    <xmx:UQTmaP5a95bTlJThRNAf_s-7fqA1r4m2rsi9GDNHun8p66Qo3_N7FQ>
    <xmx:UQTmaA7w8YnPIhtSUNcwFLV8HeM4xKX5jxg0VPJBqjj6gbhNzpwBag>
    <xmx:UQTmaIoaWw1vSOMKXby_U2PXPpU0E0IJVq3ygyiZVtvQl8yqGXk6fg>
    <xmx:UQTmaLTtpqG6k-lnw-D40GC6GUK7xWyRqEJyjyUy0YagJljCfQlBOPRr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 02:27:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ab9df59b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 06:27:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 08 Oct 2025 08:27:12 +0200
Subject: [PATCH v2 1/6] ci: deduplicate calls to `apt-get update`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-b4-pks-ci-rust-v2-1-d556ee83c381@pks.im>
References: <20251008-b4-pks-ci-rust-v2-0-d556ee83c381@pks.im>
In-Reply-To: <20251008-b4-pks-ci-rust-v2-0-d556ee83c381@pks.im>
To: git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Eric Sunshine <ericsunshine@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Chris Torek <chris.torek@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.3

When installing dependencies we first check for the distribution that is
in use and then we check for the specific job. In the first step we
already install all dependencies required to build and test Git, whereas
the second step installs a couple of additional dependencies that are
only required to perform job-specific tasks.

In both steps we use `apt-get update` to update our repository sources.
This is unnecessary though: all platforms that use Aptitude would have
already executed this command in the distro-specific step anyway.

Drop the redundant calls.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/install-dependencies.sh | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 0d3aa496fc..645d035250 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -120,21 +120,17 @@ esac
 
 case "$jobname" in
 ClangFormat)
-	sudo apt-get -q update
 	sudo apt-get -q -y install clang-format
 	;;
 StaticAnalysis)
-	sudo apt-get -q update
 	sudo apt-get -q -y install coccinelle libcurl4-openssl-dev libssl-dev \
 		libexpat-dev gettext make
 	;;
 sparse)
-	sudo apt-get -q update -q
 	sudo apt-get -q -y install libssl-dev libcurl4-openssl-dev \
 		libexpat-dev gettext zlib1g-dev sparse
 	;;
 Documentation)
-	sudo apt-get -q update
 	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns make
 
 	test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||

-- 
2.51.0.764.g787ff6f08a.dirty

