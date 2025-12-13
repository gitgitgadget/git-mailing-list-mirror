Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AE52E888A
	for <git@vger.kernel.org>; Sat, 13 Dec 2025 18:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765651367; cv=none; b=KlwaFHb5XKzYTDU2T1zR4/u7HPrx/ElbQW8pkjchiKu5lIq9JAtyDvK+zDZ2h8hf2EUjCJFlLbxu6uSrvHcDGVFIpWZcl9TJaUnh1rootX1ZU5aiUkgSlK6y79iLc2O+JarqgY52XaceH7dQbj8ae36xp/pp+UiF3lhqhUhWyFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765651367; c=relaxed/simple;
	bh=pB1tVr0vjcCVpELN5A1Kj/a6kzWoEfP9eNjEfkrqgBo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=FoHlkGzFTox3VwvADCwAZYjETaPpeQhyy3WdUcRgP4clx9/BflRiNgsgtYq21DtBIOjfP5iuy468jVjrvEZ+XQA8D2BKE6RDpC6IqVS2KIQCNjVAvib+27S3ua+HunM5iKr3aDJaPDDGOV+DYAA0g2qLbtGqbvFGstFXZnCIh7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Ijvirwqr; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Ijvirwqr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765651362; x=1766256162; i=l.s.r@web.de;
	bh=5hNZMuxuMLh6wSOYoD7dDhd1yRiyxGrBK1BTDG8+6/s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IjvirwqrnCgsfyF3xBGDVZ20THLtAM/k7EoTECLZMffY/ELrsTAb+MqhigqYLLul
	 AAF/l/4+8NonepGJ7Xo4vgDO9ROVfAwzEfHxGomoB841W/IJwzQE2ykqSISUeZ5fF
	 BbEfQWu7HXWJFzWHEW0zN+gRI9kUwhTtvQGcq20qKZqiabfhdbueo99cDdYKbY5jw
	 fIvbZT5vkmutd5AmzFzdAP8Gt8x1M/XGJQfh5bxrl4nGwRE+MHKbicSrb/rbiARbU
	 jlsRov1zr/a49Y/P1D2OX/6rVw7sBggSUxv2QCUC1Y2deD7UvzEFQZ/zdmINC/VDX
	 mzg1XiOX2Pisovy0+A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.27.139]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N8Epo-1w7y8g2LNQ-00y1hh; Sat, 13
 Dec 2025 19:42:42 +0100
Message-ID: <5153f701-cc22-4b36-9f88-7187809cbeb8@web.de>
Date: Sat, 13 Dec 2025 19:42:42 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 2/2] config.mak.uname: use iconv from Homebrew on macOS
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
Content-Language: en-US
Cc: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
 Junio C Hamano <gitster@pobox.com>,
 "brian m . carlson" <sandals@crustytoothpaste.net>,
 Koji Nakamaru <koji.nakamaru@gree.net>,
 Yee Cheng Chin <ychin.macvim@gmail.com>
In-Reply-To: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wEeohK3ehwwfrx+D2Rn2/Ox8vmQzcRYCzYqLpoMP7ruAgael43y
 LPfmIjJdO9OqALLntMrJuQ+8qyj6Ze2Eo7UhOnEW3GMcKvV/0s+/a4OKyQvPM+bRiWrUj+G
 AObMZ2UWOrWx/e6HsW+7nTzOLGsOvq1+M9j0dNAs4W0beJAxOy1Exkk3hmrS2t4F6LVPN6h
 8cOvXG07FBU+fxi39AvsA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wDOWRle2hEs=;kXhKHoHE2IAHybAeEgp3qo1hMts
 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
 ffyEqA4g=

The library function iconv(3) supplied with macOS versions 15.7.2
(Sequoia) and 26.1 (Tahoe) is unreliable when doing conversions from
ISO-2022-JP to UTF-8 in multiple steps; t3900 reports this breakage:

  not ok 17 - ISO-2022-JP should be shown in UTF-8 now
  not ok 25 - ISO-2022-JP should be shown in UTF-8 now
  not ok 38 - commit --fixup into ISO-2022-JP from UTF-8

As a workaround, use libiconv from Homebrew, if available.  Search it in
its default locations: /opt/homebrew for Apple Silicon and /usr/local
for macOS Intel, with the former taking precedence.  Respect ICONVDIR if
already set by the user, though.

Helped-by: Koji Nakamaru <koji.nakamaru@gree.net>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Makefile         | 3 +++
 config.mak.uname | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/Makefile b/Makefile
index dbd2760d18..80af832529 100644
=2D-- a/Makefile
+++ b/Makefile
@@ -1707,6 +1707,9 @@ ifndef NO_HOMEBREW
         ifdef HOMEBREW_MSGFMT
 		MSGFMT =3D $(HOMEBREW_MSGFMT)
         endif
+        ifdef HOMEBREW_ICONVDIR
+		ICONVDIR ?=3D $(HOMEBREW_ICONVDIR)
+        endif
 endif
=20
 ifdef NO_LIBGEN_H
diff --git a/config.mak.uname b/config.mak.uname
index a6521575ee..a926943141 100644
=2D-- a/config.mak.uname
+++ b/config.mak.uname
@@ -172,6 +172,13 @@ ifeq ($(uname_S),Darwin)
                 endif
         endif
=20
+        ifeq ($(shell test -d /usr/local/opt/libiconv/ && echo y),y)
+		HOMEBREW_ICONVDIR =3D /usr/local/opt/libiconv
+        endif
+        ifeq ($(shell test -d /opt/homebrew/opt/libiconv/ && echo y),y)
+		HOMEBREW_ICONVDIR =3D /opt/homebrew/opt/libiconv
+        endif
+
 	# The builtin FSMonitor on MacOS builds upon Simple-IPC.  Both require
 	# Unix domain sockets and PThreads.
         ifndef NO_PTHREADS
=2D-=20
2.52.0
