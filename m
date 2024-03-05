Received: from mail-gateway-shared15.cyon.net (mail-gateway-shared15.cyon.net [194.126.200.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A77D12A16C
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 21:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709673995; cv=none; b=jNnkR6PLKF/dyxaF4NJAl9judykn1Oegt6DOmGHO5e5+Bqk5sFC31DBab/AW4nsrRnHZ3kCs6bEvHqz8rb3ebXajEjUQp9lCUnanyvb/xnxVPkVNfzEhvorRUmG7ap/xzi3JHU6Y+DAyH+oK/QZl49h10TNgM/ArTG64HtkNI6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709673995; c=relaxed/simple;
	bh=8A2LM+K1ukjOftczHLsu1O5QkSmZ5eJIh4zRAdWHC4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XkEY6gVIMAXUEnrligfOTRvlTenVmmt/LH+Vw84B6toXlaxiAXtB9/mCbIg3HYP8ktxXfsLK5KRKSf1itXXFaABGk3yoxxk1okk/B0ni7aVjPxg/ukxxBU8P66Zg6RRFWK2i/8PAkT0YEYNZiPYGiSvqvzjTU4FPDehQcDXtglc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared15.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1rhcIw-000000002Po-4Bx4
	for git@vger.kernel.org;
	Tue, 05 Mar 2024 22:26:31 +0100
Received: from [10.20.10.230] (port=27380 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1rhcIv-006KaL-2r;
	Tue, 05 Mar 2024 22:26:29 +0100
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id 8C0BF18012F;
	Tue,  5 Mar 2024 22:26:28 +0100 (CET)
Received: by minibeat.bolli (sSMTP sendmail emulation); Tue, 05 Mar 2024 22:26:28 +0100
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 04/22] t/annotate-tests.sh: avoid redundant use of cat
Date: Tue,  5 Mar 2024 22:25:03 +0100
Message-ID: <20240305212533.12947-5-dev+git@drbeat.li>
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

