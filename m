Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB7A1A0711
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 00:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983077; cv=none; b=rsiTQFJXyXCugBXGHwQLcKnlGi2axi9aAYZYyXS+QRUK8LtyhhrduuavlSDfGw3hP3KlbkkQfOHwhYghgh+x8UN++qwQGcUejSEvM6VNavk+iw8JTBjZev8sMMLuwB2VIIKuIHiCp63D7IzpYRAdpLwTMwkiBexK+W7oJbjpD9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983077; c=relaxed/simple;
	bh=ZCjNGJhXmiqnzd2L1GKApvpyyBY995QQZS9WVHzVOOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=INIGMslBPN5m8jRhe3/hz84Nfn7JHc8J1nhqBF71QmP9Acv6pbdLJmaOpzx/fiqvZjYlGeNEIPHak2unhCIaOu6QqUfoAG0pXDPlTPtyOlGyRw3fV6TAfduwvsKUYLo3JNjlhDlDAQu/je2Hybo1DCGplvzGOFeBhReb4/ONPUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KS7uBr5G; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KS7uBr5G"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-ea3f49679ccso1692726276.3
        for <git@vger.kernel.org>; Mon, 15 Sep 2025 17:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757983074; x=1758587874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7YRrTiQhTc7FEFlW0zxreJ510IqVyNe6b+yd+4WU5c=;
        b=KS7uBr5GGP3U6j26H9ylBTlMp8lkifaxXCXPP9p+lOkrhCgC8mCidghNoAG8g+McCK
         aNxrpXtksLkoU0m7bj2jhuRYLJQ4J+3zNsJHbh4C8Rv4wlXP6Yayd3h7x4p7dtgxlf6v
         0xLLWRVre+CgGTxTCSECOj3JlgTH2JcLMvXEByeUEMoTliWrcRMDlH1cFjrtwQbTA25h
         iKKOP0JYzE+xI72IB+LrRkKIgU5L1UCZZjAr3Pwa+MbdaGsdQTMN+AU9mqusgQQM8jJO
         8auUdXsBy0Awce15oq8FElTzvgAzfs4Yv5VnAQy4PMI385LQp52HFBWekC3moooNazgF
         m1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757983074; x=1758587874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M7YRrTiQhTc7FEFlW0zxreJ510IqVyNe6b+yd+4WU5c=;
        b=i3t6FDPAs6n5gJ0vl5/3rEJI2AalqHvUMdHtWQ6YapxkN4cS9RRfIZ58CYotasmbly
         68ZwZtzQB6sVtZUVH5j4blBIpspppzetk0jvCwFqfSW9QmSP9auyz0GuYco3XtUo7r6+
         jm+KmrPjRG4L1EQA4MVSmWzUXN0SvwIWWECC5E/5viJQLgF7b+Se2msWJijiL5BL0BJE
         OT0f5p3gDkOmvmTo572nyh0m4wzbrc3ZC+3kZG+wyWvLc3wf+JamHlXoHkKUbDigwr95
         Xm48Kd7aG+OxH18A5mtBS0HXRMbVnynsVmIWvNJJfgnsHDFeLbB8dEvr24R1Lsws6AvS
         2Dlw==
X-Gm-Message-State: AOJu0YxQbcuuOvdU6CYIbrtDRRGZtNFTgp2RY04KTMJShh/oM47E7udS
	c86rZ76eU3LAU10XecaMikM31BcOpthf0K3Pi4ygN2swPkQo5zswJXnP+pr57qLI
X-Gm-Gg: ASbGncuZcqw0RGIMVEXnsGdNA2CQ0vtp4o/J25W/XQsq6m8P5Alr3cLg2+klNdCW5IC
	lT0GM7REAbsnUepizRVljLs6dQZ891Eb7Jvz82rUzMUzlpynA2ltKBl6VbQ55zUenzwvxQf1ljp
	d2DEhgHE44gUVybpAehOGbqMCqiwRmFAo/+wocC84hyx6LNFHHx3mftaCrLJbG1EWhhr7DYX2gi
	LiDfB3bJjvZxjPc3yz1ysAA7X0NHzFzWO8bQbn8PyUH2qIMVD2+s9Ird8Qe+iWFlmrj/pcCZeN/
	mVijbF6h7NNGv6QP1N2PkQQ3KOT02mHNhlgv5Ijmb8k5tUK3iYCDtwAkX7Cf+VYCyc3UMOzyp3P
	M14V8jGeBJeUZsPrE26US1uZVN26l9cVx+9+eQjVs0Sr1LOHwP/diRXbfBDMVVveSnnMZq4wLPW
	4N
X-Google-Smtp-Source: AGHT+IFiJBEomQOVapxJ4PFrJvipjBSMUv+Z4VzFhZM0SBN8qUz0+8MMobuXaCe0ypsNsCy3EGkYsw==
X-Received: by 2002:a05:6902:18d2:b0:ea5:a9c6:1d86 with SMTP id 3f1490d57ef6-ea5a9c62cadmr631726276.40.1757983074111;
        Mon, 15 Sep 2025 17:37:54 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:6545:4857:11f:cd8a])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea3feaeeab8sm2333167276.5.2025.09.15.17.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 17:37:52 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/4] t3903: reduce dependencies on previous tests
Date: Mon, 15 Sep 2025 20:37:34 -0400
Message-ID: <1328eb8eac65ec7bbf1f3cb257d7221a372c45c3.1757982870.git.ben.knoble+github@gmail.com>
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

Skipping previous tests to work through only failing tests with
arguments like --run=4,122- causes some tests to fail because subdir
doesn't exist yet (it is created by a previous test; typically
"unstashing in a subdirectory"). Create it on demand for tests that need
it, but don't fail (-p) if the directory already exists.

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 t/t3903-stash.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 74666ff3e4..b8936a653b 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -895,6 +895,7 @@ setup_stash()
 
 test_expect_success 'apply: show same status as git status (relative to ./)' '
 	git stash clear &&
+	mkdir -p subdir &&
 	echo 1 >subdir/subfile1 &&
 	echo 2 >subdir/subfile2 &&
 	git add subdir/subfile1 &&
@@ -1327,6 +1328,7 @@ setup_stash()
 
 test_expect_success 'stash -- <subdir> leaves untracked files in subdir intact' '
 	git reset &&
+	mkdir -p subdir &&
 	>subdir/untracked &&
 	>subdir/tracked1 &&
 	>subdir/tracked2 &&
@@ -1343,6 +1345,7 @@ setup_stash()
 
 test_expect_success 'stash -- <subdir> works with binary files' '
 	git reset &&
+	mkdir -p subdir &&
 	>subdir/untracked &&
 	>subdir/tracked &&
 	cp "$TEST_DIRECTORY"/test-binary-1.png subdir/tracked-binary &&
-- 
2.48.1

