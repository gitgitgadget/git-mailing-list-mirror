Received: from mail-106101.protonmail.ch (mail-106101.protonmail.ch [79.135.106.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB222E7180
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 18:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751306816; cv=none; b=m3OU2KhH1yrj/W0nBnZTT569i37vHpRfwA496pWJSLvWqLEbeDyacFeVs3pAj4vccr9JZTiCbOLdxZ1ANLQI0F+pO8FSsmwdp7Rr5lARQ8TPWJqSSW+oD+LSHdqcz4WlifoN48VgMIKodBJlEFXLGrr6nSfRUIJ8CxjA6x8bPi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751306816; c=relaxed/simple;
	bh=AwN86uGG/80UA2hZXbzNtiPuBKiyZ6Imn881mgO0Fhs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LqBuKBsta+tPYaNhNtfYuOR7tMGb26IPbN1pumAAXZDD3lBnK7kN8o5qSofqpeh+uYzKdrJSbzuwaE1GicWIGIowwPluhovMETpX+I2Y3Ko7OsRcoJf74TCK9K3YirrJQzdNEuEImnEaX/ya389CmUP/sV0nBg6eSJn+Q+1ogDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=YaJzJOKW; arc=none smtp.client-ip=79.135.106.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="YaJzJOKW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1751306805; x=1751566005;
	bh=8EIlFJnVu4HdskvjoV3NwmNLvR7LPa0h7r8TXC3+zBw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=YaJzJOKW8ei6GpJPBQ1VFi7FioEbjuIyAmng5HVHdafpGMU/Ke2hIUkJCm2i6Ec9E
	 JCWB/J8uBK7FxgF4pf2+LIubv52WkEpz+JlYkBfHyG19fBWxUjkqlkGPmI3yRYbSxH
	 kw3np15sUOQ2vu5Sq8SqbLoseJTy7jluuM+8jsDLXcgElnFjhx81EJZKhoop3st4Rg
	 jjllPoDrxhmeCYLQdpWB0XdaK4kHU+PFcXtJwpx30ql0mMbVc+MJAW/kAK4jpizq8Z
	 i3HnfWMs1oJP6PPWA7UZ4E2zQODw5KqF6ol4YKu4Kaaj7kyt4KyUqdelzA3yQvRj0e
	 8nZkMfjm5jL7A==
Date: Mon, 30 Jun 2025 18:06:40 +0000
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org" <git@vger.kernel.org>
From: Aditya Garg <gargaditya08@proton.me>
Cc: Eric Sunshine <sunshine@sunshineco.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>, "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 3/5] docs: add an OAuth2.0 credential helper for AOL accounts
Message-ID: <20250630180511.499-4-gargaditya08@proton.me>
In-Reply-To: <20250630180511.499-1-gargaditya08@proton.me>
References: <20250630180511.499-1-gargaditya08@proton.me>
Feedback-ID: 145777226:user:proton
X-Pm-Message-ID: 1e90af050e2a24c9a5ee11be315102f40aca6123
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Aditya Garg <gargaditya08@live.com>

Yahoo and AOL, both advertise that they support app passwords for third-par=
ty
applications. But generating app passwords for them is broken and unreliabl=
e
for quite some time now. Yahoo already had an OAuth2.0 credential helper
added in the documentation, so I thought it would be a good idea to add one
for AOL accounts as well, which is more reliable and secure.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/git-send-email.adoc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-ema=
il.adoc
index 4208bac44c..b31145901c 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -600,6 +600,9 @@ available online. Community maintained credential helpe=
rs are also available:
 =09- https://github.com/AdityaGarg8/git-credential-email[git-credential-ya=
hoo]
 =09  (cross platform, dedicated helper for authenticating Yahoo accounts)
=20
+=09- https://github.com/AdityaGarg8/git-credential-email[git-credential-ao=
l]
+=09  (cross platform, dedicated helper for authenticating AOL accounts)
+
 You can also see linkgit:gitcredentials[7] for more OAuth based authentica=
tion
 helpers.
=20
--=20
2.50.0.windows.1


