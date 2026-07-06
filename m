Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578EA3D7D88
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 06:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783319061; cv=none; b=DFqD+DTUJEUyCZgULc3ZuskeckQXZScr88CoKN4HMO9PeNlSZCVYQkMryrHZKWbljhxLG+Lf5xvhgq3UgvcdY1D2bVJjMlr3XG12djN6xdtqW+0ivih+v2ZVguokVaxm3f3PwmKW/DUR2CG7Ul4Z/U07zlgCDxxsGq3H7KrvRcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783319061; c=relaxed/simple;
	bh=6a3wUNrBkO6Hw8O6fDvTXdoI/ukuRTPogEDb7gI/nwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ns5xLLmJthQNAU5tMn7axak2FKwHJX/NM5z7XceX1Pmwp5D7KxZF9xeqxKTm6wBvtL5INiSAhjZTQuYQ5NpZPF8jVa51BWnz+hnoSsdQvBtO36wj16ipzb79AD+6BGdAi3fx2Bl0VYXAtbvKYkzz1KMMAsKDsmTPDmfwnFrLUA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Fi7QYi7U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dxO7fFr0; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Fi7QYi7U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dxO7fFr0"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 055D71D000C8;
	Mon,  6 Jul 2026 02:24:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 06 Jul 2026 02:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783319055;
	 x=1783405455; bh=o/1qyf0sGQb1cpD0oKHhzoAeblw4z25zbhG3BaJw+jQ=; b=
	Fi7QYi7Uhdjn/6mVpcnJmmfyeJwNy9Yn7zC3YtkaAjq4JBJ2iaW+FWrTrtIXZHFJ
	3aOvgeVnFXhdpdXOJC4kZunQVSWbq5SOOHHL6zYAAspqTXcnMxVsN0+6KZnbuJv5
	3A8LXRbGuxp3nny+A4vu3OMwLBJaNAWQ6uG3yBQH8QwZERSu75oTZXcbJHiVI11O
	owbTUJJKKF+K9NwF5/7W7DU32QS3tBsR45EKrNOJzxqSNVue/103IqJQvyhX+TNf
	gpzIXnViQZR8FHYXCqOtF91r57Dy4fTa0xs+bglksSs/lOl7e6JV1YMwmbFJka4G
	vGbRl7IjorCgJI0jKp+i+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783319055; x=
	1783405455; bh=o/1qyf0sGQb1cpD0oKHhzoAeblw4z25zbhG3BaJw+jQ=; b=d
	xO7fFr0eP9Oo+ERkYqq6erzCqNDFhAjSLq2FcTMSUUXjeKTzwlBStnlOKNFugq1G
	kYS//Q10Jp4Xz0XZ3aJk1QTy4lJLN7NUm5P2pCcawp2jQwDyjVdnRBH9tNV6jcS1
	DQ4TrIijqzLIJDwn8LqWgMuh27G9uyUKriNqA9Fv7BWBmFjDCVft1Vur/n2CEPSw
	N2ivBPC1XmPqONlh9LZsv9wNw8ndE7kTT+5DQL8C+oSV8K/Md1SnfCoeIGN9upH+
	1aQzyR98zhJLKnQErZxzNz+RAXPclMMUZyOPGoJge3SLxbWdu+rY40XMKsXq4Ga6
	m3aofXo7l+zeg+eG3gVmw==
X-ME-Sender: <xms:D0pLar0v7mINSB_Qs671NSmfAiLmpc-HIEr8JNGH1Ei1VCuRCNfS7A>
    <xme:D0pLag8ItyGAeawrBjldhhcP41yztmK5tvgLXaO93pEl60EFYdCZ-nD9afN2W-2Qf
    NaAu38U2_mkXk8zpn2DOgxmLz_dNA80TvJYQn9IaKRce_Zx_JbCroE>
