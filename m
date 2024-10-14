Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DFC7E574
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 12:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908483; cv=none; b=G37CDqyj7JkcHG6Ey+3Pho9+9iw92vvPubaAjvsfVj8HaZhyb7I6G0MqsN4z5ExXKbtM5d7sLJuTa7+RypwkNqIXGJNMw96ar394a0X3hox/Y2baFelkTD9qhG50IaT1Yz9aZ/1Qtt5cCn9clDB4CiFW5JNRi0POKYt2dqUEN1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908483; c=relaxed/simple;
	bh=Ou5SFhL/rUe6C+qwfh4+iFosi78FuFspGv3OQKjbP+4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qrms3xBSvOH/4XLE7bArshfJhOgZkgL5bvHkvzzLEHU1PD2QSd6UEdTCYbgfNmf1Ii2ighBXzeZZHgFeqK2UFE1ldqsMMIJ87AhPJKxrOYZNamTFH8KBjzeyzR0kANb/XBzd+7kqK55Bzq3X7qFr5gKd3w+kZy4tg9QCPWcuajE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sKztrLbS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b71SxOfP; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sKztrLbS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b71SxOfP"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id CAB71138023C
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 08:21:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 14 Oct 2024 08:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728908480; x=1728994880; bh=L/smTfNcha
	Y++CwGOKTQVb6OTjgn3o8COvfEr0IVfIY=; b=sKztrLbScCE8RdAfTCb/qmSl7q
	4iQ+iP9JMWfMeaGKil5fTu8bs6Toc93kMMLHDusik3Bqg0WXDRPWpCYQhkk2qRXp
	29vsTNeNAYxUBXP2HMtSDOD0kCy495xKoRWRtZKnmdWXThVXBraZp/pbDyMnxTIz
	zwzJds6hJoM90UHAs/FogrAAJwjtjMvfvsytW3xl69C/oY6LmwJSGWMhgAPZg3T5
	HB5XjMRAATSNp1+useOIoyqk6b/jNgFz0KtX8174tk5AWadB196dd7OoIeAju4WK
	FzWJV04I0t1wuL7nzBUi7CcrBUYATrA1Nny5LALs8AWgu918odimu9ylp/9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728908480; x=1728994880; bh=L/smTfNchaY++CwGOKTQVb6OTjgn
	3o8COvfEr0IVfIY=; b=b71SxOfPuXpYM3HD1Pwzoto1ZyqqiqaXeD8tOb2m/Aqz
	qdCbvv91FxeANWg1XJHDkJAX5Q+JirzEBrkawUfoPvcIh2LZFYrwUIETnKbhDKxC
	jZOn2Uic5jvki3OQpf05iqMVSH/8DYKuS1Ar4tvKWjoIwPCaJ0iAlvmpiUHsm5JL
	YKikBpFhOSxSz5MvRl1pOFet/i+0MoeOD2Srkasa/+S5gECnUxLxdQEfA/fYjxIk
	EsGb6wdMhBzMX9V5CPb4YI8LvJI3J/XbWXQSXzMdJd1RnBuk2fqSIzNEZ+d6SX3s
	G3uxxBaZvHe00BKAnYYYAsm7Wn9yWhai2Arro6UEZw==
X-ME-Sender: <xms:wAwNZ-qRAm1bbHd3iqtUjRorVGHbGiAuaYfJE8WhkkuEa9LDrnlm6Q>
    <xme:wAwNZ8p43nC-a7Kip6I9grXMNviLWHNvTBsHkAomU2BJAC4E12sgdRV2ql80Fi4c_
    xX8kdzsev5qFQ3ocg>
X-ME-Received: <xmr:wAwNZzNC12z8zVZlm_Dyg5_sQX7SjGtM5lYmG4lF59KaDzWxawfMXDyPvcF7wH4-nMewpnGr2_k9paVhoKG9-OYANkrWfESYU-z4B-4_zEvciw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wAwNZ95tCEMyrTL6u37l6FQxG4LekAv4AHiiErjK9Pd7pt_6fYlmiw>
    <xmx:wAwNZ97_NyalKiOKlyfbvX4XgPqi1u84_ipFCbFnVJrWkt0ZWlNLig>
    <xmx:wAwNZ9gBSHsON9i92caFSb1edCPVbUdQWbkeed19JNxJBulzzBB-eA>
    <xmx:wAwNZ35qDqU2ieNo2o2AwntVfdvFpnwnkQmQNIkW-v8LQMgPcxPqRQ>
    <xmx:wAwNZ_QWwL6IPeElA4_lX3CV_6qaX8dubI7kTpTsAyem0BSqYkLOKPx5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 14 Oct 2024 08:21:20 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fbf20133 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 14 Oct 2024 12:20:07 +0000 (UTC)
Date: Mon, 14 Oct 2024 14:21:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 03/10] t/lib-gitweb: test against the build version of gitweb
Message-ID: <eda73d81139e640f4f942818f6035770b7bc9121.1728906490.git.ps@pks.im>
References: <cover.1728906490.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728906490.git.ps@pks.im>

When testing gitweb we set up the CGI script as "gitweb.perl", which is
the source file of the build target "gitweb.cgi". This works alright as
long as we run in-tree tests. But we're about to make out-of-tree tests
a reality, and there things will break because "gitweb.perl" will not be
found in the build directory.

Fix this by using "gitweb.cgi" instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/lib-gitweb.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-gitweb.sh b/t/lib-gitweb.sh
index 1f32ca66ea5..c64c87fb87d 100644
--- a/t/lib-gitweb.sh
+++ b/t/lib-gitweb.sh
@@ -49,7 +49,7 @@ EOF
 		error "Cannot find gitweb at $GITWEB_TEST_INSTALLED."
 		say "# Testing $SCRIPT_NAME"
 	else # normal case, use source version of gitweb
-		SCRIPT_NAME="$GIT_BUILD_DIR/gitweb/gitweb.perl"
+		SCRIPT_NAME="$GIT_BUILD_DIR/gitweb/gitweb.cgi"
 	fi
 	export SCRIPT_NAME
 }
-- 
2.47.0.dirty

