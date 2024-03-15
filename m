Received: from mail-gateway-shared03.cyon.net (mail-gateway-shared03.cyon.net [194.126.200.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B896B55C04
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 19:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710532010; cv=none; b=ABGENvOwEiiZnbq8V74xmqp3+UjEAtPZ5W5ywwcPks+hsRDuG0SZd6TBOP5EUE6rbt401akzWNOGxz0bPJ4AV7sMfpBlYB5KYqRH3qvz3+6VmPcuJhqqWbyHKaxKSWW1iOxX3x6YZyqa7m49kh3lyw/boRtlaN+EZ4gAgJgeIJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710532010; c=relaxed/simple;
	bh=Cz0k7VFrUIr836cBw/gMXsVPyXzyHJYg/Jhb43e0LbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YbBGF2tICxr8+UJDy4jqNYjgkY+ILUjjufItoxV8Ig9rRMXn5eSJpmzKmzHfMhUM5lWTQ3EbiphjLW8pbDFNkW+3+Xw5kjc2DXOamuUk4NdvqyhD66RSMh69nMxPOmBWgs1LECKg5vn6+L9vC7RX0kAIcLbmKx8rCPN3JUakXrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared03.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1rlDVt-000000002DI-1fmM
	for git@vger.kernel.org;
	Fri, 15 Mar 2024 20:46:45 +0100
Received: from [10.20.10.230] (port=59878 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1rlDVs-006anT-0x;
	Fri, 15 Mar 2024 20:46:44 +0100
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id F09601800FD;
	Fri, 15 Mar 2024 20:46:42 +0100 (CET)
Received: by minibeat.bolli (sSMTP sendmail emulation); Fri, 15 Mar 2024 20:46:42 +0100
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v2 12/22] t/t7*: avoid redundant use of cat
Date: Fri, 15 Mar 2024 20:46:09 +0100
Message-ID: <20240315194620.10713-13-dev+git@drbeat.li>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240315194620.10713-1-dev+git@drbeat.li>
References: <20240305212533.12947-1-dev+git@drbeat.li>
 <20240315194620.10713-1-dev+git@drbeat.li>
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

