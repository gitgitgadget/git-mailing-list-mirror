Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EE33033E9
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 13:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771506010; cv=none; b=sj2WDLQEHolb7lOO3rdPli+MMi84C6GD8EQFXnQepAsVp0CES41nj23vCSfO2hDaR9w6NYEbhmoTglj+FN6dXUMX3CKsEMHzb1alH0VuJo2Meeu96jIK+QDdNCzT1VTeMGGkNJgzPhEQzoPq5UtOrpOzlBY4hzRSCfkzgQv4jhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771506010; c=relaxed/simple;
	bh=J7JZicj4widfQ3J6F97+PhplaVvoWctjC6bR4TSb/xk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bnJf/Wbp31FfgnA5A9PZTVR8P395nTkPEJT+ONdz+In7AlxNUQi3NtlivKF+lHZgN7zkokGlnm+J09VN8GndgcqmdeI/XjGGXta6nPyS95i9bNsqh4u9Pt96l6WxZlWgJl7dAsGhh4PIOgU/GvQ5I/8o19xIutsNxNnNXmenOrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyLojM+R; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyLojM+R"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48378136adcso5689325e9.1
        for <git@vger.kernel.org>; Thu, 19 Feb 2026 05:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771506007; x=1772110807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a69ckUP6GlPKvNp1Kvzn3OoFA6INY3BcDQc+BscfUY8=;
        b=WyLojM+Rm5pPtwWrsVgooKesI4Xmxld9xuEROlUPcoyqowOzZtiF4IJ2vqmg+aPYjQ
         S4JjyOL9D1p2O52w6YD3Gm9/jQMJFQEsw1l3mNAVnB/XygsL0Ku8wYw3/rnMy3pjKkao
         p3ENnWudpGG7OvseFN99E9qoHiuosIXy5JIywg3yvHVSg4PxeX+YeYGt43jRecEPwt4i
         2sTurX8aCqhKOP023BUU7t1o0XRgZFMY51UfyfhKkYgXEy5bJw5prSZ9CYwr66n2f0yf
         6rSBcflCekxxABxPd2QGuifGaXZTQNie7Wk3LvcFwq5Or2uZcGagDXg8P/4TPlM3RiID
         fAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771506007; x=1772110807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a69ckUP6GlPKvNp1Kvzn3OoFA6INY3BcDQc+BscfUY8=;
        b=bdtq07maRHZzbyelb1/i7oynnJsutaIdFBKvb1U74vkAr6hHMD9ApX/M3uoLCW3uKK
         hKF6ZlwiE5lwfepjYw/ekFisQ77iurNVr1D1o6t4YBZxahc5OZJuD7Jqy/alFKt1ma2Y
         cO3lCFY/0g39dKpQIyV22jXTwvx/6+VJKoNoZjvR3hAXCgOkuaDrkCrJzsPvNUdGD0fq
         6Ps4S1Kel7onghoWV5bz0IACD9TyqnZc6/DMZlP9QI7iXOh+QV6U3CSgYj0uW+AUdS/o
         Bn7PCCDbVqQEhhCYMss5R41hDU2Ia9DUB/bOmVIcmnzAoychxppCg54Rgz5L+6EUr2js
         wBuA==
X-Gm-Message-State: AOJu0YyHlVKKlM/zdS9/q8IXTzt3BFEYZqW08wy2jDteBE3B3dpOzqrm
	/qlS88FTNLyWYpWjyUbBwltobqZ+8ijD1O5Zjjuu9uhaIbpcwQXNs1OqAihZqw==
X-Gm-Gg: AZuq6aIIlmcgB07G2/HbhJjRFSTO97OtBlGe+07cNHiVy3xEKcPpC07+tJNkskg6Ybq
	2qVK1UtKRoBIUp3XHY9QWSTZwSuPDlBzHcgDl1ahAdy2XGf+gv54VfBH8UEryxDngkNmwF/TlsF
	ARH6AFS/aBEDrQ88xh9m1xpyePrtAiitVtHdb6UfG1+vPgrwI27+5bMQ21ntX+Sbqu+mlAZESXF
	qC29CYp9cLFQzWyo3epHNMB+y1eOCwN4SsOboDbyIjrYUHQ+nrzWUj7EDd0oLExYhv1QfdYHsN4
	BlG93uHcveJhABWLsD+8SvsZP+0db+B2iADckHPXqCj09Jakyg+rybvp+QiEn2f9HYkZJ/AoDYG
	uMat4oZK/J5dpGURFqssPYL5vjK8AtpQ5JMbR4N5ZxSHmMrdZhYEL86irwjJAa3xY3+QCFF/gen
	pbwXOc8f16U1PqxkQ=
X-Received: by 2002:a05:600c:5491:b0:480:1c2f:b003 with SMTP id 5b1f17b1804b1-48379bfd732mr306045465e9.20.1771506006437;
        Thu, 19 Feb 2026 05:00:06 -0800 (PST)
Received: from fedora ([159.146.42.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31c0779sm4603015e9.6.2026.02.19.05.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 05:00:05 -0800 (PST)
From: =?UTF-8?q?Burak=20Kaan=20Kara=C3=A7ay?= <bkkaracay@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	ps@pks.im,
	=?UTF-8?q?Burak=20Kaan=20Kara=C3=A7ay?= <bkkaracay@gmail.com>
Subject: [GSOC PATCH 0/2] mailmap: reduce global state
Date: Thu, 19 Feb 2026 15:59:52 +0300
Message-ID: <20260219125954.3539324-1-bkkaracay@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

I am an applicant for GSoC 2026, aiming for the "Refactoring in order to
reduce Git's global state" project. I have already submitted my
microproject, so please treat this series simply as an extra
familiarization exercise to better understand the codebase and the goals
of the project.

The project description mainly focuses on 'environment.c' but I noticed
that an Outreachy intern is currently working in that area. To avoid
stepping on anyone's toes or duplicating work, I decided to look for
other subsystems and chose 'mailmap.c', which currently relies on
'the_repository' and global configuration variables.

This patch series aims to reduce the global variable dependency of the
mailmap subsystem:

  - Patch 1 eliminates the implicit 'the_repository' dependency in the
    'read_mailmap' and 'read_mailmap_blob' functions by adding a
    'struct repository' parameter.

  - Patch 2 removes the 'git_mailmap_file' and 'git_mailmap_blob' global
    variables, shifting to on-demand configuration reading via the config
    set helpers and using local variables.

Thanks.

Burak Kaan Karaçay (2):
  mailmap: stop using the_repository
  mailmap: drop global config variables

 builtin/blame.c         |  2 +-
 builtin/cat-file.c      |  2 +-
 builtin/check-mailmap.c |  4 ++--
 builtin/commit.c        |  2 +-
 builtin/log.c           |  2 +-
 builtin/shortlog.c      |  2 +-
 environment.c           | 19 -------------------
 mailmap.c               | 30 +++++++++++++++++++-----------
 mailmap.h               |  8 +++-----
 pretty.c                |  2 +-
 ref-filter.c            |  2 +-
 11 files changed, 31 insertions(+), 44 deletions(-)

-- 
2.52.0

