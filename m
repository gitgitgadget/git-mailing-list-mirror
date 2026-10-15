Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1754A2049
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 06:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792047451; cv=none; b=l+lXNkom3LAiwPwwrjWm4mG0SUQm8euiXX88J4XUpV9DwU3GHHH6tq9tD1rwlJy/94bdHEB/pZ3F3pp7dUx99+hvAYgfI6pJI1lNAbnbpd7VxC4qhTZQNxCCYSDaCkRhSWkgvI8/gIreZbVbO1QXucpftvUIiPU0AgDS95EV3U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792047451; c=relaxed/simple;
	bh=6rI/w18FBVqO37aAw3fY1GBXg5fGBcXBRae1E1Zn9nc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lPijlBVq9UA2YN3ApByx1x0ckSfj0P1sQH5jI5cVEWswKSHIM9LpXl9Ek9a8DGdVw1HJFTtdF/06JtS13rk61WCNn+wMDs5ru2/nTUoYB6KalJexoUzSg39y5rZzx6i80iAAkN5ynHhsoRKQE7heVQRwKdHCxaNL3Di+l+QWgek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Mf5xO4Oj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rX7AKUjV; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Mf5xO4Oj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rX7AKUjV"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 161817A0193
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 02:57:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 15 Oct 2026 02:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792047442;
	 x=1792133842; bh=ApmT+N8IukcXTpysj9yv6zRl36qdeWJysk/JdNWOTaU=; b=
	Mf5xO4OjHw/tPuKbDW6PqlhcsUtCf81uVfKYFgbrRA4g5rpMQV+1SMz4UYGSFHMj
	pW1ln5MJujrRff4ZojCSAyXw5EftpBw+KlLT7mvnOMYTzJzswjGdDPWOFFBcxAz3
	FOJT5DKRZJ15TWmx7meGXb95ZUoJtn4qGu5uF7ClvpJVAaXEIe07kM+afxUjngGo
	vRAGFQjHMrXVp/XT0SUsQtNRJXWTiXV2ZiSQPb8cp0nBT7ntRTC6VOtZBiZ7dpbA
	dTfmMwl/eU5spNQJEMbJvdm28gUqWM9vCADmtBW8UCx8i0GdhHrA6Ao0PWW0n04o
	XNo9J2ecQO9uP5eiW9awZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792047442; x=
	1792133842; bh=ApmT+N8IukcXTpysj9yv6zRl36qdeWJysk/JdNWOTaU=; b=r
	X7AKUjVO7TjHAYSOVH8MQg7JKxcpG8wsXjIL5rbX2mYQjUI+AR+3fTZsL07R68w2
	7a/9dLHwqVBWbD+lDcbC8mXisPRn7faysiumos8jLT9/EU/0wY4+JvZ5Epco4JVL
	cshVMghE9GX6u6AthW8iWzGphgj7KwGPU4CnkhB5290UO0EXMfXov85dzn0Qo7Ro
	s4GnDl5QOsUyVbAeTKjHIBrX7gwyMQ0Ikm/ORDz74aaNdac11W9XeYUICBBQX3nl
	NFIVYvmPSTauMI8usRQlnS3Mfz9zNA4RB/TNfFym+h4Xp9Drl5qpx0G2IvOZLuyr
	fHjNWw69EbEAdrPdKoKjQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792047442; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:AOBIvtBjs+Xu9jRq2E0xZkY1sox1RbycdbGKt1o7MYlYq3u
	TttM/weKAuHavvegPbvPDLTZ/wjXwHNUQLqf1cyRGaExA8YrACfwVWAwlR3A5xkN
	6lvzO7hUGsHyM/hABbw9ZisTCyprJTfLIqqdltmRsTw50oS+ROBq8HrwCicGZrar
	Ggd3oxFxSCbnU5mveqKbherJ9FVWoOonb4TJpUfdaM7GRgmJHamOWF67uqxPuV/y
	ENCv+eCI97mwJXcuIel8K9s7CIly4gALtpdaBqlH2dTam6r+Z7GsaatfPcsrVsJH
	hmqdm6tgRqem10v2hqW11geBT2JgfWE4aMMt8fw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:mr+aXQqAyg/slh+Tl/78pxo0Ue4v67k1WrmQSQKzFzI=:6rI/w18FBVqO37aAw3fY1GBXg5fGBcXBRae1E1Zn9nc=;
