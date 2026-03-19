Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308A32D97AA
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 03:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773891414; cv=none; b=WEX3kEv2nJl9Efy4rP/Y34TCasGuaER/JNwytE3JCA0luU7NcDColtSSe+sQP8XGmii6OLTVo+tHlrT+4vaBsdQWC9OLfHtiQhQP+D1BE/rBc6zfaXM6KXCs6K3pktZAOD7wBQcYHikS+rPTzD/qmuN/oyk7nKdMamENIO/jgeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773891414; c=relaxed/simple;
	bh=++IJ4XRX8SJkPv9gBR2NsLOSSMz8Zjx3E3JSW5M+oCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uBsVVI4Fw6S0kpVu/FtnD43Tal9HsKiKVFtQoUhOCDwyioGV6WFyZL1nN5rw58yHI03ID2jL+rCTFgbvvmA41g3DctEzFIsjM2x/3HEtCjkH34/o90q2j3s9fpqChLROTLWG5ToNV+c16c4KiKmwKZAAueVZR6+YH8SYLV1X47k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHN0TUT0; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHN0TUT0"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82a124f3a5bso136021b3a.0
        for <git@vger.kernel.org>; Wed, 18 Mar 2026 20:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773891412; x=1774496212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFg9v14oIvbm81pokf6HZHDkqazL45Ywq7jX2D9k/zI=;
        b=QHN0TUT0Gm5aa2/vnE2c82OzVMVKdcl/V9zKCm/Yb0gm0Xve82txy/bu6+sX18EJkH
         l5k7ZXIuRK5gu+34OStvUVVsxoOtsq+tbwm0K/O1kV2kSQsmrS0+EJkaO2LLnsJsQLBT
         bSCuHeRDRn1r1bQ29ebUaBt4M4BX20jiaMqGNWONRlBGcdEp6ysOCZSxvDfiEg6JDyZu
         eDshpAqkzc+QA521gjeAWCRUOAyX4HouT+/UOnv8B3kjsHcIqLaoZpxIqalCY1vhTGr3
         tPuHV0OXOBlXVuBaOA/MHeKtf5S/+xquHwQ9Tiyq2QohgtXqHyUKLDQiuknpJvArHIsP
         cj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773891412; x=1774496212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tFg9v14oIvbm81pokf6HZHDkqazL45Ywq7jX2D9k/zI=;
        b=U0M1kUW/V/I+C2wW+LaNdlUdvsJUjGodDQVpvJg46cDIh/ClPLm/r6Hzc8nORQG7/4
         MKjbH36s4lkMwhjXpBJq21oBYK6dYq5XUMbC2ImouDH7i5ma2pX+Oa0Zq4gGFhIY7zBQ
         e5JkHINn9U/xNOqW+CS8WC0PGJWC+ehpq+Mr25hc+9eY57CwEp+OruftxwYsCwpBm8L7
         Glu1zAvJoAxwB8oDeOvTpnpmwUUbQDM0TgDtAO/cCpCjwluk1gdDEOcLJps5HgR5j2rt
         SwMIeDsiXRiHmAULZYuJBpJzgh1Kk6jR+0u0hbPTxTu/cD8Y8MFfHqOQpZxVlTsYt7Jf
         cwBA==
X-Gm-Message-State: AOJu0YxZmZ2wKq2snA/QAplYCc+Ee7gAqzpe4AoOfua9FWCpff3T+Gwe
	FoFp/k5H8nwzh4/jsgt6kM5j9Q3VXIkNAvg3UXgbeuZnOnvkHvewdrHxpJzA4/g8
X-Gm-Gg: ATEYQzwZjw6JJk+WzJ6epy8fQbCNXzXRYhrL4H8wovicuLsDarZx7XfRU+/YZzNe3+i
	0wj6q6pqO7wqC92abSsn2ufy94bjkvUjU/TN9HDJuff4c0IXWse/wErR01Sy9k+lMy85cxkcqRF
	3WuEhxoyVJA6/Gi5hMChgPgagP1uncN7A4CyS7Woy9dvotJD6MrzxvGvicIn+Fu/uVfbOjXCHG1
	DFv+7kS4aXrYaB6QZwaHuekmya1OL9xjmX1fDiTisjC8n3h5xZezFjaowOFSEsMDQctHRd78fZm
	kuxaTuoMJW6VleAIHqGtUPlB0LU0FlfCgqXQExz2mmuUDJGsgeIEkXQwrG8wsu1k7spQFE8FXyv
	xYrKFjDo7qf4ciNetixA99HQ0C3yTj2KOnt1NqQUy0qshBY7++Gg44S2dcHOUdCRHaMA0eqhVLS
	ibbxi0juwty2sa2U3LHUgao38dIfYjM1fWGeOurLZtcC4BYwE7gr363W/v4/sFygiebQFx/eF6d
	yr35KEH0J9igNasu1u7leElFH/pPr/j5kC6/PNlH/ML
X-Received: by 2002:a05:6a00:9099:b0:827:455b:86b1 with SMTP id d2e1a72fcca58-82a6aee1853mr4916580b3a.28.1773891412426;
        Wed, 18 Mar 2026 20:36:52 -0700 (PDT)
Received: from jayatheerth ([2409:40f0:1020:5ca3:6737:ef9c:4476:1d9d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbb522asm4336780b3a.37.2026.03.18.20.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 20:36:52 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jerrywang183@yahoo.com
Cc: git@vger.kernel.org
Subject: Re: [PATCH v6 0/6] repo info: add category/path keys and --path-format
Date: Thu, 19 Mar 2026 09:06:41 +0530
Message-ID: <20260319033641.38458-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318204438.40075-1-jerrywang183@yahoo.com>
References: <20260318204438.40075-1-jerrywang183@yahoo.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> While reading the current `git repo info` implementation, I noticed that
> `layout.bare` is still implemented via `is_bare_repository()` in
> `builtin/repo.c`.
>
> At first I thought this might be a small repository-awareness cleanup,
> since the `repo info` field callbacks already receive a `struct
> repository *`. But after tracing it further, it seems the current
> `is_bare_repository()` semantics are not equivalent to simply checking
> whether `repo_get_work_tree(repo)` is NULL.

Hmph, this was an idea I explored few days ago
But I do agree the repo->worktree == NULL method has multiple flaws

For example

test_expect_success 'layout.bare is false even when run from inside .git' '
	git init nonbare-dot-git &&
	echo "layout.bare=false" >expect &&

	git -C nonbare-dot-git/.git repo info layout.bare >actual &&
	test_cmp expect actual
'

I cooked up a test like this and it failed
I have since been exploring config.c and parse.c.
specifically the if repo_config_get_bool()

I think there are few other checks we need to do on top of
repo->worktree to be completely sure that the given repo is in fact bare.
Also instead of using repo->worktree I think we can use repo_get_work_tree(repo)
Why recreate the logic when we have a getter ;)

I am convinced that we need a helper
repo_is_bare is a good name too.

Thanks for exploring this :)

Regards,
- Jayatheerth
