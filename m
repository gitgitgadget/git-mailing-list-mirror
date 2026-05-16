Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A71A405C3A
	for <git@vger.kernel.org>; Sat, 16 May 2026 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778944553; cv=none; b=GM6RqdbVmA63ixknV+2WKqnmBgDDe3Z17FuSq0oW7a5pKv9j7Vdi21nkNaqy8vHkt08xZz8ExpmU9QJJu9f2g1oP74c+nLIRRzqUAVvJfLZVxf+vqzrBRFqqMpymXp4RC/Jz66NJStAburq+R/BDYs6JHgJSxOrhrLAUYLUU0pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778944553; c=relaxed/simple;
	bh=V7QGfvxFQ9BJxpTbG1HlhqzR1PFJ2ftB6Ssp/SIyYAQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RYCjMsLkjMfzzYefj/Iftu9tl/7uVDJd39WAQYa0deLT+jGQssO4quJwaQy+RyJwsRuBzzr9OZmneBurVg+f9GeawqlMBKVADFRZ+V4IjaS9JFNOOmb5ALNLySCIGhhhG2ncIJBFjOi3RQXBNjPgmVOOW/cWTtJ6+fyEM4nmHvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=nkV5TohL; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="nkV5TohL"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 64GFFgQf019450-64GFFgQh019450
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sat, 16 May 2026 18:15:42 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wOGju-00BJr3-IP;
	Sat, 16 May 2026 18:15:42 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sat, 16 May
 2026 18:15:42 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id d7a10036;
	Sat, 16 May 2026 15:15:42 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, Tuomas
 Ahola <taahol@utu.fi>
Subject: [PATCH v4 0/4] approxidate: tweak special date formats
Date: Sat, 16 May 2026 18:15:36 +0300
Message-ID: <20260516151540.9611-1-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260514115520.6660-1-taahol@utu.fi>
References: <20260514115520.6660-1-taahol@utu.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-08.utu.fi (130.232.247.48) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lWFxYWFhYWFBeUVxfSFlbSBwJCQAHBCgdHB1GDgFIWUhZX0gPARwbHA0aKBgHCgcQRgsHBUhYSFpIWVxIWVtYRlpbWkZaWF9GXF9IUEhYSFhIW0hYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWV9IDwEcGxwNGigYBwoHEEYLBwVIWEhZW0gYDQ4OKBgNDg5GBg0cSFg=
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=lq1xYOUmWKY29StAdcw+BYE0jbwI3Glg6IU8Pi2ED3o=;
 b=nkV5TohLipPZUxzEwuj3XuQrj0qe0CybO56AZyHSFg1GLPdlJCv7UkYdgapz6TU8YSOC+6UzxsBB
	AkMMDHlAQBSC7Qp6RB257Sf04CQWRF4KLIwvyBMDm9I1xw+ixzL5g3D4frrOpOG05WkCd4goFqi7
	gkXh6EQp9BYs1+VabcUW+a0aDnTbcNlvOJ1YKgTsrRjmfnO8RSO/1XvVGXmEZxKzT4weB/aksPWU
	kXeQNXHDPgCtk5ZJ0hKYP3UzeUPq/6AJpmcSrBAxzxsBXuDhPcf7X9Jt2B3P28Wftc2EOXb6F1JF
	xuI8kxK1DnIFZku0oVIbd/9bYOkQJjt0cE2OmQ==

The approxidate system is an endless source of absurdities.  Let's make the
usual "eh, that's crazy, let's do better with this input" type of fix[1], and
tweak some sharp edge cases, including one noticed by Linus back in 2006[2].

After this series, "tea" and "noon" will work predictably with all kinds of
date formats (today, yesterday, last Friday, January 5th, one year ago
yesterday...) regardless of the current time of day.

More importantly, approxidate is taught about "today", meaning by default
the last midnight, as discussed in the RFC thread.[3]

Links:
  1. https://lore.kernel.org/git/20181115144854.GB16450@sigill.intra.peff.net/
  2. https://lore.kernel.org/git/Pine.LNX.4.64.0610101102560.3952@g5.osdl.org/
  3. https://lore.kernel.org/git/20260515205803.26211-1-taahol@utu.fi/

Tuomas Ahola (4):
  approxidate: make "today" wrap to midnight
  t0006: add support for approxidate test date adjustment
  approxidate: make "specials" respect fixed day-of-month
  approxidate: use deferred mday adjustments for "specials"

 Documentation/rev-list-options.adoc |  3 +-
 date.c                              | 45 ++++++++++++++++++++++-------
 t/t0006-date.sh                     | 43 ++++++++++++++++++++++++++-
 3 files changed, 79 insertions(+), 12 deletions(-)

Intervall-diff mot v3:
-:  ---------- > 1:  86bcb70ac2 approxidate: make "today" wrap to midnight
1:  7ea9c9967b = 2:  9863f359a1 t0006: add support for approxidate test date adjustment
2:  3a21727dbe < -:  ---------- approxidate: alias "today" to "now"
3:  d1992d23d0 = 3:  830de02f74 approxidate: make "specials" respect fixed day-of-month
4:  0b1a10305c ! 4:  d33195dc91 approxidate: use deferred mday adjustments for "specials"
    @@ Commit message
         field for deferred date adjustments which can be easily reverted, so
         that the default logic of the special formats only applies if we don't
         get any explicit date (mday) specification.  In particular, overwrite
    -    the field with -1 in "now" and "yesterday", so that those formats will
    +    the field with -1 in "today" and "yesterday", so that those formats will
         be relative to the current date.  That makes specifications like "tea
         yesterday" behave more sensibly: instead of going backwards to the
         last tea-time and then a day back, Git will now understand that as the
    @@ date.c: void datestamp(struct strbuf *out)
      	if (tm->tm_mon < 0)
      		tm->tm_mon = now->tm_mon;
      	if (tm->tm_year < 0) {
    -@@ date.c: static void pending_number(struct tm *tm, int *num)
    - static void date_now(struct tm *tm, struct tm *now, int *num)
    - {
    - 	*num = 0;
    -+	tm->tm_mday = -1;
    - 	update_tm(tm, now, 0);
    - }
    - 
    +@@ date.c: static void date_now(struct tm *tm, struct tm *now, int *num)
      static void date_yesterday(struct tm *tm, struct tm *now, int *num)
      {
      	*num = 0;
    @@ date.c: static void pending_number(struct tm *tm, int *num)
      }
      
      static void date_pm(struct tm *tm, struct tm *now UNUSED, int *num)
    +@@ date.c: static void date_today(struct tm *tm, struct tm *now, int *num UNUSED)
    + 	if (tm->tm_hour == now->tm_hour &&
    + 	    tm->tm_min == now->tm_min &&
    + 	    tm->tm_sec == now->tm_sec)
    +-		date_time(tm, now, 0);
    ++		date_time(tm, 0);
    ++	tm->tm_mday = -1;
    + 	update_tm(tm, now, 0);
    + }
    + 
     
      ## t/t0006-date.sh ##
     @@ t/t0006-date.sh: check_approxidate '3:00' '2009-08-30 03:00:00'

base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
-- 
2.30.2

