Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112BD31A05E
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 19:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570713; cv=none; b=Uhiv1w1JUcjCrdSpHgNfWaCzaGl2QxmazMQTsjOp+Q8aLKow8/5dDp6Pe3nBzP6GbrvWsRIQI+jrFQBSTacjDKNjLhQCP1GYD03bXF+t9HlygKjM78MrD1UiZn56n+npzLQWNEDbq+XP85csj4JPwF4nn9cjgFAJMdHhn89yUYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570713; c=relaxed/simple;
	bh=BTBkqOBo46HKLrO1JkXLChyVjl9VuzfjDtDRU8/t574=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FLPb0R/JT7CoQ3nFT/p6LNu51qMlzLKyr9kSOoqiVD0+8yvErG/DprAN+1FbO9W1NoNymQ50ChBBwHpavNgEDvSj1YeDPtzSLwMeZyRlvRBmsIHGJhzklSRp8EzlHAFY2PQGEWgNxUdxvq293SdNS3NDKwjnvVVYQsmx8Byu6l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWkKTh9R; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWkKTh9R"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-4240784860bso19807365ab.1
        for <git@vger.kernel.org>; Mon, 22 Sep 2025 12:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758570711; x=1759175511; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WErw3AydLrOKz0X239j3/jDTD9XruWWs5KcWhttI7Q=;
        b=iWkKTh9RCu+h0b8Zvj4evx4uDEJj9SRTHoTHvqHBl+zcJgLNf5kNkscWQcdBwMsL17
         0mWMVphaJdPRjOTFMjI1lWCLxcugfIilYT6kZ6O0q6FSJqg1sv70Wodv8wlrsw1DMod2
         n8QQshu2CO2CHrEuWTWGiT9Jv8DCXDUl+rYeeao+2BN/T511Gp8iF99U/VkyJfOADkXj
         9xQ64UMTbgYBHBWTNeJo8xOyZQ2VWY8X1diAvZaKPiKIoCtI7OeklzjVkynqvp51IN/J
         X6XhLuX6c6dFbPDpAF6S60BYXz4r6ZIvW7WjEtVcUQTqS/f4pJGxvpqD4WVtcSqoENnc
         HwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758570711; x=1759175511;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5WErw3AydLrOKz0X239j3/jDTD9XruWWs5KcWhttI7Q=;
        b=NcKy3c0Ao7nQIejV32bPo5eUJC1fi1FAgOJrroal41pYJcGTb45nkrV85jJQlj6WY3
         K/R42o8AQLohH49zBM8S+0sGkwv4AHtV+S95iz0DzzAvYgBVlNm3ZAZWcjRuWrp2ls9o
         BUkW35NTs1pJemS0PBuvJjUgjMAUDTVVvIzPGodyRqW/Fo2Ps7YVWwIKWaFYyGMZ+Nyf
         hPWApjStbud+v6zAE/5oolUWgCFRqAMVwLmMFQHuhXAJ58hj0dYf6rC0BZVEu0wBFrfL
         FKM5iFJala8jY3aaOdihgnO3I4MGaxcz3aJTJXoZN+ZmneFjSByfn/Tf0QgzYVjrNHw0
         GvJQ==
X-Gm-Message-State: AOJu0Yx4PKXCr/IfV3G+KjI/RW2uG3kxjdBcxQNFUFMbiu2ZH+3U3zZx
	t/NEUTVwsaJX1JhZmAEzG/jRo3Eup9bkEUhWCZZ6+tkxvKYpgMrNM7upR+BsEg==
X-Gm-Gg: ASbGncvRHVfdNoTwUNG/eMG7HZJfNceiRQpQhnDRAJ0EadvJDFCtWul45ZlDg7aFXkS
	DnWrwqY2e8OQI6PIPci2dFCQU3fb0crbe/Hm1ShhcbrC5EMF1FGdggPzwhDcXdN+qQAlVFkn8lG
	iKuXL9gxroj2JGC1UqMzX/+VKReG9+IewoXzJFQXuqlzlvPR9fGbpS+oPuRzULQhPer4GmU8x9u
	91TNOWxt5/a+838Dq3F6iDiFzkyFemeZi3Se+1hDeI7zv2Aap5405xV5g88FoPoegPs0Y+rF0Z0
	+tmKXF2mFgiLm+D4jw/T7rQs0p5aO+E5xzx9kZRbIFNSzoJfVUFYZosDW4lNDtDWyIrm6kuEEh8
	lr6k/8zs72sPzPfNzRqKsG2XZXw==
X-Google-Smtp-Source: AGHT+IEoSLP1LW2Wkve3RGyWgzDzatdyy0fMSahpV8jZLTXOzvDBavjyz3OAYs1YV+HfxVSbksKtVw==
X-Received: by 2002:a05:6e02:1489:b0:425:51dc:5b7b with SMTP id e9e14a558f8ab-42581e2e258mr2384165ab.13.1758570710600;
        Mon, 22 Sep 2025 12:51:50 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.80.135])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d3e337de1sm6045547173.25.2025.09.22.12.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 12:51:50 -0700 (PDT)
Message-Id: <311279c123da718a1462dc0a8695f0e06e7b0330.1758570701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
References: <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
	<pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 22 Sep 2025 19:51:33 +0000
Subject: [PATCH v4 04/12] xdiff: delete superfluous function xdl_get_rec() in
 xemit
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
Cc: Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Jeff King <peff@peff.net>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

When xrecord_t was a linked list, and recs didn't exist, I assume this
function walked the list until it found the right record. Accessing
a contiguous array is so trival that this function is now superfluous.
Delete it.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xemit.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 1d40c9cb40..40fc8154f3 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -22,23 +22,14 @@
 
 #include "xinclude.h"
 
-static long xdl_get_rec(xdfile_t *xdf, long ri, char const **rec) {
-
-	*rec = xdf->recs[ri]->ptr;
-
-	return xdf->recs[ri]->size;
-}
-
 
 static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *ecb) {
 	long size, psize = strlen(pre);
-	char const *rec;
-
-	size = xdl_get_rec(xdf, ri, &rec);
-	if (xdl_emit_diffrec(rec, size, pre, psize, ecb) < 0) {
+	char const *rec = xdf->recs[ri]->ptr;
 
+	size = xdf->recs[ri]->size;
+	if (xdl_emit_diffrec(rec, size, pre, psize, ecb) < 0)
 		return -1;
-	}
 
 	return 0;
 }
@@ -120,8 +111,8 @@ static long def_ff(const char *rec, long len, char *buf, long sz)
 static long match_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri,
 			   char *buf, long sz)
 {
-	const char *rec;
-	long len = xdl_get_rec(xdf, ri, &rec);
+	const char *rec = xdf->recs[ri]->ptr;
+	long len = xdf->recs[ri]->size;
 	if (!xecfg->find_func)
 		return def_ff(rec, len, buf, sz);
 	return xecfg->find_func(rec, len, buf, sz, xecfg->find_func_priv);
@@ -160,8 +151,8 @@ static long get_func_line(xdfenv_t *xe, xdemitconf_t const *xecfg,
 
 static int is_empty_rec(xdfile_t *xdf, long ri)
 {
-	const char *rec;
-	long len = xdl_get_rec(xdf, ri, &rec);
+	const char *rec = xdf->recs[ri]->ptr;
+	long len = xdf->recs[ri]->size;
 
 	while (len > 0 && XDL_ISSPACE(*rec)) {
 		rec++;
-- 
gitgitgadget

