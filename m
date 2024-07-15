Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E3318733D
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 09:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721035857; cv=none; b=uGG47WpuwGyAvYTg0jMdwYp6SD1JGiVdWeNro9x+3win2TEIqMm5/Vt/OWara1fpgV/CBMCKG5KGPDPWIOUgCgC+Gr9iwOOVpWmcfKIUm5ewbZeTiBRqn598IwWflBx7Jk7dsvZtbNXCs2K1S1Phm5uPtdDgQqc1bx6UgjZb8iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721035857; c=relaxed/simple;
	bh=S7Zo/NpUORndOH2vsbJ5V3SdVDxmqCwBMRY0KwgBPmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJVoYZ70mMGS1kohX5/au/nIwooYxjg7VlInhL15IO1hGqTVXS0PEiPpiRhRRzFSIVHJ4ZfRfSlYhUjm9i0obichskO/DK8xwi2lF+F/0lDbr//SKVMhMEOI1d6K0i5+XadKkd0ililySSEtUUbWI5oi8Tpdfz9i5lUOBAlPygU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8i3S0Sk; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8i3S0Sk"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-367b0cc6c65so2523498f8f.3
        for <git@vger.kernel.org>; Mon, 15 Jul 2024 02:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721035854; x=1721640654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wNgL1+hL+/hGwg4Th2qpdX12s/4q4BWBjTK648i1So=;
        b=l8i3S0SkTAy1RJOls9vQBDzxYug1Fu7XsJT+6XWQbTiHWHmQ6neYJXuGUxBnIuN1mw
         i1mgn3b4LeuCHtbg3Mc09eI+FbIgHYR7nPeC6B03FFueH42c6VbGjYDOlGv+scN0a57j
         hM37kLN92XktvmN3d4VmzxHtrXQBEjUk1Y5gFncuB5NlWd6v/3ncBiJFVXD9QVPBN213
         SmPpayd/0iS5HuIUkuxIs+TJlUocjaxGW63KDEYSISkRkkUwE2J2QfqZljcvf57nFLBZ
         zTIgXAidQRcLoRE7cpycP3wnATQ8+9dRfzbGfJy7Q39Ykv4eu/iQNsADCZjfcrvw0gZt
         uEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721035854; x=1721640654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wNgL1+hL+/hGwg4Th2qpdX12s/4q4BWBjTK648i1So=;
        b=mmzBg0ry8CmxDNg3uj+EJqHiC738ANHfkamjjbc2RQLKQj2cjGnTQbGbF+d0S1XtOE
         PXI5n+LFifGTBHsI5rlEyJzdvCi8G6zQLwfeN6lkhGrvgfd+F2nynx4ErwnB1KxS5duH
         PKZ+eSL9Lk5VoNwUunFKV3QPShIwxcb3NhZ6TWqrZk+pbKNVPBHDsFbhW82x3bIR0sR8
         lk0zesEZtg6QRsjwsWrLvO5M422xaVjH2k7vft7IA91sGSVP59gYGG3vd7JQ9eDD2ds/
         UFptgGRtCTDhq/NaEopVnmw7oOK2mkTZcmrC0umbFohquDX1IpE7zZWgWHolo6OrfAuz
         y/og==
X-Forwarded-Encrypted: i=1; AJvYcCXx9MrK+MHq+pXYnvF6G8AUYjHpnUoKBPkbwkkoRgmwnytUpzfSxWzLboHWX7ZPEVop9YdAnCiiznWBo1U4Oy3tUIA5
X-Gm-Message-State: AOJu0YxpcXdbcW9UA/WfSum9DcD0u35R8CbyTpvZKtr562GXqZHnLzYg
	KEmcuJ1FhlHsMItnjIqf+530Ej3avwNpo80EHgFLneQxrVEXuCjV
X-Google-Smtp-Source: AGHT+IGjV0APN8PFM5UNLr9WTbIhcfqAnsSFu0SPEyEp5W+CXVmT4rXz6DaIy7g96GEvaNsy2Ke0nA==
X-Received: by 2002:a05:6000:178a:b0:367:992f:6037 with SMTP id ffacd0b85a97d-3680669d9ddmr6813046f8f.16.1721035853900;
        Mon, 15 Jul 2024 02:30:53 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:1a3c:da7e:77ea:d1ae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafbf19sm5745208f8f.68.2024.07.15.02.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 02:30:53 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com
Subject: [PATCH v4 4/8] clang-format: replace deprecated option with 'SpacesInParens'
Date: Mon, 15 Jul 2024 11:30:43 +0200
Message-ID: <20240715093047.49321-5-karthik.188@gmail.com>
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

