Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D10638D687
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 13:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773410127; cv=none; b=Lvy2yTjZblArYI8Jb5E5ElhuFUJpRamaKXiw2Rc+ZSWBV6NKTHUHhdJ0F3TLnM1aqq39nXBdqC7aKlX37HN3yDGQoug5nwz7rp/YqyDTSIy8wP//NSiaXATp5cAP8WdjX7lhZgjY9ZppPqhgURaMQ/ffBkYjKV+FnB4pD6XwI9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773410127; c=relaxed/simple;
	bh=1ye0M7jy2GqNtgx9jg08vk2zsOEBLJ6Dwt9XzS8+SJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qLS87cVxEd+cpgGfyCunYIc3cwzcAc6RV/P7mRCc3O2fMX0fZ1mzj9GLrWXplAYyZNt8F+0yvusvKZwmd8mU065URGlYmascjXOPuwyXkQNAomFcdKyb2L2qRCoByIgB7Befq3hfwvtoeX9szDnio3d/i4MJ4FTEvSe+L0+w/cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/Ce9E4f; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/Ce9E4f"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8297e0b27e5so1384413b3a.1
        for <git@vger.kernel.org>; Fri, 13 Mar 2026 06:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773410123; x=1774014923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ngz8VvOSsajozeAmVbPtHTBA6R7Ie45SRRI/oudwuAA=;
        b=a/Ce9E4fzHwqJTegA2FfwPvr5pVH2RY/SUh5hSXUKqOoy/8sPUHbEAUowK9vU8dCGh
         HCuk9ctvGwaxeEeCzCy2+zRA2iZLUjBUmC5Bfk3ySozFwKlCBluOZsSaigZoC2wq80Qm
         XcA2vdRLgW/f0jHVgNo7bkAziEEGAxR6dnbP5PCn2PMk+rgPa02ByLQAizwwGkSRU8HR
         oy+0LMYf2lTOQYIuOOhI+lDk6KzpekZYDSZJL7sS88EWFugQ+bCuNZUamzQkPDptOQYO
         yMYGvV0KhhlV2tGq6Q4ajtzhywn4HmxxJzArL4sYoI62++BlhU86SK1o+XEwz5i7K9N4
         VEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773410123; x=1774014923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ngz8VvOSsajozeAmVbPtHTBA6R7Ie45SRRI/oudwuAA=;
        b=qKCFO7qjDNpbSHFTcdkAo70ot4HZTuYfNrmi8qX7ds1UqphQbTbvQ+JxIzCTv1K/Ps
         /IRuR6h+tTIZaZTZUeUpbmu3oI3A2TRGR/jq6PJgQ35gCJh97b5suLDCldCnFmaBK1wi
         aeCb4vI2qxfqGQctGbWCKBXHQ3iv/IeI8O69LmyHPdwU6mg8BhUqgluy7GMGL1fD/df4
         ROZ303N4A+Pp1gre3pKMSx+B05OP6l5KY2VC0FJ49/XAwSH7c/LJySfOghMiltnDd5ZX
         l00PMEHz9/f77TEP1o/6u6KJEFSR9/BCD9TOKrinXKAsQUoDfgoflYLlUHcO0Vr3ymCD
         JAqw==
X-Gm-Message-State: AOJu0Yyb0R3rYi2dVR7w26+0F+L6aFpeykA9zZWCwmko2N6x4kcvZ7CG
	9GM3wVXZJ+5rrn6K8Z0QHRnEtZ03PHZEC95wGR4jtLwm09tGUhYdifTrBz0TJ9bV
X-Gm-Gg: ATEYQzw3Jw/I+zpNBtiVTW2InSrIoyTRrfD/qcbjNZn0WRG8IBaxumRGe5N1+2l+nsu
	hDiBWn6DiaMzi00MIiAHqLQ/rkiFXTnKgPf/aazGlY4cp6dncIdyoBpUfrFGUMFKzJkkwaKVPE9
	LUFoUqI5PYND4bN0jTIWO11pkRTBCAxcGixzt4dtgRgjaqzoc085u2NRlVlUw1Syx3XPiX3D6Im
	+mvkQm4xmX5QEhj5RIk2cDMjf5TzHQ272xVLsEpx7NOjoJ84cH0IBAmRrAPJHq2EG5CK8ca/iSf
	mGTj9oTa1qtMO6InHBCYLIfB4YCRRUjRWZSkrvkB1HANar8OuDsTvh96xIoltrbg5NzX4C18zr9
	fxOQmJokhG1KLYQNgzTg6ZhXnP3r5RuwtHCt9OMRzmqOaEz46kqknrB2A0ALujJnRWRFvw68SDq
	ZruxQO74HISOtrv6BMNasW+U5iAByxVNPmyQzIycZC
X-Received: by 2002:aa7:9069:0:b0:829:8041:83f with SMTP id d2e1a72fcca58-82a196d1051mr2981235b3a.7.1773410122875;
        Fri, 13 Mar 2026 06:55:22 -0700 (PDT)
Received: from divineocn ([45.127.227.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07244071sm6242465b3a.6.2026.03.13.06.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 06:55:22 -0700 (PDT)
From: aum2357 <ahambrahmasmi2357@gmail.com>
To: git@vger.kernel.org
Cc: aum2357 <ahambrahmasmi2357@gmail.com>
Subject: [PATCH] Signed-off-by: aum2357 <ahambrahmasmi2357@gmail.com>
Date: Fri, 13 Mar 2026 19:25:31 +0530
Message-ID: <20260313135531.563135-1-ahambrahmasmi2357@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff: use conventional comparison order

Replace `0 <= addremove_explicit` with `addremove_explicit >= 0`
to follow the common coding style where variables appear on the
left side of comparisons.
---
 builtin/add.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/add.c b/builtin/add.c
index 0ee21692c2..ad0d6047af 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -432,7 +432,7 @@ int cmd_add(int argc,
 	argc--;
 	argv++;
 
-	if (0 <= addremove_explicit)
+	if ( addremove_explicit >= 0 )
 		addremove = addremove_explicit;
 	else if (take_worktree_changes && ADDREMOVE_DEFAULT)
 		addremove = 0; /* "-u" was given but not "-A" */
-- 
2.53.0

