Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABA04D9F4
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 23:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712878353; cv=none; b=kN/PTZB51OtyfHXBZ/038CW2uYtpgrhwvn33hMCa1jcXtRwT6CDx8IERv+4xww1j0CZ/TWHzb+3jIttppqCDsddIm2Mzi3oh/2oy0Np+xZsgcZ48KQPsjqei9p0m/oc5hk3x10jeYg0yCsdr5/gqwLPPfTOjbKR1QzyYX8JOkvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712878353; c=relaxed/simple;
	bh=97ZmeyhwahwA2ZW805pXSdSYH/7vhmkQn4p3rhC3agQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BwcbWgTnTirbuU1ONQ+YgcOwO9Tnr10mgg16u4Ts/933bwc1+ubM1o52DWO/PHOvL8IQjW63w6OaxLrPfVd4fMN68E/+m3TKIA0g8u1EUtiuhlQ3MoG+qAxhWuoWJEJE/2U7GaTuFQuLzbsWN8HDXMTJ8SH4moVbea0WVzChzhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKA8Qvir; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKA8Qvir"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-416c4767b07so2722925e9.0
        for <git@vger.kernel.org>; Thu, 11 Apr 2024 16:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712878350; x=1713483150; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQHtztpLYBisKit05nkkC2rkf/Moh7swzkOTWhRGuc4=;
        b=gKA8QvirwLzRmz159RGBYhqNd13/66pQMijpn9e7z1EUGv0lc8oAHSVnqCBXStQL7M
         F4lSU2ng6d7rFGY6pWMBwb3EApylxFHisCn6jkNUV1LW0cTKCsOPP+cTYXrY0P0+s9+q
         S0gm1bx4ZIJiFt15AfbNqwRyC8MXPBESbKVKVzBhTFAWSN4xRrfgy9gcoHytRnTSWCj3
         ySDvLzxxwKnAMISapujn6wfOPA2q2faFDOZkKieP62uCejoKFbWmJtcVEbUcVKLuWDba
         za5vLrc4qvU27YTglMor1moO2IZnwQvVjJ7NohFNgJ1PHgR36LxJ7zyeMXBv+omVJFyz
         rWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712878350; x=1713483150;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQHtztpLYBisKit05nkkC2rkf/Moh7swzkOTWhRGuc4=;
        b=EZ6vuyqVaR9hPjO2MZfvbb6Ip7Nbzr2WqkbnQ8nEH4c0aZ7kNGmZOvueabE0YW924O
         3vktRXsBT82lalmt/P2kaxKuKKSzdkKwGsPiPO1IT85k3LFSknfB2Eef/dYD2jLU3i8A
         3TkVOy+JfclnojdgmxF/SCyS9iv7qIdG+Rfc+W5V8/PTWlICMk04OqrYY1jyMu/MXidh
         5+0VITTQ+5absCxDUpgsH7u3QLyEm1B9RFL/xJow/0coEuyHY6eDlpWEBvO0XQq8s+01
         wWZMhtXy8ohvU8MMFHWEdZmzpTaPTQhsOZUnhqw5rnrd4zhyJMt8pzEV2oAUWrWmV0fP
         CJlw==
X-Gm-Message-State: AOJu0YxZNWG1Ue2NCFBtSBWhhxignznul0fcJAwqMuNhpoCGO1kSNeTS
	LUn9ZCdvVE5/NPsL6U9DnncunUiYYpD1/GGRlpQYXIvEylHe1QfiQvy2VA==
X-Google-Smtp-Source: AGHT+IE2CDUlgs4zWpmULr5Vx17XIdYvEBfW2tfYItMExq7c/z1yMg0ntzFz5yI9T6m7jlpxN1GBbQ==
X-Received: by 2002:a05:600c:3b29:b0:417:fde2:abd5 with SMTP id m41-20020a05600c3b2900b00417fde2abd5mr73353wms.7.1712878349733;
        Thu, 11 Apr 2024 16:32:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f19-20020a05600c4e9300b0041628f694dfsm3781929wmq.23.2024.04.11.16.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 16:32:29 -0700 (PDT)
Message-Id: <84b1cf3f914067f8c2d056578e58d5b38bef7b45.1712878339.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v4.git.1712878339.gitgitgadget@gmail.com>
References: <pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
	<pull.1704.v4.git.1712878339.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 11 Apr 2024 23:32:19 +0000
Subject: [PATCH v4 8/8] SubmittingPatches: demonstrate using git-contacts with
 git-send-email
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
 Documentation/SubmittingPatches | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index fd40a444f95..eac086133bc 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -420,6 +420,13 @@ trial merges of your topic to `next` and `seen`, you may have noticed
 work by others conflicting with your changes.  There is a good possibility
 that these people may know the area you are touching well.
 
+If you are using `send-email`, you can feed it the output of `git contacts` like
+this:
+
+....
+	git send-email --cc-cmd='git contacts' feature/*.patch
+....
+
 :current-maintainer: footnote:[The current maintainer: gitster@pobox.com]
 :git-ml: footnote:[The mailing list: git@vger.kernel.org]
 
-- 
gitgitgadget
