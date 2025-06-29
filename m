Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29611A23A5
	for <git@vger.kernel.org>; Sun, 29 Jun 2025 11:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751197416; cv=none; b=VO7p7KBnW4mV8C1pKVkXhAP96DkSLBXDrLi4gnyrdcRUC89zlx9BJ8rGtuzGQnV7T6g90A0B3eH1YoZYdK9qFTGkFM1dRYZzpACQi00qtsbJrY6+K1cOR0dKljhMXOQwByAU2kGYcl9JGFNMe7ZucXJ+po/aYToUPyMS2GxaGKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751197416; c=relaxed/simple;
	bh=GEKHUUmUv+xjWXTW/1C9/EaNI8c3M6Ck8kGYH21jGdM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=PdE0huwB9cq5o9lpF1d5z+zkl1Y0EfgnD+qAEauyF3Iht60+7kjpO0mdu41WuYB6js4WS514eGUo9PHL3oEGp54gnlG/faVGNT+bTl1/2nOlTvw4jBxFg0mC16SMCbCvzEX4jWvw1o6ZNyXKRZ2JvRrET4YIrohAmb2pCLHQD98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=HoY92Dfb; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="HoY92Dfb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751197405; x=1751802205; i=l.s.r@web.de;
	bh=R5djdbOgd7JruoUHQ0czAqCAkq459F/sR9ITJW74qkE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HoY92Dfbp0/rf0oAHPMsekXXB9P63RFHP7b/K3a4XAPhCIRocgdTAMbcZ/793gtK
	 9Y4s8Q9wb8orPl8ucuVJ1Bjhv25krTk6sWDlp1KnmxdhAWLdh5vX7y2j52KZL08VY
	 r5zwLJ1lXhox1BQldVNlAPBZqBQmomKFquckUskKrC1jo0bcnSTb93BT4V22kB2d3
	 7tLYcvNsqoilNkCj1V+5HYE9CdDrN6ByQvSuGZNgdm4Op/YZl6EEl0SRkVIXx4QLh
	 uUxwajj2RSf1Y6P9BxhGrH8nXRIscapczdPSIVeE8sg2+nveSdocR29lwW2yFXFKg
	 pb+ZLCUyq9BLoeq5Sg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N9cLf-1uk3PU1kcH-00w5qY; Sun, 29
 Jun 2025 13:43:25 +0200
Message-ID: <cf5cd57d-733f-4239-80f8-23bdc1523ab2@web.de>
Date: Sun, 29 Jun 2025 13:43:24 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 0/6] parse-options: add more precision handling
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M0W/mpuJ4GgPXfutvDhbODm19iWPm9Zda0jOfIIQBKCuVivnSI1
 w/SGLRHo9EbhShJS/uKhLEWiKe3ILikWvFoJuDGNrQsYmK9Gg+IYf10eG24ekQNdjVV0k2N
 w+cN5f1C3qZXU25LzRL3aF3jrPVl4k/RkZxvDoD3tJbEzBPGq8g9tNuGsh8F7C541qunZx0
 SlxAoqGlU5CeHWL4j3I4w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ebp9a8gx+D4=;bKPO/122a3HzyFQmr+FfqRbc++t
 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

Extend precision handling to all options that currently blindly use an
int pointer to access value variables.  This allows the safe use of
smaller and larger integer types.

Sign handling might be nice as well (especially for OPTION_COUNTUP), but
is out of scope for this series.

  parse-options: add precision handling for PARSE_OPT_CMDMODE
  parse-options: add precision handling for OPTION_SET_INT
  parse-options: add precision handling for OPTION_BIT
  parse-options: add precision handling for OPTION_NEGBIT
  parse-options: add precision handling for OPTION_BITOP
  parse-options: add precision handling for OPTION_COUNTUP

 builtin/am.c                  |   1 +
 builtin/rebase.c              |   1 +
 builtin/update-index.c        |   6 ++
 builtin/write-tree.c          |   1 +
 parse-options.c               | 142 ++++++++++++++++++++++++----------
 parse-options.h               |   7 ++
 t/helper/test-parse-options.c |  17 +++-
 7 files changed, 129 insertions(+), 46 deletions(-)

=2D-=20
2.50.0
