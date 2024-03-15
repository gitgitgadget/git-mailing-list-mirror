Received: from mail-gateway-shared03.cyon.net (mail-gateway-shared03.cyon.net [194.126.200.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8653954770
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 19:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710532007; cv=none; b=Otn/6dE0t4q/fVi8B482o9X5k/G+gdwZ7Kvos4ezNq6XGPOfFCMA5ll11LoGK4jte/2IzX3yBpMsOTDzHhwny+cTspkaG3xDCu4YsshOzBaEQ97lBqg4V2fm6KTXHv9CPj972So2dmTCNLjnz/zByMSAoaEegI1Jur6I8SJ+uLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710532007; c=relaxed/simple;
	bh=8A2LM+K1ukjOftczHLsu1O5QkSmZ5eJIh4zRAdWHC4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WLBR/wgIeLd+F9aUSDNlhDE1BAeSgTCDSVVO9JV9qF07zitQY1FasVmtYBwdHy8Ev1P4mV5trKhWzhMb0GSUnJtg5Nq1+H3zGxU2JuRe9irQGCxZ9zcQKS3TA1/O6eKIcnTnegaWwQOJffp6M4ZfVaNb1Z/o2wSjRQvnAnFBar8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared03.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1rlDVk-000000002AR-2ldH
	for git@vger.kernel.org;
	Fri, 15 Mar 2024 20:46:37 +0100
Received: from [10.20.10.233] (port=27324 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1rlDVj-006ajn-1j;
	Fri, 15 Mar 2024 20:46:35 +0100
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id 3C5431800FD;
	Fri, 15 Mar 2024 20:46:34 +0100 (CET)
Received: by minibeat.bolli (sSMTP sendmail emulation); Fri, 15 Mar 2024 20:46:34 +0100
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v2 04/22] t/annotate-tests.sh: avoid redundant use of cat
Date: Fri, 15 Mar 2024 20:46:01 +0100
Message-ID: <20240315194620.10713-5-dev+git@drbeat.li>
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
 t/annotate-tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index 5e21e84f3884..87572459e4b8 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -532,7 +532,7 @@ test_expect_success 'blame -L :funcname with userdiff driver' '
 		"$(cat file.template)" &&
 	test_commit --author "B <B@test.git>" \
 		"change" "$fortran_file" \
-		"$(cat file.template | sed -e s/ChangeMe/IWasChanged/)" &&
+		"$(sed -e s/ChangeMe/IWasChanged/ file.template)" &&
 	check_count -f "$fortran_file" -L:RIGHT A 3 B 1
 '
 
-- 
2.44.0

