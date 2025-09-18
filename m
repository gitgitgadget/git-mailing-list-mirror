Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7BA1E3DE5
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 09:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758186051; cv=none; b=iX6h0IDe8pfbTDynh8M7acDebt9NqrKQKjEhV+9vpMvwKN/4RDM+0LebRG2BIOQseCxiZIgMuysgQh6GVkMWZvfm7SvnnRvhBo1004nfTZHqCQb2nl71QJFYUyP1rIaJUsjXWZeM2uzwXrli6quc4sqJRCfhzKCZhIEbXlsKLEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758186051; c=relaxed/simple;
	bh=F86MNOXTk8q1/BBMqwfd0ZNFNecagCoEoNdZTHCSQ0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eaebCkCehqgZCuqVjaoqdIy4v4mRUSD2q/jP/5N+TgupyoVsDiPPxrbKcfqiSQWb+W1SQTHNChNDyixeFV3b1hcX9KqPVEk5sD51z+CLNqFEcpBTMIPL5QFR+0s35y1uVs0h+g9EGsNuQa1uZ0grwzfL/WkL9rNcNJrH2ra8sfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lf8UPGyQ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lf8UPGyQ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45f2f7ae386so4941375e9.3
        for <git@vger.kernel.org>; Thu, 18 Sep 2025 02:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758186047; x=1758790847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VvjRNlKynN5VWkc9kHaHZOcTnmFFkGHIyOx8fFTE4m8=;
        b=Lf8UPGyQSbG9GTZCmDpx900G0tioLek6O0jWLhapxYWfr/12vnbaM/8EKdkKw/PoWE
         b/lk/UE1X035hKMa8UFOKUWlcesUVAE+3J7yvIMBY7h8fk+TpNyom0+29G1OYle/ZeTY
         uzFuvu3+/6kw6tY8w6VbkTLSI/+5h1+LdpVo5g34JhmjDTR4x6GpgVFekQd8mxANhLFh
         2Cz/hd97q39NAGfStdS9to0hNwFfVYsyyvkmi9G25rePOoGx3LvItAGyKOs2g1zPTQoz
         o2nnsXosFIQ/Q7V7nfmA6QzQCqNKbEcKIbFjHYt2UQ1egliH+/vC0zPR+LSsGSEpwUma
         9WYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758186047; x=1758790847;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvjRNlKynN5VWkc9kHaHZOcTnmFFkGHIyOx8fFTE4m8=;
        b=R2EOFCATKtOTqZzLgHSxW/q6zCzCHv5qz+8xfKGkxZS4yaX1a98eo17WUOUGJK3zqe
         +Khb8bfOH6x3viu3KErtkTdiEaeEOGoyPreTvrFvFX4PPijbx6tbVkL12q/o/mmXcBGg
         iUFHRW+V3uL9eeBwFKFyLLv3d8C4KtuQAAlrC1/vdptyTba6UqKrsLDfPEZZ+pFHg7pY
         PisGHTdGBbAVy/gh6X3sRy6jHxc6nlR0ucBS3a4Wm257sYPkJr0CBDTr7HgHelPqtE7O
         tOdViIbAZLWL1bsvyaR72aYueo+2gB7bKcOzFlDNngzhkHmXm+ASwkQyrPrUZ73C6OpT
         AJcA==
X-Gm-Message-State: AOJu0YzB1tkiW57fLA+3H44n3nAo1X3XlpBgxB7Dno8r3Yi0z0tJVlvf
	APlaRAq/KHtTfhRB2ygdChFi5NrUEG20I+B3vtk6nAmnjHcCHswoMdIU44LV0A==
X-Gm-Gg: ASbGncvXFl11JI9Lpef6+YLHjCzRPzwuufft6ehPKE90xXjVip9Wl/jR3QULlGuoXB5
	akOQePw5DYVIMYna0OAFRdp4bA2hizgoVr82WskgMqMpzidzf6ARlIR6FYrWm5bpu6x2IMqIoaf
	X62disb04Jqy4YSsEcgVMClkeiqmE7BpUJGuu8fVEpkfmJjRt5zkG82E3pZNcEoKwhy/cjfi6/S
	uH9r51y06JTtePtSXhwmR3AWf8LmMnpJw7RUuWpUN244Vx7c+P6QiP0kszRZ7ViHp3Vy/ehGBfg
	iv74FVggVOxy7Xpekmg7E5yW/5k9UpNUEDGSMAgLvS1Xr6lSRsYwaAXUNWHJl90vL7On996Djy4
	5VpMy/mmcJ2mYyIgyGe6FtkSHQkbpZi4MHDfShnjFBZH0opScnHSrQpw=
X-Google-Smtp-Source: AGHT+IEeaMgMAUey+T5zUGY1s8C1lSJ9bu7gerl8L40ZS1RciOrNB4Vo6BRUy92HuSWxeHfbyiS+NQ==
X-Received: by 2002:a05:600c:450f:b0:45d:d8d6:7fcc with SMTP id 5b1f17b1804b1-46206a2b929mr44171365e9.27.1758186047373;
        Thu, 18 Sep 2025 02:00:47 -0700 (PDT)
Received: from berwick ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7284sm2703082f8f.33.2025.09.18.02.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 02:00:46 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Simon Cheng <cyqsimon@gmail.com>
Subject: [PATCH 0/2] rebase -i: respect commit.cleanup when picking fixups
Date: Thu, 18 Sep 2025 10:00:37 +0100
Message-ID: <cover.1758186038.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.51.0.595.g259a2096d9c
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This series fixes a recent bug report[2] where "git rebase
--autosquash" left comments in the commit message when squashing fixup
commits. The first patch fixes the bug and the second removes some
code that becomes unused after the changes in the first patch. Thanks
to Simon for reporting this.

[1] <CA+itcS3DxbgpFy2aPRvHQvTAYE=dU0kfeDdidVwWLU=rBAWR4w@mail.gmail.com>

Base-Commit: 92c87bdc406e5bcf1b516a861d609b03d99c23b7
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Frebase-commit-msg-cleanup%2Fv1
View-Changes-At: https://github.com/phillipwood/git/compare/92c87bdc4...9c7f4e39c
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/rebase-commit-msg-cleanup/v1


Phillip Wood (2):
  rebase -i: respect commit.cleanup when picking fixups
  sequencer: remove VERBATIM_MSG flag

 sequencer.c                  | 12 ------------
 t/t3415-rebase-autosquash.sh | 28 ++++++++++++++++++++++------
 2 files changed, 22 insertions(+), 18 deletions(-)

-- 
2.51.0.595.g259a2096d9c

