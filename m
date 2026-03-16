Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9E1374730
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 23:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773705310; cv=none; b=qGVpZYaSj6k+6H8BB0Ih8rX9ivqhFPUEssUbQ9ofDBcTtjpVRIGS4lXrD7JcXGM11JhxFWWr1auviU9mikvFgz+DfxP3SyO0tWwFf2spa05vXCLJ9+elgFdTyRf+Jma8Mugxg4/fbPfWHTvTegJ7dY8lr5Y9ZhHPQSr9T8mIASk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773705310; c=relaxed/simple;
	bh=Ez4fBo6D2+qaaNB3L9KRc8pl8pxW1U8S83tCtoIRsqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BGSHSky6b33HWbQ4687V5fw3JSWvacoWdSAgWDVh4PH6pF2aJWWHjlBnIDZBaD5Dp38Rs1MELbJyEAT+rTLWG2RrG3OQuYmqhO/XC13y7Spev4N4JgiILLe/E2dam2Gg9S5xApHs/t2ImyrffJMMxvtNpdRuNiBe224TyKuZ+HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DiWbLdRR; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiWbLdRR"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-78fc4425b6bso49731127b3.1
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 16:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773705308; x=1774310108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXvYF9OyPjwrEe/bos3NDYm/5poAWZF9DQeUKHevChY=;
        b=DiWbLdRR/lnyB+Z6IRQ2iEfEHaoPDHe0tNcaliuMCwS0GGDj5zf1BpmtPChqeLBzlU
         xD0K7d+qBrPJnj/dahVHkwpUoKaKJcQbiffhIVlcjPgXYZjXQ8SaVKQB2CRaPEqJwNwg
         j0yBX14wg7wAnZQqgkM0689Wf5cAN8eTG8exNUzfFy08muwDdtidXCZA+KHYK7q8RTm8
         GGhiYEP36EnYvAzQpZFhkHDMJhaf4cnA8HQeVXCUwC9lF1WSTJ6Rnk/7yPNgjU2YSe0C
         DE/qQZJzCUr7OpLlTO5wTkdx3Xy5GlwFV3Zr8WOr+XSL5lV0zfR1tiUgiUaaNrGpC6vf
         MtsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773705308; x=1774310108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TXvYF9OyPjwrEe/bos3NDYm/5poAWZF9DQeUKHevChY=;
        b=MPIekbIjU2zVeRURrj9pkRt5h8A39mECre2KCD11PP2B2VegUJUCMGtHkNU/Smv2Cs
         CbrPbGK52WlahXSCcaXwByCGDtbFo7sKJADgMJh2Qtxr20MpVN045N1Lc2ROgpqGUXCR
         BR7TBxzdd8rDjb7Vh0/+FJUxZddWB1N+za5ckpsid5TSUWbR1ehdN8uy6VkZZ24r7O3e
         /bjYekLNHX1lqLCweuHtatgOT4gmycySpASk57rrh+H95LPrCzH19Y0aWyMeKE83/WsE
         v+NVqyJ5ILsWW8h4OTE3C9sxgIB3kA0TnB9fjnrvR6QVHNJcUGX4C4gHg22Ppmosi/SE
         uxaw==
X-Forwarded-Encrypted: i=1; AJvYcCVwIdGraHjUudlSnoxT2+LANcnnoWFPe0MBdkNpz0Zviq0Ko5nP2mEiajR311Z566W+3zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ5RqT47gTahBLN5XdGyX41NrTGrx3wYiiyZL6M1ICS60dBZR4
	d8HKQmYI/pK34S6j6z4FBcIbF5jpcZu+ALA7Xkcd9LX59EQ2diZENpfX
