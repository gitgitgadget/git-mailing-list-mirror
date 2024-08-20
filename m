Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F871917D8
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 14:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162553; cv=none; b=AFiudyJWEY5imKjBson4Imj0+jekyrYTgfCdMFfXLavtlh3qu4TquB/XJDgNopByrhCeUhWNttlmvciTUUHFjfb6Ka6FWY/UiBbXn0qGYmr4QTUx8yReFiRhjJXviIGOLoqn/3a8UiBTnmD9xgs9nXbVd/ZShzj7sv0Ghbw9Grs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162553; c=relaxed/simple;
	bh=9gFZuQuT6ls7SktEBXAM9gv+DuGgKWdrqyOm4Dj7DYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfl50t6crgc61WGRdDe2ZcqXxpcr1sUWIS+QgqoGFzoLVNEN/m4IdCf8CEMXa1VBbAFR/JOZCLg1u4WvZboSDjuIrnMK8/4h0pgL1EwKNhoen6+4SRuhA2lRH5R6wHV+YWWdljBYmOkbum4n9OZE3TKraY4WqkSfqvFvun3fkn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Mce2JlO2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=emAzV/39; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Mce2JlO2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="emAzV/39"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 321F8138D31A;
	Tue, 20 Aug 2024 10:02:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 20 Aug 2024 10:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724162551; x=1724248951; bh=gjJRiUNlXM
	w6DKkURskyjWbcSb90BvjNnXE5DaG0xK8=; b=Mce2JlO2AU85E9nMP08fR4fUQD
	cYg+LLKqRMjJUacEcyhh99mSDC+4TJDcbcI1ARPONC/JxOW+TDEHIxCZ2jya3dFi
	XNmA43CFc9xiqjNVvSCqb3qT4R9DJf1EoZ9AtT3hclvsnpatQd+FcNUI7YupjdP7
	Esq85rhyh0DIq/z/OimB0SQcvZ/N2SqG/Vt7DkNrriOSdb62xKkq+RmBLhsGE8hV
	rCRHyVinl690ePkYA1sETrVwXmcnSpHcJxZhADqUkf2vpg3LIzIO0FHeAeCJDYFO
	vum/cEuwC4ZkEwq8Mpu3a78K+nL8wnfY+l4/64Emqp+RI5/AVotSLL64mQpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724162551; x=1724248951; bh=gjJRiUNlXMw6DKkURskyjWbcSb90
	BvjNnXE5DaG0xK8=; b=emAzV/39ZRlIbJfDW04btNRTB2n1Bur9FSlL85PnJsY7
	riVr1Xv9uRY/ENwMpmfQWM3wVzX52E/sEDU84i/ctFxJmsxl308R0EIHjbdEvXiD
	98n1TieaOYrXWF1TbjteBtKPfyx269zoSaV8U/aUN4l3nUEMlucSeMToo7OwewMx
	tMI8yEZt2YwKtUJAfzOCIdUyt0tKOGHzawViHI8HQt7LrUxWB7uXBpoI5cLDv1jm
	M03Ef2XIV984ESiE4T352cuwRjNzE7dTjiQd+fQy+AsnMR1KhXWQMMXngY8sFr9h
	70JpFfo5DMrqtnX5ISjz6JozFHp9bJ0RkphrLwKW6g==
X-ME-Sender: <xms:9qHEZgcAUtVYeyAVIh2uSbtgNlEd5f6Kvsk9Abk2yuvI1UvVby5Abw>
    <xme:9qHEZiNpWuAg19BgXZOyVzaFqWoA_yBV5I5VkI_Kb5vGorkO3iVn7Y1bhuOkqHOWb
    075-2odJjPqYRsMMg>
X-ME-Received: <xmr:9qHEZhiOmP6fv4yV3KERWZYqMZ9W3aw1EZEufmDAIA-Jz8VmMPNTeHD7C_N2iVVJ10YdI19iIdSEnAJhCf8O0D5ANVLeH2y-nFAd1dpHVHVCK6JYxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhephfeigfdvffdvtdeuhfelgfelhefgfeevueetffdugfeh
    tefgveelhfeuueevuedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrsh
    gsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphhtthhopegvthhhohhmshho
    nhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehsthgvrggumhhonh
    esghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhmpdhrtghpth
    htoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepphhhihhllhhiphdrfihoohgu
    seguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhih
    hnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:9qHEZl98oYlNaepZBW7gHskj8cHFxzQ7PvqkHMBXvVyitDrJ3o-AWQ>
    <xmx:9qHEZssSV_VY7U1H-BXpG5UhrKezEqXfHgMxpzRUCfdaOd5vaF1bnw>
    <xmx:9qHEZsH-_45yYiPpm5xMqy-_VQ_J_PRhcN-qEbGsAZg2uvjZvtJnIg>
    <xmx:9qHEZrNvaow5z0XscstSMUfeUBbd_t7MCt4K3cyYxINc2RmtEy1YfA>
    <xmx:96HEZuJyGk1D1fNZEs-ML4I4v9Yj-nwgYNM-euK1HbBKfzBhI2S_CtXY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Aug 2024 10:02:29 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c20afb80 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Aug 2024 14:01:58 +0000 (UTC)
Date: Tue, 20 Aug 2024 16:02:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v6 06/13] clar: stop including `shellapi.h` unnecessarily
Message-ID: <5fb4c55be334c084b92fd46a788afa9676cf5ed0.1724159966.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1724159966.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724159966.git.ps@pks.im>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `shellapi.h` header was included as of
https://github.com/clar-test/clar/commit/136e763211aa, to have
`SHFileOperation()` declared so that it could be called.

However, https://github.com/clar-test/clar/commit/5ce31b69b525 removed
that call, and therefore that `#include <shellapi.h>` is unnecessary.

It is also unwanted in Git because this project uses a subset of Git for
Windows' SDK in its CI builds that (for bandwidth reasons) excludes tons
of header files, including `shellapi.h`.

So let's remove it.

Note: Since the `windows.h` header would include `shellapi.h` anyway, we
also define `WIN32_LEAN_AND_MEAN` to avoid this and similar other
unnecessary includes before including `windows.h`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/unit-tests/clar/clar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/unit-tests/clar/clar.c b/t/unit-tests/clar/clar.c
index e2ebe551d38..cef0f023c24 100644
--- a/t/unit-tests/clar/clar.c
+++ b/t/unit-tests/clar/clar.c
@@ -19,9 +19,9 @@
 #include <sys/stat.h>
 
 #ifdef _WIN32
+#	define WIN32_LEAN_AND_MEAN
 #	include <windows.h>
 #	include <io.h>
-#	include <shellapi.h>
 #	include <direct.h>
 
 #	define _MAIN_CC __cdecl
-- 
2.46.0.164.g477ce5ccd6.dirty

