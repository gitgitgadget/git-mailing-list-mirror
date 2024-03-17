Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC9C134A9
	for <git@vger.kernel.org>; Sun, 17 Mar 2024 08:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710664076; cv=none; b=RaCCD9WoldqjCeYw+eXXuJAzno4pcWXrggENWbsLMl2sfBp+ZytbmZxuwkkxgEt/NMnl5ukI6mcgbetJ9YKX7eHTaXE6a+H/s8HfEfi3edbswMN4MIS1zujkT6F5ZOK5W4LX3dkKr4ZfWzoBhv/iGpLgAnT/yWtCjrHcdxLS8uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710664076; c=relaxed/simple;
	bh=c23b/upy7uBCO13+GRkVcv5Qk76W7T4nMN+hnnLlgrQ=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=GKqhx9z2zTs/taGUoRRLWlSuj4M32JFAVrY8/we48TbMHrNu46/T5iHoabe1MQnGcqXiu28dQHUYlUwXHbXyLQYN3lrfhgd0B6sJEnD1RNVrSQ9kMZ9Aps0knAgYoTLM5L0IMNh3IUpEITe0MMffnORJUjcJAGSXmtT44QNQUK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wim2wtYI; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wim2wtYI"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41409c8edb6so4931515e9.0
        for <git@vger.kernel.org>; Sun, 17 Mar 2024 01:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710664072; x=1711268872; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3PkFw1TkptaGZGYGXIbqZ1Emdy5RlDFNp6fNIboGwnM=;
        b=Wim2wtYI22jexa0Ztx+/t+uq8oLSQ6gAVpB76Y6TfefFYGIGWbC6TH/3JBrnsO55Al
         tE+kfJYz39ltpkrtdo96fd16Ah9QnTgJWz5Ov8UUGzuxk1Aj1WmXTrPYKCmhaXCPhkui
         sqaDoSsIJvSg+uaFn8w5l6Yax4dqOt80conCVcIcBQbhsWAs+QGhR7pgvNkw68wGDdrK
         PG78p7K7w/il9eH02LJvC/fKy2h4ZhGTlFuSNmGFelFMHy7ufM3Nc/E643YPBMjpT0yD
         kyrTelDK7s5B5uxtUMiEWI5UXWAMS98H0DiD6ujf05IRDejNBDq+pZoRsNHDp2Geg5AQ
         OhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710664072; x=1711268872;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3PkFw1TkptaGZGYGXIbqZ1Emdy5RlDFNp6fNIboGwnM=;
        b=i9x4Xoy+zG7C81dgU5JvWayWR6Szu/gIhTEkxz3DuUfJE8781Pgei2Kux+ffsEJ6FH
         5soVD+fax6jOqA3I7zk5oK2y1rcNzFgOhQpPy3oZtlPGS6P5qg8WxKETOBgcLD4yaw4V
         /PdSTSkSi0eRqZuziobtcB2krCOBmg3pR8zZoqfTrAxKoS3ysCbHsJasZ8av+LcMA0ZC
         Vsi5OWf2DENkh+N0MslW+aIgVCmyBJZS+Iaz1rfw3E4IOufB9bL7hzJhBTeQ6bBMulZU
         8tExUir/VVpEZfqJXnxi6pK0uAc8GdM1r4VIVYm4QY5miguESIn8361RySaQyyEFOZBP
         DrZg==
X-Gm-Message-State: AOJu0YxPQazGoBT7AWyrYtwLBzsHsY+CpX+aOXbZ0TWSx4zUzQIiQfpe
	LGs0eYyuw1RkunH3clwoDzTP1+Wvqo8Z8qJRHCIBepOlok1DJvN4N1VfSG6x
X-Google-Smtp-Source: AGHT+IGUKgcVpg8F3FCdNs2lYvSbdfX9KfUf6fg6DtyZ3et7UGOgsgU/FwDkw3EQdLgsLVhsG2V9Og==
X-Received: by 2002:a05:600c:3c86:b0:414:286:fd1f with SMTP id bg6-20020a05600c3c8600b004140286fd1fmr3434136wmb.11.1710664072161;
        Sun, 17 Mar 2024 01:27:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v15-20020a05600c470f00b004128fa77216sm14402439wmo.1.2024.03.17.01.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 01:27:51 -0700 (PDT)
Message-ID: <pull.1690.git.1710664071.gitgitgadget@gmail.com>
From: "Mohit Marathe via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 17 Mar 2024 08:27:49 +0000
Subject: [PATCH 0/2] utf8: change return type of some helpers from int to size_t
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
Cc: Mohit Marathe <mohitmarathe@proton.me>

Hello,

There are lot of places in the codebase where int is used to store size of
an object instead of size_t (which is better alternative due to reasons like
portability, readability, etc). This patch series accomplishes one such
#TODO comment, which addresses this issue.

I appreciate your review and feedback on this patch series.

Best regards, Mohit Marathe

Mohit Marathe (2):
  utf8: change type from int to size_t
  utf8: make utf8_strnwidth & utf8_strwidth return size_t instead of int

 builtin/blame.c    |  6 +++---
 builtin/branch.c   |  2 +-
 builtin/fetch.c    |  2 +-
 builtin/worktree.c |  4 ++--
 column.c           |  2 +-
 diff.c             |  8 +++++---
 gettext.c          |  2 +-
 gettext.h          |  2 +-
 pretty.c           |  4 ++--
 utf8.c             | 14 +++++---------
 utf8.h             |  4 ++--
 wt-status.c        |  4 ++--
 12 files changed, 26 insertions(+), 28 deletions(-)


base-commit: 2953d95d402b6bff1a59c4712f4d46f1b9ea137f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1690%2Fmohit-marathe%2Fint-to-size_t-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1690/mohit-marathe/int-to-size_t-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1690
-- 
gitgitgadget
