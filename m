Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE5D191F91
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 06:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758003687; cv=none; b=uSh05H5HIFJ2dZ7maQ7BPtesqnkg1ElqBxXikdjYu2oLIfAoP2Fb1KrtZlPSgR/eLESluuPCcx4c5bAoFQfVuOJ7NEXb17FNelovIoB0eHJL6+zRWfbcxIt29Xxjxx4g/v/rAlwRXsDq3m0V4VQ89qd4lw9z612LZ3Z+l/SzwkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758003687; c=relaxed/simple;
	bh=6d/Y4nBMu+G8sS2r8N6ha6TnrB5fMXbX8MYnR/J01UU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uK0d9IrcyJzP0DUxNephcxyXa2tawbC2t3NtYxkroYk9wabvKUZD7xpLBI4xGa7oDG3ax9lxzFsCArQnJbKL8GOWjr9FOPhJO7PnNWGDvJ+V9jy5F2jGQmrxYY+/fDIafzBveuex31gW7JrOfvOf2yNwirTXc77QD+0nSodJ1vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4a14lNx; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4a14lNx"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3e761e9c2ffso391559f8f.3
        for <git@vger.kernel.org>; Mon, 15 Sep 2025 23:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758003684; x=1758608484; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6d/Y4nBMu+G8sS2r8N6ha6TnrB5fMXbX8MYnR/J01UU=;
        b=Q4a14lNxJMOV/uSJEdjXn+xCqWHK+rc/35opXJHsRpDQ4e3OxqpLkQvMlUE5Kx8/6C
         DLnHMbX5IZLbAWHaTS4qgGCzHq+P/QIEsdb4fdoRHA7jx7Yo0bwCMoNHuptE4WuPkbTa
         fJPqmGlXVa1T2bcBYmLEzu8DVErTmogM6Uyl/uCTjaVIO7oFD9ZGxel3nKq7EVLMtIy+
         rU6kvWzH0yg0o9ebKYyon7hjkKzOysR0Qg6SKepjX6HnKeY5E8CLnah+oB6GDi3MGQLT
         1sYGOnd0RRY2/nxCs6klR4zRwMUQCuQrf0wVeiENzV81JTL/xZi6fp9q5PSvnyqFmQ9L
         FHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758003684; x=1758608484;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6d/Y4nBMu+G8sS2r8N6ha6TnrB5fMXbX8MYnR/J01UU=;
        b=H5ho55gtfIYfNob66a/9km7hiw4F9SWBoRrK/D08MtvOXpg7rmNTgcQPzTyMwstk/l
         y6ZYKBMBBDv7+QY1IDhTtIU3X/pWQuF/PkXPELVTTKq+NdXMg1e3EhmUbUu98n5NwHWn
         r3wPTdt2kn7Kz9l+B/ib2xhPycaQv2vBVxCt9kRKRQhKQDMkDO+DRzy7AbXmPJkOpdRt
         uUVr9Tj80Qj+ATkZtWsapJibIZoG9qCI3MnFw89IxC0ad8f0ASEtR3hAYuP93N1ajYYL
         ttpPR9l35cSw4pzCWcBsFpRBOGK0aacvf/25dGi+XWiT7scXYALZvFEQtx//2JGEKbv9
         0BbQ==
X-Gm-Message-State: AOJu0YwKAkSE/yvIEB5Alb0BY+r9fH9DZ+TNQ3QTHKg65Rcf2PARc8be
	ATdLLh2eIKeq4SdrMX9RHSmHCv2wPIKAuCDn1UxakMNUK28sz69oJMyAOwljofuuDGc=
X-Gm-Gg: ASbGnctyvlCbqLGjUEjb5tmTbGvcBnQt+nzt2oSKba2BVOnROOLvZtQQSn8jzSgiJdw
	w5TlAOMZJJ73OQvKzPsSOwCcs9yQpQAzJsefMJznnETKAC+69xNufDWLgbPyo7SD8QJ4U8DYqsL
	7Dj/JsInrD4sFxycSKx0+eM5DVGj+5FO3caIL4UydQVnrj+Tb0D2Cn0kRGI3hpW5aj+LhdBsaIQ
	3xpRCYGHBqSchnnMBwM6SVmXpSNsDc7lQC9q8R5W63qhQniLCJe8wOkjiXZ91/13SQaxSsgW+Ux
	yMYnXv3E1yfrt8YAHfOo05ImYDXf3fTsb0/+OWsw3nfCV6/BoxZHy0CammWAMj8b18hEC6vZOho
	2zsaEvEBujHFgr1ol1x+x8fh+m91JxP2OobQPAQHwyIzoRVIl
X-Google-Smtp-Source: AGHT+IHn8VZxheIVBUJ9fKskmpXvBumzpE2qHLcxZgbuCmL0dMgtMmTvyKcwHhgeZ5IdO4DDUnzf+A==
X-Received: by 2002:a05:6000:1a8c:b0:3ea:1876:b3ae with SMTP id ffacd0b85a97d-3ea1876b5c4mr3222340f8f.5.1758003684064;
        Mon, 15 Sep 2025 23:21:24 -0700 (PDT)
Received: from desktop (s176125235115.blix.com. [176.125.235.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f32083729sm11361305e9.0.2025.09.15.23.21.23
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 23:21:23 -0700 (PDT)
Date: Tue, 16 Sep 2025 07:21:21 +0100
From: Matthew Hughes <matthewhughes934@gmail.com>
To: git@vger.kernel.org
Subject: [QUESTION] how to find options set by scalar?
Message-ID: <vppjutjcdglp44qvsk4qozphycyg663yrq5775zztim2oe7ty5@uttjrshb52bd>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I'm wondering about making the config options set by `scalar register` a bit
more discoverable.

Background: I was recently working in a large repo that recommended I run
`scalar register` to help make git run a bit more smoothly, and I did (and
didn't think much of it and forgot about it). It was a couple of weeks later I
was again working in this repo and wanted to update my config, but was a bit
confused when I saw a bunch of things set that I didn't remember setting, e.g.
'status.aheadBehind false'. It took me remembering that I had run `scalar
register` and some poking around the code to discover where these options had
come from.

I'm not sure if this is something best addressed by documentation, or maybe by
`scalar register` adding comments to the config lines it changes?

Thanks,
Matt
