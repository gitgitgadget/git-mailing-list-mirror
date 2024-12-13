Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF858364D6
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 12:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734092422; cv=none; b=V9+f8V+HriC9S7z3u5OhfRDnmZay4jZHoHudRl0aMMSeGBjNCSE8YbFnI9Sa4Ig8js0lOkeWRGiiLvoczdtiXddyKdXpuqqvz0mP3W+o+ugM+aocpFdoH2+wR5vaxXNaazFhkdYfZIdtZqSJ0QxCPtFQI6z7sicxBHeFYYyeXnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734092422; c=relaxed/simple;
	bh=sENx2SA17qZzWHXiKwyJbVe6k5oImDtlUOHrpfP3ym8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QU6hLK6wmFrAdNvK1GzFGNU90F9I+g5ya91BMXx5oH6wV9oVV/1PnAbXN37kakkNr56XLQVTo1KDyDyP+I4TbKhpWnhK7ihQ9+1rL49ZMITbXvM19MosMD+a/QP32+k86RgKiJkPIhaVEMNJW45pDoyN+ZPqSSVMkwpUtMx4+cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtpIDzfC; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtpIDzfC"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d647d5df91so217559a12.0
        for <git@vger.kernel.org>; Fri, 13 Dec 2024 04:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734092418; x=1734697218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lH9U/mA42Lm14jE5/tXYt7GipBTnBZeM0ekSttLXqKs=;
        b=dtpIDzfCu9aD9QEZTNbUwAM1xmqdNqzcVTmCKuVKUEqmkVynw8x8fFTmZKDb8VDKZk
         C8qkLOC5xLe+yN6YZZY5c4LdU8tU5BY649MahbkmBsel+PVCIgU8FiOjVMz5uxt/EGhq
         DROqvXA8CN5aRcAYG8Q2PTkNvwtM6SRgDuYoI0rKqENChuyXsb1qV3MicFJP925a1ZRq
         efG3FKuP7yqU+fsysghiuAvKCVWWNyEO8vyWdUgE6wJJZieskGldK6TCQY5BnYz1AaOA
         Qn9JlFKDjf1hR5UoOXxiKNN2idATlRvHouhYFls2FmGlSnZsuI8k2z/mt4PZdHVi4N5Z
         w0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734092418; x=1734697218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lH9U/mA42Lm14jE5/tXYt7GipBTnBZeM0ekSttLXqKs=;
        b=JfEtErfvrLCnx8rWMDGac0KgQYhcSThJfUBHRdAm+tKD3rnMdrOxv3srG8C87G7yyR
         7jMvq/vE40RVaQzp0nQOMHUEcUxdFhH+UUyqr3v5DuuSj6qDSklM5ytYvx0009BwWBh4
         hhMfZlXgqsgGAzNXchDD37ZRJ9QVOkPT/pIWrIL8o3LwyOZWnfnRFoJQgy+4ZNeV6WKX
         VRdpgYGBwsFnQMP/XiraeDTRuWahCYW2weDGpdOZgCnxKd77bdvYHKdZpUzAi3jXgCYg
         ANOkPYqXtqxrgmcm41X414pmgacLSsXQHsyTY8R4Ak0J/7bh3oC6TNmrhukyMVts3qyy
         h00w==
X-Gm-Message-State: AOJu0YyS+DeXBDlEXjuY2iChnmhFtQuUrnF6o7dVRm35GQioWmn3I1HE
	1mg+EHzkvHjNOJSorEyt5rEKbRYzxVt6jVGTpPW3YwsM1z0DI8/PcCusOAVGehCQrY1YtpbHBz6
	MtnPB1+43SGN9wPNlvK+fsmQlGI2m1KQ10Q==
X-Gm-Gg: ASbGncvQgAK+dqRISbdAiSAtM7ulkgwqsH5PPdlJUnxYt1ZR+nwXkR51IQk5kGQiCta
	rtJv1GCmAIy8ckL6U9BeemfuM5/SJcQs+5sNs
X-Google-Smtp-Source: AGHT+IHFdGh+NfoskrQbSB16iTPW2ukEcOkQUhYgNWYhte5IvvliAEoAKeoCCAz1Lqq97mWWJUwP/oDzOO6f1Zjccag=
X-Received: by 2002:a05:6402:3885:b0:5d3:ff30:b4cc with SMTP id
 4fb4d7f45d1cf-5d63c3c19e2mr1772330a12.33.1734092417689; Fri, 13 Dec 2024
 04:20:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMhVC3ZHsGJs8XJPZOPYCWBCHJOkp8xnau=5xH_Bj33JUZ4DNA@mail.gmail.com>
 <xmqqo7sq4khb.fsf@gitster.g>
In-Reply-To: <xmqqo7sq4khb.fsf@gitster.g>
From: Yuri Kanivetsky <yuri.kanivetsky@gmail.com>
Date: Fri, 13 Dec 2024 14:20:06 +0200
Message-ID: <CAMhVC3Ztem+620b2yEYuHKWFZ5rofx1VD2nyvSSP8N_TY6b6Lg@mail.gmail.com>
Subject: Re: push.default and "git push"
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It's been a while :) but... I've been researching some aspects of how
git works, and stumbled upon this issue again.

I came up with the following explanation (of how `push.default =3D
matching` works):

> In this mode `git push` pushes matching branches, i.e. all local branches=
 that exist in a remote, to their remote counterparts (if there's a local b=
ranch `ba` and a remote branch `origin/ba`, it pushes `ba` to `origin/ba`):
>
> * First it chooses a remote:
>
>   * if the current branch has an upstream, it chooses the remote the upst=
ream points to
>
>   * else if there's only one remote, it chooses this only remote
>
>   * else it chooses `origin` if it exists
>
>   * otherwise it fails
>
> * Then it pushes matching branches to the remote.
>
> * If the upstream of the current branch is in the local repo, there can b=
e no matching branches by definition (there can't be 2 branches with the sa=
me name in a repository).
>
> * It never chooses a non-matching branch, even if it's an upstream. If `b=
a` has an upstream `origin/ba2` and there's `origin/ba`, it will choose `or=
igin/ba`.

More in the following gist:

https://gist.github.com/x-yuri/0ac53cb7999b3b0352c1ec0ac8f5f4cc

The description given in the documentation:

> matching - push all branches having the same name on both ends. This make=
s the repository you are pushing to remember the set of branches that will =
be pushed out (e.g. if you always push maint and master there and no other =
branches, the repository you push to will have these two branches, and your=
 local maint and master will be pushed there).

One can sort of make an argument that the remote repository kind of
remembers the branches you push to it, but... if you delete the local
branch that you just pushed, does that make the remote repository
forget that you pushed the branch?.. The analogy is flawed. And
confusing, because it's not at all clear that the state is stored "by
the list of the branches".

Also a lot of aspects of how `push.default =3D matching` works are left out=
.

Regards,
Yuri
