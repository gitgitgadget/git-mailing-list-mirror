Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F6A13B58F
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 16:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734540400; cv=none; b=uzB6SWr3RafM/CdPoEQ8yqWismq3gkAEBjCy2qTETUJiioeqmuiaTflBr5/iAMtslLaz+/ucsQueV+lEuPyw5pJ9MWC/+7zAcH/kKiMNwxXnMj0DVubFKg3cETN9RwxMvp3E2NQKKWtJ1mzJcc4IC/PyDICxy7fCoa1UUdbfIzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734540400; c=relaxed/simple;
	bh=UDYJMIW6D6HrZm9lVun9k0Xy28wjKx03csyeBsDC3vI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Km6IKSWSyGWUXdeBilBwFaYSeZoAFbRvOrgOXBU5cheGTtBIOIZ/yXgoDeB2LVMAQTgpqHxPdPeaeaWZmTWlI0dw+SDq0GmFXj0iL9NwAtxZTYPOnIu8YbNiLWNSbEXlEi7hMGVmamUUlH6S3DOnFq6lW6d/uwcwCj74Xg0vE1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCl2tt4Q; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCl2tt4Q"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4361e89b6daso47561195e9.3
        for <git@vger.kernel.org>; Wed, 18 Dec 2024 08:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734540397; x=1735145197; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyiWxvsIAV4FdeY6oxaj/ywlB+kfDE0BUF/HiGCRvf8=;
        b=DCl2tt4Q/urw3nhWgxAgycyaDkybAt1G660AhedgloQYel35uclL7eme0S4OH06olG
         UUVA2XkZqH8ViBGBPhRn0C05H/KHAeA//jZmUjDb00H+kLiPJbMQumqOIrI/dJUA0wRc
         qOkJ0R4//fcRdMv8nBFl8Y1QI32sxrgsUY6wqDh5jzN4ojR0Za3OEsSUESzUEtLUNQsq
         lwk3dkLjdu10W2zHKALSQchXGSqbMKm0EHwz/5KwLvaDqJCOmpmvSm0HSRHpnGbrWTQa
         4CZ+rd6lHmTKfsuX67G48q5PvAzixd3ZgOzZgesKKDh7ccFiwux4fNsSPARdxtGsYz/O
         QDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734540397; x=1735145197;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AyiWxvsIAV4FdeY6oxaj/ywlB+kfDE0BUF/HiGCRvf8=;
        b=fD8HZ4m/V1eGbJ8tVfgXympAJIfF8VT0FW4PrSQUN0P7tEQnEHRjYHlZxeENjgqhF4
         Igelj7cB+XDU3hCOLChLu29J8a5xxOI5ywLm2nY57fgOf6YY/YhK+iEvlhxjbOn9TIMW
         jHnn7HnoetKGdIF7ftIii5k1zHMnRvK6ZC9SqwgatsVZk1MzKO9G1SnUZfbhToAImkMv
         rgc/j9vbI9rp1bDoLmDq5+2cxNKeW/3f2Wd8E3ExE5+zb5axFJNIvcGoLSWP5Z5Qj2np
         McJl9qFIAABLCS/dHmxiYEDdJ2P6/3lsJMM79eGwm5AcLfoe9Cp2+ZG2hmmlxqWq+OOE
         iT+Q==
X-Gm-Message-State: AOJu0Yya103Wmlk5AFOkNhbSP1BIYlbjYLtyRgikwnPon4kR5mqVnmCV
	+z3GJgNYYdjmbmcCrdutXiiV75jLxVxPawdEDUY6QGKDN3zEYKd54u+ynA==
X-Gm-Gg: ASbGncsAQrfwFfeHFwaiImh2O1VPnB/QHQJDxPUtr57VX/vi238/7eu8CafolffjI6C
	F+6fnOH1svsvsZqhNcDDxG9H89GELRMjZ3n/5ndYXxpcU/H49uxHOrw3r2sAPIhKJpHR3siHQ4L
	tSnS5x/VvoLm5HXE19RLnqw3kJ9Gq5FcJE3DpQn5EIMKTHZ8nPGugPVrh9ANLHUZnYog1CSfOyX
	QbvOa36PYSkXjtBlJDVwQ4KbbH2lL2AiNH4h4pk8yK5ctDTqgct6lNctg==
X-Google-Smtp-Source: AGHT+IF/NJvOoVFttUe0gWjiMSO2kC9TaQJCJsdFQGR8ITP3/dvFelJHnk94cG2WK3+LsND0UUPV0g==
X-Received: by 2002:a05:600c:190c:b0:434:f7e3:bfbd with SMTP id 5b1f17b1804b1-43655426a47mr25931885e9.23.1734540396684;
        Wed, 18 Dec 2024 08:46:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b015b6sm25303115e9.17.2024.12.18.08.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 08:46:35 -0800 (PST)
Message-Id: <pull.1620.v5.git.git.1734540395021.gitgitgadget@gmail.com>
In-Reply-To: <pull.1620.v4.git.git.1734489540328.gitgitgadget@gmail.com>
References: <pull.1620.v4.git.git.1734489540328.gitgitgadget@gmail.com>
From: "AreaZR via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Dec 2024 16:46:34 +0000
Subject: [PATCH v5] git: use ^=1 to toggle between 0 and 1
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
Cc: Dragan Simic <dsimic@manjaro.org>,
    Jeff King <peff@peff.net>,
    =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Phillip Wood <phillip.wood123@gmail.com>,
    AreaZR <gfunni234@gmail.com>,
    Seija Kijin <doremylover123@gmail.com>

From: Seija Kijin <doremylover123@gmail.com>

If it is known that an int is either 1 or 0,
doing an exclusive or to switch instead of a
modulus makes more sense and is more efficient.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    git: use ^=1 to toggle between 0 and 1
    
    If it is known that an int is either 1 or 0, doing an exclusive or to
    switch instead of a modulus makes more sense and is more efficient.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1620%2FAreaZR%2Fbuffer-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1620/AreaZR/buffer-v5
Pull-Request: https://github.com/git/git/pull/1620

Range-diff vs v4:

 1:  db1f0b1a323 ! 1:  5bb2cf10062 git: use ^=1 to toggle between 0 and 1
     @@ diff.c: static void mark_color_as_moved(struct diff_options *o,
       			else
       				flipped_block = 0;
       
     -
     - ## t/helper/test-path-utils.c ##
     -@@ t/helper/test-path-utils.c: static int check_dotfile(const char *x, const char **argv,
     - 	int res = 0, expect = 1;
     - 	for (; *argv; argv++) {
     - 		if (!strcmp("--not", *argv))
     --			expect = !expect;
     -+			expect ^= 1;
     - 		else if (expect != (is_hfs(*argv) || is_ntfs(*argv)))
     - 			res = error("'%s' is %s.git%s", *argv,
     - 				    expect ? "not " : "", x);


 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 266ddf18e73..5c2ac8d6fd1 100644
--- a/diff.c
+++ b/diff.c
@@ -1231,7 +1231,7 @@ static void mark_color_as_moved(struct diff_options *o,
 							    &pmb_nr);
 
 			if (contiguous && pmb_nr && moved_symbol == l->s)
-				flipped_block = (flipped_block + 1) % 2;
+				flipped_block ^= 1;
 			else
 				flipped_block = 0;
 

base-commit: d882f382b3d939d90cfa58d17b17802338f05d66
-- 
gitgitgadget
