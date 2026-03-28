Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F58333F5AF
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 20:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774728202; cv=none; b=MKyxaT2fqatj/Ca5XpBrj7OjYKn/DsuyuPj2QQYamWrCkzg2ym/5xBfacEc4D5/QVkM4+1SaRzfz+4XeRDEfheTJoxpXFdqn3svwlx5ga8gJWwNXkeuWP81aUy3cNADWmrOdGbzf5x83wlm14Sxts034ut/ga87BVXB02/41ulo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774728202; c=relaxed/simple;
	bh=3o2IqqKJmznkTfeOq0O3GBXLgDzBJRjPWbBmO/vYZjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QWmUFx9FBfqHuRJcx3A9Mu31TgWVGB+xp8704hFH4YIYUKbsiZ6DrJmMsE778Bxgf7nqUfFfiSrTfDc+dB7XUi6ZRshSUk3BGTN+/7WL4MhZskOvuZvs4D+8q4/sDd7COHguEpRcX2X3xUD72OK9PCiLqnuIvSf7Rz+sQMJP1+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTOLmQ9k; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTOLmQ9k"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c736261ee8dso1177083a12.1
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 13:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774728200; x=1775333000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWe0wQN8wBzymQ1BGHi96/37mgOouKjFkCMEGe7oKTQ=;
        b=hTOLmQ9koleaNZ6hEVbSaeCFVoqKrwPxNACYR9xzzlv6DuTjXZwjDi5uIwJ/ZZiGX8
         rsdzuGg1HVUE/SuK00Hy9BbLSjIsqELOgPTskTwTDajdActkHhWYQrtZ+EsvrOXcj3A1
         e75dNiZ0QF9OxxOQfdRdzQLsBlpFPAnhlSROwtAdmGcIZ/ODn4PHDq8sQ/x1eN2irCbX
         JFWE7JxUtT40Qequ5tW26H8oEtdwv/3mGmS4gWvoWYQlKbtsO0d7qw+kwwHdQDAQlcD1
         pvjEgZRKvQ73PQ7DeVTe9EEiMQOJugt8leOCdcklMlgO0kTMMyxwrcp2R9hC1zh0yQ3Y
         PETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774728200; x=1775333000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rWe0wQN8wBzymQ1BGHi96/37mgOouKjFkCMEGe7oKTQ=;
        b=a0Y1/UyRV+85PM4BhLL8tBINqqsNLTv0CAtT1M1/ENvyVppj0riJ2KkkXI4sBnEkiG
         LJjCiLQt9eet1rUPh2LnfKK6yP1tFqmmvZKcL/EPohd4eAGYw1AWHgtZXwFDok0cin0x
         5XWTlJRUhjSjhhHW1M5tELVMcx+Gozo4oxfOGNyekjMABdTGZCYiv8sH/PBxHNgwDEjz
         dclCshFXWW8gBcW57/TJIivU6CnbruX+it7eT9D3pHa+cJG8euiW6ngMBrZaJbhBp+2K
         K6IXp0tOFDcVI3brYNVvHSjIuwmGI0exUHrCi4Fqgr969PXfHdGES0bhhdFv2pfE9Q3B
         sp1w==
X-Gm-Message-State: AOJu0Yw9IkyUk3KU1ukSXt94m8C3bSxkDI8jDeauwvtWEBJURXoCTisb
	dDT7ypj16IFPZIwgx8YIRU/NHp3inrwnS4d21Juxj19yXCSYEI21auo6jBl6WMBv
X-Gm-Gg: ATEYQzwutlPHlPJWEQv5kZdU2KNjF/AgMk2AjoSwdOhThTqblWioa1dqF0fV8mfaFFL
	9mC0i8vKMs37nCvoFul046z8s9mZGO5xZWJ2ct+0BLjO/GjEY/X5c8lvm3zFPMilVsvq9xWLC1p
	K6nsWwmqHvKKLAPjMjzT45npNA0/jrDOD9/u/CcpX+eTawt9haZerChAd77JORzAL9bJ5LDYFTE
	cYlU7jtR0SXop5+sHSxv0S7BoOrpHTm492dIjFrBtN3DIJYlqHuHRV2kzjBPycJIKxQ4OZKLF3F
	ASWB1kpIbnAvIMIX26tZgekmf29RwhcYwsQnaNsEQLZaWGLu8OMqqir1pQ+SBcDg5FmZIypyTD2
	WDflIuuQ4BHkckAL8QDbkPzSQjl543cLoilwhbqbsIalYGd834CUUhQjANj04MqIUOOSdsOPDY3
	MySbup6Cmq7eSFJQjzn2VifP2QunY2Qy11RYc7R+IuLZCsLg6VMNEjfXz2nX8PkpGt1Sadb2j/P
	pyYdCduBQ==
X-Received: by 2002:a05:6a20:94cb:b0:39b:f026:6f7c with SMTP id adf61e73a8af0-39c87ba1d3dmr7999832637.49.1774728200236;
        Sat, 28 Mar 2026 13:03:20 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local ([27.122.242.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76917bb31asm2359786a12.23.2026.03.28.13.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 13:03:19 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: git@vger.kernel.org
Cc: Trieu Huynh <vikingtc4@gmail.com>
Subject: [GSoC PATCH 09/16] t4140: avoid suppressing git's exit code
Date: Sun, 29 Mar 2026 05:02:48 +0900
Message-ID: <20260328200255.247759-10-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328200255.247759-1-vikingtc4@gmail.com>
References: <20260328200255.247759-1-vikingtc4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update t4140-apply-ita.sh to redirect git-cmds output to a
temporary file instead of piping it directly to not hide
the exit code of git commands behind pipes, as a crash in
git might go unnoticed.

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 t/t4140-apply-ita.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t4140-apply-ita.sh b/t/t4140-apply-ita.sh
index 0b11a8aef4..15eef0a2ba 100755
--- a/t/t4140-apply-ita.sh
+++ b/t/t4140-apply-ita.sh
@@ -79,7 +79,8 @@ test_expect_success 'apply complex patch with -N' '
 	git apply -N complex-patch &&
 
 	git ls-files --stage --error-unmatch test-file &&
-	git diff | grep "a/committed-file"
+	git diff >actual &&
+	test_grep "a/committed-file" actual
 '
 
 test_done
-- 
2.43.0

