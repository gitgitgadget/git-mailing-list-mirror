Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D41228BABE
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 20:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755722279; cv=none; b=XTNAjdpqDwq214lHxd14qVbabQvbm77+GDstzaNwaBIJ8ETNp0wOqZ/J9f263/C51sfn6lr+baf9EAkXBEusC9uA8HguTiWo3nB21W2HYnSAAjd+MqVRuCkUdmsFjsZtDpaVCql7dZH1h1o/dtdb6aYMyeVU2DXfojOR0V1HpvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755722279; c=relaxed/simple;
	bh=dvJFe2ptej2dlG4+iyu/c8gGlY4eLJidcxROQ2cl/qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hIa2XPb9tte5VVil1CNtRnbNTy5MyR+WrshgkSuFQLMYqoqysy2hYL/vCvJ4td4jQl4XlDkOAYEOd6ZdLS9o+oQIkcCrNu7RD6KZ/C7Jbo/JCnRMvSxtwWbaRO4xDfNT7ynDvl/Q1y5k/ptawzXqVDVXDTlmtvilkHMcdXuHJrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from cayenne (unknown [IPv6:2a01:e0a:d1:f360:76fa:3ccb:8c02:b888])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 6622713F880;
	Wed, 20 Aug 2025 22:37:51 +0200 (CEST)
From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2] doc: fix asciidoc format compatibility in pretty-formats.adoc
Date: Wed, 20 Aug 2025 22:26:10 +0200
Message-ID: <20250820203722.31268-1-jn.avila@free.fr>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <xmqqa53vc77z.fsf@gitster.g>
References: <xmqqa53vc77z.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The change is needed because Asciidoc.py and Asciidoctor
do not process the '+' verbatim the same way. A span is
detected when the format sign (here '+')is preceded by a
non-word character. I haven't digged into the source,
but it seems that '{nbsp}' is considered a non-word sign
by Asciidoc.py, but not by Asciidoctor.

Using the double '+' opens 'unconstrained' span,
independent on the preceding character in both engines.
