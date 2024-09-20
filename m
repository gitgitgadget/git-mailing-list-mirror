Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BCD1E87B
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 14:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726841767; cv=none; b=Mv1wOl1EIDKyDzdtfo66pueVaXTG6UnO4CuAE2UzXQEbl37zAbd/fd7tSD63l8uqYzSQN9sfANxiuantYCq+8ymycTREqKp19a3ZYZeHSAS53pcJcDCGrSkUGAH+Kn3ATpw0foyhl0kCVUwPXCxRjWNI8FMiKGBe3Hkk0CFrrSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726841767; c=relaxed/simple;
	bh=AhSAnXRl/ZA0al6k4J++jdg48UpthjlDHJEE17K0CJg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=icSWKtVYaDtR7u31eWWA3jm/N5kj4m6ymiLm112SxlLR3b1/mLgITzUUOgY6rI24Ag5okcgxsmEOE0oFNLKBVWZlGVhO8fJVjEpLzsKL5CJJDuk5/IBjjNd9JXqEnxOHRe1z8tHSWMzHt1x/DYH563CxGOGE45iVtkyp09I446g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=oOTV0Jc3; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="oOTV0Jc3"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-82cdc21b5d8so93321339f.3
        for <git@vger.kernel.org>; Fri, 20 Sep 2024 07:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1726841763; x=1727446563; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6N9I29qZOMeRefGyOmO9PxgqXa3v4J7K+DVVoJpS1h0=;
        b=oOTV0Jc3MXyD79gW3+NZtEyG78W7h87qbfYBF+pFK3+Q9e8fvUy0BTzCqvNJ7HlzEG
         sK502CTKCoNLoEkpY4X+V3kqk2pM9xepIpGYSvEP3PfHuNt+1S2Fe7wplngF7MXDctON
         xDHXBeAHOJF4Jb9FuNte9zrbpROOTswXD/ML3TY7paWcLVKnlTbiRdbBrbz9kuAVHtSy
         UEMGlIMolMSO0ypSjCLSjVEu7HCM0i7SYdx5aDmXoNZS3bsqonoumEAdwMITD3l96Qvq
         luczD6PgnH1nNEcWrH4wTMQHc+q+BTx8jWLEkZme/le2khIZ3Mu6aCH6wpIRIflbRiVU
         l6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726841763; x=1727446563;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6N9I29qZOMeRefGyOmO9PxgqXa3v4J7K+DVVoJpS1h0=;
        b=u9B2xx46sQ3hoF3aEWSdDdDIRIG4/IoJGK9tSqgrJ4v4GbbnUwsXG3deOrGtPWAlpD
         tW+syvLC/acCKE5WpEKd6rO7uZN6GQ+lILfNRjQENHZdoa9i5TvVRwQFiepkTQ82vbGZ
         SL1U10E6TrrBfUN3n7hnbrwlaieTMzHaoenfMiQc22o2ioNSCE8+FOKZiIpBCwF9yE88
         tpDdP3e1hfQu8xBfd/odY2L6WW76WbffDIqcZQcMVtMSE2RReZhqd7iyrqyikMPkJd8y
         dEvitYAySi81BlTO87pQMLlTtP5wRqLOlo6FW3378oSYjbxdylyQC4a4aYUyftey9pUM
         PqCw==
X-Gm-Message-State: AOJu0YwAn3aGNRvFe2FXgunE+suCcVqWdt5yw1+ng83TYkgDXs101DXC
	3dwFtqdHAtPtlNTfNbYLXW/u6B0Zn01vSR86K4srGqnARcRWLSgsHXFpK/zbqPXKR3Wa6F6VCtx
	z858eIw==
X-Google-Smtp-Source: AGHT+IEmy8cJsydBjDc0Pb/E8pNx5uAC5Cevc1LrjNp6SVWq+I3uRrlZJlP+HTnCFTB5ojloervfVw==
X-Received: by 2002:a05:6602:6422:b0:82d:8a8:b97 with SMTP id ca18e2360f4ac-8320b324496mr302107239f.10.1726841762863;
        Fri, 20 Sep 2024 07:16:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ebf4856sm3642656173.28.2024.09.20.07.16.02
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 07:16:02 -0700 (PDT)
Date: Fri, 20 Sep 2024 10:15:53 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: Notes from the Git Contributor's Summit, 2024
Message-ID: <Zu2DmS30E0kKug2a@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

It was great to see folks at the Contributor's Summit today during Git
Merge!

The notes are available (as read-only) in Google Docs, too, for folks
who prefer to view them there are the following link:

    https://docs.google.com/document/d/1IZvW1_pnkrMMWnBmZO2MbT4QCjIPJBWNJg_shYqSnrE/edit

At the Contributor's Summit, we discussed the following topics:

  - Rust (Kyle)
  - Top-level lib/ directory (Patrick)
  - Structured Error Handling (brian)
  - Platform Support Policy (Emily)
  - SHA-256 / Git 3.0 (Patrick)
  - Git / Conservancy Stuff (Taylor)
  - How to attract new contributors? + Community Discord (Jonathan N. /
      Calvin Wan)
  - Modern Build System (Patrick)
  - Bundle-URI on fetch / resumable clone (Toon)
  - Project Tracking (Emily / Patrick)
  - git-scm.com state of the site (Johannes)

I'll send the broken-out notes for each topic in a response to this
message for posterity, and so folks can continue the discussion on the
list.

Like in previous years, if you have any feedback on how the
Contributor's Summit went please feel free to share it with me here, or
off-list.

I hope to see everybody in person next year!

Thanks,
Taylor

