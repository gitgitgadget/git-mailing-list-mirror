Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895B726A0D5
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 20:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759350149; cv=none; b=uhm+BPEPNxb8rsTfszxvuTTqWolgSeLCJ9JMnrje0g9kIw6tz6W6ahqTpyO600zu/3d68e8OsqGukEblzKmee6Ru4rlIPWujYGQQI4WJhQTFAuDDiuY+GPHzECE8bDqUIYb0ucnmDhrjvujl/p7l2CKVBYXO6ZZnC9mJ1fHYjZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759350149; c=relaxed/simple;
	bh=LE38llZi5EWWiYG1K+91q4CKL5Bfm6wwPy2QPpBdpoU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=oatcavVoTYH3+dj/JlB2TgVDUUlOEeEi84Z0j+tWgzt14/smJlpQbE1gu9Btg8sAqriknWOoQSGp3bXYFivHmfV2e7JcGL74GNDhhvOhU2Kil+XfmRCqw1RWUl7+op0dMAbWx+cn1hm9tz7uICx1eufzy8maLPl0UQIBQyOIu60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F847jq30; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F847jq30"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5818de29d15so273773e87.2
        for <git@vger.kernel.org>; Wed, 01 Oct 2025 13:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759350145; x=1759954945; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=33SVRlcBvKeM6pzRmEQLEJlzO8ld8xM1le3psM44dIE=;
        b=F847jq309LJW2z7kYJFCAGEu11w3UQZuYh/8bFVU2Mc+NKObgDYSezOFdrGUKf3yQ8
         JExKRT6wSoYHppruPvnDReBS+YMI3/1P45qs4WxYGvKGW4NXefkAJRY7ykQq0IKlf3c5
         Ajny0CyTlDN7dzpXXlKGTqGY5S74ufmFSa3XEc5m1eK+cTmkQU3ppJdcB7crDPA6+qWv
         zwcnizN1ctZ6xbNn5tApu+aUt3rRS0KJK9ZUoM0NDfA1vAKubZRovn4LqocLH5L6QTM9
         TTWNyJVSdyHMs63INEosGq8N3ZdexZMuPp4/WeJyAZ5tQibV5MT6nZwUyIO4XVcgihUo
         qlCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759350145; x=1759954945;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33SVRlcBvKeM6pzRmEQLEJlzO8ld8xM1le3psM44dIE=;
        b=pyqFrMYGpQU+gDC8aqu+4LuceaMpvnzOE0duFeziH0+3WGZ5AHTYgPd7B4RsNgalxk
         d8JnRr6rZdBymQykFsAEMMt9n+3eHGGRi74Uhdt3Le7bjwfT70n3fgw7XeYwSzqXTqKV
         zK6rjscKIODOb8qX13emoLCny5MSzMDMjV9PhgbT3h3ZtYWlrkFMCsULk2S+PGGaJ7Ws
         5MZLLiwTJSaZcy6DFPCZMyEC20SnVJuchFDtFyghVuuIylgXbRUB98wvaZ2FeEB0B5xF
         /mlo/uhtj0ITgFKCsent1rKOnx4JA8qYK6BtbeDzu/HAsGPYcDSA5t7VqyDSiLLzFsDk
         2wsg==
X-Forwarded-Encrypted: i=1; AJvYcCUmV5RtFxIUsIJ9Gm9KtiSooO7jGE9s0olrmHNoh9nbZYZ0GeE8o5ZbOiftDi0Q7Qhw1Os=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdT987EjzXZ6jvsiiraPRCEUonH8r7ZeLSTTitN5zk4NJSJ2W/
	/5uBRy2YPWr0w9R0u1/Rzev5Q07mvlpz2XY4DJtCbjNHrH6LNuxrUjWLQG7xbw==
X-Gm-Gg: ASbGncvT+u1LmenOUlIEyS2yj5TFvNXRBb0hPtzZIzU41ewcOZ4B1g4nc9tD/TBnPQN
	tlpZWI3VM6kPy3aYZs815+1DVBoiZ8rRRQgV44KA/UnJtmJM9iN9sJGHnAEbRzdpfQY/1QlPe1A
	FCp2889VGhv02F6zrlFbJla0d8yOAOarA8s2Y7VT9eI+drSSPfT9lHCWEBIzSotXFAswT4HsfeZ
	WfWtAx7zrbTk3m+QP6RDlZlTsX9awLuXrWc+hFt8KxDAa+mXNwZXlLZOAksOJGxWzO5+W6Lo36L
	kun9UID8rrmg85byTwHwZhy9c7S9YSMU/lqo0a5/gjE9kR0pa1dhvUo9ad7GBB9Fav4Zi+VmwQD
	BGPYp9qm19WujnFPR5wb5K9sMiFBSMTXFzuLFexR2AltlDdtvlw==
