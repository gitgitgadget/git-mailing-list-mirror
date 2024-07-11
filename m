Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67781581F0
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 08:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720687014; cv=none; b=XFxr0e4Vbd7oUTibgSiTwZJV90pxaPAXkMk0BzeQACkaHTpH0vXekqb7mlHotToZdoqNXZAGTp5Tfo2jeHHtcdVHZAyipMOEP9G3oJ2hrq9sc1Tt9S8SNRmrnqoxNMHrNJFCP5hIJZMahWeOx5H+hhx7fnkQkwBPi+9Y3KJYqB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720687014; c=relaxed/simple;
	bh=poDMSwEc6B3SCAgLbOXGWv/CHhTC072yPl7VgW2bHJc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qbVSulglq7lUy2FEpa0HXGRGZgbjxRPOE3WjmCisQnYM/Pxk8I5PQXWQijYM3c1HQY7oym5GyulKIZLoONcEODnHIIvkE4MIfUMQrha4d9JGfNJHNRedX36CcRRwOIB3rZlXJgkKrc4GwPvU8xoGo7ytJZAqpgQ/Ig/GNJQSNwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZwk/n0h; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZwk/n0h"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-367ab76d5e1so182170f8f.3
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 01:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720687011; x=1721291811; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nz0sBk0HrVeC3HH2mUkH55UALO3tE+nZbAKvzx3coII=;
        b=kZwk/n0hpulad1W3Ovy/SLsLthwD+OnBYG1JFU0NVKQZ7uCwI0LO/xW33u8yRe1Qdf
         0+Sj+Yh9OSHAMvqDi4JSjALgMZ+/nISuSPcg/MQ6qkFz2din9GOojIvUUicQ97mnX1Li
         XTlY2gm2o2jImvf/u5eW/JYEcixps0QosjZIfeXLGVN+/pycZiWXWy9quz2rIFcIMzQ1
         VNPewiV31WmtYZgperMvRiW+1CIRNYJX2kvszZRRrI4WRIkSc4+XekZTJVhein/6KKng
         ifaCBRasPWoTIrH64ZujJJv9/WMadkDqEaYsqEm/htR5vvh7MLNcXpQwTbSJB6ufAuGw
         zZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720687011; x=1721291811;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nz0sBk0HrVeC3HH2mUkH55UALO3tE+nZbAKvzx3coII=;
        b=eqIYr30HhRz2Y75dlLWeGK3kMmqvVUmON+BjxlP/eKrWgQYqJCZzlGel/YCUoygLoB
         CvK4QbgawsrZHsdSSPhFMhV/dEiCgiA4lInueiG9DgtgGjcqpDto9fsmW2SmhlxZ80Dt
         Aec8XkTTtxNaTYQ1Diq465poHoArUOUdOM3c92/ihIHX+4JMwD95ZlJQykuq1pSQYDa8
         w9FvZT1QY+XXicL3CoIklxdqFv9ROvG95uGn9hjKQeGWz5PDpuQ1LF6z1eqXqbNSRi9J
         ZowvNg6rvnaWlyI/E5iFkRTaqDe5sRFcJIISdUJSo9vi3w286zrFFSBlKfT2oTtNDazI
         eyAw==
X-Gm-Message-State: AOJu0Yx/VKiama0AiBBcz4YzaEZpMGvxohnyoFUe+EKpFZVeTUPy5m8+
	SLfyT1WzXe6uefmBsZeAcK/L6bGoct+nAXGuAEl+i7u13rtXYA7fjvhFoA==
X-Google-Smtp-Source: AGHT+IEwKBnaz/55nIv8ZbpICYF6wRA86qwpSQ58wdPfkdBFCaqCjc0H67DjKgU/ExioNFnW1vjA5w==
X-Received: by 2002:a5d:634d:0:b0:360:7506:2b8 with SMTP id ffacd0b85a97d-367ceacb21emr5205405f8f.52.1720687010354;
        Thu, 11 Jul 2024 01:36:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde8425asm7116338f8f.26.2024.07.11.01.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 01:36:49 -0700 (PDT)
Message-Id: <pull.1733.v2.git.git.1720687008915.gitgitgadget@gmail.com>
In-Reply-To: <pull.1733.git.git.1719177846725.gitgitgadget@gmail.com>
References: <pull.1733.git.git.1719177846725.gitgitgadget@gmail.com>
From: "Piotr Szlazak via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 11 Jul 2024 08:36:48 +0000
Subject: [PATCH v2] doc: update http.cookieFile with in-memory cookie
 processing
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
Cc: Jeff King <peff@peff.net>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Junio C Hamano <gitster@pobox.com>,
    Piotr Szlazak <piotr.szlazak@gmail.com>,
    Piotr Szlazak <piotr.szlazak@gmail.com>

