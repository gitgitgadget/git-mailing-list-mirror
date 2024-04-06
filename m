Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08CDBE4F
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 01:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712366550; cv=none; b=hfo7YjlXS7ZF1PI+fvRIe5OTiw4xVDjyw1/AdrpVNiJFfi0imrrB3vliA88V7F+ysBr5dqiw+AXLSCTt5nsGLLOXqQTDSwVh4IqzaDnrgejxkdeXwYN8N+lsx0dQ+LE3GbhDb2TV+TeLA9vy9dd+Dgdvx1zw38G+jMSdtxLVda8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712366550; c=relaxed/simple;
	bh=jZKRm+2mEdekboNrU7z5B7zDXHMsJR3ygUNr2bizhGU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nQkWOP27UIX/lZ45s3+NUyM6Ejy6z3PLiLAq8jmOgsS+iG6dQxY57s60CmuzvOi7uLTZhfTQwDNhwqYa4EW69yWDA7Q7+FNp9JSvJ+TZFx+GY8Ta/2urEVBlJJb/Z31GGfUFWBG8r8VFAfN1RZfAsefrypbxzW+z8F0WE9tO3HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPmy1aZJ; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPmy1aZJ"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d47a92cfefso35998811fa.1
        for <git@vger.kernel.org>; Fri, 05 Apr 2024 18:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712366547; x=1712971347; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qM96Pg+v2WSlmqea84VoJywARHIirt8ccQRhuqk6neE=;
        b=CPmy1aZJCCPJgoYDdkzwtPvBrflR8ifvuMVXphU0MojBqx7cFel1I7Yi6DJJ/JjFXj
         KgwbRqYNxR/oe/obPLJWGxBzSLnFQPsIgoasG1zIINiX17ZCRAjVWea8ekgUu4zIK9+1
         twAqyeDnqkMR11Om1XYnOktpdDxBQH4X5uvT0W2fgN+nOffcUkQBe+rSndDAn+RNCzvo
         kn/JnrwAEDhb9ybC/UEdZFf1bE8+s+6n6qmdQ3sWMKvnIlbzapcEUyBm8kLwP+w7zZhy
         yU7RNB6t3e79u750s9clqB64n7eWIDeQ6/KsZd7SdAiVTIRKjVwd5+pMOqwe8wJN//oa
         WE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712366547; x=1712971347;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qM96Pg+v2WSlmqea84VoJywARHIirt8ccQRhuqk6neE=;
        b=D72FlbP0TKyvMclqgMOXK45V3WS7ORwoet+4Nd6VMXN6nt9wBOU0PmRYLMrjMfnPcC
         QDmS11AYXePmT+vB3eCVJvB32V0+qAD2KIHU+M2bCIvUy+YygXpV6qqWefFH7eVO2cwy
         gsDWWBbMNldZnf0cO+XygQmKM7Cqd+3/XXy/fxfXKyndiq6LOKsqVUBjHTFBWqnWQh80
         GzOERUvn3/klp8wdNkDF4rddj+CmylOPfbYg89BhEThRZZpruno57y4c5xDoGxBL1Wx9
         Tf5RQGZxUl52t3p0VCy31YOTCUkq8rQrxVUKyanKSm8xpbnyLv6n9lVe0lkTdHZLWVji
         tdRQ==
X-Gm-Message-State: AOJu0Yzqrrc1MqbJ2Ly1VzMoAJ2lIMy7j4XD1lhn2UsDx/nLUj1tp1hc
	Ck6S9OODszksXJoB4syPDbLSTfhqurCZxNGl/yfyqi2MQ3IXE2H6UNA3EjrM
X-Google-Smtp-Source: AGHT+IFp/0l0tefahCaseMXQW8i7BmveSRsuvW2+LzL1Pir2SFQ/gE49jZ9+RaSZv05HYcTKa8zjyQ==
X-Received: by 2002:a2e:7d15:0:b0:2d8:63a2:50dc with SMTP id y21-20020a2e7d15000000b002d863a250dcmr2152900ljc.48.1712366546423;
        Fri, 05 Apr 2024 18:22:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h7-20020a05600c350700b004154399fbd9sm8319569wmq.45.2024.04.05.18.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 18:22:25 -0700 (PDT)
Message-Id: <09f4e7ad123b7359d29981b9a61243e9554487c6.1712366536.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>
References: <pull.1704.git.1712017205754.gitgitgadget@gmail.com>
	<pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 06 Apr 2024 01:22:15 +0000
Subject: [PATCH v2 7/8] SubmittingPatches: add heading for format-patch and
 send-email
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
 Documentation/SubmittingPatches | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 311f306394b..48224e745ff 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -426,6 +426,8 @@ Do not forget to add trailers such as `Acked-by:`, `Reviewed-by:` and
 `Tested-by:` lines as necessary to credit people who helped your
 patch, and "cc:" them when sending such a final version for inclusion.
 
+==== `format-patch` and `send-email`
+
 Learn to use `format-patch` and `send-email` if possible.  These commands
 are optimized for the workflow of sending patches, avoiding many ways
 your existing e-mail client (often optimized for "multipart/*" MIME
-- 
gitgitgadget

