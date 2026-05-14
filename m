Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B903C1F5A
	for <git@vger.kernel.org>; Thu, 14 May 2026 11:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778759841; cv=none; b=LyXYeQFky0IerL9361FjdYBFOIp0jrenRf9d69RLgXewCS7lmDrqZmKSY7MzSAhVADVH2tJmXM4XJI8Y48FdBXJN3CjxNP7fq9DP/1oVPDuzC1ZJoir2ICSpMr/3L69Y6h6AoXzVhbW1fqBI7MzgsBL0QrPKE84XMeT17GFTdtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778759841; c=relaxed/simple;
	bh=hi/PoD1BBoCaax8IbfhpOze9ESgPiaGoZTfadPPiSio=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kkuBTtnf8dW88gTtLdKJRLkUVk4JqkxMLCi5dZt8y/ob4C8qD6yh+L7DZ5erlX5y4cF8LuUcx/xWkTqY4Ac2ckMQrBd0wjSq5lUjbByVM3Xn2SJ/gnssHgYvdFI8S9jSBvOP40GVtaUUutC5WBObW7sBZFa0kZT1rfgq/YgPNzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=OnWUzYDy; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="OnWUzYDy"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 64EBv2rZ011541-64EBv2rb011541
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 14 May 2026 14:57:02 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wNUgY-007WOR-6c;
	Thu, 14 May 2026 14:57:02 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 14 May
 2026 14:57:01 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 9673e898;
	Thu, 14 May 2026 11:57:01 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, Tuomas
 Ahola <taahol@utu.fi>
Subject: [PATCH v3 0/4] approxidate: tweak special date formats
Date: Thu, 14 May 2026 14:55:16 +0300
Message-ID: <20260514115520.6660-1-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260512145430.13212-1-taahol@utu.fi>
References: <20260512145430.13212-1-taahol@utu.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-14.utu.fi (130.232.247.54) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lWFxYWFhYWFBeUVxfSFlbSBwJCQAHBCgdHB1GDgFIWUhZX0gPARwbHA0aKBgHCgcQRgsHBUhYSFpIWVxIWVtYRlpbWkZaWF9GXF9IUEhYSFhIW0hYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWV9IDwEcGxwNGigYBwoHEEYLBwVIWEhZW0gYDQ4OKBgNDg5GBg0cSFg=
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=LBYNaF4U49tbRjsKOrUiGiEZWCI/U63rVE2p1aLOAy0=;
 b=OnWUzYDyaB6k0d5sJTijUc+1gh1ugLO0KF1zj/bQ4IB9XLljSJYTc4ld/FYKgBNu13B3U3I3wREM
	4OWbW+T3owylG+MX5pSRkH03WuQgoa9ELNtmogGM9x/bmUr8O84ymKD5EnhXgbRYzChOIcbgpoki
	HRfppK1Z+GXUyV3S9p/B4Y7wWQaY7rO65s54+xIdF777pgDUkWtzidq1yEoBDg41ZgVauNK0qcOu
	ilX3Vn19EndYZoEnmdm6P2Y5gT+J66xGYrpj+WXZ8p0KvtdaBOoWSmo6/7gXPg7E2oljHI2WaL13
	1zxvY9Prk31NWD1q/5cXG/vdSl2l8fZHcr83OA==

The approxidate system is an endless source of absurdities.  Let's make the
usual "eh, that's crazy, let's do better with this input" type of fix[1], and
tweak some sharp edge cases, including one noticed by Linus back in 2006[2].

After this series, "tea" and "noon" will work predictably with all kinds of
date formats (today, yesterday, last Friday, January 5th, one year ago
yesterday...) regardless of the current time of day.

Links:
  1. https://lore.kernel.org/git/20181115144854.GB16450@sigill.intra.peff.net/
  2. https://lore.kernel.org/git/Pine.LNX.4.64.0610101102560.3952@g5.osdl.org/

Tuomas Ahola (4):
  t0006: add support for approxidate test date adjustment
  approxidate: alias "today" to "now"
  approxidate: make "specials" respect fixed day-of-month
  approxidate: use deferred mday adjustments for "specials"

 date.c          | 36 ++++++++++++++++++++++++++----------
 t/t0006-date.sh | 41 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 66 insertions(+), 11 deletions(-)

Intervall-diff mot v2:
1:  118f1825ac < -:  ---------- t0006: add support for approxidate test date adjustment
2:  21c4858c47 < -:  ---------- approxidate: make "specials" respect fixed day-of-month
-:  ---------- > 1:  7ea9c9967b t0006: add support for approxidate test date adjustment
-:  ---------- > 2:  3a21727dbe approxidate: alias "today" to "now"
-:  ---------- > 3:  d1992d23d0 approxidate: make "specials" respect fixed day-of-month
3:  cf72403102 ! 4:  0b1a10305c approxidate: use deferred mday adjustments for "specials"
    @@ date.c: static void pending_number(struct tm *tm, int *num)
     +static void date_time(struct tm *tm, int hour)
      {
      	/*
    - 	 * By default, "tea" and "noon" refer to last such time in the
    - 	 * past, be it today or yesterday.  With a specified mday,
    --	 * that logic is overridden.
    -+	 * or e.g. "noon today", that logic is overridden.
    + 	 * If we do not yet have a specified day, we'll use the most recent
    + 	 * version of "hour" relative to now.  But that may be yesterday.
      	 */
      	if (tm->tm_mday < 0 && tm->tm_hour < hour)
     -		update_tm(tm, now, 24*60*60);
    @@ t/t0006-date.sh
     @@ t/t0006-date.sh: check_approxidate '3:00' '2009-08-30 03:00:00'
      check_approxidate '15:00' '2009-08-30 15:00:00'
      check_approxidate 'noon today' '2009-08-30 12:00:00'
    - check_approxidate 'today at noon' '2009-08-30 12:00:00' success -12
    -+check_approxidate 'noon today' '2009-09-01 12:00:00' success +36
    + check_approxidate 'today at noon' '2009-08-30 12:00:00' '-12 hours'
    ++check_approxidate 'noon today' '2009-09-01 12:00:00' '+36 hours'
      check_approxidate 'noon yesterday' '2009-08-29 12:00:00'
      check_approxidate 'last Friday at noon' '2009-08-28 12:00:00'
    - check_approxidate 'last Friday at noon' '2009-08-28 12:00:00' success -12
    -+check_approxidate 'noon yesterday' '2009-08-29 12:00:00' success -12
    + check_approxidate 'last Friday at noon' '2009-08-28 12:00:00' '-12 hours'
    ++check_approxidate 'noon yesterday' '2009-08-29 12:00:00' '-12 hours'
     +check_approxidate 'tea last saturday' '2009-08-29 17:00:00'
    -+check_approxidate 'tea last saturday' '2009-08-29 17:00:00' success -12
    ++check_approxidate 'tea last saturday' '2009-08-29 17:00:00' '-12 hours'
      check_approxidate 'January 5th noon pm' '2009-01-05 12:00:00'
    - check_approxidate 'January 5th noon pm' '2009-01-05 12:00:00' success -12
    + check_approxidate 'January 5th noon pm' '2009-01-05 12:00:00' '-12 hours'
      check_approxidate '10am noon' '2009-08-29 12:00:00'

base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
-- 
2.30.2

