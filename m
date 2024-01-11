Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0887C58136
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 21:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="rtvCjH8s"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7831362c9bcso438843485a.1
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 13:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1705009549; x=1705614349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dpPki2J22HFUT2fTnUw6QLfIdTYcysMo7Tu+maCfo2k=;
        b=rtvCjH8suntgroDvWre5e4D41KdhTYASzSsU9Uw4630Ltcbq9cHdYaieOj4kpxpUaL
         JwLiBn9tCGofUQZMKMT3Qq4nF0R3Kh+OqpH3khnOZ5kUT1r4VPlfZm5RYPeMTfJVhDfk
         tKMDTifcLsB99HWtn7P6aRWx9jtF7p9ycSTR6DbmNaFXsuUaufdItsGxidSmgC3MJ2Vi
         CuhkE0M4Sg2dILac+TZ2bO44P5nDi3BgdXahHXbOE+x5E4BYi0n5vwbN2pukaMCftwAY
         eAn+qGOGEUdvRw/twWO1sCu0F4KdekgYIoULYFu8Jexml5iaO90e1DWIMSpbBZn5HUef
         Rrhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705009549; x=1705614349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpPki2J22HFUT2fTnUw6QLfIdTYcysMo7Tu+maCfo2k=;
        b=km+tOt5TJvkuNWPSPa0vXRRk0H53ndQigP9mA6klamjQk6sNiORFAtlnJQCqNzyLE2
         ShUApBGjUnXt+eriDwr607CN/kx8y8VSUVq4Hp6dci3ihNWYSXsa089j8EP1UezPbcCf
         3auQyED+a1hirs+UDslxrdSyM6RKJDgJpdGGb4eCZz7HZb8zPEJbqE+Qx3VnHysX9tdO
         AZAosHC9J0l1asvzbN1OirpiTJzYQ7idGQGrBwX5KpXJH+DwBgFE7XsQyLu/cQlkOcja
         Rtd3MieyCc13cP+q7ZVB75JyRyxwpBKoSKMjcu58AfktZoMsFWS5pu1aDQLXZMKVTrfz
         BiEw==
X-Gm-Message-State: AOJu0YyLP7HQA/4omGCE3oo77/DvcG5g5ZJivuroGA0U2T8b4BPYM7UD
	a/CreX1lWvFi+r6furX9x9xL/RGbhv7wPw==
X-Google-Smtp-Source: AGHT+IFPlzI5N+sltxtLLo+FqLNM7s9kHqj91aii/5m1e7QRe180vQmaGH5UInkAnctmX6eoXHATrw==
X-Received: by 2002:a05:620a:bc5:b0:783:2d83:ee1d with SMTP id s5-20020a05620a0bc500b007832d83ee1dmr452283qki.142.1705009548774;
        Thu, 11 Jan 2024 13:45:48 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w26-20020a05620a095a00b007815b84dbb3sm615382qkw.49.2024.01.11.13.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 13:45:48 -0800 (PST)
Date: Thu, 11 Jan 2024 16:45:47 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] diffcore-delta: avoid ignoring final 'line' of file
Message-ID: <ZaBhi+0LUyYcXL2X@nand.local>
References: <pull.1637.git.1705006074626.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1637.git.1705006074626.gitgitgadget@gmail.com>

On Thu, Jan 11, 2024 at 08:47:54PM +0000, Elijah Newren via GitGitGadget wrote:
> ---
>  diffcore-delta.c       |  4 ++++
>  t/t4001-diff-rename.sh | 19 +++++++++++++++++++
>  2 files changed, 23 insertions(+)

Nice find and fix. This patch LGTM.

Thanks,
Taylor
