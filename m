Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F04264618
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 14:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750861571; cv=none; b=plnynYWmg389kKR1XVXpT8JAxXjc9oelJfPhzAAn38WL1b2D+Tcg+q/eZR12siSif/xSQbXD0uc8TEkeS+FBBkbYHPM9PMHY2uydsDAKfGy1EZpkgLUKYMoOlStgCCPzDPnNzKwDlVn2cucT/65+FM5lbGqxTgNiDPJlRVNK9/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750861571; c=relaxed/simple;
	bh=cGUr/8/10AcaouhAxbfu3dPYUQEHbS0qDpbSEo/2PgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rq0+82mGt8l2/S0CQNqP9yMxOOOx4b7/QhBgDT8ChGbvz4BopzHn4wCNLbawVCJvzE7H3epQYavuIQrnCVq0X/Uz0VbPn/kmFlDH4vIWbyios21jJkbNF6+EP6Z0VTuHCjxHcZbYOxwlrVKqj+fOttezdxrLYV8u/6qc8W4/Jws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guixotic.coop; spf=pass smtp.mailfrom=guixotic.coop; dkim=pass (2048-bit key) header.d=guixotic.coop header.i=@guixotic.coop header.b=lSH+TB/T; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guixotic.coop
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=guixotic.coop
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=guixotic.coop header.i=@guixotic.coop header.b="lSH+TB/T"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <maxim@guixotic.coop>)
	id 1uUR4h-00EOyc-QY
	for git@vger.kernel.org; Wed, 25 Jun 2025 16:26:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=guixotic.coop; s=selector1; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From;
	bh=/NdAykJRuU7hlfgGfdombUfg1+13XohmOXmQ/M0hSqs=; b=lSH+TB/TcsVssZtQ1JnPJlhzDh
	x0ofKFTEAHAe53A49fArheCCTvKu1yCzY5KT/c+L7pAmcrlUO/3cuODm25siWNUHORbeNMpEY/yZo
	Hv6nx9PUpjpt0pMyklMBv9r0cYCiAQN5aiiS70ThfpFPy0eCMucvg7Zv+5jJY8OcWZu1+Ijqdkvej
	9KQy+Voy5ROioQzYhvdrbHW4L8qAYW6u1jcmeuuayQUMSfWj/+auPSybInVmQOU7kM9BS2zo3eiXX
	fXeq/ZMz0fG7JjZCxMsv9Os3MhHMrReE6SZaZ9+4mfb85U1EfjjIBexODa5ySOZEP8QqKsq/msC3r
	+50RPlwA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <maxim@guixotic.coop>)
	id 1uUR4h-0008N6-9Z
	for git@vger.kernel.org; Wed, 25 Jun 2025 16:26:07 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1476852)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uUR4J-00317J-3d; Wed, 25 Jun 2025 16:25:43 +0200
From: Maxim Cournoyer <maxim@guixotic.coop>
To: git@vger.kernel.org
Cc: Maxim Cournoyer <maxim@guixotic.coop>
Subject: [PATCH v4 1/3] contrib: use a more portable shebang for git-credential-netrc
Date: Wed, 25 Jun 2025 23:25:09 +0900
Message-ID: <20250625142511.28857-2-maxim@guixotic.coop>
X-Mailer: git-send-email 2.50.0.84.g5fc0c030e3
In-Reply-To: <20250625142511.28857-1-maxim@guixotic.coop>
References: <87ecv8k4y9.fsf@terra.mail-host-address-is-not-set>
 <20250625142511.28857-1-maxim@guixotic.coop>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While the installed scripts have their Perl shebang set to PERL_PATH,
it is nevertheless useful to be able to run the uninstalled script for
manual tests while developing. This change makes the shebang more
portable by having the perl command looked from PATH instead of from a
fixed location.

Signed-off-by: Maxim Cournoyer <maxim@guixotic.coop>
---
 contrib/credential/netrc/git-credential-netrc.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/credential/netrc/git-credential-netrc.perl b/contrib/credential/netrc/git-credential-netrc.perl
index 9fb998ae09..514f68d00b 100755
--- a/contrib/credential/netrc/git-credential-netrc.perl
+++ b/contrib/credential/netrc/git-credential-netrc.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 
 use strict;
 use warnings;
-- 
2.49.0

