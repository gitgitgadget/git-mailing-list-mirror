Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED57C19F42D
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 05:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743656771; cv=none; b=pei7d8ozCYqAeS0mYXSceKjALm8f/FsB4/hB6RvLybNe8TyP4gfAZ/hg4SFnF/ZmB/wADwWnc+Ds0jMgzD1DytvzH34JG+oyud13bJK70HJZV4hgyIQhRs0dWkEXJadDs9I4pJAiES3+a6EjPFXs4kmWG+ug03ZnibF+CBms4FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743656771; c=relaxed/simple;
	bh=LO4siAgF5CQ2IxGrWXtdGF5zitMZxBUQsj5kr7BdsCI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XVfuI/WebaAbva0acSAAX2nSs27QUl7eDiFn0/DU59LjIe4IWoyRe/DOGlkXOLidWiqaxlLmOACsOaDfQQWBhFXvItkDKhcwIul6JD6AlAQ9yG48eKAm6BYTysLXJWh3brDhIg3Jo6Q2TXOgbqPRtfmZxwTGLfnS4MAAPTjnse8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Nd/KBfRX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dh5ntkl4; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Nd/KBfRX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dh5ntkl4"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 12B9125401F7;
	Thu,  3 Apr 2025 01:06:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 03 Apr 2025 01:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743656768;
	 x=1743743168; bh=sepCKZOLMpDbOyWyAlQcaajjn7kIsX0G4sgxQHAL97g=; b=
	Nd/KBfRXZPH9iD+PL/KXBVXn1roLBed8mYLbh7WeNCkyQDi8XeX8ChNHl4MJCrB7
	Dfv7rfO0zlgQZYAVXce8Bnod0LyoWxJOvIod0gQXFVCQovQ6TbvPQYMhbhAR9aV5
	L7xAQWmzQ7ictM5EtMsaSXvmxQltqZy5luFYKFSmi6HYci3rDnkp2Ljabv06wUkI
	gq00EhDAF7ATVLNQejvn97rkC7Aypz56Fd1CHXJqmTptti63Lqvs+dtQTBz6rkMV
	j53RvHnLRltwjoVubJGpcVQMkEaYlHyFv9bczcBBm+bfKjrn9VR4zqW764IDWN5x
	Nms4faohn6qnecCiqwW0Kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743656768; x=
	1743743168; bh=sepCKZOLMpDbOyWyAlQcaajjn7kIsX0G4sgxQHAL97g=; b=D
	h5ntkl4J/CzE3ew7r5D+8qKFJl4nivR1eVxAeDjgbT1FAONFNe00QpW5fj0s0+so
	1hx3B18vv4IY4zgg70iAAHDjwDmIspHVTrHFGTULSmtQy0u0jQwwxBJa8WUPwlXW
	WdV6kuyAMJHdNkDX8mbqjKeUP873wjVQ6g1vjpMSMak1yfTkjlbyWc7WBrvJqclW
	v179pqK2zI5ozk4Sh8EcDUcwK7y3ip4S1PqosKzxbLeqUCOe5vYh+7pcvnHGFknw
	vnS//KzNbo8vi8Mij26QXqT2ovXSTmZ5KTJcEbyar4/3MmQggpHWd4dGnt5nqlGE
	NVNQTCA+3wz3L3nwgxPGg==
X-ME-Sender: <xms:QBfuZ-epahqttvSZVUccOZz69gq923ebhhkhINy0UgSHuEiZE35Zcw>
    <xme:QBfuZ4P9-U6wmjlfq4wMem6L3uzP500IU98s2y3suhLo-xNpKTqxY2i6xysrdyGp5
    0eykF5nIRouAWiO0g>
X-ME-Received: <xmr:QBfuZ_j6WIAWuLFV3whwOHCbkBdLolvKzKuqzltwRd_4p2z7TQAIaBVKLrtcmzleFigBR3jB75JGmVE7Mdn7IhU6G0L9vmL1oYJ52KQLgpJAbbE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeejieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohep
    shhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:QBfuZ78X4UhfQidfCzniq1UaYAYjf9qvW5wobLwNx8I8fC-kRxlQZg>
    <xmx:QBfuZ6t6hAXUF7GQt3KwEgD3D-rWH_ynIh2XEUxo6sOMqsIN3eetPw>
    <xmx:QBfuZyF5KEDXGN7x2gqTiR5Cwxzv4JDKeQrze62fAo98lXY8__Tfhg>
    <xmx:QBfuZ5PKGGkPlxB4-g2Q1GVRtGxx6Q1xxXlB8si5PXZZCOQpNT66bQ>
    <xmx:QBfuZ_hwtOr6BOZWSmWkGvVGjtBjw6kBITevhOgeN8AdEqgONnmv8C_I>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Apr 2025 01:06:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ef2d58fe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Apr 2025 05:06:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 03 Apr 2025 07:05:59 +0200
Subject: [PATCH v4 08/20] meson: stop requiring Perl when tests are enabled
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-b4-pks-t-perlless-v4-8-be20ac3db39a@pks.im>
References: <20250403-b4-pks-t-perlless-v4-0-be20ac3db39a@pks.im>
In-Reply-To: <20250403-b4-pks-t-perlless-v4-0-be20ac3db39a@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

The Perl interpreter used to be a strict dependency for running our test
suite. This requirement is explicit in the Meson build system, where we
require Perl to be present unless tests have been disabled.

With the preceding commits we have loosened this restriction so that it
is now possible to run tests when Perl is unavailable. Loosen the above
requirement accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index efe2871c9db..d6e27b236fa 100644
--- a/meson.build
+++ b/meson.build
@@ -772,7 +772,7 @@ endif
 # features. It is optional if you want to neither execute tests nor use any of
 # these optional features.
 perl_required = get_option('perl')
-if get_option('tests') or get_option('gitweb').enabled() or 'netrc' in get_option('credential_helpers')
+if get_option('gitweb').enabled() or 'netrc' in get_option('credential_helpers')
   perl_required = true
 endif
 

-- 
2.49.0.604.gff1f9ca942.dirty