X-ME-Sender: <xms:UnnQarghEfQzAK5rGVMU7VI2RFuUaPc-eYH1a1G4m7jDlY5LdS-9NA>
    <xme:UnnQarvsp-xPwtL9pHKk7PEQxuANG_Em5M8RkZaQGAW4PErAAGU6n04u2mzPD0__9
    iyhckCxxRVKHdEksrV9G1rzrHwK24ZNedoGibBoDNtzCZkyEbtcWQ>
X-ME-Received: <xmr:UnnQak4oV1GhrQ2483nLxFcZhYjqe04Qqr4Lr2km-FakfGOVMpkPS-fXxF3K-1zmvdVHiCQ>
X-ME-Proxy-Cause: dmFkZTFR2gXAIfQ/FpRZfZ+y40AvQU+NV9YZRh5rNA/h5E4kXCdHfNjsr/Xe7zptRuPm6k
    HEQydowXCPxz+8KdGLDlCNKjYcUHbFpWcPulaFKicQYFBD0OVl73rfqfs8xaulMxa9y2b8
    CcRFZpUtOwZeMklp4a+uAqFi++0EsXBS7soZiYnLDEjYvU14VCFOhTxEXmM5JbumMTPsZM
    XHlmxzE4mLD/5TcZm86Yn8nvQ+9d68oXnAHzX6GRs2kc393M+r+4TSA65ksq+CxWc6IH/6
    pkEBrrqg7XivpzbsJ3OwC2k//kAFo+cmcpGrWY+4GsvHPLpNCjzHRsi4pLDqcjVRDsgXdb
    G6h1u0GJMWXcjSAFYF/42ecDsMSzJcIqY/hjSkyZNpdrQ61TEJOISD8JU52TqkSYw+WF+Y
    LZsa6hKjXgBspji6/U245bB4yHr2T+I8Krvt6g51IXjKZYAF4nF8IfSxtIBvUdNfprsi25
    F4U2zvDqCAvUIpIr5yvD7TVYK1L5Q6jZVhZbAcUxEGf0KxqTItex4yjXyRt4jhiN6oqWon
    zpGw1g8DUL6Om2EENM/m5ttj/528H+rIHVRYH0QfFly2SqGMlhVg6aTDnNia+HL5eSf4GS
    Wm0WtvI0fJ28O2dJrEvfKAlmll9VHRBXcbj/RhmocmezKAk+QH877R34o3Ew
X-ME-Proxy: <xmx:UnnQavOsJ6BRjGOy5W7BWV4_Vs1EMcQFQILZOKZwHYghHgeYsmZDhw>
    <xmx:UnnQaqvEwGYnF95zGbWWhTu1WtYGYbcgn7vPK2NpmsQOL1X3q1CuuQ>
    <xmx:UnnQaqZ9mRd9ubVoN5ZrS0djGb5PvzA82ic8wVMGsgJB2JcWpTkMNA>
    <xmx:UnnQakwaTsrDunM51LFU6dUs6bUKqPwZAqI-JGyHqg14DqIdhjJ9UQ>
    <xmx:UnnQajS_Vw7F8vxcGWWynMkPMszHw1dNkxF_sm84CWMqqDdIB3BwSccJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 02:57:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5161501e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Oct 2026 06:57:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 15 Oct 2026 08:57:11 +0200
Subject: [PATCH v4 2/8] ci: fix "fedora-breaking-changes-meson" job
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-pks-ci-housekeeping-v4-2-c2c88f1b198e@pks.im>
References: <20261015-pks-ci-housekeeping-v4-0-c2c88f1b198e@pks.im>
In-Reply-To: <20261015-pks-ci-housekeeping-v4-0-c2c88f1b198e@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Todd Zullinger <tmz@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Mailer: b4 0.15.2

The "fedora-breaking-changes-meson" job exercises Git with breaking
changes enabled on Fedora with Meson. There's a typo in our CI scripts
though, which has the effect that the build does not enable breaking
changes by accident.

Fix the typo.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/run-build-and-tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 6a3b43b366..bc5058c917 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -18,7 +18,7 @@ almalinux-*|debian-*|fedora-*|linux-*)
 esac
 
 case "$jobname" in
-fedora-breaking-changes-musl|linux-breaking-changes)
+fedora-breaking-changes-meson|linux-breaking-changes)
 	export WITH_BREAKING_CHANGES=YesPlease
 	MESONFLAGS="$MESONFLAGS -Dbreaking_changes=true"
 	;;

-- 
2.56.0.212.g129ede20d9.dirty

