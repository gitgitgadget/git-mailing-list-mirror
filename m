Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB1C2F12BE
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 10:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764758718; cv=none; b=jI6BMr5mZlgettwJv3dKeGHVpTMnaGAcv/hFUtGIAeNjKCJwYcuCUjFMRYbDPfgnG6a0ifOfdxqbqeMy4jIwVARvI742k232/owpbJznTEqx3rHiP2+276vVxFl03fDjiB47Xbfdq0uCLtJFzJusZv/WwX1PawnKwESjQdvZm18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764758718; c=relaxed/simple;
	bh=FZWuPVLvYEkWxqOA7CusbM4kAIuQslIlhxry47ZAMpI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Oz0a+tqub6MIrpU40lsHuIzCzUVxZXe5FMf1OwTIfx4BDCdVkuRfrus79rVQYcPT0AtgGQNJYb5a6CL0yTuEEnOVhBP0Pl7tocos3YAhuNLwyKRqq7t1huYkc6QNfIzHPkFOjWW/KDK1RqEEYkDnItvbSytbMpdzWdc+eULErj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=LYfYF3jH; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="LYfYF3jH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764758713; x=1765363513; i=l.s.r@web.de;
	bh=AEdMUi/qtF1RRLL8SQvrD5jEsI61xj90P3Ijkq1ZMuc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LYfYF3jHZkfz+4VGZOzwXgp8fZ9R5hPzPyevU5HGsRw3eHLO+0ThaHCHnm7NMO9W
	 agekVr81cy+YFzhUrQkcaPwYFjth/oo5hHT5TYWBeXRX44DlDTiaBB27nGmuxN5xM
	 aK3zjGzYVixEtgqm2ZOF/Glf3gDOo4bmgyJZb1fJYCkbwtuuJiZpQdSEGXHYGZGw9
	 4J452AXGeCK8HlVwXsiWZQvQXhCuwzlEYNJgrLIO42l1figpTLIZ1kOct1eQCZjX6
	 bWVEf/wwdzrx18K9xcul+GMErGpEli7ww/exxfj0/BetI6blFz+j+7cwfUF6RqfKq
	 RVD3vCWP56tQkcziRg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.29.250]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N2BI2-1wCq9v1RZG-00yOHX for
 <git@vger.kernel.org>; Wed, 03 Dec 2025 11:45:13 +0100
Message-ID: <784f495a-4b1a-4acf-96cd-599243ef9e27@web.de>
Date: Wed, 3 Dec 2025 11:45:13 +0100
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
Subject: [PATCH 0/4] ban mktemp(3)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ctzOta0rJyYajYIe05bIU6VGpCAGuIatYCDhsv6ntkF+Zy24UW6
 qh5AOQ6WvVSbkjyQ2ESgwB2g2tr+U4WcwuxeHpzfDDPQZkjlR17x/0GvipTfykAzWXChylz
 vC0JZ00mGgMDxk/jHwXQSO19k2iQziqDo4e7dmSAbMEOdAFyFLh4gvQTDHSUEWhCnTUbw8T
 UZvSpSw+T5aAX9lhSrZQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZfWZjXQ7CR4=;HMieTJNqt5vU/Xmd3W9aKov2RWm
 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
 0fJEEv8yhSkDBNCi3ch3j0g==

mktemp(3) is insecure and POSIX.1-2008 no longer specifies it.  Stop
using it.

  wrapper: add git_mkdtemp()
  compat: use git_mkdtemp()
  compat: remove mingw_mktemp()
  banned.h: ban mktemp(3)

 banned.h             |  3 +++
 compat/mingw-posix.h |  3 ---
 compat/mingw.c       | 12 ------------
 compat/mkdtemp.c     |  4 +---
 wrapper.c            | 17 +++++++++++++++--
 wrapper.h            |  2 ++
 6 files changed, 21 insertions(+), 20 deletions(-)

=2D-=20
2.52.0
