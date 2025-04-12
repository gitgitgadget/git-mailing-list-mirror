Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE001E480
	for <git@vger.kernel.org>; Sat, 12 Apr 2025 18:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744481737; cv=none; b=R3SVstqTwc+5mgnHkjFFxch9O9SDCyd9cofrnA92D0T4TTE6Z9EB7dBZ7W3B0wClAZ6opRCmLck7SKloZdOR0CKARY83yhEWQaUzmVc54CVFITu8JyoBZmg835IkeCHZzf66XK3C4/I7J/RJQ8HVlv3qr/itkUUHsqSN8E2ipEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744481737; c=relaxed/simple;
	bh=MaDSQNFhOHf5WUO57RIGMNBip9ppT2IrweiISbtkEhE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cBb+k1OA7UL5wccTbZVG5BCuqGDUg90R0llGnw/rArQJWkuOEP1yNYg2TCgiWIhkiThiSwfQUENW0wo+cIuuL5T8sXEqO3aYAiEKXqCMspDvWX7lqajt4xkqjmbvjyEW60w6ttNdzeNv79AMMhznST1+ex60He41YCit1m7TQVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DajZ7HRQ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DajZ7HRQ"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so32924635e9.2
        for <git@vger.kernel.org>; Sat, 12 Apr 2025 11:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744481734; x=1745086534; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqm1mNEcL8qhbAM/W5GdiLPG4I6D9aGha77GAFvgNhE=;
        b=DajZ7HRQNFyfy49L+zZMgGXca6uQ8GXffN4fYgskDhPFukJOBc3qlSp72RhGTcWoEs
         jel0lICwPCW1otUyV15O1FFKMjDysRgCWWtjvh7hBJiwBGd1Io0hezqRiEVFwhjoZ/0k
         Ta4vthHmq3nja1c1NeIEFQ4v3s3AlUkDq2UjJjzSnKSb0AY2zJFDenc04O1PSTOitcZ5
         3Py8gsQglWD2TSmOnGRNA3ChKXmGWx8Fn2HpOu6WhcueJIWumbyjbrknxDcyW4jL0auz
         IO9NC94nO88jiHOjQJcPXqoOHm9dE6oL91tl1SoRNV6ZhYh9D5S22GNR3NG2+EST3Doc
         1bUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744481734; x=1745086534;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oqm1mNEcL8qhbAM/W5GdiLPG4I6D9aGha77GAFvgNhE=;
        b=Xxv04+e6gZW8RAmyBDpTy3LUDS4W4xJHbNpXGa3G2h9VoLWXiREgIW0Y7WkF/DPpPD
         Zyb1JcG7haGgSFS1laNTP4ezmeR92VYj0RbioScNDMyDqVDj8A//XY6rQdOFhWU5eYxw
         OWyaYigiYm5eQVNy1dTUmsMSzs7dpXePYX3Pjq06JyEvjkR1T4o3hHJv+yEPb/c0wTRe
         C6l7PxwRACNOuEmeJXkfwgGPC+dbPNrNo2MO4R4zlrzA0yxoyxNwrjJkSKbqU0bkq2nn
         gMhYvytjydi5VJLOJtfOk6q4aJBh1ojB9KrxPWir1+GWknwWeDgnc75UEC2/VH/p7sRO
         BE3A==
X-Gm-Message-State: AOJu0Yzr9WI25Z7ouaWVHPLf6qIroKa8ciwyMJvS+GAlLocALI7mSMAn
	u108hE2MA9FO2Q8mjmu2fqY5r3vSQdu03RfKaE8XSroi/CgEdbr0gur7ZQ==
X-Gm-Gg: ASbGncvgkLAGfCkYuz0UbKG8gr0NpQVXxO5sepAiKB6ahxn1FtY3mX/FwEWXiD9zhbu
	3v5xhuKdTKF0rck4iy8u0yCutdb4DUW7FX6o0MsvzHE9lKSx30WhRlmWU10GkQveTJfUvyN68HO
	SJ+OCuVBQkTril2QjnBABCCWZWb7AMlWAwtx6/xTPstsiCrvHR5/MJThu/xMWM//s6rNGWwTZLV
	/FlLAFokWSWBkVHV5+/DRNG/a3oSgyOlqyxtEoA15DSBRrVh/zxqByAFdu+CeINj2lpXhEprnrN
	HA49sl3yGpDcvRaYv6AX+RvuXXoutY0SI6JEvQ2a3yotEKIAX4CM
X-Google-Smtp-Source: AGHT+IGVl3Y2PaYJ3mrYSBk+1QOLPiYF89PmGQJwNruCHGTHlC0VUAvUAlgcJ/z+CatW51xhgF/Cxw==
X-Received: by 2002:a5d:584a:0:b0:399:7f43:b3a4 with SMTP id ffacd0b85a97d-39ea521505emr6173875f8f.24.1744481733541;
        Sat, 12 Apr 2025 11:15:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233c7a68sm121462675e9.19.2025.04.12.11.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 11:15:33 -0700 (PDT)
Message-Id: <pull.1936.v2.git.git.1744481732.gitgitgadget@gmail.com>
In-Reply-To: <pull.1936.git.git.1743181669.gitgitgadget@gmail.com>
References: <pull.1936.git.git.1743181669.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 12 Apr 2025 18:15:29 +0000
Subject: [PATCH v2 0/3] Two perf test fixes
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
Cc: Victoria Dye <vdye@github.com>,
    Neeraj Singh <neerajsi@microsoft.com>,
    Patrick Steinhardt <ps@pks.im>,
    Philippe Blain <levraiphilippeblain@gmail.com>

Here a two fixes for failures I noticed while running the perf tests.

Philippe Blain (3):
  p7821: fix test_perf invocation for prereqs
  p9210: fix 'scalar clone' when running from a detached HEAD
  p7821: fix instructions for testing with threads

 t/perf/p7821-grep-engines-fixed.sh | 6 +++---
 t/perf/p9210-scalar.sh             | 3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)


base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1936%2Fphil-blain%2Fperf-test-fixes-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1936/phil-blain/perf-test-fixes-v2
Pull-Request: https://github.com/git/git/pull/1936

Range-diff vs v1:

 1:  41a093d570a = 1:  41a093d570a p7821: fix test_perf invocation for prereqs
 2:  1092c32609f = 2:  1092c32609f p9210: fix 'scalar clone' when running from a detached HEAD
 -:  ----------- > 3:  abd146b7c2a p7821: fix instructions for testing with threads

-- 
gitgitgadget
