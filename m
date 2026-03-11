Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E650E38237F
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 17:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773248779; cv=pass; b=fHzYR56l43DLbMQU3HK5Eo3uTzb1BtDaahK7jnIdzEJzpoKB529zalYyoelA5Bsr1ERUjtPpQbIyrTn7FYx6+dh2/20Ow6DvI2jFEOg1pehiNnH22BeEwv3f2u4bXaIZ1uIRxq65FobaWLvCnsm/mhDswkGuXqxJX/a/pWYVUu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773248779; c=relaxed/simple;
	bh=JGGDqorVIkS4snDGW+HdhUWmGdgDYZJrVafEcTrTi2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WEJ94UK9YYCbHF9eb+80X8bbL+WLZgv0yh7FXcIQs0KsMF1DoIZFAa5SE64koXo1NV0Ot0kIeEK8FKu153irZLxk+wfnbw8Q8/e7NBMNWiwqjqOqLqbnKxHHV71qCNq8k55XxCTygmb/0KOt6tDyyW07WfDhJjT2KbBSV5DiyNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OB5CgQ4y; arc=pass smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OB5CgQ4y"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5ffa0b23a60so46098137.0
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 10:06:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773248777; cv=none;
        d=google.com; s=arc-20240605;
        b=W0fwu+KTACE822qCY5iPdCicWJHrNCYBsM6p/8IkLFrB2taJg99cFWnu//Z3dhYIgF
         2f1k9CzkuBpO4hR4bYQgoCzlPuG2q25Nh6f2JF8icJJ5eiAxS0DiVMxyjvhzsLF8F8oj
         m3yBa2u4TKb2xiohphGqKJuoIHHfyK33y0l5LY8BOcUrrk1I3PpWc4cqlNZb0Q5kOIq/
         rEwhY+EmZHckSX49s00vilNYt0oERHUBS16iu0Cz/lfgZLF+aNS6oPW20Blo2z1IfrJP
         VfVdHdz3stgIt1nXBmplFU7nzJKSLtBTgUdKRkeCe32tkskySYTjAmqUPJfBNXvgSvxM
         tgWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Xmuw5xpuVWyDLUhBoZMv4d5yEaEItZS8FzmcNaZaktw=;
        fh=vX5skMDYYkDPkXSbowtYjc1Hkr0i7D8Adgz50ahwCJw=;
        b=P7hJzfuxfZDmQfckEbFpN5SGOl5+Haf5Z2Ysb0KK1ZdaIXC5tHfL5boDpJNH7pqC2P
         Xoo8YEg60N1L6PqBnCyowjSVbWu7F5mD/ri5yfYkNw1MZblEwp9zdSwKI7YDQt1iN8Y+
         KfMLMX2zSQB45A5on4FRcl6TBPE5ZKFHQ7Uu1cdPI4IbdDwvdestxwhpZiXgwPROaYtY
         Z9J++8H4Spb3CozPDplkgpT0j97wm5t0AXNG/c2IksWK2gVhhgB2sWgFrooifLMbTqvL
         7NCf/qZA4YWvK8LFsBgpqaJ6HExSpKtYB4K0bEcprjOnbJs2ZCgviLiEedCpOoLkgiRJ
         2yYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773248777; x=1773853577; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xmuw5xpuVWyDLUhBoZMv4d5yEaEItZS8FzmcNaZaktw=;
        b=OB5CgQ4ymugzxxkroZWXGr3w3AaJ0dsVSkF23fBVSSQTl+HSOYNvP+AWr6mWQFKAOv
         /rYsp1vWzQu49eMzPrDgfMmhyHHsx5LDkw18CPTgKeIN3kAg2bk6FpXchs35NFWus3LT
         x+PtRvPT73AxnahSVo+vgXj7kCPwvC/kl0IJwsVtUgrpbBmvLqfBwz9shjVf7LXq5BpX
         1cU/+8TG5mJ20+hFOMtw/V9brlQfllkLZCsPg+a9QPhdDBwBjzXTYX9dfcyOKvZ7VWhR
         ucP/V62xaFPeFvDqDS+8DD7WvA1fukYNdVXsgE/HUuyfpCk27PIMxHePo/dvpCz7CmcD
         vVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773248777; x=1773853577;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xmuw5xpuVWyDLUhBoZMv4d5yEaEItZS8FzmcNaZaktw=;
        b=bRyT5B23pVCrx5XxQxnMwE9SQsm1q5qNF5a1RUGUT9eJNKRNFliOtF3z+3lWM90GWm
         ULBoD4/JMwk2uQg3VaWamw5fsqTiMP5dfgm85xls4XEN71RygiOnN9e+3YrsuQhHpHAa
         rNLc9QKaAmgiPvwGKOXy87bQNrhnRjW8ycttn+UVdxLLer29q7gjNfqpV54ycOZiMpxw
         FzBbJRWKA7f7nsyErPj+pZ0OYo1ChdxGkUhCOzNT4Q9FcC+YdsCJ+fOcr7nxpYd1VMOH
         7NegymQmOLclC7USiSJfLTh5/LkWmQJHneLvJUWR9RvwLklZZyyqffDNMvzX1kBAUMdj
         w0BQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaplNjwKg4yBJJUTADxlDtqL+UUHl/upbTjA7ufiSJgk3VtE1wZnSljbDc5psd7cNd/ec=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUhW3XovyBYTxxidzafXf8qr6W0In/wd6VULn4dX6LRV45V+Nt
	5ScKsTlQj9+G5J8Og4BpJ1Dk5KBtgdcLtVqHdVTmaJ22nuy4KkZtBWqqTNHWMVQZ1AuGbbG9YWQ
	zrcdUmmHSqZSQ9CjHC4nGI8KNOseoSnM=
