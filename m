Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB16F30FF10
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 14:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.80.101.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771426370; cv=none; b=aNIqOQ8fyoHy9K0cRQv4BG+ufrdfPpW7KGlR9JOuimm7VDcx/P5QzXro2p9Y1uH0WuUQCGNFb6ej/fjLSjhp9y+uyoBNxGcPjB07rbG4S+Ma4kt6OJJJV431B/ZeWE2NCc+fgQ5jChldhHvjMAETP1Yjnvqbwbl6d1yC020Omd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771426370; c=relaxed/simple;
	bh=Xgfj0fkEsfH4zIJKEa9OXE1IM+YKp1e6nIMR9wsz9V4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2CltbRH7cMbBencaTxTx9iNwKgYRi8IJk5n6agmXB3yRY4RGz1g0s3WO69L6Vcf8cFqBz8zeTiAEkKHFfwJFRnOV3IQAziH1XmLqulEZdB2fgXgaHR20pRJ2aHv00oPeolIflnWP3jIIflMT2MnexovCEgbD/uSqr7ji/w2d/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=RPZ2yAUr; arc=none smtp.client-ip=213.80.101.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="RPZ2yAUr"
Received: from localhost (localhost [127.0.0.1])
	by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 31A303F839;
	Wed, 18 Feb 2026 15:52:40 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Authentication-Results: ste-pvt-msa1.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
	by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j9xgq_Bsd9uH; Wed, 18 Feb 2026 15:52:39 +0100 (CET)
Received: 
	by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 10B1E3F380;
	Wed, 18 Feb 2026 15:52:38 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EE49DB1E70;
	Wed, 18 Feb 2026 15:51:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1771426289; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vBM1B+SxK8U1ZFKNnOtzYeAN/p9UeRBNxLCcTOUUx5E=;
	b=RPZ2yAUrWxdk+NUZZ7AgW0aPuVZoF6uA2p6kdVvR1FmEzKSmASBVJLBSijGKwHZqkdN+l9
	MH1Q7AvEil2AB7N0gkIMr2fhmG4U1iZzxmn3YTkB9SSnvi9GttWhdw1bvUf6iJlfsiSXRq
	/keYQ9Wwze3Um/pqKJDBpGGR3fSJZBH8diHFkPm9A9nVcvpEktzgv8Dzjz13CkWWelWqzN
	PYsuBRhFMKmNLcFSWdExAiZTnYlQ425qAOLtT7livM3OA85/NSVs+L5DeT5t9juQYw6rsx
	3RPIVFH8o3VE7POZPdWM4LyNTWzepVmRKHgw9DEv1xYTsL5VWGozOh1/7GKZ+w==
From: Jonatan Holmgren <jonatan@jontes.page>
To: git@vger.kernel.org
Cc: peff@peff.net,
	gitster@pobox.com,
	"D . Ben Knoble" <benknoble@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jonatan Holmgren <jonatan@jontes.page>
Subject: [PATCH v6 0/4] support UTF-8 in alias names
Date: Wed, 18 Feb 2026 15:52:10 +0100
Message-ID: <20260218145214.581460-1-jonatan@jontes.page>
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

This series enables UTF-8 and special characters in Git alias names
by using config subsection syntax: [alias "name"] command = value.

I have since last time:
- Unwrapped opt_mode_usage() call in builtin/help.c for consistency
- Removed string_list_sort() to preserve config order as suggested by Ben
- Added missing Signed-off-by trailer to patch 4 (oops)
- Fixed --aliases-for-completion output format to use NUL
  seperators instead of newlines (as per my own commit message and intention)

Thanks again.

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
2.53.0.122.g591c997fb5.dirty

