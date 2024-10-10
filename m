Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3A51CDA2F
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 17:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728583161; cv=none; b=BDxWXKo86zvBB0oArOIJBntspLAUotX4HGmsmvZhUuvdFmkBKPSc1CvGBd4Gnjj+T0hPul7TTd5GVcGhX7lKx6Ggp+8156mVvxp4v+8O17PjPllSuSOR8M2kwrnvGpRB13C2Uj2sAsMcQl2IEbCOSUADL7Ia2rMdRtlyeynWUaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728583161; c=relaxed/simple;
	bh=GCV0b7WimHT/zs/J2i0xhuYCqqjmycV1vGTRUHpvp3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZqXMlNaqILXNzK7HOMBZ4s2vnKSlFB+Re+6loShfSwep6I+doMOfzzGEhTVpSafpOe2MqEQxjDErDPHznBdGSwWD/dT6HeqEFvu4ic7iNvqSmKO6NOsbYewzgBarInwPsh7Ycf43vy1nTgJ8oGPRirOxsSeuebaAaSdbXkq0jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTj0c9JK; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTj0c9JK"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c5bca6603aso1380166a12.1
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 10:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728583158; x=1729187958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aS5qzjDh8HtV9jAGqw4Hw1nQflg2cdOkuSbGuvHPIUg=;
        b=XTj0c9JKAKzFeAL09vqrEAZO5RpEQ/3tNoLdcB1NbPNHnJFslFzJcMPOZcJ4J1HWQO
         3ov0p26No/N0ohpKhzLKuAyxrbFmwOqTOlJBXDxTx8WcMtKXpX+IjBWYdj0EYsBT4mq+
         7U2v/w24Y77cRDBpo4GnphlMK6a7DHlF9aJZIHf9LoSCGvaB2B9aroDfo7fNrXjm587n
         cPXPKUDlXRd/TYuN8iz0u0uZ82sP5cX65BOsz894Oyl4pGkO2Ux9ryD1lDvJwqnYforB
         cb+l+nKg44HQoZf9c5J1Ko01sLm7oabspYTtWz8MawP1tMDpm+asY5xtNpT2g7OMxT+C
         MH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728583158; x=1729187958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aS5qzjDh8HtV9jAGqw4Hw1nQflg2cdOkuSbGuvHPIUg=;
        b=g3mAdgEjj6Kcimfngj+zINLECEG1HQubnXiksrCn79daXvn2np8FMjgNdluDVu5fNF
         IpTbC5SafdvJ+3a3KzLBGXzftX2yQQc3IcJxqDUUS+iSz7uHQMy24phuY623hUx4zjoc
         80CQBYyd62XKPu/yZK5Ow6zIU1HGB1GFm/iySPNRTQQzo1Izart2hsb+qtpe3GGRsx+a
         YkxC/iNXGCiYmyLjBKxwy6C7vXrhTu0GatZnO+78HugqUWBbtatFH9NG/cXPu7GYzI6T
         s0MwMleTcSk3SwkroWvwfXEI0zeEv/toJikTkczhrb4j+Xnr0oNhkYVba7U3l9RQ9RGc
         97/w==
X-Gm-Message-State: AOJu0YwJkmDI1xAM8b320xN3S69FPY/St0aHTjGNIPj59WhznifUAseN
	efgKc6doYNa6sYd8eudJkgnb+kdyR73R5khUuRgA/W/PHMn4uxZ4xeMTTlF5
X-Google-Smtp-Source: AGHT+IGdCpk4RjEc3srteOEmTb92UEZYtfSFCA7FB6wTDbBmZIOJ2DWBHaPUgBleafbO1ISW7aHCYw==
X-Received: by 2002:a05:6402:524e:b0:5c8:81bd:ac90 with SMTP id 4fb4d7f45d1cf-5c91d65c330mr5802306a12.27.1728583157726;
        Thu, 10 Oct 2024 10:59:17 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c9372608f4sm1059995a12.70.2024.10.10.10.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 10:59:17 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	toon@iotcl.com
Subject: [PATCH v2 3/3] clang-format: align consecutive macro definitions
Date: Thu, 10 Oct 2024 19:59:11 +0200
Message-ID: <6ebcd2690e05820e15584fe5459dc46011fde101.1728582927.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1728582927.git.karthik.188@gmail.com>
References: <cover.1728582927.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We generally align consecutive macro definitions for better readability:

  #define OUTPUT_ANNOTATE_COMPAT      (1U<<0)
  #define OUTPUT_LONG_OBJECT_NAME     (1U<<1)
  #define OUTPUT_RAW_TIMESTAMP        (1U<<2)
  #define OUTPUT_PORCELAIN            (1U<<3)

over

  #define OUTPUT_ANNOTATE_COMPAT (1U<<0)
  #define OUTPUT_LONG_OBJECT_NAME (1U<<1)
  #define OUTPUT_RAW_TIMESTAMP (1U<<2)
  #define OUTPUT_PORCELAIN (1U<<3)

So let's add the rule in clang-format to follow this.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .clang-format | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.clang-format b/.clang-format
index d655b08ff6..22ae882923 100644
--- a/.clang-format
+++ b/.clang-format
@@ -35,6 +35,9 @@ AlignConsecutiveAssignments: false
 # double b = 3.14;
 AlignConsecutiveDeclarations: false
 
+# Align consecutive macro definitions.
+AlignConsecutiveMacros: true
+
 # Align escaped newlines as far left as possible
 # #define A   \
 #   int aaaa; \
-- 
2.47.0

