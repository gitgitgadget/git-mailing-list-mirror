Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411CD81AB4
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 16:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727282876; cv=none; b=PradEp31KPrpPNkll1hOwFdKO1aaJEV+tx7iI6hl/7J5rBCuy300pNZKgDHbtoXJ+7EH5VvZU6r6U9Mgp5JbS1lXBQmq+ypXuMQMjCM6hbLZUp6dZgCVcAhT0bAaueio73ZhoduBPZ6orwBsS+D3XVmc+3xYJGuF0U6A3oO4oMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727282876; c=relaxed/simple;
	bh=mRX9jER8fbTZz38cxMJFZjPqPO3xRfjbBpBEj3Cb03I=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=lU7WGgQ0XohbKMpmWq/ovqq++Gzhk/BbryXmmDh1XDBawhXid8ABStoP0qprCkL35tYXzbOHbT7SJEYUbAnpyCmdbQJCaefJNr4ZzEn3mpLSa1vplT2egbUl5vzMYd3TmRLSkL9dsYse4p0XQ3XwbEiOQQfsOyuLtpdDSAGv5gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kU1wesOP; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kU1wesOP"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cb806623eso60896905e9.2
        for <git@vger.kernel.org>; Wed, 25 Sep 2024 09:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727282873; x=1727887673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mRX9jER8fbTZz38cxMJFZjPqPO3xRfjbBpBEj3Cb03I=;
        b=kU1wesOPgf15oW6IejHgafs+CYf7mjmD9Pvwy4mG7yW00rZQYeWesGWzszvHRsTIfz
         h/Vazdn6GVPofmVEpc5G+mbL27Hc/pWQCT8CbDR0mwRcWjsGo+y4Rvu3enOaz3NfzSVU
         PW1wv/RCAw0C2feKTMJgFSJ4/drX/lnBPcm+5wh2CacUXLawDIhRV75H/GpwHnUeZtT0
         GrF450dEpwJ99HpGYfN3E/fsEExyqkZky5y/LYTK15KJFZy6ve5xzKYJvfUSc976+g3y
         3oeWYM2n7ms4x0XeUoMzlWdOuSaclDMVbSyLj/qfxGxviYl4rBSaJaASBO8covJeTojb
         vF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727282873; x=1727887673;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mRX9jER8fbTZz38cxMJFZjPqPO3xRfjbBpBEj3Cb03I=;
        b=HnxQHnT/1RdrJn6Q+dBVrBUIyngYeT11yM3eWSDDJ6XC/kUvvNwFwbf6WTYb46BJQ7
         Eh2PRfomCnmEy9REMviiBw31tCHk16yXRBnTgyBUUw8mQ2A4kUHb+NAQ3f1ZCZ0Tsim7
         XK1PDplFYZo3MCn7DZkr6geclYu6o1YL94NenG+3jNY602wnSqbND8sr8+r4AmTOMP+J
         5jreQo9wGCefHYCs1FJ35NhTDmyXNQJU8/8o1S6kwFD4nzGggsrNnUa+AuiN+O+dM1Tu
         SIwD+tOsdoe/H9LXljET5TE9comlm2R5zn479iAaHrZGaHecJLljPdcoIkhGZyptN227
         EUBw==
X-Gm-Message-State: AOJu0Yy4sPj82lpD4JhtyaByZFCk98pImlsn0qhDmXDW8OVxcPQTXofl
	gq/JnCgmn0HcwctsBDXtm+Wjt/5LDq+9Lv8Q4LcsYPMwhj/pL2pdR1qctKOVyUk=
X-Google-Smtp-Source: AGHT+IFbnXF1nu6on8MsJ3wHqZuBgD8hvpvp6XJHmxbzj0Ja0P1ZwhNQbVsUSfppZF+WEdLJke2UgA==
X-Received: by 2002:a05:600c:1d98:b0:42c:b4f1:f2ad with SMTP id 5b1f17b1804b1-42e962451ebmr25074925e9.33.1727282873169;
        Wed, 25 Sep 2024 09:47:53 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a36287sm23597555e9.29.2024.09.25.09.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 09:47:52 -0700 (PDT)
From: Sergey Organov <sorganov@gmail.com>
To: Mateusz Wielgos <email@mateuszwielgos.com>
Cc: git@vger.kernel.org
Subject: Re: Using Git as a Database
References: <4B2B1EC7-6B08-4B57-A50F-702C031C2792@mateuszwielgos.com>
Date: Wed, 25 Sep 2024 19:47:50 +0300
In-Reply-To: <4B2B1EC7-6B08-4B57-A50F-702C031C2792@mateuszwielgos.com>
	(Mateusz Wielgos's message of "Sun, 22 Sep 2024 22:28:26 -0500")
Message-ID: <87jzezhe89.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Mateusz Wielgos <email@mateuszwielgos.com> writes:

> Hello,
>
> I would like to use Git as a database of sorts. Let’s say I want to
> track weight of something in a file. When the value changes I can
> commit the new one. I can also figure out all previous values. That’s
> awesome.
>
> What I am having trouble with is… What if a measurement is taken but
> there’s no change? I want to commit a file that hasn’t changed.
>
> The only workaround I figured out is to toggle the executable bit.

As you are tracking weight or something like that over time, it's likely
useless without date, so just put time-stamp into the file as well:

85kg 2024-09-25 19:45:14

-- Sergey
