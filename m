Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B06378D9B
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 11:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769771537; cv=none; b=noxygvuGRJzJc5MU5MlO7CuQLj9EXHajDynzUJDzGroREmh4CQ+Hl+FrRo0lO+yvIs55dZ9qX2g+SDBHMk5e2j52rTHzhMVTQPLMHd5k03Nl1gSXfj0qNkUvKCm48QzxBrNwbSZXLRdjqnY+94uDAokd40y28qk2xML9+gU5GtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769771537; c=relaxed/simple;
	bh=TlyE4ebdRVpIcScLaT5q3mCd0hFcEJOkF5Issvn0wfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nv/T/Od/x3+bdzL/2Bu7r2jVhztp1+IJlKsulfUWpcJ+m+pq+dg09+jHxNijbOG7Om768PL/D4nfEWhD/ImjjQktt0jGCGP1UxfXGQ+h+guPCUw3t644ewv/iAEoigNNVyrUMRa0Qc62aPH2wUhdmvleDXLJeFKqbYTMgTK7qxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4ws6Qmm; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4ws6Qmm"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59b6c89d302so2132385e87.1
        for <git@vger.kernel.org>; Fri, 30 Jan 2026 03:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769771534; x=1770376334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1rmWaGvrfhql7wGjpmM1iPOb3HtoQFouTp4oQah6EQ=;
        b=b4ws6QmmTTvfvKS61/4yX5+UIM/PnHGB77eTmiVmMk8tCvf7acFgRNY7fn6Gje78RE
         DyLtG6OmaBAuFcRfcXpcRBAOJPK4GhfToy4a9Q1TeRBWtnU8FF/8RkQwzs7ipki96dhJ
         zVQquzMbRTLV7V+GTzmseq3EPmAFJVnlQklgYNewAHpYBiY7PQBjCDvbibZB1x8x7Yje
         TN5H3eVIi/tpNdqJLh/By6l8IerVkGXhtZfZAcAwVgWcsjpG1PiPvwwSK0xMSpkXOBXQ
         dnryZ9HatEXHrqKjrEyqtD5JxVlFt/tuMhWLJl9iJmxvohRnosSrggYBOYkOUvCOs+DD
         7Xcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769771534; x=1770376334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n1rmWaGvrfhql7wGjpmM1iPOb3HtoQFouTp4oQah6EQ=;
        b=ZYNrOVPwNHoIDlPGoc47R06Xsz3NbU3CBsvaZZ2Q9nnFU3rbva7SXUmwcn6SC8jrNW
         EU9+i02UXPkT4dPhe1uOLb1cHlT00R7pxBn1PFEeznKZPZRPJI+PRcvaOf9MWgpkM2oD
         lrMEo3Lw8gGbqRrHQVm8+aKHjul/FUIG/KlB7c4+bcostQiXuqiB1uRonQunvTQUNN1S
         RWNwJF+5JoN857EggU/Reo3AgTrvxQHNyN8Wt1udjJJf31M5uNT/zdW7y/BDu09Bojnl
         3e369Bgs0RLsE3snHuNEM7zD9qCJHQzbPnZdBSbDcwDb5Ekys7QerqtcrOnPCauaRq9d
         QzqQ==
X-Gm-Message-State: AOJu0YxTG+9DJfGPCj+GusYbOZrAC816JJiQIwrFq7WoBLkAPpbUoocE
	e5L7icYKifNaC7L/nVskhq0HQgFTErFcjNL8h5maTbwkQbCyJP0GWhdA
X-Gm-Gg: AZuq6aLWckYb9pFXZfPJHDYNddZw45Ay3i0n98C4AmJv8TSj8w87Eu7owfDY6hPyohU
	uo7ZYMTbMIFMEGBka04wRUdh+XNcLYz4U1xUS1wENvvwRQPyTTpDI8rkdfNeGAbba6A7PN4mKz2
	VIACiu/UwzFJ4f0MaMEcpYPwKhK6DzrMbzZZmJYHKfyu6NPQYVvoZku/FMjyrCd4RLxpVHM4LE0
	f3p2sedF6ojmYo2TPS2h8qTf7VKJTjC3433WraKbupEADpZ0uaa3f8xfTKH6ADAHOZS0isphaAd
	p0hLls6qlVwmYgsIUT3wBJXfYTBOjW32ZOslLEfRSuLIEI80Ib2mGs2XGa56amq8ZqnvRf6oPl1
	G5Z55Tv0uI9vq+ieX7ho/ayEQ64V1BQbWGvOGTlthg64Wp4BLtwLLEktugoU4P2yo/iA+sfDBoE
	HllenUpdu7h2HUyY9mV9ihxvvTj+yx1vjwpiBZKc9ghOsKr0T38OHFELpGddOl68oVcT7/xZM=
X-Received: by 2002:a05:6512:2207:b0:59d:f5ad:156a with SMTP id 2adb3069b0e04-59e16418b5amr941719e87.52.1769771534128;
        Fri, 30 Jan 2026 03:12:14 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074b2d20sm1706773e87.64.2026.01.30.03.12.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 Jan 2026 03:12:12 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: haraldnordgren@gmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	gitster@pobox.com
Subject: Re: [PATCH] revisions: add @{default} shorthand for default branch
Date: Fri, 30 Jan 2026 12:12:11 +0100
Message-ID: <20260130111211.78639-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130105954.59636-1-haraldnordgren@gmail.com>
References: <20260130105954.59636-1-haraldnordgren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I realize now when looping over all repos on my machine that quite a few of
them error out with

   error: pathspec '@{default}' did not match any file(s) known to git

I would expect all of them to have a default branch set. Maybe this is a
showstopper 🤔


Harald
