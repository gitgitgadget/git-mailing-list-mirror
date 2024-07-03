Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36121850A8
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 20:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720037952; cv=none; b=WQgekZnNm6zmXY6nLLbcKMf8C0oZnl4k8cJVa3iceF8POD1hFpTrTN5PHTzH4NW3bT5GnmT4T+NrkQY9beMbwb6/lIS3lqq89MQAjhYi9hSYcnWXMf35sWO6KvKtn4Y1aAel4XgY013YLjEJxCNDCqeg0fjE36xznItN9ZGPbh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720037952; c=relaxed/simple;
	bh=ZAPZ9tE6ClEnoX1POTkORFyR315Sas9JhkIS9V8XfYs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U/0JqiGyUEX9CdMOzvkrjGYRk2M3+AL6q5KK1TzUCXHfd92orTlr7aX4hh7Bao/udvAoyKrK5gUTrsC2LGoLF+jDe+T2+lugy4sjXoFXsZTIM8t+nvS0PLTNKONrx1CDonH5S7Iqkak6tyY+5uEhcLaZgRvB4AnRrD8RstUzl64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YuuF6wE0; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YuuF6wE0"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-70df213542bso3320217a12.3
        for <git@vger.kernel.org>; Wed, 03 Jul 2024 13:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720037950; x=1720642750; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4H48Xb+w76UeaKpvSfa49NUBvi3QeOuJU/M+y4hulh0=;
        b=YuuF6wE0VSEozrAKQANdr4qy48i4992ykZ/MMvVGWEcd6A9q/n1ZL9FY8D/ykVVIqL
         yGPIKbDXphz4TaiKcHepa5pKNwKdo7OL5qxJKnsasYbaKwUJTCQCNIxuDRj3t3yDNBFq
         na7kc0hOkvnp93SLKKqmkuMW1dWSnGGoPpugdbD+kMKWsxewJlZjdurJw8tkmXpMxAeW
         2Iyv/P6QzbTE18mnLzBSibBMtOg6FQejyLYbIdlErbxlsx45fwPx1aX+cQ4nrYCxhGYR
         KDYvsscKzTWS3Hm5PRbtrQA65grW4Ww/tmX53R2TB55aI09/bNAAkgR7AVDas2K3cm+4
         9oxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720037950; x=1720642750;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4H48Xb+w76UeaKpvSfa49NUBvi3QeOuJU/M+y4hulh0=;
        b=UUWpko5AnCatFt7Rl3I7xt+mluA6XV7ZUB71MG/6rZ0rAGRqb1eMGRl1Txuxttr5+d
         GvQ2eU2H2wbPI4qySVkMxGPAhcyJLL/ef9BNdNewRfZjzp1fYCIMhbVREVTCXGgOQ9DT
         gAzSqEzgP/UmjDgW3z1txT2sn7Bn+vb27S259NE3sC9NhM+6w3y0lapbM8hCy6LR6JQb
         JWj2+uhQeBcGQWQuOCz4MpkJvfUlIewCcUCnTQ1APe66ZsZrHWbGG/mjoMJHtvkahGaP
         xrww8S2+DmmVX/sMeltWOqqJsLlgfhQj4RlgoBkxyEgdj2U+0ZCq0X/IBRf4Ioyz48TI
         d9FA==
X-Forwarded-Encrypted: i=1; AJvYcCVLzX/dQyJum7cEjtBEUZ7TkxupoKKizNzoPM0tiqRUeYM3/SRyqfYD/u4f2hS/MeoVTWKRfPxqiFMveU3+LywKXu46
X-Gm-Message-State: AOJu0YzuGcNdrjnu3kLU8Y+hMpyHhiiuGRVD0pPJfNzFvt9i2RyiWOJh
	HWv0qWif+5K3BJIs5AiEucLT+mFVty8aQfs4yvTXfepPerZUqEuO
X-Google-Smtp-Source: AGHT+IHjVWg+r65wZTmeNBHhxdIRAZh97/gs1kvuQs64ZLl16T9aybV09zX0HJzn3/mE5vAE4sLcXA==
X-Received: by 2002:a05:6a20:6a0a:b0:1bd:1e20:9308 with SMTP id adf61e73a8af0-1bef611cf12mr15012517637.2.1720037949885;
        Wed, 03 Jul 2024 13:19:09 -0700 (PDT)
Received: from localhost (236.219.125.34.bc.googleusercontent.com. [34.125.219.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1596920sm107642945ad.268.2024.07.03.13.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 13:19:09 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Antonin Delpeuch <antonin@delpeuch.eu>
Cc: Antonin Delpeuch via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] merge-file: warn for implicit 'myers' algorithm
In-Reply-To: <dd1f768f-a137-428c-8a60-c5e875b66592@delpeuch.eu> (Antonin
	Delpeuch's message of "Wed, 3 Jul 2024 20:28:15 +0200")
References: <pull.1741.git.git.1720016469254.gitgitgadget@gmail.com>
	<xmqqmsmycriv.fsf@gitster.g>
	<dd1f768f-a137-428c-8a60-c5e875b66592@delpeuch.eu>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Wed, 03 Jul 2024 13:19:08 -0700
Message-ID: <xmqqr0ca9qkj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Antonin Delpeuch <antonin@delpeuch.eu> writes:

> I'm really sorry, I thought the switch of default and migration
> plan had already been agreed on in our discussion of my earlier
> patch.

Ahh, OK.

So we did some time ago floated the idea.  I do not remember how
widely accepted the proposal was, though.  Having a such reference
and an explicit mention of what we have and not have yet reached
consensus on (either in cover letter or after the three-dash line)
would have been very much helpful.

> I think relying on `diff.algorithm` is a natural idea, but it
> might also be confusing for users.  At least to me, the name
> `diff.algorithm` suggests that it's the algorithm used for "git
> diff", but I might not realize that it also influences how my
> merges are done.  It's probably common to want different
> algorithms for those situations as they require different speed
> and accuracy trade-offs.

I never thought that we should get rid of one-off command line
option.  After all, we started with command line option to support
such one-off tweaks in the earlier 4f7fd79e (merge-file: add
--diff-algorithm option, 2023-11-20) for that exact reason.

The need to have one-off capability is orthogonal to the need to
allow users to choose their own default via the configuration.  We
want to have both, given that some commands other than "git diff"
already honor the `diff.THING` configuration variables.  Doesn't
"git log -p" already pay attention to "diff.algorithm" among other
"diff.THING" variables?

A possible downside I had envisioned was that depending on the
application (i.e. "diff" that produces a patch vs an internal
implementation detail of "merge-file") the users may want to choose
the value of "diff.THING" differently.  But then we can use the
"'diff.THING' is used as the default, but 'diff.frotz.THING', when
defined, overrides the choice inside the 'git frotz' program as a
more specific configuration" pattern.

In any case, honoring things like

    [diff] algorithm = default
    [diff "merge-file"] algorithm = default

in the configuration file might be a reasonable way out to prepare
that users will have a way to squelch the warning messages.

Thanks.
