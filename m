Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2301C259B
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707585229; cv=none; b=j8KvXsZ1mnbSjcHepYC1kTo1Kfneg84BkrH8FpS/SDi+TlCBb4Juv6kciC9+YhMp6Qo7fT6HYpRNFtx9PjKSyYW3fXerWZvGmuIzRpviQfC9IByh/Cb1AsFDkHfJi1B7Bv+cZ/SDQpNT7bWv0tAoWbU3dSnY9qMGdF2VFEZ+43g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707585229; c=relaxed/simple;
	bh=pQeFWB+mUja2ogLifuulXjKjC4PI3jznA6LarQtDhos=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=P59b+ZHbxhJMB3UrgzrEuz2KSXuxy8/IHBUbybmClnSaI+p2E8Qgi9O2ni1ywNvsUbmeGbli1/QqNPQN8iHcv4NxS5nnloWQIWfozUUrqbsz75pMFaM2ZWF4naRqmSaFPzfIf3mP9e58qDYeN6FiDs+b1h+zazYIpbrcQslVr5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdRGgrV7; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdRGgrV7"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bc21303a35so733044b6e.0
        for <git@vger.kernel.org>; Sat, 10 Feb 2024 09:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707585227; x=1708190027; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=E7a3Vsf121z3UBl4nYNGP2nPvw6OLpZ47O0RD8nE36k=;
        b=bdRGgrV7CeGXQHlMaw8kl2lrncW5S3N/gEKm/KG3lJ+/QUMlPrvEw5jKbufCzznbn7
         h8PTCfXafA+D9QlH5KB/qWQ8UxnGdvhcY5t19lr0mM7lur3TnC7TzXwFrfZ4bU3EpJhp
         lPVJXEIhiMUw+0z5lYSgf67UE7inruyQIEtC4v+xK7vJijcr5/gGHzeqJ2EdLUrEcFg1
         purK+3HiQ8sR532jerbaHZPmxWbBjgMtyvU3yssLlIucwmmHl6lfYUXndE19JSnnwvft
         t2BHbIfgZnPzVb684RqmxbL2xC97pL/L5+2aaoorsXvpft0wwp9q9nfsH9RtN7EQZ6zc
         cbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707585227; x=1708190027;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7a3Vsf121z3UBl4nYNGP2nPvw6OLpZ47O0RD8nE36k=;
        b=AeqW948ZeHLGhLqeswM9MYtNU4lyLj7HW/ffR3872mrYir14gpYKZ5s0hv1PmdR0TP
         i6HZMpSEvoT8VhXmO6R+ppdQaXo5ueMU1Ka8gBxnfMB/h8OfZFmIgCKkMMTbFMtTUQyV
         jS9UCBSBAOztTUM0MLI7+36MboGm1uFkAP37pNPVIqXtjlqN0rCpXNHyHeycJes8A7HX
         GXYNARJIDZ9hMKWPVts4bMW6EGdvEZnGMPnc0oWLG8rBeuN0xvOf4revOupPnKLKl3Zv
         0AvkjNXIfkjQCXcQZtWyFHqw69EOdG8tUtfAU6VsqIrMsuvtsSmJ657kr8kcWNbgDX+E
         uAOA==
X-Gm-Message-State: AOJu0Yxwty4OfD0GoH1juH0Ty8X4rxCarKqPsYOfAJ3hmBveROtGUhAB
	4KbmbiIee1IfufPHz2hNcdJzTpeTQiz/GAPKUJF0LMvKg0c5pTSebSeq4A6v
X-Google-Smtp-Source: AGHT+IHXew8JFGZdZkzYc7SqgNaCsslhDCWpiNylcBogiCrw8NCN2jOsTZX/YV1qZ6ebiduBRdNVGw==
X-Received: by 2002:a9d:5c89:0:b0:6dd:e5bc:c6d7 with SMTP id a9-20020a9d5c89000000b006dde5bcc6d7mr2333425oti.1.1707585226750;
        Sat, 10 Feb 2024 09:13:46 -0800 (PST)
Received: from epic96565.epic.com (pat-verona-l.epic.com. [199.204.56.217])
        by smtp.gmail.com with ESMTPSA id l20-20020ac84594000000b0042c3ce9c662sm1644988qtn.16.2024.02.10.09.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 09:13:46 -0800 (PST)
References: <CAK7MZG1MeeS5QNPog9oS+MbdKpkDXu61eVOszsC20Q=ik+Ng=g@mail.gmail.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Sean Allred <allred.sean@gmail.com>
To: Vijay Raghavan Aravamudhan <avijayr@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: git status became very slow after upgrading git
Date: Sat, 10 Feb 2024 11:06:20 -0600
In-reply-to: <CAK7MZG1MeeS5QNPog9oS+MbdKpkDXu61eVOszsC20Q=ik+Ng=g@mail.gmail.com>
Message-ID: <m05xyw9r92.fsf@epic96565.epic.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Vijay Raghavan Aravamudhan <avijayr@gmail.com> writes:

> What did you do before the bug happened? (Steps to reproduce your issue)
> 1. brew update which pulled in latest version of git
> 2. git status in a repository (without submodules)
>
> What did you expect to happen? (Expected behavior)
> git status should have been fast
>
> What happened instead? (Actual behavior)
> git status takes almost 5s to complete.

Thanks for the report. This isn't a whole lot of information to go on.
At least, I'm not able to reproduce locally with a trivial repository:

    git init
    echo foo > file
    git add file
    git commit -mtest
    git status

If you're able to reproduce, can you re-run `git status` with tracing
enabled and provide your output?

    GIT_TRACE=1 GIT_TRACE_SETUP=1 GIT_TRACE_PERFORMANCE=1 git status

If you can provide reproduction instructions that start with `git init`,
that would also help. It may take some time for you, but it'll take less
time than folks on this list taking shots in the dark :-)

--
Sean Allred
