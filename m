Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF9B2C08DC
	for <git@vger.kernel.org>; Sun, 14 Jun 2026 19:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781465145; cv=none; b=tbozZ8ucsV8lFJbY+bea0zO5Dk0J1eZdSJc6LAfT4+mVjidDpWJXD+29jh9P1MNs9qTdmD9mB33Zg48ZMaCMjhweQ3I0huUIuJ1qctQ4YPQ68DKkhNidtMpiJA6Z6DYYE8CwgEQEkuGVfLybsKb/QcSxFJRug9oYViCYEX3vfic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781465145; c=relaxed/simple;
	bh=zWZXRbsIR0s3NvF78kg+HV4JNsKYBnhfLGKhq7UL3TQ=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=M5vNS819IVyPOq/j3o0Y+dj5uJ0ydQZvPlMHfyeYtWpZC76XU5P3SDvCI6AWz//M5kG6Mkg2SxPoz1BuPsqsCeCbuAO2vtugz8HcdpTMuE8BsLwMfXFhgOi86UU1ZzvbIUDlrT1oJTXgH2Wh7FZsbgHFmxgsmwGldMoGuejdWZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/Yfh4XW; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/Yfh4XW"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-307d0405e07so3957399eec.1
        for <git@vger.kernel.org>; Sun, 14 Jun 2026 12:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781465144; x=1782069944; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c1WaiBPUKsyVLxDnsk70bHBbYPXBdHkOqbigP1QLDiA=;
        b=T/Yfh4XWh4QZrGbGiuBxdEAh/TSobY+USKVdcLPwyivGgtoXTCsiVP1ax1xiaSLylQ
         4PebMTzA8MHuv9uW6hy3ZyxSYPucAK4qXQlSPR/WFL3x30iy3+0cOeyVOmTcn9PuqrUo
         u+M9pSLu5tvIuXMJu6FJSBqb3aOJmqXzlRU4z8Y700vIVML4DzR3LBQ8oA2noM7pnAt3
         feZbrRepE9+VXTHZHvwodJkthY9Zc1xQY1pQVHxAQTxMjkvVZ12Ocy5jYDuoiG8FJLOv
         QqHiDp/T1gZ6mKio7KOc3PlMsH923/fus7hJZcH7OV8TYnIxfX8TFhOaaCZg9bgs984/
         gHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781465144; x=1782069944;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1WaiBPUKsyVLxDnsk70bHBbYPXBdHkOqbigP1QLDiA=;
        b=Y/8cPC/b2NDGy9+aKuVZeLBKUR1AWi9vhLT9HWgqV69jhcqhi8Y4dqUCG/Xkgv2pvk
         1UsSfjc2unGKLvLyD1GMdGOxaYYfTxkOtZZ+4JBqbg4IcVFksjfbMbNIlINeMrfxlyEh
         UuKSR32KlbOAi8hrxyv6RQE2K3w5aAM2lQlD0+f1XTL1UJQEWO5WeJYxLfiwPgKWdgSF
         p1my3XCVFyieppuWyUOb1/gfhsOByZHV0M+G4RIjYG3x9YpokeZVmA7S4v/3mzMTw38s
         lIehC7RdmEk+CkmxtIAbYMBVzoBBoPzu9zKRW7chnisLnIISy23Ih8avKv8KyGcj0vWh
         zI9w==
X-Gm-Message-State: AOJu0Yyeg+1z6kvWvHPRWlyQuf6Yh32BaZBK3DKIo5VMl2me5kFsFF1b
	mXWV5GTGUBbbMOF0WmD3yvXKZs9WjGbZMTomJaTEpfbGrPhWWiLdGkchDmqTwZTy
X-Gm-Gg: Acq92OEqMmRNmtR1KXOqaZRvdoNzYX3d9i9z6MaAaLfBEp91Rifodhzf5QIo4drO1cL
	N5DuU8qybjCY8g6bGcX9RlYOdV51tVVQD4D045rNyLFxPNTrJecjWwvJtNaR+f9m2ZyQUIcBmYe
	1Sr321rwLlBXnxRjI5a/lNLAPEFpFLwwl9T0kF2e/K9GfkdLLaLSlbp2upIEMQw+cIqwyGu1YDS
	TwEHntAK3LRhu3TbDikQeg4CQi+kjmRK3cUXoQuWdLG3tOTxwYdQ31klO2EHk+m0pqTaN4pOrtz
	8xH7rpHT7PcWvgFqJCDGwBnfURo5DYWt7UWqjMzHfoyLJ0lYZ7o2r0K2q7FyT7cBMAy3A09OG6n
	t4EaXZUkGgjLqiEZ0LRxLolKgO5C4ghYOxIHoEGmTg4OpsNVSh/CO/XeIM3JWOzKY2hyMzlt4Bi
	6ZaAiRLCpAJglx/59Xxns3j30=
X-Received: by 2002:a05:7300:8c05:b0:304:c651:bdea with SMTP id 5a478bee46e88-3093b9443a3mr3896231eec.21.1781465143492;
        Sun, 14 Jun 2026 12:25:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.42.67])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5fefecsm11997287eec.13.2026.06.14.12.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 12:25:41 -0700 (PDT)
Message-Id: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 14 Jun 2026 19:25:39 +0000
Subject: [PATCH 0/2] rebase: add --fixup to fold a range into its oldest commit
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>

Adds git rebase --autosquash --fixup [<upstream>] to fold a range of commits
into its oldest one, reusing that commit's message.

Related idea: https://github.com/gitgitgadget/git/issues/1135

Harald Nordgren (2):
  t3415: remove prepare-commit-msg hook after use
  rebase: add --fixup-all to fold a range

 Documentation/git-rebase.adoc |  11 ++++
 builtin/rebase.c              |  13 ++++-
 sequencer.c                   |  24 +++++++-
 sequencer.h                   |   2 +-
 t/t3415-rebase-autosquash.sh  | 106 ++++++++++++++++++++++++++++++++++
 5 files changed, 152 insertions(+), 4 deletions(-)


base-commit: ea97ad8d017de0c9037451a78008a0fd60abea0c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2337%2FHaraldNordgren%2Frebase-fixup-fold-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2337/HaraldNordgren/rebase-fixup-fold-v1
Pull-Request: https://github.com/git/git/pull/2337
-- 
gitgitgadget
