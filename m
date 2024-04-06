Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B5D1864C
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 01:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712366548; cv=none; b=YVq1/Y+dmpYVWLSibiisMHucUMmMYfCc2g2xVxLa61Eki9bm9sYX4ZnhtYKGDQqolvfx3W3X6ASQIp34Aov3JEWhXYPi30St9ZQ6iKR4FGci9YAdkGkV37BzViARWn4KDOrYPSDMVf0NibRD+aj3Z6H+p1rc/ptEin6z4HYAaG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712366548; c=relaxed/simple;
	bh=CmzZnMlncjuY3eA2HBuzS9D9pHnJ6nNm5KiVNgpysMQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pAv3QaK3+iiLDZWVnBdlXi6xAjj/dfakjdP01R+0e5XwN6HQ9OEiy+esmae1uVkapJ3g3cxSa62G/R9OgPecWs2Q+za3UNXgubQTlY6zPrONXpswAyxluczpmhGV4HAlStOchaEtMbT35kxI9oFO/ye3bSeBtkTYjFqD2mC7Eqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+A8vA86; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+A8vA86"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-343cd12630aso1423918f8f.1
        for <git@vger.kernel.org>; Fri, 05 Apr 2024 18:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712366543; x=1712971343; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Pfd4ptpPwLTQDjG1HgBLjWLc/ce3d0suhzBjCfS4sg=;
        b=A+A8vA861gdp+aSU926nNee3gh3np/Nw2QwQK7AnzG4ymu08EMlZdZqJT+HP0ueGkO
         QZ7yKChiIEfOCtRCr3YQ+gOccd1rrO5Z0zlFyknZ23eeqRTJNICv7jHMq3PeOdV7Y6LQ
         KmvgUVdcRfnt66kEP+nIOtNeCbORr8OfjGF4wHHbKSPLuoLCrfpe2AXFqC5iHHkEwOYn
         mEWWn5JAReElM5WAdycpCEcQu68LDBJKtPNRVhZ3NdAe2a1U9nmSqEwGVIsNFMtPM+JX
         GpLVqm5juNwdEhq7zlQYCYwZ1fzDTfjs/6CW7I8ggMTrYXljrJh5QgQDgZmv/a5n8Tk2
         MANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712366543; x=1712971343;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Pfd4ptpPwLTQDjG1HgBLjWLc/ce3d0suhzBjCfS4sg=;
        b=sIlYKv64Qk7Cw20n2BMEt+NFq7OV58OPy+mv+gl0RtTUePeF75sULncEiPwD1jARMg
         I38pgNQwqVMP5QE9yW/v+EpmH2ybw7Ozz7rvAhwbUP1xstgWo5YgFxw2Ds6j09NiqOgy
         oePAN1aOoljh3n9pU/ARHfH6v5TAI2Ie3f6fP/w4F+D00Y6tqnt6udqW7MkWCBK0YVge
         vlMSLUgFSMnz7lAyPdAl7tQvbqkTt0mjXcFLNcn7bWwm9BrDXvywfAvWehPyqEW3oJiE
         2AvCgb2mX2tsc57F26LEkXL0Bwy4aNeBg39AUKWrtEcmengtHL3CKO0+xMPuLyzX8ZOV
         rXaw==
X-Gm-Message-State: AOJu0YxjtfwKyxFton7W76C2V+bbybMVUS8GebfZ3MKGMY8Jy552y4mY
	HLec/X3Q6ZliPMUHGGu8rUz/uinDM5wJlePorNsbjNuJe3Lqf+EKmf7+QBrO
X-Google-Smtp-Source: AGHT+IGumURzZ/xkgmHsEKGEOZVtiz5SiOZOyFUny1M3PCA4IrtPdq/rx3MOaNilJjlgVmIKyfB04A==
X-Received: by 2002:a05:600c:1d90:b0:416:37ec:4bf9 with SMTP id p16-20020a05600c1d9000b0041637ec4bf9mr176242wms.26.1712366542912;
        Fri, 05 Apr 2024 18:22:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d668d000000b0034354a99d43sm3214484wru.43.2024.04.05.18.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 18:22:22 -0700 (PDT)
Message-Id: <fb06d5ce247c17f61f0c4f518979c76753017442.1712366536.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>
References: <pull.1704.git.1712017205754.gitgitgadget@gmail.com>
	<pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 06 Apr 2024 01:22:12 +0000
Subject: [PATCH v2 4/8] SubmittingPatches: quote commands
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
 Documentation/SubmittingPatches | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 48b270b4c48..24c7041a06f 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -403,7 +403,7 @@ Before sending any patches, please note that patches that may be
 security relevant should be submitted privately to the Git Security
 mailing list{security-ml}, instead of the public mailing list.
 
-Learn to use format-patch and send-email if possible.  These commands
+Learn to use `format-patch` and `send-email` if possible.  These commands
 are optimized for the workflow of sending patches, avoiding many ways
 your existing e-mail client (often optimized for "multipart/*" MIME
 type e-mails) might render your patches unusable.
-- 
gitgitgadget

