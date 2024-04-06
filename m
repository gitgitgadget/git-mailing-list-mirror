Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7293125DC
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 01:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712366545; cv=none; b=ikrzW0rBjJ57l65YZEnpnbw6nT114gY2SEMzz7KDphMnnoJFqEI5q2SHmVLTezkumxMsItgB09ksV6jked0OA9HHWcwM43YFDO0b1DO8xF/42+TEj5c+ZC4yPbUVo6251ZZyTFWP0d+S1PmQg/wMCUbao6Tdndzhlb1DZiFNcz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712366545; c=relaxed/simple;
	bh=njHys7aqHmJeoegisq0yVyi01xQBW0W7XIJMtB8rfSw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ibqbsJ83VxPw7p98QQ26zqa0x6+J8cpm7MrjqrkCcrs1i/M80mrQ5P62U6NE2bDlVHlVkVCicB6K3wg7sd/KhMng4aUZIOHBpuZYY55L8eE3ji618x2Y3n95gejg53h1NCKTexcdGGRcJAUaf/aBIbF8kf9fgFmqID5QaDASqLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbHXNwS/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbHXNwS/"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41638ba5323so442035e9.3
        for <git@vger.kernel.org>; Fri, 05 Apr 2024 18:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712366542; x=1712971342; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlOpFDkfpFvhax3pB4KYhZY4cXff/yHJbwusPhgiXWg=;
        b=FbHXNwS/dUuj1Oy5yLyf6DVbR8Lxjq9nelkcvXdcC5eTQgFMsHdDgR0lBYSBWhIFIO
         72HFHCsEv3KQuS4rwC+n7CRpJ3B2O7pNc8ToYEJ2jVnu94mFcsPGNTuRZYBZOED/+3nu
         FbVxQH+l3XWZ5sEbJ4R+rL13iZVz2NGlS5Oann7hnSjtScUuhfk6rykzgxg2B5ordORA
         4Ibbufu6qrVq4ryYsMHgnBOL+I/vIIeGpoS1dzBhoEZNg5g5HEhrRQDwykLKsngVwAWx
         licKp7RrDnh99wT4kD5T7h2emxvveQ7D9LkyvyV5rIS2zhYuoFrdySqyhrnldc1tawLr
         eNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712366542; x=1712971342;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlOpFDkfpFvhax3pB4KYhZY4cXff/yHJbwusPhgiXWg=;
        b=AA7ODfElDfd2LH7AHFtN9wvtet8GvJYSgDg9ubiBsrwVnJpLqUfIxzOIWYgz3+Lf/a
         KZZTfQ/GhIeEcx0K4L7m4h7uY73Ojdx8vDIGj+/xoTNzmD6HywphmAi4hfOSn0C3C1uS
         HKsK0Y/xxBbnV1IchIG1E0CuhmQwuZ3FEP3wdNPhvhQnRl1hSEO0GBVCsHdWNsGDQO0v
         5lZoa8PYns5cgJ7GW1o9hZLWFPmU+GYy8yLCFTO/qD69MkBiUNdrChNT6RhHEgRXXEus
         9QQHUXErR0pdLvbvGQGIYZSUMQEg+taB4xzRg0fb584ypfVeeLQTopFT0Qzdb607x+4Q
         djtg==
X-Gm-Message-State: AOJu0Ywb23yC3W7p8vwmV0+zwMCah6XS7l0Tuq1BM9QoxhKAPvO73ymF
	nDQvLtUUWQm7yvJF6DsASmWKbauPfY0u5TOXvOSh6vpbqu8BJK0vmp0wED5B
X-Google-Smtp-Source: AGHT+IF/KPUDkAnIaiXFtEu+S0nI45kAdgU4bWr3Qxs7T0WyL68OjLTL4DCssVbVyg85p9w5B8IVMg==
X-Received: by 2002:a05:600c:4754:b0:414:a76:3d5e with SMTP id w20-20020a05600c475400b004140a763d5emr2400018wmo.28.1712366541883;
        Fri, 05 Apr 2024 18:22:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9-20020adfed09000000b00343d33ac824sm3229590wro.78.2024.04.05.18.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 18:22:20 -0700 (PDT)
Message-Id: <6e6950afa6e6e884ee89ac24c05b50dcc722657d.1712366536.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>
References: <pull.1704.git.1712017205754.gitgitgadget@gmail.com>
	<pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 06 Apr 2024 01:22:11 +0000
Subject: [PATCH v2 3/8] SubmittingPatches: mention GitGitGadget
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
 Documentation/SubmittingPatches | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index a33fe7e11f6..48b270b4c48 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -408,6 +408,10 @@ are optimized for the workflow of sending patches, avoiding many ways
 your existing e-mail client (often optimized for "multipart/*" MIME
 type e-mails) might render your patches unusable.
 
+NOTE: You can also use GitGitGadget (https://gitgitgadget.github.io/) to send in
+your patches. The discussion here focuses on using `format-patch` and
+`send-email`.
+
 People on the Git mailing list need to be able to read and
 comment on the changes you are submitting.  It is important for
 a developer to be able to "quote" your changes, using standard
-- 
gitgitgadget

