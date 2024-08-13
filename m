Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C018518950A
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541479; cv=none; b=p5+SreC8sAQXdQ/j0Fuhyaz3T9OL54ALIbL7lHh6yTGzvI+peZusBDv5ThNItj2WSQtSpph+fjUs8v133Maj+YxIy3wm0FE1dQNoyIvKBo9on4bdDsRbWczEupt1Q9kO9Cu1q5pdN/obUSc74kPXNQmQBOOLuzy7ziuLJWBfydE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541479; c=relaxed/simple;
	bh=luZlTz2hTI8YLT4pNO5tz0if96yQMyYh73CZ46a0rCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVkMPPreCSbNE91HJreeg3qbtHpnRqWO2FIRojt1n5nHkOsslZ2zsaSXzC2UviURGzT9n/75+sPE4mUtqnref9VfiBjO+3klrARhX9I+WmQ3wdFfLRwll+Ra5ppEk9P81ljbPzPGumqgzZHaEVGE0/MWqbCofiECaRCGNmbi8Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MCtk8QGP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BpVceFSj; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MCtk8QGP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BpVceFSj"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id CD366138A055;
	Tue, 13 Aug 2024 05:31:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 13 Aug 2024 05:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723541476; x=1723627876; bh=vAJymv3/2V
	GXDhjMfmXOqsXr79Vg5+j45QHKvwZBsks=; b=MCtk8QGPS9EeJIF9xNV+Qv0YX6
	pkzj3byRAdGDkVuwvff6E4SxVJALsGXSeAF3f3OsPU/kBf1naJ/PaUZeIN14R11X
	3+v27iDfoGEHx5YE0w3tThtLnRGdQsfpWVc/HbgXv7zQekXSv8Ti3yTXUE3wm4fi
	sqgXeESSENQ08oaWJpLVYcx6Wh2ou9kLKoSGSA+wkaXXqHJ62U4OfxjtJT2K1k75
	Mg08aEvlP2zUHggb+agb16Bt8qwQwduouWlHWWtOK5zhoGcSShsOdQbIdUSutmOc
	n4vbpTRuqEH7BrsHEthlYy0Zo1ZSuUctEuXCcAvctCRWUCQPg0RuwtQ89PHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723541476; x=1723627876; bh=vAJymv3/2VGXDhjMfmXOqsXr79Vg
	5+j45QHKvwZBsks=; b=BpVceFSjaycB2Z2UK8aCYSZ+PttS4v/wqOzgk8gEDNlU
	0DVpIwrbmdK2QyoMS4NibIX33m6AdqNqToyBspQZ1pu7GluzWF04dA3LcwTaRyAY
	oSx0AxAJVQXcCOosoY7uu83NeH17V8o0YGajjnY6QpL1jCjwx5K+Bc7Jq8PoDMwh
	X5TbVjyx1CzpveguE9einadEO5chZKYiLQnMmEiQZlFQvQl950085eLSlzDL/RsW
	KhJkhZSXl/skLq0pxU4v5SynI7Uvx+HXwJUoaONMZ9qCRC4a8tfeELhpnLl0TsPC
	3ysf3e6T/0oiV2YrWgfDFfiG0BwJZav4o8nP7LF/WQ==
X-ME-Sender: <xms:5Ce7ZidMjKeQRwf0r4OkOKLTmDOk46CpFA3Lfs9YNQMLZFFfO0mqhg>
    <xme:5Ce7ZsOSEbFxq-ubqtyyobamGhuUnAF6CkvhmzecUV0h6hRt6zFjXtLIy_M8dcwnU
    KVqu40WTbpmSsC3vg>
X-ME-Received: <xmr:5Ce7ZjgHe4tm9DS_kwEtRN6nuiWJT9oXrlj_2Jk9mzu044eQl6G6svFsbTqBe5kpcJMi_HTbYn2aI72Dlu6h6Ehndt__icuQk8i_4VkC3IAqqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdprhgtph
    htthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdp
    rhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:5Ce7Zv_OYWi2F74O3wOqL5Fx4iIMRRSOhIOutpnZ1hyP8iZ7UUvDig>
    <xmx:5Ce7ZusA9oJAdAmTY0Ht2vlEGuSjKHUhCu2OBn_D3d018RIpqhPheA>
    <xmx:5Ce7ZmEiHOtD8zRjk2aae5Is0elCdeBX9XOJDUPGooLnu0xRl5NgdA>
    <xmx:5Ce7ZtNa56NJm8-opmLjoxHDtPopHbDDJnmeEesMRlRXCx2j0XhmUg>
    <xmx:5Ce7ZigJUXC08-1jwLJtmRPIHESrkWOHg4sqad7OLqh7BmQpXQYKXWnE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:31:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b0193331 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:30:59 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:31:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 04/22] object-name: fix leaking symlink paths in object
 context
Message-ID: <e5130e50a9f296720960b2a8d7be14fc01a0fd30.1723540931.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723540931.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723540931.git.ps@pks.im>

The object context may be populated with symlink contents when reading a
symlink, but the associated strbuf doesn't ever get released when
releasing the object context, causing a memory leak. Plug it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-name.c       | 1 +
 t/t1006-cat-file.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/object-name.c b/object-name.c
index 240a93e7ce..e39fa50e47 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1765,6 +1765,7 @@ int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
 void object_context_release(struct object_context *ctx)
 {
 	free(ctx->path);
+	strbuf_release(&ctx->symlink_path);
 }
 
 /*
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index ff9bf213aa..d36cd7c086 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -2,6 +2,7 @@
 
 test_description='git cat-file'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_cmdmode_usage () {
-- 
2.46.0.46.g406f326d27.dirty

