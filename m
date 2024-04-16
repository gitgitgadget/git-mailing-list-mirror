Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D3A13AD09
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 23:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713308531; cv=none; b=JXqelDigU5LvxXbEozQu+SL9jkZcliphTvzIIr8Z8ADq8qoeTVLXlJx6ujLX9UADYaEj09r6+NFW9jkoFZ0+DGcodV3qiPDPA/R0S1v1+PIV1XSsOTeEgeNMeOPniGNIqFCLWElnP+QMT2gDanwe5MhgezsXAeruebSCdn2yKm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713308531; c=relaxed/simple;
	bh=l3yGsuETX+rCdVToSs260BzmXp0at75lyiOAbnEEWv4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LMPavsEM/cIlP4N+3SWyHTsMw19efnmbeErxF/dqvtA6Y2pp2Bo54xK0P9IAeukSwFfPX5+x9+WxCB5O/AvlIVXdv4nsCzi7mqgLoog0RQFf9NplzZIh3nxNYbhZZ6U6GoZZ1yqTxu4+G9yfeqif0HKl3TB6aQbUMV9KNqxn7HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxnD87XG; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxnD87XG"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-346f4266e59so3584082f8f.3
        for <git@vger.kernel.org>; Tue, 16 Apr 2024 16:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713308528; x=1713913328; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkHmOr7a1iHdcuXIZuXhos+KLl/CUPe3QCKRD2mfI30=;
        b=IxnD87XGElAKmNR6luWKBi0IR1Ifoos9nZi/bj39suGKzLQhq5FKzpJ8wwL+W/PUuB
         D+YcTlDNYj7TmNw0YsNX2nb2/M02GrRkNH70IS5GHcdwLwK4o7LC6HcLF9k3FJkJ3Ij0
         fBMoDwdoefzWBtqZNXcN4cFGQQC/WovGQSeVo9SGzafhbnib7wuFH+qFkTlig1tv8c9k
         8MXPUor0qcB5H8+ZS2nPnf3AGD+Gjfxigm6wAAArD/7qgokbFs8q3dKEJg8um42PUWTl
         oXovn2gg88Hznc8venx6JFJrvS4nTyZttUxIzSIAjAtPfeFel0eW+xItT2elh8LSHn1p
         7VXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713308528; x=1713913328;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mkHmOr7a1iHdcuXIZuXhos+KLl/CUPe3QCKRD2mfI30=;
        b=Nq4vUdueP2AGUGcM5ShWrc4THJuHO0uS2+AHt4F2kS4zcRHfREpIDdMG8MHhD9zzQE
         C81eaokncBG3Hp8bK2P15g8fc7FP6RGEF8qrlyl2pwe1JkWKLpO1yU27/74g4E2JyEag
         dqO/GdNxqtW1idkJzFdvreiaLfYJklBucuawStNVvrfE7r3xHTB5ILc7nemyA9IpIDRb
         UbzgB3xTbg8WTb009gb1ZYUtnQtDuW9HdAZq7RS9W+q5wAnnXSvmbsZTdFm8QDlx4iP9
         lnRrccA22lsAxA4bjtmkmIihX0lydJIs+fUbOqwmBQxvbgIcnTlBgaHB0ejUZ0H8aQT8
         oc9w==
X-Gm-Message-State: AOJu0YwIHLV55tjxkgEZRbIvCe0gAlpPseCJkz7JqWX1I0wXsIvgfJ5V
	BSe9eruKt3M33zGl0HuA9zf6p8J2q/0AiuMfUN6zet5AV/Q1nlBLygxzsg==
X-Google-Smtp-Source: AGHT+IHKsqqca+fUSI69dHfoUusyMbF3lFZ74Ot32Ib5sfNptnJnEdKdZjO/CrtG5Ff0Nx4k5veb3w==
X-Received: by 2002:a5d:6da5:0:b0:346:42d5:2d86 with SMTP id u5-20020a5d6da5000000b0034642d52d86mr12268228wrs.46.1713308527698;
        Tue, 16 Apr 2024 16:02:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f12-20020a0560001a8c00b0034744966ff0sm11338573wry.59.2024.04.16.16.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 16:02:07 -0700 (PDT)
Message-Id: <b23c73459cc4c9b43020a7ff9c9b4902f71ce123.1713308518.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v5.git.1713308518.gitgitgadget@gmail.com>
References: <pull.1704.v4.git.1712878339.gitgitgadget@gmail.com>
	<pull.1704.v5.git.1713308518.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 16 Apr 2024 23:01:56 +0000
Subject: [PATCH v5 7/8] SubmittingPatches: add heading for format-patch and
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
    Eric Sunshine <sunshine@sunshineco.com>,
    Kipras Melnikovas <kipras@kipras.org>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 060c8069c10..1700132a3a4 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -431,6 +431,8 @@ Do not forget to add trailers such as `Acked-by:`, `Reviewed-by:` and
 `Tested-by:` lines as necessary to credit people who helped your
 patch, and "cc:" them when sending such a final version for inclusion.
 
+==== `format-patch` and `send-email`
+
 Learn to use `format-patch` and `send-email` if possible.  These commands
 are optimized for the workflow of sending patches, avoiding many ways
 your existing e-mail client (often optimized for "multipart/*" MIME
-- 
gitgitgadget

