Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB23B1E231D
	for <git@vger.kernel.org>; Fri, 13 Jun 2025 22:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749852723; cv=none; b=cJfLnRLiA+Gj075iWin2YMBCU7GiTFkrwIPx/dluNUBS+vOUBVaut37YgGKp5O/Bg0OPy1ZEVnFu4ShSbLBNASFLdL+77GbNtqPf6Ci5jPwlndTVYlzhs3H472MtHHcqnCCkdMLgXRu1Cxi6gbnumg5zVc4Qj5IhPp0tobyKKUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749852723; c=relaxed/simple;
	bh=eJaOWejswyLsNWlE9m72Z0mnZibVRZgOrhpOHa229Jg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bIGusAzUjqqOpjNVu7N0ROLUhl54A3/NJk9OsG3WOvzDJq3gSCH0449gFWyZN5nZB8o4b+Xf8fioiQHwLc1koJlCFe7NzyuKV3ElxZR5A6tnc+QDeGB6Zm0pg9mvMFff2MJkUoi2D5ObM00JzgRDs31wx/x9LwHHWVRQxVUFf/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=gaOgn8lA; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="gaOgn8lA"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6facf4d8e9eso28270686d6.1
        for <git@vger.kernel.org>; Fri, 13 Jun 2025 15:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1749852720; x=1750457520; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q7JlrOsFurXXrLJ6S+GbEISBNWKLFmuZ/GSsV16PdVw=;
        b=gaOgn8lA8xhZmu8m3PK3tU8BiajNvQ9Okeq393EZwaLoUwDyAV3jn2lMsaaQU+Yh86
         d3Qnu+UOLDF1k7qfsj9ZYwP/O92oBJI4t6MAw/LW8fR0Gwa3/EqqwaGZLw/dgSqKE2uY
         l3ahlgklkkkwprbTjq/ltTp49QjSm1jfxXLys7IWfRddODYqnOhQHRRSaewKzDjPaHLs
         aAnU0sUn3KiaJCnB/L6ErAbhji99m+wRwjrf6yPQejqGbDZCiSONOvGqTRxkdmU0329t
         M4WuKD3fOL0zxjhOF1NsIokBlR2DujzkpfbstkpazNKz6/4uuFh0xvCcfeVol21ZyM9V
         jCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749852720; x=1750457520;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q7JlrOsFurXXrLJ6S+GbEISBNWKLFmuZ/GSsV16PdVw=;
        b=LnPqm6mra6eJtJGi5L3DRCO3/Aliokxsp0SVekxbHULRh7ssnYUT4+Sb6ht6SP9R5f
         BD254cEwYjh74T+CMJwPeni256RUw7dx4lgb2WpIiJiYeQ7Dz4ze4nJzx5NFvbzJyXKG
         zAe8YQu44azl6TAN6Ndw1pfJwFnq6hNXpMXgOy3qCwIVsaunIxS1VKxzlSSexx7zIwRo
         nHx/yCyDIY74UxB7HTDd9YFavUePPFY6VoCUokGVlkxXo0QxtowyeivKqIadMYoooC7l
         /cRxNUn+ycdsucyPRShm1MGkebIfzkA2nVZxL+QBAcetyG8pER1onFWyqiVkzSzY+JBl
         1AdA==
X-Gm-Message-State: AOJu0Yxh5Wu2xFgGJ6I0774SWQI1cvZj+tKAyoDVq00lsfksJ0S6DPL/
	al+dRjk0qBceo/EktGvsT+ibkyigH2Gp+gP8AwIV27c74rzP0PORiYPz5k+23UAeSjoDOEnEaH6
	fP0bI
X-Gm-Gg: ASbGncvZyY9336Q21ymtPhtLYTTYpD4TociYTxBMnPHdWUe8JNst3odW45zEmMCdSEa
	xSXmhogkTSv4gP1kOjt8l4wO/b9NOHJQttF2ILz9SLOnHqgtzjH8QlGy4vBo8JcoPe8ZSuPHk17
	Jq6o0amYgGYhpbsXe/vCHJZpPdM3/KTi3SCWQT6zrz/XhoMTqEv3t7J8p6KTpYCVOTNrqsXFRV9
	zQ8/HChjtCiLfJ++U+5YPqRYe7VytpOdMOO3iRI9U0rN2E8K3v2aC89HUWQdzOi3UE1NWqWbj8J
	H3dz7Zb0wSNzAbjAomoG0KQ1NLsbovMxXUkY9ZoVAjH1oheFSp/3VnHviTilRgGalks0+SVfydV
	Iled8k+T4qVmQlThw2niIfSvGFEcGM5clJJwREqMhaVNb
X-Google-Smtp-Source: AGHT+IFHGSicbpNiHJDT4kpgjfjOxqhRzyMdFuANS9viQz2j70MKURgP1d72oB3v/ZDrNH9yhA2YZw==
X-Received: by 2002:a05:6214:3186:b0:6e8:f4d3:e8a5 with SMTP id 6a1803df08f44-6fb477431e7mr15676656d6.15.1749852720362;
        Fri, 13 Jun 2025 15:12:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6fb35c31688sm26467096d6.80.2025.06.13.15.12.00
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 15:12:00 -0700 (PDT)
Date: Fri, 13 Jun 2025 18:11:58 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: [ANNOUNCE] Git Merge 2025 Schedule and Contributor's Summit
 Registration
Message-ID: <aEyiLhDjSzQhpJnK@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi everybody,

I'm excited to share that the set of accepted talks for Git Merge 2025
are now available at:

  https://git-merge.com

Thanks to everybody who submitted a proposal. We received a lot of great
submissions, and would have accepted many more if we had the time to fit
them in.

In addition to the speakers, and schedule of talks, registration for the
Contributor's Summit is also live. As before, the main details from the
original announcement[1] are:

   When: September 29th and 30th
  Where: GitHub HQ, 88 Colin P Kelly Jr. St., San Francisco, CA 94107
   What: Main conference on the 29th, breakouts and Contributor's Summit
         on the 30th.

If you have any questions, please feel free to respond here, or
off-list. I'm looking forward to seeing folks either in person in San
Francisco, or virtually soon ;-).

Thanks,
Taylor

[1]: https://lore.kernel.org/git/Z+L3Mt58n18KUNzs@nand.local/
