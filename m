Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE431C9427
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 11:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724238164; cv=none; b=RN2HVXX0bb7PIFQyt+4iYMMYg8Wbr2uR6otpfX+BiKE/SCgBnQJLr5M9CAgwsF9tAqruRcRJH4PKU2nCAuHTBamIPIIUbJbKHJZORe2L0g1iORtBjAJt9mP7xVa4uAoipyEHHq+6iElDdRfyJI1V+2QsvqVoGQCXRbcuYYtbx94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724238164; c=relaxed/simple;
	bh=vm/WsjCGUJ8J1YgsjP4iFrDgFtTA3K5jDOeFxMmkxFk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=S7dyGgwf1c1LOivHrT42hpewNs/Fqp8nRK29y6cAiIuj0qpLR42/gKPogMEwY4LR+0On/e7LnR/feBIsy3deLpVrauJ8h93UA5ZqP7GfpUffv7L3u+czxlyJttnP8ItjrBh11hlMuioha9TvDmVgqDaSUmydKSq3Xepk5BNhwwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTsn5GlO; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTsn5GlO"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a867a564911so55947766b.2
        for <git@vger.kernel.org>; Wed, 21 Aug 2024 04:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724238161; x=1724842961; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwXZc6Ki0NohwVjY/tMsRvhm/tHfbNJVC/zY3RjTiG4=;
        b=TTsn5GlONE62UYY7P18Dqw8N3rRmShgXSwDT1zpwj7dd4r5wH2LTc38eSzv/6yKIwj
         LhSLuVvLRFvH1B7q+ky26wPWqLbFU9FB5YzVdhxKQHdZ4SHQCGSNWhdHVx4oMRa6Phsg
         ZjKd8z/HWcLd1NN5wrypCHf3MJu1KtkQ7LP2XUEnVwloz7QKdBlA18fKhU5oaNpG8lox
         /z1nTljfJKrd+8kh1QMKpXAR1MD9l/1uyZPjgq6n4z5214G1Qc8Fl5KnqRofSCkaJBIf
         Kl8oIyCpjkSV9xlWnZls6EPgqJtr1ck3p/WcY55cRWyxoAWNY9YHCYVfQiKcxAsk5USQ
         c4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724238161; x=1724842961;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwXZc6Ki0NohwVjY/tMsRvhm/tHfbNJVC/zY3RjTiG4=;
        b=o9KehhBfiotbKfOaJW9DxZLlaKsl2PaFaoETugCSFxwQ1mtwDiMeFsNHY+OpfztEZL
         nmHnE2Wjlfa1v0hi8YCDUo8xMQr9m0Wsw+zaJMUVMTyQ3R2p9Qu2yNHNMXADamshsYQk
         D7h/VyQIMB2BWZhGByn3QOYXqm/UjMaZeD/PM7KJc7ormrm3KrzFxocL3LSJWjqcrvXX
         NwvHfsPYAjU2b5Pt8GymxXbo0ca5w+ZMVpfXcSCr04pANyOWWctfz6owrzIH0+Q0n8lT
         BcLwQCT1XVDoLHdBdbfgWKLSva8aWQuWIKy+Bz5oS5kgWwPvcQ22C9kguEzIuBne1Bzd
         49fA==
X-Gm-Message-State: AOJu0YyO2Vh4KdVgZmhbhSkjUD6TZnP+xOq0svb04p/qMYTJMOQUVy8N
	BIJPOopfbAGqVm3CJn+z5I9dg85vRO44HI5oxRb4QKrU5rkRBYdOXi8s/Q==
X-Google-Smtp-Source: AGHT+IHirDc7ft0+CkGffOshnX214IFk32ohEyvBVblk/F4Y0nRE5HKMVLNKJoRIEaA66SYXglmySQ==
X-Received: by 2002:a17:907:f7a7:b0:a7a:c812:36c5 with SMTP id a640c23a62f3a-a866f8b351dmr143792166b.46.1724238160497;
        Wed, 21 Aug 2024 04:02:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383745e66sm881608366b.0.2024.08.21.04.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 04:02:40 -0700 (PDT)
Message-Id: <960d1ec11ece90a29da8a909243aeeca0fdc04fb.1724238153.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1776.git.1724238152.gitgitgadget@gmail.com>
References: <pull.1776.git.1724238152.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Aug 2024 11:02:31 +0000
Subject: [PATCH 6/7] t7508/12: set GIT_ADVICE=1 across all tests
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
Cc: gitster@pobox.com,
    Johannes.Schindelin@gmx.de,
    ps@pks.im,
    james@jamesliu.io,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <derrickstolee@github.com>

From: Derrick Stolee <derrickstolee@github.com>

The output of 'git status' changes depending on the availability of advice,
even though the messages are to stdout. Since this test script is all about
testing the output of 'git status' including the existence (or lack of)
these messages, set the GIT_ADVICE environment globally across the script.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t7508-status.sh      | 4 ++++
 t/t7512-status-help.sh | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 773383fefb5..7158ee57f37 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -9,6 +9,10 @@ TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
+# 'git status' output changes depending on the availability of advice,
+# so force its output to enable advice, even though it goes to stdout.
+GIT_ADVICE=1 && export GIT_ADVICE
+
 test_expect_success 'status -h in broken repository' '
 	git config --global advice.statusuoption false &&
 	mkdir broken &&
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index de277257d50..1d9676bb3e2 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -17,6 +17,10 @@ TEST_PASSES_SANITIZE_LEAK=true
 
 set_fake_editor
 
+# 'git status' output changes depending on the availability of advice,
+# so force its output to enable advice, even though it goes to stdout.
+GIT_ADVICE=1 && export GIT_ADVICE
+
 test_expect_success 'prepare for conflicts' '
 	git config --global advice.statusuoption false &&
 	test_commit init main.txt init &&
-- 
gitgitgadget

