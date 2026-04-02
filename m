Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3A733B949
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775141884; cv=none; b=ndA0XpSHsgksGJN1wBO2fZOc4M5/Obiy6GpKil2HzrYrBHTBvBFG7m83uN8cDftu95Adc7neH+zrkUqqBlwGesUV99WQrHneM+z8EFeu2QtXYW54MGyhgZ9h4v3Bh/Mz7hEZFsvdtmYB1z3JhnotRi+Lo+r8vQiQGQbWZT4UZAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775141884; c=relaxed/simple;
	bh=NALFgJVKiHh1e3k8xp8AlIKlmOEv1YkU0A7VYto541Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ceUwHMXnsNVkFHgTPffV9UQnrik4EQ7jgqfF0aGn6glY3Uz8NO88c73B3ndC8TBzr4SSsx0Qvde9edezPOOOXPOREvdGaL7W39mJD5AmJwna19a8WoHBWQUoa0geupZO3Ur9/sNDi2L5rDQeOfCFgkdc88WgXFuI1/6ct81GVZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGyBuvDh; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGyBuvDh"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4887eca00c4so6542455e9.2
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 07:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775141882; x=1775746682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BPyJbQEc/0JBPZuleLpDAm6YhkSXy/zNss8MqS/HZ8w=;
        b=RGyBuvDh4OFPhiVVKmHLXyXRiSP+l/7fF6ry/MY+7sEd6LTlTZSt2TfNJGNiZeNzbX
         qiq2YWqKh/g4XyJxkAkS1E+y/MrkYqRGs0/ro49cSvKtiVTB0sqh5/1POO8pdzZADQYV
         y/1LhDa3MgdBkgg8Q/FBVbD6o165zLVWuoVAkfrz0FRIorF0QMEUZlwWNaD6euvoMxEr
         ay9eQ4WbOv3cGMhf1fzVgqEuDZtdq7Qf2tGA8B22CziqVd9v4tgsaTHpDEVOdt1S3pNW
         9EdKYlrvJzDJ9V7Un/lG46UYniK9YnbqDWI8CMJRy3CbrUZY+7aC5SE2oHXaXcFwh+zR
         sHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775141882; x=1775746682;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BPyJbQEc/0JBPZuleLpDAm6YhkSXy/zNss8MqS/HZ8w=;
        b=P6nKZ4+KU7mmjkQmHYSEBwjZXZPAu2nnZjV0/GOhHevC5x2YYZEmRXpZ84hysSjZ/F
         hnslukwU6EmTIQFRUnzYC4bJ9ov3pefF1pP+gS6DJxAwV693W0USbS4kQj/90V9B8TVx
         p8BgiaFOpJQh/tM1T8ghHFUmD/BSFVZNJQBgid9XsQGBHNH+iN0wpPpzAIb6XUBlIDFa
         RI3DDgxFaoRAifVFpCWjkJkicw4bl48B/vVAh5UzGNWbl9gJXHrc1JBTzBhPyUe/ss/1
         3bBRDB+UCJzxEW25aSHbhWgM1BxY8QUDVHofjy2+rPyNDwHy5H0L2NEMptMzjtpN5geU
         dl2w==
X-Gm-Message-State: AOJu0YxLuAAyV32FNeAFZeUjqSZz+R+63yURalyftqnBfod1uTbymU6t
	/zUAO0dEXWpPV9NNI9FV8pDbrMLD8uwkVrs3cX0aIewWyN3P4XNpBjVB4uULqA==
X-Gm-Gg: ATEYQzwtjb08CzYYPIBZB74gdqzKxKEGsJ8UJysQkpblP2OIWMiLSqojzbZmQ005w2I
	OmaAnDKJG+sIrGRI8zDkGBiISmZE7GOsR76mFCVrMZz7MG1EdB5eEjDE+mpRZNRmI5UQEAZoCj6
	5lWaUln8GAxBcXiVD5gjtgP1FX7GxXS+Uh/6kLN0iIFLiOtBIQsBsAaxkOG50HfZKF+p9dpYuoP
	oPcAO0P8fpmigSjB49m3rUowcBXx6Q01y4HwttzHbwHLAUTCAvopFYRYtNaLOtbQEwLDFAJ2kwe
	z6EvG8MEkUjn76tIEnppzkTtHvejtaRVAr8QnLcIVY70+ypSTUE55no79IN39gtdIU7/V2FK015
	wXo1PpZixTYHOOs/63Xcor4xVNMTCERoNkggcXE0PfGNjnbfGY4ySLKDVaHyKJGAm3RCvyKJlSC
	R9CYJyVjNDWyTfzLFUHgLi+5KpqA==
X-Received: by 2002:a05:600c:1e02:b0:487:4eb:d125 with SMTP id 5b1f17b1804b1-48883575cc9mr163317785e9.9.1775141881430;
        Thu, 02 Apr 2026 07:58:01 -0700 (PDT)
Received: from berwick ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8b6230sm70913705e9.24.2026.04.02.07.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:58:01 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 2/4] xdiff: cleanup xdl_clean_mmatch()
Date: Thu,  2 Apr 2026 15:57:42 +0100
Message-ID: <78e9313fd44c7cd9f820109edb103a680aa73ad3.1775141855.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9.dirty
In-Reply-To: <cover.1775141855.git.phillip.wood@dunelm.org.uk>
References: <cover.1775141855.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Remove the "s" parameter as, since the last commit, this function
is always called with s == 0. Also change parameter "e" to expect a
length, rather than the index of the last line to simplify the caller.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 xdiff/xprepare.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 4bb3a8ef41c..f8e6a6d74d5 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -197,8 +197,9 @@ void xdl_free_env(xdfenv_t *xe) {
 }
 
 
-static bool xdl_clean_mmatch(uint8_t const *action, ptrdiff_t i, ptrdiff_t s, ptrdiff_t e) {
+static bool xdl_clean_mmatch(uint8_t const *action, ptrdiff_t i, ptrdiff_t len) {
 	ptrdiff_t r, rdis0, rpdis0, rdis1, rpdis1;
+	ptrdiff_t s = 0, e = len - 1;
 
 	/*
 	 * Limits the window that is examined during the similar-lines
@@ -333,7 +334,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	xdf1->nreff = 0;
 	for (i = 0; i < len1; i++) {
 		if (action1[i] == INVESTIGATE) {
-			if (!xdl_clean_mmatch(action1, i, 0, len1 - 1))
+			if (!xdl_clean_mmatch(action1, i, len1))
 				action1[i] = KEEP;
 			else
 				action1[i] = DISCARD;
@@ -351,7 +352,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	xdf2->nreff = 0;
 	for (i = 0; i < len2; i++) {
 		if (action2[i] == INVESTIGATE) {
-			if (!xdl_clean_mmatch(action2, i, 0, len2 - 1))
+			if (!xdl_clean_mmatch(action2, i, len2))
 				action2[i] = KEEP;
 			else
 				action2[i] = DISCARD;
-- 
2.52.0.362.g884e03848a9.dirty

