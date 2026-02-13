Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D91214204
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 07:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770966858; cv=pass; b=BHyDiALpOLsvd409+VMUyDEvgi8QaqQ16YZCRF6+YU/4i2yRlMmgBlcJEZeSkh7j3IOefgSJEPmUYqgGGVidUI+pZZv8t9RcvU3bjLdM6EEwStGk52+vAauaIITB0Gk7LXX7srs6ABdV3wmOGoPcT5wkAS6EXBxaXG+iQ+QutV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770966858; c=relaxed/simple;
	bh=EjAX7d7yHENillGfkoGEeXKAEcg+jIivb+IKm0cb8OI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kj6dyNGA/6t+RLN73onj1Vk5P/zHQd0MGATEcIoxNnWvAJZc3PdgIAezjXdURBgbN6lAtOxoZ4wQOs/7OrqOYHbiKoggZ4SW3OnltRgHx1eLKm7vwbMI1QszFb24n3ul6uFcYxwmdzjT7WjOiwKD1P0hxjuczdGwELRBpNc2WA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jKTRr/oy; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jKTRr/oy"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-124afd03fd1so1122734c88.0
        for <git@vger.kernel.org>; Thu, 12 Feb 2026 23:14:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770966855; cv=none;
        d=google.com; s=arc-20240605;
        b=E9AtEcC7s2CJ07bcRRqs0e+eSxGIYGGEvXsOjvGDssSsmQB3jiNyIX6d/pbUdRYnra
         Np3zbqvzXq9BKg9iHuxg/gJhqrQhvDafVFzQDjMlcHiQnhEFofBl2Ud0HA/tH1Z8gyl9
         FtvizjZajiglj92dUpeh9N3S2B9ym6Cr6dF3I/SCvQy3SXa+Paa99EV5qAFpj5u89p0a
         gyXDED246nSjP6bvQJbDB5C11cJZRkPRfigDCHrZkF8qUEEyq4d6c5Ib2YllOmuylRgn
         M3uGYRA7vO89vX4UBumCS4i5Slah65WjQLwSXax+o179K1jZg4DFqvO9MGRjlsbXFA4u
         UqKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W0LUDLp/3moxxyLUD6fiYAJ1vQnRI3Ku6beji5Tg+SY=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=W/anzWwTtx/t4/lOMSduU5WVYwHJEmNlHmLuGJ2MkRVwwibwoXJWgU0eEASOCrzZG7
         i3KFhOHvt2aGTPgSPifPsR2xihmY5aIAVZlJ/YQSdRqEVeWVHxLGFNL/6MKs3f1F8HT7
         oEonaINrwIXUavQ4uzGRNofuPZOd06uOvlvcyVi3EiJcJkF43yF52b2zYGuVL8ULBJ7v
         9abT0MIxXkw6HCB3pOcf0QCJevryYURA8MBHWqWdfFwCwLoKoRZtSm/WSbeyTUaeW4lZ
         SUZYOXuTIbHxZZ4xiYFtGoY7C7DAnR/BgUTPh1yyFNrI7fEP7FYVtJi5be1Tp/a/ahth
         HoWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1770966855; x=1771571655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0LUDLp/3moxxyLUD6fiYAJ1vQnRI3Ku6beji5Tg+SY=;
        b=jKTRr/oyULVVGiGmzwViMmtvuXsFxxN999rdk9ik9B7erVk2TrgnAYjOLxmyLKLMk6
         xFGpm40Gf+bptgYo9pxxbcOt9JkRmFu6ILGZSICi+ccuj70yedWS3Bj3kVTcqgO/OK1R
         LRz4fn5ryHQo9/d0FqVkQhg9GYNuE4hA3jN4U4fx+ijuDWFNtBcAObhi7dkIl0zUVLf5
         ABaHCUw4+EouAZrAvbUNhZwkr5qIcNsaKe1RbJV91TjxfFJhDpT49zejLjRPgLTdHtDk
         LxZJFBywcYqw5XgmLVLDjP657GIigPDQZQG2zcda0mZZIFLtqyOhCuyJD++QdT7n8r1J
         YigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770966855; x=1771571655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W0LUDLp/3moxxyLUD6fiYAJ1vQnRI3Ku6beji5Tg+SY=;
        b=Fm9hKzUsxZLI3pj3hz2qjs6AmMqK/Icp4lenYZUGe5hAyXrF6A7EjW9BhZmKBHANqH
         apLxry+VQk5UTp/BGtzC8S6fV2DZNzUJbDoa7ndqnlStZTSlnrMXT3nTSP1TaT3ESGa7
         EFSgBOpO793+kUT0sDkgSYNtCcY5XtaX26l49srzWgE5hBo1+qsY7ECtssx+SD544DzK
         rsU7SrqFuHhAB0PfzUiq2ZKzhpYbqShYX8fzTj7e2iCMLm6LBxQlvFAg1i5Fe/7I3w14
         nn5QFXhHzY6hJMUguENJZ8ul0fQ3CaC+d3/YI8OWWj7Ja1K09AuQlcUBvbuvmYRTzYvw
         5wKQ==
X-Gm-Message-State: AOJu0Yz8sVQlQaz0c4PmBtcF5C3oGG+cZ2OfnScOwa/fyu+1+D4iEnk0
	pnEA76yxY9zCbgGgLmE17l4vH7SfEzBzqQHyYqECn8kEmAG1O1Ft+LpENFBQeWSr1j6MqerkKZv
	DcJlsaZ5D37CWluC70riwEucolajR9pLOZ/RRAQZ8c1LwwFPuHhbtRzQ=
