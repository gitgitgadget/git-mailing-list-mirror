Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E8C1A4F12
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730472045; cv=none; b=hxrNAJX1caA/StTGovvVsHQfQ1iELZ7BBA/FFxJnbrmCD8weAoSrzASYJHF4Ihzr2SzaNsv6qwfMFyXQ2YWUczV0N9EVCM+HgYBuoiPD6zcu8de5JEHNDSOfEwBGm8OgufG0g0Ec4iYQh90g5YkTNhgnrK9JQ2KY+b9xogIPEow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730472045; c=relaxed/simple;
	bh=q7K/T1oujU7xNDeU1VWk6ZvHNEy/pvIzWhzUwndwS8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=saMwf2Mu8kwLmgTGvr90szHgHU/ANFufLgq6MmurEX23u7EjzEnkVMU2+V6fIaMO8CHWI20dI+1WxW3WmGt6mDNjkmPMgAALRoGvOZLHo5Dy4EO2TVGImp8+g6xaH87iTeVr+wxfb/KgnN/zeYnKqewxPdnBayBSRkpIqNHkigU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=o23dqQ3y; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="o23dqQ3y"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b15467f383so145419385a.3
        for <git@vger.kernel.org>; Fri, 01 Nov 2024 07:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730472043; x=1731076843; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ro4I/tttpfF/8eO8SOP4phaXHGVvPpcj/IP1G2EAXLk=;
        b=o23dqQ3yfppCDBUluCNLQkomtMvtIXqDYOE0sjEjwU/YVfwK9Z1r7UzHYfToqeGzVa
         n+we8UHuIUPUU1spSQJEdcO89iih+4rVN2sWksrdv3xJNkHD7P+N1E+n4kIiEYxRgRuq
         NePpekmtFYL69jRiAIVb0dMqCKSSn18PPdypB+cwQSwlq84wBDr0HWwx/h8kA3V9mDay
         gpe2qRE+ye1DI/I/vKpQgqHxvawwGAvaEkirwYwtz6MjaqB3OnkHs7XQR/SQYk1QBcL1
         h2qsxIQy9FOwRPYQwwL9A+KJOw6/iQaORfDfdrl26zMLA6ZB8KOolX3MmE7j6gc3368R
         c4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730472043; x=1731076843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ro4I/tttpfF/8eO8SOP4phaXHGVvPpcj/IP1G2EAXLk=;
        b=bxtrTup6LYt4+dQ5fWK3xW80L0vBZ59aOx9vNh5mfSarZQNuflEqASeC44s01tZ2Ls
         Mhr3WaCVuOMtnOpxBz7B235kQi/AB/XrpcG+Tr7Tvsx/55e7owriq9bbebuNbPZQwJNA
         MZvl2pknX18oqXpk2etfA82OZEoO3EBJMKlEh4f+65o2cJnIfZ0wgzICTINatE7EVM56
         t8lbC7NgD2R2UxHc486cGXBjhiJe9yzB5C9yT5yvXVzmq6C4HAooRvT9AuAxttnt97sb
         kcrqZKJR773b9fqCUQLd8WcHIML60CJ801vkNqySzCqEyY1TcPuDYLI3ScDvb81+08qJ
         h2dw==
X-Gm-Message-State: AOJu0YwaUpdZyVp9qA+6ltSRxiZMaILR6dypfoTw4u3F6O+70H8QiiwX
	uXFGQKOUoP9r5EgHTEqDUWtMObCI7mad8sl6gmAu2BxqGmJfx3+zrUsk7TfZ0Hs=
X-Google-Smtp-Source: AGHT+IHXz9HJhEeVYl/KXNmOe6wfsrpI7+Z7C4MOuNnVEPS/6BianO/+2hqE5G58Ei3kDeyIKA2fsg==
X-Received: by 2002:a05:620a:244a:b0:7b1:5504:2772 with SMTP id af79cd13be357-7b2f2551291mr1000404385a.55.1730472042834;
        Fri, 01 Nov 2024 07:40:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f3a6fef2sm176770085a.79.2024.11.01.07.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 07:40:42 -0700 (PDT)
Date: Fri, 1 Nov 2024 10:40:41 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] rev-list: skip bitmap traversal for --left-right
Message-ID: <ZyToaRxR7upLg0IE@nand.local>
References: <20241101121606.GA2327410@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241101121606.GA2327410@coredump.intra.peff.net>

On Fri, Nov 01, 2024 at 08:16:06AM -0400, Jeff King wrote:
>  builtin/rev-list.c      |  7 +++++++
>  t/t5310-pack-bitmaps.sh | 12 ++++++++++++
>  2 files changed, 19 insertions(+)

Nice find, and well explained (not just why it doesn't work today but
could in the future, but why making it work in the future with bitmaps
does not necessarily a clear performance improvement).

Probably you and I should think more about other rev-list options that
*don't* work with --use-bitmap-index. I share your feeling there that
there probably exist such options which silently do nothing (or the
wrong thing) in the presence of '--use-bitmap-index'.

Let's merge this one down.

Thanks,
Taylor
