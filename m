Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AA83FBA7
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 00:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768521909; cv=none; b=aqc19SFQ+JdYNfZ3n7bcFt9FWNu6B+WJY3XaulFtI9hRkc4U3wUWWISCUlrc3lJj46ULWPUI6lYBEivUCppDmO6Q5TiTGWLMW0Wni3/7ADjGcRyv0Nm38NqhGjHTnBUYfYOKNpDrixqYLcBQZhRJvxwtGI7006cszUfc/ddtMKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768521909; c=relaxed/simple;
	bh=oVjfGG/ks+l/HiF319xdQmZZxxzCjb3hbLQFuqNTnFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTg5Ur8Q5Tl+9gCo9CMHhxV8DBJeMiZ9CPl9ShMkB68gm0BH2nJsKFHD/QozGOYmQ6Stxv5akJ6MwyWSb1V/MzFUEFjcbGv9Kte7wApwVOimfmS7nDBOIIObGn/7VX4UPJkAzb4XyUdmuhV7wAe6NGqdQ4sFVznNImU9Q0LkG7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfIx2vmd; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfIx2vmd"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-65089cebdb4so2387125a12.0
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 16:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768521906; x=1769126706; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uT/y7IQ/581XNlaI5rzIRhJ9HTv1ycxYlHMKSVpKdMk=;
        b=IfIx2vmdYkgUspXgAELjF5QMQgAQFnoRzn7yZWITw6OiwNBlymW3ti2cHZb2WuNu3c
         q9Mq/h5nzDbQR7GVnBdxTrw6+01/U6uyiBXwrqluRHcJrPmkxB8ViTCKK7eNwv5k6x9G
         ml/QvV35YWql8WJqA4+5AHbEAdmCAEY43Rci2LbfOJ4Vzx5gUVZ+u0JChjC9twx5V2ZP
         qlfxs/A4siUtZObtWKKqiVE+ah9xxB3WQmUXVh3ygAP+mSEt3ed4hWyvwlL+enhR/udS
         xECpvP1LR51dSYwscTuFpkXkUGVK1IT4C1whNDARGXp38P+OAKDbVnEkDdQO2OnWZWlS
         gAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768521906; x=1769126706;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uT/y7IQ/581XNlaI5rzIRhJ9HTv1ycxYlHMKSVpKdMk=;
        b=dmy5puG/pNjiU7Aj2wJ/VDLQaY/FLMwXSFXy1CM8kguMkjFS5qTNgk5j9VtmYNzlYO
         JcdPKRndEnLoVw8lKOZ6/3Ej6EXRawB/+CzeY+JDLF5i1DspMCFMj7qrDh/UL4wNh8tu
         s8lPXX2xzTb+JmMltnt+DTV7Z1S/p8mmVT7wVE0IwGRYPXjrXj+j0SFN0NHPkyRX/DYy
         8WdwXM28Dxuqtwm7XCh0D+zHn915xWOw5K08ojxx0vzPFz3fGZddjK0O0s7fT5AqwStU
         VsxhAlXIxJp5bHXAgKshxr3TIKRx4uq3goazt+HIMQRtob6lOnKVMFRoy1rkYLedll29
         L/wQ==
X-Gm-Message-State: AOJu0YwgVPdQp1NNyZFTva35t3DL7gdoHIPyjPABDH+rggjwZU3qDj22
	UY/nhfqineQHclGkuSRsrlF+6ssoM3mPyAV1Tgs8UJ/fBJZSBny7D1yWk1sRjc4z
X-Gm-Gg: AY/fxX4XE77T1nRH4YLfF+WkW2LwELIWJfcWP9jbujWVwCoEiAShp+mVt5okW/B/V/Z
	V2aq7+dJmyZZ2RdlYO+/dyHg8sXcSzz6XuV323X2qnTQth6M9aL2X2/dBKP8gUWALeWJWmNas86
	v0C/gw9as0DP7LBW0Oo9B9zJGQgx/nkt8uRMu0SS4Q2z269+bUDdKU34ukGhdZiqqRUBGDpZfuE
	vb6khvC2i+3zL8llKNBwMvMj/3oHX2v3IluyDU53f4sZHOgDY63qoYkEYApfevVncPlMsUvzzlk
	JK/3mhy+SttV1gNRLzbK2LHtLNLTscaDqZAMLm4UdwGbIV4PCvl73znmR3UdANi6Jxxpba+EiM0
	51bWM2jTBwo8+QSatO/b59ZV2O4mA2Fi52RzZLOS72oyLe7Jgx+cHp0Q+cRYWDiu4Zoa6LytwQG
	pIv/HIrx2O9umkeoyJLerp
X-Received: by 2002:a17:907:d716:b0:b7a:18ba:a63 with SMTP id a640c23a62f3a-b87968f6a60mr50777266b.19.1768521905729;
        Thu, 15 Jan 2026 16:05:05 -0800 (PST)
Received: from lorenzo-VM ([84.33.162.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8795a214e8sm71432166b.60.2026.01.15.16.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 16:05:05 -0800 (PST)
Date: Fri, 16 Jan 2026 01:05:03 +0100
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>,
	Niels Glodny <n.glodny@campus.lmu.de>,
	Patrick Steinhardt <ps@pks.im>
Subject: [GSoC PATCH v2 1/2] diff: improve scaling of filenames in diffstat
 to handle UTF-8 chars
Message-ID: <abeb8d3439de6569fd73617de580fa510e19466b.1768520441.git.lorenzo.pegorari2002@gmail.com>
References: <aWgYRkv-YsuekdR_@lorenzo-VM>
 <cover.1768520441.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1768520441.git.lorenzo.pegorari2002@gmail.com>

The `show_stats()` function tries to scale the filenames in the diffstat to
ensure they don't exceed the given `name-width`. It does so by calculating
the "display width" of the characters to be dropped, but then advances the
filename pointer by that number of bytes.

However, the "display width" of a character is not always equal to its byte
count. The result is that sometimes, when displaying UTF-8 characters,
filenames exceed the given `name-width`, and frequently the bytes of the
UTF-8 characters are truncated.

The following is an example of the issue, where the 2 files are "HelloHi" and
"Hello你好", and `name-width=6`:

    ...oHi | 0
    ...<BD><A0>好 | 0

Make the filename pointer move by the actual number of bytes of the
characters to drop from the filename, rather than their display width, using
the `utf8_width()` function.

Force `len` to not be less than 0 (this happens if the given `name-width` is
2 or less), otherwise an infinite loop is entered.

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 diff.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/diff.c b/diff.c
index a68ddd2168..452fc69775 100644
--- a/diff.c
+++ b/diff.c
@@ -2859,17 +2859,12 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 			char *slash;
 			prefix = "...";
 			len -= 3;
-			/*
-			 * NEEDSWORK: (name_len - len) counts the display
-			 * width, which would be shorter than the byte
-			 * length of the corresponding substring.
-			 * Advancing "name" by that number of bytes does
-			 * *NOT* skip over that many columns, so it is
-			 * very likely that chomping the pathname at the
-			 * slash we will find starting from "name" will
-			 * leave the resulting string still too long.
-			 */
-			name += name_len - len;
+			if (len < 0)
+				len = 0;
+
+			while (name_len > len)
+				name_len -= utf8_width((const char**)&name, NULL);
+
 			slash = strchr(name, '/');
 			if (slash)
 				name = slash;
-- 
2.43.0

