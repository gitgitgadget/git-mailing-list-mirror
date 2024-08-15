Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9962A5F
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 17:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723743061; cv=none; b=M0AFVhE+4YIDVfxf1ZvrDyvX2UAw1BQYP0JhKzXOQSmnYxyKIs7Mr3Gro7SECFQUQlyH5nMGW1GkI1OJFJ99/ODcJ9w/bDw1M+DHGzkkCNHHjLsliAssKyIZCeNpWMWgxCyZtmbzWaH45givYrZKYdtwmxFfJeotNZQawP6mIec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723743061; c=relaxed/simple;
	bh=4xZM+dbQl6vxArzr8+ot23Mes8vnW6aO9ZMu4ee/Iwc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RWjmm2lMdv/2nkJ/SGuT8jLWFCv/OTMUP1SLBLI7Wz9pmOmdrZ8+k0aibh59LHOBNfvJwibNs2CooNaBhWJavh/e9OBOaE3anZN+K4FS3BNTkvm0TDNRm2quSkjhh/rvvd6vMzfsW+pvyzpmd157EIoYNC9KVrc/UxTjcqGpPqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=dJFjTqY3; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="dJFjTqY3"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-690b6cbce11so11668697b3.2
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 10:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1723743058; x=1724347858; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3lrdN8Elb2cf8LxqmuFWsBIoNX+gYEVelYUTYH7CNj4=;
        b=dJFjTqY3YGV+PbfMClCDuuxJzUNyQ9/wkOXEkdcYtqjsM5iFYPCqipoqzbqRl9xgZS
         IFUMqmu5oVw3vO7nrKWA2AXisypwYmyEQI3IwLfiGnNHOXbhBqBlSs9oco6VfE08pE5I
         pNlgnfha14gQOWHFbFsgzoHcIWVOHTD4QubAJDhXwzS1xRuUNPUyDFh9xA/xy6uzQU3k
         807gwgGFK+xDMn4SzT3/ByWZC6lrdtZ8zf4h309JUIo7r+IvBJKLF3I+MItW4t9CtgGx
         GnAQPDisnyn2eyrcupjyqWwQ2DMPjxcxY8modSk7V7r9M1l0wAk/d85ydJCPJV4D3XMf
         K2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723743058; x=1724347858;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3lrdN8Elb2cf8LxqmuFWsBIoNX+gYEVelYUTYH7CNj4=;
        b=H/8uD62Ri8kXul+cJT+HvpN2Mm/G9C0S0ycGS+7r33Jla32x6TJLy2hi9fvtz0gG07
         nmGHnnxQEwpSU3nhCgmlYl9hxEgxwC3VjSq00KSdge2qTnVugt0PkF8bd7InRS+B7IMi
         JMcfIqrNI+chWRAWpqF8TjCvCqghXZoAklKINkmWJPdaRPNnbFHp0i/1GlsTHWJUcOp2
         bRoDG+oMqaXpsb0qN4x1FKz6tyU1cZdSIgYUm/gdrgcweV35f8a4P5htRmFxu1DxvNn0
         fV5r4WnHTpd3Tl+WtP8tIIelpMxhnAxet5HB9XMKp5E5juhbr0Bm422d1Y5686FOi+mD
         KskQ==
X-Gm-Message-State: AOJu0Yy5w7KcPeTuNBfc8JSr4KLF9xZ9w4h0vlmAc24VOuetfQn9joK6
	ubf+ZotQaQ70as/4xLVU4lF9dtuHc+NN6oMsM0sMVV7BJiAR9s5AbgQ/yc2bTE7B2+wg0G8UVsc
	g
X-Google-Smtp-Source: AGHT+IEZ+2bGIIVTlFkvI8z9FK3auB5mownU6dcHh8oPDpkfFCm7DMxk4DfvnANJ7cWsR2CIcKhxcw==
X-Received: by 2002:a05:690c:4e86:b0:6ae:614e:cbb with SMTP id 00721157ae682-6b1bcf9052dmr3808407b3.42.1723743058397;
        Thu, 15 Aug 2024 10:30:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9cd7a530sm3134237b3.103.2024.08.15.10.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 10:30:57 -0700 (PDT)
Date: Thu, 15 Aug 2024 13:30:56 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/8] pseudo-merge: avoid empty and non-closed pseudo-merge
 commits
Message-ID: <cover.1723743050.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This series fixes a couple of small issues with pseudo-merge groups,
where it is possible to (a) select pseudo-merges that are not closed
over reachability with respect to the bitmap's pack or MIDX, and (b)
generate empty pseudo-merge commits.

The series is structured as follows:

  - The first four commits refactor the pack-bitmap machinery to make
    the bitmap_writer's packing_data structure available earlier at
    selection time, and then remove redundant arguments from the rest of
    the API as a result of that change.

  - The fifth commit makes it so we select pseudo-merges even in small
    repositories, making it easier to write tests in the remainder of
    the series.

  - The next two commits demonstrate and fix a case where we would
    generate empty pseudo-merge commits (see (b) above).

  - The final commit ensures that we do not generate pseudo-merge groups
    which reach objects not contained in the bitmap's pack or MIDX (see
    (a) above).

The bug described in (a) was noticed by Peff, and the remaining seven
commits are preparatory, and/or fixing other small issues I noticed
along the way while investigating the original impetus for this series.

Thanks in advance for your review!

Taylor Blau (8):
  pack-bitmap: initialize `bitmap_writer_init()` with packing_data
  pack-bitmap: drop redundant args from
    `bitmap_writer_build_type_index()`
  pack-bitmap: drop redundant args from `bitmap_writer_build()`
  pack-bitmap: drop redundant args from `bitmap_writer_finish()`
  pack-bitmap-write.c: select pseudo-merges even for small bitmaps
  t/t5333-pseudo-merge-bitmaps.sh: demonstrate empty pseudo-merge groups
  pseudo-merge.c: do not generate empty pseudo-merge commits
  pseudo-merge.c: ensure pseudo-merge groups are closed

 builtin/pack-objects.c          |  8 ++---
 midx-write.c                    | 10 +++---
 pack-bitmap-write.c             | 37 +++++++++++-----------
 pack-bitmap.h                   | 11 +++----
 pseudo-merge.c                  | 13 +++++---
 t/t5333-pseudo-merge-bitmaps.sh | 56 +++++++++++++++++++++++++++++++++
 6 files changed, 96 insertions(+), 39 deletions(-)


base-commit: 406f326d271e0bacecdb00425422c5fa3f314930
-- 
2.46.0.54.gc9a64b1d2a
