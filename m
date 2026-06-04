Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D5339183E
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780567673; cv=none; b=cQBPnuTr+610nxJMx3vavlT1GeqoefHd2DidAsA6EVtfO9OdjO6nj3Z9cGcUMqJwpHve8obW3aqH4CyGGIVTUOmYAI9SwRGoc21Xpzi9RTEb5GVnsKQeZyAm2JCgJ+s/W0b3dXA4x3lWb/XLoql/KgiOKp7Bxp2fqf4AfIDFDww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780567673; c=relaxed/simple;
	bh=8n8PRAf037CH9XL4HMEOpyzFmtSF+tpqDpGuV2Z2Bnc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CXoc4fbLBhFozV35pPrL7cVAjdVhvXnWFciYk8bYs+bOOQwAlt9drpsm4SZUMu2ynV/wJuND2aPURCbSGXggI008eSVAIridJnJZianEVqvgoSf/FrmqewQvvV5g4y0kxtNe1blb/52DZOvCDxcKNe0GpU3lnmxsPfI5mujdp8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vNaBjhjW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cbunAA9H; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vNaBjhjW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cbunAA9H"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5CC7014000FB;
	Thu,  4 Jun 2026 06:07:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 04 Jun 2026 06:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780567669;
	 x=1780654069; bh=cPnqtm1jK6ABZGpgqqYWpFEOKH98Hu7UxDSfI1cN2XA=; b=
	vNaBjhjWjmWjs27Yb+jdJ2ifUxkozRBjr9ohYFgXkBzL+Yq2229GwuzfzdBsF4wk
	Y9wyHPvSX90pVruN1NZyAxAsJWj6rc8HCv+haLDHHVQHtIsvFrNyxBzLuJ5p9x6B
	1VLPcI/Xh7A2EtwViniBwlwZKRFehhEvA4cIuj1a4rUptyeQGYcaOq6zScEG85TQ
	GFUeDJ4Occv8064E6ymX3ex2m+UFRqxGKnRDnmLFKH2Uwx2wdgWny9sBe72HvW8u
	+AgMOZYyK770GXJaG27IQ8lu7BxMhUaN0uDf5SwcXmGlRQGkhOPS2clxhtuX9vGl
	fYKUlS79K2/LZN97crfqEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780567669; x=
	1780654069; bh=cPnqtm1jK6ABZGpgqqYWpFEOKH98Hu7UxDSfI1cN2XA=; b=c
	bunAA9HpDTNEG+0xqByS8orp0U3eA97UgyjfpSM32aVlewx4owgYGnYr8vtc8oWs
	QgVfxoAfUV4H/Ck76z3uodHXcBqnyDuOBvVaFkhBM4jglH9FUWUXeGnPS3wSAqDM
	Vk2heSQXjE48fPc+hMW8vPoxA0KnidtGHt4RvQp7yQvGyqGHazi6YnhCeD0qN2Eb
	pxGE82hFisNj7yICC1fou1FDpEGa2m5oalnpAwjpdTcUV1yseWpgWXCVWGHulhge
	7pZjx0iJq7/j9Myu+AcJQINyGlP06j9RXfwl2W6qWwzExWo3BuB/LtmmzMa5mXE1
	khX37hZQSUqEzjO8lQtLQ==
X-ME-Sender: <xms:dU4haicS1uoOnbeHIvg6c1gHplIsCey0ZiPr8FTfgqnkl-gKVGqcGQ>
    <xme:dU4hajq8OpEqk4R-DCM4lJ44_C6BhcDJi0gLAyFEQRxVg8Z3QCyjnwV-VT3a75f2o
    J85GV8_FbJeq9JEdbAmX6SQV6x30kfsVkXb4XDqn7yYR8BZIPyqHw>
