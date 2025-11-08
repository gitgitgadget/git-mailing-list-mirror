Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547E215278E
	for <git@vger.kernel.org>; Sat,  8 Nov 2025 00:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762562103; cv=none; b=IF6b56S8UGlS9OoAGubxT2sKGqbHkVmhsokSjeQhwIYkkiTOx7KiLkVxDTEXM8TFqCHTYKlzjUbseWX+gOsY7pIHIgciP6kyU9DnNOkOTw80Kc07lCGZ4sAfmMQjXI+juQQ4unB8ZmMDH488tMfUeUSKxsQSJaz4uVeLh9aqOGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762562103; c=relaxed/simple;
	bh=rzChbVm2hJrveUBqnmIJyM3dewgFKiPZJmi4sfsFH/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kTUzkz3WPwW+FZiqC/4L8O8+LKX6Zmht0WuFJi17rkazKBf6aCNS7lbTv0N6rlv1AVIyO9zJ2fNgT1qt4Pmx30J1YWFkhLD8e8P0Kt09L2Ng8KPSk6XXxPdrfeaN0IezMxSe6Rxq775pz0GBctJfqXcgbSmsqzF3Qh2690BT2UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSnM20xz; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSnM20xz"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-94880a46f3fso44238239f.2
        for <git@vger.kernel.org>; Fri, 07 Nov 2025 16:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762562100; x=1763166900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ThudiFc7PZKCkOM9Q0rjpAuaFe1w2ujUqv+ftHisj+o=;
        b=WSnM20xzQls7NCTJb9lli3Cqsgh2kBaMwOz2WZPwQQFziCxjt+tbwpCCnlI11tXKfX
         eBI8HF0aT0cb1CCi0ed/MvuGJWOe4M1WQ6C4Hpox78liNEWm6FZUaWtbQo/b5FKBl4Yu
         QQqVAQd1z1HI5cowbwV0awvJj0tBn0IddHXFKQ8+szopIzKUTSbaDdH3PuZxv5Ezd+Pv
         IKP88yOhZ5j4PKgP0rvz3AVex5rTqwMHMAAdRXfxHHu/6UPMWij8GRjqimZvFfh8ffNk
         JnJkJN7YbK6RgdtfwDukpx992eie/UY7X7eTXL173gk+m1W46hUjUS7xmjMEdwGByFZ7
         R9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762562100; x=1763166900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ThudiFc7PZKCkOM9Q0rjpAuaFe1w2ujUqv+ftHisj+o=;
        b=uI0FsGrpM8gD3JOwfnQKcFqp28Wj3zpm3EL/OMlIjvpJQMmfDHwl9EdXZSDYjgn6Zl
         yTdQHFSchl6yn2CtCIyxbfOaZ7zWZPPUVJKUTqZMVLC7W1oYzD6qz4Xcwo9cDjD3tMDX
         P99AMZSvQpgk/OwrcOpY0xPd8a+7XbXgZLhbJZZHD39CPtbYlGj+woFJC5jjo4yZUYBt
         yl0Ey/qaMGp9QHu0VBSxHv3pJDPfSmOYhMw0zVKyYvpW6k8pDALp6eUZa8ZoZqcN+CUQ
         BHrhSobORTn+GyLtMdP+e6gIsKLIpb7rSUsNdQV97zzAde2aHjZEuMZmQtb969I5zEZV
         +zNg==
X-Forwarded-Encrypted: i=1; AJvYcCWMTNltTl0iOBInOrUD7bnlBauB9zcZiYF5LIZuHoWYlYM3vGLfzBMKB8R4257X4VQy6hw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy+Fm5iiV9qTXcBlvkaQBee3lLZqEb7NkGZvj3j2P66AicVtie
	ZRGcld1Or4rnopRwx/tRa4WwMoRX1Y4a4xvkkw1wsBATizhRSmNYG43ce9stW83vhM+goR/FNUT
	zBaPQKGZn2P9alM6BwiMNg20op0X2aFFSdu4u
X-Gm-Gg: ASbGncvTS5PUI4D4MarvlxA/y0/jDoPaw+Nx5Pw4tVuIRQeL7JMy3FP0zExOfKrCmPb
	CO5xNk04nUxdhLQKS5pH5LtTO4RxNcBOZ9mzOiWVpopLos21E4gNoZWCe8y4mqpO2JkTfUDK4OZ
	wLnVKFmYXzNxhHxhcV0w27QDiewwL59vnI01TCxx5+pj0ipv5SRIveQhUWh6HuttSQ7WoruydJV
	cs2Hjc1EB3gH8tihcf+FFTbqY5BZ6HJwImdlMJu+2QmKai8OtsP7pey8Bbjkpl6b9fclYxsIOrV
	TjQkWNei0A==
