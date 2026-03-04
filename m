Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5A719D065
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 13:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772629539; cv=none; b=hs40rVRbkYV4K1VdgGeCSkmLJPia+VNHH3h+Ybb7XClSr3JE7N8CmcbgwXBY/VI5NqpXldomSd8kQp/EzynvG8Abzyh1IMEf8m74NW3SGxBchqduYWIDSueB5WmZ8LuyYtCOs6mwaF1KQjgeEhdaQ7hnW6VbMJ0Y4W55Kb3xUto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772629539; c=relaxed/simple;
	bh=vx7HuXx2DlnzUD9lFiDhf1CLgks7AfDE8LwczwyfwqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FYCbwjTy3AxvM5UT8AIn2HFhAfJ93vs+VUTybxwTZQIWsAhOc/w3HQ43ixv3h7XKsvL1NGYoSImyhGBcYDXwDTAgRX3TEOoxgNOYW0SwV4/G2v/Wkeb3pUK13Cn5DqFqjioZvQ/X6f9jPIZZmJ0ocDJ6O0+sPMMRpbOHH3mG808=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZrYvaJf; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZrYvaJf"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8274843810cso3926896b3a.3
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 05:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772629538; x=1773234338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GygyMWQLBFzVYeAvWGVNjQErtvMwV/hgYhScpdYiRCw=;
        b=cZrYvaJfn3gIY6WKhg5XrOH9RpRYwdEMJ7wQbUVzdjPHEx8NlbRUXjOsZBYHAZxzt3
         zyIk3hAbRg9U2i5D+3Z/m6IIedhKQkb/dUNJInDDn5fiZGjeXbcT0gEMXN6o1bxnN0yy
         LCfeUpVqTi15HVXPsZn2eGyga85k7OjcLylXXKvas7MDZonOgPzvGZABBJ7he1wou2c3
         8E3d1T/Sk2bcJ1D0FyO/7fTR3IwvEZtStA8r0JVUo+O1w0IIAfCzUZ0vEdWdihiqYWTR
         2LpJP2NJkaFgYiGV03v9FwFXcJysU0mB9YzrUDimChmTlmup5IIyQ/KYQueB5olS1pmS
         pajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772629538; x=1773234338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GygyMWQLBFzVYeAvWGVNjQErtvMwV/hgYhScpdYiRCw=;
        b=kZLylZd03O2dV0xkxABvSr+M7OK/b63Ppl4RceVR0YfbdWwRSHmnEG/WBIflYMhGfu
         rHJ0nRva2qHc2suDx9HnaChtuvadCZ/DMN4PFotEi0LkTUFS6bJQ/Skju5nmZi5pVubk
         x1EyHJuwlF9hOlaYV2xzmYHeZx9TZ9pZilAax22j5QmqAjKQcRB+GS1cYwa1Q4gK2bsU
         2P+c+fChHD7L+5vfd/x94OLe+dvD7S/2iG69d3E7dss0fJxOGa7JtEwIFCdKCuvCaP1K
         9kjz3PwuShRIc/nPz2qqywaJAtBVtNiquVtrhdnUgTNzW/FwOkltrPUdUd9SnDlayKPe
         y8ow==
X-Gm-Message-State: AOJu0Yx1ndiE6Jf6xe2pihZkqtkeGNgxvwGY0pvbMu+hICoxmOrdxDiM
	ZgLBO3QYlBLRXsWGjRxhFv9maiurAKuuGHqpDEpQw6eeMdfOCsjlMu+M
X-Gm-Gg: ATEYQzyAi6WWOcaqjM86k7gCIJYbqOXZEgPMw+eS9yBYMItAkQkwJ+LXvydK1WxgWqV
	zJJle8dtnso4muebLMW9zhV0uNoI0/SH6jCPIQxUd9VWHG7O3ceWqDC1dLzCizCT1FBk9gfQdS0
	5btMUnp/Xy2j+WlmBYOhckTVVgWZJDXfedceLr2t4b8K9ux5TxxHtIlSj1gci1FHXbOMPCf2eHX
	j12o+bg72Tefq9WgQS9OSX9U9+IPF9RaJmeRJJ5+09VODE/CbCYJInoXjW36AYdBkgCSWb6IL5E
	h3IR9yhDJY2MkMEzR5lLx1x/z1R9Iu6tGllXJS7cLEOzOq/2r/d0DY0wTIXDi0kclzGyeuGtGmn
	ImTBTSodbiQw1pKBJozLnYXipohYFBWxkX7Dyniw/dZ/JJbYcs3jIyTLaQrJDEnLhYOrCUOKEHq
	c01nMxr9j0pN6R5Xl+E9D4lywxIt5dBkbHpn7+Ohm8sLExcAOEUMFGqeMEz09ENT8kbVCMoPudB
	0dQeuT5Sj+HsFu/dGBDTsLvD7AH5hop
X-Received: by 2002:a05:6a21:a518:b0:361:4ca3:e17d with SMTP id adf61e73a8af0-3982deafc9cmr1944544637.13.1772629537827;
        Wed, 04 Mar 2026 05:05:37 -0800 (PST)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa3756dbsm16473717a12.0.2026.03.04.05.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 05:05:37 -0800 (PST)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org
Subject: [PATCH v2 0/3] clean up a few things
Date: Wed,  4 Mar 2026 18:34:59 +0530
Message-ID: <20260304130502.8475-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302142138.712273-1-jayatheerthkulkarni2005@gmail.com>
References: <20260302142138.712273-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v1:
 - Update commit messages of patches 2 and 3 to better explain the changes

While reviewing path.c in preparation for the upcoming git repo info path expansions,
I noticed a few areas of accumulated technical debt.

This series cleans up the file by removing an unused header, enforcing proper
size_t typing for path lengths, and eliminating redundant settings evaluations
to keep the underlying path API clean.

K Jayatheerth (3):
  path: remove unused header
  path: use size_t for dir_prefix length
  path: remove redundant function calls

 path.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

-- 
2.53.0
