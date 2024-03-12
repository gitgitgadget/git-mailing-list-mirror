Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF3A58112
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 13:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710249301; cv=none; b=kfFG6KB9SJeaFhl5Rh7O+0eP206nJASp66vJnV4HOzDWBKiEYkm7fJbDSdxpJPDATyZizJPNdPfKybhN6m9Ls+hngY1PdL5PQLmUww85mh8JL7KO3YtcFvFtFmHq+ROGl6NQsg4Ahdx/IzBN+IyI7HMlRRlO7SIUMsO8zO6fEP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710249301; c=relaxed/simple;
	bh=PTR8QQcEOxGDj4nsDc7lE2oLBBfFQOcKysLn9mLiBzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5N/U8MwJdYf8C9Yn+htZj0Kgdu0LoSWWtBMOxyRieSyHlFwg5sz1+jef9CINKjORTRKJU37iy3HR2yQOaE4ugC7D9fyRzi50hTfvSQN4LdhQxJEZRif0Urmrh56J0c8dagZoxpWWMgYQD3FQKocwVPTsi3HoYzBJd5KRPdTIv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CY4IXk8M; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CY4IXk8M"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4132e548343so10009655e9.1
        for <git@vger.kernel.org>; Tue, 12 Mar 2024 06:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710249298; x=1710854098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTR8QQcEOxGDj4nsDc7lE2oLBBfFQOcKysLn9mLiBzY=;
        b=CY4IXk8M2JSWX+3uvbYs5SXKmNxY1w2D2REg+z5/RmXp1YvXNYgWjSXHDoNB+72H1F
         N0xFY1kuPQisd5gGhPKPvkLil/eZO8f1xXuYDaJhpd+avFflXZIMOAWH6STF1QwkTt1e
         5LqwZpCllRhj+e1roxOd7/PfjhfwAY45yeqYD/FXgueFX3g9maqkVsxbxrLMvDKVeTj9
         91I0WZBZEYd/crY4z60aLU904kjy1HARBghbxqjCOzUSguCluaTQMa2wI+14hGiBX3+P
         bW/WZbkxgBK2RI8j3bGoVHkrmJ+dkTsDMiVzcHel9t30TCgCVoKaoF5WlIZsuAZdS0LD
         7k2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710249298; x=1710854098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTR8QQcEOxGDj4nsDc7lE2oLBBfFQOcKysLn9mLiBzY=;
        b=Te+hQFByEFSpkTIM5ib5G3VndqOh+DfEOzVUOlfjhbrFz9N+akiV0+kkPUtAIyPLnm
         Slh7Z4IW30VF95fynon2TDq9EkHV6qcpPBZdM5UkSG0Y/x6e9GD7XSBoK/99BeK6pFI1
         4GzeBIQDw9Gb6JG/U4OZPSIcmuysV6tofvIav81hv+z4KGyYmhwi2NULqMcsOqKLP7mU
         6EQTvM8jdATGqTYuOHJ5/3YENNakKvMZfbTuLHDoMCo2euhLScHRqrjJMKTtEu88UtZj
         tCFeg+3ue6M/9DiDApNmp9k0sCGsJwz6X4E32yoF7v9clbgpSkaICVyAGBYuCyOgc3nJ
         CBjg==
X-Gm-Message-State: AOJu0YzB+WOw5c10zqPbI8GPJGu7Q8WcQpXZ5olipWRRaM+1Ntw3MsB5
	5dzftp2C9YQHp2P8i4VxbRA53E1I00prEGmk+lL87KenjO2xKdnPAbZig86AW6k=
X-Google-Smtp-Source: AGHT+IFXJyoJKc2oomunk6DtFpLWCHSYE7V5zfTZse9OvC6YEZaG5FTdgrK4mOqtNYx9QxlyXvzHWQ==
X-Received: by 2002:a05:600c:3ac8:b0:412:ed9b:621c with SMTP id d8-20020a05600c3ac800b00412ed9b621cmr118836wms.24.1710249298468;
        Tue, 12 Mar 2024 06:14:58 -0700 (PDT)
Received: from host-sergy.. ([154.72.153.211])
        by smtp.gmail.com with ESMTPSA id l2-20020a05600c4f0200b00412a31d2e2asm12586737wmq.32.2024.03.12.06.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 06:14:58 -0700 (PDT)
From: Sergius Nyah <sergiusnyah@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	pk@pks.im,
	Sergius Nyah <sergiusnyah@gmail.com>
Subject: [GSOC][PATCH v2 2/3]t4034-diff-words: add javascript language driver
Date: Tue, 12 Mar 2024 14:14:47 +0100
Message-ID: <20240312131448.638472-2-sergiusnyah@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240312131448.638472-1-sergiusnyah@gmail.com>
References: <ZeWOhxBDvyjH8gW7@tanuki>
 <20240312131448.638472-1-sergiusnyah@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 t/t4034-diff-words.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 74586f3813..cf2374af2c 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -328,6 +328,7 @@ test_language_driver dts
 test_language_driver fortran
 test_language_driver html
 test_language_driver java
+test_language_driver javascript
 test_language_driver kotlin
 test_language_driver matlab
 test_language_driver objc
--
2.43.2

