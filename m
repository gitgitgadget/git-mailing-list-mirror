Received: from pio-pvt-msa3.bahnhof.se (pio-pvt-msa3.bahnhof.se [79.136.2.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88B73090E8
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 21:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.136.2.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771451931; cv=none; b=BWXLBly6m+K4drYYMjyDt9UOPz9IUPPI+kVuRj5DV5t/jawrnKUFKGQ9Ph49koHARRXGjLriU2k2cezVTOlzUPnRcTZxbJpf1Ckp3mcYPtPrlhuYGqt9FvMWA7OQx/Tb9NIgWogivQwPFUcMKTB+QjdvEoo6mFGhieW1g+KddLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771451931; c=relaxed/simple;
	bh=AbBmZ/9g104rVx+4BeCFsHCE7ev4GVgYqNW7dbp5Fus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TTLKLDFwZiBYmDGKhZV62gKrq2nLQElbV7vJt2GnUI4+cZZycOr790DmlVyEwtmexT/ZLvjL8Wy1NCusl3+Cvre+6IC4IEXm/s/S5yaN5Px5C2o/hzGtBL/R+WnMcTIzOYz/HvZgsS26q5R9uILNCj+Qgh6eXvJIOHkpvz3XthY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=DclK7E8g; arc=none smtp.client-ip=79.136.2.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="DclK7E8g"
Received: from localhost (localhost [127.0.0.1])
	by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 2B2294374D;
	Wed, 18 Feb 2026 22:58:42 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Authentication-Results: pio-pvt-msa3.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
	by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B0Q-T7crLQWP; Wed, 18 Feb 2026 22:58:41 +0100 (CET)
Received: 
	by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id EAEAF4374C;
	Wed, 18 Feb 2026 22:58:40 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1C02BB20A7;
	Wed, 18 Feb 2026 22:57:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1771451851; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kark3eAI14OatsGM/eB7sEP3/FEjweU0yLfsUQUn7Qw=;
	b=DclK7E8g6p8Q+1/VRqqZt5I6P7EYzqpVpJIGKh0EtQsCUgRn2KUJ87Y9ntKVf+DOwNxDXJ
	7HyfnLmtkjEA0EjCPXkD1i8E94AB/EEKvzH4XSyV2BqzSPPgem9H8k67SlY/e0CmZYstiB
	U+L7dueUVnHBDbrwNtOgqJ0AlYiRu15mDoa8DTXf43KQAFnf6SBGvEkAd6HagqsRYpBQQz
	ps8rDZi3cJ3cPw6+FhC3sPCP2290A4fCYsXjLtnzZ8QllUh1a5JPa9NzVG04XxBt6h1k9c
	TD9ouHJL+3oQGkB0dn7c4MGB++va/c1qK6eDfRcDmYnJp5R+iYYzZWOmk35ARA==
From: Jonatan Holmgren <jonatan@jontes.page>
To: git@vger.kernel.org
Cc: peff@peff.net,
	gitster@pobox.com,
	"D . Ben Knoble" <benknoble@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jonatan Holmgren <jonatan@jontes.page>
Subject: [PATCH v7 0/4] support UTF-8 in alias names
Date: Wed, 18 Feb 2026 22:57:33 +0100
Message-ID: <20260218215737.1181147-1-jonatan@jontes.page>
X-Mailer: git-send-email 2.53.0.122.g3abf75d576
In-Reply-To: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi all!

This series adds support for non-alphanumeric (including UTF-8)
characters in alias names by allowing aliases to be defined using
git-config's subsection syntax.

Changes since v6:
Reverted the --aliases-for-completion output format to
use a newline as the field separator between name and value within
each NUL-terminated record (name\nvalue\0). In v6 I changed this
to use NUL for both separators, but this diverges from the
convention established by git config -z, which outputs
key\nvalue\0. Matching that convention is the right call here.

Thanks!

Jonatan Holmgren (4):
  help: use list_aliases() for alias listing
  alias: prepare for subsection aliases
  alias: support non-alphanumeric names via subsection syntax
  completion: fix zsh alias listing for subsection aliases

 Documentation/config/alias.adoc       | 50 ++++++++++++++++---
 alias.c                               | 42 +++++++++++++---
 builtin/help.c                        | 13 +++++
 contrib/completion/git-completion.zsh |  2 +-
 help.c                                | 39 +++++++--------
 t/t0014-alias.sh                      | 71 +++++++++++++++++++++++++++
 6 files changed, 182 insertions(+), 35 deletions(-)

-- 
2.53.0.122.g3abf75d576