X-Google-Smtp-Source: AGHT+IFlhXxa/Pq3yrmx3K2CDJxBT3FvHMaas/iVR4X51yx8EFU4NAk1a8/J8O16BUNZoc8SqVr1Te1uODfPrbt0hgE=
X-Received: by 2002:a05:6e02:2708:b0:433:2844:111e with SMTP id
 e9e14a558f8ab-43367df3aa2mr21078005ab.14.1762562100250; Fri, 07 Nov 2025
 16:35:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105061918.3688870-1-christian.couder@gmail.com> <xmqqjz04mtji.fsf@gitster.g>
In-Reply-To: <xmqqjz04mtji.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 7 Nov 2025 16:34:48 -0800
X-Gm-Features: AWmQ_bkMSROFE0T7GAKw1vd17k2a63awVUz_i3hY6f6PjOxBptPoOP8wvHLndBc
Message-ID: <CABPp-BFWem8iWFQn0Sq7JhHigm7rZsa81D6r7zbsQSh3+ZH91Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] fast-import: add 'strip-if-invalid' mode to --signed-commits=<mode>
To: Junio C Hamano <gitster@pobox.com>
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 6:40=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > The `--signed-commits=3D<mode>` option in `git fast-import` allows user=
s
> > to decide what should be done when commits with signatures are
> > imported.
> >
> > For tools like `git filter-repo`, it would be useful to be able to
> > strip signatures when they are invalid, so let's add a new
> > 'strip-if-invalid' mode for that purpose.
>
> Sorry, but I do not get it.  What is your definition of a signature
> being "invalid", and what is your assumptions of how accurate a
> validity check ought to be?  For example, are you assuming that you
> have all the necessary public keys, revocation data and accurate
> clock?  Even if you are not changing a single bit in the import,
> some of your early commits' signatures do not "validate" and may
> need to be stripped, and after that happens, wouldn't signatures of
> all later commits become unusable (i.e, you may be able to verify
> that the signature on the original commit object may still be valid,
> but because the commit has to become a child of a rewritten commit,
> in the resulting history the signature would no longer match)?

Good questions.  Let me step back and perhaps motivate the change a bit:

There's a fairly significant chunk of `git filter-repo` users who also
have git histories with commit or tag signatures in their history.
They often want to specify rules for rewriting history which happen to
only affect "recent" commits.  While they could try to specify commit
ranges corresponding to "recent" commits, they worry about getting it
wrong and want to just automatically rewrite everything, expecting
older commit signatures to be untouched (since the modification rules
didn't need to modify older commits), and get new commit OIDs starting
with the first commit that was modified by one of the rewrite rules.
Unfortunately, when fast-export exports history, it does so without
signatures, and thus they get every commit rewritten, not just the
recent history.

Christian's previous series allows us to have fast-export also export
the signatures, but then we run into the problem of determining
whether those signatures are still valid and what to do if they
aren't.  This series attempts to help us determine if they are valid,
and implements one choice when they aren't (strip), in addition to one
that the previous series implemented (keep-it-anyway), while leaving
another (re-sign) for future work.

So, yeah, I'd presume this mode would have to assume the user had all
the necessary public keys in order for fast-import to be able to check
validity.  Perhaps that is a tall order for a small percentage of
repos out there, but for them, is there any good alternative?

As far as signature handling goes:
  * Since fast-export doesn't know what changes filter-repo may make
to the stream, it can't know whether the signatures will still be
valid
  * Since filter-repo doesn't know what history canonicalizations
fast-export performed (and it performs a few), it can't know whether
the signatures will still be valid
  * Therefore, fast-import is the only process in the pipeline that
can know whether a specified signature remains valid

I guess one alternative would be having fast-export include for any
signed commit, what that signed commit's OID would have been had it
been unsigned.  That would allow fast-import to check what the commit
OID would be without the signature, and if it matches, then just keep
the signature without checking whether it's actually valid.  It'd be a
change to the fast-export & fast-import format to get such an extra
piece of data, but perhaps that would be a preferable strategy?  It's
the only alternative I can think of to what Christian is doing here;
am I missing others?
