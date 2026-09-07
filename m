Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B0946F486
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788780030; cv=none; b=KHyNVP2wD5nCUJiBlThNk+znjWOomITAqqCqkt2gM3XziwBfOR1bzOTPhQUvxl+06/V3qaV54wpurhgP8lPRt8YP80e1c3AajBdScbuSskHlJkIQPfOlH8UrFrK3foHUVcfJDNedquH6ywshLOt9NBzlta2qqJlTMkyidPOFrqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788780030; c=relaxed/simple;
	bh=9yS9gHi/2Oc7XmqpkJQh2ERN4jTO+vXU1jDlbrpNwbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dKdDLvsV/DI/xSwRPzPPr4ePwWBCDiYBjimXbZwH++Wm4NPhPZBIVz0+pw50MEwM6O1VyBkXgAsWRJBdUaAx6zIk9Tv5kiuZ1rUL17o3MG8chvEWqN1FcCd90MujCNYLIZOyzStjc8x4EgjAcPn9sfCk2dcelC2N9lYebhKOyYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kYQvVgFO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QB1A8VZP; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kYQvVgFO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QB1A8VZP"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id A34D1EC0242;
	Mon,  7 Sep 2026 07:20:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 07 Sep 2026 07:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788780025;
	 x=1788866425; bh=L5b1BPP0kS6UsgoYiZDfw+LOq9f0yAj2zrhZhKu9ZlU=; b=
	kYQvVgFOo/HqXL5t44L+sIvxuPFB+jQKfEj2zvbW37eBB8myhywKckiqgzjP3gG8
	sAJn9s9m/Yp2LgDLg4Q0S8EZgLSHkEXzwkGLo3LNqiILkMA3D5HPVUcgsu8hHlcn
	Ov7B6wLPmIysnJW62wipoXc9KiUUH4FnoNkVBp4LytzzP4YCL1b0utG4oGI1u1cW
	gqSaTTj9iry4d44R8fzULtW9IzE9Y/UhGAA+xof1lmfRKBSWDJVfU9xKK49PuyTn
	7AE3m+7JuJtw1MGI9cdIZG9ym4ESKB1LEDN5fSL2El4vNelANzpjWwcwIlhbLdUG
	0C+IM8GIeVawzAMKiFv7Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788780025; x=
	1788866425; bh=L5b1BPP0kS6UsgoYiZDfw+LOq9f0yAj2zrhZhKu9ZlU=; b=Q
	B1A8VZPJRA29KEVk1dscL0yB3AzL9wyIh7T1HRmCkjd5FOU4MEtKdNHctGwY8OtV
	RGbWjeoePaoFLoXGNqDq1qfEJLeSpWsXoOGV7yVT/2s+5nHxdKMQxuJBVzydVjxE
	91Vw0UWphhxRr1Np/Iun/84L05O+BNFM7u9itF6D8eg764DPotXP4owM98A6YhUJ
	21oZlJ3EAwzwByXF44jxgATL32lbSRasmDP7pYtREe4pI7WMySjYKajXmMLUyHzF
	Dsv2aP7oeEyySBUJj8GDbkegJDSLsb8ABdgAfP1j9nBdd/2Jhiz5qsyweCrwxWv4
	bqlJL4RhTlfiSSOFShGlQ==
X-ME-Sender: <xms:-Z2easJYHqmAM0g0AUSjmlRqrROgmrbJdcxG9FDVNqrSVouvOmRWsw>
    <xme:-Z2eajkOVAbRBsTF2VKsj1WKmOoEwnfTNvCCB_6EkwTxF6B-rm4TBHPfHCERsvwfH
    U57QNa_EjsVCMxeXtSAKvrZEz45RuFgfNIyKGgekMU0Z7i65MUO5Bw>
