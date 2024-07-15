Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B55F1850B5
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 09:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721035856; cv=none; b=nKjpl2yrJzF1Y4JMlE+xhLTvVbJOIGI9m4pbwbQ1P/hvZXDKf0vpgO+T9YQxQem20L8nZeew4+2dh+DNgofOwhVj5vR6xeVrnRzXafzfe9V+jLuCFYh7+4bQKw3c7TwGeNwK/ERhC88gh7zuCgQcNIsSSw3bDeq63WnSY8nROeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721035856; c=relaxed/simple;
	bh=mGKp73t1gDNv5XhEYpbWC9ylOVN74pdxUlMqwbrFvRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwgUQO7/6KoXZV6MbJNPdgbk2/4J52p9Hi+M60OQpp7EbTyITqIDDknTRSX/ILxuQttzXfyOo7cc/j27CKU5Z2tpFQ6+LKHfpGqx1UH9DAckTgj/XfxBg3sntagYYn2VCichi92/EkVvrQVF1vZlPexLxwWVCg6PVgXVxZPonko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIo+rX3O; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIo+rX3O"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-367963ea053so3390459f8f.2
        for <git@vger.kernel.org>; Mon, 15 Jul 2024 02:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721035853; x=1721640653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QEj4J1duXKauf+ZuSbER3cN37XrHK4JaDZdLoIf88LY=;
        b=cIo+rX3O60vAHHNmGmq6oQf9+hgW6AUCEyTQF5bm2PxOYOs2+RdtspDPlGKcYXNDva
         yIUQ1u12QVuCQ/8bTtRhoDfytxb7PdKDglRPETtBBDi96KUfhg+ls+x2Q6qr9NLzFGMO
         fReF11C+R1TGR3D+IMlZuaML6ozrO9Q0MPqHzC0nOX/6tp0aFRHPLPThkaVU97lElT6n
         ybXGgFu6TDWrF8roSEE5cflP8sjsVWKhnOpYznHox/Ab+6+By2aLqJMMY2TflwF3N9X7
         LITmKLnJIpb9m9Qtpth8yJy7qkw/ByOmCII1eUr6qWTh0OLE6Jn7k40M46Vgz1dvpyl6
         8GBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721035853; x=1721640653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QEj4J1duXKauf+ZuSbER3cN37XrHK4JaDZdLoIf88LY=;
        b=RNRr3AZ6rSia9dSbVxLxvluEwfR8q5eTPgLbFyFlHcv9lqKSKJvpRDojmnNJSvjc/c
         xyudQktTcmK5+330BbYUDp8DlzWhzIZ/xIPq/EL9F38L3Qhvgo6HCXC11fNHrysj7N8g
         C2Wr0vISDV3drW07vWY36c9OCXDx5/cidaHhl3ug3t2y7Mbo6DAspw+MIkinS4WmREpg
         DxSb1v/i/3wKA3FskAFoA3dPuHz49wHdX84bHICQZf/RcjGumtUUM0wI3Sy0rV3E4l6G
         oRq8R7xdMEiYidk6JRRlSJItpOxZyJ4QivimDrl9jaJ90C+jjTRrkfhtoW/O/C/t8Hky
         uTKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoW3jTAYbfo3iVGxA4vkOFOlmUTqWe2qORDN6GMz3eXv++CYC3eMEQW3QQ/JUs/JakfC9B88GvOQbOI+HTL+zIEQin
X-Gm-Message-State: AOJu0YxVldpQTHt2GCggDv99o+vawYzGsrt+Du/hStTNXNg0tBlfG2XW
	ukBQf0ylUf+VK32ItsNd73vFY56mjrvDTI9CfKrkGD6VuqR+wKwy
X-Google-Smtp-Source: AGHT+IG6uQPnzHaC8iQeboLuBmmKVP+sGWCBHlWiWpzOMXbTx+9hGET/T0v65cQic5IAaqyvAeX2zA==
X-Received: by 2002:a5d:4703:0:b0:367:47e6:c7d9 with SMTP id ffacd0b85a97d-367cea95994mr15000134f8f.33.1721035852703;
        Mon, 15 Jul 2024 02:30:52 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:1a3c:da7e:77ea:d1ae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafbf19sm5745208f8f.68.2024.07.15.02.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 02:30:52 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com
Subject: [PATCH v4 3/8] clang-format: ensure files end with newlines
Date: Mon, 15 Jul 2024 11:30:42 +0200
Message-ID: <20240715093047.49321-4-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240715093047.49321-1-karthik.188@gmail.com>
References: <20240713134518.773053-1-karthik.188@gmail.com>
 <20240715093047.49321-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All our source files end with a newline, let's formalize in
'.clang-format'.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .clang-format | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.clang-format b/.clang-format
index 803b274dd5..4c9751a9db 100644
--- a/.clang-format
+++ b/.clang-format
@@ -106,6 +106,9 @@ IndentCaseLabels: false
 # #endif
 IndentPPDirectives: AfterHash
 
+# Insert a newline at end of file if missing
+InsertNewlineAtEOF: true
+
 # Don't indent a function definition or declaration if it is wrapped after the
 # type
 IndentWrappedFunctionNames: false
-- 
2.45.2

