Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B6E1CF96
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 06:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757227622; cv=none; b=WQHqEvl9oQLmAkEzMqSizE57YDE4BYBUH8h7X/teAgLuB4L3NjXoleeHZgbGe6l0dqDMGxumAJ1J0wvFrNsnY4Svs1eUxRkr2wrntCSruCKdMuiq5o2pmkRU5I8jkdwg0ceLWHllZ/EXIk+3lFHsKXsbtywYWxqD0e8yM3lhgm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757227622; c=relaxed/simple;
	bh=A0uCJ1U68fV+7sGbBjQBn5XI/ljL38e+2lvwbC50Vhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQO0R36hyzX+rSqsavB3o0iy04jUb+geGfE29udRU7v/EFUUqSRfjDYWqL4wW1wf6NO2c9G3wAeZMBBJthim8i34vRqRf+PpTUzy2mtfOOAfA+CRrTfcOgMnDjXPk5ELK9chRcuJNm58mw2/jr+0xuI979BeFnHKQXdY0CIFwz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYREfCDJ; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYREfCDJ"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-406630d3b17so143705ab.0
        for <git@vger.kernel.org>; Sat, 06 Sep 2025 23:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757227620; x=1757832420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lj8mfEpddQJxECVVFrqCGE7h+hFxGz7ei/j20wcTYeI=;
        b=CYREfCDJt5kuZLDUlOgsiVJmn2pTKW9xDfGMXEZyekh3UeY5yS1Nj1qmg8Yvqmal8J
         +IYUta8HomDpZYWAs64NkQ0qQUg54ynorFnkLpWaJueWKpAJRgRNBnZrkcbyMhtf6X3L
         fjfOhIkd0VKL7DDtDUUWZSnahGLS/ZDs/RfC+6qaU8yxOh9OaU51Sh0pkBCcrjLSqXQN
         whWJoUsXXCb/Hq0HwgVac+TSYMqODb4vWgXht2vApVonEWdmYvHVS8ygw3XQutqlkl75
         RfuDzr581ZQON+haLTcJk/SjFxI1yeJQBk06bKHoxpwBcqg3rZHnjn+mBf3ymQN/Gv/E
         ApUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757227620; x=1757832420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lj8mfEpddQJxECVVFrqCGE7h+hFxGz7ei/j20wcTYeI=;
        b=qoncKD2ixrnb63B5ROm4bm7QDcyWTRf1yankerAX/kr799qELDkebgbUeO095Tqu6U
         nHBT4xhrqtMk4OeAUJ9PKXc4Pe3X7kRb3Yofcl9zFBP3O4wKN6rQpfcRa2EHXKPm6PwW
         NLNz/6AmQohwB22fRcsEy1MxSqxlv7ZilbuXrFCYhETX9qCq4KJrLjXfnqcU1fJWVNFV
         5y0fnb3m00cmwmgshoBEIxoRiXfQihfJy1+TALyU/aZgCsVKWBbuxofndgOL9D8GCmi7
         AcI1eMEHTTDSoMoJg1JFGgUEMvxOBwcDczS25p9j1ws1JGmE04WUi64wryBEbRu6iQ+C
         JCCw==
X-Gm-Message-State: AOJu0Yz8AoQA/5YW7cJeq2zsbBwqqU9FIqRLksBooyeZrH6ZTJVvsDGv
	T9zKvr6UZvPVxP6kwav9oOyrUAtSO9fW/8/zE6cFnvKjD5+sa8SYW+5MERK3Pi3awa7HYXtmdLy
	Wb3bDELGHqDd6kvEoLqQ0yjBzSaBogoFQ4g==
X-Gm-Gg: ASbGncvPyjrdyK7DEzmbVQLWzRGgdoVKsSAxtXyxFZZebODJNGpD/qibjlkhdnSBLeN
	/EF6UmheOD774Cy1lcC7OkiZiNgkEN3jNBZOzdjNZKc1e5GmG9TiBxklVilc/m8YFic3kROd2TJ
	B4y7QfB7+AFuXnbqlcns78N8l+iabhuQ3ERwDsNAPnyS/IAbzvkfanGgNKt6UG9c1ksbmURsQQR
	+2BcwELbndUjY0Y1g0=
