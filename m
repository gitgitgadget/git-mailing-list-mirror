Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E481DFE8
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 06:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730787437; cv=none; b=iJx5prvRq0ELXMauwdoyvoYGF1rI81pn5BYkvQYD/sEcaLEm31YcvPeKq12xwJkk9qNVlL4lzDw22VUqrCA1pLzNe/vmjSrpP5qg0YChrVFNq6+EaFCKNjzccloLb9eurlFWLJYFokmNgHiDo8ix67fUkht05slevv+1/yt/wmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730787437; c=relaxed/simple;
	bh=jeDgV6xmnE8Hg6BGySLVEiBIJtsBlhbI4LTRIR5Nl+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JosND+GsHXEa3VDYvjPeH8D/ldrPf1VSFBb7diAqdnUer0nXU2PZuMF6i0iB5I/sHdBT0b0kqzEoQ0vXT+ggAzlcjZ6mf5GzgqhiVYREhUraJDBv6bMIaiuPRbxZvhqVcNE7/hsj0aT0JZ52rD9cxN+k5xrug/FquBCHKzxEKjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WvV3p96k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WWHnkP/9; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WvV3p96k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WWHnkP/9"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 84E3311401C3;
	Tue,  5 Nov 2024 01:17:15 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 05 Nov 2024 01:17:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730787435; x=1730873835; bh=dYdnbtXUXj
	61tzkzZZcrdct4dMcUhhKwFB3yh7/LGT8=; b=WvV3p96kIkFlL96rwxdHgq3DOK
	GuwVBnsW8blsbjm3i5uWFNOi+o3k7t38jfGdF8mZajte1yu84iu9CMrfSabSLs+w
	ccqhu9KQwfiqJ4cJKmDQbK5SroA9Ky8mX1cD9jsfZdIc3zeBZigC5J9BNavyTOjb
	WxMYcKHyxwg+1OJ//27OZsvBSc6jaWvwm18/GHp4ndOciHjEr4p/BNjScweXFDoC
	QJHs0GfNVpMewUx59a4WJMw9uXhN0ac6QtgmCeVnTa5yy8LuqgO3JVeEtttXnMxG
	4jtcX51OA8Cw2xwz+H6QvGdVrfmpM7MxKZDU7AWkSyUkCWGZKnPbpO2WEGbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730787435; x=1730873835; bh=dYdnbtXUXj61tzkzZZcrdct4dMcUhhKwFB3
	yh7/LGT8=; b=WWHnkP/9o53xjswlIXaWZrZmDQ+NknheKQTfc3pdz+GouICopFf
	6OD9fktRpISUMu60k6O9HVVd/J9wkbON6/XnjIQD1uLXYYjKKJwVjpmWVTwmYv80
	2xy3Bexo+uxo5wrACSI4BTtpFPswXNkXmN+7RqeBVNN6kkuvWet7pr/s9ObKY0aF
	nN/+Fg7gkSHMZV085lRAhPL0mGCV9bOIQytZieC5XwOc+Z9rSvjmak83d1U1u42j
	pm6QSV0S88K4Pxp4pogHAl7jAKiDq+2jONYVBt+thsEh51GrehgLIdVOhicrjUiL
	xd21JPVwMIhu++864Yn7W68Ut9JlsOTF8iA==
X-ME-Sender: <xms:a7gpZ1A65zPtTtT06gS-zUXOm4sF-zbddwG_advh0asw2HlAYSl5Fg>
    <xme:a7gpZzjQjUHamaWTz52I7-BCFHUyw7GRZVVvsoUqbjPivKf93bErq1z4Xvfrowj-D
    Dt0VEaMOfp5xgVuCQ>
X-ME-Received: <xmr:a7gpZwlQdM3BHpEwX9dOLlVu5bWYRjVufGe8Lf1GAya3QEzzL5Ixdfvmim5odVzld_PVfwlsgy7PXjKJakhxIYhxCTEyhZj8j5NUWQHiwYx0SA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehjlh
    htohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhr
    rdgtohhm
X-ME-Proxy: <xmx:a7gpZ_yVndVbPutGnHVtoIq703sjYyuuD87IWcdvlYwNeuuvVygRUQ>
    <xmx:a7gpZ6QIbZHLQtjQJGGmU1cq2GXKpNpGeSg9mHG38Uyl8jxv_Y0wbg>
    <xmx:a7gpZyaiRpHv_DbgcACPOmI0Jbjy0G8Rn-IqzJI81uHMVuSZPfNaaw>
    <xmx:a7gpZ7S_ZjJzkLYXHzPMYmlEXnqTrJZGrrZoRGOfSRoTG5mWHzwalQ>
    <xmx:a7gpZ3LmvdWQE8sIpa2CosvC-plZ4DrV-goSoR-QEUYNxMgoxF33AeQx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 01:17:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 48e94aa3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 06:16:52 +0000 (UTC)
Date: Tue, 5 Nov 2024 07:17:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 08/22] upload-pack: fix leaking URI protocols
Message-ID: <c5813079d44ff8959f21b7b8b19414ada475c133.1730786196.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1730786195.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730786195.git.ps@pks.im>

We don't clear `struct upload_pack::uri_protocols`, which causes a
memory leak. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5702-protocol-v2.sh | 1 +
 upload-pack.c          | 1 +
 2 files changed, 2 insertions(+)

diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 1ef540f73d3..ed55a2f7f95 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -7,6 +7,7 @@ TEST_NO_CREATE_REPO=1
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Test protocol v2 with 'git://' transport
diff --git a/upload-pack.c b/upload-pack.c
index 6d6e0f9f980..b4a59c3518b 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -166,6 +166,7 @@ static void upload_pack_data_clear(struct upload_pack_data *data)
 	object_array_clear(&data->extra_edge_obj);
 	list_objects_filter_release(&data->filter_options);
 	string_list_clear(&data->allowed_filters, 0);
+	string_list_clear(&data->uri_protocols, 0);
 
 	free((char *)data->pack_objects_hook);
 }
-- 
2.47.0.229.g8f8d6eee53.dirty

