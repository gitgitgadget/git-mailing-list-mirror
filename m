Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5E83803CC
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 19:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769109767; cv=none; b=Zfdt26llIHIoFsisOPi9m8CAPnmdZB9bGsRAylrys1MYsPnGQHXBibQcQItRs74i4xXeDG7inoA/G/FUepuhzTXF/CkvYjC76focUvxM5KD0wdGD8YwXP9BjmDcelSiLl9FOpYqp2BIy71s1ZGn0zd9k4K5e46Sy21v5oCTvS6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769109767; c=relaxed/simple;
	bh=c9Gr9xejOZmGDzjXUPN8SxKw1KJIhMv5sWpEtuRSCmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rz7n8y05YMguHYZxJ6kmd655klj46cH64Jc3t5ihZ8s+P6gGEY0U8bap0109BFt6pIhFLswFoP6w9lAv7oHlUEcqT3blKdK3R8IQwq8DbyY2TyrPITJf9zkISdI4gD4/lb3UILiG0wXciaKUWKOFu1Jtq4lflkNV72o0IIDP604=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=leyuMCu9; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leyuMCu9"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59ddb31ddcaso1386647e87.2
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 11:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769109760; x=1769714560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFn8iHEd10kf1rN0SExcFFxi5IWpaijS8P88/r4+Svw=;
        b=leyuMCu9kht2V5l66H+PTySHzSVNT/yc8GhHyyZsoB3zt4Le+J0OPU2HQchUDJ6I61
         WEizVRaf3wWjfBUJCplh8oLhYyAoxusQZQbm+ZrYz5Ok3cyXHzUm5QM8fDSyaRzMiWIq
         T8ertopyqJrcjRAdFYOmP260wE97JjqWCwn0Lld9H5UZ66HUZ3nZMSc8dEJ7KQ4lm/48
         dDU2EK4vPFGvO/9vfBtwqMHAjaLOTEbbQGkvl5OhLaT9hzHeRk3OCnkY9THwKQrvgFgl
         B4s1ze1pYq4pa37Gg1dQXrVaPXxal3BKif8PGIQrk4ODcQICSVa5JFDCa9tJPgXzExKQ
         3ALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769109760; x=1769714560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aFn8iHEd10kf1rN0SExcFFxi5IWpaijS8P88/r4+Svw=;
        b=wz+zWbnyvRd2JRGNkiw3AU3bmsEoX98mOZNisIPuM2gqhPGsgDsVlxME+MD3m6T9YP
         8vxy+9+cc0f7CrC+xffHUCIS4SgUCJnPOes8lYVWRIUHJpfi4+ROM77mXgImIZa4m1Hx
         yiKH6oD6caqckunKJ/Lf3GsU98NciZsBFdpwePjGgdzJtG9mKZ1fw7sxZZIwBarabzhm
         hWpPkOXTFfCJj8nDDswDyR6rp5N9hQoTOHPry7d6IXk1zmeXcxaMot6ADDxNsdhY6hSw
         l7mv5/+gXVp/uWbVFf7zGj0KVEyA3478+G+EfkmDnravbDNMF+QnBvMJ5tGhIXKtH2k7
         5u6g==
X-Gm-Message-State: AOJu0YwERpNfUxJ6oOkA7WJ0POi4cGlBRy465IUyuc7LLVhH7Y5WGlD4
	Rj1NAIN7A7X5mQVS8JTpgq3UdlBvCCzutREGnikXBRbLPAkwXLNqiuCK
X-Gm-Gg: AZuq6aLq3Jp7EAcWRJZo7/1CfW1QqiUu8O99DciWhh/vUvIy1rpF3KrE+s4lZCfLxGN
	Xclc7ib8eRnbrEztD1UiXDEuAefjBYHQeL3XQtv9brV8bhcqpSEDUCTqO48CI4axQdUF6sDNqUM
	oApRRxYydoeoD28pCV2O8URCpTwPTq9L+8tXb3GVjP6vtY7ytMHra1la+ih3QxCl9bsmHKvNsO6
	twILgGh50T67cdkIsRm4AN3pPY4XAmrecxoJQZRS23QOROtL53UW3aejN+tFBr39GiV3m8YxVDK
	s5KqmVwCGrJ6zmE7QDfKGtjNdJldQV429IFtSpTzUPaTkhUJj63OcpCLhKCJpSS4oWGc5y10vGi
	/TmgQ5hsmDt1gWfrP0bJze7mzZX2SIaUjn/TlOMJRE0RCzZNpVIQmZJ0N06g8LqiT6U0HmJK8+z
	NTuiFYD8F6QOYSRrAwOjwbK+6vvr5LMeDTNfQNtT5CoAmzNMSyS3Hv4fiZlUrPmUgmU6+JcPU=
X-Received: by 2002:a05:6512:ad6:b0:59b:b0f9:53ec with SMTP id 2adb3069b0e04-59de49054d5mr151896e87.10.1769109759395;
        Thu, 22 Jan 2026 11:22:39 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59de48df64bsm91476e87.19.2026.01.22.11.22.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 22 Jan 2026 11:22:39 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: peff@peff.net
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Re: [PATCH v27 0/2] status: add status.compareBranches config for multiple branch comparisons
Date: Thu, 22 Jan 2026 20:22:38 +0100
Message-ID: <20260122192238.76368-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122190751.GA2098026@coredump.intra.peff.net>
References: <20260122190751.GA2098026@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Using a string list like this is quadratic. It probably doesn't matter
> too much here since we wouldn't expect the list of configured branches
> to be very long, though. But a strset is probably the better tool, like
> the diff below (note that its "add" can be used as a single operation to
> insert and check).
> 
> I don't know if it's worth re-rolling for this or not. I doubt anybody
> would hit it in practice, but I'd be more concerned about people
> auditing for accidentally-quadratic uses of string_list and stumbling
> upon it.

Sounds like a good change. Very nice to have insert-and-check as a single
operation!

I'll update it after passing CI on GitHub -- I'm running CI from two
separate GitHub pull requests, because one has your memory leak fix on top
to allow the leak tests to not fail. 🤗


Harald
