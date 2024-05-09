Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA1453E32
	for <git@vger.kernel.org>; Thu,  9 May 2024 17:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715276241; cv=none; b=T6DzUwgDFNgq1zT/ssQO2/gltGz6wx/ZizG3eSmZ5la7rhM9/m4stYvlGDyXlQGVnoy4FRVzZwrDoX5kjcV0tfc/7YglfjLq1SI68nS/puBGFyZKxwP4I1jvczWplYdIPt1C4iIM7BYMbTyw6iEk6GCxwrSCJkOIDnm/RmKFYUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715276241; c=relaxed/simple;
	bh=nq+DMrAovIgpqa4P1o9Tl74xsgO18rR3KVS1jjT9Wic=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GFZjfzstGdd5mZM+IrVF5FMngAcCzKGcd6HnAPObRfvHcOXAyIfWthz7PEQZDr6SqcPlqy6vX/bGLqqu5RwyHC7ZYoolG4BCSm8Nggb59yGKSoC1O2LqX1f5bZeOXSGqfEpUcGstmoqiVkDXgjhJa4F8nFXglsvzPRfYTmnZ5QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=VZ3xdxwc; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="VZ3xdxwc"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c996526c69so196149b6e.1
        for <git@vger.kernel.org>; Thu, 09 May 2024 10:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1715276238; x=1715881038; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fagl9oQG+VD1yIxy71ntCPylu0rDPmy1t8QNoVm7B7g=;
        b=VZ3xdxwcvW7pIlS0SCVFiKhsIaw11DQD/Lk5qEHRZ2ELYNnZ5hvGBMXN15w1K8Y8UZ
         vdocLg6cZoC7jA1q3baWuqCWRaYFwoStOnezln4BrQN8LjJ8856GAEDSXbWMSy+TVAw/
         XCJI5IbrQstflP0ZfbCOINc7KfRVi805ydZ0hibdhoeeYhAM6UxQTkKvoVNCSYqDiqEl
         zl4EqUBWX4OQUlNBGqhV8cKvnp8GbLr2XBUueRGpK0VLOgxfURk5OiuvEmMP75i7z1I/
         rwnbXy4hxEC7R9yxWAacwEsuKzffEabQk4/O/9X65jjySOmPnrlEzKVwOhUzW7Yaiinq
         dOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715276238; x=1715881038;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fagl9oQG+VD1yIxy71ntCPylu0rDPmy1t8QNoVm7B7g=;
        b=rIL33hQFdNsrCFPFCYjQPbrja0zuV7PWxVO3++Y9A/gjcbGDLUlqjKaUf0Ac9Ys76N
         EypU4NbMecGHdJ1XtPPZVONYcYZRQYVevCHupoMenuSKPrwjnE9vt8b7R5R5Rf8aHP10
         i45oXdMyo1INaltYUj8eJ4nEqiDtaZK6Ygq8azoTS83gXe8+4hTXDxnUXjPZdf4q2ak3
         GzllhLX7IuwZ4Gy5AwfCOjxAAr1eI/RnLyrjkg/gIBQ0cwkGTqiErGIwk4GuPiocXdkt
         MHEXOdlOE8cBRbKw4R9KJ7fxxcVI9WuWFYlTWak/uSXu05FzROviM8WX6FbyWSm/lZbN
         cpUQ==
X-Gm-Message-State: AOJu0YxGxDQCEImjacdFxoFysiBgsULvt99InVdrboLy3PJ9FtYTqG7P
	E8Y4GcTMqrOh27oNft0ku7fTjgQpPkTEDekbyiutbaAzeydrP8VHThQ5FDU73TNg/Z+zmyLvY0y
	8
X-Google-Smtp-Source: AGHT+IG4kKSLw0gKrvtqEmcwJtJuJ28jdeEabeS1oibPUpXcgiFTFyVvkzE5QsvG5i4mgI5SDFRmvQ==
X-Received: by 2002:aca:2806:0:b0:3c9:66f2:69c0 with SMTP id 5614622812f47-3c9971d9509mr248637b6e.55.1715276238518;
        Thu, 09 May 2024 10:37:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f185486sm9138306d6.40.2024.05.09.10.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 10:37:13 -0700 (PDT)
Date: Thu, 9 May 2024 13:37:12 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Scott Chacon <schacon@gmail.com>
Subject: [ANNOUNCE] Git Merge 2024, September 19-20, 2024, Berlin
Message-ID: <Zj0JyL1b+g1G3zWx@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Git Merge 2024 is happening in-person on September 19th and 20th in
Berlin!

GitButler and GitHub are co-hosting the event, which will take place
over two days in Berlin and allow developers and community members to
get together and talk about the future of Git.

Here are the details for the main conference:

  When: September 19th and 20th
  Where: Location TBD (in Berlin, Germany)
  What: Talks on the 19th, birds of a feather discussions on the 20th.

This email is just to announce the date so people can start planning for
the main conference and BOF discussions.

Registration for the event is still being set up, but it should
hopefully be live in the next short while. I'll reply to this email when
I have some more details.

In the meantime, the CFP site is up and running. If you have any
interest in giving a talk, please consider submitting a proposal here:

  https://bit.ly/git-merge-2024-cfp

If you'd like to come but need financial assistance with travel costs,
please reach out to the Git PLC at <git@sfconservancy.org>. We'll
collect requests and try to make decisions and notify people by
mid-August, which would hopefully still leave time for making travel
arrangements.

Other than that, please be thinking about (and feel free to discuss in
this thread) topics you'd like to discuss, or any general thoughts on
the format, venue setup, etc.

Thanks,
Scott Chacon (GitButler)
Taylor Blau (GitHub)
