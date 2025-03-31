Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439311D54E2
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 08:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743410003; cv=none; b=hDi2/tF0gWLsra3/5htMb7ioe4a9ekm06gFu1K/3fyPV+qiISmZHwh3dw3Oe5D+ZbspI0ei/oDVX5jUTQ46r/Qgq/3r6hhHGQIhKjfGTLJP2jMzqQSYO7zlSM9kRHGa/bw72ltkBxCLErstF66OLZIED/rw0HfJuk5VzdkVg/uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743410003; c=relaxed/simple;
	bh=L/oXw5fkxxAALV+jPuSzhvNpqrmwQu2Xl46dqm/JvMc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rkR8t3bniKzHuIkyB72LwG3OZG7GfxImjUToWoMMWOa3srYv4cJQ+7qqFFwWCtSj6EIanpWyclMru4k1olLRC2JsboUqCcYNzzIdQ0wNWt8mv4dAxf8m9hmoSzHptNivpBpPC8bhr95f1m7QL8ABFUoeOqSgLJ67+w0injfjlHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lCsw4l/p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WfZOnjVe; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lCsw4l/p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WfZOnjVe"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 4EF1F1383C42;
	Mon, 31 Mar 2025 04:33:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 31 Mar 2025 04:33:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743410001;
	 x=1743496401; bh=YnFIXo8/GnTlyNAp6sWU5pl2bll/1dH35dzFahsEJD8=; b=
	lCsw4l/pCK5xKsK0Net9TkcaesdHD8xJi2ouq+EE1mCN9FaFQEgKbBueFNo1+Fmd
	/zFi+PxfpFZt54TA/AMRCOiOOxjAxJlRLO1IU67IbXolR34CNnEcUteFz8NSs+/a
	/3XkjEM/sYxgNNnmbwaF8c1cp+0e+g+PBguRfH6sDOhx7HB7v/JkwBScSjIT0/oz
	UIhZ9wRBs3PvVNbgldN8uE8Ky/WrdXNXgCiBnzfc+o20l2KLeYwYsBdrbMD3JGL/
	YQO7LBYtDIzox76L+SEer4imFSWcdjTDPAOnkU8cFgMB6B6caahSj1MfWiYupj4w
	jYY5KoLrF5pJ7iAdE+Dfgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743410001; x=
	1743496401; bh=YnFIXo8/GnTlyNAp6sWU5pl2bll/1dH35dzFahsEJD8=; b=W
	fZOnjVeuDDHjALxiJJLTDNw8q05IcTXzCK5EFrM6U2pd21FxGvyWi0PU1dARxU97
	lPPJrsb/W5M7txIMqVOi8lrSC3h5mScENWJxK5dC3mlkP4P40mrUu3lAFKLbXot9
	6z8Sg6jrd1jE7UmgjYnWYksrGzGa6x1y0m3TmySoTyOUjbIlC60OSY/QxhZM7rZU
	uNcj/lqXwVJALu0Dpoy/lPCEOwfJDZouXZuEeIMyR+WpCf92/usRvGzXfFKdMrP0
	uxcGK4rJjL4XTUAXpbrrOQGukPE+uK8VX/8tj/gOYWUbPxiwLdOXGDl9WzqaFSLp
	fjQWTjkawF2dEWgA4C4ow==
X-ME-Sender: <xms:UVPqZ2dJtLJAxsBaarKOVkr0gBzF55XMpp40WtBnRhhacKQAxxhpNQ>
    <xme:UVPqZwPnn1W4pT_P8pzNVKtEyC31pe4B-VJNjrFTor2aBgnpry4P2kN3eMsv_bDmO
    cI6c9mV9Mtekq738A>
X-ME-Received: <xmr:UVPqZ3hmxqaAMi4pft8s_uwVD09lrhzXpFDQDE0LTxF3NXJA7bRtAdfL2o1pCpm8O7sqm73FaQ41B-QGq3I8smf4tPPmTPvrW5rnXv4eZzoaRgvM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeelgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehtghesuggvsghirg
    hnrdhorhhgpdhrtghpthhtohepphhsrdhrvghpohhrthesghhmgidrnhgvthdprhgtphht
    thhopehsrghmsehgvghnthhoohdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrsh
    gthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:UVPqZz_dDA6ZmaX_O1ZKLShhchlvTkNvXOR4PMyz6HHhr7ReV9Q1AA>
    <xmx:UVPqZyuSmF6CzYyA9niYIwxoAAvvosogwh6H8nOpz1FsIF3_h3Q3XQ>
    <xmx:UVPqZ6F60-SsPMXwGo18S78tyPA9tFdBtQCogv_eEprXOQY2h0Ex4Q>
    <xmx:UVPqZxNuQYvN9BWG8WSn87DBaaBWUlENBhOEHaJP4XShLvjQV8Z83A>
    <xmx:UVPqZ_83Lb3g1soJpy-n8AxeZemYtetTcEfjV2BFFBasl1oUt9iyl1XD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Mar 2025 04:33:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2b242e15 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Mar 2025 08:33:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 31 Mar 2025 10:33:08 +0200
Subject: [PATCH v2 2/5] gitweb: fix generation of "gitweb.js"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250331-b4-pks-collect-build-fixes-v2-2-6b06136808f3@pks.im>
References: <20250331-b4-pks-collect-build-fixes-v2-0-6b06136808f3@pks.im>
In-Reply-To: <20250331-b4-pks-collect-build-fixes-v2-0-6b06136808f3@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Sam James <sam@gentoo.org>, 
 Eli Schwartz <eschwartz@gentoo.org>, Thorsten Glaser <tg@debian.org>, 
 Peter Seiderer <ps.report@gmx.net>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

In 19d8fe7da65 (Makefile: extract script to generate gitweb.js,
2024-12-06) we have extracted the logic to build "gitweb.js" into a
separate script. As part of that the rules that builds the script
has gained a new dependency on that script.

This refactoring is broken though because we use "$^" to determine
the set of JavaScript files that need to be concatenated, and this
implicit variable now also contains the build script itself. As a
result, the build script ends up ni the generated "gitweb.js" file,
which is wrong.

Fix the issue by filtering out non-JavaScript files.

Based-on-patch-by: Thorsten Glaser <tg@debian.org>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 gitweb/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index d5748e93594..26a683d4421 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -118,7 +118,7 @@ $(MAK_DIR_GITWEB)gitweb.cgi: $(MAK_DIR_GITWEB)gitweb.perl
 $(MAK_DIR_GITWEB)static/gitweb.js: $(MAK_DIR_GITWEB)generate-gitweb-js.sh
 $(MAK_DIR_GITWEB)static/gitweb.js: $(addprefix $(MAK_DIR_GITWEB),$(GITWEB_JSLIB_FILES))
 	$(QUIET_GEN)$(RM) $@ $@+ && \
-	$(MAK_DIR_GITWEB)generate-gitweb-js.sh $@+ $^ && \
+	$(MAK_DIR_GITWEB)generate-gitweb-js.sh $@+ $(filter %.js,$^) && \
 	mv $@+ $@
 
 ### Installation rules

-- 
2.49.0.604.gff1f9ca942.dirty

