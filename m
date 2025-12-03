Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5002EDD7E
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 10:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764759184; cv=none; b=GRtlYQvZHp5IINNygACJh/vaR8VNp7/opgeJltmy564PAHECQ/1fDqLISBHBIFEKM8rhoe0VtBen1CXz0/jSwEwDkXMLn1ySomHsiF9uY+TRQbVvGQsXDcwURVKVkAugD9A0aJrampJmjZhcInjtvyLPNvbW0bEeq76W0hVzovE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764759184; c=relaxed/simple;
	bh=Uv9nsAhuho49sEvG7E8yA8kZUDAwkTxzUZZGIXpBMUo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=UWN0wIgCHf+HttCMgxtD5Yj6EqK4esEfWdmH/r3zb87/CDKaIJX0G8kr3HEMFVcvCUGlzESY/E39XLjjZyForZ/rhk1RktakoCnHldj6S42qqoY7Eqdw7YkCZ5wIVN0G8P64LzjzfRJU2Ud3VxUxGnLVYwEp9lMFvnPAJwPriIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=fzx32o9g; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="fzx32o9g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764759174; x=1765363974; i=l.s.r@web.de;
	bh=KlNRVDNUFdcUSL7B/ASa+/nEUll/ivGd1EgvyfbOqYE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fzx32o9gWdEUDTMtq6C9XlaRQwUUeI0ILD44Y/ElVkqi0ljhEKBTsOSA7ThCWUOl
	 Ih3tMa7uVywxzWT2CS2oFlA4Pt4l7OJN577iRNJRDaekRFPaM9xAcb1fFwgw5G/kc
	 hZ1mbIl4BXAEjUKs9s9Ndu+vPrznFuyoUAlwz5RfZwMej6CU5dIcm/E4PDaC9hFlQ
	 sY5aDt7/epdnUW2oiODxABYGTxzPJWV5XQQJvbiyp9kVsKfxYV9UsCd89WJpXWtwH
	 gnjClR1qDSSTFWaXYVAqpjayt3X91Kpq9T+xSSyKS4icw7GdOqrnB6oboBFM/BbkZ
	 Wkm9sBKdRjuYxXKfnQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.29.250]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MWiA0-1vXRXh41VI-00Ml5B for
 <git@vger.kernel.org>; Wed, 03 Dec 2025 11:52:53 +0100
Message-ID: <fdf6e8f3-d547-4331-95c7-75b44ae6c01f@web.de>
Date: Wed, 3 Dec 2025 11:52:53 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/4] compat: remove mingw_mktemp()
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
References: <784f495a-4b1a-4acf-96cd-599243ef9e27@web.de>
Content-Language: en-US
In-Reply-To: <784f495a-4b1a-4acf-96cd-599243ef9e27@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0MSaANl8zctSiWr6fHtGYdo3+/PgpscKLM4GdUwm+hIdIwdyfHp
 1rE0+iSx38WeKm39CDI/pSNs0tCJFFjvm+ZWC0t5GMRoMpqG+WqnukGlyrF9dzDDZJ+PMIv
 MnY3Wt6+5AFY2i4eZxJSvf6E+t0J7lBIFiM97eBrZi4zUQ/taEGJSqoITP2q1S01hlLrZwT
 6t30Ui5csqjnVx+m0QxcA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rUYu/CX8OR8=;gq52QVCn3QrzPQoVlTRJbu1w6D1
 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
 NceyHXymB9dikf2GlPOWjMgeuM=

Remove the mktemp(3) compatibility function now that its last caller was
removed by the previous commit.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 compat/mingw-posix.h |  3 ---
 compat/mingw.c       | 12 ------------
 2 files changed, 15 deletions(-)

diff --git a/compat/mingw-posix.h b/compat/mingw-posix.h
index 631a208684..0939feff27 100644
=2D-- a/compat/mingw-posix.h
+++ b/compat/mingw-posix.h
@@ -241,9 +241,6 @@ int mingw_chdir(const char *dirname);
 int mingw_chmod(const char *filename, int mode);
 #define chmod mingw_chmod
=20
-char *mingw_mktemp(char *template);
-#define mktemp mingw_mktemp
-
 char *mingw_getcwd(char *pointer, int len);
 #define getcwd mingw_getcwd
=20
diff --git a/compat/mingw.c b/compat/mingw.c
index 90ba5cea9d..939f938fe2 100644
=2D-- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1164,18 +1164,6 @@ unsigned int sleep (unsigned int seconds)
 	return 0;
 }
=20
-char *mingw_mktemp(char *template)
-{
-	wchar_t wtemplate[MAX_PATH];
-	if (xutftowcs_path(wtemplate, template) < 0)
-		return NULL;
-	if (!_wmktemp(wtemplate))
-		return NULL;
-	if (xwcstoutf(template, wtemplate, strlen(template) + 1) < 0)
-		return NULL;
-	return template;
-}
-
 int mkstemp(char *template)
 {
 	return git_mkstemp_mode(template, 0600);
=2D-=20
2.52.0
