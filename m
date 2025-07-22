Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEC32DBF40
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 07:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169915; cv=none; b=FRSdMp9GeGRaprlRfKNsZoTUihTEAZl01ygnveeMziElVhQFKoEn+cr4dnfCIA59XU2ZoBTdDuIDntM+7nSXa7FkLhk/DlrF8ZlgK4p6IPlIpksVEJDYb/HjnFMaG/xOiqTuOn1LuQ2RGhnbDmxa2kdJLphgRYBvtibbGD5YGKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169915; c=relaxed/simple;
	bh=xjJmEa3uAOuL1/1nAVqGPaawaLnAtL2M3U3jtPQuOXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DbkUaLk9jPpkroqiXSE8c1KSaGH99HGLG5Uw17e2DPh+U3oACUMT6a3814YGI4ZSFOLOiMks0+o6mjIEtKR5YzEC4YbWLNMaXBC9mfzJ3vWdXQiLlnxDPDADJ6mGA9Riz0SDmbOceFj3RvRBBS65hro03SVEXX2JuTmfJWRTHvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYUICq8H; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYUICq8H"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7490cb9a892so3142225b3a.0
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 00:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753169913; x=1753774713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQ+QYMrJNrmDoPmzHhDMhJ/+TV/3wEW3YD9ECWHPQc4=;
        b=KYUICq8H5IGFEl8H/v0MLWBvWEpqPhWimmoTfXI5f1+LhDAK+mwOxgh+W8CZVAWHS8
         m0FOhyW8hxPCqj4DvffUPcUphK6nhwbevLfTZglsko/cZQ9OhGfBlMmh4wbNBek8j21i
         WgZUX9Xk0Ct85zAt6CxTnWbebsR8hhdRXBwU7sGMZl/HsvDBtKGNba4HYU0eqPAewur1
         vqh5A107i0MLqUrOm9vdA1u03nNhpjDhbJ8zT5gPRafQaBracotvuNdkghW8yxShYPW+
         rMnyv5P0wuKWf90aRys30GHW9iPQmg/KoujeP9lhJXFI82xPnyfKCaZ1pZEBpRBl8vRw
         /UwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753169913; x=1753774713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQ+QYMrJNrmDoPmzHhDMhJ/+TV/3wEW3YD9ECWHPQc4=;
        b=Kkqj8N8s+EJMejAx9EyWFQguUvKUSroS20hBPCg+xSTFm47cMFy7GQIkqfFqEocvKq
         GfXd76vJkllBgGyS/ajR7AR6CDxYhf+ZOTnQGX3/bCNTw81xoocNkHe3CT82ONkpqfEa
         SgT5sq4EQp64uMw9rqUX8h9n11QvjMVvPS1Qo4jI30tAKvVZKDG2CHSFl08Cj0ZgiGwE
         k8JZfz1eKSDuXi9mTg+OgLzwyyaqhTiS0OJdKRcycCOZX10eEiBTxV3JN/K1ym6GCM6g
         mtlDcliqCQelB0EsFvBAu4ktuiAdk7JM1nzLgF6GVwdi2g1sY9W24INA8R6fC4quheCp
         Ohtg==
X-Gm-Message-State: AOJu0YwCELOT5AHuxPZnMI/iOy+hRcFrwrlm+JXzA9U4nHn2GC0V1SD0
	jrlXKJ5xxrX52xvOb7I/pvTIWOJC8ua8BAkwjOYpvVZFtb9++cbcj4u39il0kKhX
X-Gm-Gg: ASbGncvPzKf4//TGr9uNDCmdlufDSTw3mx7blW6bwcDTnNqZrY8vZo3VtmCCB1XKu6q
	SD1nnpKgMGm+mcL8z/zW/3KQxEbmJkhTFYd/My4VWNFqVhZwI+fFeXNj6kTK4zrA+BQtMuZx2K2
	x54SaJXDfhIrHBFQyx+UsocfSuCBTTZpTel5RsxgmrC3Rgspl/WwLdufCNN8CQWZFWbY70+F5wg
	ERkidwHlPCg1oe/22XYGfLgXucW5MNkulAHDYsgXm8BUgR8v/fwxmPjf536PAn7zaJbks6zL9v7
	bUI+Bd2SUveJB7kcgdskWg8u8A+SvSDCfcjB1Ss6sI7ievaj9gU3nZPjjgHTOjpSGb1Tb70IOl0
	r6PnJaMj/ZLSVwgsA7V0uaQJVNJi29j4C6A==
X-Google-Smtp-Source: AGHT+IG/uEz5eStwo4hDw0ro33LSxT3AqcIaUT2uofcoJ1zwqsQUyvZIaKoVmxy2vERuVFg6WGXKnw==
X-Received: by 2002:a05:6a21:6b04:b0:215:dfd0:fd24 with SMTP id adf61e73a8af0-2391ca68491mr26181132637.31.1753169912980;
        Tue, 22 Jul 2025 00:38:32 -0700 (PDT)
Received: from localhost.localdomain ([211.37.148.227])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2feabe7bsm6393713a12.32.2025.07.22.00.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 00:38:32 -0700 (PDT)
From: Hoyoung Lee <lhywkd22@gmail.com>
To: git@vger.kernel.org
Cc: Hoyoung Lee <lhywkd22@gmail.com>
Subject: [PATCH 2/4] builtin/archive: close file descriptor on dup2() failure
Date: Tue, 22 Jul 2025 07:36:32 +0000
Message-Id: <20250722073634.1080217-3-lhywkd22@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722073634.1080217-1-lhywkd22@gmail.com>
References: <20250722073634.1080217-1-lhywkd22@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In create_output_file(), the file descriptor returned by xopen()
was not closed if dup2() failed. This leads to a potential resource
leak. Ensure the file descriptor is closed regardless of whether
dup2() succeeds or fails.

Signed-off-by: Hoyoung Lee <lhywkd22@gmail.com>
---
 builtin/archive.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/archive.c b/builtin/archive.c
index 13ea7308c8..c919a39f90 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -14,6 +14,7 @@ static void create_output_file(const char *output_file)
 	int output_fd = xopen(output_file, O_CREAT | O_WRONLY | O_TRUNC, 0666);
 	if (output_fd != 1) {
 		if (dup2(output_fd, 1) < 0)
+			close(output_fd);
 			die_errno(_("could not redirect output"));
 		else
 			close(output_fd);
-- 
2.34.1