X-ME-Received: <xmr:-Z2eaqFMm_XXQGSPe9foJr43A-vaNjyZ9G2GH6C2mQiVrrB9ovg3-g>
X-ME-Proxy-Cause: dmFkZTFoKZgQEqhZRO239b+8hnPbfapsRjV8oSQdkKv379A8I/jT7Pi8M1BltYZwASCtVh
    74w7ghSo2A6JuFF1V+fMbhGB7NR+9/9V9xzl0CEHQ1htGieUl9mOgP5RdYg4l9fb1nlkmB
    G+zNlpgO540VVW4Slpjqbdwj58l37HUzlBxbWkNpYJhImY+IiBTIbs/pfpfrRtAqFOFfpC
    7DQhehxXyLjiCVbXyufUXQpIVZ90tvYasY6DQbrlXccpPvBPmaM0qjlNURiP9jHG68MFG8
    VJvMvXCZDSewarnWwh8qN00J1ZSP0kqDqek7KIGnGOd+3mVgkpRA1L7vlpHxb2H1vx7fhM
    XrA86EEVURqqQq9DNhFYxwHw7AgWOxzhRO9euSG1g2Lz6rmHF537+/cxA/clqYHMsCuGXZ
    SpznPTae1Q53DjRqLReNRKTVfJNSWzZW/EnXit3HHGmbsJ4NPeBcfV02+OwXSdw0JO7QDl
    YbEhLHFHbvjNqldeRF221i61yTS1CLFmdypVX6a+jODlJvg1W0V/RL5o7Tsc33WbCzn8yT
    EtTSpuuF2AZAd7EXDSZue+/A1aEdmfzWvN9bS21/Ax32Mh/aBaoq5ZFReS/CWRz6nHL7zt
    9J6NVpXzJvV9X9AG+O8e+xEd6zUsbXUrpNAJERsz3hX/CiNXeRLMKlgTyVXQ
X-ME-Proxy: <xmx:-Z2eajHKLkUEDEOx75ExLbD4YkziWbaZDppFMQBAZUxHZY2ottKK-g>
    <xmx:-Z2eanOYIcwGaefd9vAnVCoN9Sg5SJvp2eI6FdKxk-mrQH4YDe7Kuw>
    <xmx:-Z2eaiG82mdTAkIjviTyGHJBVX7mp9hPRYVWfbFrOMgkU2xUwDXOSQ>
    <xmx:-Z2eauPJZjelTJWsdpncdFbXMDXV011KimvpW0A0bpRV9PWyKouX2w>
    <xmx:-Z2earlZ88BtgIDWXOBAGP09l-jAuDXH9ZBVGyRFkMMNU4LVUAyp7LpJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 07:20:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 16e1ec21 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 11:20:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 07 Sep 2026 13:18:40 +0200
Subject: [PATCH v2 06/11] help: rename "default-ref-format" to
 "default-ref-storage-format"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-b4-pks-unify-ref-storage-format-v2-6-6733c90ca5b0@pks.im>
References: <20260907-b4-pks-unify-ref-storage-format-v2-0-6733c90ca5b0@pks.im>
In-Reply-To: <20260907-b4-pks-unify-ref-storage-format-v2-0-6733c90ca5b0@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

When printing information about how specifically Git was built and what
defaults it has we also print the default ref storage format used when
initializing new repositories. This is to prepare for Git 3.0, where the
default storage format will change from the "files" backend to the
"reftable" backend.

In preceding commits we have adapted "ref-format" parameters to be
called "ref-storage-format" instead to resolve some conceptual
mismatches. The build information is now the only place where we still
refer to it as "default-ref-format".

Rename the field to "default-ref-storage-format" instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 help.c          | 2 +-
 t/t0001-init.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/help.c b/help.c
index 46241492ce..1dd8391eeb 100644
--- a/help.c
+++ b/help.c
@@ -824,7 +824,7 @@ void get_version_info(struct strbuf *buf, int show_build_options)
 			    SHA1_UNSAFE_BACKEND);
 #endif
 		strbuf_addf(buf, "SHA-256: %s\n", SHA256_BACKEND);
-		strbuf_addf(buf, "default-ref-format: %s\n",
+		strbuf_addf(buf, "default-ref-storage-format: %s\n",
 			    ref_storage_format_to_name(REF_STORAGE_FORMAT_DEFAULT));
 		strbuf_addf(buf, "default-hash: %s\n", hash_algos[GIT_HASH_DEFAULT].name);
 	}
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index b4f19d8077..6f4431bed7 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -668,7 +668,7 @@ test_expect_success 'default ref format' '
 		sane_unset GIT_DEFAULT_REF_FORMAT &&
 		git init refformat
 	) &&
-	git version --build-options | sed -ne "s/^default-ref-format: //p" >expect &&
+	git version --build-options | sed -ne "s/^default-ref-storage-format: //p" >expect &&
 	git -C refformat rev-parse --show-ref-storage-format >actual &&
 	test_cmp expect actual
 '

-- 
2.55.0.1007.g17ff1f9808.dirty

