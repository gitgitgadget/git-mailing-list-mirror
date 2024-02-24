Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DAE46B5
	for <git@vger.kernel.org>; Sat, 24 Feb 2024 21:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708811231; cv=none; b=K9Vzb5LKfIRxYKd7dbc5YdGDqI3Gb8Ke83VajzVjI4RlwDXVQQ4qGYWMlvH4hpmREF7O5SdD6KYHPyHi7AwGJqYfplBRBvBBtEtcHOuoNh/PROZxwgszBN4ma7QWx9Mm36YkaUtnSNN82oPJvtyKu5NCrC/rD9ENpZaMlHvd2gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708811231; c=relaxed/simple;
	bh=ot1vCTZ2jXvM7H8NeJQZi33HQ3VhA4309Aop4bZrnAk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Re8unOYXygH6O7kiAesOlkQmDV8mPKN2DrNjr/Tzu+FNDJt+Zgm7CeQptgZnZpBekOhmW1b981p6Fv/nabt1a+6nFwpk8bHkld1g9I5IO0AdtcFgSblNSkj9PbHwOSbp51QCDM4zU+uvi8jXCeih9eshU5f7hHogEhagYw4wWGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=FT+pgDMF; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="FT+pgDMF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708811227; x=1709416027; i=l.s.r@web.de;
	bh=ot1vCTZ2jXvM7H8NeJQZi33HQ3VhA4309Aop4bZrnAk=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=FT+pgDMFInLvQp4/PeSGusVxY9IR5rLZIHmmt66XLtS03ccF/XQz/FWhNLsCwSkj
	 CKQ3lccZHssMKWFs58YKnKM4XE7e/zVFEJBbkBBbY6/N4FhZeKgowvHqfU5oFFqUo
	 4C/4HM/ZNDoVpEC7aTyB5CSA65H4dqPiABhdvYW7BA300vK2cnz0BM9UhZ2QyGS2S
	 D8H6rfea7un0/jZvBDD7rhK7CSrOBz1XqwQXpu9uBrV5zI3kLAkjddr4nctkTAGwp
	 dIpRiBWwFXnju3lelUh1JbUhySF3j7iVMwa/0CMx5ttoTKWDDAqgHR6rz61EIfmxn
	 HdM48/rZMydxMPlZGA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.211]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MsJSy-1qkWaf092g-00tqk2 for
 <git@vger.kernel.org>; Sat, 24 Feb 2024 22:47:07 +0100
Message-ID: <cb94b938-03f9-4dd3-84c1-f5244ca81be3@web.de>
Date: Sat, 24 Feb 2024 22:47:06 +0100
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
Subject: [PATCH] fetch: convert strncmp() with strlen() to starts_with()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PZk1tCzQeOeMr65K0zOVHhiDfcfqeW2WB10UuSmPCPLmV2s4kZT
 Them8EB8FM/4I0hVcoLakJY8nnmgDljMOuJG8qWreNYm0SF9ODCYkJ1G3gYDVNemcyYKfD0
 N8unyOUz7BTjmI27upGx7XpT86mXES2MTFyM6PRj4daxSHd92l1yuoJYGqTKpMMn+Rxhsh3
 jfY0NmjdYs+/2o90HpVew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gAkl/v//Hec=;UpjzfEizFzKLR6rzABHW7gt85ah
 6nrkbkjwoYSmwS6LbQmyPt03Nk8H1L/hLJeem+SYd/vOXes9yyRWLSweC8xXSwkiTF6q/hUR/
 8OmrkKtMRGNtUXIdSBDihuHgNnTBLLBcEqDWtSZP3PbRbiKjQixDfL/re7bTTAqImeDnDoUDJ
 qY3HWWrJyabtZOsju3erEj7NcVHvi6NmOSWBOq7xi52LuHjBwKQIYZYMO7AERzY3BNbe1P1Gt
 Fa/tGAGnw33Y75WqMe1AiKXGQWSNK5pC+IG+XDICxHbRv3oIrY141l9QZMD4+W5iAMpk1Vpix
 EpBZQD3mQwuZXYfdsfA2H+Nr/oXabXKj2lWYvQFdhLH2e0146MmVQHQpVZ/Jk02I2Yv2slBQ6
 vnxo+dgCUjcgUk5d8ahc6nb9e7icK9H9U9Mmj68QVi1NqCzc3QD6U/h1Ph9ymx2MmKw7+BpgZ
 R2sVAzeEqkfWiTL6VWAkrspxkI+Rc3Jh1cMDohbmWohBkxLBA3BHdxg9bcYj3YjuIMoy5/NWa
 zFHL8hmFfXSOPsSNdBFAB1lggV3Z1wFtr+Ioqh1yV65rW0qR3UUwa8K1Lyj+fVMisXXMt8MdE
 hpZEhEy93+EVGCF2UikU3uPW67On98tHoNPbkEOa/ojo1d0deREEIeRX5BebL+oaofqScVjSe
 kHUbIVEZL0HsGt6E4wTyGoal6u3VTKkWzJEyd7PpOkwyPNx9acT+jwoH4Ui9aREh/MPy9WvZi
 MmryZnY/aIXPTYvgVEPpfKpR1YVipoOAaqjCGwC3LIUTYWBGaXKADHm0pIXamtFc7zZpi6VbF
 WsxB3o3j2zEMTfdpXs87kdtdkes1nQlkZh3voDwkAAuMs=

Using strncmp() and strlen() to check whether a string starts with
another one requires repeating the prefix candidate.  Use starts_with()
instead, which reduces repetition and is more readable.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/fetch.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 3aedfd1bb6..0a7a1a3476 100644
=2D-- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -448,9 +448,8 @@ static void filter_prefetch_refspec(struct refspec *rs=
)
 			continue;
 		if (!rs->items[i].dst ||
 		    (rs->items[i].src &&
-		     !strncmp(rs->items[i].src,
-			      ref_namespace[NAMESPACE_TAGS].ref,
-			      strlen(ref_namespace[NAMESPACE_TAGS].ref)))) {
+		     starts_with(rs->items[i].src,
+				 ref_namespace[NAMESPACE_TAGS].ref))) {
 			int j;

 			free(rs->items[i].src);
=2D-
2.44.0
