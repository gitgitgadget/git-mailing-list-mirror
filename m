Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D04725484F
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 10:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742899116; cv=none; b=hTGO5R5YedQAJbAH8RtKtTH0hocUomqMa3jAxxteNzDA7wzXac/abxyUiypkfHV48NJWMfL9hCIcDIejf3D5nSFb9nKQ30Fy2bn9FXD/uRb3bvBDlRApVUQR/IFMSuI/L0eOn4XAC/17V/oT3NSzF1T9nvVtpZBhQ8QSfVqfjMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742899116; c=relaxed/simple;
	bh=w/MilV9s5Z2Tvz/1OoHagRtLOPJEUqyZJw2GB0pJjo4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Yji+aE8jp2nzqpS69eG/yPC4ohJ58p1igCsX92+q8+d4e6bdz5OyK1m5boMC0qwaI2WJcVJBClm5ApY4KZUnzbo3Fv1mJNWNqY/M4mZz06LwsdoJgE9ZnZVxptD6C6NVYDhxM+j8eRezjXwk+wN8BezfM7xTGobfgGmDt6OTHwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9Mv6dbl; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9Mv6dbl"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3912e96c8e8so3040595f8f.2
        for <git@vger.kernel.org>; Tue, 25 Mar 2025 03:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742899113; x=1743503913; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jtkl4Q+56P/fWgeUgh0D3Y5btSZwYFZPDqsL98n/CKI=;
        b=C9Mv6dbl02Nxy6jc0GCB003Bq2KRS1YVtAtgaiox+/XPZwjZciJqH2BQ+L1LK24qCv
         7+iumXUJHNycR2bT34QEKWLtoij7igInBbCLnezUNAKGf1n+M9z7Tdl4CSTkz+SYZNLD
         X6UECFUOXEIfNz8o8WfaI9Oe312pxuoKSKMZe/jLiTtGxcObqw/lOAgDM2D/mmecFApJ
         9i7TsVKro/xpRDGeyatKrsWCQGGMXZsqP2hrOwzK4/e7ErnU9LL7uFqtf8pd/HKqJ+5u
         DcVrNsxMaQksS43kj3Vx0IZR/NexwMBg/F9qIbGwICUUbQP64LNUtGMf9X2cFvesZaAf
         A1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742899113; x=1743503913;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jtkl4Q+56P/fWgeUgh0D3Y5btSZwYFZPDqsL98n/CKI=;
        b=HirM8GheqfXnK2cp350HXXH1h3GyAoCcA/lfFt/kD613RTEffNLTIVHJmcywZbRuK+
         0SFmCE1nzx50/MWKKkSQboSLhglrF1YiWESGLOk3C4LIRvEt/OwetqbUDAu8urO9uwAU
         M3baRED1GQKpcze82LaRHcaxsT8EE9nw5y2pWfJoBp0JCRHlOdvYo5YvaigpeDbijjMR
         7Gx67jqBP0ccPkG+vHuNAs+V80EmGOiSGO8uhYLp+AwLMczrhMWBphV/T/QE0jCpoqj8
         C98pf0HbkSu82QKx/hOpB46mXx8QA/+sxOr1RtthA42LTDr/MP6Izbmvuin2c02w90/z
         xQ+w==
X-Gm-Message-State: AOJu0YzB2Sr36Ttv5dq+znpL97oHvDZGVfA0j32DxQKcGmApGMFa3YXd
	7EBrsok/RcBoaqsVUWCj2y/QnZeLnUtuDbv38na1OOijU4WarVQ/IqBiMA==
X-Gm-Gg: ASbGnct8sVmGZ5B/VeUeDXhq7d2f7nfFueYmGVy8JfhjnNjON+3cnqa4BAxZS1piGmv
	qS5eI6LhH33C5s8tsDhpWYfxAk9GY5+lKTxBbdNLWy3TLhVudHg9h6IBW5S3c8JdZ5i4rBS3p4L
	ENQ8vCMVDJbY9tuom+HeJMc6yaiEhEh5z5GT4pXjp4Dq2SJvdW8S6LUnrs5gUUXeqW/6YwM/Sv2
	kFileUwjH82RjXRQDu1imbmGXx3g1XLLj4Ji/TMKw9+3QZB0QL/XO0T2ko/O2n9W9syenYdcqkS
	TnowkboSYlc5m2BBz0v+Tat6mpcDFXzKhZdUNVOpV51o2ZvtA/v4744a
X-Google-Smtp-Source: AGHT+IGFZZ26U2VOskW83IxsZVr3Iv8uRO6qLgQc4w4znBjX6Wzo+uZVzUdSdHnlm81s40eeg8gVsQ==
X-Received: by 2002:a5d:6d88:0:b0:391:2e6a:30fe with SMTP id ffacd0b85a97d-3997f92d305mr17892179f8f.39.1742899112845;
        Tue, 25 Mar 2025 03:38:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9e65casm13575672f8f.69.2025.03.25.03.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 03:38:32 -0700 (PDT)
Message-Id: <1daac3f08fae41a967d52d510128052c6a1829a8.1742899110.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1893.git.1742899110.gitgitgadget@gmail.com>
References: <pull.1893.git.1742899110.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 25 Mar 2025 10:38:30 +0000
Subject: [PATCH 2/2] test-tool path-utils: support debugging "dubious
 ownership" issues
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This adds a new sub-sub-command for `test-tool`, simply passing through
the command-line arguments to the `is_path_owned_by_current_user()`
function.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/helper/test-path-utils.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index 72ac8d1b1b0..f3c59e50285 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -504,6 +504,25 @@ int cmd__path_utils(int argc, const char **argv)
 		return !!res;
 	}
 
+	if (argc > 1 && !strcmp(argv[1], "is_path_owned_by_current_user")) {
+		int res = 0;
+
+		for (int i = 2; i < argc; i++) {
+			struct strbuf buf = STRBUF_INIT;
+
+			if (is_path_owned_by_current_user(argv[i], &buf))
+				printf("'%s' is owned by current SID\n", argv[i]);
+			else {
+				printf("'%s' is not owned by current SID: %s\n", argv[i], buf.buf);
+				res = 1;
+			}
+
+			strbuf_release(&buf);
+		}
+
+		return res;
+	}
+
 	fprintf(stderr, "%s: unknown function name: %s\n", argv[0],
 		argv[1] ? argv[1] : "(there was none)");
 	return 1;
-- 
gitgitgadget
