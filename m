Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7007218821
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 16:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.80.101.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771258544; cv=none; b=E7uoe0FaxqXihqTcyIX2jaBrTONRXLy90235uluupBPgb+gWbPYMfHIAGf7RLjZWSc2+q5c2IACyGX5kD6OwzoFZ5kr/kEyUohxmODfx0DppqkQCpj+JjhLNggLplq1+mlo3O9j1Yw5QH3QoLobd/fHodmw8Wb0j4CHPBTFBZ8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771258544; c=relaxed/simple;
	bh=GGKjtoeHMX/0RGYdx1UlwXxIhsADRy7Ys27ywns+vK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DtjfZUBs2KbVAKB/ABB4W654awwi6ALkJuVGM+GYJ+aar70vN3/fQE9SQMaq7v0og3eupkI6IYOYoYqRIsjHAixNql27yrxwbf7EwX5xN88ATof7hT8MPkw1odS7OayhtT+XPLXow/wLXZqbXsnLU/RsXBt71e6AtmpVrxxfkYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=hXcKzE1F; arc=none smtp.client-ip=213.80.101.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="hXcKzE1F"
Received: from localhost (localhost [127.0.0.1])
	by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 37D6A3F526;
	Mon, 16 Feb 2026 17:15:35 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Authentication-Results: ste-pvt-msa1.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
	by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zfDBw5WkIRV2; Mon, 16 Feb 2026 17:15:34 +0100 (CET)
Received: 
	by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 0E7493F380;
	Mon, 16 Feb 2026 17:15:33 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AA951B1D7A;
	Mon, 16 Feb 2026 17:14:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1771258467; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=E/8yoPnAVsTQagGnLTrp3zcNTmVg523dAGSNeJxRddA=;
	b=hXcKzE1FMjxoucQpcQEU5G3zrygBOuO9n+4KNCkYXyCPb52Kq87L8wwG9IqvTvDSKOVdaF
	HUa4KRmv65WS7vxsiWHqQSp03hgrATRn3kjrj0Uqv9tMppoeKUkKFw+17eVjhGs8d/ptza
	CZXNWqd6K1N8bMjA6JWbF2mVseKruO1Pwob70MLl5ANlMXBC9kZnqPI/JKE6rg/ZMZHsAd
	8lccIhyN6d9RBrsakpT0fu3MxAXckmFciMZae8eeTYVkcNz/1wXVRdIyiTZ5P8yYoZuXLs
	xnt1oWlCbEkqZsiCbKsG7MV9/wV3rXUxcBvapIwp2uBVhc4jicraQ7f2yS9o6g==
From: Jonatan Holmgren <jonatan@jontes.page>
To: git@vger.kernel.org
Cc: peff@peff.net,
	gitster@pobox.com,
	"D . Ben Knoble" <benknoble@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jonatan Holmgren <jonatan@jontes.page>
Subject: [PATCH v5 0/4] support uTF-8 in alias names
Date: Mon, 16 Feb 2026 17:15:09 +0100
Message-ID: <20260216161513.2533141-1-jonatan@jontes.page>
X-Mailer: git-send-email 2.53.0.83.g660bbd62ee.dirty
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

Heya!

This series enables UTF-8 and special characters in Git alias names
by using config subsection syntax: [alias "name"] command = value.

I have since last time:
* Changed "native speakers" to "languages outside English range" (thanks Richard!)
* Fixed shell completion in zsh
* Improved docs slightly with feedback from Junio. Also changed out one of the examples with one with spaces to demonstrate that feature.

Thanks for your time.

Jonatan Holmgren (4):
  help: use list_aliases() for alias listing
  alias: prepare for subsection aliases
  alias: support non-alphanumeric names via subsection syntax
  completion: fix zsh alias listing for subsection aliases

 Documentation/config/alias.adoc       | 50 ++++++++++++++++---
 alias.c                               | 42 +++++++++++++---
 builtin/help.c                        | 15 ++++++
 contrib/completion/git-completion.zsh |  2 +-
 help.c                                | 39 +++++++--------
 t/t0014-alias.sh                      | 71 +++++++++++++++++++++++++++
 6 files changed, 184 insertions(+), 35 deletions(-)

-- 
2.53.0.83.g660bbd62ee.dirty

