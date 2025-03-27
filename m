Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337D41C5F0C
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 11:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743073563; cv=none; b=JhlkeygS3ZASVOGvJWgZXcuRqyu+xGbRXvHAzKyu4ESOeqqiQwx+i1fQ4vRA9LTtZFaKYOMIUQqsschEvPM48hBYCFAzypXg3YVBsIO2DCU90eQYLMbsJa+rjH/dIOFuWPdm9LhSxV0ZfeUdBBUAEhtVsXnrA6uzWwvfospZ7tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743073563; c=relaxed/simple;
	bh=OvKKijfWzBE0MCZ0wCJ+0a5UjytAb+xr5480U1Jo4Z4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kDY9+EA6CZse7VhQkXcNwCji1Dn9z7fjpTQLOy4PgkPuX759S2MH9ni16xaXOm9pW9ZdgefRTLCU4zK7ZPwW/Sp68AQpFK4SHuz/VyhtWgoAL2CcaiUGoazePb01uSDp51Ux0x73k8VFGzPBZAHjsQjnPmLJqrAaRIQq2bWJmvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHml3E+S; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHml3E+S"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3997205e43eso634398f8f.0
        for <git@vger.kernel.org>; Thu, 27 Mar 2025 04:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743073560; x=1743678360; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kU7b5SKJQ5hO9/SwmZW+UXVK3CuCp52iNpMoClwIP7Q=;
        b=QHml3E+S+6ZH7kZzMzGquU41CGxPp9nPtsuha6DXQuXPAgOu3QzeTKA7Nbt9nwboTk
         C5xJgDcRP7oO4rctHEekeWR19KCDLOnVDSPWO/3pCbE1jsf2aIlnjlKwA1NHnW8j5szd
         FzAuTgmqhXQqxRyKl+fS+RRKme64JoeT5lbGX4saR+JsRaudV0swxA04wEPPvQMfyRc6
         DCXo0cy+VuIRUnfroUWwhjZEMde5MVn77FkdzvHN3hXD9w2YO91RUpyRq2zfJ0ewh7yd
         gaz839uFqDDauekFXT+jmRGGb70p7Nx+I+tptxkEhi4wyi2gKyZkvIHcNWcpRQPXFuG+
         MT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743073560; x=1743678360;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kU7b5SKJQ5hO9/SwmZW+UXVK3CuCp52iNpMoClwIP7Q=;
        b=H+NLutnKGbpHu7d7u+N4DONJZe0+GMBZTRJErFeEfGiOesvWig4ZMH9hKUSkSvZdDW
         vMRGoTAzCHz2U9j+9GsxIlWB00gbgN7lItAGwsif67xvd1m6xbF8PlMwD+bRanaukUvZ
         uj5GmkXs9i5YSBZXzzmVDR/C2nIUg2SmWkJPVZ7W54gbEAnjC1U6lOg9U7+ycJSrmilf
         A0wJcx6kuGWKEhmE291fpQO7nfCcQg7SrP8+aQSh+ADRyYYZuZZYh2y2y27ojDT/+cHp
         Xp4amCJFzoEKWehuu98R5pgcof+Ttu6Hgnd5jObHDtGVjJ4uoHgudSg44k6RP3uhwnyg
         EJBw==
X-Gm-Message-State: AOJu0YwYoqS9h0HAeJ5KCYougaNDmU4l3al8q8iloPgXWfcFLxH3Ti9f
	nbMFUWPus4uRVOi5ZojlBqdoyAEPz1WJIZs5kq69p6/wCxcugm95qETHKw==
X-Gm-Gg: ASbGncumF81d/XTnGN2BAe281bV+hJ2rTZWN9hkGbuz//giUQjgCfznE+7WdUA1p3xh
	jB+fUkQtXtYUAKlO1A6fYmbf5Iba5mzRoFPsIUFXDDfhih+I8PlbVodWRQWlvbmHenpAjUBV0FN
	6LbfhAH6spstfV+RzXg7jDtgZAFs9xhgBskj43SVcnPKu61xFobcXW78uts7PT3TJZjLP4/Z5TG
	YAHBv19cjXy14xOOT7EqdfQxWbTna3whHz7GiH7o+CnpxsqhxiZZAHGtvfZdz81Zo1cidXlsSc8
	66hbJrH2BhbXJBLpL/D871SHGhNNCy2aJ41WrdozRf5TnQ==
X-Google-Smtp-Source: AGHT+IFlqjeC5IRiuY8UKJL9kWm8AHlvIkU9E2avIOHvMTBtSGKhwggR6BqiAsElasCgVETITFN86w==
X-Received: by 2002:a05:6000:40e1:b0:391:255a:748b with SMTP id ffacd0b85a97d-39ad1784903mr2769306f8f.39.1743073560062;
        Thu, 27 Mar 2025 04:06:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39acf3a9105sm4311535f8f.101.2025.03.27.04.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 04:05:59 -0700 (PDT)
Message-Id: <ddfb44ed924615bdb61a30ae7627326942575567.1743073557.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1887.v2.git.1743073557.gitgitgadget@gmail.com>
References: <pull.1887.git.1743010011.gitgitgadget@gmail.com>
	<pull.1887.v2.git.1743073557.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Mar 2025 11:05:56 +0000
Subject: [PATCH v2 1/2] diff: check range before dereferencing an array
 element
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
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Before accessing an array element at a given index, we should make sure
that the index is within the desired bounds, not afterwards, otherwise
it may not make sense to even access the array element in the first
place.

Pointed out by CodeQL's `cpp/offset-use-before-range-check` rule.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index c89c15d98e0..18ba3060460 100644
--- a/diff.c
+++ b/diff.c
@@ -892,7 +892,7 @@ static void fill_es_indent_data(struct emitted_diff_symbol *es)
 
 	/* skip any \v \f \r at start of indentation */
 	while (s[off] == '\f' || s[off] == '\v' ||
-	       (s[off] == '\r' && off < len - 1))
+	       (off < len - 1 && s[off] == '\r'))
 		off++;
 
 	/* calculate the visual width of indentation */
-- 
gitgitgadget

