Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387E029ACC8
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 07:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961484; cv=none; b=NMuiciX7CuE2gzp94QbEzGowVAFTTYaKjsQKrE5nRzZPXtbbWtbAlu053p5hJB93oa53rlTX8KDpa48+FEAVGhVeyFhDjFxk8XdSlwDYfZkad9JLIhUHDgHXH7V1lYn6swNL/gKKl+TXkuPuRGMQ6PMhuGU+v4mpJfxfShhLjyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961484; c=relaxed/simple;
	bh=1hF//OB7MpjwgN7hTUiSGSiEYZC2uneYbHjLHkzKbsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZA3mX9sbLXWTUHDTPStQKzrxAYqwWiZZ/zJ7d6iZUVPZUFpBTcy6G+xcvyxlTCFd6/wFY809cVPfrUfeoNu4M0obv6xF1uCWNvkw/vI13wM3m/NY3Kcd4BCkK2CaP3m57a4vLOmKJcaMeqMvNX06ZCc4ABS4nfjkfQPGuFchCKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JEC1Php9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kwXRBeK4; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JEC1Php9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kwXRBeK4"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 633DCEC0B5A;
	Tue,  8 Jul 2025 03:58:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 08 Jul 2025 03:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751961482;
	 x=1752047882; bh=N7C++oCxfNsq8K7+5JNUyKveB29NNlusyf+ft1e9Pbo=; b=
	JEC1Php9WIbJ8Nrf56xCxeE1Fvh+LwnGG8BXgds+KJJlRVkcW3mjIkRgvDxSE9QP
	gmLesF8Mhsq5cagVOei37K8MiFYlj6BeIeORU75OJJ1eGU0WsgEWywvCkRKqirJg
	fnKyGga8lpbUr37neY0PCGHXqm1EVAMlpaUgYROxxCOap/FaUVB62SuBuAwUlUih
	bxSlzRPO703cg+yIPA3SPOuoWnPqW8zwAFrdFPQ2EgpqyVNecJUeaYV1joA2fabC
	99nCTaK8b9N4g+OGPHNWSueY/8wPsYmcxpv0W/+Fi+lrfZ50evoaf7gghaPNo2AE
	JE+L653nkC5Jxz9txnGvzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751961482; x=
	1752047882; bh=N7C++oCxfNsq8K7+5JNUyKveB29NNlusyf+ft1e9Pbo=; b=k
	wXRBeK4ScS/VM91OEz5KFjmhrunILoANGrXO78gbPebX3DuYvOUlDvaFFS/z8LjH
	11vPV58YGdief4AjAppAtEDWimHt+/k/+7FX2PMIYHoNQLKJtmGIOcR+IQ8rEZPW
	qtQUsaJdFzIMVp6fdnVP+iKi0rPwxpa93xCgUhGkZcPp/6pgfhRwh3Npka+WhEIr
	IDGAZTm7/irYo2RcA9ZJs+MinJQhuSJH7COm4wWhNvegiRJnqxJTZZpdTof0/wzh
	or9aJf2WUrxsGs3ESoeDuYolIsOgaiE4SEv3LMF1aMRmXsN3Igt19V0n8zMfEJ5N
	4LF5UVzCWEkpLfImXT+cQ==
X-ME-Sender: <xms:is9saL-Q9J5FdSQbZOKjdT2I5JRKOP9SrAj1Km4XCI7d7En3_9aVcw>
    <xme:is9saIcKt-D0MfVi-vrbAWFmzvkUeV0w0-WWXlg4yfAwluu6cOLKsr_IQ3YIq2d6Q
    9KhxLDkTzslDnQOMQ>
X-ME-Received: <xmr:is9saFLkCHcYtJ7sE7NtyyhWO1BoUvIRKxHxjsCxyQ75iL1-U4RApfVAGRPLt8GIV-ZxnXUMW8Ww31VgxBrLGxc49VMzJ7YKLWyfH0pPvWo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtth
    hopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepihhrvggttggrrdhkuhhnsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghs
    tghhfigrrhhtiiesghgvnhhtohhordhorhhg
X-ME-Proxy: <xmx:is9saIhZi1G_TIgq4CtO9eWuqJfNodbckryawjphGBJtTuTs7q6UIQ>
    <xmx:is9saDRT82J23xn7B9ktURkS8pWE7Hgz-FgwtNermdcCZ6Rh0SOB0w>
    <xmx:is9saCUBj3U5LZFp9-IV61pX4nFm0bOFHBh13AEmHG78uL_fEPwJug>
    <xmx:is9saPQotjtRO-J6BRWvEMkKNv4548ak46TXwzEqZSp4YZXb0H5mUg>
    <xmx:is9saD-BGBsAaFHupIpeKMPGwsrUsPMVdXPDfOF_YqmlBCzfAbwJxnhH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 03:58:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4a610339 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 8 Jul 2025 07:58:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 08 Jul 2025 09:57:45 +0200
Subject: [PATCH v2 4/8] meson: clean up unnecessary variables
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-b4-pks-meson-cleanups-v2-4-94ac53cd4b95@pks.im>
References: <20250708-b4-pks-meson-cleanups-v2-0-94ac53cd4b95@pks.im>
In-Reply-To: <20250708-b4-pks-meson-cleanups-v2-0-94ac53cd4b95@pks.im>
To: git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, irecca.kun@gmail.com, 
 Eli Schwartz <eschwartz@gentoo.org>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The `manpage_target` variable isn't used at all, and the `manpage_path`
variable is only used in a single location. Remove the former variable
and inline the latter.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/meson.build | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/meson.build b/Documentation/meson.build
index 2fe1a1369d4..4404c623f00 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -375,8 +375,7 @@ foreach manpage, category : manpages
       output: fs.stem(manpage) + '.xml',
     )
 
-    manpage_path = fs.stem(manpage) + '.' + category.to_string()
-    manpage_target = custom_target(
+    custom_target(
       command: [
         xmlto,
         '-m', '@INPUT0@',
@@ -392,7 +391,7 @@ foreach manpage, category : manpages
         'manpage-normal.xsl',
         'manpage-bold-literal.xsl',
       ],
-      output: manpage_path,
+      output: fs.stem(manpage) + '.' + category.to_string(),
       install: true,
       install_dir: get_option('mandir') / 'man' + category.to_string(),
     )

-- 
2.50.0.195.g74e6fc65d0.dirty

