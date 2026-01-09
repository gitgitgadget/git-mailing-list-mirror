Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073FD36921F
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 20:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989132; cv=none; b=NfPzP8rQox+z4exKMbQzo1RR3jVCRNqj1v7AbSakKBDHKVxxCV/RVgTLZwFcdm7crAaGriuSbBVw8yStevpa7RCRxixYYW6tnV2DdWAB+BtOTygboBCkFBI1F0k1soyMmUz0j+cgHCE6N1bvCz96zT4FMCw5cuoMyanyZncxPNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989132; c=relaxed/simple;
	bh=+VHMtfFWcnXYWJsAY/EVv/le9EE/5DAua0dMBjAqisg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JdKbcno0AhSYvO62HYD3n6BU8TyO7vTmmMmPNdVKjqd7ulBRLvfOeaJrtMbj3CAgAUoyXh7brBbIpMnVk7Dt9Z1kb5Il+WMN+j1o8kX6uby4AQlqbqpfhHaX6HSHj1YKXsay8LF1m4B/2lMyscQ4n8alc/4NTOd3Jna53Othqzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njnHvmbD; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njnHvmbD"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b29ff9d18cso499994185a.3
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 12:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767989128; x=1768593928; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+Z3FTrVE9CAckr5u8N4vqh5KuI/5aT0qj+YHfM/kp0=;
        b=njnHvmbDV4VNu6tStJeIw9qoMEG+P6wARFdCneJ4MyU4h6pS3oZ+0Ha4zAGP3uLZLy
         oNhWnkK+AAnw3J0hIsslV0yIWcoEbkXFN65GcTmP0g5hKlEyf+4RC84F5B/6OS24GnI2
         l5Ijr6pC63b8wjOK2Het3b/2bDDMvPbU1j8EeGPu40SBljHK7t1sC5T+v8lvFhJ0Trco
         OxtUsGBc9VJ3bMzklsY6qKe9ABHutRe4ONR48j/DSECKA/iNYjHResss0MTsHglFMcCl
         cz89wvm/NY1blcZVs+C0iUCNqozdej8GyTwPdYOQgMoLjIbWoGImp24PBuDd8InMjFF8
         Z5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767989128; x=1768593928;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I+Z3FTrVE9CAckr5u8N4vqh5KuI/5aT0qj+YHfM/kp0=;
        b=Mp08tO0CXTspLsWXHeWW3hvaPPHH/NDd/Qh/ATgm0dfspYzFa6tRJszmcgIz9j1Ad4
         89e5ZhzYUkA4j3r2g5ya9PLZ4JLrToRECMxNxWBTCmL286ZLxZ2tZZEv6WLJwwJzdI4Q
         AtCvZFhc7EIaVG8U7y7PCWkfsn/zieW1M5ofLoACJnYobwAERHhEGEdZ72FgzSdZlex9
         6VcJJJV2g8e4foGnfmKn8YY2PVPLefn6PydIg67kbHcmDx7XLD8NZaX5lzf+augEXoOf
         jzYhPF+6wn2mjriO4tgUFXREf1A6nU2FOysvKSsfNKCT0eN/20C0w2A5IIHr3H8sH6sH
         V9RA==
X-Gm-Message-State: AOJu0Yy7F6VzuVAiqwMrCt8+rTbGucZKxrSWO8k8jMk4VmuH03R74pFy
	4TmuCfFRVZFXz5xxujj38wIwSEwUGvY9cK+u3GIgXIEGyUJJ4FDuy5XYgWn3W+GI
X-Gm-Gg: AY/fxX5/TyqCCN80dos4iFkWR46AGrj3pdlVirxJO4YoUUxOaHybRT0qrwGzGyGHqdd
	OZ1HBVbB0AD0hf0AiwJeUN/CZLrylbrYtztxQ2WOv0Nfh0QkLO2irVVmaIlovKGM+57sE7TpcxX
	4bn8DKirAs/Lgme2D/OjZ2bK9rJn85ozF1KCSSB2hKFMGHPnJ1Fk9kTv+eGPSCuT8TGJeJ0pSba
	6JHsPIpG/8ZMsVUDWUUXyt8WvNVZiqvwE/cu3WnqU9DvqbOMO/EmMRZ5ctj86+kgKBPqFaVcddz
	gxOqtOh+qCImct+SljRvf6mgsUc2j+JHLlXod4zGOclRp+dFI9zKcV7C+WAuCBRFfhzEJPGiN9k
	69+5KX//4XEn8rAYIloIEOjf08KYs+j4HdXl9KEt/YLxapdyRoGi8fd6zTJsT3/jwwK2VgDh07V
	c8lRd5cLDL6DdQ
