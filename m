Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844A13093AE
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 18:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763232870; cv=none; b=u5ghPHo+3ozijCr/qYNOxKhO+D+sNnoC9eqYClBO/XG59+N1vEe7Bm4qYW15vHKgtAcw3ngNSCU8nRoEPjJhgvMCfuIVOsbYaqyJLbk5EIbv0mPmaSTHIGtsdCAuv06FJzDJr4B2Y8uFnFmI6DExZfCdvWXt/qnzpOyyUBXZzDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763232870; c=relaxed/simple;
	bh=UB2P3bxW4CsPPSbqJmkOWPSeIl8bULd/t3a+WZYhIyY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=faO+aNM4ROeEgVOeJLY/2jxqqcufjJZA4SknrxntfjVEc8HntPybJTGjurm8uIJJuNnf+qv6HRNzR/m2UxDKDKNoRWYLDQhVdGr0OHrxh/uK+bI5Y8qsE2xyh8P3f37yZf/cDOUr3+/mwQ/DcnDDX9HHTGMyMGPPJSwfF92DYNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGXmAV48; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGXmAV48"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso2620264b3a.2
        for <git@vger.kernel.org>; Sat, 15 Nov 2025 10:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763232867; x=1763837667; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJGR0n27A+0uihjuFmc1mjqUhXALXA9EYVrq36+d9VQ=;
        b=CGXmAV48RdSMXdcYf5kleohSNIA0u8E58gAX6DSPNknSWYBGUAjx9ItEYRLnhn6gwk
         6u+jEOs1BhqXhzolkuSvzjFTEY5Ib0GuAz4XBtMOqXU+zccKveTtEKhGioj4cYenl6Pt
         FPP/RTKuhSgRSpvVvmu5pBzpnmnCFzJYJwvPoZ5mOl59uNLX0DayRfHDt+WQfIrHhbvi
         ZsFUhDQ+YiT+jQgLd1WBh6US71MtzVAsiLiiASelXHOLkTZGZk5Tg5SzDRwXoCl7d08T
         Ag3u08Nn0KTZwIdDIVLfVVmtcfCqv2NfHD48HFV2B9cnThoNK6AhC1VY0lRJ/DscqJSw
         ZSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763232867; x=1763837667;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HJGR0n27A+0uihjuFmc1mjqUhXALXA9EYVrq36+d9VQ=;
        b=cL6GsnU4FRVkiNvRtFbT8NMsiBt6OqqAI8ByinFe/9GUiE0lw0K7kdYpJjoyjSIkYm
         /xT/PYfF/JvCHu5C4gyWlwqUkzNj3nMP8zSyBILJpxhMqsT9eshsgcQ9NGkcz4MfF1UU
         65slTWzUjQac2fk/kBgTbyo/Zjc+2iyQTmYdNj4eTVP/dyCCjOgZuS9oqDDbSPEs8gfq
         ebRySYl+afdoS0csXGKW9siymQlNGBPDSlNfIArwTBrUQsRgZLK8V0fq4jILVmr2Uyuq
         U4Kn4BN9nwrMOnwhyiqkWpCyJFl5wxQHCz23J9z4uX7Jnu86hlq5mrDk8A/mdOKkeQdN
         802Q==
X-Gm-Message-State: AOJu0YwLe0WKOiWyHRsU3aungOA2yxkYjSwaiYgUHLFrPu9iZzRBAptK
	YFUpWO/op7/5yJKsSzJb7v3AeDJrZYECw2wlwWYZC2fnam07LcBRL+9No2rk2+iL
X-Gm-Gg: ASbGncuc1+ErBeBe3FwO+o12psQoQtfzCwzxnjYYdPAdUbjm4VhUPwtuLfoiwKlkpVQ
	nd/Mle8A5dNbc2+conYi1PxQRMlK7SPwoCDwIbG0FDsjBKGFvNk8V73ODDR21L9FBwiZnAN0j8E
	J7kBV32mg3+ANaeaX5FF8MUKH9VjH+8UxsxjEBCIGGBMNIW0zyZWXNXLk+cPS8/Dp6XlmR/aWZk
	0AD2ueC6H0tyEVVJ9Pu5Hkgs8IT+T4qXygj+FKibB6sl8Ppbjp6Y8I7rspSOiuJ8+0n59Gp34Bq
	11cvrfxVd2f86kNHCRr6u7qGAxNmz3yd0OxcqKK9oeQE2YVCNWFs9hgfNPzp7pJ7No951tiLa7f
	Ecqc/uQ+EeeueUWTuJcdP3IeD4+JAo6x5sfpLTzNH+4c7oSaDuyRUPnnJ3lyghuwTnZx6BbikJh
	pSH+X87HS+pCMD
X-Google-Smtp-Source: AGHT+IExkiYd3vjFswzBqLjBT8jlpUIXEndc6Aoic29dvlZ3zFAfk8ggMSS6YlmVY3WazV8rHs9RbA==
X-Received: by 2002:a05:7022:3f88:b0:119:e56b:91f4 with SMTP id a92af1059eb24-11b41310049mr2383067c88.37.1763232867271;
        Sat, 15 Nov 2025 10:54:27 -0800 (PST)
