Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBD018BC31
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 09:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729070154; cv=none; b=pLIxPyyA9gLmHAdISL0vCx1L/xx+SJuC0TaepyGhH8bwq0PJTmbrWmMvuF5x6UhXDcGIhBzNpRSx2AzQDew2n3GaQPcFQtiUSbv0MEerni0d6s4n0Dy/0uQPOkCbicygvojyK2xFgLZZq0fvXOuBGb7OP3opVd6yct+NKRM5Qdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729070154; c=relaxed/simple;
	bh=fky+HM3RxpPF1iO28vOoyOxQMKhXJUQ9mtzEoNtCsUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bocezWl8xgP9X+lg492Br67ZUfTpVBN9tcqflibP91iJBnK4OsKVi8/h2s/JgBagFVHAy7/Dr9oVa2tONi5O2d2fyfmO9vw+kcHgjb6jJcgYjvFmxKv1bOJVXK3Bsc25pjjijCZh52X1yU9RwKn/xmS5sV1mj8IrG4LhP1MplO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HE3JpAWH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HE3JpAWH"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43144f656f0so13215075e9.0
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 02:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729070151; x=1729674951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=J5GDCc21nPAyPF+nwG5QvErURtzaUjPzqDOjWs9jcrw=;
        b=HE3JpAWH/j7hUdonuZFBbHg3FkfdOm1LeGJ3CUtDGz2Yd/LrM5m2QJp9z0YovFXywO
         y0RYs2qAsi439U+xAMEoG7y2gnyGAkvj2ETIyvKQdNH1vD4gfbBF1gWpGkfVSzEYu87C
         R61DXnYBZgt0BpiGF/SgmWEDbCr2xCaHVM37dFsZpJqNJGAO1/gCpropCEYx8as9OQ8J
         cSHAMIR1xFnWcBLsQbMqtK0jnG8+a7bvqfgtRGoYGlWfzKcIQW9uizIICT/lRiyQoH5D
         DDRxv8oQz723/GdwL8Bu+pLMFOQ41FMGlLJGSExdYRLdu5LbOaVXRymiIM/6eaD0hKZx
         qklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729070151; x=1729674951;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J5GDCc21nPAyPF+nwG5QvErURtzaUjPzqDOjWs9jcrw=;
        b=EUU4wxTt30UQRjOjgVEgOvYaPRYHPFqfucmUWlqiVvn2NwX4NybvC88Qe/zPo7Kso6
         /wR44sAPkZYOriqYOS2PwEM+qYDmrkjRUUOUb8MiBoa/XaYwLFWOzPj+JRsHRWtQsZTt
         3XD2EPsD9+9rncpqZXnzqbGXySH6oIGxVYlVFnImJB+gUk3KX9xeRgkO5n0DtCQ8xmp6
         oeYeJfuS8hS6hwEyjhpnTzY8krhOzTDdZU9iEIHyf5BxwsF0E8mxeygt1I/oPv5BUwg6
         p5j0WjalYBd84kc7Wqxir6QXNDEgEJXmbLr1FMBNkVWknE+KHJd9/gWXUholgDPjnNxt
         djfw==
X-Forwarded-Encrypted: i=1; AJvYcCUAZxcCYIkzw3jCtClEjDqE9WlCGiZv0MxGD8jb9kbHT2LLMylG1djYQ1ouQI9NGZQg04A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBQJ7e1OUAOydCCndUY6VHPojpk3ahbDstlAi4voXfFm7YQwai
	mN6nygxW2NT63kTh5IwsqjxQ2mFkPTo18Xy6yy9EkusauYF/7i89t6CuiQ==
