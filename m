Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58D99460
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 00:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734481795; cv=none; b=D+Grj4xUrjj/sdXMUJsdu48BP4LuRuiNmPVzk1FxnysU9XY4/mJb2a8/tLnRPjmJj2XToXf3Tzvxvi4bcWfGGvaTbX8RnCJEXhHSfDDKSiniuZEuR/q/QIQldVjhiZwcdApQwtZ9IECk7IwusTE2Ku/jAH1TDAOB4s6RmA1J8GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734481795; c=relaxed/simple;
	bh=RrQ10dXMdwTEmUqvq8n1DaD1afqICtkUhGlWw+ni01w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=V8WA7NKrWsP+rTzGZv9Q1bCTc+dxj78u9xOJGZnwUxNq88rq/O54ffdO77yOLQ+3S35+l26Zspm80whcKM1qLWXg8NIpVEkohSGjZqGLf6OOwvFkExcTPHymrsvcP2hS/pec/faEPK02y9OPoSU0kV6iVkEGE7bp48W0gNkTHL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U13phTuW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U13phTuW"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-432d86a3085so39493795e9.2
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 16:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734481792; x=1735086592; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QepR5PG42GKoaw96GXVqT4/4JvRk+iPXfBOEjOjk9Bs=;
        b=U13phTuWG+NknmLkkGPYZ9qKIpmcfAV6y1CCbr1qE3bjEQbFKzNhFn8r2wzOD7XpS/
         XTqkpJz/HPYf6hzPX6HKrS4pmhCSqfuNQqjjlYogzxpVgLBa/y40QpvdKfNC9UnCGca1
         HuiDGWacw9VDvLr+oFxq1d4rpSjK2lsdmPEQPb/SukzXSFCZEGs2/eTBFEtqqiosjyPj
         jsjX0HeJWfaW9odIUh/HFXRVNr9xJcf97i8kzuaFumwJFZQLs8+Z03klZmmf5b0SSNMP
         Xzr4hSmNRdBY514AMr2rD3JHwpks/50Oa4jLUwLlJZyx0mWzTdTNOfQaZnWfHvQV+RSU
         p4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734481792; x=1735086592;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QepR5PG42GKoaw96GXVqT4/4JvRk+iPXfBOEjOjk9Bs=;
        b=KIhPxbaNyoegAOLdQO2juPtVlAsV4Ih3UA57Hrb1ElGrvc+vCJjiRNp9pyplxtxdwT
         wXtrL0Nlb44p2pwFxEs0m6zxyZJmO8BiYQFwVNPVeeFjcJB5I8vH7zHnOF6B5OVnotw3
         yYLv1eNtu0GoRoUGtmqbJU2vQSt8zm8YjJgdPvBA4cnszE3GQuZ9Q5Jsri/HUkJU3z89
         Z6gc4gUmXxcmojl3qNsu1a7eoeTJxZbSNVhcQ/ehtGzOrdFoxF5/767JDYujEX2xOiVp
         d7NIvfhAbkELKfWOkf2AeDyPI4hOgNnnrNHDq2zLhzMLhkEvy88VQ0dnYBLV99DoyiNK
         hHDQ==
X-Gm-Message-State: AOJu0Yxj6W4zGm5kXR1j8A3jFP0xdiDhAf2vpul1gcom/oOkeLBWJlV9
	a2JZzSeu2OFrNca+W+aBYnPXk1LgHz8pnWy4ZUtBH4ZXJCIFfOhy+UUlsA==
X-Gm-Gg: ASbGncuyeoMw/qET/Wz00N902N7b/Ve/3V83wDzero7rkArcX9fx3a9HbIJP7gS/GHl
	QK1cSz4OgfpwgpwpbFHPr3LGL8mUh6BIwoME+QRdyvTJrko6q/HDRiIOmfcqWPIiHYIs3JU+VSI
	+SJnWzVsFMN0E2w+wQFNNmtuQgfA2PsVyjHtl5RRgFD9B1vX3LUJcxtcAD5Lt0KlVSZLkuF20A1
	6Hp6ia3soczrFQMLBSaKP+83sOPfy6Z5FK1N3MSXudV/NTxc0wa6QCGsQ==
