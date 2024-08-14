Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D49E7FBA2
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 06:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723618354; cv=none; b=n7s4q72/XIVP1iTFHSsApH7YdNMKRWGfoeFGVfBxihuPpy8KrGyVxOVqKzgreX1hddRi8HjeK+qD0f3ut3WgobFMys99YYSXC1keAN3L7j3qEqfx2enK2d8ZtN86zvb/V35F7n4RYdlQIf+ksexUULGViWy/ypgayE0dSPEIrSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723618354; c=relaxed/simple;
	bh=juzc8aVbhRv3TmNT88ZFDmZeHmiLlIoYG59Qh/jDPxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjtVI742Rzs1kh324avSX5ezq+WetzWIx26BCOphjmOftndSHwEN0dhu7Z9OZE9cGAIZxhTNQxN5aMibyonNyLq5aqMy2Ne1Ai860zp8hK8X/8qWKusHfNSyAqA3x1FCc+8IAZb2QsdtP4By64auODhomUGG7HYwSPACVWeSHhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RqLAaErN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u4gAhkWO; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RqLAaErN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u4gAhkWO"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8CB67114EADE;
	Wed, 14 Aug 2024 02:52:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 14 Aug 2024 02:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723618351; x=1723704751; bh=mra3V/ExgT
	J7jwORZFoO4Dm0oDnpB+PxfR64/nI4KqA=; b=RqLAaErN/xAYzn/QhbBPP30sT1
	b5elMO/U79ZgtO6u85dO5QYJVXZoqQmBfEO5M01aa8Ghu1maGHvCFpeziCaBBOYW
	QYoUa2L2t/UF8vXAKUfPznnVgGruk6XwGHsJs6X5OC+HNhdkTlFP8/7GwZXHY0ZY
	OW3UvqpwzxvVjiwyFmV0NtGtrA8z3JvU8PmjIh3B1jQ05am/4jD5Ujtu4+GY9NLh
	wpjxp34og1oS4aOLGFIkWtAQBP4LriKrT04BmJLgUfM2qT7TtVoH02jN3mW/+qC3
	gZPi9u7koOJuYheWUX1kp0fhNKzWnqRbdXULD9ZdC8ra7qoWxAjfVekVpNrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723618351; x=1723704751; bh=mra3V/ExgTJ7jwORZFoO4Dm0oDnp
	B+PxfR64/nI4KqA=; b=u4gAhkWOefPHi/EO/OX6bVNso+0xiYBLN71SNG75y3LC
	s4d2ia+OypOBZF9eOxCWN775Es2k/VacpeWHoQd8YCX48OTPs38AzEB8pvQgpjDJ
	h1b5YGZCmRKUSrjUdwNkIoFl0NdONBan85AthhDF8CVUqNnPjSCNa7ObpkD6a5Kf
	vCiQ/SVNoQsawQ00cZfdtcza0wJAhwRa4YpLDz04+NC+macKbiiRPgTeeG+S+ywH
	oTzB2flRlc3frmbgJYumaOXA/avHqdkOHL+I/yqwuayhZq7ikPnvLbFDiohaHjYc
	549wmjJLUmg8mpOw5qh4Bh6hBgyPamiXsXUxmq1cJw==
X-ME-Sender: <xms:L1S8ZhhNZsBXsumj1_l-2AdeFmNAGFcXhpzWK-8Xh8ZDMvc9lHeK6w>
    <xme:L1S8ZmB_6P5Nr5F6ybcPc4ufN_RIXrJbELghXG0ot4PGKlWLBYTRmnDt9bbkZ8AQj
    N4Y9n3IdJ139JbDZA>
X-ME-Received: <xmr:L1S8ZhHUTg-z-5BJpWYgpDoXvLetobbn_LKp_gUukMV3er4k0gML8y4d6veoJ9C3KD_bt7KhrF3TrXLxfZ2KxLoMhLMAndvMIpdYNAAJghYzCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtfedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpefgfeeuledthfefgfetheffhfffgeeiueekveetfeev
    gfduleeggeeuveduhfevkeenucffohhmrghinhepughifhhfohhpthdrnhhonecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdif
    ohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomhdprhgtphhtthhopehjrghmvghssehjrghmvghslhhiuhdrihho
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmvg
    esthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:L1S8ZmT9ptmw7j4MeQAxoYcI3VQndcPzdC3OC5NIuX3HwT_r1aEuUg>
    <xmx:L1S8Zux_NUAniP6XiN2HsJxKYzPT38vbh-VD4TpCvygDGG4QXX695g>
    <xmx:L1S8Zs4bLH7JTHwfMKXtael6Og2HzujKZLneto5ASBdm2ILPHf8Fxw>
    <xmx:L1S8Zjx8SBKFgoNFTiqKpbpe2LZt9ewFh109kgk5RNA_kBPYRRhuXQ>
    <xmx:L1S8Zlko4UBm53HMmCuZWeHd7VJs2x167_7XdAlndSKDiTOunQxts20e>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 02:52:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ee601daf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 06:52:11 +0000 (UTC)
Date: Wed, 14 Aug 2024 08:52:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v4 12/22] builtin/fast-export: fix leaking diff options
Message-ID: <070813a740566bebf50e771ec7d0fa4699c87a4b.1723614263.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723614263.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723614263.git.ps@pks.im>

Before calling `handle_commit()` in a loop, we set `diffopt.no_free`
such that its contents aren't getting freed inside of `handle_commit()`.
We never unset that flag though, which means that the structure's
allocated resources will ultimately leak.

Fix this by unsetting the flag after the loop such that we release its
resources via `release_revisions()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fast-export.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 4b6e8c6832..fe92d2436c 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -1278,9 +1278,11 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	revs.diffopt.format_callback = show_filemodify;
 	revs.diffopt.format_callback_data = &paths_of_changed_objects;
 	revs.diffopt.flags.recursive = 1;
+
 	revs.diffopt.no_free = 1;
 	while ((commit = get_revision(&revs)))
 		handle_commit(commit, &revs, &paths_of_changed_objects);
+	revs.diffopt.no_free = 0;
 
 	handle_tags_and_duplicates(&extra_refs);
 	handle_tags_and_duplicates(&tag_refs);
-- 
2.46.0.46.g406f326d27.dirty

