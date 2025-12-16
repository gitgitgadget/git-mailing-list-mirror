Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED7829ACDD
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765899234; cv=none; b=hze8sWqcz+o4ovkpQFr7XtuQfYUCtJJ1zrDQtCLbdPr1eGDJEbCr51d0FFvzWIOgVT+NFSn6tSYEqCXXjK//51VJ7TU6Vf64UkkLXz0/kC+LTovGKg/cBoJGgbFLfywFL9TYae9D+e89+AJGWt5P6JAyB+jsdXJ3kxOeGtEiIts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765899234; c=relaxed/simple;
	bh=X30FO49DnZIIAxvM2DmN3ix8Pt9kPuAfxWJELxGmhww=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Qad2v0gevy6VZfH8AUDgZbHPzgj/FpaNqpsO6Ly9TthVIjG1wW1dY7Iz3BFyfEbLL4Hgjzo4Kf76PzcqQhUv9mbT85HNLW5a88zNFOIllAejZ6vSHEsyLL71ph6ZyBwt+MZ6v3ECHbgs17IkRyx3US9dhj5YdsJsj/HHVEluvow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQrDNS2e; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQrDNS2e"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8b2da83f721so518831485a.1
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 07:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765899231; x=1766504031; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ny8NZtkxRrBIIamOpS+M/Zsiz33xAewhagE2ZSMDtgc=;
        b=VQrDNS2eWaiKAu9WvgldpOrORAVn02xXvpb/9IMF14nflsSdCvkshyA6sOSqQH8dr1
         tyzNZ8w6TcESiohT0YLKIB+G4Fz5FZBpYdyARg8qMPm0orTZ6CJNX/h4OWeiIP9qeG8l
         NTXlmftQcw7oMarzT0iyUF88W9xLnFfY+fSAq8dgLxhqpKMJmMkN1S8jw02uYbUQGmqc
         p6JLELvjUlJMU/LkAQLZ0KRPAvrt9m8JnnLDK7wZUUjz6KrQWya0C+YHW6fGzvdfnwel
         QTbLRCwrxsF8D9124I6T3jnTJJ8AbfFekGT6L+SnhkEMuKoaS5ROt51BPhFOkFdiCxNW
         Re8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765899231; x=1766504031;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ny8NZtkxRrBIIamOpS+M/Zsiz33xAewhagE2ZSMDtgc=;
        b=bMYav7TCk3pz+vGTagjqJ8nxFq9w6VWG87ACpKRpqWb1JFsJ3fUPQ0+1UDXN8yYZhh
         6X6PoAsn5skRZv6u5pNYctl0u398h7EbdNER7DD0qbO0MxIVOWtNw3mgft9Se4kJ+lDa
         FrFgY9W7VDF/USlurDsJXVI0eW4u6J/mnWfzyE5vK7gTq15u7VpuV1/OwaN3f8oeKHdy
         vGaBQ0Fj/wANTRdciyo8wFcbyDKJc/6DLSTBLQjgh7isRg+TaqVYl3U+N5Wy5G1f5t7k
         AhS9V0IdJSh6o3klGmKftt0N19sTgoX/9y7sB2QGJLAvXHaFmvgaOCzyzXIzw9aSFZ1k
         DYHw==
X-Gm-Message-State: AOJu0YxinuY+jZdDHaWlNsgfEuGqIwGvX2KHyEZyR72tKqNDq2huBymG
	ZjmPMmoG4Mw4C9ScRDYnHDiITMCsY8dtC7ztYMfMbkxzjHHlWlLcVjPHMpegYQ==
X-Gm-Gg: AY/fxX4Tf6m7Nm6q9beBt7ezfUlQ0Q/toKBRWCFAtPRmhrSDU023F2VXSRvX6vbsuF9
	Ys9NiOyqzMBUHUHq6QdHvfIGhHVDNj4+Dv37E/FVwcweDZ/H2lVK33uUdn4cBKEDp+rdoAyQ8Sz
	9TYdzkUzj89TNis71e/IUyrXHBDTUIkLf71tGeLOSZwRSz7EYoZDbbiYvG4t6V5s/YRdMTyIoi5
	CRGspceQPyfiiol5MBGz40XFFWstkHmrL/94Hp6myj1qRt2qxNClRQYuuqtYWIR6sRaqhHY6NfI
	wEW6laiTiK4Pme2sLgJET5ZHISw+lD037VCaFrmm0b1cz6WJHmrgNLnAOF1Y3rL7TmZx2qabcQb
	58B+v93SHjK+9rPgq/zOXbtmDMy6ryviYYVrmsOK5R6NQxlY9ywGfmLNAe6v3w6orUIF7stuUxH
	UeKdEPv7zrpg==
X-Google-Smtp-Source: AGHT+IHREL3WAFGF4G7ffhiMS6CZ6agELltQzai1VydLPEW8hyr6HXVfMnNkMdMjMA0hJwLc9DSL/Q==
X-Received: by 2002:a05:620a:4723:b0:857:7b07:3af0 with SMTP id af79cd13be357-8bb3a0ff9e6mr2129825585a.24.1765899231029;
        Tue, 16 Dec 2025 07:33:51 -0800 (PST)
Received: from [127.0.0.1] ([4.246.135.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8be31b669f9sm208837885a.44.2025.12.16.07.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 07:33:50 -0800 (PST)
Message-Id: <pull.2017.git.1765899229.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 16 Dec 2025 15:33:44 +0000
Subject: [PATCH 0/5] Last preparations before upstreaming Git for Windows' symlink support
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

After preparing Git's test suite for the upcoming support for symlinks on
Windows, this patch series touches up a couple of code paths that might not
seem to be related at first, but need to be adjusted for the symlink support
to work as expected.

This is based on js/test-symlink-windows.

Johannes Schindelin (2):
  mingw: do resolve symlinks in `getcwd()`
  init: do parse _all_ core.* settings early

Karsten Blees (3):
  strbuf_readlink(): avoid calling `readlink()` twice in corner-cases
  strbuf_readlink(): support link targets that exceed PATH_MAX
  trim_last_path_component(): avoid hard-coding the directory separator

 compat/mingw.c | 18 +++++++-----------
 environment.c  |  4 ++--
 environment.h  |  2 ++
 lockfile.c     |  4 ++--
 setup.c        |  2 +-
 strbuf.c       | 10 ++++------
 6 files changed, 18 insertions(+), 22 deletions(-)


base-commit: 77dfd223aa5b180d69cb2da54f6a7859fb94e131
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2017%2Fdscho%2Flast-preparations-before-mingw-symlinks-support-next-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2017/dscho/last-preparations-before-mingw-symlinks-support-next-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2017
-- 
gitgitgadget
