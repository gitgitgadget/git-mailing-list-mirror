Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE295E22B
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707682877; cv=none; b=ocxrJuUGZGniNek11n6tcnxGZZCDUv+Ve2yr95DzE03LLifkU+bqzplkmhZN4h1fTJ0qLJr6Y4LUMYJissySWR/yWTBoMyT/dttcioyjYvV9urnaE6ctApuv8lGufKgVFu2FiO3tvp49gO618K4+PbtRxj1CCSLiPMFpLHov8SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707682877; c=relaxed/simple;
	bh=ScWj5rGyhpWQB+0KxZjxCy0UFDwB7bwcrkeATMcefSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IlgtWOhkewjxbORJT+mm0Ns7mmBpg8VKOU/oMB6YLptPmRUb9+jmwVYNr+l9EWEqusTFqUKpf5m2L9wlfJkHn7gybpKgHPPjx+54mI4ZwKLiIjpfEeNasqET/Z/GvsWgCvewdESejakRjIaePFQ5L4BZi/Vv69oNHm1+f+FLlk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+mG7ZpN; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+mG7ZpN"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d958e0d73dso17445055ad.1
        for <git@vger.kernel.org>; Sun, 11 Feb 2024 12:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707682875; x=1708287675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylNYlANpPOmo4n2Ch4cW9UI5oMg9+ZtBll/EW3iWBrg=;
        b=l+mG7ZpNOOXvF707VxdoEaHQL2kD01dxhIabpx7j5pMX1ynUF3JN8KZy2EUudvZxor
         LUw5Z9ln8/zkWcPQwB2LiINBm/kW6A7AezXy0gu8/3S6yolDrzur/VgXXiSKk/cps+ug
         uLQWwOjDVdbt/XIvG8lek9J2qe58Lzo6nvAF5dWHMpJTeF1/JoqLfHj5rlboP2dh1tAx
         hOYPitgfSzoAru3MoDHZp1KPKrDsLdRCI8UC6zQz/ZIpLz5Kiavk05or5WbmDf0TiK5o
         7iWiczQ27prXV4K0dUGmCJ6aJwZB7kIM4lbaH9Iwmbs9mP3b+U1w9zUoeoCdxxIqAUoT
         GA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707682875; x=1708287675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ylNYlANpPOmo4n2Ch4cW9UI5oMg9+ZtBll/EW3iWBrg=;
        b=qRNhfbICc5UrBA+5kYGcuLLWDWVESiWSx52jhSRLLrwHx1pb2e8O4657HRihdXn0MO
         4Xjl9TfwgKQ3jeIS8Ff5CkIqOM2enjQHjUJrMD4MPmtWXzy91nMSd209b/exKXr+7L9F
         pEjRLYCvLOGYwQe1MlmfgeaxlK4ezraHN82BWWZxprrhpfPd57IIhe5y0Jjbh8NSVp5y
         a8yPnxrYkTg519BNenTKRqyYoMnS+1pJB7YOf0w7x8H5cnhWYRh1vApXXE3iIhQ8SMro
         AcDNPFi9Y+bYFUGtbsAxpbVBXZZ/itzOwACoYOujOIkAPnLl2aFtqQn6xhO1OoHlG9/B
         iVTA==
X-Gm-Message-State: AOJu0YyFOCCKQHxenrO33aH/dDntB6/BoiZH1972ZRIFwErUOCAnbV31
	bMGvZiOHX82zoakfNlysNdtdNLVpTh5PzmUPSm0o/A66jzLaCrGg/rLqWMM1nQA=
X-Google-Smtp-Source: AGHT+IFGUWBohAIm3RT4dO7JtwhSRAhS9JrRG20LodAe5Ag+z8P2QN938fNVnxwon8W0d+LQjcLT8g==
X-Received: by 2002:a17:902:e88e:b0:1da:1869:910f with SMTP id w14-20020a170902e88e00b001da1869910fmr9266359plg.6.1707682874958;
        Sun, 11 Feb 2024 12:21:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVnLTbebVnQbipue00P6Qd2JNhz1/+BqAwsy9Lt0i3xvsY78TW1gr3ik/3BwFS5kWgrOGW7RM2LJ2zA08ZoQs+JNNSN8mn6qKjfwkjweLRv5OUu2aPDoY/pcRoM2XCYRCfKn8pTgGips9d3odkQ81Vf8hE7pVaIIueO92AbY+5JOJoaa0IXVp5r
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902d04400b001d9fc826522sm4635470pll.239.2024.02.11.12.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 12:21:14 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	sunshine@sunshineco.com,
	ps@pks.im,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v5 0/2] add-patch: classify '@' as a synonym for 'HEAD'
Date: Mon, 12 Feb 2024 01:50:09 +0530
Message-ID: <20240211202035.7196-2-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206225122.1095766-3-shyamthakkar001@gmail.com>
References: <20240206225122.1095766-3-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since v4, I have taken Junio's suggestion to change '@' to 'HEAD' as
early as reasonably possible. And also added new test to check the
no-op case of 'checkout HEAD/@'. 

And the second patch removes all the perl prerequisites from the tests
which use patch mode functionality, as pointed out by Phillip. And have
also taken into account Eric's suggestion to not remove perl
prerequisites while amending them in patch (1/2) and do it all
together in patch (2/2).

Ghanshyam Thakkar (2):
  add-patch: classify '@' as a synonym for 'HEAD'
  add -p tests: remove PERL prerequisites

 add-patch.c                    |  8 ------
 builtin/checkout.c             |  4 ++-
 builtin/reset.c                |  4 ++-
 t/t2016-checkout-patch.sh      | 46 +++++++++++++++++++---------------
 t/t2020-checkout-detach.sh     | 12 +++++++++
 t/t2024-checkout-dwim.sh       |  2 +-
 t/t2071-restore-patch.sh       | 46 ++++++++++++++++++----------------
 t/t3904-stash-patch.sh         |  6 -----
 t/t7105-reset-patch.sh         | 37 ++++++++++++++-------------
 t/t7106-reset-unborn-branch.sh |  2 +-
 t/t7514-commit-patch.sh        |  6 -----
 11 files changed, 91 insertions(+), 82 deletions(-)

-- 
2.43.0

