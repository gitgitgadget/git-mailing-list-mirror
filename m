Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A45545009
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 01:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750729784; cv=none; b=UeGlzpsQqoVIbCqzhjA3Dbc7LftNtFevRKM57c6te7E7Wc4nF8/kge+4lUnbIJB/dRz3pK1Xi3bqwIOUTU66Q8myCEbKIt77QHtdQYIBavtUUjjHhcFTgGpwdGYKoogHYbuwbFE4dErXYMDzhFx4qqY6SrAZdcKi610u4ekOtdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750729784; c=relaxed/simple;
	bh=cGUr/8/10AcaouhAxbfu3dPYUQEHbS0qDpbSEo/2PgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iEahVd+pWkk/meE8WMCO8bToIEpDvDFIZieLxijYplw09qmmA9jKVjefnZYmXAmMRuzVEtAMVMvJx8nXJmtxRDf4sMV7oagXakLaX5Z/TTBWi0Tv4tsTPDaww/lmX3lpvbvmgf1LOOJ/eyMeDQG83ym9g88quUdi5kYuvWjG7Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guixotic.coop; spf=pass smtp.mailfrom=guixotic.coop; dkim=pass (2048-bit key) header.d=guixotic.coop header.i=@guixotic.coop header.b=PoNycTsR; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guixotic.coop
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=guixotic.coop
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=guixotic.coop header.i=@guixotic.coop header.b="PoNycTsR"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <maxim@guixotic.coop>)
	id 1uTsmw-009c4N-TK
	for git@vger.kernel.org; Tue, 24 Jun 2025 03:49:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=guixotic.coop; s=selector1; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From;
	bh=/NdAykJRuU7hlfgGfdombUfg1+13XohmOXmQ/M0hSqs=; b=PoNycTsRsT6ekf4egKDEMfQzyn
	QJvCvKJTCjF+2nTm3nENKEWJK4BOs26eijJMy/bndcPksZKNc6Jzkrb9RWvhLzti6TPs9TXMC71Gn
	pKWVoItR8Le9MxcBzY8Fh/5CNUXNjn3GqN6bEEBlH6sVJ6okWDAVU8w/GLW8FJSs3UuehKjFj+BzC
	uVNfuIWdR75aMZ8eFf7Ec/2ur1idKpdXVrnZoRI8q2+FV1y/kiyHXDcrJiliWvxMH8OBUfriJFAxs
	MsmcjpYemN4jWO+waH0Ge8L+3CE9nqSlswovxU1X34JfB98/Ok0kOYXOZjRgddtney4qslGNhUk07
	M272UoDw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <maxim@guixotic.coop>)
	id 1uTsmw-0007eR-IT
	for git@vger.kernel.org; Tue, 24 Jun 2025 03:49:30 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1476852)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uTsmn-00DjBm-Qh; Tue, 24 Jun 2025 03:49:22 +0200
From: Maxim Cournoyer <maxim@guixotic.coop>
To: git@vger.kernel.org
Cc: Maxim Cournoyer <maxim@guixotic.coop>
Subject: [PATCH v3 1/3] contrib: use a more portable shebang for git-credential-netrc
Date: Tue, 24 Jun 2025 10:48:55 +0900
Message-ID: <20250624014857.3748-2-maxim@guixotic.coop>
X-Mailer: git-send-email 2.50.0.84.g5fc0c030e3
In-Reply-To: <20250620041239.27839-1-maxim@guixotic.coop>
References: <20250620041239.27839-1-maxim@guixotic.coop>
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

