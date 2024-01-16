Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F8A1D694
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 19:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705431825; cv=none; b=VeLL+UkzQmgiBxPDeFE8Lm6e9KOBINlIDs3ENPwpQFthYw6kIK1t+9qr8ut6+1vr6XCqakjXYnqzm3HFvbZnSmNVe4dUr2d4ABhxh58ML/Yg+Z4fmyKhp4qH7n+CeF8dPfBLC9PRXFriTJSFWDmZNNWvXWISfcv7Kz9QdKxff2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705431825; c=relaxed/simple;
	bh=Xc0tTbnmr2nOAUh8cRLwOIn7QO6m00rTgJTtLt37Wqo=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QsdTcF4ZgY8Z8+5SUF6DUPJHlOZwxq48UX0MqG6RGUGvO+rqgKp+01ONlXuUSUoxw72iluQ1p+VUfqh93mmqqolvISVQauGAeD7y9dPtpYjFa0S1j6B6t28b85eWyIeCX3WT+GJCoCcUCi1q7w2n1t7xhTjgb90xD5x4C8t5e28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=j+kxNHrL; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="j+kxNHrL"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-783148737d5so907445485a.2
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 11:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1705431822; x=1706036622; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KY6FoOWiZUfoOBIsJbmiO4m18ALiX7r6hVI7mg8zf0w=;
        b=j+kxNHrLA0su6unX7HtDfNCzz2ihQTk0nvSroMNvga/ZAnTNqVqQ8fyarCg4a+aCFp
         Pr7OKmVmWEmA/IH7wmXwSum+PPUm0ESH6vI+ZW7slBNdTqtOeuY9ap5dLNlI75QY2Int
         oHz+7QR/RDvdZIhzDNDyVelQvHr/idn5EL5N99ffLz60QfZX1LNLkGdHdr/xC5YA6ruJ
         and+560rWQtpgsVw/dTMdH/NNzqCJzFnc3A/pPiItCK4LJOrNIRNlOQ4ky7P9nnSmLE3
         Ah7BbYKFGSVDZK6LN1ouB3kWJteyrTGGPQ3cu25NemQBfaaTMwTqo0B64uNdIZIj6uvC
         F12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705431822; x=1706036622;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KY6FoOWiZUfoOBIsJbmiO4m18ALiX7r6hVI7mg8zf0w=;
        b=gKhtuK66Mt1whYjTK64+qWstXOR3ke3hSSRQJ81uC9qmjHSJPLpbN1tMJTKrGgk3cQ
         JsVF9zkaTUEIZVD/pKnUggeb/N3FyU3/qhdJBUj7Pl2yDfJQq3euQXk/NI/O1QFaPX3T
         +LIMUMpuv9Iy6zIegMBSrIJ3Tv7X5mQp5uahr5RvvQ6D0zzx4rDco3S3suieqhvhCKoN
         ngDpe73C060WZ/qlvdT9iRVkTaeinTsowZpsEbJK81YyM22XsMpga/1g5VJw1fEjSQoo
         RwawI+t1iOZIsEcOSLgHngALqmr7047xye3UB8IeQXO65lEpwzriUUWfDpiuNn9JEB+k
         aKNw==
X-Gm-Message-State: AOJu0Yxos5tVcEhd/7npFkaBvXgghctnt+3J65uiQltiTDx+TOTgRHVU
	lv/kHCqbRtP+3PlLSCEfjvaoSwLA5xO1onNHud0Q+zQW4QioAw==
X-Google-Smtp-Source: AGHT+IHEAAauyyQuz/b2xoFhXReXYytH8jTAbF9PDzWu8cSbKvoz/JYizVEA9w2fN98njOoRUKPBVA==
X-Received: by 2002:a05:6214:1d0e:b0:681:115b:754a with SMTP id e14-20020a0562141d0e00b00681115b754amr9703926qvd.53.1705431822466;
        Tue, 16 Jan 2024 11:03:42 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i12-20020a056214030c00b0067f812c4a58sm4341567qvu.60.2024.01.16.11.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 11:03:42 -0800 (PST)
Date: Tue, 16 Jan 2024 14:03:41 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] pack-objects: enable multi-pack reuse via
 feature.experimental
Message-ID: <cover.1705431816.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This short series teaches pack-objects to perform multi-pack reuse by
way of the feature.experimental configuration. The hope is that this
will expose this new feature to more users who might not otherwise be
aware of lesser-known configuration options for pack-objects's
internals.

Thanks in advance for your review!

Taylor Blau (2):
  t5332-multi-pack-reuse.sh: extract pack-objects helper functions
  pack-objects: enable multi-pack reuse via `feature.experimental`

 Documentation/config/feature.txt |  3 ++
 builtin/pack-objects.c           |  2 +
 repo-settings.c                  |  1 +
 repository.h                     |  1 +
 t/t5332-multi-pack-reuse.sh      | 84 ++++++++++++++++----------------
 5 files changed, 50 insertions(+), 41 deletions(-)


base-commit: d4dbce1db5cd227a57074bcfc7ec9f0655961bba
-- 
2.43.0.334.gd4dbce1db5.dirty
