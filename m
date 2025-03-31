Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210F819259E
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 08:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743410003; cv=none; b=TtilJOFnD0A6fRTKLQIAGmCnkqtSMjWA/pr4CkilJf0Iwrmj6WeK7O9fq4OOvRDyXNxktHOKqEtDwggabpRkUOTTQfPbxyXT9X/RkBDcVn1k+ro1BC6TPs8vbFGeOj7vzsY5AW3xc32oFJcc0h/nmni8/jSFHLeFwmdam6EP00U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743410003; c=relaxed/simple;
	bh=+85wQgxZapibTJyxHYYL1BellZADssfldDeTNYezOvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mAGRRDEIAvsBbfFylBkKS29in9+8DHfy2u3/ZLRM2G/fHExdgdlbkmXATf8V5fs5zTNvsm3EGZxGCOvmoeR647OI0kwnDiHGzhKS+kRHIpvsRsidNUDfjFagK423qVvPxd52DhNKsuVxrQ02M7TADOdPjfK5BUPtyNrJKgerGtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jHBUmRki; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Il6OCOMz; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jHBUmRki";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Il6OCOMz"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1D6241140126;
	Mon, 31 Mar 2025 04:33:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 31 Mar 2025 04:33:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743410001;
	 x=1743496401; bh=UvuRhQHY+QzPbQ5ifleLoseh5LLoW6Kd+EkMakkVxj4=; b=
	jHBUmRkiap1aOtUsTVJXLVk9kTLOwDWq7zzIDGYzjcAdiw9GJcRCsvUMP7HZCSh8
	+6f/YaJ9W7DD2qgPwurL/55/8fPC4IWrEa8T1Tp7Gsv8cg4u7UeKvH59K5keGCNu
	CET8UnbYTN06MqHAl55fUqG7oYlIcUQXGhFU0Xkru2LgPku4xhwIghmhGqU5SlyX
	VVQCu5Fc2G+syui1tBhjDpLS0Rpo1kla6BFdSxx6k+je6W9LgqLS/0+YHsm8fb4c
	0YiLeJmc5Lh7GLrHJQ8DPVIf/cXTOcbtQcaJBCaRCGs6YbWKrOy7dFniviT/0RxD
	F0YXGB6bucf737YkDfi5SQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743410001; x=
	1743496401; bh=UvuRhQHY+QzPbQ5ifleLoseh5LLoW6Kd+EkMakkVxj4=; b=I
	l6OCOMzyyIp6tFgXRYrK/eGx/KZuG/JpCk7YP8n9Hj+59BPi2e5RSuh/hBHPzeVF
	GzCc07crjyzHQwfqghFr5xFSyYBlEeZ5VD++pQJznTE0/mWZKP33a+/3znxa2lMJ
	3ijVSCVuhR/rYjQuctgm12MN/J7O50RLU7qgcOSSdg0wRM8x0+agviURRUYY6md4
	AuFiNKGsi0dHluoSBX1GG6lXViqvt6lozAC6NLl1Z538QHFEYQ3rjFbalAVUlv73
	tcPSIq/YuycgoWbOkbv8L1HzXFCtQBA7tDROJUmUwVkbFzfqRCJ79YOlvBXl7LkW
	kE/qRAgCwCCY/uhqsIVuQ==
X-ME-Sender: <xms:UFPqZ60HLG-jHdvi4j7-d6KHqjGMuSveTYzLjBjdEgbvnHSMDSSbsQ>
    <xme:UFPqZ9HOFkZNl6tjuA97wiYoxKos_q2z-vO7XCPqjli29ZJmXuGxPGdhizV65zNlk
    aLrw25nKsWh7kGacA>
X-ME-Received: <xmr:UFPqZy4tkjPJ6Bt4cy-5SgwqiNOVN4VZvQ_Kqig9HkYMGLVSrmJIs20N7GUmRNHu8q53BkO-IZm4EZ0BifZ76dOywOFSipu44sVy9jefnLP4iEwk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeelgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlih
    hnsehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrg
    hmsehgvghnthhoohdrohhrghdprhgtphhtthhopehtghesuggvsghirghnrdhorhhgpdhr
    tghpthhtohepphhsrdhrvghpohhrthesghhmgidrnhgvthdprhgtphhtthhopegvshgthh
    ifrghrthiisehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:UFPqZ738Hxn2weH9e9zRGRWzDA-wGTkzMsNepA1pu95UI6JYb86nHg>
    <xmx:UFPqZ9EuMJCTrCsh__t6BAGxu4a2M5q7o5NBxpGEmLo4C9UVIv03Lw>
    <xmx:UFPqZ09RJpYQnYrGiczZvK6DyQbA_uFTRGt2KTpgidghbq5Rs-jVwQ>
    <xmx:UFPqZykqz0Txqbyl3XjPgQuRemdjgnPNBhbDVkvCOPHwogxTfSIggg>
    <xmx:UVPqZ02vhQKcJbSQaLDUbqvSL5FccrZHRGDLbrNYwKJQKfxnt7q3jVMb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Mar 2025 04:33:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bed2693a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Mar 2025 08:33:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 31 Mar 2025 10:33:07 +0200
Subject: [PATCH v2 1/5] meson: fix handling of '-Dcurl=auto'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250331-b4-pks-collect-build-fixes-v2-1-6b06136808f3@pks.im>
References: <20250331-b4-pks-collect-build-fixes-v2-0-6b06136808f3@pks.im>
In-Reply-To: <20250331-b4-pks-collect-build-fixes-v2-0-6b06136808f3@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Sam James <sam@gentoo.org>, 
 Eli Schwartz <eschwartz@gentoo.org>, Thorsten Glaser <tg@debian.org>, 
 Peter Seiderer <ps.report@gmx.net>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

The "curl" option controls whether or not a couple of features that
depend on curl shall be included. Most importantly, these features
include the HTTP remote helpers, which are rather quintessential for a
well-functioning Git installation. So while the dependency can in theory
be dropped, most users wouldn't consider the resulting installation to
be fully functional.

The "curl" option is defined as a feature, which means that it can be
"enabled", "disabled" or "auto", which has the effect that the feature
will be enabled if the dependency itself has been found. While most of
the other features have "auto" as default value, the "curl" option is
set to "enabled" by default due to it being so important. Consequently,
autoconfiguration of Git will fail by default if the library cannot be
found.

There is a bug though with how we handle the option in case the user
overrides the feature with `meson setup -Dcurl=auto`: while we will try
to find the library in that case, we won't ever use it because we later
on check for `get_option('curl').enabled()` when deciding whether or not
we want to build dependent sources. But `enabled()` only returns true if
the option has the value "enabled", for "auto" it will return false.

Fix the issue by instead checking for `curl.found()`, which is only true
if the library has been found. And as we only try to find the library
when `get_option('curl')` returns "true" or "auto" this is exactly what
we want.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index efe2871c9db..a8d1e63ccc6 100644
--- a/meson.build
+++ b/meson.build
@@ -1686,7 +1686,7 @@ bin_wrappers += executable('scalar',
   install_dir: get_option('libexecdir') / 'git-core',
 )
 
-if get_option('curl').enabled()
+if curl.found()
   libgit_curl = declare_dependency(
     sources: [
       'http.c',

-- 
2.49.0.604.gff1f9ca942.dirty