Received: from [127.0.0.1] ([68.220.58.240])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b0608860fsm20605900c88.5.2025.11.15.10.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 10:54:26 -0800 (PST)
Message-Id: <af5861933fe4f2f4aa4c81e080a035ce5cd45c34.1763232863.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.git.git.1763232863.gitgitgadget@gmail.com>
References: <pull.2101.git.git.1763232863.gitgitgadget@gmail.com>
From: "Kiril Ivanov via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 15 Nov 2025 18:54:22 +0000
Subject: [PATCH 2/3] t9903: add upstream indicator tests
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
Cc: Kiril Ivanov <ivanovkirilg@gmail.com>,
    Kiril Ivanov <ivanovkirilg@gmail.com>

From: Kiril Ivanov <ivanovkirilg@gmail.com>

The upstream indicator currently has no test coverage.

Since GIT_PS1_SHOWUPSTREAM supports various options, make these tests
parameterized with a matrix for expected results (ahead/behind/etc).

Signed-off-by: Kiril Ivanov <ivanovkirilg@gmail.com>
---
 t/t9903-bash-prompt.sh | 59 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 7628bc10fe..3997012d1c 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -25,6 +25,8 @@ c_clear='\001\e[0m\002'
 #                                       (b2)
 test_expect_success 'setup for prompt tests' '
 	git init otherrepo &&
+	git init --bare origin.git &&
+	git remote add origin origin.git &&
 	test_commit --annotate initial file contents1 t1 &&
 	git checkout -b b1 &&
 	test_commit --no-tag second-b1 file &&
@@ -35,6 +37,7 @@ test_expect_success 'setup for prompt tests' '
 	test_commit --no-tag yet-another-b2 file &&
 	mkdir ignored_dir &&
 	echo "ignored_dir/" >>.gitignore &&
+	git push --set-upstream origin main b1 b2 &&
 	git checkout main
 '
 
@@ -515,6 +518,62 @@ test_expect_success 'prompt - untracked files status indicator - not shown insid
 	test_cmp expected "$actual"
 '
 
+################################################################
+# Show Upstream
+options=(          short  verbose   'verbose name'    )
+expected_equal=(   ' ='   '|u='     '|u= origin/main' )
+expected_ahead=(   ' >'   '|u+1'    '|u+1 origin/main')
+expected_behind=(  ' <'   '|u-1'    '|u-1 origin/b1'  )
+expected_diverged=(' <>'  '|u+1-1'  '|u+1-1 origin/b1')
+
+for i in ${!options[@]}
+do
+	option=${options[$i]}
+
+	test_expect_success "prompt - upstream status indicator - $option - equal" '
+		printf " (main${expected_equal[$i]})" >expected &&
+		GIT_PS1_SHOWUPSTREAM=$option &&
+		test_when_finished "sane_unset GIT_PS1_SHOWUPSTREAM" &&
+		__git_ps1 >"$actual" &&
+		test_cmp expected "$actual"
+	'
+
+	test_expect_success "prompt - upstream status indicator - $option - ahead" '
+		printf " (main${expected_ahead[$i]})" >expected &&
+		GIT_PS1_SHOWUPSTREAM=$option &&
+		test_when_finished "sane_unset GIT_PS1_SHOWUPSTREAM" &&
+		test_commit --no-tag ahead &&
+		test_when_finished "git reset HEAD^" &&
+		__git_ps1 >"$actual" &&
+		test_cmp expected "$actual"
+	'
+
+	test_expect_success "prompt - upstream status indicator - $option - behind" '
+		printf " (b1${expected_behind[$i]})" >expected &&
+		GIT_PS1_SHOWUPSTREAM=$option &&
+		test_when_finished "sane_unset GIT_PS1_SHOWUPSTREAM" &&
+		git checkout b1 &&
+		test_when_finished "git checkout main" &&
+		git reset HEAD^ &&
+		test_when_finished "git reset @{u}" &&
+		__git_ps1 >"$actual" &&
+		test_cmp expected "$actual"
+	'
+
+	test_expect_success "prompt - upstream status indicator - $option - diverged" '
+		printf " (b1${expected_diverged[$i]})" >expected &&
+		GIT_PS1_SHOWUPSTREAM=$option &&
+		test_when_finished "sane_unset GIT_PS1_SHOWUPSTREAM" &&
+		git checkout b1 &&
+		test_when_finished "git checkout main" &&
+		git reset HEAD^ &&
+		test_when_finished "git reset @{u}" &&
+		test_commit --no-tag ahead &&
+		__git_ps1 >"$actual" &&
+		test_cmp expected "$actual"
+	'
+done
+
 test_expect_success 'prompt - format string starting with dash' '
 	printf -- "-main" >expected &&
 	__git_ps1 "-%s" >"$actual" &&
-- 
gitgitgadget

