Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A3678F4C
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 02:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738722288; cv=none; b=nmHbDoEE1X+2h8Em2MaDOHQnGGPih1iY6Gyudc5+8tYOuY+tHIrTxkiWd3wi/sxozjA5Y9fwWRi51E721Nbw+jE5/DDo/nUhMFbsapauX54fs8f3Cljx/eq30qS8Hu9ugoaOLuvKsW/kUIBL+J6gacCugu+gpqPfa8R/qDR3zjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738722288; c=relaxed/simple;
	bh=qlM9hnxWz0qTjlMjrXjcAqHCUub6aOraiddAz+5MFPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQWwDTz7152e8spYKAh9QQ/k0VbJiufEMr9vABzXq0FotwXWdOyCvETrudHf85hLSV4rMttO5y0e9bdybXe8rN1zxKJAzZyuVxIHu1d2CKl5cMQQs1Rr56l8KETBb0b6ymJg8MsBCvnFW4QYMihUPGtJPJsWz7CE8KJhazJLdVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKltSBdu; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKltSBdu"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-216426b0865so109700245ad.0
        for <git@vger.kernel.org>; Tue, 04 Feb 2025 18:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738722286; x=1739327086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JK/IhoPjQO7YbMEiQkba9Su7Rp2hDrj9Qp6Wzz3Fc8=;
        b=IKltSBduKituh4+eYb5Pa3doWPNN9BeghLL+ePcDwJfSar39TB7WzTPhquNQYGoYOG
         OqS+lyUWAP2/Wu8qaUfToMhcb8N23+a/Ow5mw1LApobuuS6ln6TbDj24XwjNGlRiSl7c
         /zXhGpD6u4Pl25h3cfT5y/wl4jaBUsHo097x361VIgbegtaWuNARniPU3c2HHfHvFwFZ
         Uzawt10XfLxMB2f2HDW1Z+IteXMCRCBrbUG3POzA+UPAlantbGxSE3MZfAYm/wEu8F+v
         4iC9W5RbmPU7Nf7h/slXYcp/fG5APk33Eb8rtjbdDBwLlECCOcB5/MpSTAWPj4HZ+2y1
         iokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738722286; x=1739327086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4JK/IhoPjQO7YbMEiQkba9Su7Rp2hDrj9Qp6Wzz3Fc8=;
        b=L6gdO1iCPaD+OtO3GiW5r2cD0k6kRut2hKOoT1sA8yZV2ZsRlAntDe8lsTZTqcxLfA
         J4PupJ4Ahrrmgaj4RptCryrdmWckt1hEKkhboJuloi0sjCI4yW2UBvSPFDEZSbTjx/Qs
         jwQ1HYrN94RNPG9YFlFpexHxV3tQdvB+dt6Z2ngNSqpsHoezmCMwvRjM30nti899pc9A
         XtjVOk2w1Yi8Nxy4JDfb+SHXg9CrTlesmXOg0tvCag4gCrOI4wDcCxrplpwhZcrAr9bA
         PviNYzYZVmdbrVwMS/WAI5UQKDttvf11Qs403EUoy80USxT0COyM44efKIxSSWi5zIr7
         4V4A==
X-Forwarded-Encrypted: i=1; AJvYcCWe0yaacwfVbDC8lmOPC+osKAl9yjEYHAIo9GeI/RiM1V+FFOH3wLobKgmRRaUdLYqNhts=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBvYm+3Y4iSueuWtZhIYc3kyD29SnCZA/nuO3EfgJ2nr+m39jY
	7Xnbw7rDRMsnxeth1+y8XStJNqWlk9Uw1uxviKadSFmTQHtC9Haq
X-Gm-Gg: ASbGncsfablQBWb5f/KjN6CPnV3U25e/a7kzERRwStDfrxbf4gXaAVD9oqRYGzFuzZM
	x2Uc9XMrq61ZdJLbA+19fJtyQJ41R91bODd4kOWcXot5XzidYYbqkJOqnpK5EIL4zG1m0iyfPUT
	rWKzei4bxFA6EXlAvkO2l8aPRvSGl+8tT+Jlyj861dC1oMaqWO1hHeMT9pxSUA33OeEdCm2jsha
	bSWXf7xcGLYVyfJP2TFZdfj+nm5ScsSSE7KoD8PcgEKIpj8qvnGycvNbbN4pM8/RjSLf8FmI9Sn
	TbB/EhVSKRI7vekPyA3vX5Dwz0L14tRMkjDhKQ==
