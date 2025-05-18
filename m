Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CB272639
	for <git@vger.kernel.org>; Sun, 18 May 2025 07:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747554213; cv=none; b=S546W915pfHRfs+KQaM918Fn/3txA7SdI1+hGUsTVwT3e4AIoDo7jQ7IYFg7m8KCx5EFxVKz3ivxBaoeLLAmCjCKsnTPyTmbvzDYMdcelzPkaFGrCA2/AKYUH5eUq4bvtQ3JtclUYzTriSMWAi1YTPnfWrdaqlar56SKoCg8vmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747554213; c=relaxed/simple;
	bh=ZlYBiLF5i6IQSEBvePfdvhhc5ZlcBHzCUCy2y4qZrk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q3oiTZ6AV6dXavtoviTmX8TS7hRCwQVzl1Lbk9qE6nsVO2vsSSt9SMRcviyRuYfo4PGPohBLAVxGdxkKv728Bs2/p8o6swGhrIwS9/IAbZtb7iGmiDaDswzh/zQ+Ax3Qhl0VffALqEGw3Wpgneb0tpmVNNIdrzBIG4a81+Es+A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYEy1P/1; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYEy1P/1"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b074d908e56so2141140a12.2
        for <git@vger.kernel.org>; Sun, 18 May 2025 00:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747554211; x=1748159011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ElxwHECmMhJf7y+DUrpk2gmbGEMKklDzMDV5M57jHqI=;
        b=HYEy1P/182JsVqy+F/L60sK8KU6bwdwUOFrsvLe8dr52ZsH8QbmdZsz3FUj5ylHlZ4
         rKjfCNpNdOAxnefRZyGLF1mAqVP+QGdJbVgUOwe/6BvlzZd2aN8hGbBhIGX5C437mpV9
         /xvITelaSGr6pw3UnmzofsF/kB3ZpDfJ4y0iMbG6N7RCRq2WT3r3o8I49umpRNCkGzNc
         T3AVXHCrAMQC+GhOW8oJIi3lbzY10LSzOhgSoICGr3sWZW4yxhso1pcYD99G/PyFVcOs
         fRFw8oB2gjoMnUuU4vvkSv34qO956Rdn68Hc9LPCEahH5Xvt2xuP8DTwU5DIKeW8N6X1
         IGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747554211; x=1748159011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ElxwHECmMhJf7y+DUrpk2gmbGEMKklDzMDV5M57jHqI=;
        b=HmqslsrtzmZ0l5EvDbU5A9R6VIxQfXVZtUXCj71JYQCVGUCya97/j0/5ltfL/xLmGa
         yDAOCN/tpdNrgk0GBEz93GwG9gIs9wxGav7vRmjvX8+yePvmeZfF+wYfiXnz6mzDJei5
         7nqCrH00NNsRHoQVYQ7sLrjVf7K7F1pUNxz9rEqo+IuBoAUwvR4uzzI3YMtjAVUY3twE
         8Vv8GffM5NpNZ2JflVbxlSwWTokg1r5kyoUVV/18W7vHYE8nhRIig7z/QhOCirgVnO+k
         arfde4wfNNAZ99iwKgRbnbqt854xD0RWQ/RSgIMQpTD25l8blSiB2RmqmZQNJt0dGo82
         QjVg==
X-Gm-Message-State: AOJu0Yz0POTBMHrpH1kV7gveiYCovAScyxlJA7aPP66Tge0tcPM+ynVk
	8zUqHzmfnysyalyYYb1C4smpL82c8yGozmWl1rHbsXeIO5Ll/dXyO0dOKQlHzdC6
X-Gm-Gg: ASbGncuDvPqQwGf8KGryawERdo8196rz8uzMvWNvG5vX3nT67tgoAaDft/TR2wJaGrU
	ozsFlHFYeB5VT+xWn2/1jMhglTjGMfX9fDrnrs/Nu18wTnWXOCInXR4bO4Q+x865FsxHDORm3au
	sJNkPQLm0cjjadAtzRKgWRGLiAwNOKpvbHdg2prVpcqoKuLxCaUjITJ3QD58Md+lC4PJ8D1gC4/
	LEnQymxPb0Pfr623l0bxYef3yQ9LK1ZRJuebVv+EUnaW/BA7ZTnjBsLfJLsOZhbPQ6fMJ85B9hb
	5PL9VZQ51z868wWcEYixj215FS7anAOYpslbLNr3p2TMJcHM6Nid0JMi+q4twULlGIY=
X-Google-Smtp-Source: AGHT+IEhyuuoFFRez8lEB0ilGNT9/2wI+hmUIPGIfrLBEwig6ny7AugTU2Ay1UWA/Uccx19OIw0j0Q==
X-Received: by 2002:a17:903:41ce:b0:223:4d5e:789d with SMTP id d9443c01a7336-231de31207cmr115422385ad.19.1747554210972;
        Sun, 18 May 2025 00:43:30 -0700 (PDT)
Received: from fedora.. ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ac9fbdsm40131625ad.50.2025.05.18.00.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 00:43:30 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	jayatheerthkulkarni2005@gmail.com,
	nasamuffin@google.com
Subject: [PATCH v4 0/3] Update MyFirstContribution.adoc to follow modern practices
Date: Sun, 18 May 2025 13:13:14 +0530
Message-ID: <20250518074317.73367-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes are made to MyFirstContribution.adoc 
to make the tutorial follow modern git practices.

The tutorial codes actually help newbies like myself to actually know what is going on 
in the source code as the Git source code is vast.

Therefore these patches.

K Jayatheerth (3):
  docs: remove unused mentoring mailing list reference
  docs: clarify cmd_psuh signature and explain UNUSED macro
  docs: replace git_config to repo_config

 Documentation/MyFirstContribution.adoc | 55 +++++++++++++++-----------
 1 file changed, 33 insertions(+), 22 deletions(-)

-- 
2.49.GIT

