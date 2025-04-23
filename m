Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9BB26F467
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 08:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745395318; cv=none; b=EbqnrSA+tLwY7ezsiYSd/SyHbyydVFnozcaNvUTgd8SBc4waqgCZuKp0f2P7VskVMvfDfWsC8ROV5E1G5AHkldKmjqop0U5s1lmF935dxWo7ytov4nVtiURHJqc9V98mDpxVLDSxuQp6QW0LKT0b1rOErpUI41FsKoc+XMMlRnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745395318; c=relaxed/simple;
	bh=UNMvRrviKnl4JA+Z1N73oezsdoyKAzNauEQF9KpUpmw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ev8jG+RuWr0Qt112oJ6o0uNJv1IDxd3UNgpa/vrz4VERY5q/MarTtEijpeGKQQEwUunXltGK4SNKfNvp5KXv3mS+BYy5VXukbFqeb8S1ap9p/GR2Vz7IQHuKgvZRTaYpKMTxMH08wn31P35UrQnqD0LmN/uVQtf0Zcj2Ag7qdBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmFhXxrL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmFhXxrL"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4394a823036so49416225e9.0
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 01:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745395314; x=1746000114; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALDsaaKQ+z7cPRtrQ/hykW85qBkozF9veFhA7c7NFFc=;
        b=SmFhXxrLumoCKtCS6T07O3uZoRSdM8DwSOb4V+h6RdfMEHFTCS9y3XuNREAIGvVYDY
         nTnCOypU4tbbVx4ZMbcQT9mA0HOdyE3oluWtZ88w2oJq37U+o3HdBT4G/oEt4FovKC8F
         e3S7DwSf4b02GheEBRgngVs4//Ti0mVDidCdSiwfHF0h/Nu03czYyAaDRyaxhjPr3buy
         0vvS/rJQOa0Sv/+2GBrptNDetgLlt13uQVY9RLdyCL2bO4mZq1Ud6hDvOA1hSKHAhzWA
         smMrAnrEd9n1fxpPxeu3ughgmYMPavRUb18uNzfAJkITSMwHDb00MJIlegUOjhSNdjrB
         kJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745395314; x=1746000114;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALDsaaKQ+z7cPRtrQ/hykW85qBkozF9veFhA7c7NFFc=;
        b=iTLu08C6tnmQWJInlJl4/uRCqwFIygmwJ9Ke/cCFzZR2WphygId6A5RL1ElKdGLGFv
         RselMfXGYi6kxBJILEQ5d/FZjZ7agrzWiB4qbWSh/EDZgGgRP1GATBPHqTyJMMwwZTC8
         QMNKk2ea/1nCLXTvUHEhhSSiaxCyVopZWE7W4WclOB5dtHXxEBClWbZ1kzy/qkg7JpDx
         HD0D3B+RspMmFFQmgumvOPhyJ8ywX8NldhnmXRW1pTJtBp8ePOLJ9CkWISF6/IJLPkOd
         917VYDJzkXAYMfuTxtou64et2EgRNI6SRnESgXRM7D7G+96vLsVD8qHMixt7xfJPlzIV
         yg1g==
X-Gm-Message-State: AOJu0YwURm8MgYkX425In+uQaB73bup/jQbEgfdxX784YOxDfq5pb1hK
	fbOrX4yofa5uUHFCqKGsdAGziMDHHej94gAE9uQO9UnkhEcN9iOySKgLAg==
X-Gm-Gg: ASbGncu53KUT2CvBhDP719PGNtjLlzayq+p5CsZvZs0Kc6wvslUV3jA58e9gMgJh1c8
	UNpv++8ByLtIUrfaNOIUOxUjuFt+komViFNrry7THTZYwPz28jQm8Sf6E8WoVXWwnWBY+x62fch
	k99w/DpBht87NyMPsIALywjNcgJ0lDk7opr0yLAHBbLQPOapY7L50p4IFvSOOqOI7v1UVgxDqwU
	+BaI7/dUd4BCtiLwXI6y0NlVdZslxSAUR/dyFrwiaxiMjTEy7jLkDygtaQLSX3d7wmIasiNbZq8
	2tly3+fqwLcD0/H7Dx7r40boyX1lbAUdP8epfP/WnA==
X-Google-Smtp-Source: AGHT+IH7U7XxBhuz9QkHv6hCZQ3IpFNd+oqVFWvZMvXNQECoQM74ze4AfsU4OY4TxkWTk6PLG7Y2qA==
X-Received: by 2002:a5d:6d8d:0:b0:39a:c80b:8288 with SMTP id ffacd0b85a97d-39efba5bf52mr14681582f8f.33.1745395314239;
        Wed, 23 Apr 2025 01:01:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44092d21720sm16146355e9.12.2025.04.23.01.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 01:01:53 -0700 (PDT)
Message-Id: <c89ead8eaba7f824d6a4828964f8384f60b17101.1745395308.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1904.v2.git.1745395308.gitgitgadget@gmail.com>
References: <pull.1904.git.1745239150.gitgitgadget@gmail.com>
	<pull.1904.v2.git.1745395308.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 23 Apr 2025 08:01:46 +0000
Subject: [PATCH v2 4/6] msvc: do handle builds on Windows/ARM64
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
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Git for Windows/ARM64 settled on using `clang` to compile `git.exe`, and
hence needs to run in a system where `MSYSTEM` is set to `CLANGARM64`
and the prefix to use is `/clangarm64`.

We already did that in the `MINGW` arm, i.e. for regular Git for Windows
builds using MINGW GCC (or `clang`'s shim pretending to be GCC), now it
is time to do the same in the MS Visual C part.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index 6222d2c5a48..bd94f458088 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -432,7 +432,11 @@ ifeq ($(uname_S),Windows)
         ifeq (MINGW32,$(MSYSTEM))
 		prefix = /mingw32
         else
-		prefix = /mingw64
+		ifeq (CLANGARM64,$(MSYSTEM))
+			prefix = /clangarm64
+		else
+			prefix = /mingw64
+		endif
         endif
 	# Prepend MSVC 64-bit tool-chain to PATH.
 	#
-- 
gitgitgadget

