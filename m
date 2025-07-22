Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB212576
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 19:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753211413; cv=none; b=Q18CVesX+H0ZU1/meN8WrYtziQEnpi7Au/ZpPcwEPNh1NfEnsKuvO82G86G7wsN+D7Qw65u8UJEDJEBai7Tzh7bdhiORVfpu0NqDMxiVEiTXoSQqER0YkFL2lZA4FJBNHdQV5cWAbBYTsY3ZIMDUNOr1PjIGfL94A0pu7n+XdF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753211413; c=relaxed/simple;
	bh=p/2bfwdQYNHzQaycA6J5UJK3t3iygycft7co0/Pb500=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DTVbnb3TGusZlPoLT3j401pVJ4AF7XcD5pLUtQ4RnKrIiGW0RK+9sNfL9L7k93VQTLi26Y9LWUjA7fmyiEERA3X1I8fcNDJVKHzEj2yQVmZnSlcl7spqMDWK7hFwjJ0okyLgZjhCglVEotsZG3/XSyTK/He0MsWwSmgFua2x3LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.at; spf=pass smtp.mailfrom=gmx.at; dkim=pass (2048-bit key) header.d=gmx.at header.i=jonas.brandstoetter@gmx.at header.b=eYsmiXUE; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.at header.i=jonas.brandstoetter@gmx.at header.b="eYsmiXUE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.at;
	s=s31663417; t=1753211402; x=1753816202;
	i=jonas.brandstoetter@gmx.at;
	bh=d7J2XcJno/VzyrfL5ScHD1UECzNlh7T+0dTszx+wVY8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eYsmiXUEVkPAg4iOQPGAAnuJI8Aica7o3PkZAIQvIpk0t7WbDm+c1DUyG/Ps/bB+
	 uVMJaioQpEGMjKdeWSZpWNMb4Zz5KY9T3XW5eH1aK8XyJdGMJvxoneg0g/NPRK3Ye
	 zz+3YWFqGKBuZDtD1J5E4p5RMJsuEUkynn6qceuo/x6Ajn/pruZ5b5LcaR6YVP6Rs
	 J94V/Orm5gDV0Waboc0wa8CnhWFgwZYrMHUuc5M/bBQVBNKw70hprIWGvuY5kVZNG
	 cHsTWu9AEKxCynRd0q89tYVxInFToum/ViGiOTZyr/1CZGILc1NjH1cYBTsRkuira
	 1STJDKeY9enesZ6Q/A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from fedora.fritz.box ([185.89.163.201]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mi2O1-1v8hRm0xNJ-00ZF4f; Tue, 22
 Jul 2025 21:10:02 +0200
From: =?UTF-8?q?Jonas=20Brandst=C3=B6tter?= <jonas.brandstoetter@gmx.at>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Jonas=20Brandst=C3=B6tter?= <jonas.brandstoetter@gmx.at>,
	Fabian Stelzer <fs@gigacodes.de>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/2] gpg-interface: expand gpg.program as a path
Date: Tue, 22 Jul 2025 21:09:20 +0200
Message-ID: <20250722190922.51183-1-jonas.brandstoetter@gmx.at>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250711232348.460804-1-jonas.brandstoetter@gmx.at>
References: <20250711232348.460804-1-jonas.brandstoetter@gmx.at>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+NmjwwTNYHPyoM96NYvdfXnuPaGl6GP+Quqzszw0dGvnsPC/i/D
 gSrmvFewnI7BqKjhQ9A5kimE7Z2jDMTr45JO5Qpfn/RUWr30P73kvenpcRHOs+NZmJiLc2c
 Quz4JdZXmOZu1ELUncFF9TgxY84WwU/jyE4tFLZnZfvhmy9510vm39pPmuN9H8hCdeG0GBw
 D6L0hE6j3Enil0zX42GLQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Zruvx87Zd2M=;oZxmpnAd+LHx6PZJIQuGRyltFvo
 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

Allows users to specify a custom gpg program in their home directory.

V2 adds test cases for when the gpg program is not set as an absolute path=
.
The test for gpg in a home directory feels a bit wonky to me, because it
assumes that `~` is an alias for `$HOME` and just overriding that variable
with the test directory. But short of creating a user while running the
tests, this is the best solution I could come up with.

Jonas Brandst=C3=B6tter (2):
  gpg-interface: expand gpg.program as a path
  t7510: add test cases for non-absolute gpg program

 Documentation/config/gpg.adoc |  2 +-
 gpg-interface.c               |  2 +-
 t/t7510-signed-commit.sh      | 12 +++++++++++-
 3 files changed, 13 insertions(+), 3 deletions(-)

Range-diff against v1:
1:  b551903c16 =3D 1:  b551903c16 gpg-interface: expand gpg.program as a p=
ath
-:  ---------- > 2:  ca22bf2ee6 t7510: add test cases for non-absolute gpg=
 program
=2D-
2.50.1