X-Google-Smtp-Source: AGHT+IFm0P0CDCCSJ/MukJsB+vJZRkTB20V/KQajp0Hi3iCmv2z3NRGfj3Gveo/mhC6RzEjHFccrgw==
X-Received: by 2002:a05:600c:1c1c:b0:430:582f:3a9d with SMTP id 5b1f17b1804b1-4311df56fd7mr163443015e9.26.1729070150531;
        Wed, 16 Oct 2024 02:15:50 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a? ([2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fbf8313sm3763577f8f.66.2024.10.16.02.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 02:15:49 -0700 (PDT)
Message-ID: <1dc91aa7-04da-4023-bbd5-5b12539477ba@gmail.com>
Date: Wed, 16 Oct 2024 10:15:49 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git rebase exec make -C in worktree confuses repo root dir
To: Eric Sunshine <sunshine@sunshineco.com>, David Moberg <kaddkaka@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>, "git@vger.kernel.org" <git@vger.kernel.org>
References: <CAL2+Miudq0UXAb=R24v+ftZVkHy2We1CFsFAt__tCYMWtCfOow@mail.gmail.com>
 <Zw2K5xJAOGWitfXr@nand.local>
 <CAPig+cQZoO8tMZ1Gip-at8-9n_tk4axctkX=WbaO1==JRru39A@mail.gmail.com>
 <CAL2+MivOu=_HYg+2KoMKMUtz+=q2jv-K9u9Zxrhe3OuHLCmwFA@mail.gmail.com>
 <CAPig+cQ6=HDD447xTHQ84hmsF3SMbC5nH_PXf3rZWvTWmp18ug@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAPig+cQ6=HDD447xTHQ84hmsF3SMbC5nH_PXf3rZWvTWmp18ug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/10/2024 21:01, Eric Sunshine wrote:
> On Tue, Oct 15, 2024 at 2:55 PM David Moberg <kaddkaka@gmail.com> wrote:
>> Den tis 15 okt. 2024 kl 09:11 skrev Eric Sunshine <sunshine@sunshineco.com>:
>>> This looks like unintentional behavior; probably a bug. It seems to be
>>> triggered by `git rebase -i` setting GIT_DIR. Here's an even simpler
>>> reproduction recipe:
>>>
>>>      % git init foo
>>>      % cd foo
>>>      % mkdir dir
>>>      % echo foo >dir/file
>>>      % git add dir/file
>>>      % git commit -m foo
>>>      % git worktree add ../bar
>>>      % cd ../bar
>>>      % git -C dir rev-parse --show-toplevel
>>>      /.../bar
>>>      % GIT_DIR=../../foo/.git/worktrees/bar \
>>>          git -C dir rev-parse --show-toplevel
>>>      /.../bar/dir
>>>
>>> The `git rev-parse --show-toplevel` invocation with GIT_DIR set is
>>> incorrectly returning `/.../bar/dir` rather than `/.../bar`.
>>
>> Thanks, that is indeed a much smaller example and it seems to exhibit
>> the same issue. Can we figure out how to fix it?
> 
> Someone is going to have to dig into the code, but my Git time is very
> limited right now, so perhaps someone else can do the digging.

I'm about to go off the list until the 29th so I wont be working on it 
soon either but I think the problem is that git sets $GIT_DIR when it is 
run from a linked worktree. I've reproduced the commit message from 
ff5b7913f0a (sequencer, stash: fix running from worktree subdir, 
2022-01-26) below which I think explains the problem we're seeing here. 
Unfortunately the approach of setting $GIT_WORK_TREE used in that commit 
won't work for exec commands as they may be run in a different worktree. 
Naively I feel that if setup_git_directory() has found ".git" then any 
git subprocesses run in the worktree should also be able to find ".git" 
and so it should not be setting $GIT_DIR but there maybe there is some 
subtlety I'm missing


     commit ff5b7913f0af62c26682b0376d0aa2d7f5d74b2e
     Author: Elijah Newren <newren@gmail.com>
     Date:   Wed Jan 26 01:43:45 2022 +0000

     sequencer, stash: fix running from worktree subdir

     In commits bc3ae46b42 ("rebase: do not attempt to remove
     startup_info->original_cwd", 2021-12-09) and 0fce211ccc ("stash: do
     not attempt to remove startup_info->original_cwd", 2021-12-09), we
     wanted to allow the subprocess to know which directory the parent
     process was running from, so that the subprocess could protect it.
     However...

     When run from a non-main worktree, setup_git_directory() will note
     that the discovered git directory
     (/PATH/TO/.git/worktree/non-main-worktree) does not match
     DEFAULT_GIT_DIR_ENVIRONMENT (see setup_discovered_git_dir()), and
     decide to set GIT_DIR in the environment.  This matters because...

     Whenever git is run with the GIT_DIR environment variable set, and
     GIT_WORK_TREE not set, it presumes that '.' is the working tree.
     So...

     This combination results in the subcommand being very confused about
     the working tree.  Fix it by also setting the GIT_WORK_TREE
     environment variable along with setting cmd.dir.

     A possibly more involved fix we could consider for later would be to
     make setup.c set GIT_WORK_TREE whenever (a) it discovers both the
     git directory and the working tree and (b) it decides to set GIT_DIR
     in the environment.  I did not attempt that here as such would be
     too big of a change for a 2.35.1 release.

     Test-case-by: Glen Choo <chooglen@google.com>
     Signed-off-by: Elijah Newren <newren@gmail.com>
     Signed-off-by: Junio C Hamano <gitster@pobox.com>

> If you want an immediate workaround for the problem for your specific
> use-case, you can probably unset GIT_DIR in your `exec` instruction.

Indeed I think that should work in this case. Unfortunately we cannot do 
that unconditionally when running exec commands as the user may have set 
GIT_DIR when running "git rebase"

Best Wishes

Phillip

> (By the way, please avoid top-posting when you reply on this list;
> instead, post inline as I did here.)
> 

