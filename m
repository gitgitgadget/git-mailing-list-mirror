Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8000013DB83
	for <git@vger.kernel.org>; Wed, 22 May 2024 13:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716385492; cv=none; b=D/ccfSoQH9stX00xXodzVUaJhLtGWU1UG/80uTVbhgLFrjbjjgRM+tvSkMDFCOX3UbzRMgyJTRTpyi2rAli1z+1qIjYt2WdBsJOn7Pe75hhy8lkUYTQEV6gBCraCPfEnu6UFnZLQ/OnBNDYpPHyxWTquIi6iOgnByNRWSfMFjYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716385492; c=relaxed/simple;
	bh=I4P67EJkM34v8msodnyqzgf9lM6R8114rgpJWXN+JQI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QLkEFDItsZAVBj2GUdYihTL/xhS3zi/zAUMmnFAWNzL8hQEmlwE3+eHMuR7wGnFm8maXss+93enqddMaVtc+VVAkTjlutGHxvrpjhxzLEaizev7W1+w60fhf4D/puFOAR5b+usyLs7JuJpkbrcOqZIqOscXg7apS0WQXLt5U44E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=LtjDASVK; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="LtjDASVK"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-df481bf6680so742236276.3
        for <git@vger.kernel.org>; Wed, 22 May 2024 06:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716385489; x=1716990289; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PLxJ1p+fTZl5PWIWLgCavs/y02NkmGtq9n/cGPbWdRA=;
        b=LtjDASVKHjIIJR1jMtPGwTByxmU0EPFgmRaK3PjFz12CfDuR1tQ8vNuCS0E9y6UVOD
         kJxFlwfq5qgtJGFJMGY6gIAIkT7eB2Di3IuW0DNNqv7xLlwSVlE1twcVrmMIaZmzIK4p
         IM8la7nQdBvGKroCwLDB1c92bRzEDYRy67phKJ+XHMU3DcukvfunsOdjTF0yBWGWPGlY
         7s2pS3mqAT6eXMiPHFYYemcagTEEvRu7MrxM4gKkRc/9L1efVHdiMiIxss5kJp8MtgT8
         IAi6KBhNXJTtKYfftd/Dolkf0BLayB/YNfBk3xdluPm1vE5yBoDLC2Ng5Y7D3lyI/zwm
         WyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716385489; x=1716990289;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PLxJ1p+fTZl5PWIWLgCavs/y02NkmGtq9n/cGPbWdRA=;
        b=Pks2U7faMxgO1incoZQZzKbw71BDHpUsMpfGM4eZ+QdFvfVY/hqjLHEgjS1CTk5lzZ
         yimPNRYIakKz6EEEr/rPHv35j6WOo+7KfKIkXRPuOnhtJZ9C18PhuB5ieQbRYXsyojHe
         6IsnZjnp5Gl/onlgxHAE4dc5TzOKXTZfBm3h4FT7TyvyHB0WvkGXZjunyVjZN8qc6HHw
         CjxPASpB7+xfNoVoQhhh+JQTgOOEFpg+lwoUWMHtIYpVW0xjwFoeyRCbY/8XUYCU5lHS
         uQBIWkOhlbNng4VmxJqTmis4xNBbuYAE+1gp35yhYPwFofFqPHrndFSDhXYigQF+wTm8
         ZaXA==
X-Gm-Message-State: AOJu0YxagvA7oE0+N+DSkJEXh5yRb+k39lWZIJq4GAPJaKQERt7Q6NAk
	XaN1Bv48QzjFVIephyg31PjRSfFv+b/HSJFrFzg73YipRbTKzdJdGSjc6C2Buz/AV/ew+jXJx1Z
	E
X-Google-Smtp-Source: AGHT+IHcJjj4Ais5y3pk6wHJR2eVYoEWXzOd4XtJ4ckq1Tr7UQxRv3daD9MRdoh9i+QYOw4iIlK1Yg==
X-Received: by 2002:a25:d611:0:b0:df4:e882:2808 with SMTP id 3f1490d57ef6-df4e8822ef3mr956909276.56.1716385488822;
        Wed, 22 May 2024 06:44:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7947a472d8dsm412854485a.80.2024.05.22.06.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 06:44:48 -0700 (PDT)
Date: Wed, 22 May 2024 09:44:46 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: John Cai <johncai86@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Documentation/fsck-msgids.txt: remove duplicate
 'gitmodulesLarge'
Message-ID: <ad1342d101112f52f45c2dfef4c369f7676aa9c6.1716385486.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Commit f6534dbda47 (fsck: document msg-id, 2022-10-25) introduced the
various fsck errors/warnings/etc into documentation, but included a
duplicate entry for `gitmodulesLarge`.

Drop the latter one, ensuring that the `gitmodules`-related fsck msg-ids
stay in alphabetical order.

After applying this commit, the following shows that we have no more
duplicate entries:

    perl -ne '
      if (/^`([a-zA-Z]+)/) { $ids{$1}++ }
      END { print "$_\n" for grep { $ids{$_} > 1 } keys %ids }' \
      Documentation/fsck-msgids.txt

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/fsck-msgids.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index 5edc06c658..68b8bb492b 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -79,9 +79,6 @@
 `gitmodulesParse`::
 	(INFO) Could not parse `.gitmodules` blob.
 
-`gitmodulesLarge`;
-	(ERROR) `.gitmodules` blob is too large to parse.
-
 `gitmodulesPath`::
 	(ERROR) `.gitmodules` path is invalid.
 
-- 
2.45.1.216.g4365c6fcf96
