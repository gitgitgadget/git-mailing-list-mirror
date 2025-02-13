Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DC8245011
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 18:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739471864; cv=none; b=RpFB0iFlJOpxRKbOotJ++DLCOS8BfOOV+6L1hiOBiL27rH7Bq1cTki//fT++euBYpbTAdirz1m5IwbNBnwQWruABleG43ZLlbQGtFoHzZ3u9yL4Yu9buVhzqeGuUt0u4fRu8Fn0U49b+/MI4O2KIa5QJnMZc7EYqIY71UU5sHKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739471864; c=relaxed/simple;
	bh=RVomXlwQJKX61/D9b92qPJG+bf902FGFyKYZ96blsBI=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=i4hi7LtGWkeATZh0axjugHBCKG+oJvh7ED+s+EQ+j9GZ3F+e4IBViql0ph62guP5WJiSwoFYbnGOptu/Yw+6bm9dqRlHAclQl0fgWRApbUGEabFNRyuyAa3bojRN/i9ocrKPNTyBJMFGbitknDaYXp7jGs5mCbK5t5oyR52DowI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oog2bfrR; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oog2bfrR"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43955067383so9106595e9.0
        for <git@vger.kernel.org>; Thu, 13 Feb 2025 10:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739471860; x=1740076660; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=habvQk8CZIIyjyn/ixFSspZN+u43Ke16xQZA8Nxrs9w=;
        b=Oog2bfrRkoQUyU4A+SKc0VLolxZooXX2IjyZq/9yUOQHSoI0ldco13GYlf1WqDAruH
         lv2LjqfDM7KIwjZxlPtgJAjc+ODA/mjTl+uGisCKlrCrbJI7Q6tW4bMJs/G2izNBTjJf
         6ZXKcEIQH/XevRu4pkC8fXErKMBcO2gDLXdudrRS+9pFyX/yXrkgCDuvkjIWcZZgbc/O
         8LSMJeBbRdoGR38q4oAojaAwh7oXnsvAwhjvcbplLEiIE5+UwthnG1JJLq8PtPA4jUPt
         YwrgvRaCTK3I1/+HYUCa6wM9nS4ek/yie5ZcNQZGqFm88JEYr/bLX2ezPfpqAmiMoDxd
         1dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739471860; x=1740076660;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=habvQk8CZIIyjyn/ixFSspZN+u43Ke16xQZA8Nxrs9w=;
        b=fOSq3LRzvdhVcVP5ek5UDxFNWFLGncbUpa02Wv/C+vyaNnF+xBjHwlVfe0vRsVdUfe
         R6N+SWsdlc9FX1x/yNE6FqA02pDW9WTYDSj+tAzxm6NDSXvg266RzKnZ1ojhJVmWO3xL
         L38jAAEzDiu20hirn7c0kV9kwla4qPGrcJbyunxogvrWymMq5JhtvOu8iRBn/FPUROvB
         0yN6w2l6diWJOx0hVgOHA2N3KCtwpaUYixiOK2/o/2nhOQPGLyOWfj6R+UwCEGNxk/jK
         tKK0bG96k6Lu5YeLGd5ktjPp8r6zbUtyuHT1u+kDMLTjeJv9PYmjkdcHlk4vAoqKlnVu
         TM4A==
X-Gm-Message-State: AOJu0YyQp7PKHd25ALCwXNfK6Mf7IPJnoW8yOARhZhCsumEVwmtYTuzi
	NOAcnkJlT7MnTg8faefoQAi2d0q/lCF+CuKQY5/mIAMMkKWCs1B3p83YRg==
X-Gm-Gg: ASbGncvO10WouXKfaj0L23uFsDAXzWhsKjPyqNRJP/Mo2YqOugGW5OlH4J8A1P3rGt0
	E7UESKlr/uTc6dMOd74BGbdp7fNkHiPBk9zF1bknmxD7GCFI9kOd68kOWPp+aoYv8K8AHDEluc+
	742jNzf9lXLbPuoDGnFpQgwDCXQZxGuwr7q4NVB3NhmofWllXvSoZonU9Lv4a7lw7WTN1DXqH0a
	cVVaLrCOYBVXnbzUV6dBQSWkKQRgzNj+TDXbnQxdGtSyHKRGDyamJhKAEUqPj/9fCl4Y2viwXja
	q+ztmhtl2jjT4iv6
X-Google-Smtp-Source: AGHT+IEjWjW+Aw9tChufF+dB74JL5Zi/VemTlIZm/PS3QqKrDL77pJKTWciyp9L+/+uTJT1BUQqpjg==
X-Received: by 2002:a05:6000:1565:b0:38d:c99a:c1de with SMTP id ffacd0b85a97d-38dea3d017dmr8818977f8f.19.1739471860224;
        Thu, 13 Feb 2025 10:37:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f2580fe7dsm2594257f8f.0.2025.02.13.10.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 10:37:39 -0800 (PST)
Message-Id: <pull.1859.git.1739471859.gitgitgadget@gmail.com>
From: "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Feb 2025 18:37:37 +0000
Subject: [PATCH 0/2] meson: wire up contrib/credential
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
    M Hickford <mirth.hickford@gmail.com>

It would be neat to also run test t0303-credential-external with
GIT_TEST_CREDENTIAL_HELPER=wincred but I couldn't figure out how to do this.

M Hickford (2):
  meson: wire up credential-wincred
  meson: wire up credential-libsecret

 contrib/credential/libsecret/meson.build            | 3 +++
 contrib/credential/meson.build                      | 6 ++++++
 contrib/credential/wincred/git-credential-wincred.c | 2 ++
 contrib/credential/wincred/meson.build              | 1 +
 contrib/meson.build                                 | 1 +
 meson_options.txt                                   | 4 ++++
 6 files changed, 17 insertions(+)
 create mode 100644 contrib/credential/libsecret/meson.build
 create mode 100644 contrib/credential/meson.build
 create mode 100644 contrib/credential/wincred/meson.build


base-commit: e2067b49ecaef9b7f51a17ce251f9207f72ef52d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1859%2Fhickford%2Fmeson-credential-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1859/hickford/meson-credential-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1859
-- 
gitgitgadget
