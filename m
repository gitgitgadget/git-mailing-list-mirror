Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703A14949E7
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772552041; cv=none; b=Yu37Qs5J6XkpWQ22GpN+SblSiBItlrrfCKEloxbaS0O/NeAtkPi+UpOB9yYq0Xd2JNgoF2yexRaX/99SDRUygjabC0d9sDwb06ErQTQF3mjJ1to/IQvp/u1FmqtNGlEwAaAx+4nCnNBYwkApoigtG4ZC5u29seWNZPBAYcGTtQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772552041; c=relaxed/simple;
	bh=YosJL0K3PTX7DXBbQh64PY19+TANwjlXx5AsQvcROM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zm6Qmiez55FjMHGRKPOoUn/T1IT0N+WDCVkqt59Shqa29QZ36k3DfJ2T/N8pJlIzbRQTBdyvS5VHtwR5uYgxyrZfMi5WOGC3/+K8K83VDeA2FgwkG1W1mtmIJUndYT+dwv4Ahr+OLlv4lfhYhcJgHO2xn70JrF+EPYUS+P7gXiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVS0TaDd; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVS0TaDd"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-78fc4425b6bso56543467b3.1
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 07:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772552039; x=1773156839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9pYlY6NRSmu3nkcDbdIkOVyPwHc0OhQwKW7MgZDv1G8=;
        b=AVS0TaDdKdOjvaFEsqJTq/BS7mXy1lkMHcNYqQuDeBrGpgzMeBQ9oCfJogjPomzQnh
         RbIPfYiTyJCDJhuiBW422EgzmFN7zTtGBIHvaTfdwXwg5G2E/35ddmKP/qiL5d5E1/t2
         lYVNhPRetBE2ABW10gKoZ76aIunBLIyJu/7cdhehFqDmIDzmW3EC0NopC/KZwtHYCCSZ
         Inm19HkeI55+BjVJXQaQasL3cwsr0OThxr0k/nMbzoF9u1Hpv8zheTggspoBdaiPVxeD
         M9tcA5+Jn3jUV1n9TTKgoK8hFBrWauWLam3oS/WcpIu7TNOvhLCp8nLL9MtErG+0X0KL
         dknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772552039; x=1773156839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9pYlY6NRSmu3nkcDbdIkOVyPwHc0OhQwKW7MgZDv1G8=;
        b=YB/suLzK1yd+eCPyWKCVOEtZ9cqGCw+Y+bIBJXgv+2eCDkjr7F3Y+jOwCBHkuYoTVY
         7xItyk/PIQRvIiVp7jUIt7IMMQB6MjPAYoMDIeaLVYhsywUlKzrZl4P3RON3Al52vDiS
         Ec13oFDJD8gBUGOAhhx+JBzeuLBur8UszlCLNkkVcZ6McWZVUGFxQ0oT3buPNqUNJaeJ
         cNBTaYu2uRrtigl1tKHgmGOy4z8vlLlXIcneFCmkT54d562if1cCIR8UdtqOdLPu7/Y7
         vd5NxC/AoIObrt7EW4ZiQUhnQkt5zcQ7+Iyu/vVvi5VOYLYz1T9gmdzEruVYP1ZixP8l
         EDNg==
X-Forwarded-Encrypted: i=1; AJvYcCUlgolXL14lqEVo7QkOm9cgVT6YwUPhka1hgUJLiKBm1nHSLI1x+9eaCfnjrvn2M7OlOLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY0Br5KdevWyG28dzHlhH+80astkRxjVLjzGaS0wOz77G4Lp80
	244gSdCbr72fj8/epNd4sZcjxCcbFxBQfQjHNdkzvamuC7Q1pw8tF+cL
