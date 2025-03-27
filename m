Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C6F213E65
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 11:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743076393; cv=none; b=c5KHzNSCV5/u7RzvE2OjKcTvGicPzkDaWS9V4uSmINkp222X3S/zLtnycxQSSiuXpffCbLznTGsM5c0sRICyeciAu36qsqRVww07qygKIYajBdVRRt86xHl02e5S280SDnjRxGhnPPQZiCi5eVvzxKUMdVGruT36bgNPkUAdmx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743076393; c=relaxed/simple;
	bh=1E2MIPGvJpZILgeR+y80nHde8v/+QmHjrMnRhTe5LRw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=T//7Y4msRhoSojbCfndZf3dkgsqVzSE+tRsvTIZpd+UqX1U5A2QtjFI/a50RoEW5pLBKdh0hfm7b7PTl5VR7L0UKtToBFOvD0qT93N/aN1nqiXpmz3ohjmy+fXoqicHnsB0bsLt0kG4NgtdkdtdoG0wJEldOwiFbfTOichafsUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJURUh8r; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJURUh8r"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39ac8e7688aso669910f8f.2
        for <git@vger.kernel.org>; Thu, 27 Mar 2025 04:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743076390; x=1743681190; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyKGogoHxgJZ9S+q2w13V3Jagh0709TpjxDMNF9xpPQ=;
        b=ZJURUh8rtNvXUC8QKxGA8Y2dYn0//ZIRjV2v++hthRlp5qVMLk6nH/oG2rG4H5S+lv
         BeDjTS8dwqsacIR6NtPunuantMt5IRiLOL82zNzRpZnNE4hR0KlcXrh2N8Inu0Fu4IXB
         /PNb9sqHXZpoVKyTo5qNjvW3x8JfvaJ/f3DKCQFseuB1Gp0wi2tMGG/BYsWV5Nyr+XtB
         KL49hY1fCfMDA8be1jnre96df43nkrgIasRLHqyUuTQtKHShRzEfvk4D678sWu3qVqty
         amH/p8SQfd7OH8XvasHFbXbk4AjU5/ZKzFZAP/Nka0M9ZVmyMxg0MIFOfz2mG++hpWHi
         rnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743076390; x=1743681190;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zyKGogoHxgJZ9S+q2w13V3Jagh0709TpjxDMNF9xpPQ=;
        b=nVlFB64w6vtDTpInAp8fpm9GSwDJ+ZuU2BYVatfpri7uuIhdFxmHIRq3wAJI9w+EAV
         wdUciBLWCt4Ddk5nUn9VPDFeuL683NH2eNyJ68rxAYBOSoe0V9i9LfWcegUEu90MFyUV
         u+jzswDSF/MOKm6DQQKiq+GEz9pKOoRhxowZPaW7cvcRqoj2XBc1CANTC5+BvUaG//bJ
         y5PZxHQoKE58YHasVCyrIMLGNnUjgJBnEF0PqueFXS0r1VJT1Ibw1/wPD7GGGtSPBQ8T
         w7PQw5S6C2jh3AGzRae8QKEgqqppNmQ+Wbga1KWJrhJqdFXTsc7m/GCKxJucGJ6Wrwsh
         E/Og==
X-Gm-Message-State: AOJu0YzKWSCWtHvLUhOIVjHZYR0yukqqGauMOb2GmX41QptfrBiUTxIE
	R3a2SXWANpFANKJlGMyAdebaHoVidnEz5s9j+NMOj9xUQ6U9G7ffmKz1HA==
X-Gm-Gg: ASbGncv2F3XApudOdIbx4y0AINvrIDQpxDpeC8/AEW2MuHjR4k2iE4Y+btuEYt9/7rh
	DGhuUTs8nUzkxZS62LFPGqMiADCIRZZD0w2Ufw1WWAQF3lbZ9l+FjBK1ABTWjVapTpuCQL9B0ML
	McB9r+dYT2lgUPNThN8HWitmrAm+C7EOceA6vkANkceeTadfsWtmG2GyTVEqDWwagEKPwi2VKku
	LqRlaIwDdc3LijhODug1LQIJnuRZ1zlBoF75Ras4l9PNLjSfwuEAomYgIKVS/atpM+uRF++wRzm
	SvNVj7x20Zhvu3BCNpDxliPlLJYtsTI8fQuQKZbmT1BeGQ==
X-Google-Smtp-Source: AGHT+IH0WDHMHhw6J5bCVWBNkR1ujpMtgTPXwGThNbazQJudu3ZljF/Fa0Uqdfpl6Dy1Q2HSmHE26Q==
X-Received: by 2002:a05:6000:2a5:b0:391:1806:e23d with SMTP id ffacd0b85a97d-39ad1740291mr2576366f8f.6.1743076389405;
        Thu, 27 Mar 2025 04:53:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a50c1sm19961192f8f.38.2025.03.27.04.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 04:53:08 -0700 (PDT)
Message-Id: <7239078413f6a223105939af1b56e79b9d302f1f.1743076383.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1889.v3.git.1743076383.gitgitgadget@gmail.com>
References: <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
	<pull.1889.v3.git.1743076383.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Mar 2025 11:52:58 +0000
Subject: [PATCH v3 05/10] xdiff: avoid using the comma operator unnecessarily
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
Cc: Philip Oakley <philipoakley@iee.email>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Karthik Nayak <karthik.188@gmail.com>,
    Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Chris Torek <chris.torek@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The comma operator is a somewhat obscure C feature that is often used by
mistake and can even cause unintentional code flow. While the code in
this patch used the comma operator intentionally (to avoid curly
brackets around two statements, each, that want to be guarded by a
condition), it is better to surround it with curly brackets and to use a
semicolon instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 xdiff/xdiffi.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 8889b8b62a1..5a96e36dfbe 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -211,8 +211,10 @@ static long xdl_split(unsigned long const *ha1, long off1, long lim1,
 			for (d = fmax; d >= fmin; d -= 2) {
 				i1 = XDL_MIN(kvdf[d], lim1);
 				i2 = i1 - d;
-				if (lim2 < i2)
-					i1 = lim2 + d, i2 = lim2;
+				if (lim2 < i2) {
+					i1 = lim2 + d;
+					i2 = lim2;
+				}
 				if (fbest < i1 + i2) {
 					fbest = i1 + i2;
 					fbest1 = i1;
@@ -223,8 +225,10 @@ static long xdl_split(unsigned long const *ha1, long off1, long lim1,
 			for (d = bmax; d >= bmin; d -= 2) {
 				i1 = XDL_MAX(off1, kvdb[d]);
 				i2 = i1 - d;
-				if (i2 < off2)
-					i1 = off2 + d, i2 = off2;
+				if (i2 < off2) {
+					i1 = off2 + d;
+					i2 = off2;
+				}
 				if (i1 + i2 < bbest) {
 					bbest = i1 + i2;
 					bbest1 = i1;
-- 
gitgitgadget

