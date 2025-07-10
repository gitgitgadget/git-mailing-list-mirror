Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49D5156C6A
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 19:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752176749; cv=none; b=odaK+NCGssmjABZ9cfm1aCIzUC2fGpXxmgq461W5t049V/xKdD6B6j8zD0qohvNEbr4EER7mrAzr5zlvJe2OxNtzhMz+AMfQlD3Jr25DNXgxCcwlUbme5Cc2a6z1Mx5PuHmrHHm94S9VplDhWKZ2k8HBwvHtNHQr+74Kg6NSPdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752176749; c=relaxed/simple;
	bh=M+VsxYRBTgofBncEqH/GUIPweDLzwmXvKOc7GvnThnc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=XJCzt4T4D2qbgjmvH8T7t7jiohYxopYw8GUu+dRtLtgnc13uTiw5dolDhIlCuahBZ8B+E3wzFZgWhtrzplus/RJxu72wP3hDXs44SE2k1p5paxqnhpmDKbISFuETpQuVHDtwDqgvoGIMJsjqrt9jHfDQB8/CorobXkJRFqslQRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLgqrkaX; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLgqrkaX"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-454f426b3e5so117585e9.0
        for <git@vger.kernel.org>; Thu, 10 Jul 2025 12:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752176746; x=1752781546; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmEuLldrLBaFFdlfJZKwHskUigKfyt3w+TdwowoNYok=;
        b=VLgqrkaXhq9T+PoGu49oGOnKSJQ5RZv1BCky2q/8hR0YVy7AEtWJlGcz7lT18IEn8o
         MH4n3yu9DgNkTW4x4LrrHD512LN9qxe0l7OFuNrYB7yC39oO6PP0ezv+6Tk5oEgKco0L
         EZ0hDZXyl8dROtdaum4V4DKv4JRSS6IBl8mR5/CixGdHFF6BfCvfcMIDk47BAVfm6RH6
         BERjRl2eRPRu15djoQStopXdJ2SAalZSUPLpPm1GFWrtuJ5i8R2da3IpvJCdKZnH+Hjf
         YU8jhSa5aNO/xgEMUe7Vk661jtetwpxWeD+G0AlWPOXg1ykpBIXAE3cXOd0HNOItTABx
         Yc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752176746; x=1752781546;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vmEuLldrLBaFFdlfJZKwHskUigKfyt3w+TdwowoNYok=;
        b=lC66PuLCWTaT8Mng0JAZDjM5j/VO+5rwcENhhjmQDUDrbDlwXzlKcoYGDcac3oXihQ
         /zFSe0NDkXD1yK8Fj76OniLj4PpUqIJC+qymTlggC94DsdlgyVRvxNO5AXdQxxZqVk5q
         iM8dH35axYSZ9vo2xcUH8bOIj3A3bJ2sGj+5nIsXp7A1umYzOz5yoYxjuesRK+d59O/B
         nLLLaAOUyoIAFxOV3rwTxKywrj8NvCeglOfoOZTHRCHLXMmazxlo4n/3llCNfaDt2+Mp
         mJILjwAAiXsnQuQtxhnPgtFwf3HkwuYvjmNvI11LhLTl3OB8tSRmVBG9t5xpWmHDdyLf
         YQ+Q==
X-Gm-Message-State: AOJu0YxiXC6aj6EibAfrB34atn6DJmx5x9ZxwC5ZC20YcjxddLVXoIys
	gv60Xn2VGI9gKFTClGyMDy+kNu9r7xT/ypnN2F59ruXuTKpUMD6Ys6Y/UwG13w==
X-Gm-Gg: ASbGncsA0hfMyQp3QwHhoT2mm+MNQO/fkf/LoEBxzM7m55sSWFvcDMoXFjVZShWBeEI
	vT9qYuBIqKAiErylvm+yXHZdtSq+GBJPXzRzsGHdIKqGT3grH67xN1jXjSWUOcDng42BMPYv7xO
	ocA90qMVaOuYzsKMagAHbUdJLMzhMuDE1hjoq5zSWHEshKc89akIwiloqy+RcNWogiXxy2Wysay
	5qqh6iyYxmfBuYElubuTOxVt9QscNZ7AOlSQ5yYjRZLLhQAUPEXIA9mdL9pIEUFA+s/SGHEx5AN
	GzNWOH0+1GmMxbq3/yOi6pWEDJWodj61w+mf6IundSn+M0B7ifziwUq0XvjjVk4=
X-Google-Smtp-Source: AGHT+IFqdjBY5rCFsUvm869ydai8tMYHZcY4NbjPKxpZqQ33SUsXiL0CJ8fSSCFtjCU5S0nNQXYgvg==
X-Received: by 2002:a05:6000:24c9:b0:3b5:e6f2:9117 with SMTP id ffacd0b85a97d-3b5f18937cdmr672780f8f.39.1752176745664;
        Thu, 10 Jul 2025 12:45:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd43906dsm28192785e9.3.2025.07.10.12.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 12:45:45 -0700 (PDT)
Message-Id: <f21e8ff5c9df0989ce09b3d9a50c0dc81af18837.1752176743.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2002.v4.git.git.1752176743.gitgitgadget@gmail.com>
References: <pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>
	<pull.2002.v4.git.git.1752176743.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 10 Jul 2025 19:45:42 +0000
Subject: [PATCH v4 1/2] compat/mingw: allow sigaction(SIGCHLD)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
    =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

A future change will start using sigaction to setup a SIGCHLD signal
handler.

The current code uses signal(), which returns SIG_ERR (but doesn't
seem to set errno) so instruct sigaction() to do the same.

A new SA flag will be needed, so copy the one from Cygwinr; note that
the sigacgtion() implementation that is provided won't use it, so
its value is otherwise irrelevant.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 compat/mingw-posix.h | 1 +
 compat/mingw.c       | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/compat/mingw-posix.h b/compat/mingw-posix.h
index 88e0cf92924b..631a20868489 100644
--- a/compat/mingw-posix.h
+++ b/compat/mingw-posix.h
@@ -96,6 +96,7 @@ struct sigaction {
 	unsigned sa_flags;
 };
 #define SA_RESTART 0
+#define SA_NOCLDSTOP 1
 
 struct itimerval {
 	struct timeval it_value, it_interval;
diff --git a/compat/mingw.c b/compat/mingw.c
index 8a9972a1ca19..5d69ae32f4b9 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2561,7 +2561,9 @@ int setitimer(int type UNUSED, struct itimerval *in, struct itimerval *out)
 
 int sigaction(int sig, struct sigaction *in, struct sigaction *out)
 {
-	if (sig != SIGALRM)
+	if (sig == SIGCHLD)
+		return -1;
+	else if (sig != SIGALRM)
 		return errno = EINVAL,
 			error("sigaction only implemented for SIGALRM");
 	if (out)
-- 
gitgitgadget

