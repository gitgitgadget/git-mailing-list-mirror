Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E7017C8B
	for <git@vger.kernel.org>; Thu, 23 May 2024 16:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716482285; cv=none; b=ZohqjaUH4XmZ+8ZBLCLGrJjePDbVaySK8dhupbI46JvD5MtW+/OiACa6dBW2rPfOkGTDaVF+a5GUZALlYaxl1FivSjbBYDPwR8DF/luRXNQHOhMwTe9z1qi3vfDZYzjDQVIO7wTGzpQsiCZAjjNabSWdqNGP0gTfX1wg8CEzMmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716482285; c=relaxed/simple;
	bh=vTYiIXnIGBa5fvafLyY8AjP2WgM/RC1LT9pReAQQxZk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TGslwfN6ZVwf+/Cqodle6DNTM10XXUM9q6MXZGR5rRroQXWdfvuyFf4GxJ0lRAJ9rwM71BjNsigdr8KOeJHbTzLa5TKwSWBuOSsuKYxthC8GwoYXs9NWv0FCcSx6P00MBjat2vqG+olgDKGJDflkHsfDF6VQ1E0R3kNEGjm6iRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=tHak9Tgz; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="tHak9Tgz"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-792b8d989e4so452357985a.2
        for <git@vger.kernel.org>; Thu, 23 May 2024 09:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716482282; x=1717087082; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VG4iXv71Oyn4ilzTYRCoVsALwON/5OAeF2C68F3dJds=;
        b=tHak9TgzHzDINnwgeY+31h/ZasJ7mWafAhViZJiiQS0VvAEbcf8jAsBlvrpuwZftfB
         DrpHUQYfbs84aSEHvCcPl+dWcwRPJSLIB0MMFVtXDZCgaCm2LDcpXEL1Bj4ovHo9CMtR
         tGkRGd4q5vQa49lHb3hf2AEY9B2ffI212GsEnHqkxC18djlTbb6Jb0jag7Df4oXXHGSE
         m9gj4nClW1BwgQT7M9xD50MdWReqbuNuYHpUxZPKFAa8NjjILktylDqJPG99Wt10waNt
         QNgPzhvI/gonosHpvXdGDvpVpbVUCYslQxiDBYZdlx/ev5PfYZzlvyLuHxhAuv15Gu2c
         FbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716482282; x=1717087082;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VG4iXv71Oyn4ilzTYRCoVsALwON/5OAeF2C68F3dJds=;
        b=RlS6vH9F7rDDK/EjM5YM4LTUbtRWq5vry8mmkFkMrqxxNPs4k0y4H+Fm3X/TVX74dX
         ZRd008w++DVV289jIku1PZjoxjElH+peJ6zFtqEUnuenQa5Ik+NBYtJ00mpTa0ieFFBp
         LrnVCAWWWDWPVIBpE7ifr3J7mlc7BCqwtVmENSMFeRKd+QoFPhT6l5rorsajx0YanXfV
         xfSa6O4LWlZFAfkV8At+gNKT8m+NHHbaKfqVZYb7ZgP4nn8xIkJ7DK2XE0Lx5/62UoRv
         A6d2TsyhpUHP+aHYekDG4eA6ejhGch//ffL/muNmD4igkfCO4Zuhqr+rIVQVsjG8uHbW
         ZciA==
X-Gm-Message-State: AOJu0YwZ7ZEQC8eg6Bg/gWbN9KNMZVvlUTJs3hFzDAT4wQgRCpNBP6pj
	Mv3CefAwBQWwI7FPZxZN68ChDK2kCjdbynx5EMCdhIndn0Sb53uJYruvCO3SgBz/SWun6OR1SFR
	8
X-Google-Smtp-Source: AGHT+IGs5UBDroCrSe3cWwy6oHmd4B4YtQBUt1YEIGkPPxS11sThLkw1/0ugnd0l0c6GEM7ZfghH0w==
X-Received: by 2002:a05:620a:424a:b0:792:9741:ca86 with SMTP id af79cd13be357-794994196e6mr652115185a.11.1716482281575;
        Thu, 23 May 2024 09:38:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792dbc57811sm1192329885a.14.2024.05.23.09.38.01
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 09:38:01 -0700 (PDT)
Date: Thu, 23 May 2024 12:37:59 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: [PATCH 0/8] midx-write: miscellaneous clean-ups for incremental MIDXs
Message-ID: <cover.1716482279.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This series has a grab-bag of midx-write related cleanups that I pulled
out of a larger series to implement incremental MIDX chains.

The main goal of this series is to support reading an existing MIDX when
writing a new one with `--stdin-packs`, since we need this capability
for incremental MIDXs. Along the way there are a few other
quality-of-life improvements and refactorings. The first patch in this
series fixes an existing segfault that can be triggered on released
versions of Git (but has no interesting security implications).

Admittedly, this series isn't all that interesting on its own, but it
does chip away at the larger series, so it should be easier to review.
Hopefully sending this one separately is OK, and in either event, thank
you in advance for your review!

Taylor Blau (8):
  midx-write.c: tolerate `--preferred-pack` without bitmaps
  midx-write.c: reduce argument count for `get_sorted_entries()`
  midx-write.c: pass `start_pack` to `get_sorted_entries()`
  midx-write.c: extract `should_include_pack()`
  midx-write.c: extract `fill_packs_from_midx()`
  midx-write.c: support reading an existing MIDX with `packs_to_include`
  midx: replace `get_midx_rev_filename()` with a generic helper
  pack-bitmap.c: reimplement `midx_bitmap_filename()` with helper

 midx-write.c                | 157 ++++++++++++++++++------------------
 midx.c                      |  14 ++--
 midx.h                      |   6 +-
 pack-bitmap.c               |   5 +-
 pack-revindex.c             |   3 +-
 t/t5319-multi-pack-index.sh |  23 ++++++
 6 files changed, 118 insertions(+), 90 deletions(-)


base-commit: 4365c6fcf96caac73dcc412aa25db34cf8df48d5
-- 
2.45.1.217.g9bb58e2bf5a.dirty
