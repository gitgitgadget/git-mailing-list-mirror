Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089681BD9EC
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 21:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732225874; cv=none; b=KH8ff1nl1x0SBrN9IyU5JAJvWgfmGE1FtD8tRW6PNgD49m/SggI+sMf2SUTwE7aNsp3M0UOdAQVQn0SNQ8oc6Pf8Dj6CTn1m2mQXIgBzRjUCfju+n4rroEgsgPVd7EHb7QP3aXwTvy2PNBAbV7EDVMYRsnVrblQgxzvGN8cl8L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732225874; c=relaxed/simple;
	bh=w233NNy4p5L1XvJln9fH2cm6swO0U/L+Zer0YbF0B/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=By4ITQcJJ+6lEJX/QX8vUFxI8HNE1HFIeCGCmgoa5MzBEy8Gmh7r0m5fmT4FqRNtC6faPNSnp6YVt1VUjZLvr6ibm2mVHiJi9e6lQfaN3eV7ax1BGM+eZxCzdXoNBfHYoUrjg5oesM0ml9RXn2eehKzfgjBr3C8ICeVF/oYxYQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tp0h27m0; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tp0h27m0"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3824038142aso973432f8f.2
        for <git@vger.kernel.org>; Thu, 21 Nov 2024 13:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732225871; x=1732830671; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6XMIAqPzhM5bxCaLmyAE1T8ZqP4pQykquYi+/1CvKGA=;
        b=Tp0h27m0DoTrgl52BqLyTtVXKqMUPVOyaSgQwD7Ot8RXZzPyYaUiiOCNSubi+j0S6Y
         +JN5NmXBpTaB1BD4g2z6hczcq9Ny6T+x1UwdbAmPmQc8WCwPBujq/kh4S1HPlHW/sMea
         NASyZvdhu7YPY/9LFmCgbL0M84kPGVNkwhlzzT9ajDO3lnxg5MNigCmi/1/n7Cwb29FY
         PShqQvFrl26/P5jq4od0rPWYkeFqF7B4kUwZlw162JFKmmJ3T3QkJMlLFMhxcvTe4Rky
         VNrYhBZIqJANu7dwp7IPo0qpmkyZbwg6wupSj9zxXN4FMVNKvbaGNvle3/UCY3RfvNd7
         sJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732225871; x=1732830671;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6XMIAqPzhM5bxCaLmyAE1T8ZqP4pQykquYi+/1CvKGA=;
        b=knNu8T0PdVZVkZnkwwBH4QfcrWIOfZluCfdBEK18Z+Vbw9KmpabWogGyMMEValhULf
         zmxJe7qBTUt81cj6w8PEK9jrJ7b5OnW57mFrsy6WhyhpG+pT9h4McF5CH37qKPTHJCas
         DrLCa3sFefbp4mNyCUSzqMvuqInw5YtjNTq2+QHoc6oEOPCZJAyktoOQpBm5HN3uBkda
         KBRBnDgkVNkgSSQIg+VSlK3XlVI0Tv4wfRerkomqgAFIkMuQN/4T8u36wVqs8eCDUvFM
         fxlrj22p95OZNHV0/Q3sQ3uysLgz5QF72Kk4xmqY8NVylKRMyOqRyG1hEydI3NG1c9Ur
         8zCQ==
X-Gm-Message-State: AOJu0Yz1z/kRZ0MXfK4ee1CtyhNnNK7LuUfj5CEx65yYs/pfyusLs0Yy
	PN48C5OhQJ5nzBbxa5VcheorVRLvZW9svO9MdWY3ShBneCQdHvou7z+h7WKXw/AQXf4Q++KWhS/
	/l7EkMTTe4ObikdRgDHwvCKUxHXI=
X-Gm-Gg: ASbGnctEhK7MNy1T5FQWFoDCF2bPS7Z1b7H0IWjAomBz6iJfsl+iY+xZxvRq6W7xomb
	60tRItVPNbnSKU7CSz6WOeHv3E/O0R4oq
X-Google-Smtp-Source: AGHT+IG8EQAd5mUP4F2TgCiD8wzyWOw7fUzklBztpko4Z/P7x21ibMmUcYXdTYP2S9iA6LHJcGWylQbbPOiIi0iEf04=
X-Received: by 2002:a5d:5f4b:0:b0:382:4a1b:16de with SMTP id
 ffacd0b85a97d-38260b6b627mr484167f8f.21.1732225870957; Thu, 21 Nov 2024
 13:51:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120101741.8225-1-dev.mbstr@gmail.com>
In-Reply-To: <20241120101741.8225-1-dev.mbstr@gmail.com>
From: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date: Thu, 21 Nov 2024 22:50:59 +0100
Message-ID: <CAN0heSoryo-DO6WXKqqASJ5nDLqb3PNNiZv1TP=Pq11wsiSM6A@mail.gmail.com>
Subject: Re: [PATCH] git: fix paginate handling for commands with DELAY_PAGER_CONFIG
To: Matthew Bystrin <dev.mbstr@gmail.com>
Cc: git@vger.kernel.org, Lessley Dennington <lessleydennington@gmail.com>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, idriss fekir <mcsm224@gmail.com>, 
	Joey Salazar <jgsal@protonmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Matthew,

On Wed, 20 Nov 2024 at 11:41, Matthew Bystrin <dev.mbstr@gmail.com> wrote:
>
> Calling commands using editor in terminal with `--paginate` option will
> break things. For example `git --paginate config --edit`. Add extra
> check to ignore paginate flag in case command have DELAY_PAGER_CONFIG
> set.
>
> Relates: cd878a206e8c (t7006: add tests for how git config paginates)
> Signed-off-by: Matthew Bystrin <dev.mbstr@gmail.com>
> ---

> Some time ago I've sent RFC patch [1], which was not quite ready, and I didn't
> receive any feedback. Now I'm sending a more complete version of it. Fixing
> mentioned behaviour of `note` command can be done in separate patch series.

Thanks for reposting, and welcome to the list.

> +       if (use_pager == 1 && (p->option & DELAY_PAGER_CONFIG))
> +               use_pager = 0;
>         if (run_setup && startup_info->have_repository)

This flag goes back to c409824cc2a ("git.c: let builtins opt for
handling `pager.foo` themselves", 2017-08-02). The original observation
was that setting `pager.tag` to true was more or less foolish -- it
would help `git tag --list`, sure, but would also break `git tag -a`
quite badly along the way since the latter wants to open an editor.

That's why c409824cc2a allowed builtins to basically say "delay pager
config handling -- I'll respect it for some options/modes, but not for
others". Now this proposed patch wants to extend that handling beyond
"delay pager *config*" to even go "for some options/modes, I'm going to
completely ignore `--paginate`." ("Delay pager *option*"?)

Actually, no, it's not so much ignoring as *forcing*. Since you force it
to 0, doesn't that mean that `--paginate` ends up basically being
`--no-pager`? So `git --paginate branch` is now `git --no-pager branch`?
That doesn't seem right. An optionless `git branch` would have
paginated, so adding `--paginate` shouldn't change anything.

But even if we force it to -1 instead (for "maybe"), I'm not sure I
understand why such an undoing of user intention is wanted. If I run
`git --paginate tag -a ...`, maybe that's just self-inflicted harm, but
are we certain that for all the `git foo --bar` which won't respect
`pager.foo`, that it's also completely crazy to provide `--paginate`?

Martin
