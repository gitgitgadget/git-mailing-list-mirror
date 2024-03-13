Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420505CDFA
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 22:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710369483; cv=none; b=lefjDkvgGM0BRnFOJoxxWlqT8bY6vxBztoPj27q8h/Z1/fDQgelcjE9gC0HoNGL2AoosvW81FMGFC2LuGoSnyradyuHk4Ju+nq12Zg5/b1Glqtj3kpEyk+2repwGQyMpSG1nmuYcrF4QbtmIq5Pp2DFpZRoR9mk1NGIi++nDFRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710369483; c=relaxed/simple;
	bh=IAhn0B6ySJP/0HtWbJeL4cno+obrIwQYoDgYAmdIK50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=el6yO6GOhXV0KwfOH4D23l71xKDm+diHg/jsqE45xErJHF45exobQKgkLkix0Xb/vlBMmkMWaMqtj9eetAURPsYqE+kFotEpPS1khoeDepJNhyYPBHqqgluC3vPVfAGjHeHC0bN4kxlGKb9Ehrya7XmIlZscXh5yME/hthyc7gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ks5dt9Kk; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ks5dt9Kk"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33e285a33bdso169448f8f.2
        for <git@vger.kernel.org>; Wed, 13 Mar 2024 15:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710369480; x=1710974280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCAid3A7iuo1+8dRGONu4YFfBdPI9bYh+7EPg0Neqi8=;
        b=Ks5dt9Kk/5x5g5QJuLA5njhDUdhgY9plGWTjstUWd3r/XMZDIoUd0p9+DHzE44mXgt
         SpzFWraMVF2mMa2DwcZtcYPqPsdDPkZFAQ1exEuFSpM42J2PX8/QYuXQVZiqgV/5w9HQ
         uosQcDJUAmSK7jpszakB3Ty7A5yYqlLCflEYBxOdQk0yAr2IUjbvvfTwG5s5WO1wXw8w
         3FajjIEw2VjOm5c/xYeCkZXgDDuzI7vrTdKm6KdQRzur0/QxIqO0OmpknusYu896K4g9
         rKzQr3uEwsLQYIknv/a+3a4b2TXelJWwxTV7yo+0Ri+3WY+ZtX48n6+xV77YPbyvZQ7j
         EZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710369480; x=1710974280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCAid3A7iuo1+8dRGONu4YFfBdPI9bYh+7EPg0Neqi8=;
        b=CS1TwpW9PXx6ACND3yUu9w1UK3cQmmxvBecDvM+CfM7BbiRbPI8A7UOf5om1JlnNGZ
         zHjt4lTWU44h8eCoQaZ7b54wYV8lIcUExB3/sZuZ+YK6ss5x64Vq293LO9b/yI9u1Qsh
         1K9D+zUpZIQQc+qT2XpaMl4Q2D/JdYRouOWus1K2O1GKVXdgnpRorC5TQ5wA+HTtp5PH
         m+EqkMFT0oli6e6AewCLm1FD+ze8aR5OK4L1JRqbesW47nzOZhe5ikqZ0vIiCNHuAUS1
         nsJh3oDKsKKhev/Sry7dIBrDdAuX0WmBmhY+xUiguC99H6ZIYpWC2T9ABf9UVrgVmelq
         nojQ==
X-Gm-Message-State: AOJu0YymCqIvSvyLW2ZyNzh9rVV/yCqxBBmxdGngvn8Ok0sSCg0F6Ne0
	8QH3o4U4dBql4RS4/Ckp7C4eTzkGJYhCq360M5tKgfUGR5pvT7tzB0rAZZKK0rcfz0J+
X-Google-Smtp-Source: AGHT+IFiPJczMBVD57EZZMUoGnSUFtKedFJnDOtn51GuMg/e9zmb+0Hnb1TTHholNIkgKac1Zt2rNg==
X-Received: by 2002:adf:fa4b:0:b0:33e:7a71:1a31 with SMTP id y11-20020adffa4b000000b0033e7a711a31mr2590857wrr.6.1710369479157;
        Wed, 13 Mar 2024 15:37:59 -0700 (PDT)
Received: from localhost.localdomain (cust-west-par-46-193-56-47.cust.wifirst.net. [46.193.56.47])
        by smtp.gmail.com with ESMTPSA id m8-20020a05600c4f4800b00413ea26f942sm3139007wmq.14.2024.03.13.15.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 15:37:57 -0700 (PDT)
From: Aryan Gupta <garyan447@gmail.com>
To: git@vger.kernel.org
Cc: Aryan Gupta <garyan447@gmail.com>
Subject: [GSoC][PATCH v2] Optimize ewah_bitmap.c for efficiency using trailing zeros for set bit iteration
Date: Wed, 13 Mar 2024 23:37:51 +0100
Message-Id: <20240313223751.50816-1-garyan447@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240310162614.62691-1-garyan447@gmail.com>
References: <20240310162614.62691-1-garyan447@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Aryan Gupta <garyan447@gmail.com>
---

Thank you Vicent for the guidance. I am still not sure how 
to do the performance measurement for this improvement. Any 
guidance would be appreciated. 

 ewah/ewah_bitmap.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
index 8785cbc54a..1a75f50682 100644
--- a/ewah/ewah_bitmap.c
+++ b/ewah/ewah_bitmap.c
@@ -257,12 +257,15 @@ void ewah_each_bit(struct ewah_bitmap *self, void (*callback)(size_t, void*), vo
 		for (k = 0; k < rlw_get_literal_words(word); ++k) {
 			int c;
 
-			/* todo: zero count optimization */
-			for (c = 0; c < BITS_IN_EWORD; ++c, ++pos) {
-				if ((self->buffer[pointer] & ((eword_t)1 << c)) != 0)
-					callback(pos, payload);
+			eword_t bitset = self->buffer[pointer]; 
+			while(bitset != 0) {
+				eword_t t = bitset & -bitset; 
+				int r = __builtin_ctzl(bitset); 
+				bitset ^= t; 
+				callback(pos+r, payload);
 			}
-
+			
+			pos += BITS_IN_EWORD;
 			++pointer;
 		}
 	}
-- 
2.25.1

