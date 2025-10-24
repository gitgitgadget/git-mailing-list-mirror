Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A316130DD09
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 09:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299524; cv=none; b=JSvvw9oijhdSt8Sxg65TH+E0tCNycv9PLHOWPl362trGnsy6pM2T+vCqlLi96wrAHz0HRVfShOPdQZhBllNZNvRx8E54q0At9XJfG3kZYTWOE5UUVLXAn+j4V5u/dFARSNmNNYHTuksJaDi1FcbT+Mg4L8cbVMZOz/voDgo6lls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299524; c=relaxed/simple;
	bh=1uyUYRByisqGbub7/5MEWrubO4g7sjYSX7fMSgDvhNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lGgnuMYKOvh3XMXgSd78zGZBhYE/UR+FGsdj163juuliDtEpHiKSBtUNRG80/xpYAD9RaCxYUqcMNOC/wVvW9TV0jdlhjA96LPgMSEqNTmBUjy+FTIKXUEknTRUeKuaGzIpOi+2uJSX8o6On7Vi5Id+mF/CQhs8VhCIoWEYb7eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EgS5waW7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=amh1YR4A; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EgS5waW7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="amh1YR4A"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id DDAC8EC016F;
	Fri, 24 Oct 2025 05:52:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 24 Oct 2025 05:52:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761299521;
	 x=1761385921; bh=6Oc+Z1/+/GIhDCwCElj08DQn+SzM09lvOzgkVHOT1Ng=; b=
	EgS5waW7YJ0U60YgkQc0YBmxnMX/w5neLwo+Kt/0FKoOBGMCsEC3jQbrcQRYAOkU
	GKQHRGDQKRc6W8gDRS/xkPra2FMX9YdRO6JM0vXvargmYnoz2tfxig07SqbW7+vw
	3pnFpqyOpDEazOfQsVdTVq+KszC0/symQw+3TJP8CerIRS2Cj2nxaQXUBvpH1jqB
	3Z2QMBxtZyA+0Wn4uqCP2hJRFE9x2YoMTYhyRgnvXMwxZJZcICMGUkrFdB2bQGRq
	8B+iOFkVtVEQ7Vijy6+k6PXK48cpoLwq3447isZ9igW7a65jJpbLPvVX4JntDrvO
	bgQWMCQjcX4l1daICpoUag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761299521; x=
	1761385921; bh=6Oc+Z1/+/GIhDCwCElj08DQn+SzM09lvOzgkVHOT1Ng=; b=a
	mh1YR4ARQSQZugtWDcJRHIPlaRhBHDuFqG1dbC+rodd1UfVI3c4mCzZUdGmFOmZ0
	ARFuDpU/JPToBuMJWf5rjK2yxdzpJY4qBthdTgrZvh30FiMonVzHsuHkJ0I/8KVZ
	PtC6HJPcISafyNxM35QkUOFWT91McPQaf3n7eNagCzsa9/+cKgKdLTiXuXFKq6rW
	BLs1hEnjsdBTKD9FdJ/kcxopxz++nrDuFhbYpS08zDysmtdFOuWjd76B1ThHTLnE
	irSAiQOvG3i8YxzrAtBBPE9s9wKMVlo0WeHMJnv+vu5hzqrmO/Mqjb9zP24oY3a1
	/SbcPS+sBEfk3zGVo3H4g==
X-ME-Sender: <xms:QUz7aI379m2pSbwkOxbdYwkr3qVUZf6pcxovVRRHCBmc8WlP7xx2qg>
    <xme:QUz7aKGJVEe6YK982EFDt4luwKXmUh7XOpbFpoqb8l0rhkmeLuT237senrI6VDMlD
    JAF8kxWEgYwjqI5tnCVWo1V4BKPTXT6EWqt-afcMhmP5vufYjnfEjM>
X-ME-Received: <xmr:QUz7aF5N-z7bJx5vwsJEUjU5qF0ndMshTD5nEW1fUMJgA77n0pLOwlHG1iTJJ9mU23xESEMl-zxFuNMTX0pvaygRSG4DCBMZHw1VTDhoVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeltdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrnhgurg
    hlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepvgiivghk
    ihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:QUz7aAtzSkh2PazWE8XArMRWOSIWcdIuY3rBnnO-_a3BBg3HgzTn9g>
    <xmx:QUz7aG4TdPDQ-dGcfb-Yt9SXGe3kCAwHiA3xRV5h6wXlShFexdBnsQ>
    <xmx:QUz7aLVn30bTzjcb4ytoiiEx5PYe3HzNGNrM8lFbYlPn-9goLkjj0g>
    <xmx:QUz7aI_ZEv2sLGXy2OQP6RtTBkWNCBIqOZz_ffqIEOP8GwfIZHsqIA>
    <xmx:QUz7aCrIQa5kQxK4McWP0P1IQRwbQoHI4ooiwvcGNqubn0tdPUs8JOBi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 05:52:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0338712d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 24 Oct 2025 09:52:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 24 Oct 2025 11:51:36 +0200
Subject: [PATCH v2 4/5] meson: rename Rust library target
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-b4-pks-rust-cbindgen-v2-4-4b4bd4f18490@pks.im>
References: <20251024-b4-pks-rust-cbindgen-v2-0-4b4bd4f18490@pks.im>
In-Reply-To: <20251024-b4-pks-rust-cbindgen-v2-0-4b4bd4f18490@pks.im>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Ezekiel Newren <ezekielnewren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

Rename the Rust library target from `git_rs` to `rust`. The latter is
way easier to remember if one wants to compile only that target via
`meson compile rust`. Furthermore, this name matches the test target
that we have for Rust that can be invoked via `meson test rust`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 src/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/meson.build b/src/meson.build
index 25b9ad5a14..1c73549696 100644
--- a/src/meson.build
+++ b/src/meson.build
@@ -17,7 +17,7 @@ if get_option('buildtype') == 'release'
   cargo_command += '--release'
 endif
 
-libgit_rs = custom_target('git_rs',
+libgit_rs = custom_target('rust',
   input: libgit_rs_sources + [
     meson.project_source_root() / 'Cargo.toml',
   ],

-- 
2.51.1.930.gacf6e81ea2.dirty

