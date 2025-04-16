Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC101AE005
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 14:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744815592; cv=none; b=p+nG5J8ijkYsbBV6Nr/jn7xYp9DPPJEXdK6inKnkdKUVLKoTeNgE/qBHI9qKrSglUOoUhhHke+EqHk84Q/f/znGUyDgshVVXamXt1XkMA9+BKu1ZA5WZHHnb+W70BnHVZldsxffWMiFXrBaRK9Oek50bt48YpuC3FzASqLj8E2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744815592; c=relaxed/simple;
	bh=cf26gTs586T/QfHnBbNwDn+R5mjS+o/hcdJ7CgAFrMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WGTvhTbGTUXIN5zyNEwSh+UFGo88nr981nidabwP8NRsfni+irhQSAZx8jU4JggqqGzUaM+4lNgfL5QkwjrgXxFMe+RBtn/Cp7CTRMXhVo7v8Fn1Tg8sJXBhjlyHEQRxx1dSVkPa2pA3KFIGO828dfu9O86UZblwrsKMYtzBh24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cR3uCIOs; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cR3uCIOs"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso1398317166b.0
        for <git@vger.kernel.org>; Wed, 16 Apr 2025 07:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744815588; x=1745420388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lj4b835ET2OZy93KdQ6SH/iQ/3XYtBiFsYAkceycqC0=;
        b=cR3uCIOsahNNYKikaeotmM9byeIuGwpFsnpZAvnXz+GWwfpwVNXRc9AxcDOldTi9c7
         g0qKTNO0E6EJPgVQyU4w93cs3JbpjfJCxJflPk0yrTX8fFs4jtgnePNxFmBdB3WwY4c/
         q3Iq6+EZBhYb5s3LyIirNXhkDJgmsLjoe2C/m3V/qRSkDGaySF/KSlb7jY0AN9F1Gi7k
         0hQWpe9ACPZyXACrbyaE3PB4kxrVDOWGZuuWAMhaK450nNSuO5dXmV8FIMi3zcvMBIgK
         nUe+giBWDpGS5WKDPvbgRfm4QB+blD092BI3aCd43oVSPYQOTGn9oDBCCpxlthcmYiPJ
         dcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744815588; x=1745420388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lj4b835ET2OZy93KdQ6SH/iQ/3XYtBiFsYAkceycqC0=;
        b=vmKFqwvWxspcOECSfXAlTqYqil8EOXo2TpYven2hRlqG+C/FtMPv7fkQtLu5CEcpO4
         3Z0gdQN30IA5+EuHRYNBrPx0ZNWmb4iFvpLHa+TujbEsFY+8NROvxo7KNsIhDWfUxhpp
         702ifh7S6xNE2CngeE8zE2ZJx2CNSWD/zkd+4IWjk7V02pNsh5BFAh8a28lzJYKbvppy
         R2jmGaVIWYgNd1/zvJoCxOU+Pnzq2Cyz0FbeOpt/WPRhIYfPher35SAPtiUnG3zvDQNj
         jJE3XBMq6T3QFiX1UdZVUmyGGyuGYIwSRvvR8Oge6XFNgAWwt2AXNdo82azlLe8rilBO
         rZ2w==
X-Gm-Message-State: AOJu0YykZfqJklyyZ8gRBrBoTv784YO8xeob/Ykkn8fz5qUs9XL6nItu
	+//CbtgZBlFBkltUAuKUAMvuboWWx+GVTXHfdnU9AF0g8EEspl8BI3srgs1qsSYB
X-Gm-Gg: ASbGncuy3Hoj52LUuzZQjRVh0tHOr+zwkMq5tF2QPhpPq8WDXpstpWckOFynfe+pQUY
	RoSyPQI9VKoVVCkSJWqYZDC/wHVfUeQB+OFs4Tal7+l2qHQTwaOZOeBXP8B/xPwRoR+dS2e1d5r
	LXwYZfpc9s6aUJmmixO2PG1J+59952gVl6cCMaNfm8FwihzJpQ05RDIjoaUA0oUenQrPflIqnfZ
	vMW1geZ0wHVGCATmh6pc1jdne60ft/EIrRnsHhuPiaJrjiORJ1gOwZV/ZGI+uGamqrogxxvkyM7
	GH4nwCnWhNfCAekEp7/6uGgI7x6n7JCGxetnWePd3MeizlwkYkIP9Yz+YeLt9siITt6b8DaT9hC
	ZpecQhL6HTLQTGswcSm1otMueAtuuMLksQkHDFZ9Pzvhm8Ni12cgQESQSD2UuBQ0kfzC/nVL1H/
	JX/W3kmHTCbevH3ay8qPw=
X-Google-Smtp-Source: AGHT+IHNaFJenO812xnOfVlENct8lY1KcXEyGyk5xwEFwR1vUReV4Xe/oiUzJ0cub3e1NFPDlpNY3w==
X-Received: by 2002:a17:907:2d11:b0:aca:d6f2:31b with SMTP id a640c23a62f3a-acb42ca964amr183600866b.61.1744815588092;
        Wed, 16 Apr 2025 07:59:48 -0700 (PDT)
Received: from Anthonys-MBP.homenet.telecomitalia.it.homenet.telecomitalia.it (host-79-1-195-126.business.telecomitalia.it. [79.1.195.126])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36ee54ff7sm8599711a12.15.2025.04.16.07.59.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Apr 2025 07:59:47 -0700 (PDT)
From: Anthony Wang <anthonywang513@gmail.com>
X-Google-Original-From: Anthony Wang <anthonywang03@icloud.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	anthonywang03@icloud.com,
	anthonywang513@gmail.com,
	christian.couder@gmail.com,
	karthik.188@gmail.com,
	ps@pks.im,
	shejialuo@gmail.com,
	shyamthakkar001@gmail.com
Subject: [GSoC] [PATCH v7 0/1] t9811: be more precise to check importing of tags
Date: Wed, 16 Apr 2025 16:59:38 +0200
Message-Id: <20250416145939.24207-1-anthonywang03@icloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250405103718.25160-1-anthonywang03@icloud.com>
References: <20250405103718.25160-1-anthonywang03@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to expose more testing outputs, we remove the piping of `git tag` 
outputs in order to expose the exit codes. In addition, we change the 
usage of `grep` to `git show-ref --verify` to check for the existence of
expected tags in a cleaner manner, preventing false positives. We also
check to make sure TAG_F1_ONLY does not exist, as it is not expected to be 
created in this test.

--------------
changes in v7:
- changed wording from "the original problem" to "an additional problem"
  as both problems are important, and there is not an "original" problem
  
changes in v6:
- removed unneccesary calls to `git tag`
- changed commit message to better describe rationale for changes
- added missing sign-off to patch #1

changes in v5:
- moved commit message to message body, and fixed subject line
- fixed whitespace issues in patch #1

changes in v4:
- changed `grep` to `git show-ref --verify` to check for the existence of 
  tags, and added a test_must_fail check for the unexpected tag.
- consolidated the three commits into one, as the changes were not 
  significant enough to warrant three separate commits.
- added a new commit message to clarify the changes made.

changes in v3:
- patch #1 and #2 were missing my sign-off, which has now been added.
- patch #2 referenced a line number, which was not informative. A new 
  discription has been added referencing the context of the code.

changes in v2:
- patch #2 and #3 have been added to reduce confusion caused by the 
  implications of `grep` followed by `grep -q`, and increase debug 
  output.

 t/t9811-git-p4-label-import.sh | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--
2.39.5 (Apple Git-154)

