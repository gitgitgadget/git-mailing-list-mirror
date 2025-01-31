Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E486CE571
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 03:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738294148; cv=none; b=DnxOIvG1t+NturSejlo8S+CI4BkmFash7jVRXDJRQnHhI7D8QgXixezjpfFE4vElpPkPNfjNRNK4pdWYemCJw++klp2xYGYjwe1SPOZFuPRouDcJ8JfbGbnWFX71WSmXtzj5ll2F3zm+fPYCAia5CgfzDDXsuXjc9BVYm29s5No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738294148; c=relaxed/simple;
	bh=yoE5VqEfuTaZiUF1qdKqQxAS/beETkJ+mgyoN20+BiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LD8TXykf3JP7Mg+0mbKeluIEvqL8qsPLMtLSDt02Gcyww3beF9T4b0cOw6GxJFaPvHbYZkum7iqB6irZwZZB6AMDiCNZLRUACA+fDD0p1ndet8Jrrl7OuXtsSye7YJ3TmYV1Ty9lUwTDCpCoAanKzuzHusRX7c46NrOJ+TzpS+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDLPXG1d; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDLPXG1d"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ee50ffcf14so4158206a91.0
        for <git@vger.kernel.org>; Thu, 30 Jan 2025 19:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738294146; x=1738898946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yoE5VqEfuTaZiUF1qdKqQxAS/beETkJ+mgyoN20+BiQ=;
        b=JDLPXG1dfbh0uMpaeXc+pCW3J+iS9isySo6D+t1JcL84UvZvAH6rKwsg2V1Cg/OyLK
         D3+Oa44hND9P4nyYSPJESGZTfziWLibYBxpeNkhu8bmgHOTrCMC9F9EK4G0TghmXoofZ
         x08oX16adQjaAcPjLoq7ls33YyMAH47n0JxAS3nutUi8e2WQRhvWvoW4VTH94BxAM+xa
         mE1/LC26epPSxWAjV7rMT+eTAVEiW89aNQpc/K2Ye+CpXrdhP7RyaxD++SCWmTUK4OSn
         3t+LH57YNdbrmfKx1Bxapvmm80hWC4Newh4Odv22UlLz4SUmjqcu7/wtBFMvgu4rbq8o
         eb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738294146; x=1738898946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yoE5VqEfuTaZiUF1qdKqQxAS/beETkJ+mgyoN20+BiQ=;
        b=KQQtlAk0g7gDRNFiScChY12GFtMAWwrNTohn1z7p1tvlrLstvR2zxMJlw2yt7N5JCl
         Al+F1GFSs9WULaoUrr/mJNznMRH+GwY4BHnZ1XMkDYfuNc5Um7JHMfCH6pWsiVMGu05Z
         m0r6i+fVGodL+yUfd59wkQoC4s78RqjfC3qXXYoH5gBzfRFiDvm37sblW7FjEgwecQ6n
         b+R0fmK/gSqsqbP1gEyxBfiEzQRXN0aSXGQgYlF0D8w9JCCii0ULgFd/ms7rhHAEU2uH
         UHRReBXAGB8aYBX33k5HJA7OC4CpmE+AIxQSG78AEgXNc6/vQv2see5EoS2/HcHs6WTt
         nc7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWTEJo66DiZZTOP2iROpIlZEFRqIVgPcQGJnjncY/1aIlvAfxxqzImrdcAzoM6G3DhfZGI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzwoe6owG4luUXoQVnbIayP2OT7HSR6+75RsdblDcNnZa7F4Cl
	EmCqtVIC8v6AnGQifdubRe22cSzBEwoUy0lGiLN8XEuUCvS0Bx66
X-Gm-Gg: ASbGnctfaoOXmTy0Q0OlzEcQC6JeIluKUkt9SuWATSmFlf9aAELpZ61nyh3ZnzFKJ1o
	KY1TSnEFAUf3A4PMhzFDPKOenHajayO2saIx+aLsepk00eNFP09xQ/Gwe1f2BLOz1pBRvB2Tclv
	Und8zHDm9PsGQLi2Cqlg/K6t7IeE1O89Dudur1IYiFUchNHQH8dpdkMklVrY4VJEv6u7cOQUI01
	kkXVlLfjUo94/W+bESm8JjjSY/maCNxr0mSbhrp/CIUwrkli+ubgU24XlxerzwUnz6RTuKB0T6n
	N22lbMWAmPybHFQ3N9VxNgBugm1xOgiOfGlpqP/C/ucGBf+4XSKqt2tEraTqHQ==
X-Google-Smtp-Source: AGHT+IES0XGMJZTJxpWcH6F7P6XUZMkzlzeWKHQH9S0dLKZLgGnv5fIVRSP0pHRM4SMJhao08PKCkA==
X-Received: by 2002:a05:6a00:140e:b0:726:a820:921d with SMTP id d2e1a72fcca58-72fe2d5c46fmr8780403b3a.10.1738294145174;
        Thu, 30 Jan 2025 19:29:05 -0800 (PST)
Received: from FWC02J2WN1.office.atlassian.com ([122.171.19.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6426aa7sm2244256b3a.46.2025.01.30.19.29.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Jan 2025 19:29:04 -0800 (PST)
From: Manoraj K <kmr.manu535@gmail.com>
X-Google-Original-From: Manoraj K <mkenchugonde@atlassian.com>
To: gitgitgadget@gmail.com
Cc: Johannes.Schindelin@gmx.de,
	avarab@gmail.com,
	chooglen@google.com,
	git@vger.kernel.org,
	m.ispare63@gmail.com,
	me@ttaylorr.com,
	sunshine@sunshineco.com
Subject: [PATCH 0/7] fsmonitor: completing a stale patch that Implements fsmonitor for Linux
Date: Fri, 31 Jan 2025 08:58:59 +0530
Message-ID: <20250131032859.37865-1-mkenchugonde@atlassian.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <pull.1667.git.git.1707992978.gitgitgadget@gmail.com>
References: <pull.1667.git.git.1707992978.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi @maryis, I'm Just checking to see if you are able to make any progress on this PR post the last commit. FYI, I tried the build from this branch on one of the Linux instances, and the git status is ~80% faster.

There are some merge conflicts with master branch (config.mak.uname and compat/fsmonitor/fsm-ipc-darwin.c) I tried to solve them, but, couldn't make sense of the changes so didn't proceed.
