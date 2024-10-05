Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8D92F2A
	for <git@vger.kernel.org>; Sat,  5 Oct 2024 07:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728112411; cv=none; b=SwTmCmeXUMz9kWFes7i4tm5GUisoxagVxgDJ/5vBvuH/46pzZaB6LXWZz/c6D4jqTYm7YJHaxvtV0pRzWRrx2GrXibXj+xkqffF/hw8IYI3Hj8dgbWpG5yGET8+fE1zx7yhDmewLDwqdYl9iZqGXze+kRQks5VZf/0w/nv5EPtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728112411; c=relaxed/simple;
	bh=dWyHg+lJLzPO1OV3zNEjZiESIA+4+Gw0BasOj6imP20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGm5XnGC5CDJnvApPDw/1RK/tMLSMnyB5jcCZyejiNSzwydHhfCPyAsQdB5Wafz1Uq4gEKEDp8DhWZNKPPzyZ/J1LPdaLXsTgiJyqwn6PIse1XOKR1TyNDL1njvwitTS3oiX6sMwp/+7mkUNgSAYWNW/gCIxjPhJghghyLav5do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QK51TLfN; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QK51TLfN"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20b4a0940e3so26853115ad.0
        for <git@vger.kernel.org>; Sat, 05 Oct 2024 00:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728112409; x=1728717209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YU6hgg3QdSEcIq5fTZCYZVbvZT/pbGJLFHE71HZttfE=;
        b=QK51TLfNdC8EZxzrSubS1yFBO9wJHAtpYddCuTkx1l80jbGQiJLx3JLzT4tGpRY/il
         yUoFLqfBMaBvryDexJi0CIqHj3NmFmCZr1lVw1WXWJPSSYZd8o3JUceI+312iGlrCGBP
         penCB5qNezX1rrwjv2S26T5koyaT+dFi1s6iVOcotP2izpcmKe/gAw4QGFi+pcIf1po8
         jxA8LvwZ8E50Kl8wbDK08h7alwdakcN1dv3UANm3uqs1MYdxzOKSIUd/RNkXby/iwktk
         RX3HnDrZ15TFUfhkObr+2fQZDQY9U8fC5WM79XwxsDhrCjmR9VF6sxtkrUqN0p3CBFug
         WnoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728112409; x=1728717209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YU6hgg3QdSEcIq5fTZCYZVbvZT/pbGJLFHE71HZttfE=;
        b=UM4ZkQNH3+azInqyaNGd1L8vrKbb82cZWAVFBU4+DBrrc9pmsXo16f3dJZTCTRg+a0
         FB0RD2B4EpfhlsJXrm90lYV/bW/GZtsHOE9A6uy3/ZeyCFO5ZOHFMr+i6cj5RjeNeqxF
         pjqOlZP2S/MwzeykejKs5aS6PPAkMZkkC6VOLW5rbjC7RdztzC0fvIJ2qQcZ0qh9p39T
         i7VzfnOgfxc9hbvHVmiVxXrv+fEg/9Ai4rPcZQnnxDxFWlQTo1Kr2fhbakH962ZWqyBM
         v7tWGoq8AhJSUM0asayZm9MG8QWNZ4uc4V1r/79cwxPg/SsIYklhM8TiluqTpNzBrc+K
         j7jg==
X-Gm-Message-State: AOJu0Yy8tbMxB0bZxx17/6xReLySmrHKTcR2rqOFIU7qJpvRTYIvY4Fa
	F9vS/XRpGcdNUvYZ8upIDe2ZPL5zvQWcag7oj3YeD21Yyxd0V+u0/Th6oQ==
X-Google-Smtp-Source: AGHT+IGReaEves+llZ2n3yWZMpDxIuvMiFmLEsLMVUIxIbIgWDIiZrI+E6AUhvWMPt9uud9ZJnEKVg==
X-Received: by 2002:a17:903:230a:b0:20b:9822:66fa with SMTP id d9443c01a7336-20bfdfb4a9amr70121155ad.16.1728112409472;
        Sat, 05 Oct 2024 00:13:29 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138affb3sm8312405ad.32.2024.10.05.00.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 00:13:28 -0700 (PDT)
Date: Sat, 5 Oct 2024 15:13:34 +0800
From: shejialuo <shejialuo@gmail.com>
To: John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v3 3/3] archive: remove the_repository global variable
Message-ID: <ZwDnHs92pEs0UJbN@ArchLinux>
References: <pull.1788.v2.git.git.1727718030.gitgitgadget@gmail.com>
 <pull.1788.v3.git.git.1728099043.gitgitgadget@gmail.com>
 <5d33a375f41132b8b378885d00e934b9f20a0854.1728099043.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d33a375f41132b8b378885d00e934b9f20a0854.1728099043.git.gitgitgadget@gmail.com>

On Sat, Oct 05, 2024 at 03:30:43AM +0000, John Cai via GitGitGadget wrote:
> diff --git a/builtin/archive.c b/builtin/archive.c
> index dc926d1a3df..13ea7308c8b 100644
> --- a/builtin/archive.c
> +++ b/builtin/archive.c

[snip]

>  
> -	ret = write_archive(argc, argv, prefix, the_repository, output, 0);
> +	ret = write_archive(argc, argv, prefix, repo, output, 0);
>  

When I read this new series, I feel quite strange for why we only change
"the_repository" to "repo". After reading the comments from [PATCH v2 4/4],
I have understood the context.

I think we should improve the commit message to take about we decide to
remove the "the_repository" from "archive.c" code unless it will bring a
lot of confusion for the reader.

Thanks,
Jialuo
