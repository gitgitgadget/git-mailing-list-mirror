Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC0454918
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 16:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276758; cv=none; b=py41qS/2GlflmJLOKDUbfbFYGqQAr/hkuoxgHbIWitI55huXn4TZHXgfVH64qxDbL5DpR7so/FdRs98JbUsZFb7smKVxZ8u6TwrWs7WJLVQG2C6JO+dVY0IZakRX+qq+t6YZ+GmRBrF9PfOZ6YWfdMVNyT5LaFKQEWsq30s1MJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276758; c=relaxed/simple;
	bh=bLmeyXSHKM8Az49Ee1PjpFuNowdoVfPlCgQV1L1F/6U=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tFxbIIc/ULZV1JS9HV2xNx3fQT1C3/FTAJhLy4iMf4aMxC0tvv2TFz2xqcnYA0oGuOrH+6tqcpJ9/QVh8o7lAKoby8XzJCdcbmpBYeB1ehsEgQw9VbX9zb5TPYVCSp671rTvZFdTi4NMjnZ4JnfccZitWKEgC6Qm8zqKSLTeD6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQgdjc7l; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQgdjc7l"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso1935028f8f.3
        for <git@vger.kernel.org>; Fri, 15 Aug 2025 09:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755276755; x=1755881555; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRG1tCa/IrI9Mc4Lghqvcla/Of5GXD5DMJ1yUWYoUvw=;
        b=gQgdjc7l8Pe+neLCUaEPUGx3ecFVnTJ62kdcuv2/WsZGGiHeQ4p2UjgaNXtcFmUujc
         CXFUT4ttpaqdLVlnhziqwwMubiadmUDQO1xK/rQ6dwlavAgrNcQf3cNOHkAAFYVjQIfg
         j5CJFl/j1f8XUoCwnmESWrrYqUPn0iPy1F17FiG+x/3b5LoFQUB+8PrUowxyk4INFZZt
         evrv1AWtdRcb4I7zZ7LFzvUrpzosKI6DeUFXyvpKR5QJjR1bkQ8KF98XGyeV76i3Lz4C
         tZNe2iTrn5FUZ+0n/joz/QddvRgVkLFCv9UMSar6tszEqLT0CwuyjonA1XljvC/dbEHO
         MAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755276755; x=1755881555;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRG1tCa/IrI9Mc4Lghqvcla/Of5GXD5DMJ1yUWYoUvw=;
        b=jYAxeKASJPScQsiCYBcn1s4BZ7aD+/maMMU1i72QnZ12ug00lEPrh7l3MfUQRNCEsP
         Qa0bmuY3nEgiQk7wjigItJtQBkXhpn1iM5uilYRSwivcVHMeh+zHIrF594MOrZOflGK8
         7UrHFGQby2QVz0Yg528h3PAG1XkttBsI7pCe8ziMpeICq/h+MQsqJEyxITfLYGzowkdh
         qLrIUE4b2eV/XhhGqbYICo70hX62Yyd04KSU6N4hoAG5aTPBiYTODDrBQXLr+5XExSvc
         FtuG6HJxspDF4+nnJCiyLJddhbGZvcy19zrqA7e5ksP80a2S/kkeHjDQnP7ifB/zVSbz
         KAXw==
X-Gm-Message-State: AOJu0Yy/c4/Q3R5NLaWYSWI+8s0AOwFusRLB2uMD49EWdQeW88LI8asd
	DkDasy3srtxMOiRBDVgSiHRGKWXhAxE6NXrnQUdiCqbjxE3PcbkOjSE6vtBAqg==
X-Gm-Gg: ASbGncuzZrSA+caN93/rj5QbHGM++BkaQUonHrox8qXwTwMdOaq2wJbARpQHZLFR595
	PW8/b65iUQgZju3XbCXLh9Efy31R3UeXGAiWIcQBj+AJMd0g004DMv8+DY+/h1esWcRZKaUa8b1
	B1Te4b18QvrE1jW1yKFty/vbZhU0qAU0r7hSVM2+KPcTrLVxV4dgJi/jKB7Y+hnTHy/KX9FOYDQ
	4IRjlYPQwbgfAMAElwFb/6uMR4NEj98ajS9Wtxp62oQa3b/xAVeeMiolfQIp0C1yXv+qlDcJGYi
	prWBGXzXCVbNtaTuJUXc1JZy7MO/DeiONhPVUcIf9t3cRkJ980iw9FGYmLbX8Gf2lRuG6E77PXF
	vFstOlROQBq/PT7NdOiskJeAGGu7eiT//5g==
X-Google-Smtp-Source: AGHT+IFQNVWURARZX4fmXgtFcjEXXyuBWdKqw3CyCZanEYK3W30aiPJm1vgbxXz4H06h4H549vdxNQ==
X-Received: by 2002:a5d:5f48:0:b0:3b8:d6ae:6705 with SMTP id ffacd0b85a97d-3bb689218bfmr2234272f8f.30.1755276755103;
        Fri, 15 Aug 2025 09:52:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb6475857dsm2582113f8f.2.2025.08.15.09.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 09:52:34 -0700 (PDT)
Message-Id: <7ee6b0afe88fe4f5346776192a0df99c6b64de19.1755276751.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v8.git.1755276750.gitgitgadget@gmail.com>
References: <pull.1949.v7.git.1755006568.gitgitgadget@gmail.com>
	<pull.1949.v8.git.1755276750.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 15 Aug 2025 16:52:28 +0000
Subject: [PATCH v8 3/5] doc: git rebase: clarify arguments syntax
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Remove duplicate explanation of `git rebase <upstream> <branch>` which
is already explained above.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-rebase.adoc | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index e82ceb9cbfce..6d02648a9b3c 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -62,11 +62,7 @@ one of these things:
 
    git rebase --skip
 
-If `<branch>` is specified, `git rebase` will perform an automatic
-`git switch <branch>` before doing anything else.  Otherwise
-it remains on the current branch.
-
-If `<upstream>` is not specified, the upstream configured in
+If you don't specify an `<upstream>` to rebase onto, the upstream configured in
 `branch.<name>.remote` and `branch.<name>.merge` options will be used (see
 linkgit:git-config[1] for details) and the `--fork-point` option is
 assumed.  If you are currently not on any branch or if the current
-- 
gitgitgadget