X-Google-Smtp-Source: AGHT+IHf3LTC3H9hHPr891LjZhg46yeaJ0YwoI7BUrorwDE2de8IwZVOiTDxFf2/XfO5hmWwK9YSljgpOY9jOvotg9w=
X-Received: by 2002:a92:c24c:0:b0:3e3:f9db:c0f2 with SMTP id
 e9e14a558f8ab-3fd8e98d19amr70971935ab.10.1757227619636; Sat, 06 Sep 2025
 23:46:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im> <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
In-Reply-To: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 6 Sep 2025 23:46:48 -0700
X-Gm-Features: Ac12FXzNKCn0XLOBbAYqyNLumPEa7uQBD170AY6xk9J0WySszN6J9fuEU-cYcB0
Message-ID: <CABPp-BHeXtJPq7BE1UZ+zH0C-9VzQcSYRo+t0P-KWth68Zd94Q@mail.gmail.com>
Subject: Re: [PATCH RFC v3 00/18] Introduce git-history(1) command for easy
 history editing
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 11:43=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> Hi,
>
> over recent months I've been playing around with Jujutsu quite
> frequently. While I still prefer using Git, there's been a couple
> features in it that I really like and that I'd like to have in Git, as
> well.
>
> A copule of these features relate to history editing. Most importantly,
> I really dig the following commands:
>
>   - jj-abandon(1) to drop a specific commit from your history.
>
>   - jj-absorb(1) to take some changes and automatically apply them to
>     commits in your history that last modified the respective hunks.
>
>   - jj-split(1) to split a commit into two.
>
>   - jj-new(1) to insert a new commit after or before a specific other
>     commit.

Cool, I had been thinking of adding some jj-like functionality as
well, to git-replay in my case, though I was more interested in fixing
up the infrastructure to handle replaying merges sanely first.

> Not all of these commands can be ported directly into Git. jj-new(1) for
> example doesn't really make a ton of sense for us, I'd claim. But some
> of these commands _do_ make sense.
>
> I thus had a look at implementing some of these commands in Git itself,
> where the result is this patch series. Specifically, the following
> commands are introduced by this patch series:
>
>   - `git history drop` to drop a specific commit. This is basically the
>     same as jj-abandon(1).
>
>   - `git history reorder` to reorder a specific commit before or after
>     another commit. This is inspired by jj-new(1).
>
>   - `git history split` takes a commit and splits it into two. This is
>     basically the same as jj-split(1).
>
> If this is something we want to have I think it'd be just a starting
> point. There's other commands that I think are quite common and that
> might make sense to introduce eventually:
>
>   - An equivalent to jj-absorb(1) would be awesome to have.
>
>   - `git history reword` to change only the commit message of a specific
>     commit.
>
>   - `git history squash` to squash together multiple commits into one.
>
> In the end, I'd like us to learn from what people like about Jujutsu and
> apply those learnings to Git. We won't be able to apply all learnings
> from Jujutsu, as the workflow is quite different there due to the lack
> of the index. But other things we certainly can apply to Git directly.

So, this brings up a question.  Should we have git-rebase &
git-cherry-pick & git-replay & git-history, or should we consolidate?
I had envisioned having git-replay consolidate both cherry-pick and
rebase functionality into one (then got pulled away by combination of
work reassgniment & multiple life crises hitting at once taking my
focus away for quite some time).  But now we're going in the other
direction.  And further along that other direction is another extreme
-- just having these be top-level commands, e.g. "git reorder", "git
split", etc.

In a separate conversation we had (and I hope I'm paraphrasing
correctly; if not please correct me), you mentioned you wanted
git-history to be the home of history rewriting, and viewed git-replay
as just a server side thing (whereas I created git-replay specifically
as a user-focusing thing and then Christian changed it into a
server-side thing since that part was complete and enough for his
purposes).  But if git history is the home of history editing, how far
does that go?  Do we have a "git history reset"?  "git history
commit"?  "git history fast-export/fast-import"  "git history
filter-repo"?  Or is it just the home for certain kinds of history
rewriting operations?  If so, which ones?

That all said, I'm a big fan of the idea of incorporating more of jj
capabilities, and you clearly marked the command as experimental
(thanks!), which leave us room to adjust later if we don't like this
path.  So I don't want to serve as a roadblock, I just think it's a
useful conversation to have...
