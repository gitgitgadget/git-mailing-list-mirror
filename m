Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4148D528
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 00:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983078; cv=none; b=dUOC/vwxMqJVDWbmsJlkTDpuBAhUuunc5DAJdd322XSVR4hNuoT54zZSfEN6F36CYXgC3EZPqOgalU1ajKtusXTulfFdhiEn5BelKzvpGWPeQlCEB9SVEtOTbMFZILJWZKR+Y7OBM2Cn6lY0A8fnkRwuNZGbeg27zmhHuAHXB5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983078; c=relaxed/simple;
	bh=tjDm00X51D+soRcPSfusFfQ3kozU4ElPqn9bKZ9nIQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kziMapo3zDMx8vLY1047em6ZkGSqH3ZnXmdjDdu7mCFyCNaNd/Rws/AJRX8MYiTNWZp3ZgXC2KybnhKWVj2dMtt6ELHGRab2ZSsa24Qd8v4SUM6AQm4+GEm0IK83ZVgnkHAPTjgNt18XgPH2hAggK101WqVXtzWczZVueKfSv1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UA+2A14J; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UA+2A14J"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-ea4fceb260aso426351276.1
        for <git@vger.kernel.org>; Mon, 15 Sep 2025 17:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757983075; x=1758587875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Esk++tH1jEYsfXOsP1JttRh39Gshc8kyJov4m0nkA0o=;
        b=UA+2A14JQ/8gKMk9a0wojkV33K401SVsqxFX1NKInI/rp8lqYkfeksqPmvrLSjOKEs
         cV5Kn+FGU3yqCl+u8ENCB7VunHNEQXchyorh0GpEkiDWAmr3nc2T4X0EG0RgV/Oqfloz
         VLl12JARJKuNYYdRtMjC3xElt291ayEzXGJBvNDNP240p6Oy73usp7NrKOZ1gkSKgyvx
         GpDrMjbSO+R7/IbLdNf/DCsDdD/VFDeELEyJAouM7FCL1IgjSBSpqaVlyg61T1agcs4o
         GcLFsERc5BCOmAak26yD63E9w1aaoms/GsQdgvMsw+RauAN/mrvi4Ixb/1b5KVxWds4H
         zZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757983075; x=1758587875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Esk++tH1jEYsfXOsP1JttRh39Gshc8kyJov4m0nkA0o=;
        b=Q/J1aDgDnEEYhrlCNGMkbQM3vdXUFb3nlo3dA0lP8OnJlQs/jjNoOMD7nN0B4A7W7U
         WDRdLSqMY5oQcH7Qdh5wGhmInetf62RSZinIurHSSHiSV/WQ/jdCX+qT7T8p34sUFOKj
         Kd9Sd6KvlzuuJsaMIoZgDUXYIYNWZSE7oS41AHMh367/1YrwwE/SBFAiJ6DjPm7JopXB
         qM5Mx6LBNc6IdieURRE7dYwXS9mQN0KM1+rCmwQw+JAT9UlnPsLjHFSpUCNtwV7nCpmX
         oXTPBwc1OZ/hNKakxFkTxRYe+/RPbXHuHePP+t3QnyQ0bVaxlmnUht1gPd6npPm0A5xd
         TGzQ==
X-Gm-Message-State: AOJu0YzXLncPZmmfCLM4hpYb/nY6BqRFq+7xoFsEJxvzcp1B9MVRrXku
	e+c8b7H2RLT8yPnaApVHWqz7hiU6CzVC/aQD0mBgMSsvkgPwY5vgWkqG4fvOgYWc
X-Gm-Gg: ASbGnctUpWCjXJRAvPIPe+PRLU/U73Q52rPJ4abGcjCIpp2KajP7j65Nxq3aarShXjl
	EWkoQcQsC4YpFl0dgM4CBiurjspDHtIhsOigGi/pEk/ayczcrr4hDQge9pygGPhSK+X/ZwuarxO
	KBgfuM56kzolJXLbwq8K04sxwwUmKk5RJ7UT0dfEHF6HOa1Sq9cvspHgjN8VxqYmIcXa7d0hEOP
	jdNsTP8wuMPw79FX0d7zs8gkbtPRhqjN9KEarfCt4SvK4fuLUhbzWznUnjM2/GwDkfn6NbX4KlQ
	kKKwhYRTKxIvEcOge1ONtkybbsB+FqNdQCa0/rBPK1mnIF55AA/GDEs61+BHG2ngPFpFxXH58XC
	isLszpJ/O5XqE90QVzh+7PhUsuxGdu/qez92OJP+IlWbZe6KcJtaXYpci3C9aQiYTrg==
X-Google-Smtp-Source: AGHT+IGTjyx9Zem7jdpb5/Zz1Lb8G20KdIKgq1Y4bjurVVgknxwbCYlIrGe88mdh/4WOP9Fsd0Tltw==
X-Received: by 2002:a05:6902:1006:b0:ea3:f1be:65bc with SMTP id 3f1490d57ef6-ea3f1be73edmr8786444276.16.1757983075215;
        Mon, 15 Sep 2025 17:37:55 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:6545:4857:11f:cd8a])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea3feaeeab8sm2333167276.5.2025.09.15.17.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 17:37:54 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Denton Liu <liu.denton@gmail.com>
Subject: [PATCH v2 2/4] t3905: remove unneeded blank line
Date: Mon, 15 Sep 2025 20:37:35 -0400
Message-ID: <8ac06ad62df581bb84ecdca0b0144c218daa0733.1757982870.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1757982870.git.ben.knoble+github@gmail.com>
References: <20250510183358.36806-1-ben.knoble+github@gmail.com> <cover.1757982870.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is leftover from 787513027a (stash: Add --include-untracked option
to stash and remove all untracked files, 2011-06-24) when it was
converted in bbaa45c3aa (t3905: move all commands into test cases,
2021-02-08).

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 t/t3905-stash-include-untracked.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index 1289ae3e07..7704709054 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -87,7 +87,6 @@
 
 test_expect_success 'clean up untracked/untracked file to prepare for next tests' '
 	git clean --force --quiet
-
 '
 
 test_expect_success 'stash pop after save --include-untracked leaves files untracked again' '
-- 
2.48.1

