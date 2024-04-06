Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE3B18C36
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 01:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712366548; cv=none; b=quUhKfi87VT/CTbIHo94Jim2HQMM34UXmwaFKKQzQSq4FOy/DoKuDiiW74qEhYHsHhrOXtuPFROkoshZsmcfYjOt8Y6wIQccQ9jiP3fOQJn2l/w1+dHYuMRCA4rIIa+cP+l3tPq7l9XC2m3bSF3F9nuVeykI5dSQrgUihUzGQtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712366548; c=relaxed/simple;
	bh=Jy3UQAwLerFCkgDypFQwtqYPfZiq+iQrYx8hkg/QbHg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sr5wO/E5ZtIL/21l9tPm5MaIcieI6+SSjp5UGDkM4VAi7GX7KJgikg4pd0wsc4HGyzjuwBkk5wCf5uxNiVJv1AZvy0D+fYjkMee+H6SGFkK8SECkWsTJCCWT0tEVvPSNFhmt4o0BD17UKjXigVGBi9QMIvQOHwpgClEQ6nxMx6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TaY18dDl; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaY18dDl"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3454fbdd88aso70704f8f.3
        for <git@vger.kernel.org>; Fri, 05 Apr 2024 18:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712366545; x=1712971345; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8H5ODmcle9HDiLrIV62Z8QVANHMAPlqooF6ONKnyKAQ=;
        b=TaY18dDlqtAMlOSZInzoRaY3QlkLvthMQx4pm1fhrQ5k0BHaR5AiQW+t9NsEAHS1TA
         G5zpY0M82lnVIifecstKcZ697Z7rh7rjQQxJZHRxH1oXEI733GEN2kVVT+OTF00sycVm
         5ivMhAsmGLQ3SNZklHECePjBsDds9AfdvNP1tAy8IeWK4uc+3ENQhHkzCx0tcMViOnE+
         12rfkRYrRGpBjlJtlI49xMZ7f5qQwGgV5HFcaM9GP0j/vfZNPu/+lkIbdRSGOB7edKd0
         RxyuRWyufQZfm9IzO00cJ9gwscpWzmRBXtiKAt+1mbyeXTIKHF07v8dwr2X38sAbNLZd
         274Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712366545; x=1712971345;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8H5ODmcle9HDiLrIV62Z8QVANHMAPlqooF6ONKnyKAQ=;
        b=qLzJfPh/Y3zKMaK4Q3VlK4FUzGheGja+KutFnaHLS3wU4aUrC2WgJqIRjEldiDlNpk
         7l8NTKy7cZUcN1CDQIskyxsIAObLPACXnIYdNsIeFpykfjMF/8vfm2MsD0bbUSLsCDYJ
         An5hXLrh8N0EEAMaId34VaD/M/gVTVi0UKBzDBXqlcVas4ogmQbqzUzoWFRty9y03hjY
         vWAV6trBfxRtARUe530sYUzpgmZKcLVlUYEnN9Op4rGnObgN/DwBp2OK5XRHuVyUPnb3
         Rpu9iEBvqKoW2/pXplF6sRTBeQv/VnMBIvskl08u/LcSUjMeehoW+m9Rp8yrjJOJKPy3
         TLlw==
X-Gm-Message-State: AOJu0YxsuXGvDIKNPml0hCaAkmAQryeu3M6KriiJ+tZSMiGDdLM3YgGT
	LPc1dNnhtnSwNOtEaMsDoswZV/eO4tHYU45VZ0ARPuLslTOYnpxdton12k/Y
X-Google-Smtp-Source: AGHT+IEgi01jrTDW33u8hFujMLBejyHuoZC7pcJKnhAkViF91EB5RxUOJfDDU0UMxZvXfW+hkoRbwg==
X-Received: by 2002:adf:e44d:0:b0:343:ce59:c702 with SMTP id t13-20020adfe44d000000b00343ce59c702mr2751112wrm.50.1712366545379;
        Fri, 05 Apr 2024 18:22:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q18-20020adfcd92000000b00343e5f3a3e2sm2822263wrj.19.2024.04.05.18.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 18:22:24 -0700 (PDT)
Message-Id: <326afe1331568b4e2efbef12b8beebb263d1cfe4.1712366536.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>
References: <pull.1704.git.1712017205754.gitgitgadget@gmail.com>
	<pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 06 Apr 2024 01:22:14 +0000
Subject: [PATCH v2 6/8] SubmittingPatches: dedupe discussion of security
 patches
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Jonathan Tan <jonathantanmy@google.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matthieu Moy <git@matthieu-moy.fr>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 17db961bac4..311f306394b 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -399,12 +399,11 @@ letter.
 
 ==== Choosing your reviewers
 
-:security-ml-ref: footnoteref:[security-ml]
+:security-ml: footnoteref:[security-ml,The Git Security mailing list: git-security@googlegroups.com]
 
-As mentioned at the beginning of the section, patches that may be
-security relevant should not be submitted to the public mailing list
-mentioned below, but should instead be sent privately to the Git
-Security mailing list{security-ml-ref}.
+NOTE: Patches that may be
+security relevant should be submitted privately to the Git Security
+mailing list{security-ml}, instead of the public mailing list.
 
 Send your patch with "To:" set to the mailing list, with "cc:" listing
 people who are involved in the area you are touching (the `git contacts`
@@ -427,12 +426,6 @@ Do not forget to add trailers such as `Acked-by:`, `Reviewed-by:` and
 `Tested-by:` lines as necessary to credit people who helped your
 patch, and "cc:" them when sending such a final version for inclusion.
 
-:security-ml: footnoteref:[security-ml,The Git Security mailing list: git-security@googlegroups.com]
-
-Before sending any patches, please note that patches that may be
-security relevant should be submitted privately to the Git Security
-mailing list{security-ml}, instead of the public mailing list.
-
 Learn to use `format-patch` and `send-email` if possible.  These commands
 are optimized for the workflow of sending patches, avoiding many ways
 your existing e-mail client (often optimized for "multipart/*" MIME
-- 
gitgitgadget

