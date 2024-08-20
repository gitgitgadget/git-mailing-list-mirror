Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ED81C6B2
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 01:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724118520; cv=none; b=WQhS6Ae2jm8i9dT60eVgzvT0NAA+lWtqi1kpanmOebxKVAPb8b/Jt+/hIX8GCgSHRpt0ZNGaxYJe6a9APjO7UYV4thfU8c3xo60f4VNfQFcjw0hYPYcPfaZDykYU/e7nNufIEprM3OIk9Pgd6m7Na1H6vKAas9x6PXfVwTSHGEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724118520; c=relaxed/simple;
	bh=sipFw1dJc1zbv6tyF/MqIbyJnlnjC/BLxSZ5WN2aGTs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JWrlZ4SOuUWN3qTVPo7wQMFICxhkCQVw1OJdDXGmzvk6OIiOQspTHgAPvbzAotVgk8JZOhCvIJoTxvYgfQ7dzCTGQbLeZ5qE6d1oT6lPrIUHbToqfu4STvpG6oyhYctIv8qIk6mr8lZL5m1Gvy6Lx86Ivq1qhIg5pURvcU2TruA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHU8+J2+; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHU8+J2+"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42817bee9e8so38271235e9.3
        for <git@vger.kernel.org>; Mon, 19 Aug 2024 18:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724118516; x=1724723316; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FG3uwywf17nE7MKTAyfOz2NJswUr1C/H8jKjMZ6nbM=;
        b=SHU8+J2+FoGfWvPv71mYfWGPm89QFY1JWnUpkIUOfObEa3Xz++fIhnO+KXTib0EWGL
         ND7bLXu8cm+EqJLUtOrTVQbySnWNaJrMzZ3vt1HLcRmcVfHJe4el6YfOq7P2fcVryQKD
         IQmNSJLydxQJGEOg19CVibkI+Kc2coHa5Mn3PR4vmlUyDUD9p4pP0X9lVIZAJfHd0smE
         bo71ESbOu/fpCz2sycVcn9vGOzpmBQpOHbcl8OcyRj79ILOrXW3CLCUcMCbgnQensVwg
         nh33iaNmkmL9/aKkF5mHZo/rxw0d+m1oIbdeCDSN+sZCFPJYu3JLnLs5XYIBIAIdt80t
         BDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724118516; x=1724723316;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FG3uwywf17nE7MKTAyfOz2NJswUr1C/H8jKjMZ6nbM=;
        b=tZP228Oew6YEU/LPsHp+L5HJGpp+x+ZVknsLknIb7gBX27C1o6+LEd3SLodc4Y7RuW
         mI8v5diQ3VoQ9mVjl6O28/I9s9opSlYaSIObsvhrNMiP0l4ZsaLC1MPQPMzgMZ1EhyuW
         Q3s5H4muoPV+twkQ14F91/r5R2dv+UYgX2Ma2U9ahTj8N5yfRTuOKDomZx4z9Cgy1jSp
         haGf1ayJGPGk2dgM3V1aAPn/dhHTvm5F4w6+wS5fq0reU4mCTWiyJ38v/XsXeI2NP3A1
         BHroc/9m9A7rRzLdjpBdTccxjjl91KiYQbcgFUoofcH0MP8TB+tF46JWDSfNXMcPtyc7
         V4WA==
X-Gm-Message-State: AOJu0Yzt4lg2FPgZ8W/yU2Ast/5jvzkLgN4Y3gkpdxeo9e+/hJK6YYuy
	B+vocY9DI9QA2Cat9qPov+VMm+yQFp6O7opHQ8fGiO7rUbJnanUCwDJH4g==
X-Google-Smtp-Source: AGHT+IEkdF3oMtuC7h/1W7BzNluYUKN1/BQPgcTQ/jrtV5iGKI1DxCGNHNoOkXF8Bw6bJxISvYhLLg==
X-Received: by 2002:adf:f6c6:0:b0:371:899b:5c5 with SMTP id ffacd0b85a97d-37194659e95mr7245370f8f.27.1724118515321;
        Mon, 19 Aug 2024 18:48:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbbe26fcsm6197852a12.5.2024.08.19.18.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 18:48:34 -0700 (PDT)
Message-Id: <9ce5ddadf0bb13229461d67451094a373348771e.1724118513.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1750.v4.git.git.1724118513.gitgitgadget@gmail.com>
References: <pull.1750.v3.git.git.1723886760.gitgitgadget@gmail.com>
	<pull.1750.v4.git.git.1724118513.gitgitgadget@gmail.com>
From: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 20 Aug 2024 01:48:25 +0000
Subject: [PATCH v4 1/8] git-prompt: use here-doc instead of here-string
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
Cc: "Junio C. Hamano" <gitster@pobox.com>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Patrick Steinhardt <ps@pks.im>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Avi Halachmi <avihpit@yahoo.com>,
    "Avi Halachmi (:avih)" <avihpit@yahoo.com>

From: "Avi Halachmi (:avih)" <avihpit@yahoo.com>

Here-documend is standard, and works in all shells.

Both here-string and here-doc add final newline, which is important
in this case, because $output is without final newline, but we do
want "read" to succeed on the last line as well.

Shells which support here-string:
- bash, zsh, mksh, ksh93, yash (non-posix-mode).

shells which don't, and got fixed:
- ash-derivatives (dash, free/net bsd sh, busybox-ash).
- pdksh, openbsd sh.
- All Schily Bourne shell variants.

Signed-off-by: Avi Halachmi (:avih) <avihpit@yahoo.com>
---
 contrib/completion/git-prompt.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 5330e769a72..ebf2e30d684 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -137,7 +137,9 @@ __git_ps1_show_upstream ()
 			upstream_type=svn+git # default upstream type is SVN if available, else git
 			;;
 		esac
-	done <<< "$output"
+	done <<-OUTPUT
+		$output
+	OUTPUT
 
 	# parse configuration values
 	local option
-- 
gitgitgadget

