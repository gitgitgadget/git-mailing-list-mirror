Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A939C38F25C
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 06:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781244009; cv=none; b=Uojmm0fF5zes3SBZFhTNSvwKpWuHbgBxaXjBQzB7YB6IKonDsHxIUwfc4EEBxIqIBKIB2bCjpw5rjPkOG680mZ9DgbNgbDiFhzM/jptl8k8FcSCJJtMdHh/41oenl5xjcvksYfqCIhFjp0SmdaGnbN8oyNKmsoImn/Dnqg0sbSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781244009; c=relaxed/simple;
	bh=sl/0M90z0402cVvfzwgGyHidn40O1fbpVZbANRef7v4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltNetiDWavPiSN/MKhQNkYRkUwrzhgSi5AMbbsqzzmvVc+iewXb4z3aca3kCcIn9UQV6OIWc9TJTOEr3ZUucdFbYfX0mxrS2B9IcIwqLZTB+mEtrLGQiK13UwQwObWxC/pNJrApwUJMhmlkjhcXaRPTnX5RRrRPg0yo8aFhxBsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=iarH3KKA; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="iarH3KKA"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 41D8860002
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 06:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1781244007; bh=sl/0M90z0402cVvfzwgGyHidn40O1fbpVZbANRef7v4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=iarH3KKArxEBVVB73JgTxNPeoRpcvW+y7jKqSwxgDDBr6eIyiwTvBdBLOx+1up91v
	 kMImiHSUtQmp9xqV0Ik2ezRWRwP/HDiRTQARpWzrl8BzQdAMX43VR0QIU1VYfLqxz9
	 1oLMemYdBXIY1718+kMxD0vRS4dBHs6Rt8iWoZCw=
From: Matt Hunter <m@lfurio.us>
To: git@vger.kernel.org
Subject: [PATCH 2/7] doc: explain fetchRemoteHEADWarn advice
Date: Fri, 12 Jun 2026 01:55:38 -0400
Message-ID: <20260612055947.1499497-3-m@lfurio.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612055947.1499497-1-m@lfurio.us>
References: <DJ19CI50W6UH.17QLIBNTXBWXU@lfurio.us>
 <20260612055947.1499497-1-m@lfurio.us>
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

