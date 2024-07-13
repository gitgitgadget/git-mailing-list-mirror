Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B16213A411
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 13:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720878329; cv=none; b=LcgLln+NOl6QbBnuVMhddMpd5KxzW2nbIBxwkzwpg4WCjvqrdAeoCNJiHSQ/EjoOX+TGo8W56gUsiwQuhhT5Qa2Zv70qM2EtGNC8AtiuQUo643u4U1Pzlx6OeZ9bc+kZlND51V4kQogj1Grwa9Z+7n8Qst8YhSexCIUAFRZVpw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720878329; c=relaxed/simple;
	bh=S7Zo/NpUORndOH2vsbJ5V3SdVDxmqCwBMRY0KwgBPmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YdCCLMCFZsBMDVhMlOwrp/WlrKtlqRFRnRfHzmYWrrDzIshiqztuX1wj+8eedXysGNoNe8hibZGrYofQabFo+i/N7Zy7OObsNuk8OWj6SettBasSyJShtOnD4J3x5hi4tiTUQZxTPu17R5bfdh8EtXPpN/loXHIDGLv5bcG8QlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+ccya8g; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+ccya8g"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3678fbf4a91so1499303f8f.1
        for <git@vger.kernel.org>; Sat, 13 Jul 2024 06:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720878326; x=1721483126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wNgL1+hL+/hGwg4Th2qpdX12s/4q4BWBjTK648i1So=;
        b=a+ccya8g+z3Ng1fTeW8oQP5P7yEBgaXLJ5VwZ96ao08ZYLd2yFuCtlo+ZouIHHYyNh
         /3+Sx8N2zQMnBKFB+0Zp4wlR+wt9wofqhCgfeHyKJZA9c8upaTfVJHVfdvF/oBqU1hFo
         QXH5077q3bxsBl/lxpplMagYFzGc4nOvmnZVg5lDa+O/YbefuVMvpOpkCfwroThnExF0
         YHw9PdrDaSlTZuDYKVI605G3gD3VGWMEIsXcLsTrgrpmTGmQzyX0znYoQmmFGCNjUsG9
         Y45J8GQdaA0qYIYmqvhX3YwFZsc5zl+jjrJgZbn019eNvwmMQTH/9/maoJZbTtQoBxCO
         tBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720878326; x=1721483126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wNgL1+hL+/hGwg4Th2qpdX12s/4q4BWBjTK648i1So=;
        b=kTeDNdr00qi1aD4r35DTkRrdd8eMXdrgQYt9wcnjHXXJYXXwZVQzYUxi/vFFg3Wnx1
         JAMxsAmTx6qwWTUkc+Hk6Q/9uKBspoI8N0l3UfVXQ6Yg/9gdGeSJUkT8l3okkY598xGl
         2LYiioPkTvEmmswAEOxAUfa0Bn5+JmFEBdvOYYVFo3eQqGDk1AusReJWxlwUWqFZ3VOB
         mlV+3P/AY0QpqOpUU+Ww1q5JqPVA2LzkL3sqP0jRtCt5ZCUnhMO31oEiX6f9tgO0NG2f
         fiGrM45Jsyg5C5TN4rSRUlrWnFH7H2v231Ov95Crrgw2nSH8P5kYkLmzUdPjcV06E3p6
         iV0g==
X-Forwarded-Encrypted: i=1; AJvYcCWcLBI3bVGu7qsfjsbZu8mOLSV4DGYe8Nsrw1tqIBwautMVNERquWecT/fRfBSi0NXs5T78laK9mhtqzPRwyMrDVEWF
X-Gm-Message-State: AOJu0Yy8XlUVs2u8cVHQWTTN83nBgbFllfqMd1iTMBkGkWViA1o4a5dv
	YBO3gDY+GdEWOztvb/iDBKFgf2bNytOhTdnB1d4bEKNzMMI9psh3
X-Google-Smtp-Source: AGHT+IFaiLYhiKlf4EhzihAO/hyGC7F28feOsQWOQ8mEV6zM860dhEaDRGQItMhOw5Fy7xT4LlepSA==
X-Received: by 2002:adf:a79a:0:b0:367:951e:595c with SMTP id ffacd0b85a97d-367cea7386dmr9753782f8f.19.1720878325832;
        Sat, 13 Jul 2024 06:45:25 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:cb20:918b:a998:e5da])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dab3bd8sm1440325f8f.13.2024.07.13.06.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 06:45:25 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	phillip.wood123@gmail.com
Subject: [PATCH v3 4/8] clang-format: replace deprecated option with 'SpacesInParens'
Date: Sat, 13 Jul 2024 15:45:14 +0200
Message-ID: <20240713134518.773053-5-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240713134518.773053-1-karthik.188@gmail.com>
References: <20240711083043.1732288-1-karthik.188@gmail.com>
 <20240713134518.773053-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated options 'SpacesInParentheses' and
'SpaceInEmptyParentheses' with the newer 'SpacesInParens' option. The
usage is the same.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .clang-format | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/.clang-format b/.clang-format
index 4c9751a9db..914254a29b 100644
--- a/.clang-format
+++ b/.clang-format
@@ -134,8 +134,6 @@ SpaceBeforeAssignmentOperators: true
 # }
 SpaceBeforeParens: ControlStatements
 
-# Don't insert spaces inside empty '()'
-SpaceInEmptyParentheses: false
 
 # The number of spaces before trailing line comments (// - comments).
 # This does not affect trailing block comments (/* - comments).
@@ -149,9 +147,10 @@ SpacesInCStyleCastParentheses: false
 # var arr = [1, 2, 3];    not    var arr = [ 1, 2, 3 ];
 SpacesInContainerLiterals: false
 
-# Don't insert spaces after '(' or before ')'
-# f(arg);    not    f( arg );
-SpacesInParentheses: false
+SpacesInParens: Custom
+SpacesInParensOptions:
+  # Don't insert spaces inside empty '()'
+  InEmptyParentheses: false
 
 # Don't insert spaces after '[' or before ']'
 # int a[5];    not    int a[ 5 ];
-- 
2.45.2