X-Google-Smtp-Source: AGHT+IHOdWeF9HlSEKfSvc0p2PxpSaYh3/vl2eUbC/4boRPAQ/HqDJGS+kzTDpkDmjr37lh/YKG5xw==
X-Received: by 2002:a05:6512:3b20:b0:55b:8afb:e644 with SMTP id 2adb3069b0e04-58af9f38ca8mr1735725e87.31.1759350145183;
        Wed, 01 Oct 2025 13:22:25 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b01124438sm172579e87.4.2025.10.01.13.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 13:22:24 -0700 (PDT)
From: Sergey Organov <sorganov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ben Knoble <ben.knoble@gmail.com>,  Michal =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>,
  Jason Cho <jason11choca@proton.me>,  "Jakub T. Jankiewicz"
 <jcubic@jcubic.pl>,  git@vger.kernel.org
Subject: Re: What is the reason behind not hiding git worktrees from git?
References: <aNuy1aab954D3rJ1@kitsune.suse.cz>
	<E311F5BA-F88C-4C3D-88B5-F8508B106D41@gmail.com>
	<xmqq3482312r.fsf@gitster.g>
Date: Wed, 01 Oct 2025 23:22:23 +0300
In-Reply-To: <xmqq3482312r.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	01 Oct 2025 11:54:04 -0700")
Message-ID: <875xcyfk3k.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Ben Knoble <ben.knoble@gmail.com> writes:
>
>>> The impact is that the list of worktrees would have to be read to get
>>> status. As status is not particularly cheap operation in any case I
>>> would expect the problem to be minor.
>>
>> I believe status information is used for the shell prompt info, so
>> performance hits there have a cost.
>
> Sure, but an embedded git-controlled working tree _should_ be
> flagged as an untracked entity, _unless_ it is ignore'd, no?
>
> That is how you would add a new submodule to your project after all.
> So, if you want to ignore them, just add them to .git/info/exclude
> or something, perhaps?
>
> Why do people even want to have such a layout, unless they want to
> make it a submodule (or deliberate subdirectory that is unrelated)?
>
>  -+- README.md (your own branch, probably on main)
>   |
>   +-+ worktree-foo (worktree checkout of branch foo)
>   | |
>   | +-- README.md (a slight variant of the file in foo)
>   |
>   +-+ worktree-bar (worktree checkout of branch bar)
>   | |
>   | +-- README.md (a slight variant of the file in bar)
>   |
>   +-+ worktree-baz (worktree checkout of branch baz)
>   | |
>   | +-- README.md (a slight variant of the file in baz)
>
> Wouldn't it be easier to manage if you had this instead?
>
>  -+
>   |
>   +-+ my-project (the primary worktree, probably on main)
>   | |
>   | +-- README.md (the file from branch main)
>   |
>   +-+ worktree-foo (worktree checkout of branch foo)
>   | |
>   | +-- README.md (a slight variant of the file in foo)
>   |
>   +-+ worktree-bar (worktree checkout of branch bar)
>   | |
>   | +-- README.md (a slight variant of the file in bar)
>   |
>   +-+ worktree-baz (worktree checkout of branch baz)
>   | |
>   | +-- README.md (a slight variant of the file in baz)
>
> That way, you can go up to the umbrella directory and ...
>
>     $ cd ..
>     $ ls
>     my-project worktree-foo worktree-bar worktree-baz
>     $ grep -e HowTo */README.md
>
> ... do things you would do collectively to these worktrees with the
> primary worktree included as well.

I suspect people rather expect support for repository with multiple
equal worktrees (no "primary" one), like this:

myproject / .git
          / worktree-foo
          / worktree-bar


Also, I'm almost sure that the first thing almost every worktree novice
does (I did), quite naturally, is:

$ git wotktree add <branch>

that happily succeeds /anywhere/ inside primary worktree without any
warning for me. It probably should either have created $top/../<branch>
instead, or refuse to proceed without confirmation in the first place.

-- Sergey Organov
