Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2D618BBB0
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 06:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728543214; cv=none; b=cDWGu2l+u3W5NU3R+ThBxICGkA7VhTu1D7j45DAL2ZGAzk7TgQRdFGKFVoHNEYxu86hieb4dUvy7MGuI18889qNmg9Jy+5PT0tILzjSjTUIeQw0vPO3mrz9v0Ehmek0XNenBVPJgLXOZ0pJ4GT74BnAyoKd86pgbcJbMF3jF6Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728543214; c=relaxed/simple;
	bh=xxXiYWaFWHvMdUMQ6I3R+d+h9UiYvFZFIgZj2eDH/ZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=obG/hbXRoUU3NMiWaoAsfbB20zslqILf4pNe8Eszqi4QOftFVt6yE0xd40X4qgiXyyxn+wkr5uQE9Cf8kDUxEzj23sn53J2jTYUNVwBQ25YbLJ15706BnByAkgfzTrrndyN8sD+2X6hxlUK+/QQ5KAC7/gPGwEt+MPxvdPGIdlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0YDBOWl; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0YDBOWl"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5398fb1a871so570968e87.3
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 23:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728543211; x=1729148011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxXiYWaFWHvMdUMQ6I3R+d+h9UiYvFZFIgZj2eDH/ZE=;
        b=O0YDBOWlrf1Iq0aliXG2FutG1FfMQTMlQiFq4+x1+XzNRR8rdKK+EhuGkkyY5DzpLB
         1pXvRIRKskEqK6CUpgnGVRm+3+nOlK59DUyyKH97MFWgT+zKScBunpsqMphZSYyT6aFY
         jumZZ0p1/Hl20/0adUUz/kz/tcjz8p/Scx1AGlEnBES4CmXM5uCiMUnkOY3vCs69ZlB7
         7mVcDZLtk+yCKEdmqImttuDcKQgdYzyte9wEZimPCFdq7QNkwFYrrsg46op7yDqOhJLW
         +v2HDC7G3S7p0FNr0ssYqsSKRib+r6/ouweizxe/q5I5d4zvgyUKNGrpRqyKTUNmk3yB
         dQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728543211; x=1729148011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xxXiYWaFWHvMdUMQ6I3R+d+h9UiYvFZFIgZj2eDH/ZE=;
        b=svSWzQXHkdWvLpZkWqLKksLf3IDDe+4+z1ZHmhDIGE09yrsPTJ8jnNyPzIiHmp9uHE
         A/W0e70Poa6eRUCUhlzOurootTpSbkO9sQi7hIxLHebZTw8xzz2m71uFcVeXr1NFkSYb
         LLiLx8pa+bxLFqlzbfWpP4HiQAUCXxOYsZuGcueGMDZK2p8CXOhrA9gbdGmE566QDdnA
         kqUUL09Jft1y15T/K5eUIy9Kf9ipAhgkxa/6BmcgdxpXlLZvNaN2upr40Wh5/ISqo3eD
         oja+8mEvTPGUTsMl4mkomcfKDWJD/M8+y9CsfiBivywvhlMAs0OXtBNpJuFGurnibPzD
         L8pQ==
X-Gm-Message-State: AOJu0Yxqu/6/qdJicYf8lv4nu2kF79JFBP6CdfU1t+TMkqDllxJeng0V
	gJ1QiUFxgDXk3JZ8PPzg7LCwxRUTtGevnz8M8cENy5H5pp5BpehRAFq/kw1s9dHn+Q/9p3DXzcD
	Zqsn2HAled65ZQF4OGwLXY87P3ulbeGJ/
X-Google-Smtp-Source: AGHT+IEScIwbu7MUTrAw7cZAuPfoCjcaVpI6lvKcCYJ9uHsDfyyDHq7hctSdYV9ny/wv8gnbOy2d5EQMLN8HcTVr9gg=
X-Received: by 2002:a05:6512:68f:b0:539:9f52:9e6 with SMTP id
 2adb3069b0e04-539c49728d1mr3110636e87.54.1728543210434; Wed, 09 Oct 2024
 23:53:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJoAoZ=UyfDjAvG0-kC++R7fpR871Gsi4crR=o5F3PvNfB=7Uw@mail.gmail.com>
In-Reply-To: <CAJoAoZ=UyfDjAvG0-kC++R7fpR871Gsi4crR=o5F3PvNfB=7Uw@mail.gmail.com>
From: Scott Chacon <schacon@gmail.com>
Date: Thu, 10 Oct 2024 08:53:18 +0200
Message-ID: <CAP2yMaJc8ZDiyZrxym-azUpkUOCTjLWEkv6gO_hJ1TqU==Bdcg@mail.gmail.com>
Subject: Re: Interest in a Git meetup in Bay Area, California?
To: Emily Shaffer <nasamuffin@google.com>
Cc: Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 7:10=E2=80=AFPM Emily Shaffer <nasamuffin@google.com=
> wrote:
> After seeing Berlin have a meetup recently[1], I wonder if we have
> enough critical mass for a similar meetup in Silicon Valley. I know of
> my own team and one or two other contributors in the Bay, but since
> there are so many developers here, surely there must be more?

I helped organize the Berlin one, but I'm in the Bay Area often and
would be happy to attend or even help organize there.

> * Which part of the Bay is your preference? (San Francisco / East Bay
> / South Bay / Peninsula / other)

I personally feel like SF is good, since I live in Berkeley and SF is
easiest to reach from both the east bay and the peninsula. But I can
make it anywhere.

> * Which days of the week/time of the day are you most available? (e.g.
> weekdays after 6pm, weekend mornings, only Thursdays coinciding with
> the crescent waning moon)

We did our Berlin one in the evening. Good pizza and beer time.

> * If you are interested in helping to organize such a meetup, please
> indicate this.

I am happy to help organize, but I probably couldn't do it until early
Dec or early next year. Happy to do the next one if you feel that's
too far away.

Or, what also might be interesting is to do one in the evening on Mon
Oct 28th, as there will be a lot of people in town for GitHub
Universe.

Scott
