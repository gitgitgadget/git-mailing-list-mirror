Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521143624A8
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 20:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.80.101.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772139253; cv=none; b=kjhJec+sjrJE9mv7NlhGBsSfP5xyOu0BbgpqTK5+SzGhVKjPi5EeMl8l1rspZ9+G5xnRhBKxq9eiXZtvfgtwdyMLz9CboQCTGQiOxT48+zl5w6XBJfUMlY/T+bHJbqX1Nhr6iNpta3bNUAbvGT17s+ofn4IPIzz7G7yzGr/m6EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772139253; c=relaxed/simple;
	bh=5EndbWBh0T8Zodnqz6fUdphuP5k6PH/HCAogF/PW+oI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QeP6wFXe0lZIdfjRGzGBu8QLy71W8HC5wOoF0vUlOi30Z/hcyy+3/O3rqZu7J8YMWHWYg2JCzMtR/Ltxs93ltY4OWRvoDRKD+ZXPd5AvDnAqxUW0jvn3TKOtA3DeEFTOW7fdUItV9jW0xiNuNTS/MB1QXfJbnodkx/wumO08w7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=QLVIOyCU; arc=none smtp.client-ip=213.80.101.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="QLVIOyCU"
Received: from localhost (localhost [127.0.0.1])
	by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 4A8683F7EC;
	Thu, 26 Feb 2026 21:54:02 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Authentication-Results: ste-pvt-msa1.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
	by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5BWRgQ2uTaiW; Thu, 26 Feb 2026 21:54:01 +0100 (CET)
Received: 
	by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id D5A403F3EF;
	Thu, 26 Feb 2026 21:54:00 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 40C3AB2332;
	Thu, 26 Feb 2026 21:52:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1772139159; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=8DRqYSr5zcYUtZSrC/CPy6YL7tgYyiidrUpQuLPs53Y=;
	b=QLVIOyCU67QdHhIpUVkqHmXQgTOmUkODkMtI3vxoAyZ1iy9VLM3AjpIjFbVyudz3qxOJxf
	Nm+Lqe5c+cb6HwTgP4bnU8wVqofdtroZma/ijXwjHszIKpUFJBUFYUFQaR3kb9A0zxN2Pv
	MxOd8yFHVy6wAmj+s7wCiM4O+0EZph+22gisZdTz4gksL0Bgo3N+dJ87qkLBy4QERgnwW4
	zChpcabOGEFVP05um58uNG/5mB0Fj7O5WWgrhfdsQpWL/wjez2UUGuOoibh9xHdrGO1QU1
	GOHTppKQ9k4Pz39HDlgLarcRrgzQ68SKXxLqqScjxvjAR1cUjbbiVQC4Fde6mw==
From: Jonatan Holmgren <jonatan@jontes.page>
To: git@vger.kernel.org
Cc: peff@peff.net,
	gitster@pobox.com,
	"D . Ben Knoble" <benknoble@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jonatan Holmgren <jonatan@jontes.page>
Subject: [PATCH v2 0/3] Fix small issues in alias subsection handling
Date: Thu, 26 Feb 2026 21:53:25 +0100
Message-ID: <20260226205339.1535482-1-jonatan@jontes.page>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

v2: Add patch 3 to fix memory leaks in alias listing reported by
    Jacob Keller.  The leaks were introduced by the jh/alias-i18n
    series (specifically "help: use list_aliases() for alias listing"):
    list_aliases() allocates util pointers but two callers cleared
    the list without freeing them.

    Also fix a stray trailing whitespace in patch 1.

    No changes in patch 2.

Jonatan Holmgren (3):
  doc: fix list continuation in alias subsection example
  alias: treat empty subsection [alias ""] as plain [alias]
  git, help: fix memory leaks in alias listing

 Documentation/config/alias.adoc |  7 ++++---
 alias.c                         |  4 ++++
 git.c                           |  2 +-
 help.c                          |  2 +-
 t/t0014-alias.sh                | 14 ++++++++++++++
 5 files changed, 24 insertions(+), 5 deletions(-)

-- 
2.53.0

