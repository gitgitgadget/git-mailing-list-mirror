Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA2A13B585
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 06:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723618325; cv=none; b=eEDrUzVcsGjjyUvbbCKapvHYUbzc1LNxxTdHxk04QhnNTRtXBh7pxzJ91O+1SWNX2eIkPYc78VUnRmQPikRBiW0egNjJDaJ8p/zVmNjr1Sw3Cd/tLHe8DrUAnlyykHU20/+ocSIf2wuHa9TljvmGqRrSkS+f3oq+wdHZLhKXR9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723618325; c=relaxed/simple;
	bh=luZlTz2hTI8YLT4pNO5tz0if96yQMyYh73CZ46a0rCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dj9KXv7ABcYAMv+l+L8kvHJuLPMVIlGrfMogOELKnJ/A9pMEx3iYT9A/iYq0mAByLrwh4UR/LWboUoJYDv7MXkO14talkJJHnUMzuU1TRDM9LFN9OCJjL4EcVcWHY0WX9qkahKKahXwp3xjgwqK9GrvD3XwuBMgVRlk1F+f+9e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MDAfaLcl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VuObgU35; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MDAfaLcl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VuObgU35"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id A49581388210;
	Wed, 14 Aug 2024 02:52:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 14 Aug 2024 02:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723618323; x=1723704723; bh=vAJymv3/2V
	GXDhjMfmXOqsXr79Vg5+j45QHKvwZBsks=; b=MDAfaLclYdlImR83c24XkLiBqW
	QX4e8WXT9xuJ4uZaThYrDzHXqQtV3lLE1VS2A59O1xwoRDzVniBzbqZmiltIoS+2
	UsU5j7oWc/UunTCwt1Sa6S2rrYelIaWNw+adHKLgZ+YBXl5YJjHfpmxcULM57EI5
	wey99AkmazrAjfSuiktoadK+HtNjboRqpNgBrL3FZsR6svIMo433l/DzjUrCNLsj
	tFaBcAjp/i5lDHmPssP6yanOvKCvD7H4N7ppiQPtkEcxF4Xd6l8vn2Kh9wuP5jv1
	isOwrv3gKTOGa39TaILRn67XanTDAuk5lXnSEdqUeyhuutFepk9JoInBdHBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723618323; x=1723704723; bh=vAJymv3/2VGXDhjMfmXOqsXr79Vg
	5+j45QHKvwZBsks=; b=VuObgU35vzXTbXPZmEEBLvY19NHDjtNOSRDxM0NLPXyT
	KUaHb4bjfmIUU7gW50i2Jj8yb8gpXWDNiOL8j9hHTlbeBQmg4jmpPLzKdMi7GTGq
	JyIuingrgnNu+kLyOlgjbKFPQqL9Ef5Xaw3lYvv/GaBSz47MWtqmMA4ydeuZxj0V
	d3LaOfgq3GMh47mqu6IO/6Y6/ya6ybSRike2s/GCRHi5n+zLzY7FJXLegoB0HZ2P
	DfBEeY2dRnkgFBG5ktGlF6OH+saKeSj3SMr/ndHocvuxN8J2r3yIL44er7zvWN6F
	0xTuy3ZRa9lIom4AEUmso1PBDhRHmqHEwgCvA1g3Fg==
X-ME-Sender: <xms:E1S8ZkgmMAaZojHv3E38lTx5un5FvlG1B-ku7A9LOlv32qJ4i6HFrQ>
    <xme:E1S8ZtAYO-fGuRxz_VsdO9JnZ52ySuxDP5nUHTetpALkT_hJSp-3SaEQ-MN0ohcrx
    qxXVKZV1-qHOocqmw>
X-ME-Received: <xmr:E1S8ZsHIlMMwmw0qneSmO1auYVIA-pqQLJmqKCV5UMHQdXim8h4XwQLs1KbqLJ0Gc_jrAbW7gCnSIlbeloLk2TZWoTP5eHYIP1TssZhKeqfzOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtfedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjrghm
    vghssehjrghmvghslhhiuhdrihhopdhrtghpthhtohepphhhihhllhhiphdrfihoohguud
    dvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:E1S8ZlRMhqf9PgdKz3vhRyvlpK3uzxIEqVcJYEwZ8z45PLAnIw6sug>
    <xmx:E1S8Zhy8dW5Rq97CzEJ-HvYup5UPgM-3DDH7mVhSv-oxRj-Cqh_AHw>
    <xmx:E1S8Zj7c2AF3KWYuOWfR5RBMj1GbYeLotqt1j74FPtClVBR7D31XoQ>
    <xmx:E1S8ZuwL-94UEBJx6YfwjTwc1C06NEL3NzyRQnAqgc_k22mk7qZcAQ>
    <xmx:E1S8Zomtk_akPEZ0I4mx16vvKh3xWzQGgf9J5S6Wx-zG5ooOqzZ4tGLI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 02:52:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3d2122a5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 06:51:43 +0000 (UTC)
Date: Wed, 14 Aug 2024 08:52:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v4 04/22] object-name: fix leaking symlink paths in object
 context
Message-ID: <e5130e50a9f296720960b2a8d7be14fc01a0fd30.1723614263.git.ps@pks.im>
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

