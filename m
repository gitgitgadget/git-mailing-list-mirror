Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B84B34B1A0
	for <git@vger.kernel.org>; Sun, 11 Jan 2026 19:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768161119; cv=none; b=AZg+Vvf3J4aigP1Y4nL/Dz3eU6xjb4hDVnjSwMZnViPbtjUbsQTrSKg5JJXDyD4s0Gc1G3kSAExBfTMfLqnrvdza8Pg05SscjYGieXuhFBDh3bl2wRHAIa8/X/S2fsFZSEmoBysl1eWbHzDWhifpDVgl5mEDYH8ltOREHJaksAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768161119; c=relaxed/simple;
	bh=vpa5k77qXD00t9N0su+R5AApOnwMhUDFIBhtfFEeLLU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cMy5VKwOZuFJKK0HQI3CSoSVfpS1eNkkahLz9wBs0etp+kYG6tbcfsCom87Ugpfiao5Z7ljZjbblNMcHrRpFky5Z5uD1ZWLbWOOER4C4l7NKB/LLHN9QtcalPrKYdLJTCEiYd3B0xJEXzDqeimAkL6b7aCRs5ppM/UYlhhHnUKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=QbKWW3PI; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="QbKWW3PI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768161109; x=1768765909; i=tboegi@web.de;
	bh=pG8DopdrMJdFBWh9FLRQBQEGscauNaqiXWyvydZuQFA=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QbKWW3PIRXv71Kt7YfEBoR0Qlp2Edc6303s2NHSMJjDziWvpjb/CqnIUgQUldoRy
	 F07pSxlVEyjlJq+Btziqt6QYQDk6rHDFyPawWm1N+ozgeDLjvZH67MC/FZhgY26st
	 7SpGDcC5oKw1Y9aGtAIUpFSjC/u/3f5znIeccbTN1kJ3bJerK+mRkCBNwBC51Wmuk
	 IAke78ZaWm7fGjciuPQt50400wj+IXPZZ4PBjxTKJYCg0OH3nb01IL30vtoBrmrez
	 cZH8ZBXt7PRLCVWcp/wUwJudnIXuOO1csurllHadISJf3KKlPEX+nJxz6I1QG6HfC
	 xEJnJgojh0MHddSAqg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from susi ([81.224.105.209]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MV2Ka-1vF44p2YrO-00HsHy; Sun, 11
 Jan 2026 20:51:49 +0100
From: tboegi@web.de
To: tboegi@web.de,
	git@vger.kernel.org,
	l.s.r@web.de
Subject: [PATCH v2 0/2] Workaround for iconv under macOS 14/15
Date: Sun, 11 Jan 2026 20:51:45 +0100
Message-ID: <20260111195145.716163-1-tboegi@web.de>
X-Mailer: git-send-email 2.50.0.rc0.46.g7014b55638.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YTMX91+tlA7IysBAcf+ggfAz2Cm16l0oEykCGZk0QTQI3dlmjjh
 iTnK2zu+7chUz9eUKfvUpVVJsRmvGPVb3kFgNgsVJEvWxgSRtz63ROd+v9e/FaR1Wxd/AcM
 s46qec6T2+GhP8t6JyYeXJK4qPs9jOxjuLmnjBYGNLu0hXJLMOnYFnPFgCRJwNubEhRTbox
 DSOJ1li0JzwzWnoM9dhCg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EO9AeM9ndp0=;20fHqG6SldZEcKWHmtQbgnJh4qr
 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
 ppR6Y0kc=

From: Torsten B=C3=B6gershausen <tboegi@web.de>

Changes since v1:
  Re-fined commit message (thanks Ren=C3=A9)
  Installed a fresh Fink. It lives under /opt/sw now (/sw in older version=
s)
  However, people can choose other places, I did use the default.
  Make more clear that libiconv from Homebrew, Macports or Fink can be use=
d.

Torsten B=C3=B6gershausen (2):
  utf8.c: Prepare workaround for iconv under macOS 14/15
  utf8.c: Enable workaround for iconv under macOS 14/15

 Makefile         | 16 ++++++++++++++++
 config.mak.uname |  1 +
 utf8.c           | 13 +++++++++++++
 3 files changed, 30 insertions(+)

=2D-=20
2.50.0.rc0.46.g7014b55638.dirty

