Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD042F0C71
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750869829; cv=none; b=rafxVBJqLV61XO8DwikcjI5b5uKZYQf07sDzJ4dbSNvGajQsL9+9l3dS6vx29VhrQRDTl8OEDCZJbRV2zZ8tV0v0tkBD+wK7ljvP9dVHGeFgFcxaQSmwB2J3Rrbq+slHKWX6DFgL7CxUuNqm/2/VG+lbyFiXTEVY86xWXPH6ZQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750869829; c=relaxed/simple;
	bh=7HCbL16RcywuwmWkey5Bd/URz58cvE7a/+2zbPtM50I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=in2zRjPqth2TQjz7eOEsVBunTnUnsZoSxsnqr5Tf57JEWggR6ot/h+PrgSY8RbMEEo2DzbnWnhQwvug3ss6DJWRHZM4GebjFQl3YL5y1Yao5Ize/BbvTMPxSKenysE3smVbV8eiwctTpyiJ7U41ER+z7DOECLl/LHtn/yl/6EsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+ggnwsi; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+ggnwsi"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6088d856c6eso85265a12.0
        for <git@vger.kernel.org>; Wed, 25 Jun 2025 09:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750869826; x=1751474626; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KLdabKtgBwzfYYUeosl1IkKDL6Imn/otrXTqwuBQ/PI=;
        b=W+ggnwsi4ltYHuKc7ILJc13/z+Zz0EWsGPgt5g6tGKpvo0WAydvbg609QfDFOSvTQT
         L922Ts3+LDmr4DVDeMltj2grTCaLtagPRhptPiI/Bwf0AxFA2QYCqUWU/n1BPZPsS9CW
         +Ycmvn8gbplGpftS/fxG3l3Qvyz5SHXK1447giV2vGFoaislHjvn/yHK048LgM4ThNxq
         bXIuIvU6r9KTt6gbiEJ+aAKdfU5R8I4/iyp3NKpnKhIe9AALmp4FAtOzytZB0znjIFzP
         4OL1OVY3lKthh892VWdUr0PRbSV+kxHbTe0+RJr3fu95K5n+xz0qJG+c+w2CDewpY4wI
         wsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750869826; x=1751474626;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KLdabKtgBwzfYYUeosl1IkKDL6Imn/otrXTqwuBQ/PI=;
        b=J75uojjHW7r17xn6cws3AAHv+JPmdPqMkOL7vFTaYO2ZNJq6GDGyW3slecvZ6bwJtz
         oiaUfPV9pFrKkElcdKBVmM9F9TIsYdBskyAOF/yWgFxyQKeKUPArGWlMM+HansAJKX7/
         lWgFI2isz48XJzu7CFZA+dHFJPtsRLSz+01/iNFt2CHMV4lELzFXFAc6czmKJGkmhZxw
         vqayF/OkGVbxpeKyBRFy0ZwfIu6i0FZRTWlqNNb7UatMRrgYn/aVovupafJuOntC+wFb
         FhX5+EtAHK9ShLMYB9Ik3y0tPNu02fThmNaUBhFPzrDvL8nZddoTMAM+YETpganDEZV1
         eJPQ==
X-Gm-Message-State: AOJu0YwJPae6xtW87PEA2rvzGtxV64BgQi1tI1dUomvbzoVVEBw0mTxa
	Wj8yyishPLRzWGZ3io7Uo4cBgh35xtP+lIUtDfqogR4NJgxN4xrA4UzU7l8Tttwga+E=
X-Gm-Gg: ASbGncv5RWcNlr/wwfidjuihwYnRgWkIWqFqiodTHyIKyplvUCTPl20eSoPEWfHMetm
	F3lKHMmwy7GmVJ4utGlI+HF5bAvClHkMLzq3Jqs9jwl8TPZYH/Gevtc6H6om42CMGTT5EMGoC5D
	+6coHzo/Qgw7CAUShJFwBxkLDi/gCexQzSbPW6H0XXGUQ8TWjZ5BrA0+ptbD5G2clXdBFk7rExt
	65GrlJHl9oACVmMc0j2Px+Rq3PxvGEV1UMzwCFcOF3SirK0Z/6neABXrPf++8uvVaL3WJuf+q8s
	s2wUF+25I9zxX/FXF/1jAAGvJV1+iGioSS/UaPONYuAmFA==
