Received: from mail-il1-f193.google.com (mail-il1-f193.google.com [209.85.166.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EB72620C3
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 21:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759873179; cv=none; b=rKqSmgTEHTEfIhJG0dsadBEKvgg7WQEU9cxwvlWQQQtjoLIYEN/C2OXyeawu+76sk+3oYVZvdlzIVYIoHqt0Hf1KWQjJKHkNE7BlACJXfOvltmSaB0UZ56uxpQDVeM5fVoISVJ2l3DIpCdbEVETlPkUUyV1k3LNsv5B07CgmkbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759873179; c=relaxed/simple;
	bh=soJq6DVYfpdQX5hViLR4TDvF8Kj70dV3LXMfgtod5xw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nzz8Un438ZY4BoHHZ2r2klG7kzrIs9q2R5N9z9Bh+PBUMX4JS4BH4PCQM1Bu4IeX97MZJyJCEsiwqlcYFbxjhCr37eK7+evTyci13AfmKVX+Qou/wiN3G6Y8hGvBJU0TOo7pVNOErlwVrHFnu6Ze+nm/b3lejvoIqAYnX5AAYH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=YITu8FS8; arc=none smtp.client-ip=209.85.166.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="YITu8FS8"
Received: by mail-il1-f193.google.com with SMTP id e9e14a558f8ab-42f788ffec0so10599295ab.0
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 14:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759873176; x=1760477976; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YMNzul0dFSr5cCeJYkRyu04WtvlIYg4ebW273+MTEc8=;
        b=YITu8FS87KQZHnIYOM5qIF9QeWLZmkrPufl+h128dmeejSs85s2w6YiS7o4lO+G1Cv
         pyXZIpSIO+tGnihRLkhSbXRjwdIYZ3fDcQRA0KMGOVLTVuf09yhGSA0ePse9CyuCkbRi
         2bzVGEGCETY83kN393MsFyE4NfOp3o9Am3M8yu1YRQRcpi3vRlefPP+CgBflrZAa/3qr
         fJ6H1v/qK6k6tJtiC7GkuqZ1Ot7wEZldSl107RpoAer2wTy30RIAAQB+tfaBcFI3NvHj
         UF2zHkBprIoPtmyaEvsKSwbc+DmT6sFCd1DpNZjCPLtAYTeoApjFwbbhFZN/Zyv0KKSp
         K3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759873176; x=1760477976;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YMNzul0dFSr5cCeJYkRyu04WtvlIYg4ebW273+MTEc8=;
        b=aUvHGuVWPZeGlzWMRCISRHPuKzJSKoPicqPRTHeVSQ0ReZEmeMvS3AkbuxsQRILzCy
         P5mtkOLZGQT6hX1H868YRtZLp4mKO3neByyolh0/dCpcIbqggvWScHTwoRjXqi2EqOZS
         T03Gj1CWB+4GtgylhkYfK3QmrxnElORWHXLYHlz+AjpAl5PF2JxM31+YtyAQ+DcaV+Y7
         XD+EWvKMtBnIt+z5ppHkb/NJ05YRSgewYtCY5glxZeAmrZrQjTrroX+rPWfvtiJI0w8S
         xm+9rMPkQJ7HYPAQJoYm15exP+knCa2hDDmZKHI/YW22OAO4cvt9kA/XDmpoP5wKkuCA
         9sRQ==
X-Gm-Message-State: AOJu0Yyxvz6lNgDeusMZe9tGns8uuY0KyXK15/0NIyO6xk2lAXlZkd22
	nBgeu5Oggvmn4vlf4OswfFU6wq9TL1RVibBGefkpXGxEKm6ruD49bD7a0IapqFfkMlZokoz2BVR
	Hvu0+tk5qJLfJ
X-Gm-Gg: ASbGncsy7vX/Ut9LeTB7VFc6prCQSf55hUOnZILgQ71nnhfK24/fE0m6J1AQEf4ePyg
	dG7Ot8OkTXSg6kV7eFFujTccDo8iJH5+OnC+pRIAoFd14UTPGgt9dL0qi1uO4irad4zaH1UuB2V
	csrSKy8a0Nk4WSxexhbeaOnsyqKZj42N10hX9sI26jYohWg96ooiju1gbvmAbo2k05ooOtCZ9Uc
	TgQP+PXK9b9P+iMqL7CfbkqtYomx1XZFzznlitenBHkBlWn9Qdg+/JrSMTjpEbW6vyZVsDkLu7G
	Dec2lETgX8gxfd+APs9UF9Mn8RwSB6+LohJh8QT0V8AckM9OcU1y8WP2SZBAYG1lqwuV0UmNA9w
	Ftf1/fiF1zM1CVKU/1UlJtKM4x+SUGZbOYrxrScar0FzFuV5AMrHaA4Kq6ZTWR+B3gzsftnLdLi
	b6n1L1K0k2nlBqLr9w6ZI4mjpNY1zhiO6Hz1VnCd3i68m1618g3A==
X-Google-Smtp-Source: AGHT+IGvF6BfeZIESDs8PTs/UUtF4yHJ0j1nPaJO5qvFbSQpUnBDtVnoegFR0RV/RMPN2tADFG5gtQ==
X-Received: by 2002:a05:6e02:1c2e:b0:42d:86a7:164f with SMTP id e9e14a558f8ab-42f8737587emr8635815ab.11.1759873176189;
        Tue, 07 Oct 2025 14:39:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-57b6bb2a9f3sm5406278173.10.2025.10.07.14.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 14:39:35 -0700 (PDT)
Date: Tue, 7 Oct 2025 17:39:34 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>
Subject: [PATCH 0/2] SubmittingPatches: guidance for topic names and
 multi-series efforts
Message-ID: <cover.1759873165.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

A note to the maintainer, I suggest queueing this as:

 * tb/submitting-patches

   Extend the experimental protocol used by contributors to propose a
   topic branch name in addition to a description, and describe how to
   name multi-series efforts.

---

In [1], Junio suggested a few points to stress in our SubmittingPatches
documentation, which are:

 - Mentioning what topics not in 'master' your patches depend on.
 - Suggesting one-line summaries for topics to be used as a topic
   branch name.
 - Describing your topic in the context of a multi-series effort.

The first is already covered by 0a02ca2383 (SubmittingPatches:
simplify guidance for choosing a starting point, 2023-07-14), but the
latter two are not.

The two patches part of this series address the latter two
suggestions.

(As an aside, we should consider whether or not the experiment started
in d255105c99 (SubmittingPatches: release-notes entry experiment,
2024-03-25) can yet be declared a success, and if so, graduate it.)

Thanks in advance for your review!

[1]: https://lore.kernel.org/git/xmqqcy7a5gnb.fsf@gitster.g/

Taylor Blau (2):
  SubmittingPatches: extend release-notes experiment to topic names
  SubmittingPatches: guidance for multi-series efforts

 Documentation/SubmittingPatches | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)


base-commit: 45547b60aca32b45d2f1ef93462cf9df28637c13
-- 
2.51.0.435.gf7a65e208c7
