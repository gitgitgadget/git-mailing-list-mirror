Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAD93672BE
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 09:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781862514; cv=none; b=HpFoePGApDKXRmJvTE/d/gm/J7ZZl59DSAlCjU+1nT04mImFoT2YS9cwWbEgIDuTzpPaBrlP9xQwhpUwgD+8ThSjcoGwvRY8z77RrliUkxwQNPPVDPPRXKmyW55qPIW8wSIS9L9b3rExp8RnurWedS9hyWKctVB3SQGjpieAedw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781862514; c=relaxed/simple;
	bh=sl/0M90z0402cVvfzwgGyHidn40O1fbpVZbANRef7v4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDiDdeLHnPfIqNwk0G6dWpC+6VdQqvIzO6c3RZz4aEeLJ6VqrHIgyeWHSLmUjMXeapg9cyCRivtKm6J/3CcBIzKK7dQsibP1m2qGUgTNe4S6laLQ8SUGXtN31zCKtWmGio0nRiS04yGjMYSOJFuLITaaMunuoFU2rq66LF7p1to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=jqA1Q88h; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="jqA1Q88h"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 00CD36051B;
	Fri, 19 Jun 2026 09:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1781862503; bh=sl/0M90z0402cVvfzwgGyHidn40O1fbpVZbANRef7v4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jqA1Q88hR6B/F5SXAjy+b4n3uRo87gvEYzu0uyp5TwS7vReT8hZGDG49+OU1rrqD3
	 NdhccANLqHq5xTISOVMZYVl67/DCg4k3nLHmOxe//CRTzf/TOXrFcJtlrq8yKRhqsc
	 4hIDFwUKa4W7fjaar/r0mD07n/L4vmHl/p11T93o=
From: Matt Hunter <m@lfurio.us>
To: git@vger.kernel.org
Cc: Bence Ferdinandy <bence@ferdinandy.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/8] doc: explain fetchRemoteHEADWarn advice
Date: Fri, 19 Jun 2026 05:44:21 -0400
Message-ID: <20260619094751.2996804-3-m@lfurio.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619094751.2996804-1-m@lfurio.us>
References: <20260612055947.1499497-1-m@lfurio.us>
 <20260619094751.2996804-1-m@lfurio.us>
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

