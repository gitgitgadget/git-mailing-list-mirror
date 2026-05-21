Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4493A3E9C
	for <git@vger.kernel.org>; Thu, 21 May 2026 07:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779349376; cv=none; b=t7O+nUn/Y5cWh+8jHTj5EhFMoRpaFU+c6b65h/RGldKuhOfwCA4E0SfbFTEnoPWtWdOc746OgfhqKu1DPR2B5kKRXv0Y54NUTBvohyqPjO6mGowXOafngECgmCOaXqXyotXTWrfLG2/ej1oz1SXIyFAhuhyISBM6kgfMKvUH1dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779349376; c=relaxed/simple;
	bh=Kaw4AQ8uUDA2Uz0wvpwm2huuOS0Mi9MCo/gdxLNv9ak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vi74Y4DfV1keWD5sWGL2vw3UXxnOvzWtxuurWLxnGLkIGlRENwUDoVxGIhk9lMCTm/LiOBh/xYQrLNgDflJ1xw37ucYa+cO88Oq39ze2TAO8q/ns1B6adh8mt3ciuVMM4LtM2oe44wCJJ5GRx1KSCI+TbcEZLqIvaP4k6UqTxsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ASStNeEU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nx/9WL/1; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ASStNeEU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nx/9WL/1"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BE586140006C
	for <git@vger.kernel.org>; Thu, 21 May 2026 03:42:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 21 May 2026 03:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779349374;
	 x=1779435774; bh=FSKodS6z48wfHZksFB+tY/Lvh7uD9yQSXz0AKFGO5F4=; b=
	ASStNeEU4hswM5M358v/nNbbuc1ZKe6l+GOVeYIvg2xoLRHqg+HkxlFivZGnzYaJ
	3sFDfDn6GA2mj0tRiv1Ax4edlhlHex5blGvrDiHhkskXYWHRh0kbkzjE9WGK/8Xy
	y/HfY+0E7GnVTz47QQ52vqqP2Q7/TPLOMTllYTdUxLIe24bc5mv5kttCU9I+ase5
	5B4Gcj8k6lzloqLMDmS4qwzqqvJiDff63thE7CkIj0R15xbQHWDTmbldqvXMaxCo
	ycOOM13bg2kgJmj218HZXgPRf5mrP3gebho0AWZMgrIAutVsyD7XUiNwo8e6FJDx
	7x9mG7buHrr5QLOsyv4cWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779349374; x=
	1779435774; bh=FSKodS6z48wfHZksFB+tY/Lvh7uD9yQSXz0AKFGO5F4=; b=n
	x/9WL/1jOK1GYWjnHjgHQjPwLkIUxm4Iyqh9IHwBVrXUq9fymxbUKY8LY6M6TJAp
	fXinon5EDeyCG/C2QovRYSql6ey/ZP0FmwoK7ObjQ9MO76MhrVqzHi4GjAH9+2f1
	8Eb10g2KlXqqryuorUh/6ESJINHHnI5YP2EwCVvXOvet8RXvSWiu8/LlP8QwxtXE
	zlzr3UZs4mjyK2uyKPzmahtoemXn50ArPTEKbd5WJ0jeAE/9VOzjhJDibds61bLp
	yt/fsqZhRpZ7qNeZNGdPvqKlsFIpPmDxxHrCCghZsLbvN9aL93uXUf/PDFB30MRt
	BBtw+ZjIeWYYnK+NXgkww==
X-ME-Sender: <xms:frcOapO_4__rZf4Vhq0-IiBJwpwcR60veSy3MbG9TwA85ddvHXU8Hw>
    <xme:frcOai64Ok7cXGmenydQimNfeuohpsNFm37WkJkcmMrFRRqXQJUqRi-oj3KLZJU7z
    zFHWbl4wqoqHPGfuL-MOL-XD3nEWx0bt0QiML6evrQYTUu6xVCrHA>
X-ME-Received: <xmr:frcOat4qBDtupel8P5pSxk_MP2xFfFQx_0I9J4t5o_CYH3FOzup2VeYMhyeDcU8VaYcCSBHYoLqhUHfLlfgilgD-sakyC8Znsv9puM3pPDM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeeileegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:frcOaq01Z1CdssadfToEwjs4GztWU558TKfttDS9xVVrKZgC07Zi3A>
    <xmx:frcOahU-zBiDWv9mA1DtjWgkmsrgfu3TVIc6zlYdIoW1llQ7Qle6tg>
    <xmx:frcOat45xEEdLJdvSKmyNyIKQHzMPXPt5N02-hHLbuYMK05J9FtkVw>
    <xmx:frcOagIhMTjBc8EpuXagmQ8KrfLr_ERl5kLET-4mJuzQy-gDfFhHIA>
    <xmx:frcOal9K-Mz_J7t4-VbQTkWDr9ziUNsAD79r5IDH5YnEBU_bzoko_FW5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 21 May 2026 03:42:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 80260947 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 21 May 2026 07:42:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 May 2026 09:42:34 +0200
Subject: [PATCH 7/8] repository: stop reading loose object map twice on
 repo init
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-b4-pks-setup-centralize-odb-creation-v1-7-f130d2a7e8ae@pks.im>
References: <20260521-b4-pks-setup-centralize-odb-creation-v1-0-f130d2a7e8ae@pks.im>
In-Reply-To: <20260521-b4-pks-setup-centralize-odb-creation-v1-0-f130d2a7e8ae@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

When initializing a repository via `repo_init()` we end up reading the
loose object map twice:

  - `apply_repository_format()` calls `repo_set_compat_hash_algo()`,
    which in turn calls `repo_read_loose_object_map()` if we have a
    compatibility hash configured.

  - `repo_init()` calls `repo_read_loose_object_map()` directly a second
    time.

Drop the second read of the loose object map in `repo_init()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 repository.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/repository.c b/repository.c
index 2c2395105f..61dfbb8be6 100644
--- a/repository.c
+++ b/repository.c
@@ -301,9 +301,6 @@ int repo_init(struct repository *repo,
 	if (worktree)
 		repo_set_worktree(repo, worktree);
 
-	if (repo->compat_hash_algo)
-		repo_read_loose_object_map(repo);
-
 	clear_repository_format(&format);
 	strbuf_release(&err);
 	return 0;

-- 
2.54.0.771.g3ed373ac14.dirty

