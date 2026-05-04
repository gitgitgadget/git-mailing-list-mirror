Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5C53E3D91
	for <git@vger.kernel.org>; Mon,  4 May 2026 17:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777914527; cv=none; b=DUDYcaYCJ/VnRa/UFj1IMHQDedem2UZKxyevU0Aq39mCX1956gSV92/OWT/EmykzARrpFb6+k87fZtX8Npqjy4/r8ecE+DKHHhmbb97InktEz8IrAM2dHcPhGdEHLUBcM6PL0evfqDTwsO+9XFR9b6/AqtQ/i/ifoE0F47JVl5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777914527; c=relaxed/simple;
	bh=PASS0jf5R1CaQT04dB4gmIEPEo0kdfIoVtivlB04D60=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pewzBF8qOAayxGbo0H5Z3quPRMb3pnz2+uvD8I0VVAS4PDWlKAD7i0TDQggv8+mr25JNPQuQSTIypnCA545WjCS8YQ09mzEAt8pxnpsLeqX4b+Nu3zahG5tJ569B7juXXPVxJUbcNMicQIi8amKuc0WEuRUKlXjjKaHGviFGbtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7C/o5tf; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7C/o5tf"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8dbbc6c16b2so557516485a.0
        for <git@vger.kernel.org>; Mon, 04 May 2026 10:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777914523; x=1778519323; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpTsmj91yrtrxUOUYDP3Ff5uPTzelI9FxAXV468jY8E=;
        b=T7C/o5tfP81jZryTe1PUgeXOHs3SEvFGhf3PTlgOXe3OcXNyntTb+7QZgGiwgIVIUF
         MXde5zoGsOq/N9d/XiMmYDKYtMPFLuqX9Bf8T7wwkGswdSF3BMQaGz/oTypm1TqHIr8+
         VC8DCNhHRmYBC4sdWImrAd2eurAyJqK2VuCoyaSUy0lMnXJtCaxD+Vn7qAC6zvbd/FD2
         CpA7d+2aR7zanS6N/lUh02gVqeJxTnrqMAZG1wYPEYozyS6b9UqFY1OYt+at2Xf1rItJ
         sIB2biVevQB2VMQjmVQQGQWlXKU4doW/47dVTiEQxNnnBOBtSTdMCw0Wp/n5pf61gHGF
         JR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777914523; x=1778519323;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wpTsmj91yrtrxUOUYDP3Ff5uPTzelI9FxAXV468jY8E=;
        b=NoDMtDCLltRZ8+LlRf+Nr1n7x5sZ7hgjT2/O7S5LxsoFPczrqFZIJ61rBJkh4AMBtt
         TrrY0tPIPvOKY8CytbSU4al345PDjztntNLnqBUe4i+CVZ7TTmHaaHPn0EPOfZYFNMr4
         HfNRtmKVqYc6LNFnDlbDJF50XGy5gBE+CAf/Pfknz5c/GCi+4lKunOOVBKxEbpG3uTUy
         eIExD/AY8WsfvtQxmH73Ri6+sFBAusUku6r7EIvuS+tgZVsBY9PxygE5VVGhch9kqHjI
         4qy0B9/NnVK8fX5R+ZPLfuqMjfzc9g7P79VzhwON5uAnyeB/4hkE/i+Ksx8p8J2A/tf6
         jPfQ==
X-Gm-Message-State: AOJu0YxQqjVmIB0PmpMs+U2xwydp94hpofm/4UF/YnZooWQa8XfqCwOT
	6otR6gMWCt4MtHsgOGQkMAA8GCMtxp2/9Nkt+oMOe6Ho3fBaUCpuQd01ro3GCAGr
X-Gm-Gg: AeBDieu7kOkSd5G4wE2JVa3Dy7FWZx2z7HTe7D5GhiFl/d6tjsCioyzBZf/qbB4Pm4B
	1iTUOCC2twKAswdXv73M37G7o7gbtNiwcDNA9n1p6ZvQZUniTPsEmum/v9JWJTjYbecrVs8fFEM
	DeyG88v72rWWQP99SjEPdWqKd99hbIuLrg+52+ZvDfK+1TTLjVqapAIkuQ5XX0OGdvCUoajraRF
	j+I4AKYIfu+zbbH5URkQ3pcUYdJ1ZHNaMnBCR9rUU9pm2V0E79h+TbtCyIHSAb0uyZMKb04ypjl
	T/Jq/QSk20HshSdZ1dsPq9hFnrSJCIuwOnk+3xhBk/mk0t17DzPZ4y7pPT5FQFqPDGGgl8Crk8V
	uqOM7lk4E+7JkK5sIS7Cf1TpCUq5uwQoPE6zg8YtOuffFo6Xi6WQ8TeQxEsFStWRVTGHrQ8+ODU
	BldDI9oXdetolm7o1ySnufnJUkI/UdQuL18El4
X-Received: by 2002:a05:620a:480b:b0:8f0:c513:8cd9 with SMTP id af79cd13be357-902e298e219mr55993085a.16.1777914523276;
        Mon, 04 May 2026 10:08:43 -0700 (PDT)
Received: from [127.0.0.1] ([20.231.101.45])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc29889603sm1099319285a.11.2026.05.04.10.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 10:08:42 -0700 (PDT)
Message-Id: <1eaaa7fad7a1432dd97ffdd7c45e8162f61bc302.1777914508.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
References: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
	<pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 04 May 2026 17:08:28 +0000
Subject: [PATCH v2 11/11] ci: run expensive tests on push builds to
 integration branches
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Derrick Stolee suggested [1] that expensive tests should be run at a
regular cadence rather than on every PR iteration. Gate GIT_TEST_LONG
on push builds to the integration branches (next, master, main, maint)
so that the EXPENSIVE prereq is satisfied there but not during PR
validation, where the extra minutes of wall-clock time do not justify
themselves.

[1] https://lore.kernel.org/git/e1e8837f-7374-4079-ba87-ab95dd156e33@gmail.com/

Helped-by: Derrick Stolee <derrickstolee@github.com>
Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/lib.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index 42a2b6a318..a671994bdf 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -314,6 +314,15 @@ export DEFAULT_TEST_TARGET=prove
 export GIT_TEST_CLONE_2GB=true
 export SKIP_DASHED_BUILT_INS=YesPlease
 
+# Enable expensive tests on push builds to integration branches, but
+# not on PR builds where the extra time is not justified for every
+# iteration.
+case "$GITHUB_EVENT_NAME,$CI_BRANCH" in
+push,*next*|push,*master*|push,*main*|push,*maint*)
+	export GIT_TEST_LONG=YesPlease
+	;;
+esac
+
 case "$distro" in
 ubuntu-*)
 	# Python 2 is end of life, and Ubuntu 23.04 and newer don't actually
-- 
gitgitgadget
