Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A3D34DCE0
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 21:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.80.101.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770844730; cv=none; b=mmntBz6X5TuutynQhXdPMvnPLTXtSmesc2YqcQEUy8RpcAG8lfWQS8RuqFqkksDtNCZsOUsdvtqgrXiKpVc3jxcm5J8mKwR78LyzHsN2EmcqcEYHoMS0PjqZ1c4uwmbgerQ0hvJ+8uwdpEE45sJR9tXBZj9qLRi2miWcit2yrGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770844730; c=relaxed/simple;
	bh=0jcEt2iEFTcbwNHZ5aPhpBy/xb3Vt8p17H20vXpoYdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DjdQ08XVqgY2QKIqgn49aAKH7CgITsDXiQ21G4hUjn3BHuROFebK9xLKNks05zhxx7IgpcCvql5wqfQZ6ndnWAc71jUbMnKcrARyfmy2U1c3PIZj1WxkSZs/bxV6lHtkL6HshaMFjPTFoSuCByW0IfcI0pZOUjtXqIifzQ4BTns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=Nn+XXf/E; arc=none smtp.client-ip=213.80.101.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="Nn+XXf/E"
Received: from localhost (localhost [127.0.0.1])
	by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 3D8E04097C;
	Wed, 11 Feb 2026 22:18:40 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Authentication-Results: ste-pvt-msa1.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
	by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OeGmQ5Qsi2n2; Wed, 11 Feb 2026 22:18:39 +0100 (CET)
Received: 
	by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 753B53F66B;
	Wed, 11 Feb 2026 22:18:38 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D0F2EB1E34;
	Wed, 11 Feb 2026 22:17:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1770844659; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=sUImrHqEY+aSK/0Sti9LHRdkDzvQR13YgdCa9arJIrI=;
	b=Nn+XXf/E4h4+ldv8u8NdPHsUEgCgmEAUIpNsa640ZXrRBHG/7DRyHt09OJHRchS41c7rVd
	76Iuh0Iziu99+UQYE984su68n3Fkcpk9LNdVV0f0+8Nxdua9cHHDqMPCsp0uaZlsc9M1FC
	OkXa3bTr3HXCbrd1z7xw2PdwXkOj0Yd6fyTDuKuK9M9sxl+AyCOwEKyqFcfX0WY5S5G9U4
	ZMYidozgV+4vR+rvVlWpqPL/vG5gkr37jJkM+xfbf6TjGIZucvluoi8u5cxi8cYWkIPkE7
	Ag5wLbkIby5mUa1Z/Qb6BSQvmCkiUP3lRb7bL4t5Bs9vIiHjFZ1UKQ6QzoeQLw==
From: Jonatan Holmgren <jonatan@jontes.page>
To: git@vger.kernel.org
Cc: peff@peff.net,
	gitster@pobox.com,
	"D . Ben Knoble" <benknoble@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jonatan Holmgren <jonatan@jontes.page>
Subject: [PATCH v4 0/3] support UTF-8 in alias names
Date: Wed, 11 Feb 2026 22:18:07 +0100
Message-ID: <20260211211810.278806-1-jonatan@jontes.page>
X-Mailer: git-send-email 2.53.0
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

This series enables UTF-8 and special characters in Git alias names by
using config subsection syntax: `[alias "name"] command = value`. This
allows non-English speakers to create aliases in their native languages
while maintaining backward compatibility with the traditional syntax.

Changes since v3:

- Removed redundant !value check in data->alias branch, as Junio noted
  that git_config_string() already handles this case

- Added config_error_nonbool() in data->list branch so misconfigured
  aliases (without values) are caught immediately instead of silently
  adding broken entries that callers must handle

- Simplified code: consolidated error checking, removed conditional
  item->util assignment in favor of early error return

- Added test case for value-less alias error handling

- Improved test robustness by using intermediate file + test_grep
  instead of piping to grep

Jonatan Holmgren (3):
  help: use list_aliases() for alias listing
  alias: prepare for subsection aliases
  alias: support non-alphanumeric names via subsection syntax

 Documentation/config/alias.adoc | 43 ++++++++++++++++----
 alias.c                         | 38 ++++++++++++++++--
 help.c                          | 39 +++++++++---------
 t/t0014-alias.sh                | 71 +++++++++++++++++++++++++++++++++
 4 files changed, 159 insertions(+), 32 deletions(-)

-- 
2.53.0