X-Google-Smtp-Source: AGHT+IEpMfFmWNGKXs2slJ43RglvidTRQUSWF2FQyuZIvEe7t/Rj1QfKPk3TKPShGJaR/7nXGxcQvA==
X-Received: by 2002:a05:6a00:ad8a:b0:72f:d7ce:500f with SMTP id d2e1a72fcca58-730351f0926mr1970066b3a.21.1738722286014;
        Tue, 04 Feb 2025 18:24:46 -0800 (PST)
Received: from gamma.hsd1.ca.comcast.net ([2601:647:5580:5760:d50a:b267:8bd1:adc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ce054sm11642894b3a.132.2025.02.04.18.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 18:24:45 -0800 (PST)
From: Illia Bobyr <illia.bobyr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Cc: Illia Bobyr <illia.bobyr@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH v2 0/1] Long names for `git log -S` and `git log -G`
Date: Tue,  4 Feb 2025 18:24:19 -0800
Message-ID: <20250205022422.2019929-1-illia.bobyr@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <xmqqserjsfrq.fsf@gitster.g>
References: <xmqqserjsfrq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sorry, I dropped the ball on this.
I still think it would be good to get it done.

> On 11/22/24 02:51, Junio C Hamano wrote:
> >>> `--pickaxe-grep` for `-G` seems like a reasonable alternative name for `-G`.
> >> That is probably OK (even though "-G" is not exactly what the
> >> pickaxe machinery wants to do; "--grep-in-patch" might be closer to
> >> the intent).
> > Imagining, that I am starting from scratch for this functionality, I think I
> > would also consider "patch".  Though, as we have 4 related argument names, I
> > wonder if using it as a prefix would create a more consistent UX.
> >
> > Something like:
> >
> > "--patch-grep" for "-G"
> > "--patch-modifies" for "-S"
>
> Ahh, "modifies" is a great verb.  It sounds quite logical, but "-S"
> does not have to generate a patch internally for it to work, so
> "--patch-modifies" is a bit of white lie.

Used "--patch-modifies" for the second version of the patch.

I think most people (certainly me) think about patches first, when they look at
these commands.  They are unlikely to realize right away that generating a patch
is more expensive than counting the string/regex occurrences in the pre- and
post- images.  So, if you consider the "it behaves as if" point of view rather
than "this is how it works" point of view, it is not even a lie :)

> > "--patch-search-show-all"/"--patch-show-all" for "--pickaxe-all"
> > "--patch-search-regex"/"--patch-regex" for "--pickaxe-regex"
>
> These already have their own established long names, so it is
> outside the scope of this topic, and I doubt it is worth giving
> these additional aliases (as you seem to agree).

I do not have a strong feeling on this one.  If "-S" and/or "-G" would get names
that do not start with a "--pickaxe" it might be a bit confusing that the flags
that affect their behavior do have the "--pickaxe" prefix.  If this is a valid
concern, I could probably create a separate patch to add alternative names.

---

I've updated the patch with the following names:

"--patch-grep" for "-G"
"--patch-modifies" for "-S"

On 11/19/24 10:58, Jeff King wrote:
> FWIW, I like --grep-in-patch. Saying just "--pickaxe-grep" does not
> highlight that it is about looking in the patch. I.e., it is not clear
> from the name that is different from "-Sfoo --pickaxe-regex".

Is "--patch-grep" a good alternative?  I think, using the same prefix for a
functionality that looks quite similar from the user standpoint ("-G" and "-S")
seems nice.  Using "--grep-in-patch" for "-G", "--patch-modifies" for "-S" and
"--pickaxe-regex"/"--pickaxe-all" all at the same time seems less consistent,
but I can change it if you insist.

Illia Bobyr (1):
  diff: --patch{-modifies,grep} arg names for -S and -G

 Documentation/diff-options.txt |  36 +++++------
 Documentation/git-blame.txt    |   2 +-
 Documentation/gitdiffcore.txt  |  48 ++++++++-------
 diff.c                         |  18 +++---
 diff.h                         |  11 +++-
 gitk-git/gitk                  |  10 +++-
 t/t4062-diff-pickaxe.sh        |   8 +--
 t/t4209-log-pickaxe.sh         | 106 +++++++++++++++++++++++----------
 8 files changed, 151 insertions(+), 88 deletions(-)

-- 
2.45.2

