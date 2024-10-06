Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B96EC5
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 13:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728221763; cv=none; b=Cdv2qg/f3o24thCZHp5NHMm9TG4raO3/NB0yFaTr8wHCgKFfuMJumvSiWtJu41CcgfqZmcn9dD4RrqVvuDw8Df9eQ7/TQaRaX9+GNruACSVpUcxY5BazA72maGIsOYdl9DMR/agVHB2hkE4Ajk5sXDFqvlCOge36IXC+F119j40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728221763; c=relaxed/simple;
	bh=0Y9nXjwMV7aJF7cWBpP7FqlIZ6t/74C1vdgrolyPOBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzaFNjyYFgyv1fsPiD7gEXWElN+J8pfJmOCGC7mDlZItDG9Kvx7F1Tg33I6HKVZRUjcFQBtmWl5vDL3JXAhKwU1zYT3zaERILczhCAnJSyW7vkx/npkBrjR5bPY0nvkrxMmQ9WwbFfghui9MX4HIufdQWXxnZVyXFnaaw9CTaRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4Z6Kh0K; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4Z6Kh0K"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20b84bfbdfcso29883355ad.0
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 06:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728221762; x=1728826562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iGv7SeN8GEf1uZUdzxPx538PeliALmJEkSm5fjx2sNs=;
        b=a4Z6Kh0KAERdjt43eX+gb625gbgaj3RnMRpnNfypzF+imkgrasmBFA210n58BzywbX
         ccPnbFUORQaJ/Q0/rOl5V+bYMjSXaamnViAA839WwVC8R02A+/v1Xdy9hhgRof8se79L
         p5WhYlwW9zL2JcteJE2nvv0D1z3UuBQmmQCfmc60LgitrEC2s4UNcMLbjgGF2HjJIBLD
         RJwIdoXClLwbB/1+e5tHaWAPBihPFi4psvMLCeryiUC7YAAAQ362dcROTTXFFG3SHbjd
         dd4wWRhV5Fs3JtnpicFzsw+OayywC6CN2i1rGu+FSEPn3lBVWF/o6H+fHzavjZaUG3Kp
         Bstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728221762; x=1728826562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGv7SeN8GEf1uZUdzxPx538PeliALmJEkSm5fjx2sNs=;
        b=KqvHBMJPbSRax3Q+pc+QHyuTfuNvPXU0GCtAAy0AzCvRMDjpz0xZduWiFREuViAYCy
         EOwh1fc1Dej5H3uExI4w1JocTGQvIY92AuU9gpxtoagk3Q3W1enwgxW+fX7Kb0Dhcimu
         v1qQ2RQD6BxMxlP7pXKo6R14el93Z4wTPLYVp2lQuSvWiYEjwI9U83ZMTFbgw8rf2kpq
         xQN7SnTVpp0vswYbKtPtZZEHSk9qN34tlAbpY3MgqjUH/1RO1cjjUcGx0Caqi4aA6Mgx
         sk8+x1907UMNeGRyUICuvnudPXYUx9Vp/iReLrDKVJlBtEsNXPQOFz+awVwNlmIahplc
         WS9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVkMgYsUqBgH4xoPSmtalDByhaEJdrj+g0uCjJYbn26br6buXetBtsbDqlY9LDqeVIdUDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz849OxxuS6uCGYITmAP+7bI5gCB9nj6cGCcYds8t9jyKyNMzhq
	Q85iioNbtFcaIEU/G6I8rs6YSP3wK05Dy5/1ERG3FIaYN0USoq1UOlGz9A==
X-Google-Smtp-Source: AGHT+IGVou6wq4LXmI0LzFcCqRWex1QmlZdS2pbmAt6ENIhajnaqYerYd5gr/KmWzXP8PULwa6GqDQ==
X-Received: by 2002:a17:90b:3709:b0:2e0:7b03:1908 with SMTP id 98e67ed59e1d1-2e1b38c7582mr19259617a91.10.1728221761872;
        Sun, 06 Oct 2024 06:36:01 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e83cab42sm5236390a91.2.2024.10.06.06.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 06:36:01 -0700 (PDT)
Date: Sun, 6 Oct 2024 21:36:07 +0800
From: shejialuo <shejialuo@gmail.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v2] [Outreachy][Patch v1] t3404: avoid losing exit status
 to pipes
Message-ID: <ZwKSR48mlSME9J0w@ArchLinux>
References: <pull.1805.git.git.1728192814.gitgitgadget@gmail.com>
 <pull.1805.v2.git.git.1728203495287.gitgitgadget@gmail.com>
 <CAPig+cRePbX6OyE6WhFp1GEZenZyC7HFeA3188F_nErt7Gin6A@mail.gmail.com>
 <ZwJwsuf5ZOKiWbS1@ArchLinux>
 <CAPig+cTVf=W5KXkE2iTxCSPmZjOSbmf90J_JugDuTH_xudcW2g@mail.gmail.com>
 <CAPSxiM-bx7KdhP0OyajfiTczg-WqiJDPso1EAxLzntLqcuOUkA@mail.gmail.com>
 <ZwKKhzbeyQ5e_H9Q@ArchLinux>
 <CAPSxiM_+LCH04ZbTZm8oZWDc=Mz2JNJ_Uw7u+gO4e_ie4yPw5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPSxiM_+LCH04ZbTZm8oZWDc=Mz2JNJ_Uw7u+gO4e_ie4yPw5g@mail.gmail.com>

On Sun, Oct 06, 2024 at 01:27:00PM +0000, Usman Akinyemi wrote:
> Thanks very much Jialuo,
> 
> My understanding of this, kindly tell me if I am wrong.
> 
> 1. Make a new commit for test_line_count on the same branch right ?
> 2. I should remove the "Outreachy][Patch v1]" in the first patch to
> enhance the commit message right?
> 

For 1, it is correct. For 2, if you decide to change the commit message
of the first patch, you should also follow the advice from Eric in [1].

> It probably would have been helpful to reviewers if the patch's
> commit message mentioned that it only converts some of the
> instances, but it's not worth rerolling the patch just for that.

[1] https://lore.kernel.org/git/CAPig+cRePbX6OyE6WhFp1GEZenZyC7HFeA3188F_nErt7Gin6A@mail.gmail.com/
