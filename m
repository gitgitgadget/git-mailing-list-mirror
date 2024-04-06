Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CFB1BF31
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 01:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712366551; cv=none; b=DmnNJaTSwk+bFHFN6kAOr+R//HCG+TK++c+3YVm+q56uOaYpKj1lDPvcPtOZBA4w7v4WVXuBY2j3EC/trTBoRzCuB0qwbirHgGpK4pcC7fRQ4ANalWaB8rHOCZCPlPwWBz9Dg4YQBeE9j+aD/xQgaavMIr3aZdi4T7Q00sXstdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712366551; c=relaxed/simple;
	bh=A9u0dvzLwFmWjdg1odRVfFFjXVFBaShVixUOJj2OmdQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pZ9sbJLfsHdQ50Cff7ryXTh3iyi+C+6iX7PEMe9dayKeNGr0tNYZq8tevu+x+cw9geEEfaKn7QYKV/gOfzYzSL1WYytKDzlSTpBoeYwY6Dtf6y82ecsBVBzNrlIakt1ejitLOESVbMQJZycaa5pcEQBJf0J+GvHw05R2zJoxUQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgWvP113; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgWvP113"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4162b0e21b0so14857905e9.0
        for <git@vger.kernel.org>; Fri, 05 Apr 2024 18:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712366547; x=1712971347; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ArzzgeZqp6f/ie1rMicJVmVBDZpVN+vnuC5DQMBVDwQ=;
        b=AgWvP113Hm1ETy8w7uCFHV/eWFxjsWRvhfxrwPmTNZRuGeAoj4Qe7VXDRdOhMD+0bi
         DZ/1RjYW2ODpFmM20PFGYYGxXZm7VY4Krk2rc0A79/JNi8CWN2y3VeN/ip6Zwy7sHjYw
         UfmaAnesb6s6/FQdpR+4ErJY8GsQNhbeWZi/vqATP4IHhYCXUs8hAzpD0Xs7RPZFR0T8
         wSczmPBLnMmCWavCa2uz51OojKgHQ1u2//0AZSDRajJWe8ytrFroXOZWuC+akVXZZcZt
         RpBUbElN+5V/pvCFflbPZ5xzbSzaLxgWnUOuOXybmJbvTDmI3jV1ZSQ86Bgy72sbRKCF
         kCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712366547; x=1712971347;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ArzzgeZqp6f/ie1rMicJVmVBDZpVN+vnuC5DQMBVDwQ=;
        b=M3KubhZr8o4TciqiJU4GjjHkgnPo61oYsYhdDx/0xee4lmObJaehldrzUfw1mfPpZF
         925psIcN5vH98K5VEf+840NQA7t1FA+RVXEoWcKQ1D41E7oAxMz27WKKvmja0j1NwH2o
         Gf1foNzt133RsLBLikoStJr6oEVTXnSbTGSs8PNKsbmCzY2khIfxXbfj+L0kNNwdZj77
         eOpbEfvPUIUjq2m65gffY5ArB1WWes+KWji0UelvedZDOhCaPrKfFEp7xhdxzxh1iCJq
         C4L9NicQIznq6G7DBC83iT5I9h8f1gauLnVULDWqDigkSUPe3k349cnmUPQmGQFgOzdP
         0wjw==
X-Gm-Message-State: AOJu0Yy3fmAQFT/NM5doJ/JQDnfZ7HGm2x0Hmn90pj0B6BrNM7Nfn9nI
	s44JPCy/YboS9fELNLaac1RyQt/lxJYo24FzW00lgu6e8cOAM7BkKAox1+4N
X-Google-Smtp-Source: AGHT+IE+2ZwxkzKUuHzYYKjhiNufQFU9wEKWqS37a3OQq4alFb58iGzZweWTNfX+HNzA6PhMeBjbbw==
X-Received: by 2002:a05:600c:a0f:b0:416:33e9:1e5 with SMTP id z15-20020a05600c0a0f00b0041633e901e5mr503783wmp.0.1712366547232;
        Fri, 05 Apr 2024 18:22:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg35-20020a05600c3ca300b004162020cee2sm8458286wmb.4.2024.04.05.18.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 18:22:26 -0700 (PDT)
Message-Id: <b35748f0cf8d7c501428794d555ab79a7a59ae33.1712366536.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>
References: <pull.1704.git.1712017205754.gitgitgadget@gmail.com>
	<pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 06 Apr 2024 01:22:16 +0000
Subject: [PATCH v2 8/8] SubmittingPatches: demonstrate using git-contacts with
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
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 48224e745ff..11c3e94d4a5 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -413,6 +413,13 @@ trial merges of your topic to `next` and `seen`, you may have noticed
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
