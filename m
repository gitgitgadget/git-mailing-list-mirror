Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C39189BAF
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687646; cv=none; b=SQOiTdV3vnLyWNkUfx986+IbG3cT5zN63kPKoaXbRdozV5tV092g/1N5IdgvMRNmbOGeFc24OegaHicg36Zi8xFPSY/rSyocEcQHTrb6kQ0+nPr10L/aalukPlIpqXTBJsAPTKbzv6niRgdNS2sNxzBLK7kPZay5R6es4tUWKLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687646; c=relaxed/simple;
	bh=rMBi/n9zu2mZ8tckSuOO4+suS8yBNh7IKHfhKs22+vA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckJW4ey0viD7p35/O/om+VlrRmfRVYTcrx5AB84O0pYrYVlLEanR2c8piECSv8OPECS96dBFgl4zF1JiLummdIoejuP0cfwTFUvjX9/1CHz5bqo8q3D9ZEZmKjBRNHioiVgxZxHA86x61QJkoEtcAmzbvN1bvrFC8C54xpnv3E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m7LYVPY2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qGwm1irk; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m7LYVPY2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qGwm1irk"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id AC7F5138029D
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 05:14:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 30 Sep 2024 05:14:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727687644; x=1727774044; bh=DhGq8cTOff
	InH3xqZfZU8PiAkY/lm2XcyWoSVhhs5h0=; b=m7LYVPY2pq/S8N9xUd+SoOI0aD
	jE27qDAndOkbeqxjyw/IrRjQiMgfk/DjHL50fw0HzYI+HRcmK7RWDXYG6N82tsQz
	0II9E2mhGDz/Ik2ZwRAaMzXlZYYc3jJ3GIo6gqGm6quGIpkNz4uSh6kV9INtaNV6
	3O0xQBd6bC/Mf9/3Hv9XoJ2OWRq68grTY38U9747Nh+x8Yy6YEBlgMCNhOTHlIS/
	UhOabVZEZKUvfPdukL1k47wKMWsmOu84ZDauwWbWXtFg27Isfv6wblU+xl6R0Jq+
	MPjBdMdXgvYzfw476NYlNWuPJo45JvPhtHEkJnYUznu1HLuVe0zb8KjV6lyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727687644; x=1727774044; bh=DhGq8cTOffInH3xqZfZU8PiAkY/l
	m2XcyWoSVhhs5h0=; b=qGwm1irkwivl1uURf+QZVkOrYNi7ORth8CUlQvtn1fOB
	Rn45fmscxst7fBAlFkmBJz99/wOwUAM0bNC/6acE7bPJ4zJS91RL2aLjblCP9jDo
	NnG1dYiO70UetTVwvDKX1555oSINvi6TBST7qTySujwJWtmckGFEZ3Aqj7cJCZR8
	zOlcSw8NK9OOFI9TWCh2o3ml0QBs9ODX5VVPnTQ99eJDZH37I1jBSmcnotvNZ0re
	R0kZvoJcLBYXhZMh2BbKcAxQQ6Dcvr6Hpvihc1iEY1CoNf5UYzbZ9ExA0EnV28Bp
	JhrqE44QpCq/cYHCuCKSaLeEo2/cLqYmOOrD1JaZVw==
X-ME-Sender: <xms:3Gv6ZksxhVeNvRJD0XnmccFIGzqhRXeS3MTbCPYZkrfGPrtMCRYwWw>
    <xme:3Gv6Zhd7GbG6Pa1fsiHSnSt6OJXWOvK8Eu8xdmMeotS8MhIIMD_Rq32h2vFofvd4q
    XHord3LJkqYYf-5iw>
X-ME-Received: <xmr:3Gv6ZvxqBK9-9UNAxTOGbRT4eBTWx66vr0VZ5820sLvhCd7-seB6H8GrkqNa8d6z-uiRJ00W6Frf6xovo7BXfjQEHgAhN1W3g8mH-S_dGgHsw1s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:3Gv6ZnNhM-oqWHDJJdHWBj8ryE_Kcc8h9lX8bEUlIKBfksADJN47pg>
    <xmx:3Gv6Zk-Uta3UWmzVQT3joLbRw5HdxgyiXt2hUeaQQmoPqizezBm-ZA>
    <xmx:3Gv6ZvW7SdVpaDxW3zhGpea_wzIDU-ituekQH8nhczDTgX-19Jm4DA>
    <xmx:3Gv6Zte2vD1eUpcE7J8S0O70ejmAONkoxqJqT75U3QG44WgjTbGiFw>
    <xmx:3Gv6ZikIHLhnv7ya80Lb2rKLMd6kzSONN_b1uSrwvQ26QKlkYUuOa0Of>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Sep 2024 05:14:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e0adeb55 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Sep 2024 09:13:18 +0000 (UTC)
Date: Mon, 30 Sep 2024 11:14:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 17/23] midx-write: fix leaking buffer
Message-ID: <5db4e17db9b9b991e0dbe56d7043b56e5d161097.1727687410.git.ps@pks.im>
References: <cover.1727687410.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727687410.git.ps@pks.im>

The buffer used to compute the final MIDX name is never released. Plug
this memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 midx-write.c                            | 2 ++
 t/t5334-incremental-multi-pack-index.sh | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/midx-write.c b/midx-write.c
index 1ef62c4f4b..625c7d3137 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1445,6 +1445,8 @@ static int write_midx_internal(const char *object_dir,
 			return -1;
 		}
 
+		strbuf_release(&final_midx_name);
+
 		keep_hashes[ctx.num_multi_pack_indexes_before] =
 			xstrdup(hash_to_hex(midx_hash));
 
diff --git a/t/t5334-incremental-multi-pack-index.sh b/t/t5334-incremental-multi-pack-index.sh
index c3b08acc73..471994c4bc 100755
--- a/t/t5334-incremental-multi-pack-index.sh
+++ b/t/t5334-incremental-multi-pack-index.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='incremental multi-pack-index'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-midx.sh
 
-- 
2.46.2.852.g229c0bf0e5.dirty

