Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC361607A4
	for <git@vger.kernel.org>; Sun, 16 Mar 2025 06:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742108349; cv=none; b=CSUQCmqzc5KVL2v0mws1gvIn5v8gph2xYNNIzxSE/xWAANfKP2uhbuWERNoER1w68z+CNOoORNaNbaEPg5h8TFVTGr4Rb8o86JNTuaGLzdLI/8qvuI86v406OPKKoyMPOw1mMTHf6lykUupy6NU0yg2AFJI6QedT29ueg/z0M1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742108349; c=relaxed/simple;
	bh=r1D1q9vbFEDkxnTBkh84ndO2VKBQ6/xqNfpfON4jhKI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=J1hdEgQjG2QPVQ55vXU+D9dSHStCKpPQHjWlXb6QwT+Y6d9frTKX84dBxU1HXFhydpp5JD0qUiSkJ0+J3RKqHJe+CUAog+fXPM8ET+EopegfW3bRrw65yeH5luRJyUpjx25QspBci90yEdNKZs+LGp7qw+45rO7F4kBnLOT+DTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRwi5s7e; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRwi5s7e"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3913d45a148so2894492f8f.3
        for <git@vger.kernel.org>; Sat, 15 Mar 2025 23:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742108345; x=1742713145; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0OTLFfr6Ixlpi/43DgGt8U/OrRG926lRjCOafepzBE=;
        b=QRwi5s7ekOOji9eUTjIFxTvRuicvWyQJDLLxZvgRXPfcPbAxW+8nemgvZcTZU9FDsr
         fgiJcRRXO3C3nxpyBWDkF9xTezydq3NMGkogGZDMgEPUNFu2DScf61bFzcRhADd2XFsT
         C12rivIAj907+V4TyLUPBR9ihe6O3DuVYgnsdiBNbjSPo4VjlhrtHDJ3i2lLqj6GSFGf
         X8RO/G7RrcEESvLXhSugsm9cmkINgVhDHN2CYR+3nAzamUqGWxE0IwG2cSMALRpJMmzv
         cHrfsSp52pb05SF5Ky6MQMRlF5c7EzH6vjmfAQoh4Vp9PDrPV8pCBZK+n6qHBPXaQ4aJ
         zOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742108345; x=1742713145;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0OTLFfr6Ixlpi/43DgGt8U/OrRG926lRjCOafepzBE=;
        b=pGXN0wQlPCWyR7w4rfeXH11mQcgOu/EvLzgcsjWXbj1HCu99rhDz++si1DZU1TAkkT
         oq+oLYupaXyF6+ahBLLyFgNmNyhRP9xh7hCFceT0XXsjEgDsNv7vz1Ip/4bA3ruGjufl
         4MwUZ+Ayga7+tWQUfh/lmw7M2zeJiOK4YcbAOctocBWjO31bJuBrEuPk1pa5X1We5VT8
         YLdsoXIFYaglCeDvt1D6V9Qa5zaewt5Z7Q366pD/1g90I9pOmdtZZZXm08ZOZMwVcIry
         09ZPqJ6yEWpklSOTnKe0vUcv8kOoGIyvlS05qzyLugQtsH5JcGW8Q6z6x9gagJCVv3/L
         45bg==
X-Gm-Message-State: AOJu0Yz4fIfGzEdRmJNB0TpWIGYpi5Xy/n7iBgHSMHu+V0Tp2UsbmBPg
	yfySVno+MmVA5YVp9uUhAxaMRh6byxXiBkbNg+kqDPQsPRvfRy2idkSKmQ==
X-Gm-Gg: ASbGncu+2wZOQKVqgC9PxtnxsVGEXwLGuTTZtPqL8tFMm84ey8t/owsIcmTvmbNv1wg
	zrVM4bx4lnUXEmrxaWD7WVDkIpiGs/6+sf2iBv85y+7xSYTLdK/tcesIN4981r66dudvpRm9aCX
	lxU2+rf+wMmaW+voRMcy8behHJ9s2d/n30pM1E5buaazssCqWjDmBdG/nMyMnWaDBhyRED7T6g3
	rIdEzPZdYvS/VBOaxjJdTqpXvMy2VQyJQosqoCaJGIoQhiPXWgRZISyMI+8fiR2X57zSRzl9xem
	HzZUsj561WiNYWizjmMa9KrFKvCaOkXYtfyhJNVmLP4ghDML/7VusuDp
X-Google-Smtp-Source: AGHT+IEKuFb+0uSSozmHBYGcKRcK+XkSD9eDUDk+AxkOKt3nSS4ZTv9l9PcZpjOCwMjw3mLPOtLBvg==
X-Received: by 2002:a5d:6c6a:0:b0:390:f6aa:4e7c with SMTP id ffacd0b85a97d-3971dbe0f3emr7578780f8f.28.1742108345265;
        Sat, 15 Mar 2025 23:59:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6e87sm11578127f8f.32.2025.03.15.23.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 23:59:04 -0700 (PDT)
Message-Id: <456a30ff72a3126439e8253238423b37b772c914.1742108339.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1882.git.1742108339.gitgitgadget@gmail.com>
References: <pull.1882.git.1742108339.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 16 Mar 2025 06:58:59 +0000
Subject: [PATCH 5/5] merge-ort: remove extraneous word in comment
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

"is was" -> "was"

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index a12aa213b06..9efc2285a94 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3423,9 +3423,9 @@ static int collect_renames(struct merge_options *opt,
 
 		/*
 		 * p->score comes back from diffcore_rename_extended() with
-		 * the similarity of the renamed file.  The similarity is
-		 * was used to determine that the two files were related
-		 * and are a rename, which we have already used, but beyond
+		 * the similarity of the renamed file.  The similarity was
+		 * used to determine that the two files were related and
+		 * are a rename, which we have already used, but beyond
 		 * that we have no use for the similarity.  So p->score is
 		 * now irrelevant.  However, process_renames() will need to
 		 * know which side of the merge this rename was associated
-- 
gitgitgadget
