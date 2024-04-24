Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD18A161924
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 16:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713976030; cv=none; b=pquEoPbfSAiloAXQeEs6h7BxXdWPZdNu/2cZzo8fWHXYLwf1daZpNkO5AXDu3QmS+8Opg98oE50beW4JAi7XezWkBH5ImlrE6xTJY5C4JcBR007+qKUV+7nYCdwA2O/eQ3K+8ZXMO3kfV1Y0z4W7d2GFjbjoQqZsKZkrr1wbE+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713976030; c=relaxed/simple;
	bh=8+aIMtn4AHwK4xxaqtyC5NhIstQOVe4QD4UsKuHrH+g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ci0pfNp5DZzOB55flvQ71dDJp1v+bic3a24RXT1RnkWMNx8F8KkoyU3IBs+H/alvLE4k+9BVcl1pbx9hCtXpbC6Gc7bwNb/+SeoavwhkB29tQUR+JX2BufduPRPydgZh4VluXszf3PzVd9nQd9FmXy6V+7n9UpqmBLmRqnw7btE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=hTVviNSU; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="hTVviNSU"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-78efd1a0022so514954185a.3
        for <git@vger.kernel.org>; Wed, 24 Apr 2024 09:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1713976027; x=1714580827; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZzEpvEL23jTg3q5b6q0grxqvJmJ1OTR8OJAQybDP8io=;
        b=hTVviNSU1k84/OpjZQAwYBX9zoeBbno/pwLKKECTX53ZF/ERiUn0V2i/7brz5+c02j
         lc9RJXsOmf2DZGO9ZFmb7BQrjIk9ao4ljqNRVwyqh18kMTVZXzXLwnaUB4FxHNkbkJLc
         d7MyZ3m06Pmp7IlZqHXTggeG4oa9Px2eGz+2geXHGUhaY37vGQ54XZuk/vEaPCr4UQBw
         DVZIO6MWi4aV8ZsuCjR+fL7y/Sdfd8eZWjP07Cb2K08BadNLe4lOBmewXPPs/vHmuJxk
         +IvBWK38GkyoCrMqFfxfixdXahIWSBtjjlm9Mvwv1qUnqw82c2a5T5XTW9uOoiCUcMi5
         qU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713976027; x=1714580827;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzEpvEL23jTg3q5b6q0grxqvJmJ1OTR8OJAQybDP8io=;
        b=iDu6vkJG4OwTjCbDT4109n/+MFOXuxira9rGIH3nD9NnsgkFnDh5rwGWVv/G+wgCUF
         RM207HqlXdSbsET+d7F66pOQ0N03e6Nbu0iUgyY60ulFKrjUC7eDyCsSMskTI8UjENKb
         yo/UInP3XWK920svufgLJGCADs3QR+Xop+8QhrsdEFVLRDArA6of84x9wcP23E1Wogpb
         SvGdl5tV3Ol0zQJU3EPZSpaK7EVSTXa5URJjCWqK2kLEpQRC6pA1Y1Pj/lka6GdLw36Q
         pVItpUCC3FTxikBSvqj/J9PF7NL6iBSVeb6frDEnuJICwD6dTgR8PLE/ob3/vodIjaes
         /xHg==
X-Gm-Message-State: AOJu0YxGXp6JrfkbrF69dO+I8qICv9QC6IIu79igM4EQ56WCF85wSZGg
	hei8tBJsl7Dy1AG0YKv9x2eV7On1byj4jzfPPvoS75ODw0jQBshNBD1AbqUKmAX3lWqfnqhAWat
	fKpA=
X-Google-Smtp-Source: AGHT+IGw+9DX8J0ma0/sF/+gqsAmQADR2Fx1O6+Nf0kBTZ9Z9uYs7jMKFNj0HSzTIO0l0ZahUVsFjA==
X-Received: by 2002:a05:620a:1b86:b0:790:95ad:a76d with SMTP id dv6-20020a05620a1b8600b0079095ada76dmr1034617qkb.16.1713976027478;
        Wed, 24 Apr 2024 09:27:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y21-20020a05620a44d500b0078ecd71114dsm6241115qkp.69.2024.04.24.09.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 09:27:07 -0700 (PDT)
Date: Wed, 24 Apr 2024 12:27:05 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Documentation/RelNotes/2.45.0.txt: fix typo
Message-ID: <bdc15abf5f25dc317cf2188302879b047707ba23.1713976022.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/RelNotes/2.45.0.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/2.45.0.txt b/Documentation/RelNotes/2.45.0.txt
index 96629b44f9..e46bf6da07 100644
--- a/Documentation/RelNotes/2.45.0.txt
+++ b/Documentation/RelNotes/2.45.0.txt
@@ -251,7 +251,7 @@ Fixes since v2.44
    (merge 5edd126720 jk/reflog-special-cases-fix later to maint).
 
  * An error message from "git upload-pack", which responds to "git
-   fetch" requests, had a trialing NUL in it, which has been
+   fetch" requests, had a trailing NUL in it, which has been
    corrected.
    (merge 3f4c7a0805 sg/upload-pack-error-message-fix later to maint).
 

base-commit: 10f1281498467654abdb13c6c7c7b23af4b97aeb
-- 
2.44.0.704.g10f12814984
