Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5466126F2BD
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 17:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770570088; cv=none; b=uNANWpC//IL3cLs/jrp6qM6ZaaIGp7X7dkK/lp/bdsLavPhHfbJnm/+3y0+HQ9x4HLJO5KM6BGI0kyxcpjQrJmZzgEB9McgUm4dU+2NDQf+UJmXFAHwyZIS/Rix2Jjg9XsHaNTVxMpaFLYZQ2Ihgkn7Y85Dz3EwAAr4fGoA1S4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770570088; c=relaxed/simple;
	bh=xH6aHDf9hWCI5QGKmrNK6ThNLUzwicWkvfLXnaw/QU8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=osr6ueLKnTYQ+p8yn1xS8oOilXiduw3gDRXcvm1Mh88hVQBaBnwZMiFZw0AXPDc+5Fum2fmoayTlPbzK64vRKAGFERkVZesxl6QRYkChIFVidCcjDUTj715HPYsfoQfFQwL//adEkNgnrR7crhWRcT6B1sI1s1MDljaD8CTLh9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=AcZaM1vO; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="AcZaM1vO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1770570085; x=1771174885; i=l.s.r@web.de;
	bh=WyR7bQURwuSRL6D347IrWxLeN74GKkwuq9WZ8CxhMQk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AcZaM1vO0s6O9gc+7bjvewYANerkKDPQF7aI6jsLC67CJj4IGTm11qYq+Jx5fNae
	 JsNnXQ6XhdTWjNAHL1wDThMjwhtw8B/KncXW5EIc+iEiojPfoDkKrRt9Qq1124tqk
	 GFl3bl8VtV6XB9SSr9wr4KyfeeOevJlp4oX38YUUh/YzhXfRw4G6RSNc8Qe5nRJ8w
	 MhuiIsiR6Dq8pFGGvTu83F9a/7WVSNSUE0LJ0x0cjRLNSm8bdYdsEm9mxJPJjO1Ng
	 vjhEUr/XCrXA4Dy/ICCv2UGtoW3KBSc9eqpdRHYM5xeBdFoCRml9lvrmAyK2HaqbG
	 MM2xYqxVFNnBBxPTPg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.22.157]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MFs1z-1w27WE170h-00E3Eq for
 <git@vger.kernel.org>; Sun, 08 Feb 2026 18:01:25 +0100
Message-ID: <afccdc3a-8672-49a7-b260-e77e617d8976@web.de>
Date: Sun, 8 Feb 2026 18:01:24 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] version: stop using the_repository
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FgeTgkhnAQVLuDIi9pQpL/ygIVGGNDaKozn6UqipX2hYKbkR/kv
 I1/4oSxAOue7gnO8ZoKvZ0qLrXJyKMW0Hk0//+TXA3tFP6hc4IShIIsyx2VrnOtzaFboJ5d
 Sy6RJwXeuJ3Wkh/jhGwC5uvfeVzWs7rX7X5ohnQ1tGcISZxInW2dch9Ufy9cPRdQ0InEiA2
 JMsi5Qci6AesH9AGGvFEA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+Remz04Bq/o=;YhzLMJIdHx072pTd+4s37zGOXeU
 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

Actually it has never been used in version.c since cf7ee481902 (agent:
advertise OS name via agent capability, 2025-02-15) added the dependency
macro.  Remove it, along with the also unused struct declaration.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 version.c | 2 --
 version.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/version.c b/version.c
index 279269cc50..21ec7c0fbe 100644
=2D-- a/version.c
+++ b/version.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "version.h"
 #include "strbuf.h"
diff --git a/version.h b/version.h
index bbde6d371a..7d502dcee0 100644
=2D-- a/version.h
+++ b/version.h
@@ -1,8 +1,6 @@
 #ifndef VERSION_H
 #define VERSION_H
=20
-struct repository;
-
 extern const char git_version_string[];
 extern const char git_built_from_commit_string[];
=20
=2D-=20
2.52.0
