Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C014134A773
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 22:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781648797; cv=none; b=GVAJKeYohXqb+P2UD7dEyiyWxU0cWwGNX0cyG5SNMflKC1Rph8l/qwWPwi7G5cGrExZl5POYSMXnBiDYExVbispvmioRP3HR9rzJyWBfJhnNqgfaG9qUupr69TUvIM3vUvgAAPWK+j9rwISPKlFd9DOkX4Vk7+ucp0rGuKowO2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781648797; c=relaxed/simple;
	bh=sl/0M90z0402cVvfzwgGyHidn40O1fbpVZbANRef7v4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TasSwarh7zPBkdZDNCH7xPDmAhI7dSOaLm3JVjh5qpSyVGvxrj/al5jpfKVQV5qpTW59xsO6MaMWdAcVTpgbocKIeSaBm1SBZTex+Gu37np65JtMgM2bCVw+JQe1wFWEfbZsqewoaSmwzEhwUET/lVrF+hNhMJd3wxkng3PV9Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=bzfV4vXG; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="bzfV4vXG"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id B779A60426;
	Tue, 16 Jun 2026 22:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1781648795; bh=sl/0M90z0402cVvfzwgGyHidn40O1fbpVZbANRef7v4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bzfV4vXGEp3nZAdiZMME0nnbWlZNLayIRqaSvm8f+o/Vgh5rFcjTKA0KeJDUYZQSc
	 rarQGwyFg99QfQteE5oJsH3Ga8KQ/FyFfAE+U6KjUipXDO/dNwqfMsftRCPkEPrQ0f
	 HQ/KLakmXWygn2h0vne4tTb5abBEfe8xd7h2vMao=
From: Matt Hunter <m@lfurio.us>
To: git@vger.kernel.org
Cc: Bence Ferdinandy <bence@ferdinandy.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/7] doc: explain fetchRemoteHEADWarn advice
Date: Tue, 16 Jun 2026 18:25:16 -0400
Message-ID: <20260616222606.1003521-3-m@lfurio.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616222606.1003521-1-m@lfurio.us>
References: <20260612055947.1499497-1-m@lfurio.us>
 <20260616222606.1003521-1-m@lfurio.us>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the user sets 'remote.<name>.followRemoteHEAD' to
'warn[-if-not-$branch]', git-fetch will report when a fetched HEAD
disagrees with the locally-configured remote's HEAD.  This additional
advice instructs the user how to deal with these warnings, but was
previously undocumented in git-config.

Signed-off-by: Matt Hunter <m@lfurio.us>
---
 Documentation/config/advice.adoc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/config/advice.adoc b/Documentation/config/advice.adoc
index 257db5891817..c3c190ba6a4f 100644
--- a/Documentation/config/advice.adoc
+++ b/Documentation/config/advice.adoc
@@ -48,6 +48,10 @@ all advice messages.
 		to create a local branch after the fact.
 	diverging::
 		Shown when a fast-forward is not possible.
+	fetchRemoteHEADWarn::
+		Shown when linkgit:git-fetch[1] reveals that a remote `HEAD`
+		differs from what is set locally and the user has opted into
+		receiving a warning in this situation.
 	fetchShowForcedUpdates::
 		Shown when linkgit:git-fetch[1] takes a long time
 		to calculate forced updates after ref updates, or to warn
-- 
2.54.0

