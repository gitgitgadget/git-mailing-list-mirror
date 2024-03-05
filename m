Received: from mail-gateway-shared15.cyon.net (mail-gateway-shared15.cyon.net [194.126.200.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDD112D752
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 21:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709674003; cv=none; b=UrOccLCrQssMwYPkwr4GQxyglxi1+NSF+6gkJBU3AEQQ1eTPNYSq/F0uSjz1/RdwLBodmaIpqNeB9rJqHIDGlaubHFm5rR8VibxrJMh4s7QOD7oq9+gj+Uyo2UCgcpYsNOfC+r4BstpqMFZfaNIN6gQYc1dIbAa821YTvyZjIv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709674003; c=relaxed/simple;
	bh=Cz0k7VFrUIr836cBw/gMXsVPyXzyHJYg/Jhb43e0LbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A2bUfrY1YrffUhbhLv9dNo+uCvwZoqA54ZkZEDalVLYr8X4CvOQN4AX2Nz/AAJ/t3gUaQtCbL+/I/WH1DVOS2L7KDxiSeugGyNgDcehMZkJFPNG+7DvKoDqrcAfg4tiQmFToy6veMWbyu3HjE2azSV/hQTkDYRFseOfa5ztNP3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared15.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1rhcJ5-000000002SC-2vn8
	for git@vger.kernel.org;
	Tue, 05 Mar 2024 22:26:40 +0100
Received: from [10.20.10.233] (port=52638 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1rhcJ4-006KeR-1u;
	Tue, 05 Mar 2024 22:26:38 +0100
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id 4265918012F;
	Tue,  5 Mar 2024 22:26:37 +0100 (CET)
Received: by minibeat.bolli (sSMTP sendmail emulation); Tue, 05 Mar 2024 22:26:37 +0100
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 12/22] t/t7*: avoid redundant use of cat
Date: Tue,  5 Mar 2024 22:25:11 +0100
Message-ID: <20240305212533.12947-13-dev+git@drbeat.li>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240305212533.12947-1-dev+git@drbeat.li>
References: <20240305212533.12947-1-dev+git@drbeat.li>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 t/t7704-repack-cruft.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
index be3735dff083..71e1ef3a103e 100755
--- a/t/t7704-repack-cruft.sh
+++ b/t/t7704-repack-cruft.sh
@@ -48,7 +48,7 @@ test_expect_success '--expire-to stores pruned objects (now)' '
 		# ...in other words, the combined contents of this
 		# repository and expired.git should be the same as the
 		# set of objects we started with.
-		cat expired.objects remaining.objects | sort >actual &&
+		sort expired.objects remaining.objects >actual &&
 		test_cmp expect actual &&
 
 		# The "moved" objects (i.e., those in expired.git)
-- 
2.44.0

