Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2263B14CD
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 06:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789020334; cv=none; b=M95ushZdOLL2GZArp1H1zBJUKR3UiW/XKO/5r6M2h96RzJPAUi/IGKs7/UsQ5Rv2SeYdS/rIoPn+JaxhurK1f2QoArHlQ4e0YrGC2bIq3PsvA8T0ThV6KvZBg207L1vD5jzFddAwoCT0zsQhwoyMrXk6G65tSQ4oxmvjSqI4iEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789020334; c=relaxed/simple;
	bh=rTF1R/bph0FBqZ1/y3s5DfZ17wbvs5LwUl1joJbN5o0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=I6whu6myv6VnmbReLfrtOJoF7LDOOdauMxvUdnEan4sCKZ6rEiQmlG0+GMhEoEgtGWJkKI2wpJ1zKeBDmH0mdPORCA9PiDw1J0IOF2afYz+RR2ilPCLwjnCkRTXa4OH8ykEvpanmqpbpzwaKE6UtMQ2g0O2IuOGhhEnYMOqJqlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2CI6v6M; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2CI6v6M"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6be1f18687bso1052363eaf.2
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 23:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789020331; x=1789625131; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ylM5fbaUVbTh4a8j5Myc7FJH7fV58EQnrmgE47mMG7M=;
        b=L2CI6v6MWIYSYbhLSGBuA73yGc6H1kdKEGQfzixd8D7/syTb4ZxqixdQzKLJqc2RpU
         YItgUBa9iqJk0w9eVtZbeWcPUaxAYysNrySsszM18LZgGXMUSYIZBSNmzYES9QCKylxb
         PZ5N2iZaMPHYV0GzXSWqrRYTb9a9jpNzGFpV9q43PrfzxM1GF1MNDhr6i3VXHmRfN8Yr
         hT4eUFQ8gnd66AGXfQe9HlxZa5lhowtIegzR/6QC66uvfHo324VVq3NEu6PHUywqCy2n
         FfV9o0X3/8luaK8gFPXYcd9GAPE6wMJfDZEQoBlVjSuupbhk+uwU91Npk/IZ6OgA3ROb
         P0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789020331; x=1789625131;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ylM5fbaUVbTh4a8j5Myc7FJH7fV58EQnrmgE47mMG7M=;
        b=XcWPBbIZphzoKP1UVy5AeJ0b++yDHn/BVHnOKewf+EP8dFv0TcUSQeYWN9UPiIDtuk
         U4Ixuzc/J0D6wm9MrY6vAvCZkoOYl7smH35165zNRGDovIFUULGOQfLPUdNF8IcknQiF
         gV0ECBigQOw6qgC01YFE0xrJESDt7qnbllYmPBU32d/bKzYDBndAHZGWK62VM4EhVXUU
         zLOMuX20phToL1OyL5hoq+7gOZ3JZI029bVXL0oa54q/QfktMP9SRy7toooSX8LgIOae
         azUjfXRC/kEbHgRt5gmPcX92McBMwD2BRgSFX4ftiMeZGpb7qATufbWb2elYzBRw8D1e
         rM1A==
X-Gm-Message-State: AFuF++kQ+vxl6Knmkn5ADYQpfPSrRgaT+knq5J+Mss8Tg4lhpKSW17Eq
	RSIgdxfjFFtjRJu0ELivrHANq92cFctuVDOSwKCO/OA+tn9rts1VFlEoDOtNZw==
X-Gm-Gg: AYBFou2nIdhr8nKFnrlL0I3u1n7eqNOUTWXaNNyXPJm7AhYUUHT2qvfSWxqyxJz0N7M
	kvn6RxwbNf/DRTfd8LJhAFUrbcsi3aBkTgpRkyYjmlYnugvtnNRzN6rvMZU901w+U05Xi4hfK4G
	R5FXu81cDGV0V9iWg/SajC54qpxswyI5axkh/PYl6JI7BNJdoYIj6E/sbjccd7jY/G+brqdXJmJ
	SGBJmCV5Rnnud5i1H9ASTl6Zf7xsg2MP75qZBFIavYDlz5KfoWBiknWfswvvlGydaeDQtJQUEvI
	07jzFE1DuYAWxDyIoTOSF2gocM5xYKYmUhkKFX0YCr0P8l/wz9ebpRlhVVEPgzVgCkxv8dPHUlG
	lDrI/8QH7nrys9Zi5CT5KnWJVoCybuY2NAxZUyO5+rEwYt8SosMm1avNNJIRSFOz4UkcIN56YzP
	LDAS7EHetzQWvDnKJj741/lQWRqWGIBV75suQ6kOiWNEUjOkUrV3ughHp2+5fzY6QeLjZu7M4T
X-Received: by 2002:a05:6820:2017:b0:6b7:83d6:2929 with SMTP id 006d021491bc7-6b783d62f60mr20779222eaf.44.1789020331559;
        Wed, 09 Sep 2026 23:05:31 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.70.110])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14332405e92sm46301294c88.8.2026.09.09.23.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 23:05:31 -0700 (PDT)
Message-Id: <9894892ff590132f875cd2e2bf33bfea4b7edb20.1789020327.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.v4.git.1789020327.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<pull.2195.v4.git.1789020327.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 10 Sep 2026 06:05:16 +0000
Subject: [PATCH v4 02/13] mingw: stop hard-coding `CC = gcc`
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
Cc: Johannes Sixt <j6t@kdbg.org>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This is no longer true in general, not with supporting Clang out of the
box.

Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index 8dd8acfaa5..a464b2009c 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -771,7 +771,6 @@ ifeq ($(uname_S),MINGW)
 		COMPAT_CFLAGS += -D_USE_32BIT_TIME_T
 		BASIC_LDFLAGS += -Wl,--large-address-aware
         endif
-	CC = gcc
 	COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -DDETECT_MSYS_TTY \
 		-fstack-protector-strong
 	EXTLIBS += -lntdll
-- 
gitgitgadget

