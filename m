Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4621A254E
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 22:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743717956; cv=none; b=dZQUq9mrdvkZLcHvIg7aWKFTlAfmCoaIAyw9Q5ljTGJoVrsendorLDHcL0z0Ghbc837VrXyHx12wHFu8VbYH7Rf+2mJHBAkk1XJH2dmbnE8zP7XP8xiqWgnuEGfIbPi2fquxnjxXQKvlz9EPAk55139aLholcsIqqsrMt5z3JM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743717956; c=relaxed/simple;
	bh=KBEQwc3S3O+9bMfMizsHovpmQPtrb9n3nBz1FobMvY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SWjGdU0lpvx4ywLAzoUEny0lmAVD/UjqAnEu4ZFdGixBfmWXi306LJ5Y0oR0UdISX6TWZyzj8QknXHU7TtrvWVeW7MLlB+1JK5LvpUU/JbooQ2Js9jrKLpi/xRX5/4ApCKuVP0S4mFkHburG4p3hG+mEz/jCPROe8fyMUgNNVXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1t9qdkE/; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1t9qdkE/"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5dbfc122b82so3912a12.0
        for <git@vger.kernel.org>; Thu, 03 Apr 2025 15:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743717953; x=1744322753; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5qFkMPFjd0QENUthBWXIofx82SS3ZT1ckEyuwEmIUaE=;
        b=1t9qdkE/4tFBDkk1dBoBdnwwALzBZz5aymdwHAuLbJGs3/zHcKmxWb86dCpp7H9W88
         +wmIrF1D12kiB62LPGYPy1jTnZpOSd6FO4pxtRhcQsQhUtkes6PjTk1VOfkh/WeAqoqF
         ddpuawAEFvI9brqxN0EtQ9lKb+sRdKDrDOSydABfcLk7U2nQvcjsKZWrbmTnlh3LbPT5
         zpzqiB6hAh1Yp5228cakYFUNCRH2EFOBeD7x5afxQWfTr2mARWu/+bZwfVYPkcHd/FcM
         jDejesVBYEOQ2cUy7hVKpufrb8vyGGchWj6HgPFG6lnt/upHz9s79vdQ2D1MFXrKHOyA
         KpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743717953; x=1744322753;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5qFkMPFjd0QENUthBWXIofx82SS3ZT1ckEyuwEmIUaE=;
        b=JdTCYzN4FywNmkfKKHTfjSTjjvL6SRSSKk8ByovjyweapopVwaR7fraOVEdVv0MYUy
         FsaRUYEHjFRFgxqVyWioT7qxsGxJczvGNgYCtCb76IRfoKeBI+xQsdIQANJqgccg8OMu
         dlffP4iTFMjIJCPhNvsk1qraUcltjNXyu/rH6QumtE4GTCTyiQHbxtxNBF3GX5sP7uPM
         RPsIm8qHByFi2Mh+zv0bzndB69BA+ql1OORejvKzDp1+uFy2+Vlfllz+I4g0u4NAC9zL
         lAtINTgLNOec1vo8O3w1f0s/l+HXLGfHRgY5nIWo+Xel9PF5s5joGuY+uh3KAGZhQT3c
         2ZLA==
X-Forwarded-Encrypted: i=1; AJvYcCVBQe6xCFRqJPLA4QchgBgR5HYOyMOcN5DIcpi8oTHgbBG60HFsGKLE/Ne5k9TdVfECqA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwknwMhAqqRlBa+MLcBhj3W8R4zyKgKRsVMmqJgydkArOk8y62C
	WWKp40YBd/vAOTJ5wvuENr7nmXvuhTDZoCO1uG3OJX98K8a/W/HZvw3RxD9XFxBucO4qTO9zjSj
	kqJli6bo9MIY/Xy4lYzCiY3WYFMlFo/u24Hus
X-Gm-Gg: ASbGnctnv+WOiqc+K74k9IUnlzj+JQ/cA/NV/w3qgiwMye9sbwxJ+Q91w2EtYWS4S+A
	11C2RSoa41CidOpMgsM5oitj1cXT5rcQJ5FWW0BKbEvemsL9i8wxumPaNMD2TD4oW/03LerfuJh
	q5GIuwhu11F9+MPNePKQQ7Dz3e0DpchjQEy9+xmUJy34XfZbCc1baGDknD
X-Google-Smtp-Source: AGHT+IG8/1cGdN0llQGaT+oOlztS4xDIvXSzsWZ6JvhPj8e4ge3XkasU+/NH1VNheqXe4OuhIiW1fCydClXXziSGCxg=
X-Received: by 2002:a50:f686:0:b0:5ed:f521:e06c with SMTP id
 4fb4d7f45d1cf-5f0b69d6b02mr10223a12.7.1743717953013; Thu, 03 Apr 2025
 15:05:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <CABPp-BFRz-yjnti4W17AEBozb0v52kmNsgTLUZW6-MF34R-xdw@mail.gmail.com> <Z+7PDi5y4wXJBK4r@ubby>
In-Reply-To: <Z+7PDi5y4wXJBK4r@ubby>
From: Martin von Zweigbergk <martinvonz@google.com>
Date: Thu, 3 Apr 2025 15:05:41 -0700
X-Gm-Features: AQ5f1JrNK40tYAX9LP2zmJqXpNKIht1lJPH5ZhO3qQSZ0AvjuLdiC4AGZLoH6J8
Message-ID: <CAESOdVAd+X=6nEULHtKKotH_W5yNaJAcUajRU79EuG+0SF3m1A@mail.gmail.com>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
To: Nico Williams <nico@cryptonector.com>
Cc: Elijah Newren <newren@gmail.com>, Git Mailing List <git@vger.kernel.org>, 
	Edwin Kempin <ekempin@google.com>, Scott Chacon <scott@gitbutler.com>, remo@buenzli.dev, 
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Content-Type: text/plain; charset="UTF-8"

I think I may have answered some of your questions here in my other
reply to Elijah, so consider reading that too.

On Thu, 3 Apr 2025 at 11:10, Nico Williams <nico@cryptonector.com> wrote:
>
> I agree that `git rebase main <change ID>; git switch <change ID>` is
> not a good UI, and I wouldn't want it even though I want change IDs.

Why do you think it's not a good UI? Is it because the change ID isn't
meaningful? That's correct, but they are also very convenient. The
unique prefix is usually two letters or so, depending on how many
"local" commits you have in your repo. That makes them easy to type. I
basically never refer to a commit by a branch name anymore.

> > And if it does work, isn't it expensive since you'd need to walk
> > history to find it?  Or do you keep an extra lookup table on the side
> > somewhere?
>
> Worse: since there can be many commits with the same change ID they
> can't be used as refs because Git can't possibly be expected to find
> _the one_ you really intend -- how could it?  I suppose Git could let
> you pick from a list, but that's not likely going to have enough
> context.  Maybe Git could give you a list of named branches in which it
> found some change ID's commits to pick one branch from, or maybe one
> could `git cherry-pick --from $some_branch $cid` and have Git find the
> commit(s) on `$some_branch` that match change ID `$cid`.

See my reply to Elijah. There's usually just one visible commit with a
given change id a repo.
