Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B18215F49
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 15:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743434296; cv=none; b=kJs31oMDdCLIwZLlM7juDNjXaeFliTyQAGxsSprSglhaP/1sUN8ITyXV0rSI91J65PTCZk2j484vGa2HJRmTVJ3p+HBi7INXt+T1MhiY1xDO89hKA+IWGAoAZw+p0DHsTA+lmVP2S0QH0EvZssldPSt0eYxFTyTs9hE9ujUBJ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743434296; c=relaxed/simple;
	bh=moC8ivHh/aEh3cgvHrEPVWNc6H1ky5e5E6gjtrQ1F84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i3Ah9M9OWIZpH2hs6bn2bMOHZU6Tt7PhqlC3kcz/rLUvszY/Sp/yk1CF1cOJlvMgymXklYYNq7FZ2VXK6fg5NxAymLWxfbTK/YSiLDpXTFDWWRkvxlQvNu1gvvPLpiPZ7dnbU7BEM1cXJlPgTtoEl/Qs28MjVbuNvLBAPuU0VnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7D7KrPW; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7D7KrPW"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-301c4850194so6247885a91.2
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 08:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743434293; x=1744039093; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=moC8ivHh/aEh3cgvHrEPVWNc6H1ky5e5E6gjtrQ1F84=;
        b=M7D7KrPWtJGwPthd51dN8V4iudeXfq1/Lg8qa/WSvf5qzXG6DHuykoVzxWegcM/jjh
         RFwe5q20hQixwXjZD/pCGMMzoYROFVuHk2HzIsiOwE6LxEtBYwmLc8z1b8eUsV4MTJ3r
         0RyQB0dHAInjNJUR86bQkYpEKfH5St9qx6mWAz29FYSsAokLIGiDhUY5WQz2yNxWc82L
         R8/B2tjFgtCPaTmfj8foVLtiTFVC7u74JImPftFNbeNx+Eyf7Fs8dfOb3gH8huTBd5f2
         eOx00407g5v/NFAlmmLn3v1eTcYHLzIIxOdLMJhKv3NanFKJe1FxTP/SMPxHhaU4MhU+
         EWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743434293; x=1744039093;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=moC8ivHh/aEh3cgvHrEPVWNc6H1ky5e5E6gjtrQ1F84=;
        b=EtB4MJPNvCM9VB5MCas38ApsuJBz79x4Qf69+CZO2tPibC5K2HR6cZIxUOuAlEZMNJ
         /y+MemTEOsaI1ELwdUAEOexkMagJ7nJ2axIWzNArq0ydCDgrtxcll89VkLLcodchr3bn
         YngtTryzxEfvbyEcvWm3YSheQr7yFrW15BaPoDnM4aJUaQm2p5d7OmqxCQXhnG1cMkMy
         XM4vIz2OL1glMUGY10zjxy/IbsrPlM6v9IN28lUbFiQl8L7neCLrO+s8KbRfoxqwQ/xP
         VMi5GzotXUUnqsUC6AQdDMGk4FHQvMKDwCY40Ena1kAFEb3ZVDM+T/aoVsF5qCq7YYYX
         MShg==
X-Gm-Message-State: AOJu0Yz1tgGk6RhkXAuzDF37NApBS2WwJIBS3tBDjRIPYh3A6NePmtRU
	VdMQwQc7+g7L3unrx5sKl5m8o0rfz2uVnLLcDii+HH50TPrxp1W5XsWW+4XougrqxXMdelDdoJX
	rbUfs79pHjuZCFsbgjf9gRGfBMHI=
X-Gm-Gg: ASbGncvX8qOLg/+jOJWpVhh7VY0bMGMayHCGTr/aYTjrs4qmlyq4psecQfygguCeC+J
	cHExrVwYxXFVNbm4Ue0cT0BQf3IVKaYJ9dTGnPj+3oKOKZX+6zjj/CmHTFljBg5zuxGp9owLri+
	tgf6nqGGR0ekRyote+UvSgOhfZK3U=
X-Google-Smtp-Source: AGHT+IHVg9BKnPXBHERZ1dEOt/zy8Rk1fC7GbaahF/8Cw56aSw4numUvoPk2xyEdkKkSHsibzt+1R/ieRuM3ow/qxDs=
X-Received: by 2002:a17:90a:c2cb:b0:2ff:6fc3:79c4 with SMTP id
 98e67ed59e1d1-3053215d1aemr14336437a91.27.1743434293288; Mon, 31 Mar 2025
 08:18:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326052602.265989-1-ayu.chandekar@gmail.com>
 <Z-ae2l6fkurPNuPe@ArchLinux> <CAE7as+b8qZFEcaH9eJcQnuhZOSW+hfAMiPUBXNPj9x1L7rcXVg@mail.gmail.com>
 <Z-qkFmc9xJXXTzut@ArchLinux> <CAE7as+ZF6ARDQjGTyhjP7JZqhpbvZeouKGZA+tdZur_-8a5EXw@mail.gmail.com>
In-Reply-To: <CAE7as+ZF6ARDQjGTyhjP7JZqhpbvZeouKGZA+tdZur_-8a5EXw@mail.gmail.com>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Mon, 31 Mar 2025 20:48:01 +0530
X-Gm-Features: AQ5f1JrB-xuzsgHpLWOwpAeWxeiSkInMOkuNxpiofXSq1ka2mYAM5yoE3bOvxM0
Message-ID: <CAE7as+ZiXQiTg-YSPxmXWB3X+=WSXPpK8fiSrqQhNCpWQpHTAA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BGSOC=5D_=5BPROPOSAL_V1=5D=3A_Refactoring_in_order_to_re?=
	=?UTF-8?Q?duce_Git=E2=80=99s_global_state?=
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, karthik.188@gmail.com, 
	christian.couder@gmail.com, shyamthakkar001@gmail.com
Content-Type: text/plain; charset="UTF-8"

Please excuse the top posting in my previous mail.