From: Piotr Szlazak <piotr.szlazak@gmail.com>

Information added how to enable in-memory cookies
processing. Cookies from server will be accepted and send
back in successive requests within same connection.

At the moment documentation only mentions how to read
cookies from the given file and how to save them to the file
using http.saveCookies.

curl / libcurl will process cookies in memory if file name
is blank. Check curl manpage:
https://curl.se/docs/manpage.html#-b
This is described here in more details:
https://everything.curl.dev/http/cookies/engine.html
And also explained here:
https://www.youtube.com/watch?v=V5vZWHP-RqU&t=11459s

Git documentation was updated to include suggestion how to
enable this by setting empty value for http.cookieFile.

Changes since V1:
- better explanation what in-memory processing means
- added explanation that http.saveCookies does not work
  if http.cookieFile was set to empty value

Signed-off-by: Piotr Szlazak <piotr.szlazak@gmail.com>
---
    Update http.cookieFile with in-memory cookie processing

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1733%2Fpszlazak%2Fdocumentation-cookieFile-in-memory-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1733/pszlazak/documentation-cookieFile-in-memory-v2
Pull-Request: https://github.com/git/git/pull/1733

Range-diff vs v1:

 1:  5e9b3924224 ! 1:  c4d41b5884d doc: update http.cookieFile with in-memory cookie processing
     @@ Commit message
          Git documentation was updated to include suggestion how to
          enable this by setting empty value for http.cookieFile.
      
     +    Changes since V1:
     +    - better explanation what in-memory processing means
     +    - added explanation that http.saveCookies does not work
     +      if http.cookieFile was set to empty value
     +
          Signed-off-by: Piotr Szlazak <piotr.szlazak@gmail.com>
      
       ## Documentation/config/http.txt ##
     @@ Documentation/config/http.txt: http.extraHeader::
      -	in the Git http session, if they match the server. The file format
      -	of the file to read cookies from should be plain HTTP headers or
      -	the Netscape/Mozilla cookie file format (see `curl(1)`).
     +-	NOTE that the file specified with http.cookieFile is used only as
     +-	input unless http.saveCookies is set.
      +	which should be used in the Git http session, if they match the server.
      +	The file format of the file to read cookies from should be plain HTTP
      +	headers or the Netscape/Mozilla cookie file format (see `curl(1)`).
     -+	Set it to empty value, to enable in-memory cookies processing.
     - 	NOTE that the file specified with http.cookieFile is used only as
     - 	input unless http.saveCookies is set.
     ++	Set it to empty value (''), to accept only new cookies from the server and
     ++	send them back in successive requests within same connection. NOTE that the
     ++	file specified with http.cookieFile is used only as input unless
     ++	http.saveCookies is set.
     + 
     + http.saveCookies::
     + 	If set, store cookies received during requests to the file specified by
     +-	http.cookieFile. Has no effect if http.cookieFile is unset.
     ++	http.cookieFile. Has no effect if http.cookieFile is not set or set to empty
     ++	value ('').
       
     + http.version::
     + 	Use the specified HTTP protocol version when communicating with a server.


 Documentation/config/http.txt | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
index 2d4e0c9b869..e71ca11c10b 100644
--- a/Documentation/config/http.txt
+++ b/Documentation/config/http.txt
@@ -78,16 +78,18 @@ http.extraHeader::
 
 http.cookieFile::
 	The pathname of a file containing previously stored cookie lines,
-	which should be used
-	in the Git http session, if they match the server. The file format
-	of the file to read cookies from should be plain HTTP headers or
-	the Netscape/Mozilla cookie file format (see `curl(1)`).
-	NOTE that the file specified with http.cookieFile is used only as
-	input unless http.saveCookies is set.
+	which should be used in the Git http session, if they match the server.
+	The file format of the file to read cookies from should be plain HTTP
+	headers or the Netscape/Mozilla cookie file format (see `curl(1)`).
+	Set it to empty value (''), to accept only new cookies from the server and
+	send them back in successive requests within same connection. NOTE that the
+	file specified with http.cookieFile is used only as input unless
+	http.saveCookies is set.
 
 http.saveCookies::
 	If set, store cookies received during requests to the file specified by
-	http.cookieFile. Has no effect if http.cookieFile is unset.
+	http.cookieFile. Has no effect if http.cookieFile is not set or set to empty
+	value ('').
 
 http.version::
 	Use the specified HTTP protocol version when communicating with a server.

base-commit: 66ac6e4bcd111be3fa9c2a6b3fafea718d00678d
-- 
gitgitgadget
