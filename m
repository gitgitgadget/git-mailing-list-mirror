Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D953033C4
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 17:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767893330; cv=none; b=HR5O5j94CBMbwRDkjHOzc9fsuadGfsynMtwW75rnGALNBks6bMp/zi3+BumpNGjmAEEbYReZmJkRJQ5Wb+gOSHXFjT6qimpvbTtt2q2Pzk4ykv9pfR2uXeOZhxgnNf28aOWat34hjwxL+8cBeKk1x1ifrOL2OnoL3dBAv54pYuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767893330; c=relaxed/simple;
	bh=Z4PHXUMNGQQjiyDaewxGWgMZxvevl0SWAuAnpvq9UCo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VgAB186aQpDNwZeJvgNgwwQaT9F3m/+y9pgjuyrzsZgXb6PgLn29SX7WybOoTxqzmh61yEbiqzLE90PA5mB7veB3khJ5feVF3p/qGK6Xaefj8fGnj3GU5rX2NiHjj6mLhX1SYV5bUtZj6+hl/AqXTspv9skvNgBKCA6Kk3FdOM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=T8YT2ZI4; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="T8YT2ZI4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1767893320; x=1768498120; i=tboegi@web.de;
	bh=E/X1RxAasiSEZvu0JpwKNonYP3b9trb7O8aC3/u7fAk=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=T8YT2ZI42wdxDcC05sbv2AOPmDHnBDr+AluwZ9LCRVNCp4p5D7wXpnEJ2xlIikAe
	 BD/i5RzbnA7PimvyALSowRZZLkjX75XD7pUjYEtEGG38psVnA2uTgpVQ2/weMZzYq
	 g6Yy/cP+60k7zcrD7g4FRsWbBUWCQfmhN5kreOICwaeiOhqag1fwZcPUTWtlw3f2H
	 y4JaSEwpKR0mN5vzlC+9Xyxz5ntMHpnajdf/VIl4rZi34xwMFo9+3m3adzm3pnxUP
	 N0gFD+McMMn0jJo2m0rEIpaK4TOI8vhgyeNlTlJt+H7VI0CN6sI7W5CcxeMLM6RgI
	 +nHBfbASc/TgYXLmKA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from susi ([81.224.105.209]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsrdM-1vt5Ca3M2C-00uVBN; Thu, 08
 Jan 2026 18:23:28 +0100
From: tboegi@web.de
To: tboegi@web.de,
	git@vger.kernel.org,
	l.s.r@web.de
Subject: [PATCH v1 0/2] workaround for iconv under macOS 14/15
Date: Thu,  8 Jan 2026 18:23:25 +0100
Message-ID: <20260108172325.466118-1-tboegi@web.de>
X-Mailer: git-send-email 2.50.0.rc0.46.g7014b55638.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nbnCbD9v+RMAtoSEssatF7K5mINNFB90INmbIM7baSMnDkeVsnY
 jg9iyn5WGNk52vMzehv13Gida2DNG1c9hO+RgEcfh6IUqcMr8Y6p+sTW6off75nG4T4X+q7
 MQ6Ise6Te8Se+o/Elx4ippXX5YqtOcCz/Sbb/eFgLc2AJ18iqMyL3i5iBqZMkyi/CAC9csL
 h9hvkjXtCDVaaqbSpOP/w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tK93FVglfKc=;hPFthg5NA6IoXbWO/c2P4Sz2dgY
 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

From: Torsten B=C3=B6gershausen <tboegi@web.de>

Add a V1 of tb/macos-iconv-workarounds
Especially:
  Base it on master branch which has 'rs/macos-iconv-workaround'

Torsten B=C3=B6gershausen (2):
  utf8.c: Prepare workaround for iconv under macOS 14/15
  utf8.c: Enable workaround for iconv under macOS 14/15

 Makefile         |  7 +++++++
 config.mak.uname |  1 +
 utf8.c           | 13 +++++++++++++
 3 files changed, 21 insertions(+)

=2D-=20
2.50.0.rc0.46.g7014b55638.dirty

