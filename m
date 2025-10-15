Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F163E25D1E9
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 06:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760508262; cv=none; b=Q0ZS2EbrEvyWUhh81JEbR6auiy7IoCBo78NGDz0m4NiqQHt/bxY67whtxQhb3UqCe/GpU1RADJ/MH57jKFf+X0roBM2xc90GpevMDucxBajjm5K8EsZ9edCKXDLgQAWbEjOspy0plg6bFee4tiNsW/ytjKXuQhyF2XEQVuD+DHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760508262; c=relaxed/simple;
	bh=w/JF1Yw1aRUvGyLU7KMCs7Itv0DD9olFJ9yjM9XhftA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TCQzOjEDc4WaSGoovRPgpgddgFLoWxFnBB8k0V2AfCI8yTJLU3nUylo9iOg13rYEOYs9b4XuyOwsFTHArKeyTEwc4g3MtM88qSE3NBb8hzEzdtDI8YIXDJEuURX9WPY0ZZB710hPXrr90Sxf5iuk7L8gSFvkGN+qPUXdslPIrSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gp/coIip; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kFZtp4GD; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gp/coIip";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kFZtp4GD"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id DBE601D0014D;
	Wed, 15 Oct 2025 02:04:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 15 Oct 2025 02:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760508258;
	 x=1760594658; bh=yQGmefshFpXaFMefKCU3VT0pU2iaQVrCMjaoZmDWiBY=; b=
	gp/coIipp8s2JOwZjv95+WESL7wlj+C2ReXP2AHVpWfXdC1PZMnOJD+kFM6nMCXd
	n8A29YLEP//pg6YtkFoL9a32TBsyvlnbmNURJsE6REK0NCdLtbNxkYbusvJPJpcK
	bQDidR4LM5YcVWoug4aOccEOS7I18Xr8VMI+181i2sSq6nMWBuCC4PTpjFqZo6ke
	98UXok4RkgGlPVGLZseJXKvxjIbHMZHzB4zH3drHqk1C73n6qePXYIswDDO/Wp/x
	Nlzu85kQ192k6N0kKfr/SkQHGqUr8ALnILjyjNXTYmcfsRXKSY3W6GggsPsedL6q
	9KYQYbZY68MOqph0GsqAcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760508258; x=
	1760594658; bh=yQGmefshFpXaFMefKCU3VT0pU2iaQVrCMjaoZmDWiBY=; b=k
	FZtp4GDo2aFQkd4/nSHdHcqSu6RB1U/GfOy5NSiIQ1TGUfNeRdNyqbGqAc4bxZxn
	w2vo0TDN7vxDSbr+JY4OrkfiEKhO/66W5Evbh7f+CXW9zPYpTnTOtmsATplh0CVT
	WA6EnFD2KVels7/HcpIZ/AbPJFPVa0a6lUNNQNI8ThIFomyUXY3p42KI2wpfFe/D
	al/ja3bzsJa6Zi5S8glYG2gG0M9m6gBb7SMALntAKOflpkUa2szIqSCkS6zn8cYT
	KuiVwqpY5TiKf2gzV37Az4/hvPguymN5U3PkNRb7ZmnkYTBEKThK0lVK89ESGGz2
	jRBoXpP/++VBVaybksziA==
X-ME-Sender: <xms:YjnvaBRze26g9VdEcc6-8Qr8CxPRD848Bsp61AfxfanS48be2y4P7A>
    <xme:YjnvaJ3yzPB_m_85M39WT42u9By9AKCNxX0nnvsL45qKM1d-uy2fYQ-YWrL_WlMZJ
    f9-yMGSekiWzwTs4sLPIpXNYTzMA3UKRs4v3mtpv8ANHx6axK6qlA>
X-ME-Received: <xmr:YjnvaNAYhQvtpTrWwNUcgg5VvJ7uKyMpLeGdVMrhSko4BvFkzJTtXccyl4Q-3ACKtzevmYWDaKSbS6Y-8puyb6L-UJ2nyQ6K_rUEquGf3UyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddvieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtth
    hopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhi
    shdrthhorhgvkhesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrh
    hushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopegviigvkhhivghlnhgv
    fihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepvghrihgtshhunhhshhhinhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:YjnvaFiOnzBNYcey4F4G3oB3coLQs3TlS4E4HQyZuVQP9iNJ-QhZGQ>
    <xmx:YjnvaPM5Mb-al4PDhe8ez3XR-7zWaar-7a0eANBKZ6sAx2b3oJTPzw>
    <xmx:YjnvaF_8wainlNMzkFra8QJ5jtkBlQBnIiZ0zhM-4zthyCgkCEzPaw>
    <xmx:YjnvaAcfra_zahQbDGYcurJrbjHEp774DaOXI_iuELv6hhZ6iQzGhw>
    <xmx:YjnvaH9nuDOi-_DWiQTw2FTWqvoIxcL4NRG1lN45gmxmHGRENyybnKhz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 02:04:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 873c523e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 15 Oct 2025 06:04:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 15 Oct 2025 08:04:05 +0200
Subject: [PATCH v3 1/6] ci: deduplicate calls to `apt-get update`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-b4-pks-ci-rust-v3-1-13810af33bd5@pks.im>
References: <20251015-b4-pks-ci-rust-v3-0-13810af33bd5@pks.im>
In-Reply-To: <20251015-b4-pks-ci-rust-v3-0-13810af33bd5@pks.im>
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
2.51.0.869.ge66316f041.dirty

