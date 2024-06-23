Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E55181BA2
	for <git@vger.kernel.org>; Sun, 23 Jun 2024 21:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719177852; cv=none; b=ttEZrqA1LR0oEHkqKEG8KvrzJtg8rQXWz7yqYc7TMI5wtroEUZSE5DOE0BqHtCNhCKE5+J0RgKFL0myy5fNcPbqgX4SxEvMKLfI9bIlAYrSAuyX2F1tQWx/1ukxPw2f6NFt1Xl8CSJPIZPLqcKJ1MKAX9oeM2W4E05qpqNhDAms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719177852; c=relaxed/simple;
	bh=H2dVF1X/aE8wWRWrY/gefSJAyDDmjjOiPUzKxPgrwMk=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=j3GH6FHKqfL5qOLs7ZueE4TiO0p+YSOLEbiSGhDllcwNHZrbzyv1s3VdBW7Sz/zDTtIHp5x0Kl3Qsd5tFDH+GPB5xtma6sKS1BseKEBQgiGrq96eopcr7UHE935bG3IzrG1z9C8Lac0WSSQapm5Vq4urUuwsJwGqpLEPx4Vi0JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIhQ9Jox; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIhQ9Jox"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-421cd1e5f93so27958925e9.0
        for <git@vger.kernel.org>; Sun, 23 Jun 2024 14:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719177848; x=1719782648; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GV2K9vYUamRkbJvvTvE5bIYrye8sC0Hqlz9GjLillQY=;
        b=nIhQ9JoxDeBp4u6qovh0umVmVLjha4/BBv8rOYodKdlvctNuNP/dic+9K6aYycmln0
         +dUOQQbUy6bjgvnOauDg+J/nBEoAn8PLAwlsrq4BkMQtAXF70H3d18ARBv/R4JDXNs2z
         yFZj3gqTIfm5BkKmGl3CXzcq7XTwn3p07rR67dZ9xEyX/2y/gfNMqFUScyA47e1y02D/
         73NFn6aO2lV60n/Js66ri42vbKZiouC+ueHYkD2aPmf+YMdcn3g/cd/npJ+wxCIXheXm
         Fsl6KpmZOujyPBkXdYX3NshODKds7yrIiwsyDYUk3554RWn8Zmuy5dgTy6hcR52jIrrf
         dCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719177848; x=1719782648;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GV2K9vYUamRkbJvvTvE5bIYrye8sC0Hqlz9GjLillQY=;
        b=C87khrRcsN+dgLqPapQCxR2FbHzQrxVTh/+k4th4KkxFnMOZGlb5DYCqMi4MjYGiHj
         Wr/2gtjXKH6c9xfdWnMz9CZlMT/wrLaERYbKhPrIRDkBNOBsFTWo6QF+L73E6tG5wP03
         3kuzTWhQ6WnRd7OV4QdFqtTa0sGg/G/AI0CtDteG6DaJl2/1iVONbQzqmaHXDyMHmCgs
         aM4YYI75ywsFyqKRwA8iS3HI/P4LDWs6pelMDNGZ9gP6qklh7m5TwHUXk9POcwHmcew0
         DYuTIwOokBPRucri+XhvstQ/TC+MEjfcEd65nddUna8PAzTm/s4E6Hnovmv2qyLhbmDB
         NhdA==
X-Gm-Message-State: AOJu0YwiAqEZG3XoJAJ4JO8tM2aZKF26900aiuhReFqpevlxq9lzvo0n
	cuTgWknk1RAImVLHZhjrtRoDZf6Ekrd0fbVUIHohhdJrQuvoePR05KUkJw==
X-Google-Smtp-Source: AGHT+IHGjqtY2oUQiTzr9UnL0EwQ7jmTe9VCxQ9s1oX5vUgTjrV01TDyXFLSQDPb4IXmYHLKY14OTw==
X-Received: by 2002:a05:600c:3b1d:b0:424:8e5b:390 with SMTP id 5b1f17b1804b1-4248e5b0824mr19037375e9.0.1719177847724;
        Sun, 23 Jun 2024 14:24:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424817b5549sm116275725e9.23.2024.06.23.14.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 14:24:07 -0700 (PDT)
Message-Id: <pull.1733.git.git.1719177846725.gitgitgadget@gmail.com>
From: "Piotr Szlazak via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 23 Jun 2024 21:24:06 +0000
Subject: [PATCH] doc: update http.cookieFile with in-memory cookie processing
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
Cc: Piotr Szlazak <piotr.szlazak@gmail.com>,
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

Signed-off-by: Piotr Szlazak <piotr.szlazak@gmail.com>
---
    Update http.cookieFile with in-memory cookie processing

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1733%2Fpszlazak%2Fdocumentation-cookieFile-in-memory-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1733/pszlazak/documentation-cookieFile-in-memory-v1
Pull-Request: https://github.com/git/git/pull/1733

 Documentation/config/http.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
index 2d4e0c9b869..228bed32ec1 100644
--- a/Documentation/config/http.txt
+++ b/Documentation/config/http.txt
@@ -78,10 +78,10 @@ http.extraHeader::
 
 http.cookieFile::
 	The pathname of a file containing previously stored cookie lines,
-	which should be used
-	in the Git http session, if they match the server. The file format
-	of the file to read cookies from should be plain HTTP headers or
-	the Netscape/Mozilla cookie file format (see `curl(1)`).
+	which should be used in the Git http session, if they match the server.
+	The file format of the file to read cookies from should be plain HTTP
+	headers or the Netscape/Mozilla cookie file format (see `curl(1)`).
+	Set it to empty value, to enable in-memory cookies processing.
 	NOTE that the file specified with http.cookieFile is used only as
 	input unless http.saveCookies is set.
 

base-commit: 66ac6e4bcd111be3fa9c2a6b3fafea718d00678d
-- 
gitgitgadget
