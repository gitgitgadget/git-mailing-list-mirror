Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAAB2D8DC8
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 09:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751535022; cv=none; b=sh9pasQ9k0sNKN1bwBNGm9tW77FXFXi3LLmE5RLfOQtiry+Mcb38M8iesgTWbQ1khxASCX5ZF4/i2vtQ6sQTKCfp/exjhxu6o9FwX96fc3+8DJPYSVs3f8VkLM25WEe9tqxN7PR93Gu4NK7rlSBRh6rB0qKv6890Lsf+GBIuh70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751535022; c=relaxed/simple;
	bh=RtwqhFBJt4y05kSqqv7Ga4DIRFs+Fb5KiQWQOjL1hvM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m6R7nEEDLKoA1iPga5mf5K1xkkFgHEBlp14WH8MOMhXj0hN0O3HcW80Qp0mapA/jBxj1HU9BnrZSLC1uy5T92hZGe+kflqks6+qpR1nUYz7Z9EJhHDKHh2o2D3GdtyltqV4bCPT3Ro+vyASnH1Wraow7Ox+77NQGS6kmyxqdjTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SRHiNJb0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QTg3FKer; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SRHiNJb0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QTg3FKer"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 4C8821D0024D;
	Thu,  3 Jul 2025 05:30:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 03 Jul 2025 05:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751535019;
	 x=1751621419; bh=pjg/GzGbvEXoOVHUHvCNk6Dez0yblk75di76Mw20+Ks=; b=
	SRHiNJb0T/6UeIU5As4uOGiCwDZDMSDYrr2QdZPq+72i7CyXwVgj8uTQ9kl3lh7i
	GXZNiA1aDo4Mybh4SvXrEyjLq+T/m1a6+W/WplU1g1rJvIoBCQzt27eau3ueeKGz
	aDhDWrNvs8HFHsrOF7pJmkJYVzr7WmdR5g+elCQ/YRODKXhpq4WH+gcVY1+8+AUr
	dZJBT9kSOrhlkp6RFSGhwG6O0NJv6ZFT+VN17BhYBFMMeQW5T9O2MRoCoRXhLCFu
	WunSVXVMq4SESxCJ6PTgsl/3kNt/6gDZ0FiR5mY1CwQV0685lr9n2+4eqi9bGCEd
	eX3TrKfwapJrwemuxC7qLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751535019; x=
	1751621419; bh=pjg/GzGbvEXoOVHUHvCNk6Dez0yblk75di76Mw20+Ks=; b=Q
	Tg3FKeryJcpYRJN2szmhyQ6nGyECFTlTP8DkTRHOE7/33Nm468jmV0B3uCHetsbe
	6Pbvm93E+iEaVeA8owKtqLyn+1AJuuGLk98w74insDfx/+ZTDKdprFRLkFYCrid7
	BVULTe7KbPe5vIBweHUQq29+FQbF0sqpQTs/hjaptRihQSt0FyzAIOCURNfpxvN2
	OmGXGLFtKdFL3IqQ5n3f0GB5mJTW6xSgm5icE/5INFl2tLZPiml2aAoHwDG3w4/g
	6J6hsxlI1EDYYePQqkkRFHIUBOQTkXp+gUtvU1ulJQhRSesksGOQFOTFkkQf5Bo9
	2IGnP2UzexNjS0nirw6zQ==
X-ME-Sender: <xms:qk1maFgj9S3STpmE_8o9SsowNYBCSc_f8WwSneilIB_YlKTFxg8WjA>
    <xme:qk1maKA4N_zouHcx4to6agPVCRCGeQQ0Q_IyGnvY8wUuEXAvuQ69uVyMX2vhH3mt4
    Ph2RnKMNiCqcnnVTQ>
X-ME-Received: <xmr:qk1maFE0Q-t7JTp4AYnY54p6tX4v0HEdLsrjx27N9XlD7qWc0MkAe271nj8zq9twZ5wZ9OwuebNqN1CezPnemOmuYnyMyDA1RTmeWM0vKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepihhrvggttg
    grrdhkuhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrph
    hluhhsrdgtohhm
X-ME-Proxy: <xmx:qk1maKR4LUoqCZWi7zYo6zEFdS1UyYBIAZnkTZBM2FjoUuom90FOVw>
    <xmx:qk1maCx6Mxsid9HAu95h8RVYCFiPHjk7ujHBhekpzzu0XuLS97_D0w>
    <xmx:qk1maA4pJR5RmEo_dmlkoS06ohjrXWyAT_rOi2jAv_UmMmYP1hqqRQ>
    <xmx:qk1maHygOqhqasrAUqFe8HCxot6xvyeZYTrT85vC5ZmvYto3NxYcIA>
    <xmx:q01maO8TfEDkNO-wbxC2xGRQs4AI7JJZZISrBrnAu9VfL6L_b6wKyS08>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jul 2025 05:30:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0a51da06 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 3 Jul 2025 09:30:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 03 Jul 2025 11:28:44 +0200
Subject: [PATCH 2/8] meson: stop printing 'https' option twice in our
 summaries
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-b4-pks-meson-cleanups-v1-2-2804c2932abe@pks.im>
References: <20250703-b4-pks-meson-cleanups-v1-0-2804c2932abe@pks.im>
In-Reply-To: <20250703-b4-pks-meson-cleanups-v1-0-2804c2932abe@pks.im>
To: git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, irecca.kun@gmail.com, 
 Eli Schwartz <eschwartz@gentoo.org>
X-Mailer: b4 0.14.2

The value for the 'https' backend option is printed twice: once via the
summary of auto-detected features and once via our summary of backends.
Drop it from the former summary.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/meson.build b/meson.build
index 21fdff0f496..4e41c3007bb 100644
--- a/meson.build
+++ b/meson.build
@@ -2197,7 +2197,6 @@ summary({
   'expat': expat.found(),
   'gettext': intl.found(),
   'gitweb': gitweb_option.allowed(),
-  'https': https_backend,
   'iconv': iconv.found(),
   'pcre2': pcre2.found(),
   'perl': perl_features_enabled,

-- 
2.50.0.195.g74e6fc65d0.dirty

