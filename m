Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997501A3169
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 06:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748846702; cv=none; b=ejo4Hl4i59YBrZft4j7Czg9lvLoWhJvcBZxfVJfMrtyBB7bBsUPBEBXYd8MBMg2j0QwN1wqAsi8L/IJEBvv92WOP8ri4m3G/+M9HIyIOzL17VkKrQAxnExfUHyJWgfD5xMieWi37zqrT/bOWenj+E8Anej1CB7qjI7hmNoSRqwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748846702; c=relaxed/simple;
	bh=std7OuhK28o1BF71O4rgVPAFRCO5yRmT/dmqdmPBep0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X2ZLsS+itxUCaS5sqjMJ7vzM5N25lxbxRgDDytWDgYumtFkZKd3DJpRvPf7nm44B4yX9qb76H0g59jr+wgeXkYYtdDXs9G3IXGjpIBAwvDeAZE+jeDpwHVNYPCGCaNSHSFRnFMVsDLqiGM4S0KuxkAyJPSqyEmhSTzBOT1YV6d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cNAwzcaw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RCaHphZX; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cNAwzcaw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RCaHphZX"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 9BF151140148;
	Mon,  2 Jun 2025 02:44:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 02 Jun 2025 02:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748846699;
	 x=1748933099; bh=lq10B2BDhCuE9RTonschPuHSlkVJc/0CLgqxpZvH4h4=; b=
	cNAwzcaweQ6xOdLJmmEYWGifDJv1bmgEZkidweeiNczB7t5ne3ROQxA6cVLUpNMW
	xV43Bn/2pdADCnXUCBsQkccnpDmIK5pZjWy0E95gosr8jqn4OcKgLWtuRt+Y52nS
	y/TZ/Z4+MlmI3kHtXqzNPjdKgjz6TqolRFay48X4R81ihdMAgqM0xveG5POJMZYx
	tYbN8fYeM9CNBtw5gc7PpbBhQshzw5qC7poADAeu/qlhVKCQx180Kfnde7h6rGJR
	tAqZmdMUACct2BB81lWGwnfKjFcJ24HlQRZP4TOx+xUKDnoPNOuL97oInVquQnDO
	NRyO+rjYOvTKjD+Q/6pS0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748846699; x=
	1748933099; bh=lq10B2BDhCuE9RTonschPuHSlkVJc/0CLgqxpZvH4h4=; b=R
	CaHphZX73NpOUGI3K95XYQ7TZCxmTN4qQOjtLioB9cz/S2MrXeCpJCJSvyzwLUV7
	zLe4E/b1takOoIWUys/wnbgboiaQ+wf1aG8X6huWuIpZLo0GfzaZQEBlKCY/+X2z
	07faNPAV99A34RVHpHfb1g+tNEj0xYNv17bwnRxx5lyC3zCLlvWiS9Lxk/Cbm0mp
	9ohXVUY3MqWMhhqhg51IO0J/8uPS738/NQELcY/12Lm8e3+ynXgwYHPltt881iff
	+fWEYNzi52mePzsB7AQ6lsrry+Qt+bQmWXiD9iOtWi37Pkk5YVHUxEuvrV5ObNlB
	bhadv7Xflhh9z4PvUEYIA==
X-ME-Sender: <xms:a0g9aH3qFnfV9H_1Pd_qCkEDK93FB1SuC1D8BYKenni_V-aMpL_-iA>
    <xme:a0g9aGFBoCRosDeorDHKZsJr8tcXIy8buvfFfMVw_X7_eDB1i8Xr1U_ED6wr1_d-g
    A8-IURe8ZiarScZCg>
X-ME-Received: <xmr:a0g9aH5Uxe2hWIUe0cm-LQZ63MSKSEU2qvJTNuJQXN_sk77U9-oJ_-ukZZc8GKmvAidNJk1p11cQLAHDGtHORZcXI4lIlkrPLCdtzmSU9f4VvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefieelkeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprh
    gtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehr
    rghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddv
    feesghhmrghilhdrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhooh
    drohhrgh
X-ME-Proxy: <xmx:a0g9aM2Z-fO40zSdcQwT6ERq10FKlksyeQqCATC46U5cLeQzy6hv4A>
    <xmx:a0g9aKFutOx6QALrSbUoVqdrgZoFOceid6pLBBmPgz3YhcYof8hCyA>
    <xmx:a0g9aN9civ9-RRcDLNXNqtVlKouVmMwrS5vof4kX23LUaUKJcKoFGA>
    <xmx:a0g9aHl2i48bTM5pDFSZ3TU7DBXMRfsrGfkpvLtH8mVWvwyC3_M-1Q>
    <xmx:a0g9aBbTd8gfZKcGPTS97u9jLUlyHzwOeL9bWgAPbhQAE0vqogLp9tlG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 02:44:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 27161984 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 2 Jun 2025 06:44:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Jun 2025 08:44:46 +0200
Subject: [PATCH v4 06/10] t/test-lib: fix TAP format for BASH_XTRACEFD
 warning
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-pks-meson-tap-v4-6-052dfde0818a@pks.im>
References: <20250602-pks-meson-tap-v4-0-052dfde0818a@pks.im>
In-Reply-To: <20250602-pks-meson-tap-v4-0-052dfde0818a@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Todd Zullinger <tmz@pobox.com>, 
 Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: b4 0.14.2

When the Bash version is too old to support BASH_XTRACEFD we print a
warning to stderr. This warning is not prefixed with "#", which causes
TAP parsers to (wrongly) interpret the warning as part of the protocol.

Fix this issue by prefixing the warning with a "#" so that it is treated
as comment.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 6ce8570226c..8c0d76ea5f0 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -470,7 +470,7 @@ then
 	then
 		: Executed by a Bash version supporting BASH_XTRACEFD.  Good.
 	else
-		echo >&2 "warning: ignoring -x; '$0' is untraceable without BASH_XTRACEFD"
+		echo >&2 "# warning: ignoring -x; '$0' is untraceable without BASH_XTRACEFD"
 		trace=
 	fi
 fi

-- 
2.50.0.rc0.629.g846fc57c9e.dirty

