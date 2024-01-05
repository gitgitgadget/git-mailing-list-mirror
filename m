Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D7035EF1
	for <git@vger.kernel.org>; Fri,  5 Jan 2024 19:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="IGnMB1c2"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4297ce134b0so2264201cf.1
        for <git@vger.kernel.org>; Fri, 05 Jan 2024 11:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704481884; x=1705086684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpSCKa/PxImlBd0jhgSCs1MO0kF1p9DTBv8IwYwmlYU=;
        b=IGnMB1c2r8xme7AmQRvDYwotQnijRococUMLZUhNQ3hBieXQX5MfsCg6T0RuQhjIjg
         HVML9/BwEGgnRC9FgsB/ScHXfzyip47yTQzrCiAqyw7iRadblFgysugXFY5lsGqaJSxD
         YEt0UBeUOvzHQH+PMD2FpPnegcfRxBi0VqLv3TT7tTOFLwh3E/gn/RbP5RO1gWrcOAPH
         L4MYg026Suti/UN7SaqToh8kZyOD6Q7dXCAOBV1oDBcg+ZfnRl/LmHUbQ9mRcI64dLv+
         j0EjqsXIu1nFKNWzgKbPatPVBcVGdXoqpC3ziuANwZUIPZDdpjyE+KVKgt7dh3gqOL0u
         N7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704481884; x=1705086684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZpSCKa/PxImlBd0jhgSCs1MO0kF1p9DTBv8IwYwmlYU=;
        b=ghutFVQHrWk/eA1j8HT5MxywC1d/QMaLJh4sZLVbGrd2BO3uX2CUytTkUuhfaXbg0e
         ep7hbUsobFWTvJB9vq1V+ad44bst7x7+0uicz/8ysUm0EPcFD4L7YCjTqRrUH3GJIZOl
         /zHM/bGVFGVPUDZ4XHyXvuW2Wx2eTXELzp3th8IooOYBzo9JmbSIOGd2fr0JPD5uAcYd
         aPEFoSymaz4aQppq7JRME0X+JZTpkdBqpNlKsqeNUcSjst+o5WQO7Bbropgkmuz35oU1
         mXQTDGVD80wrXmuIkwdcI3G9zCq/ghV01kOktvSi/B3z75LlqlHPzAX+HPTQSCx0jlpN
         rftA==
X-Gm-Message-State: AOJu0YwtPzuWkzi53EqBs4wVyhTl4bETWjQf81j7wCY/xkT2HJ9c5VdG
	z8p3QniWAazwPI+OOr5YoyjPHrGYN5cukvJDXfQZyQHyTDAZvg==
X-Google-Smtp-Source: AGHT+IELSDTpxicNqkVkdDOeGcxXeHDKV9uJZuJpwD3gz3BEe006uQYc+d7rQXKVXSRrNCDpBrEVLA==
X-Received: by 2002:a05:6214:5007:b0:680:c731:a35f with SMTP id jo7-20020a056214500700b00680c731a35fmr2939584qvb.13.1704481884396;
        Fri, 05 Jan 2024 11:11:24 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id dm4-20020ad44e24000000b00680613267d5sm825611qvb.115.2024.01.05.11.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 11:11:23 -0800 (PST)
Date: Fri, 5 Jan 2024 14:11:22 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] commit-graph: fix memory leak when not writing graph
Message-ID: <ZZhUWu5pgBEYK409@nand.local>
References: <0feab5e7d5bc6275e2c7671cd8f6786ea86fd610.1702891190.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0feab5e7d5bc6275e2c7671cd8f6786ea86fd610.1702891190.git.ps@pks.im>

On Mon, Dec 18, 2023 at 11:02:28AM +0100, Patrick Steinhardt wrote:
> When `write_commit_graph()` bails out writing a split commit-graph early
> then it may happen that we have already gathered the set of existing
> commit-graph file names without yet determining the new merged set of
> files. This can result in a memory leak though because we only clear the
> preimage of files when we have collected the postimage.
>
> Fix this issue by dropping the condition altogether so that we always
> try to free both preimage and postimage filenames. As the context
> structure is zero-initialized this simplification is safe to do.

Looks obviously good to me, thanks for finding and fixing.

Thanks,
Taylor
