Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208802D1901
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 08:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753171962; cv=none; b=OzQl8UlvM+i8c00xK++O2vXCkSh6//fMqBk6QhgEruGSHWK8gs3ajvfDsmn4et+se2WRteaTUPpcXaNwIhTycjAOkdH4OdS9W6JhVZzPD4C4zNMh6X7KCRkgsCofoC7LMaKrdHMbtEKAaHwhMYrBwdjTlgDtxm1i6rR7X4OTpFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753171962; c=relaxed/simple;
	bh=sk0U82/3FavnFIrHJyV/o9nX3WL1xxy2dUr+aRpZzag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z1zg2tjNBZA/0gLFjxABcVIhhpPgj+mB+m9zhOVzd9TFtqtProLErAbp4TvcQydTbOTjs0ci/PEMrX30A3Uz1n4ILTJUGQ0oE4yNkaWzR/wZDJMQltulu+Qcg9Ztvpwa8IvTUpf5V47KfHIb25AOJb47uzUrL3KjeuU5pf1hSjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rg+ublQU; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rg+ublQU"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b271f3ae786so3834823a12.3
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 01:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753171960; x=1753776760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZfdG28L4t2BMprclNeK4kINg4VjJmW7A5DUE2OqEws=;
        b=Rg+ublQUP7xMsj+klPLo0JKv2/TSXDt5X9Hj4/PcQtDmmFmu705R+ILuDHCN022GDG
         Mj6sWWqd3oL4IDWY9MZv0ylYwmdKjiEqpG20OvNS5A1Cm4gfYM8zNZ6rVv1bytP7CJr/
         u4FOm603G+kdwSp3nrAO29nIGTG1eM5iybZyy6uvhdT5GamKj8SbABmWBJ4rY39nxI2F
         pfXTD+cZ8+iiQui0FHfNvhzM52ehcyyCJRP/dv2qTffMP/bDFAyJaiK/R6Szvlcx0QWO
         JG/nw73X4FletcnBF81m4aecCieVSMjOSPD9PGolUR0o2I2tzbyaPEtrAk/1/KkM7p7C
         6LNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753171960; x=1753776760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZfdG28L4t2BMprclNeK4kINg4VjJmW7A5DUE2OqEws=;
        b=UsLzVTih1WsZjES7HGX3xgdDImELSR1xQu4//yw5DF3dRtvt6u9DKmuE823wiDQQiN
         pOPp2MNDFp0SY4F5W9K1GICG37VHhF9PmcNhIxH7aWMRmfRL+Vf0IqwV8rsl/DvOiTTz
         5GkXu7yu4nOJnyYtbcEOZ6SGu9wHexacBqq/eEiSWJAMngu4WCVrtTU2mp6a7ajt0Qlj
         68XPLwpLStCmdPfWTMgjj5D/igrUSTF6rMXBzD3V+ndQxjpAXcM7fubq9yfLZUZMUht/
         J9s/IW6xBdKeogHKMQ1tz0TgzisJp1cT3/8/fr1bBzSV+fG79DNBo37n+hbkosE+3Xib
         NR3A==
X-Gm-Message-State: AOJu0Yzen9Xp6yCxLqQ1xRNcZl9XWqxaK+d9f6Te4w+YHA83CFpZIjNV
	8xPKWOAtdsy7CsJfGewxW7jV5BSLxf0ypq8pEzT275HXwbWizZ65/eSvCPaB53al
X-Gm-Gg: ASbGncshUcn8+m9vvICkT+VhaCE3T5cqxC9tFLIFFAsHcVL/N57v+shoYoIK8sQ0yw5
	cJsxwQ0ZpTwQ9mwwho4JE4E1zBruKze0mdExnf3w7e5TM6EKALdj2YuZEmO0TJazle1h3oCArmW
	c/BajLwVeMkmyLPIWaRK+SkCb+vVf8niZaqh/KqC33u5aFZQHXCQ8NezZVihgGUagVYkMf6pLhm
	19e5oWpxvYl4dnVogzJQxES8iOqs4DkFn+62dngdxiQt/dDkHDdzqq966uB+mUPBIZsJfXGHMZ3
	6fYd61TbWRNZRcQ8r3jE5bPm1UbNmrMiCrCW6ZPSsZZhQLPdC3HA734MxfGkXNm98It0c7n4wWM
	ITCRQm5WHh7xIVEf2TMUbY2W0gVXATCY+UsYC6Ku8GmDr
X-Google-Smtp-Source: AGHT+IHsoRlJ+zOcGbukNUElQaZyPbSqYcQB38ySLVlPWHlU9X/Olu7KrVOA6wjdShH7MhpWOo/YIw==
X-Received: by 2002:a17:90b:2242:b0:312:f88d:25f9 with SMTP id 98e67ed59e1d1-31c9e6e9661mr29144215a91.7.1753171960128;
        Tue, 22 Jul 2025 01:12:40 -0700 (PDT)
Received: from localhost.localdomain ([211.37.148.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f1b8f89sm11584538a91.9.2025.07.22.01.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 01:12:39 -0700 (PDT)
From: Hoyoung Lee <lhywkd22@gmail.com>
To: git@vger.kernel.org
Cc: Hoyoung Lee <lhywkd22@gmail.com>
Subject: [PATCH v2 1/4] t/helper/test-truncate: close file descriptor after truncation
Date: Tue, 22 Jul 2025 08:12:16 +0000
Message-Id: <20250722081219.1086866-2-lhywkd22@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722081219.1086866-1-lhywkd22@gmail.com>
References: <20250722081219.1086866-1-lhywkd22@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a resource leak where the file descriptor was not closed after
truncating a file in t/helper/test-truncate.c.

Signed-off-by: Hoyoung Lee <lhywkd22@gmail.com>
---
 t/helper/test-truncate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/helper/test-truncate.c b/t/helper/test-truncate.c
index 3931deaec7..104bc36cc0 100644
--- a/t/helper/test-truncate.c
+++ b/t/helper/test-truncate.c
@@ -21,5 +21,8 @@ int cmd__truncate(int argc, const char **argv)
 
 	if (ftruncate(fd, (off_t) sz) < 0)
 		die_errno("failed to truncate file");
+	
+	close(fd);
+
 	return 0;
 }
-- 
2.34.1

