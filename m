Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC74919DF40
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 21:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713477133; cv=none; b=H1gsjLYCmo0d0H8gTK2PrAWLh19LUKBWFJJkkG+WKfn5uwRV+X8ITD2aSf74uj2I2KwdtmmSL6A4tP7Mg1HVqBoJioSRCzh4wf2OIthjd7AVxSOwIo7MwDVfdcryUG8BwrU18W9mUqS5RqLuHxNZHav0+83XR7xMUnNKIDa50bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713477133; c=relaxed/simple;
	bh=KaawRCSqIwI3Nz31I1au7IthDncYxXQc+wO0oyYv9b4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UYYvEFwm73QJG4+lRqxqsRYZ8mm7w1jUd+8ZXkdgfQRRGidmdtdJkyp2DYPGVv66ZWztdCAA/xql2gXsVZ5tDhQMifGWyXqwWKju3COKd/5kz/3jpRZ/SybcuhogwerYXT2CqFJ6MOWfPHxFlTiRjgit0Hn1dNoYbj11z3uCqBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jP8Roz8e; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jP8Roz8e"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-418c979ddf3so10807595e9.0
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 14:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713477130; x=1714081930; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlY5twN+80OZ4NTMvW6gQ34sTTTkc0q1J4BSPAgByM0=;
        b=jP8Roz8eKfz/pwad1seNlZLqQleMeSBduMo0DxcOvolJe4aNGW+51Aamp0wow/abPS
         3AD9Ul1kz0Xc0fL0vNYgOHICOoR122f/0fKrs29mD66AU3Xh+Ge2v1VRIV4D6hhdSoMP
         NnigxcM2HPorf4f04Bs1ZYMVTfO9vu2VqRgj6GKn7EiCsEobPp1+ssWJg8zZYxGbihQ0
         QyfmKUwhNn90u4J8XiVpvBFMPTdHsnHVrMMTFV1A9HQ2kyMkynwAtoRhdy5/qCo2Iuly
         NjZOB5NnSmWC5tsDyplpfn6Le12bPm1YYiPTnKcSJFHoMBPJNxeJY1fYOxoLQJZIgfYT
         260w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713477130; x=1714081930;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlY5twN+80OZ4NTMvW6gQ34sTTTkc0q1J4BSPAgByM0=;
        b=D4r33n8q09PDeOiq/71/++CzNVKmNI2uZCxE52V6ZPS8+yvkyKDj3kD9gZIbxT3YXU
         12vozKvw1dBGwOxdb0LmT00DV9Prs6o2jPBJumgDTyyu71B7iDyTvLeFcufGvMBxBupz
         HfPAlmGVOGWJjVnfPrUP1ysCc7sz3l/CdpDlNmxfjpIFoiB0fjfMrYyz6TCfPUER8D7w
         Yv/E+zo5dP/hRiP6qsxAtWerY+jyHgMO9N8GgMP0vPUHMeKLuf7DkzZt413VJgidxIa+
         jWulykW2ztDWq4jQypcWELwS5ZRPq0lpW1y3N7ZBuGs3PXcJ4WLyLZuGR+cwck4PAwFk
         Vg3w==
X-Gm-Message-State: AOJu0Yx6cDhOPJVwgN4oZkNoZb8EupVyCmg8pUt268SrEVdLQgTCB/En
	ebpX5L8hBZntbB2kYsG78vwkjqkD97SjW+PS6E0kJOmZtqC9gNGQEVaxXQ==
X-Google-Smtp-Source: AGHT+IFUhdGXEFcMYuFzl1MjSFO+cg49FlNgpyW2ZjdtDlGaPgFfaKrpRDLZeTcYB/vOfXGNhaFM9w==
X-Received: by 2002:a05:600c:1906:b0:418:5ed2:5aa6 with SMTP id j6-20020a05600c190600b004185ed25aa6mr72460wmq.31.1713477129911;
        Thu, 18 Apr 2024 14:52:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n17-20020a05600c501100b00418f1d77098sm2429531wmr.25.2024.04.18.14.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 14:52:09 -0700 (PDT)
Message-Id: <c201b3136446037f4d92cc0010d6f9ffa675202c.1713477125.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v6.git.1713477125.gitgitgadget@gmail.com>
References: <pull.1704.v5.git.1713308518.gitgitgadget@gmail.com>
	<pull.1704.v6.git.1713477125.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Apr 2024 21:52:00 +0000
Subject: [PATCH v6 3/8] SubmittingPatches: mention GitGitGadget
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
    Eric Sunshine <sunshine@sunshineco.com>,
    Kipras Melnikovas <kipras@kipras.org>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index d4173d4fe84..26055a1fe2b 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -408,6 +408,10 @@ are optimized for the workflow of sending patches, avoiding many ways
 your existing e-mail client (often optimized for "multipart/*" MIME
 type e-mails) might render your patches unusable.
 
+NOTE: Here we outline the procedure using `format-patch` and
+`send-email`, but you can instead use GitGitGadget to send in your
+patches (see link:MyFirstContribution.html[MyFirstContribution]).
+
 People on the Git mailing list need to be able to read and
 comment on the changes you are submitting.  It is important for
 a developer to be able to "quote" your changes, using standard
-- 
gitgitgadget

