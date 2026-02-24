Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9833A9621
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 17:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.80.101.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771953216; cv=none; b=AFGL7HKNWAouSse9X4H4h086JtQfEit6iw5F1xRNcnIW/cvEfOo3m/ErxvqXturkeCMC+2jSjmSuJLo1b9MwWj8BhhMJy+essw/+vXv0iAkqOWmiAlBLAxd+1q+0zg9SH2OduwJSSJbOvMA4qAasIcX487zmj4lo+NEAOeWSaq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771953216; c=relaxed/simple;
	bh=oGbJfmXfjoUgKubKdW7lTUdq21sVVq25i3VxBQ+TKAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sfz9gbtny8Md/i75lm5IvcS87snXbqc+EgbUTPtTy0aiz6l3YK6Di3UJxIVkwf2HUAVwtvKae05oOidSkR3PFRCtpFL7F+K5x3/aI7TdrNfjh1LF1CN4AQ54Nr2NA+DQieMJaToDlpKIAXLsxy9vw2bV694aLfw2aup15MHIiEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=ZCAI7lP2; arc=none smtp.client-ip=213.80.101.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="ZCAI7lP2"
Received: from localhost (localhost [127.0.0.1])
	by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 8A9F440D81;
	Tue, 24 Feb 2026 18:13:27 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Authentication-Results: ste-pvt-msa1.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
	by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1ylytVMXpFHx; Tue, 24 Feb 2026 18:13:26 +0100 (CET)
Received: 
	by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 897EB40D78;
	Tue, 24 Feb 2026 18:13:24 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3D4B6B2079;
	Tue, 24 Feb 2026 18:12:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1771953125; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=MmNtVXywgiYxdq4eTJ/dc5LpfIziV1e4bZSoj12fywk=;
	b=ZCAI7lP2V3YjNFRyPvZ4I0rT/HHB/cYHehGCgyyi84LGErY6vq5V5Tyuh/Hgc1iyTsxK6r
	ldk9AeFGZ4oKXAAEIFjmIu6Wy3Z52XW9w0f8+4YiNYrqrumsA0d4IvwUyDLAmqWoUHCfDB
	3otVKGBqBKbCrIzSvlSMVcG90ggXh2OYuMEMHqP7CS6TSbJIKzJgkSI9WdF95w6aLY0lTN
	TnpW8Clb7VXlxrkWfwDCnxAmWJ5uIpFZzsf5mmZlXo4YNBAMyQW0To41qcJpzLt6LbhAP1
	s4RbtMJ/OW2aj3JlSHnj8OpFlYkpjTywHx2chXr4kjfkBDnhI1YNRoEBibPCPQ==
From: Jonatan Holmgren <jonatan@jontes.page>
To: git@vger.kernel.org
Cc: peff@peff.net,
	gitster@pobox.com,
	"D . Ben Knoble" <benknoble@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jonatan Holmgren <jonatan@jontes.page>
Subject: [PATCH 0/2] Fix small issues in alias subsection handling
Date: Tue, 24 Feb 2026 18:12:34 +0100
Message-ID: <20260224171245.458377-1-jonatan@jontes.page>
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

Hello!

I have two small patches related to the handling of alias subsections. 
The first one is a documentation fix for the example showing the equivalence
between alias.last and alias.last.command, which was missing list continuation marks. 
The second patch addresses a compatibility issue where an empty subsection ([alias ""])
was not treated as a plain [alias], 
causing existing entries stored this way to be ignored.

Thanks for considering these patches!

Jonatan Holmgren (2):
  doc: fix list continuation in alias subsection example
  alias: treat empty subsection [alias ""] as plain [alias]

 Documentation/config/alias.adoc |  7 ++++---
 alias.c                         |  4 ++++
 t/t0014-alias.sh                | 14 ++++++++++++++
 3 files changed, 22 insertions(+), 3 deletions(-)

-- 
2.53.0

