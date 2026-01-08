Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968B92FD69B
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767894020; cv=none; b=COBUmHxVYhUPOG0iJfNHy6DYqWVZkK27mX+A7txzqWdo05A0eMRtm5//1POBAO3m5TKKRYX7aGDNS3KGjg+tTJM9RnqyPl4jgrjZfTBZWVbzwstJHSiCkh0R6+r3k0I5TKcvMUCf8+nLp1mc+0lEXsFb1q/Xujslx4lLidbNSqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767894020; c=relaxed/simple;
	bh=cFltmd9lCEtQr73xTu6mkeFUrKizUlw1R8efK7n+fZQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Us6HYdhGeK474s3CJkf4MIZe79zAbs4hOzsMV91LKpGf+Bh/GSGuq0Uw0b13DJATzzw1FQd6S+oHI9AaMdD66lNavuaGrKsu2q882Jkfn+B/7MdoiMvsRqfBQDkuMXH6WOS4xIlrEXYR/HlpShCbD2QcJEXi6V95oyhA4xh6VgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=bM5Wqddv; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="bM5Wqddv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1767894011; x=1768498811; i=tboegi@web.de;
	bh=e2+qlNcVnWpdX3cSThF7iJneIpdtRpRaYPt/wLogsYo=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bM5Wqddvd8MP+A+2M/Fg34zF2omZMZYmQR1NxaS8yYc2jfA+X0m9ogzerLJXo768
	 exC5EleW1QQBMHDUCmWDwzIC6MHrGXnmK2twIhyFEG4+1un8SDgQVDd6L2Acvw+aq
	 qv8GmpTWMW9qadZ0awoYlB8eDKNvr3hgXSLdYflZsxVTqHoE150ld5UxGC651Y2JH
	 Q2bHBFfsmVlfp+jLX4JOVN8jUoNHukGPQ2fv98u2aI9x2+VNYSAZUXxHUvyY5azf0
	 +dMHG74yxKJ2JYXOodbmjWB9t70Y+AHzncWo9LE+XyXxPImdGaeNjUIrXgT8Yq8Tc
	 3bdPOJhbZBaM8JjGpQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from susi ([81.224.105.209]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTfol-1vRQ2R3YSr-00KMKi; Thu, 08
 Jan 2026 18:40:10 +0100
From: tboegi@web.de
To: tboegi@web.de,
	git@vger.kernel.org,
	l.s.r@web.de
Subject: [PATCH v1-1 0/2] workaround for iconv under macOS 14/15
Date: Thu,  8 Jan 2026 18:40:07 +0100
Message-ID: <20260108174007.471678-1-tboegi@web.de>
X-Mailer: git-send-email 2.50.0.rc0.46.g7014b55638.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zJgXzT6z38bsn0gpOXKj63XBbcPwjWEvTF4X6FFo/0jxBoFqKfi
 /Afdqz8wyzidedv9j+gbZn+B81X/6/xF2zTfbwM+DGyq6BysUYoJPGQHRf0uAtIMoyJhN3D
 HKn6fv8FMQVRM38UZpccoL1Ujyyn/UUMVW3tLJMc1d7VEEeXSx5ZfzdHc+6CmqCgFqZzpaO
 fCS525Ap9Atac9VHBWxtQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:E1j17F7ppoo=;un+AuOOCwv7/yYlJZkH/WUEPzkZ
 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
 B1T6J0Kx/WxiCA9OY=

From: Torsten B=C3=B6gershausen <tboegi@web.de>

Add a 'V1-1' of tb/macos-iconv-workarounds
V1 had the wrong email address
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

