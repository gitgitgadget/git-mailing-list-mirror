Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34FD168AC
	for <git@vger.kernel.org>; Sat, 23 Dec 2023 21:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/zeYnx2"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e6a806e4aso1509331e87.1
        for <git@vger.kernel.org>; Sat, 23 Dec 2023 13:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703367471; x=1703972271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTCN5f56InmkSZMXdxp6ZnRlIfBpGlhKthtIVI0wNbQ=;
        b=I/zeYnx29Sm0vUym+fP7PXxuQUvAx3+p88rdG231qZ8ff85+TY/tKVONxROylj4cph
         YQ/w/uQ23uD6ISkHiEINkjcY5BYpa7jIde9tUlqk2KvUKN4zSNsHPM3NviS55V+RbI4N
         hDVV5ucL2hVgqs8sDt5l2xrGT+R6/lBrrr1cKds0oZnpVOCO5TpOTQGGrRPGyvy/vG71
         OYatRUimTloaX9BNkvGKBmPPg5GA0BwqnMWPWGUe8xmHR1RRSzJT5UmORraEWgsBC7qi
         mQMneEa0JbyBb6BfMhshNJIUKOKesp059NAsJgk31BRfaAaYF3cT5sIn/YQjxOf2NcJ/
         j4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703367471; x=1703972271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mTCN5f56InmkSZMXdxp6ZnRlIfBpGlhKthtIVI0wNbQ=;
        b=orvWCbD40FNrvomORyCKFoFvkK3N5JYxL1l6+/Ua9ykmU2fQodU+ZUd6TgxqK5LU9F
         qR7Kksbh+3vy8aqC8MmPHpIXCsZfg3bwPH/7Ku/KxVVqJWnRhxdobKS88/lBPPqSD5Sk
         MYnZ/Ih9dvu3HvI8AkYi1ABp46tc7P0Xj3gSchKd8SKc5wjjSO1nhIADcDFaQNXtYx0e
         VFbMKS8CiCHU+tdrn66O7KXIAqYv7/jdSdqkLu0Obk5lLqGJIGlwZuZqkVSdoNalh2Hf
         665Ew/06lAem8hNLJ4/ju91qIwphE1RDCJ6EtQ/O2r6DSV8DXlX2/7obbkh2SncHZIK7
         QrWQ==
X-Gm-Message-State: AOJu0Yw6NoBDbdLX2zQYsSTYHcshrBkRbv7HT30TrPnC1p1NUB8dZphv
	YkvEIvfXxHAUd9XDC0U8jiCAlQqWQtAmPTxr89VH2TgC
X-Google-Smtp-Source: AGHT+IGkfWRY97qHImhoJMewZ1riIsT6vCwcf0MrdwnxHLT1zzkesqRnkvb5xLaN4YloG57cjKL8igzjW7c3iuUBoN8=
X-Received: by 2002:a19:4359:0:b0:50e:647e:c40c with SMTP id
 m25-20020a194359000000b0050e647ec40cmr1339423lfj.138.1703367470502; Sat, 23
 Dec 2023 13:37:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <m0sf3vi86g.fsf@epic96565.epic.com>
In-Reply-To: <m0sf3vi86g.fsf@epic96565.epic.com>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 23 Dec 2023 13:37:40 -0800
Message-ID: <CABPp-BFbvRDCbMp9Gs9PuV7WfgoVNwyOOn1rB7fe_8UvEEdehA@mail.gmail.com>
Subject: Re: rebase invoking pre-commit
To: Sean Allred <allred.sean@gmail.com>
Cc: Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 12:59=E2=80=AFPM Sean Allred <allred.sean@gmail.com=
> wrote:
>
> Is there a current reason why pre-commit shouldn't be invoked during
> rebase, or is this just waiting for a reviewable patch?
>
> This was brought up before at [1] in 2015, but that thread so old at
> this point that it seemed prudent to double-check before investing time
> in a developing and testing a patch.
>
> [1]: https://lore.kernel.org/git/1m55i3m.1fum4zo1fpnhncM%25lists@haller-b=
erlin.de/

I'm very opinionated here.  I'm just one person, so definitely take
this with a grain of salt, but in my view...

Personally, I think implementing any per-commit hook in rebase by
default is a mistake.  It enforces a
must-be-in-a-worktree-and-the-worktree-must-be-updated-with-every-replayed-=
commit
mindset, which I find highly problematic[2], even if that's "what we
always used to do".  Because of that, I would prefer to see this at
most be a command line flag.  However, we've already got a command
line flag that while not identical, is essentially equivalent: "--exec
$MY_SCRIPT" (it's not the same because it's a post-commit check, but
you get notification of any problematic commits, and an immediate stop
of the rebase for you to fix up the problematic commit; fixing up the
commit shouldn't be problematic since you are, after all, already
rebasing).

I see Phillip already responded and suggested not running the
pre-commit hook with every commit, but only upon the first commit
after a "git rebase --continue".  That seems far more reasonable to me
than running on every commit...though even that worries me in regards
to what assumptions that entails about what is present in the working
tree.  (For example, what about folks with large repositories, so
large that a branch switch or full checkout is extremely costly, and
which could benefit from resolving conflicts in a separate
sparse-checkout worktree, potentially much more sparse than their main
checkout?  And what if people like that really fast rebase resolution
(namely, done in a separate very sparse checkout which also has the
advantage of not polluting your current working tree) so much that
they use it on smaller repositories as well?  Can I not even
experiment with this idea because of the historical
per-commit-at-least-as-full-as-main-worktree-checkout assumptions
we've baked into rebase?)

While at it, I should also mention that I'm not a fan of the broken
pre-rebase hook; its design ties us to doing a single branch at a
time.  Maybe that hook is not quite as bad, though, since we already
broke that hook and no one seemed to care (in particular, when
--update-refs was implemented).  But if no one seems to care about
broken hooks, I think the proper answer is to either get rid of the
hook or fix it.

Anyway, as I mentioned, I'm quite opinionated here.  To the point that
I deemed git-rebase in its current form to possibly be unfixable
(after first putting a lot of work into improving it over the past
years) and eventually introduced a new "git-replay" command which I
hope to make into a competent replacement for it.  Given that I do
have another command to do my experiments, others on the list may
think it's fine to send rebase further down this route, but I was
hoping to avoid further drift so that there might be some way of
re-implementing rebase on top of my "git-replay" ideas/design.

Just my $0.02,
Elijah

[2] https://lore.kernel.org/git/20231124111044.3426007-1-christian.couder@g=
mail.com/