X-Gm-Gg: ATEYQzxP+3Kd5wMPEAHHgebleUbSFmmFJrFsGnXDjGUxr3YIVcSyzO9qvSLMsNbdU8Z
	iqzSd/VsnpzRAw6nFJ18+GusvZ1i1RwyGf/PFevsHZ6wPzB7Vuc+mJ91pnwTCTYZmxg4X0ogK2d
	b+EptoA8EES9c4VzTfiGB60dsTRkB0kNdJOfTAiqOrrMcYNoRbqQzwPHGWSlBF1E6pEcRzSLGvl
	bmWcZj5gTC+q04ExR4mqk38yzmlhxEMPpFKPNHaKnZ2jQAiPDNWxM/WRTbU5aE3waBSZDQrdJl+
	n9u/cZhRCsk9Bm7cGn6qBNGRCCYa4w24ygCQ/BykoOMtk35b+91RpBkI0mheEGgJ+GS9YQ39BYS
	dWmdaKan0sHpNZd1STzlEOp9zMu3c8EvLXZC9JWpumjkWiRwKePoTOZXZalO+MWiTKKkdkdLv/3
	J1FIKmk0YK31vYVjheE67cmlyUNyghf712Af7gyifpxGnic1RpM4o102/dggdpArI8B/nNVAK/m
	3Ix9bWwzpzsKvGC7ZwiBZa/YurMh7rD8aUT7kAMEWeV/cOeH+jl60WZy2PhLAKZCTJFlPXC5rg3
	nsVQLulElpc=
X-Received: by 2002:a05:690c:e0cf:20b0:797:afeb:de93 with SMTP id 00721157ae682-79a1c0720aemr124090907b3.12.1773705308138;
        Mon, 16 Mar 2026 16:55:08 -0700 (PDT)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a1fb76793sm56812897b3.38.2026.03.16.16.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 16:55:07 -0700 (PDT)
From: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
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
Subject: [PATCH v4 3/5] docs(l10n): add AI agent instructions for updating po/XX.po files
Date: Tue, 17 Mar 2026 07:54:47 +0800
Message-ID: <88f9e2e2cd88a372cf3dc705d211cabb64144ce3.1773704908.git.worldhello.net@gmail.com>
X-Mailer: git-send-email 2.51.0.rc2
In-Reply-To: <cover.1773704908.git.worldhello.net@gmail.com>
References: <CANYiYbFM9+4xGmeBRNCC6VyW9EzjEFxEWHDNnOVhJNM73Ga_FA@mail.gmail.com> <cover.1773704908.git.worldhello.net@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new section to po/AGENTS.md to provide clear instructions for
updating language-specific PO files. The improved documentation
significantly reduces both conversation turns and execution time.

Performance evaluation with the Qwen model:

    # Before: instructions in po/README.md; the custom prompt
    # references po/README.md during execution
    git-po-helper agent-test --runs=5 --agent=qwen update-po \
        --prompt="Update po/zh_CN.po according to po/README.md"

    # After: instructions in po/AGENTS.md; the built-in prompt
    # references po/AGENTS.md during execution
    git-po-helper agent-test --runs=5 --agent=qwen update-po

Benchmark results (5-run average):

    | Metric      | Before  | After  | Improvement |
    |-------------|---------|--------|-------------|
    | Turns       | 22      | 4      | -82%        |
    | Exec. time  | 38s     | 9s     | -76%        |
    | Turn range  | 17-39   | 3-9    |             |
    | Time range  | 25s-68s | 7s-14s |             |

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 po/AGENTS.md | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/po/AGENTS.md b/po/AGENTS.md
index 94b7aa7f28..f2b8fc5100 100644
--- a/po/AGENTS.md
+++ b/po/AGENTS.md
@@ -59,6 +59,17 @@ When asked to generate or update `po/git.pot` (or the like):
    command and consider the task complete.
 
 
+### Task 2: Updating po/XX.po
+
+When asked to update `po/XX.po` (or the like):
+
+1. **Directly execute** the command `make po-update PO_FILE=po/XX.po`
+   without reading or checking the file content beforehand.
+
+2. **Do not verify, translate, or review** the updated file after execution.
+   Simply run the command and consider the task complete.
+
+
 ## Human translators remain in control
 
 Git translation is human-driven; language team leaders and contributors are
-- 
2.53.0.rc2.20.g532543fa46