X-ME-Received: <xmr:D0pLakN7Et_t7NFX4VWmc4ylmtY-mq5wdA_CpD8GmXrWIRKTfKn-_7RdkowZyhdt6J-A7txX_5MOGNfUJp_ImwVDLHKe2LnPhuFLFDSqIPw>
X-ME-Proxy-Cause: dmFkZTGlIFJfvr9JjAUQqv3z9uzuI1TcAwCQgQC66pe+YtTvthMsaKYODAiYejZhaxWS94
    841aslbvo93PfbzETnU8H70ped2+XjEP+TKhKPd53H4rY+u+tL7GrH8AS3qHI0BlKr6zK3
    kuio88I+FAUzPfHelz5KBao/fBgYvHU2ards45tbzzuoQF9BIDWVOfgCQeV1WHXE25n8GX
    xYBV2C/AR6rWNwC8N1YRFPEnxtOKP+G8umMxB+a0vwblCkPX3EnGR46g2El8k5uulaFdEl
    BKPmOemAPFyBIXPXYvD2g/oA37H2vMMQhQe85NUkbU/7fSsV2z9Lr1xcEUFne/swzN4eWc
    Vc2by3albOTl4Tm0d+YSkGtf0ZNrb2MtvT/k2yZ2XuV2iyrejGY2tfAUYpjo2VSrLea1dq
    jmxXV1GSEQBH+rXYVUcrGx1aIjJ4wqo0JzCJA9JMKmMfJQ2vetF0KexWGZIbYXWegRkPPU
    3EPzCnJ4AZttISljZMLXnEpV8zmkFp1DjbiGqZ3iSkgX/F9XteBv31LdPMjQNcwXNN7rb3
    Oi59VcgQTBRoFAcWfEF037i4xY5tjfCgI6cMsjbyAewC8NfEgZnj1HApMaEreh9YPDBXNa
    C+NuGerjTIkOe1j/qlj1PYQg8FmtA9Tfg/YkmFA5OJj+P+jYrpzDfW0liLlQ
X-ME-Proxy: <xmx:D0pLasfXAddVR1vk2I424krXaB2YQkq8cE9hcB03Nm13G30bnVIndg>
    <xmx:D0pLarVmL-aV43w_XldGk1wyPyNRLx1W1VVyastDiW5PDLfqd9YIYA>
    <xmx:D0pLasiyTUFAHgTdhfhqYOUKZjT7Ijux4OjTleRn5ggd4pio91ukjw>
    <xmx:D0pLai8XTjNJh0ByrJ8OHfaz_kBiF_h4sD7inWH7-qDWegmX_Cdrjg>
    <xmx:D0pLat6k4z6JrSWW_JZLKv_aH4zRR9W_XNYTHbzn0HbJ9VNo7DDHfxEf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 02:24:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1bb647d4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jul 2026 06:24:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 06 Jul 2026 08:24:00 +0200
Subject: [PATCH v3 5/9] t7508: skip EXPENSIVE test that is broken without
 SIZE_T_IS_64BIT
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-b4-pks-t-fixes-for-GIT-TEST-LONG-v3-5-4f6c5a37fd1f@pks.im>
References: <20260706-b4-pks-t-fixes-for-GIT-TEST-LONG-v3-0-4f6c5a37fd1f@pks.im>
In-Reply-To: <20260706-b4-pks-t-fixes-for-GIT-TEST-LONG-v3-0-4f6c5a37fd1f@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Jeff King <peff@peff.net>
X-Mailer: b4 0.15.2

One of the tests in t7508 is marked as EXPENSIVE because it ends up
creating and adding files that are multiple gigabytes in size. This
takes a while to complete, hence the EXPENSIVE prerequisite.

Besides being expensive though the test can only work on systems where
`size_t` is at least 64 bit. This is because one of the created files
is larger than 4GB, and because Git tracks object size via `size_t` it
will eventually blow up.

This test has also been blowing up in the "linux32" CI job in GitHub
Workflows since 7a094d68a2 (ci: run expensive tests on push builds to
integration branches, 2026-05-08). But that job doesn't only fail, it
also hangs, and that has been concealing the failure.

Fix the issue by marking the test as requiring 64 bit `size_t`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7508-status.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index c2057bc94c..dfdd78b6fe 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1773,7 +1773,7 @@ test_expect_success 'slow status advice when core.untrackedCache true, and fsmon
 	)
 '
 
-test_expect_success EXPENSIVE 'status does not re-read unchanged 4 or 8 GiB file' '
+test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'status does not re-read unchanged 4 or 8 GiB file' '
 	(
 		mkdir large-file &&
 		cd large-file &&

-- 
2.55.0.795.g602f6c329a.dirty