X-Google-Smtp-Source: AGHT+IE7NHLXo4wXvyxUk7S9R7N7jOSdXKc+KffKEMu06AFaKZuR10uwExOjhWyknMC3ETuGNVwcVw==
X-Received: by 2002:a05:620a:440b:b0:8b2:62f9:9fd8 with SMTP id af79cd13be357-8c38940b8b2mr1353074285a.61.1767989128332;
        Fri, 09 Jan 2026 12:05:28 -0800 (PST)
Received: from [127.0.0.1] ([20.161.67.219])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4b8b21sm864104785a.16.2026.01.09.12.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 12:05:27 -0800 (PST)
Message-Id: <9a0093d34bb87e4e6d5731acf39265d5bbd19431.1767989115.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
	<pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>
From: "Karsten Blees via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Jan 2026 20:05:06 +0000
Subject: [PATCH v2 09/18] mingw: add symlink-specific error codes
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
Cc: Ben Knoble <ben.knoble@gmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Karsten Blees <karsten.blees@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Karsten Blees <karsten.blees@gmail.com>

From: Karsten Blees <karsten.blees@gmail.com>

The Win32 API calls do not set `errno`; Instead, error codes for failed
operations must be obtained via the `GetLastError()` function. Git would
not know what to do with those error values, though, which is why Git's
Windows compatibility layer translates them to `errno` values.

Let's handle a couple of symlink-related error codes that will become
relevant with the upcoming support for symlinks on Windows.

Signed-off-by: Karsten Blees <karsten.blees@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index 0fe00a5b70..0e8807196f 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -102,6 +102,7 @@ int err_win_to_posix(DWORD winerr)
 	case ERROR_INVALID_PARAMETER: error = EINVAL; break;
 	case ERROR_INVALID_PASSWORD: error = EPERM; break;
 	case ERROR_INVALID_PRIMARY_GROUP: error = EINVAL; break;
+	case ERROR_INVALID_REPARSE_DATA: error = EINVAL; break;
 	case ERROR_INVALID_SIGNAL_NUMBER: error = EINVAL; break;
 	case ERROR_INVALID_TARGET_HANDLE: error = EIO; break;
 	case ERROR_INVALID_WORKSTATION: error = EACCES; break;
@@ -116,6 +117,7 @@ int err_win_to_posix(DWORD winerr)
 	case ERROR_NEGATIVE_SEEK: error = ESPIPE; break;
 	case ERROR_NOACCESS: error = EFAULT; break;
 	case ERROR_NONE_MAPPED: error = EINVAL; break;
+	case ERROR_NOT_A_REPARSE_POINT: error = EINVAL; break;
 	case ERROR_NOT_ENOUGH_MEMORY: error = ENOMEM; break;
 	case ERROR_NOT_READY: error = EAGAIN; break;
 	case ERROR_NOT_SAME_DEVICE: error = EXDEV; break;
@@ -136,6 +138,9 @@ int err_win_to_posix(DWORD winerr)
 	case ERROR_PIPE_NOT_CONNECTED: error = EPIPE; break;
 	case ERROR_PRIVILEGE_NOT_HELD: error = EACCES; break;
 	case ERROR_READ_FAULT: error = EIO; break;
+	case ERROR_REPARSE_ATTRIBUTE_CONFLICT: error = EINVAL; break;
+	case ERROR_REPARSE_TAG_INVALID: error = EINVAL; break;
+	case ERROR_REPARSE_TAG_MISMATCH: error = EINVAL; break;
 	case ERROR_SEEK: error = EIO; break;
 	case ERROR_SEEK_ON_DEVICE: error = ESPIPE; break;
 	case ERROR_SHARING_BUFFER_EXCEEDED: error = ENFILE; break;
-- 
gitgitgadget