X-ME-Received: <xmr:dU4hag5JFKFieURVEhdveLmwGw0TDO5EJJ4AlFS8lisJtGZkZuIRiyDC96kjmGyg4RAQTx1TwCh2Iun3nxZlKsWpb0-a-j7eCEKDKfzbPa8>
X-ME-Proxy-Cause: dmFkZTEoYpUyImn8JZMtgYxX1MTkmiJjgabCL0/U8UxskOkIDI4cnEh86zA2C2QIzJgodB
    JDNdBatMqEqqW8rsUyf59mOvbPDO9OZhZdiBCQ+EuWhyHY0Dd4AU1VTI5NcaYGyERb0sSx
    AxAmlU1Y739q+LRs968FQG+wvlDvwhReNhzZbhJVgxHEp6O21JvFuflAHwUVCA1FYpiO0T
    +9yfMJFNQYowNsE5SPGx/hTIuGUEKAyBxtKp1i4HeRZVGCC0jcPzmI4XJrZlM9+ghDAmR4
    pm+khlqGJT95yeAuLPfZBxEpBHHc9GOgjClVmzgBMIqsB2L0hdLfcMfIPxIpkIeOryaqPO
    Yi8e1S8ct1LivdFPZEzEFLZfha9yt1Yl1KU66va8Al7w/DsBbwwy03J+h0se7a0GWVWy4B
    BKonn0SsUWR4EvSIXvrwfKmOWAW6pfxz54MRfkSpZWYc/sHaf45ZAmXvW6Y82Soyo33IU9
    97dtIa+6NftgqqhkYCYlj2dG1EQUXCl2U9fg77sM9vh+ys31IL82x14bJoVu2MLc/osd7+
    zaRf9aSlpSgNGZ+6kphW53XEJmomdM91khqH7oMM0kbHuKxL5fqzKyDvZorg0Vq2kUIuDh
    qj56V/bR0vAZRiuSUtBi67AZLnKlB3IneB5iA0mh+mH9hzPodIYL569J1uEA
X-ME-Proxy: <xmx:dU4hapoy-DTY_aOZzE5oEUeBUH3WSPfc6dm1YSJZ98M5wrgKo_J9CQ>
    <xmx:dU4haihjfSdKSikcp-mQD6NqFoVD0zQxSB6NEnKanXgKt_6Yv8E_VQ>
    <xmx:dU4hajKp6proY3a5w47tkR0_ew_F0yxvpo3EibyqSRlsif6PD-NH0g>
    <xmx:dU4haiAA2I11iXzfywk2rj1VeQ356X1eH7r4PDyVN9_S6JlroDTc6w>
    <xmx:dU4hasZOpzs-G7ieBiqWmUoTm4Iz6k91RzK2N1AvCK6FOPIw7ccSpGph>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 06:07:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b519c7e2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jun 2026 10:07:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Jun 2026 12:07:35 +0200
Subject: [PATCH v3 5/8] t7810: turn MB_REGEX check into a lazy prereq
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260604-pks-t7527-fix-tap-output-v3-5-7d766ed481e4@pks.im>
References: <20260604-pks-t7527-fix-tap-output-v3-0-7d766ed481e4@pks.im>
In-Reply-To: <20260604-pks-t7527-fix-tap-output-v3-0-7d766ed481e4@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.15.2

In t7810 we verify whether the system has proper multibyte locale
support by executing `test-tool regex` with a unicode character. When
this check fails though we'll output an error that breaks the TAP
format.

Fix this issue by turning the logic into a lazy prerequisite.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7810-grep.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 1b195bee59..d61c4a4d73 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -18,8 +18,9 @@ test_invalid_grep_expression() {
 	'
 }
 
-LC_ALL=en_US.UTF-8 test-tool regex '^.$' '¿' &&
-  test_set_prereq MB_REGEX
+test_lazy_prereq MB_REGEX '
+	LC_ALL=en_US.UTF-8 test-tool regex "^.$" "¿"
+'
 
 cat >hello.c <<EOF
 #include <assert.h>

-- 
2.54.0.1064.gd145956f57.dirty

