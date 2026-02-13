Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964FC3033F9
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 22:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771020525; cv=none; b=RcQAivYdwOK+Mc8fUUKs4ZRw4I81Jatyw1VPj3QhU3BaGeGVVl7L5GjbMzW/ep7OeEHCG1io+v8SwVQBw5bWXPHzSZ9LQkNKTqk2RUhAId4hGa4PVzGl2PG1a5WzLkFvNyfzTtgAA9u5i4ovh/jw2RkOi6OSBSufmqK5X3nzZYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771020525; c=relaxed/simple;
	bh=0t4p8xq4EAvabJU3fTq3O0bDDAKqDu/MZYaiKP8r+TY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZCP0zqIeLTdCR4+jHfRfys3/zuSJhC/8M4BUpD/JU43Ibjb9yzz/ioLT5MVx5qNeYWaZd5f2m4oOXhSGCCTEgdcxPjSJrqgKAyJ/y+yNBWI4c4wB8jrcn6gp96vLDhFvCNHy1TmLDEQr2plu6DhrItKzlbJotSQmlvsusuamy9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMHZDiSW; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMHZDiSW"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48372efa020so8603275e9.2
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 14:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771020523; x=1771625323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VKgC4x9/+SSjUvO40LfAujDrK814rQKTNHzy9qVi4QY=;
        b=hMHZDiSWrcLEddPKl45ayodzH06iyt8F1ETM2Dt6HRIf9aOWewtN1Ojzvzj0sqY1Aq
         sar5+o9CYJ6aIRUt0hWaJ/bpqhw/CUqhlVahO/tOj1yinprxYA4ml0dlbdPlTw0Pa0fO
         IH8ZXv5B908+jkjTJaXQV2TGqDLmBY7ej3ubnGPC45x3OMV6jJ6GVATi7p/t2jZCnlPV
         IXOMTlldPToaKqMLeYJKzqjIVSqE4E+bHV1Osd+VWASAiNc3IqFsLpwFhMbOWRX9YdbJ
         2NxSFKG+Etp3VKQ8FaGdd4yVnyIdD3D8R+gyJy6tyr6YYuHtjRPpr5PnpTiJVDJLKE8H
         Dg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771020523; x=1771625323;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKgC4x9/+SSjUvO40LfAujDrK814rQKTNHzy9qVi4QY=;
        b=JA3SCTNYCtHoZnA0Epd+nqy/YT+untNlMJOtINPz997VhHGYPgAs5WK9J5Nc5N2Wdq
         7fdMl1de0NHSItqBBSBngp36v/hdz1tDY7DvK/zP61F9NTraWxKCxIIOhUSTvhwpfN6Y
         yrF7e8OU0y+Xa/F5DsFV1IINKPHRHXoiI6o2A7TBccSnMl+OjFbQ6BoAhiqFn2dMzm0j
         Rc/Q9+hJRPA+f0WmhHdg2PaAVBRVlStoNJR2/FOE0BfTQjPOUywI3R48er2e3/ckEUUv
         +gH38uuXuLBj5zU6PNrr4mVwv/HsKbdC4+QFPncNe7Xq/yopB2QKbzYHIa+eZwL7Y4w2
         JGzg==
X-Gm-Message-State: AOJu0Yx3grt7ZIOn0/kE1W/1Lc2FFkt4wbdHY9hySePW7WiZzX49g+x+
	qs2FxTBKgb1rmXEJilzEUYbcDxP6twoUTKxzhOtnDyyc6BbuaiW6DHEFXXTBmUEJ
X-Gm-Gg: AZuq6aK/opX9sF5M+1soOQ4KqcZxPLjCbc7t5GMm3eapi/yQNfabhn/3mQiIUAIBu6r
	nqQ7OUfE7yhXWufnxx0DDkvogQASE+seRkrBbk8d2dYj+ZgSXzWdm47sEBrvvinJltt/ZZRKqOW
	BBM6NnXsKN847Ro/WG20V5/K/Lg1aaIVmPtmkETr2+kKTfy38DwBrDs97SqAVM6CONYlUPddFrV
	LsVvO5OZpdYGa/kxBL79cKBkRDaNvQrzqsK//9R9i0wFIxl3gTyzzDq1/vU4HsuAYi6GnPKS+8O
	XF0Vf6+J6jgCeBbWjMCjhVrKd1pb7fJwrr6AAQe9SCGep09GZE3qjFETkN0LfByfX3SfM7VJI09
	0H2EtbBZGvrwpwYR76WMXjqUAcjlocjCCe8IvPUBU0BS6URA1sPMReAbUgMdNtjgVwzZTz1K+qA
	9fPpQVPnnmk9MK+8/F/dLIO6YnHTvYYZfar2HHcEsc
X-Received: by 2002:a05:600c:a44:b0:477:2f7c:314f with SMTP id 5b1f17b1804b1-48379bbc51bmr13369855e9.10.1771020522342;
        Fri, 13 Feb 2026 14:08:42 -0800 (PST)
Received: from localhost ([102.88.77.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a6b563sm8417445f8f.12.2026.02.13.14.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 14:08:41 -0800 (PST)
Date: Fri, 13 Feb 2026 23:08:51 +0100
From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [PATCH v4 0/4] introduce new option `--auto-advance`
Message-ID: <cover.1771015581.git.abrahamadekunle50@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770390576.git.abrahamadekunle50@gmail.com>

Hello,

After after more reviews and deliberations, I have been able to
rename the new option name to `--auto-advance`, where the
--no-auto-advance implements the feature and does not auto advance
while --auto-advance is the default and maintains the current
behaviour.

With the option, users can navigate in between files while deciding
on hunks as they wish with the '>' and '<' option for going to the
next and previous file respectively if there are more than one file.

Patch 1 implements the new `--no-auto-advance` options, Patch 2
modifies the function `patch_update_file()` to instead take the index
of the file as parameter instead of the file_diff. Patch 3 moves the
'git apply' logic into a function so that we can reuse this logic when
implementing the all or none application of patches.
Patch 4 implements the interfile navigation, and adds tests to the
interactive test file.

Changes in v4:
==============
- Renamed option to `--no-auto-advance` with `auto-advance` being
  the default option
- Modified the function signature of 'patch_update_file()' to accept
  the index of the file diff
- Moved git apply logic into function for reuse
- Removed the whatnow prompt. Now the hunks in the file keep
  showing even after all hunks have been decided
- Added hunk summary to patch help remainder to show the user the
  hunk deails
- Added tests ot t3701-add-interactive.sh

Abraham Samuel Adekunle (4):
  interactive -p: add new `--auto-advance` flag
  add-patch: modify patch_update_file() signature
  add-patch: allow all-or-none application of patches
  add-patch: allow interfile navigation when selecting hunks

 add-interactive.c          |   4 +
 add-interactive.h          |   5 +-
 add-patch.c                | 157 +++++++++++++++++++++++++++----------
 builtin/add.c              |   4 +
 builtin/checkout.c         |   7 ++
 builtin/reset.c            |   4 +
 builtin/stash.c            |   8 ++
 t/t3701-add-interactive.sh | 100 +++++++++++++++++++++++
 t/t9902-completion.sh      |   1 +
 9 files changed, 246 insertions(+), 44 deletions(-)

-- 
2.39.5 (Apple Git-154)