X-Gm-Gg: ATEYQzwyczlj1lKB5XckSdbccqP8vPvVbdahfAIMF9RSDsiG+HwqfpB3e6x3XVcAFvC
	IvX41lJ5QUyltEpYAxj9okt1BkPNpBgg25uYxBj7SH70qrQxNIi/Cwacqs+8i3JEk0F6GSKS+W0
	JO3x39PcQIs7bW3x+tBFGO+ijp3vHnAUfLgw8Y10KxvDtja/ezQ8a/E+rf1vIvA3o/LL7J8tAi9
	czYnwCLeI6YSoI62khmSAtpH8Tw62bGufU0L4ogy2wgTZGcEXfVq0ZTGACUn0KB46WPWUfdpvVj
	ggUCEQqdpqvu14iLu5yLXzZKIZLZLLX5HujRaUZ0CrWd4OOIKCkM8NKftwdLgBGBslIaNv2vRaB
	e0AjmJpc4QhAInzeg0aM=
X-Received: by 2002:a05:6102:441d:b0:5ff:bd9d:b1f8 with SMTP id
 ada2fe7eead31-601deb86b98mr980427137.9.1773248776735; Wed, 11 Mar 2026
 10:06:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2233.v3.git.git.1773149337.gitgitgadget@gmail.com>
 <pull.2233.v4.git.git.1773219028.gitgitgadget@gmail.com> <xmqqikb2qq20.fsf@gitster.g>
In-Reply-To: <xmqqikb2qq20.fsf@gitster.g>
From: Arsh Srivastava <arshsrivastava00@gmail.com>
Date: Wed, 11 Mar 2026 22:36:04 +0530
X-Gm-Features: AaiRm52JLgDaTw_mVwRIiZ-BTwkcYfEQL1gD6Ttxr3Md5_jTycJTmXSph3jEdTc
Message-ID: <CAOAgETOZL5339mypnb9z4JXZj=7TsOfdNy=x_uwBLFKcxH13cQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Advice on checkout dirty files
To: Junio C Hamano <gitster@pobox.com>
Cc: Arsh Srivastava via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes :-
> provide perfect logic not drunken-man's-walk series.
> not a place for you to show how you made wrong turns before arriving at the final shape of the code.
> history for later developers to see in "git log" output to learn from
> what is "updation"

