Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8032D2AEEE
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 20:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726605214; cv=none; b=VQtWUPzMirXbUh3GEfHofH63zAJu/tzj9wpEOyOAayRpj9aNgqYOvtr+O3TIowtuUEkuMSjXUMDVkh4tGtHHVzuk4s5h3gprSl6jUHqzogVtbENbD6HRVZKW33X34q2CESWTWETnuL2aHgBUXaW5T/PHDmGltQggo6N7g78Mtpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726605214; c=relaxed/simple;
	bh=/TdKSNtxrAZCVNpO7BHW9wtzuXl8smvSfjsZ7m1l0GY=;
	h=MIME-version:Content-type:Date:Message-id:From:Subject:Cc:To:
	 References:In-reply-to; b=X3cyXuCFkjjFcV7Rku3X4LOSg1qP+gTZYzHLISZmTfjNorxrGHOQZeMXHBj2JZ9i2HEoeGSIACsA+3p3eohMx4A/DzrWXUf5EdJhuFCEK6kgildTpyk5P1Z/3IuSdaRiLtoKzB/UlZWWfpKLwDloHpKNBHijQOF3YuBddMjctmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=krkuVvEJ; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="krkuVvEJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=bHpsjhk22YtTKTpXlxvHgdCY2NczOtu48WfWwCGKVK8=;
 b=krkuVvEJN8tCP2/0OWX2zF7dvMMAFD0e2+3z8AIMyJ6krUTNxuG6y5sUAkwSO1ZYYmi50kaGgO1a
   WxJjByL2tuwVJL8bYLYAb6Ftr+1ulESPo9j6OKaw2OfNogYpEtg4GeVP6hpS1sIejar+j34uuI2K
   sLuPL5THf1z3gZoUQ2DRWIHiCwlbaVNGSnQdOwKD/6UVMpeh12g9ghY0YcYhMt+MsBUjtKi1yqBX
   5CYxxbJEh5wEkxXaUGDaraIEO4Y2LP7oK/vyoCErpsr/56mjLyMnqLqUTzKwEquyQDOM9RziAdHn
   ovLYRK3cD1fC/YfASw3V7Cw71VkJUTMSqJvYcg==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240709 64bit (built Jul  9
 2024))
 with ESMTPS id <0SJZ005B553LC140@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Tue, 17 Sep 2024 20:33:21 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Tue, 17 Sep 2024 22:32:54 +0200
Message-id: <D48UGAZA205N.37QFSURUDN3ZS@ferdinandy.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Subject: Re: [PATCH v3] set-head: no update without change and better output
 for --auto
Cc: <git@vger.kernel.org>, "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>,
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
 "Patrick Steinhardt" <ps@pks.im>, "Christian Schlack" <christian@backhub.co>,
 "Jeff King" <peff@peff.net>
To: "Junio C Hamano" <gitster@pobox.com>
References: <20240915221055.904107-1-bence@ferdinandy.com>
 <xmqq5xqvo37s.fsf@gitster.g>
In-reply-to: <xmqq5xqvo37s.fsf@gitster.g>
Reporting-Meta:
 AAHQEGDbQKaWfBg0QOb9cw8CEbmHFbJbr1rNRZdcQp3xiJ90RbneCYwVWS0EYxCP
 q+7h6iEL3mlNe5YlIfs5ozrXuS4+ZvtU/x4OrCyY5gGwVjOY3+2jbhNb1eDZ1nHU
 xZEP4TltBvI1JxGqi8VF9HNj+/4c7NaFMBzCuxOhNbBlFaQqra+NCOx89LHnGskA
 y0J0RnsmWKmARGCH3/D8Q4njV/pnJOARkPazCL06DH2wIu1h5lT4onMSn+eHXPA9
 zHsjwQ7J3gY5FPipti12NyyiG17x7h58Db4aR7Fh2ijGVfMhqO8g6EpdlXNcpxcy
 sIsjsJYGLzszQXxu8ZjjaJsNsZYOdor4N4G786Rsoltwj9TlZe0rxOm78514gKqb
 jfIG6Djy56Ss3aLxPxjp3nrqiWbPsJu0Y1wVeGa7DhndfgO/QTdG5mtZfCwZzWbY
 L6IIhrNiVi9j6RwCoJx1RvqTzuroBNEsZSUYGrQ4sqdnzZAWU4VNnA4=


On Mon Sep 16, 2024 at 20:36, Junio C Hamano <gitster@pobox.com> wrote:

[snip]

>  - This is inherently racy, isn't it?  We read the _current_ value.
>    After we do so, but before we write _our_ value, another process
>    may update it, so we'd end up overwriting the value they wrote.

So I've been thinking my first patch need not be so ambitious. The current
behaviour is to indiscriminately overwrite remote/HEAD. So what if we dial =
this
back a bit, leave the indiscriminate overwrite in place (the added benefit =
of
that is pretty small anyway) and only improve the printed output, which was=
 the
main goal anyway?=20

This is still slightly racy, since between the read and the write the statu=
s of
remote/HEAD could still change potentially, so the information received by =
the
user may be _slightly_ off, as we may be printing that the command just cre=
ated
remote/HEAD when it was actually created a split millisecond earlier by ano=
ther
command, but the printed end result will be always correct. And since the
output is aimed at humans really, I'd say even if some other process did cr=
eate
that remote/HEAD between read and write, it's still actually true that befo=
re
running set-head it did not exist and now it does and is set to X.

In short: any raciness left should not have practical implications if we al=
ways
actually write remote/HEAD.

What do you think?

Best,
Bence

--=20
bence.ferdinandy.com

