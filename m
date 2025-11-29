Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525A5311C31
	for <git@vger.kernel.org>; Sat, 29 Nov 2025 18:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764440920; cv=none; b=rzcVHJ4kV0vviqeRBDwJMqfvHvc6Ow75R3NmGgDUw78BcF+hkWFwvcgJ5tciEWfNOYLe8UfXzJHjuyr5dCO1rQWVXGLZFFyfzEDf0aUjEtGl8aL/sSQuEyuK51tts+9z73YrPgsUgsxmo65oQYO6iEv/aKVN/UVM1EttV6inGoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764440920; c=relaxed/simple;
	bh=tB9n4qBP7/ay58CIJd+yE4SrD/5kA07O70tuYTTFUSc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=l/5856B8v1jt24czE5EolM84q7/+95+JrWn4a4iUckhSk0E07FbsdFX+PJAMKAaY0z3zM+0ZyptPylH+JiGEgIlr6d26Ai1ez9WOuDIbSC1RV77c4Qd2zZvwNflLtlNq/H6GhhTcv1Y+jUZJ42VdR1Qy1G4loey+J1zm4BVRZy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Muxiy+fL; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Muxiy+fL"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-88057f5d041so25401526d6.1
        for <git@vger.kernel.org>; Sat, 29 Nov 2025 10:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764440917; x=1765045717; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JU/Dzu+KEcHoz3D5+7iHkxFvIVaCxjJweQqxeG94cls=;
        b=Muxiy+fLcDry4IGyYe8Nk210xoG43IdaY5ijPlasjuzHzYu2Tq7iq/1EU8qu3xyDEh
         BRBGwuFOiagLZ7Qmw55FuMWuTWnqAW21tr+mxRXBpD4Bh5wtPf+YKUZm8u0VS9EbTZfo
         Ig9rwOzRkffBT5V2u8yIZFGg8wzBOCEEGZ5ZKDSge/JD/IfLHKBCfU55EVA8GThyOkMm
         flpRRl1SMzIIOsKKoXAql9DLSUmYgRtTTGDsy3yQUggbMa4B7tI6KrwMX1cADgmJYS6N
         9f26zMDPNCuj+FOAN+2p2PA/jWygspzoH9zAU7X1nawpwBSMjmejvLnTCfHZ44cj6DYO
         miGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764440917; x=1765045717;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JU/Dzu+KEcHoz3D5+7iHkxFvIVaCxjJweQqxeG94cls=;
        b=GzhljSeaAdVM8HjMrDVutgTtaVgOaoDpgbGPUkHophLAU5hTdNOLpZNWUThZJGk9Qk
         b/qbjkFdlYjcnflAKe5wbNz0tTv9g9nfWArEvrNq7ux5zS/MTzcjMpwiDtfiBdonPduS
         7vFiOJoENHdrgyfAqLQweSFo64edP+8wc6DD8b4TatrkKk2/LY4HD5eQFHJVZvcV76dZ
         FPzPn/rLJo2N+z+Fw15FUtZpHvKiBwbO+aiK2gg2ngqKQ+TcWGWxFCeENxNXvCF6Yj/z
         lPF5FBYHjwwdufDeaegCtl95xMwdhXvfHmBNgfiN6sHP+Fhqf79uZZ0jZwNM8cJwGO20
         MnUw==
X-Gm-Message-State: AOJu0Yz77tJjXrfkWxrapfefwMQmWXGyfQiKx7ZSgAdfMGnGKNMy7K5a
	ZOY4FQtkh7YpU5C18xINWTD0f/h2GO3edwqY+dVPRd8sklg0qh3WpzFNxjEviw==
X-Gm-Gg: ASbGncuqXeA0qRyZxmpfCf+4Ov1xTtliJXpS00hBZ9vrc5TKDH3SnA/TbfHjhM9vaJO
	XD2gl/jtcXPo7gSRzgLasO1YzpfLHlXt6HAEz8MkoPtG0KiEToS1RDFsd4B47ZuXFT25ViCreWo
	UNvBCSAglx9rw7Ztw1YXztFqjEXXcoaDScKORoIDTfpCzD7x35s8Sz/qVmDI3ybgBZ6qXn+KS0/
	YVO3YSP2EUp6vof+CE5DeyZVa/KhaYZLFCREfuWQKua+LBR3MpYTFIy90IA775ClQOuGvMstVF8
	pQX5AtONp+z3XVu2yjR3euZqfq0or4+9PwJv9dfdyhmyvzhLQ9O8mBgFnYBiPDhAFP+9YazNVKm
	h80M9YACh4ZBFpLLSfU1TG/j7brAeevJYskPRuxwsuPp5bjgUQ3xtyaUf/bHZ3ymNQoK6UjIe53
	ae/ExqLyXpP1SF
X-Google-Smtp-Source: AGHT+IHSG42lxR8tiLSK06dKnO7jeW9IetJPNhbl6sJp65gQvXrjMPAhADR5CeEUO+uiJrPrMqGVBA==
X-Received: by 2002:a05:6214:623:b0:880:4896:5d81 with SMTP id 6a1803df08f44-8863aee6cfamr305569426d6.3.1764440916868;
        Sat, 29 Nov 2025 10:28:36 -0800 (PST)
Received: from [127.0.0.1] ([20.97.198.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88652b69ff2sm51465906d6.39.2025.11.29.10.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 10:28:35 -0800 (PST)
Message-Id: <0866db0a17d88016617e7e626dc032af599679c8.1764440906.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 29 Nov 2025 18:28:22 +0000
Subject: [PATCH 06/10] t0600: fix incomplete prerequisite for a test case
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The 'symref transaction supports symlinks' test case is guarded by the
`SYMLINK` prerequisite because `core.prefersymlinkrefs = true` requires
symbolic links to be supported.

However, the `preferSymlinkRefs` feature is not supported on Windows,
therefore this test case needs the `MINGW` prerequisite, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0600-reffiles-backend.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index b11126ed47..74bfa2e9ba 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -467,7 +467,7 @@ test_expect_success POSIXPERM 'git reflog expire honors core.sharedRepository' '
 	esac
 '
 
-test_expect_success SYMLINKS 'symref transaction supports symlinks' '
+test_expect_success SYMLINKS,!MINGW 'symref transaction supports symlinks' '
 	test_when_finished "git symbolic-ref -d TEST_SYMREF_HEAD" &&
 	git update-ref refs/heads/new @ &&
 	test_config core.prefersymlinkrefs true &&
-- 
gitgitgadget