X-Google-Smtp-Source: AGHT+IHEHTbxLWZGpIJ79KWL9Npuc3SJCJlYPRFvJXgDORlT2n0ry6lDZsrnl2KSj7VQNr+Oye7uQQ==
X-Received: by 2002:a05:6000:4b0c:b0:385:fcfb:8d4f with SMTP id ffacd0b85a97d-388e4d84cfbmr644281f8f.21.1734481791397;
        Tue, 17 Dec 2024 16:29:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b01b2dsm2455875e9.12.2024.12.17.16.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 16:29:50 -0800 (PST)
Message-Id: <pull.1404.v2.git.git.1734481790015.gitgitgadget@gmail.com>
In-Reply-To: <pull.1404.git.git.1671470222521.gitgitgadget@gmail.com>
References: <pull.1404.git.git.1671470222521.gitgitgadget@gmail.com>
From: "AreaZR via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Dec 2024 00:29:49 +0000
Subject: [PATCH v2] win32: ensure len does not cause any overreads
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
Cc: =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason <avarab@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    AreaZR <gfunni234@gmail.com>,
    Seija Kijin <doremylover123@gmail.com>

From: Seija Kijin <doremylover123@gmail.com>

Check to make sure len is always two less than MAX_PATH,
otherwise an overread will occur, which is
undefined behavior.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    win32: ensure len does not cause any overreads
    
    Check to make sure len is always less than MAX_PATH, otherwise an
    overread will occur, which is undefined behavior.
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1404%2FAreaZR%2Foverread-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1404/AreaZR/overread-v2
Pull-Request: https://github.com/git/git/pull/1404

Range-diff vs v1:

 1:  f9ec5429d01 ! 1:  dfc34fb4c1a win32: ensure len does not cause any overreads
     @@ Metadata
       ## Commit message ##
          win32: ensure len does not cause any overreads
      
     -    Check to make sure len is always less than MAX_PATH,
     +    Check to make sure len is always two less than MAX_PATH,
          otherwise an overread will occur, which is
          undefined behavior.
      
     @@ Commit message
      
       ## compat/win32/dirent.c ##
      @@ compat/win32/dirent.c: DIR *opendir(const char *name)
     - 	DIR *dir;
     - 
     - 	/* convert name to UTF-16 and check length < MAX_PATH */
     --	if ((len = xutftowcs_path(pattern, name)) < 0)
     -+	if ((len = xutftowcs_path(pattern, name)) < 0 || len > MAX_PATH)
     + 	if ((len = xutftowcs_path(pattern, name)) < 0)
       		return NULL;
       
     ++	if (len + 2 >= MAX_PATH)
     ++		return NULL;
     ++
       	/* append optional '/' and wildcard '*' */
     + 	if (len && !is_dir_sep(pattern[len - 1]))
     + 		pattern[len++] = '/';


 compat/win32/dirent.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/compat/win32/dirent.c b/compat/win32/dirent.c
index 52420ec7d4d..fb63d1adbc5 100644
--- a/compat/win32/dirent.c
+++ b/compat/win32/dirent.c
@@ -30,6 +30,9 @@ DIR *opendir(const char *name)
 	if ((len = xutftowcs_path(pattern, name)) < 0)
 		return NULL;
 
+	if (len + 2 >= MAX_PATH)
+		return NULL;
+
 	/* append optional '/' and wildcard '*' */
 	if (len && !is_dir_sep(pattern[len - 1]))
 		pattern[len++] = '/';

base-commit: 2ccc89b0c16c51561da90d21cfbb4b58cc877bf6
-- 
gitgitgadget