X-Google-Smtp-Source: AGHT+IHomluGctWizgZtSH5trDBzaFgDj+ueftSVYArwFryZmxdGjyK63OTKsCg8GE1J1QbtKEC5cg==
X-Received: by 2002:a05:6402:51cd:b0:606:bea1:1740 with SMTP id 4fb4d7f45d1cf-60c66cd9c3cmr289224a12.30.1750869826213;
        Wed, 25 Jun 2025 09:43:46 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:b5f1:56b2:13d2:a5cf])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c2f1b8e14sm2661774a12.35.2025.06.25.09.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 09:43:45 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 25 Jun 2025 18:43:26 +0200
Subject: [PATCH 1/4] editorconfig: set maximum line length to 120
 characters
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-525-make-clang-format-more-robust-v1-1-67a49ecc2fd5@gmail.com>
References: <20250625-525-make-clang-format-more-robust-v1-0-67a49ecc2fd5@gmail.com>
In-Reply-To: <20250625-525-make-clang-format-more-robust-v1-0-67a49ecc2fd5@gmail.com>
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1288; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=7HCbL16RcywuwmWkey5Bd/URz58cvE7a/+2zbPtM50I=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhcJz/6l77oIWnN1Mv4/DRR11mEMK/zBaNDC
 f1E1RvHFP0G8IkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoXCc/AAoJED7VnySO
 Rox/ZvkL/jW6Et/Td4Kgnz1H5C9S6NqbtYCjxhwtRYTSNZBR9auybXKTJtwQDEb79UUvGct6Sh+
 55HryytkW6/vDwb7b26nrteyBAI0FdUfqOi1ct6ST7tO40rwU3iOy8u/IMxvF9VtZNJuRAlSlh1
 CJhYpL+HR6hcHSw8xjmTv3sqpaM7fJdFCe+t0LOoL28D90gffnQMDBRp8hJZncSAg/NhlFpi+SV
 Uo4onQ9M2RWriub3XT+GwSJRmwL/3z+GV9aXNoVARgxXAc1gIt2coXGEvrobM2GWbtXRlGpGCif
 vy+DsYgPGsDnC0j+9Qg+yhL1uOMZwKXJxwbfM5M8oPrHp1nHHppCpDOKDivX2SovPMz5M9pKmQR
 pXW43ZSjkDJPg1Zrpxp+qxFkinWJXAvUi6CgjJGDeX+A1wVtlzjrQ9o/blCdWrj6IPr5YYKkueP
 lSbheEZkFlqLUe9pHY9CLXHv1UPGnzVdO+bUx6f5fE7eVzeuSxM5EG53yrhTl5JZu2HeSCkgt97
 tI=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

As per 'Documentation/CodingGuidelines', we try to keep to at most 80
characters per line. However, there are often certain cases where we
extend this for the sake of readability.

Add a maximum limit of 120 characters to the '.editorconfig'. This means
that if an individual line exceeds 120 characters, the editor will wrap
that line. This provides a lot wiggle room over the recommended 80
character limit.

Contrary to settings within '.clang-format' which are used for
statically formatting source code, the '.editorconfig' rules are hints
to the editor. These are not enforced by CI and are guidelines for
editors to follow. As such, the 'max_line_length' used here is only
supported in a set of editors [1].

[1]: https://github.com/editorconfig/editorconfig/wiki/EditorConfig-Properties#max_line_length

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .editorconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.editorconfig b/.editorconfig
index 2d3929b591..d0f940fd23 100644
--- a/.editorconfig
+++ b/.editorconfig
@@ -7,6 +7,7 @@ insert_final_newline = true
 [{*.{c,h,sh,bash,perl,pl,pm,txt,adoc},config.mak.*,Makefile}]
 indent_style = tab
 tab_width = 8
+max_line_length = 120
 
 [*.py]
 indent_style = space

-- 
2.49.0