X-Gm-Gg: ATEYQzyofCB4Rsu2//+FPB6ryP4CTzt9t1M9itaaxsnsTDgN9lqYGAefhSZcHpoP3E2
	EM6OkqSpaHhwcqc1sNn5WnJUukkH+3p0eKQbVvSn+Oyuwz2ehXWhzp2SJGVfN2Bh0s1GUEDSuib
	/O/HUu+faNmkfXbWaEoFIFwjVZQsGrSVjtWki6B2RF0fTqPbRyTrAldzlvi1mPvXdjNWlriIotd
	r7AT2mfSArjkxpTw+a1u676PSo+HcR8GFekxq9ZiiqEwbhKbixos3/8qks3Wbu6k8rsI5IsF/Gz
	RDFLtnBU/VqC+SU0S+h21GNwmgc4a8h162S6QfnvHNT1OunAL1pcK4fuj9HhjJAxZY1QkXLnue5
	eIg8PPEhG9hLUjBB8elJxcg8TNBUJs04o8XIk4My/Oe9OvcdW+3qUDC1v7va8Uwp+YaAEVU0aqp
	Bfs/V05oJMSyFddM8Xa9r2u9FXL59Ymm1fLR78/aBAs/GI+AvB7yg1kLOs+1pjb9WKpI7/NCl5E
	k2k/EvH0FHt3DPRJhWgj+s0G1K7VoOVHX3zVYJRja/rE724n44Yu0HTinRKGWSRXiQvK00Bd7x/
	jjFYD4kF8b8=
X-Received: by 2002:a05:690c:6f08:b0:797:e1fa:9898 with SMTP id 00721157ae682-79885591766mr160434207b3.42.1772552039191;
        Tue, 03 Mar 2026 07:33:59 -0800 (PST)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876a8feacsm64364057b3.11.2026.03.03.07.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 07:33:58 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Alexander Shopov <ash@kambanaria.org>,
	Mikel Forcada <mikel.forcada@gmail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Peter Krefting <peter@softwolves.pp.se>,
	Emir SARI <bitigchi@me.com>,
	Arkadii Yakovets <ark@cho.red>,
	=?UTF-8?q?V=C5=A9=20Ti=E1=BA=BFn=20H=C6=B0ng?= <newcomerminecraft@gmail.com>,
	Teng Long <dyroneteng@gmail.com>,
	Yi-Jyun Pan <pan93412@gmail.com>
Subject: [PATCH v2 3/5] docs(l10n): add AI agent instructions for updating po/XX.po files
Date: Tue,  3 Mar 2026 23:33:30 +0800
Message-ID: <e8bf240c68f069fb7ee71b4e42a43f0798b51671.1772551123.git.worldhello.net@gmail.com>
X-Mailer: git-send-email 2.51.0.rc2
In-Reply-To: <cover.1772551123.git.worldhello.net@gmail.com>
References: <CANYiYbFM9+4xGmeBRNCC6VyW9EzjEFxEWHDNnOVhJNM73Ga_FA@mail.gmail.com> <cover.1772551123.git.worldhello.net@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new section po/AGENTS.md to provide clear instructions for
updating language-specific PO files. The improved documentation
significantly reduces both model interaction rounds and execution time.

Performance evaluation using the qwen model:

    # Before: instructions in po/README.md; custom prompt references it
    git-po-helper agent-test --runs=5 --agent=qwen update-po \
        --prompt="Update po/zh_CN.po according to po/README.md"

    # After: instructions in po/AGENTS.md; built-in prompt references it
    git-po-helper agent-test --runs=5 --agent=qwen update-po

Benchmark results (5-run average):

    | Metric      | Before  | After  | Improvement |
    |-------------|---------|--------|-------------|
    | Turns:      | 22      | 4      | -82%        |
    | Exec time   | 38s     | 9s     | -76%        |
    | Turn range  | 17-39   | 3-9    |             |
    | Time range  | 25s-68s | 7s-14s |             |

This change makes agent workflows more efficient and reduces API costs
by minimizing redundant LLM interactions and file content checks.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 po/AGENTS.md | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/po/AGENTS.md b/po/AGENTS.md
index 1fcef9119a..5eb1a606e1 100644
--- a/po/AGENTS.md
+++ b/po/AGENTS.md
@@ -72,6 +72,22 @@ The command will handle all necessary steps including file creation or
 update automatically.
 
 
+### Task 2: Updating po/XX.po
+
+When asked to "update po/XX.po" or similar requests (where XX is a
+language code):
+
+1. **Directly execute** the command `make po-update PO_FILE=po/XX.po`
+   without reading or checking the file content beforehand.
+
+2. **Do not verify, translate, or review** the updated file after execution.
+   Simply run the command and consider the task complete.
+
+The command will handle all necessary steps including generating
+"po/git.pot" and merging new translatable strings into "po/XX.po"
+automatically.
+
+
 ## Human translators remain in control
 
 Git translation is human-driven; language team leaders and contributors are
-- 
2.53.0.rc2.20.g532543fa46