Thank you so much for your feedback.
Again terribly sorry I will rebase my commit so that it has perfect progression.
And updation is a noun first published in Oxford English Dictionary in 2018.

On Wed, 11 Mar 2026 at 22:08, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Arsh Srivastava via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > This is my submission for microproject [GSOC]
> >
> > This patch adds a new advice type ADVICE_STASH_BEFORE_CHECKOUT to help users
> > when they attempt to switch branches with local modifications that would be
> > overwritten by the operation.
> >
> > The new advice follows the same patterns established by existing advice
> > functions such as advise_on_updating_sparse_paths(). When triggered, it
> > lists the affected files and suggests using git stash push/pop to save and
> > restore local changes.
> >
> > The advice can be silenced with:
> >
> > git config set advice.stashBeforeCheckout false
> >
> > Changes:
> >
> >> advice.h: add ADVICE_STASH_BEFORE_CHECKOUT enum value advice.c: add
> >> "stashBeforeCheckout" to advice_setting[] and implement
> >> advise_on_checkout_dirty_files() function
> >> Documentation/config/advice.adoc: document the new advice key
> >
> > Signed-off-by: Arsh Srivastava arshsrivastava00@gmail.com
>
> Even though no developer is perfect, when you are presenting your
> updated work, armed with wisdom borrowed from your reviewers'
> comments on your earlier attempts, you are expected to take the
> opportunity to pretend to have written a series of patches that are
> perfect logical progression towards the final shape of the code
> without detours, change of plans, and fixing earlier mistakes made
> in the series.
>
> Please do not throw a drunken-man's-walk series at us.  For example,
> I see that [PATCH 3/5] literally removes what was added by earlier
> patches.  This is not a place for you to show how you made wrong
> turns before arriving at the final shape of the code.
>
> The final series accepted by the project will have to stay in our
> history for later developers to see in "git log" output to learn
> from, and a series being clean logical progression is a must for
> that to happen.
>
> Also, what is "updation"?  Is it a standard English word, or some
> dialect of an LLM origin?
>
> > Arsh Srivastava (5):
> >   advice: add stashBeforeCheckout advice for dirty branch switches
> >   advice: add stashBeforeCheckout advice for dirty branch switches
> >     [GSOC]
> >   unpack-trees: suggesting 'git checkout -m <branch>' with its
> >     repercussions
> >   Updating tests and unpack-tress.c [GSOC]
> >   File updation [GSOC]
> >
> >  t/t6439-merge-co-error-msgs.sh | 6 ++++++
> >  t/t7406-submodule-update.sh    | 3 +++
> >  unpack-trees.c                 | 9 +++++++--
> >  3 files changed, 16 insertions(+), 2 deletions(-)
> >
> >
> > base-commit: d181b9354cf85b44455ce3ca9e6af0b9559e0ae2
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2233%2FArsh123344423%2Fadvice_on_checkout_dirty_files-v4
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2233/Arsh123344423/advice_on_checkout_dirty_files-v4
> > Pull-Request: https://github.com/git/git/pull/2233
> >
> > Range-diff vs v3:
> >
> >  1:  eb5639dbc3 = 1:  eb5639dbc3 advice: add stashBeforeCheckout advice for dirty branch switches
> >  2:  e88c851701 = 2:  e88c851701 advice: add stashBeforeCheckout advice for dirty branch switches [GSOC]
> >  -:  ---------- > 3:  4237b9667d unpack-trees: suggesting 'git checkout -m <branch>' with its repercussions
> >  -:  ---------- > 4:  b25ea22410 Updating tests and unpack-tress.c [GSOC]
> >  -:  ---------- > 5:  2ef7d5a3d6 File updation [GSOC]
