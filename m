Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F013AFAE4
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 08:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521824; cv=none; b=E7AGHZJj/R9HzUxfQ+yb25RcLfSi6zykU6N5O6MsUwrzICiiHVSxTEMD295P3Vk8nSvAskl8B+YvULxea7gH2QKT1teQgN1BjBplczmcdyrleVz/lUCla7fZl8O07yOATSwI0lnpCoQIoZiuBhySQbsRaIf3u9LFMA9UoQYfONU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521824; c=relaxed/simple;
	bh=My6xMcWiSQRC21O7e03KbFzyG+Lek3st4bEshLposLE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Nv7VDa5hx06sfXczQ68qu6+DOwbYeG27bwg/LbL8GuREFs9Vn4V7rBWeFw/ShqeJGS08oGOwbr3oQUsQh0pecghwPyaA5VQID/RnTKDblWiRPLNjUIlF7s/G7LbNtuLDgt7g5KYNjg2k/EsmqT3UZLYeSbyhLjEcplVvQfw2LOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcSNt/hL; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcSNt/hL"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ca7c1176317so524064a12.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 01:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786521819; x=1787126619; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=czqKAQJUC/S5g5U+hEUPK7DNG0qtNEtNKLR4YJglJmY=;
        b=JcSNt/hL6ML7igjJeRdMIbx4fJz/a/6vIHyzE/eabwWFfo5P6SCtnl9k2yDqmbePzR
         fyYlEYxDEg7uK1cqs7qA8RCo0V+1LWAmoN0jGArd0WBjKEBh5zoAmt8++QwKewnOUIbQ
         21CntfPlRkQLoyywl2EaabeRo6xtGqk/F5WUEMGG+Z5qcov8v3LjD2iaXAYmT71Q//bx
         TTSgroEflY29VDxAvQ/ECkfoPy/ZFpw7lcUcDOtOv3swYq5Wn3mjESS10SqntGKhutbu
         OV9HAGULh8G0HlZ93c7pkAyRbWOFWfSG143XKtqIyX3VXOrFnPVgRxN7Ke0OrHhtBeil
         jCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786521819; x=1787126619;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=czqKAQJUC/S5g5U+hEUPK7DNG0qtNEtNKLR4YJglJmY=;
        b=ZARpOI7SrrnSFdVUXypLdTHA6RN5jZOqTWCmhanJq75QBLvNsIUJPJ6lkfdijkU+d2
         FTeSQVZ3HKRDkGR+iJf6c7FIwRULRIHCSiJVDAnWObrkU63JKSD/FKLgoJ9qfIL3d5vW
         RUNG/23KyacdFRqyrQ3udxopCqQGRGD8dPp1rtLsXkOLjDrDZBhnkdRxw40/ZO33dSa+
         HC8nDcDLNuw87jB7e1gyso+3TvcA1r1PlyYwWRLyEDRfhDZ1o+5bKRl8IhNAjD0BgQG9
         WoLX369FNuVdAPVh+KDR1ciBoFLPYXLApqNpHhQKJhC7iITZMd7TCvJRoc+TCOX6SwCp
         Dy/Q==
X-Gm-Message-State: AOJu0YzozXd+SuovHiqA6ailr2IvTVcTS+8Jjr2++VUwPaRB1PkxxtlE
	kAY68gxMuPpBUqb6B5/uED0PYQenSk/d3sGWpFYcHLUDyVAeLHZnPAf7DLycOQ+u
X-Gm-Gg: AR+sD11xmtQmQ87M7QA+SsKMNpd60wxu+ir+O2lV7oZ3OjS0FpxX1EqY/9EqfMVi6ou
	Je9cNYT2HZ5lgP+6pL+FNxoFoMHYB/41o07o5GBlfOZ4w7NGdEOFkcBh+JMD5ELZ4SCSG4mhTDT
	uluYbws+Z5jSV8QXux1ttVR6zR92fm2dyI1GDSAMBeNABQQEECcSlCKfIjjJoF++j7PPWSXV/dS
	r2REbhFyrtiLKAvwNFUGwrfuYGVzgymlIM8h/bTJjXlz9+S9toevQjVK51OL+r5lJ4tCDZrOULO
	pL0gHZkXGbEROAhzkRi93FknMtslThz60k4kkjYB7gt8tb9zOJt95VK1fcZa6/IZ6Bdbz2BqeH1
	0t/peK2nmwtLa2u9bXjGKohlPMFECshVPP94fERiMOJkZrC31kHfIVMszHA4aETTurGnED16eNx
	jftcfau1CN2XuxK+gn6lfK28cms+AzD7sxirhA3vqUPwdIiSjNQvv01FP8/yXz6w==
X-Received: by 2002:a05:6a21:698:b0:3bf:5539:f93 with SMTP id adf61e73a8af0-3cc3f89b6e3mr3680180637.38.1786521818875;
        Wed, 12 Aug 2026 01:03:38 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.71.70])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbee7d15328sm312997a12.15.2026.08.12.01.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 01:03:37 -0700 (PDT)
Message-Id: <6e2295b8f039ccbc3d4432d1e37bd1414b7facbd.1786521801.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.v3.git.1786521801.gitgitgadget@gmail.com>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
	<pull.2179.v3.git.1786521801.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 08:03:15 +0000
Subject: [PATCH v3 07/12] compat/pread: check initial lseek for errors
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

git_pread() saves the current file offset via lseek(fd, 0,
SEEK_CUR) and later restores it. If the initial lseek fails
(e.g., the fd is a pipe or otherwise non-seekable),
current_offset is -1. This negative value is later passed to
lseek(fd, -1, SEEK_SET) at line 16, which sets the file position
to an unintended location (or fails with EINVAL on some
platforms).

Check the initial lseek return value and return -1 immediately
if it fails, consistent with the error handling for the other
lseek calls in the same function.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/pread.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat/pread.c b/compat/pread.c
index 484e6d4c71..ac7d058cb8 100644
--- a/compat/pread.c
+++ b/compat/pread.c
@@ -7,6 +7,8 @@ ssize_t git_pread(int fd, void *buf, size_t count, off_t offset)
         ssize_t rc;
 
         current_offset = lseek(fd, 0, SEEK_CUR);
+	if (current_offset < 0)
+		return -1;
 
         if (lseek(fd, offset, SEEK_SET) < 0)
                 return -1;
-- 
gitgitgadget