X-Gm-Gg: AZuq6aKkwZZpFeO7a7ftbt0aC121l67rKOPK62Cywoe6qzB/dFpeh72k2qHWy0oXcV2
	CGXeAaoVqeOy+8ITXr2WLzSl0JIjxgSWuLyz4reucaqwV2Qt8ayW8T6KFF9dt8viXQ6SXJFRJMn
	vOMlhWEl4Nkel86b/ZoEhK1GWqXKO3eEdUENLZ9L5Tn025ftGmFdbhdb5fw9QtO1GdyJIDUvGsC
	W/B0VkH6hektWr7EohQyCQY96V5gcGZu4JOEn2Q4yA9YTpTxE8uf7qcZcPA1IyifMwPaLM0GQhv
	qAwGVQQVVoDg+8Hi9/I=
X-Received: by 2002:a05:7022:2386:b0:11b:99a2:9082 with SMTP id
 a92af1059eb24-1273adce0a6mr244580c88.15.1770966855143; Thu, 12 Feb 2026
 23:14:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211041128.48412-1-hanyang.tony@bytedance.com>
 <20260212072002.2347-1-hanyang.tony@bytedance.com> <20260212072002.2347-2-hanyang.tony@bytedance.com>
 <xmqqseb5okl5.fsf@gitster.g>
In-Reply-To: <xmqqseb5okl5.fsf@gitster.g>
From: Han Young <hanyang.tony@bytedance.com>
Date: Fri, 13 Feb 2026 15:14:03 +0800
X-Gm-Features: AZwV_Qi9LLTb1I9fmRVCq3_UJL15Yx9fvj6-pfZG551TofQZZtw7ZFaB9gtvl4U
Message-ID: <CAG1j3zH0C0DA+V35A1e73wi41gmk9Xry6gmtZM3w3LT09etntQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 1/1] diffcore-break: prevent dangling pointer
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 2:58=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
> I sense that "This prevents ... later on" needs further be
> clarified, since it is totally unclear what "later on" refers to.
> We are done with the old filepair, and have no reason to revisit the
> q->queue[] item ourselves, but somebody later attempts to use it.
> Who is it and why does it do so?  That is a natural question readers
> of the above description would ask, isn't it?

Sorry, I'll try to describe the problem thoroughly in version 3 of the patc=
h.

> > +     echo xyzz >server/foo &&
>
> The blank line above does not have to be doubled, I think.  So the
> first commit yas "xyz" in "foo", and 100 lines 1..100 in "bar/baz"

Yes, I wasn't being careful, I will ensure there are no double blank lines.

> > +     rm server/bar/baz &&
>
> We are overwriting it, so I am not sure why this "rm" is needed.  Is
> it necessary to avoid reusing the same i-num for the file to avoid
> racily clean condition, or something?  I find it unlikely because
> the length of the new contents ...

This is an artifact from before I found the test_seq helper function.
I will remove it.

> > +     # Ensure baz has diff
> > +     git -C client reset --hard HEAD &&
>
> I am not sure what the comment wants to say.  Before this hard
> reset, we did have modification relative to HEAD in bar/baz; with a
> hard reset, we are ensuring that everything including bar/baz
> exactly match HEAD, aren't we?

This resets bar/baz to the HEAD's version. So that in the reset below,
The `bar/baz` in the worktree is different from the `bar/baz` in HEAD~1.
We rely on bar/baz to be broken into delete/create to trigger the
use-after-free bug. I'll clarify the comment in v3.

> > +     # reset's break-rewrites detection will trigger prefetch
>
> "reset's break-rewrites detection" -> "break-rewrites detction in reset"
> or something to avoid the "'"; otherwise you'd get
>
>     error: bug in the test script: not 2 or 3 parameters to test-expect-s=
uccess
>
> You rewrote this line as a part of the last-minute change before you
> ran the test for the last time, or something?

Sorry, I only added the comments after finish writing the test, and
forgot to run the test again.

> ... and cause us to run the prefetch to obtain "foo", but it runs
> do_diff_cache() and makes it notice bar/baz has changed too much?
>
> Your "do not leave q->queue[] dangling, as other people may still
> look at them" fix certainly is a good hygiene, but I have to wonder
> why we are doing break detection in this case in the first place.
> For the internal "Let's figure out which path have changed, so that
> we re-read only those changed paths" invocation of diff machinery,
> we should not be doing so.  A break detection is to see if the
> change in the contents of a single path is a total rewrite, and
> regardless of the answer, the fact that the path was modified does
> not change, update_index_from_diff() would work on the path anyway.
> I also suspect that, if we are doing rename detection in this call
> to do_diff_cache(), it is a totally wasted effort.  We may want to
> take a deeper look at it, possibly outside the theme of this more
> focused fix.

I'm not familiar with reset and diff machinery; I encountered this bug
during a real world mixed reset. The segmentfault calling stack is
cmd_reset -> read_from_tree -> diffcore_std -> diffcore_break
It looks like rename detection is indeed pointless.

> By the way, I find it highly curious that with the following patch
> to revert the fix with a bit of extra output sprinkled to your
> tests, the problem does not reproduce reliably, which may indicate
> that your test may be flaky (i.e., timing dependent).  Am I doing
> something bogus in the patch?

It seems the problem does not reproduce reliably with or without your
patch. I suspect that could be due to the freed memory on some
occasions isn't reused by system, thus the access later on doesn't
trigger a segment fault. On my macOS system, the test passes around
5% of the time. However, if I set q->queue[i] to a bogus memory
location like 0x1 causes a Git segment fault every time.
Is there a better way to write tests for this kind of situation?

Thanks.
