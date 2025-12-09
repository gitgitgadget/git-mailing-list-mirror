Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B183054C7
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 19:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765308939; cv=none; b=bqvoUEzcN091k0ZRSxKs/adOUx8S6UQdt6VIFCCooNijWwKEJIzjuw2kHF+B0mVNeIJtw9sllHf4/y7Q7wMFQ9F4X1E99CpzssojPKrrVQn2bSrNz9N90Bj7amxVO03OtSGUJs+3Bej0ccbP8TYONMq2BP4MCCCXUB4IbaJfZMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765308939; c=relaxed/simple;
	bh=zMszL/3kfjhQpj102f011sxwTiqipVKEmMmu0gGQKLU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=X/OvEImcV/ieQSW0MKXMd1Fv3PSe0lXI1z80qDdnhPbbG6BGE5x3b6fmgrhmQGeoiqJHgk00USBW9HMVktZQvYe6dHnL08vRaqwAyKl+1Ntplgnhs/rycS6f4i7E1TOYIjpLPK0/gqx1AMJTLCYM1S5Ms7kNu7rW43dqFyuQ960=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=njuUAI2K; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="njuUAI2K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765308935; x=1765913735; i=l.s.r@web.de;
	bh=AwQBIXWlmWm4cksCx0lvsFYHVREPSQGIMbWl7a0CZJk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=njuUAI2KrWQU6mKL1OgeXMNrLIknNReSTf6MzXdJg3mQLpJwV0+tCATbSD/HgfvT
	 huDvWPhcUmVa7wfEjksE3Z0ooOHdbDup/Nw5AE4wvcofz/ZSQ2yGJMhRk0TrEPLS5
	 hSsl5/r5R2hcO6ssPTtYIpfB0cSiwGA0UNF23vYJhzBqusqvENdYSl7GN2JrJxx/O
	 gfi6Ugy0Mwq7ZqbIJhdVJeh4MtA6d4w6jbr8CwB1iMAcr8xjuxFM/YRJw2rJvZQ8s
	 TLWSAQ/W93iD4Oh3m/9W2m0RVIdSFz1LSWf0tgChdEZhQ/iGD6MvveISuMg+F4KqQ
	 qFI6+4rez39gTR5J5Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.27.139]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Myv72-1wG3Jk3gHa-00sKVy; Tue, 09
 Dec 2025 20:35:34 +0100
Message-ID: <16efc726-34be-44f5-aa92-4e82b663ab3d@web.de>
Date: Tue, 9 Dec 2025 20:35:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] config.mak.uname: use iconv from Homebrew on macOS
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
Content-Language: en-US
Cc: Koji Nakamaru <koji.nakamaru@gree.net>
In-Reply-To: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HcSCqPlsG1FN8j/2YIoMRImj+VobhiB59r4bidOJZXLL5sz6Urn
 GwgGTF77fheHHK5vWibRYjvv6VZJJmOE8AqpCYeRgWLdZdGdkTatT6DILORGfVv9pQIpLRO
 N7euw1A7zHY/pwCkX0qL8a2ipFPo/mxvJmqsqKTdI4T6XtXds06u3mQaeDF1QFxnOF7S9cH
 IuX02Cq2+Gi6oRwuTMzpA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:20BT4IEo0pE=;Qm+ODouvKUYx6GRKrf0UY98Va+6
 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

The library function iconv(3) supplied with macOS versions 15.7.2
(Sequoia) and 26.1 (Tahoe) is unreliable when doing conversions from
ISO-2022-JP to UTF-8 in multiple steps; t3900 reports this breakage:

  not ok 17 - ISO-2022-JP should be shown in UTF-8 now
  not ok 25 - ISO-2022-JP should be shown in UTF-8 now
  not ok 38 - commit --fixup into ISO-2022-JP from UTF-8

As a workaround, use libiconv from Homebrew, if available.

Helped-by: Koji Nakamaru <koji.nakamaru@gree.net>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 config.mak.uname | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index 1691c6ae6e..1b305e38c6 100644
=2D-- a/config.mak.uname
+++ b/config.mak.uname
@@ -182,6 +182,13 @@ ifeq ($(uname_S),Darwin)
         endif
         endif
=20
+	ifeq ($(shell test -d /opt/homebrew/opt/libiconv/ && echo y),y)
+		ICONVDIR ?=3D /opt/homebrew/opt/libiconv
+	endif
+	ifeq ($(shell test -d /usr/local/opt/libiconv/ && echo y),y)
+		ICONVDIR ?=3D /usr/local/opt/libiconv
+	endif
+
 	BASIC_LDFLAGS +=3D -framework CoreServices
 endif
 ifeq ($(uname_S),SunOS)
=2D-=20
2.52.0
