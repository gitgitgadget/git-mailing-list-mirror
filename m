Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35B11E0B7D
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 20:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736196668; cv=none; b=p424Z5cGOB88qrKlkWmEKNYxbIkdEixrEUzscBrVtoEjUmHFE4g9ufsqxAnmNN5O9NjN5QgTnpswbLsX213DEc8TPXl6ylMsC9QTcRA6BZIxYDUTMFvwDvWl5w2wTrPPEthShOcURDCtcQnHvELJvTetX3S5J8FmFCnA/Y7itfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736196668; c=relaxed/simple;
	bh=CnHclgGlR0WAI+/HgNvrzyGvWgO6MI4nUv9Q4N00XTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l8JcjAFM1a2/3g8zL1fEE5XEctiHDhSzG0pd40vAM9wqP2riC24I+xxZbUt9ONb30lUvYUFXDhcqiqbCz78myswJk/9EVh4r3sFK8UhFUNIOeNfM0tvoypiRAiRIVQoTEWygY6IRGvgahW2FPRqyiXLw5wGKnj8o8lkNXQ0l13s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToYZ74au; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToYZ74au"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e53c9035003so18167195276.2
        for <git@vger.kernel.org>; Mon, 06 Jan 2025 12:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736196666; x=1736801466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUve0VZUElP9Xkgt1uWiwF/aQv/QgvHd9iHHZF5Dwo4=;
        b=ToYZ74autWtSJ+udBIVeHcSLggUPas5YTUtfkHa32Q7A7sP5mc6K1CF8dECnoU08ZS
         FjJtz5eEYIqHlNSHqkbFTkzBHSt67r7oEOug8iJcZbsItk/PSKp757TvvsKd2ajLF2Dp
         f6mIfNvH/Vwi9WwSvkV+scFLzo3zFnG2zPIdPyGG5+LKWXs7gKwSG/ahNlUqvCeBUlLM
         0Hun/vMNbU6aD99FjzroXZDkntgyZT7803CBlONvavh0IN3W/V1UKM9IMa6vOsoVvSnu
         vZyCc69nU93QgcSDfNTbB6VjILBzphZVH1/YQrI8lt2APp+Mzh6ncM+9LX1aG6itkHda
         1G6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736196666; x=1736801466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wUve0VZUElP9Xkgt1uWiwF/aQv/QgvHd9iHHZF5Dwo4=;
        b=cAAjePfMygL74SfUPLiWPEdd+MxHD0m8VqVkhtERp6TRtJnq7101c2F82ghYyh2B5Z
         v8RcUwzozco9asHHUMDYNuXseLiGoMtPHdHHVrcl+zIz4JvMXMi58VaRjdU/Ikmh7das
         +kYggbsGe6K0vx9soy0FjTHUaRWmPI+S9+0ZoJYySDO9uR9Fo08JghRtP6HJDhNLj4xm
         /Z+nfsYYo4z6aDYEGbJBti4R9rEQcMt+3QDbbh6pD9oUipIojjRLFJ1J+JjRO/GndZvZ
         y2pqfCdCxSBSERE97ad9JRmc9cCNHsB0DYBPBeLIY3dcGAtHsttBL6OPJUVP2YTtYn5V
         DyMw==
X-Forwarded-Encrypted: i=1; AJvYcCXTZnF95Sw23MiZ6WjrKkhnFixEZmHeBjq+sTvZSCDJ1Vzgmf1m5zWwvm9ecX9hIRdNSR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBgHxkUakqyRxryRU0AMDmN0aQgNzUzxDYNPHGR/4ms4qTgkDK
	eZgeSysKCf7m+jtkEUQIyvgOQuNp4s4wXfaN8a75p9bXq4539eKEmDM7CGzMXjOb3E1DNaIA3Pm
	s2hvR66x/5AajjO4rfB3JJKwnRkU=
X-Gm-Gg: ASbGncsabVwh1G5djIVfEvwuIf5YTkZVvH61ydgwvw6ggnCtH960OqOezA+nUA7FZVg
	l95CAuBBcyu8A6xPR8YHrnlkGzUJWlui+kG6m
X-Google-Smtp-Source: AGHT+IFmsH4HYQB0K5e14Lc88osV9wLGnsZehfeRPseeDIRYQd66tKslL+my583c/5jEJ6kdzzqSwD5nRmm4J5+yV4I=
X-Received: by 2002:a05:690c:490c:b0:6e3:323f:d8fb with SMTP id
 00721157ae682-6f3f81152c3mr438253497b3.14.1736196665732; Mon, 06 Jan 2025
 12:51:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFOYHZDQs-mftqLQn5HiFgBWcFN6Z-WDscJt=zVLRyGTo36=HQ@mail.gmail.com>
 <20250106065121.GA8844@tb-raspi4> <xmqqsepw0xk7.fsf@gitster.g>
In-Reply-To: <xmqqsepw0xk7.fsf@gitster.g>
From: Chris Packham <judge.packham@gmail.com>
Date: Tue, 7 Jan 2025 09:50:54 +1300
X-Gm-Features: AbW1kvbHbpQPS2g61w0DfqEUDrgkNgrFLerRGbrHVOjwJTQj4xflFgh_9XFRmNY
Message-ID: <CAFOYHZCWhwmHDUsB0jyz+kDLwMOtOX_W+8PXisi2NBP=HYARVA@mail.gmail.com>
Subject: Re: Testing for existence of a remote branch from a script
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>, 
	GIT <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 4:30=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
> >> changes are fetched from one branch (e.g. 'foo') but are pushed to a
> >> different one ('foo_incoming'). Our CI system runs to test the changes
> >> and when they pass 'foo_incoming' is merged (fast-forward most of the
> >> time) into 'foo'.
> >> ...
> >> Is there a better way of checking for the existence of a remote branch=
?
> >
> > I may have missed something, would that work:
> > git fetch -p
> > git branch -r
>
> Or "git ls-remote origin refs/heads/foo-incoming" and see if it
> yields anything?

git ls-remote --exit-code origin refs/heads/foo_incoming would work
for me. And I think it would save me a fetch to get past one
bootstrapping issue.

>
> The "workflow" makes me wonder how it would be bootstrapped, though.
>

Currently we require the first person to know what they're doing and
do the initial push as `HEAD:refs/heads/foo_incoming` the CI tooling
we have set up knows to create `foo` if it doesn't already exist.
That's probably not too bad because for an unborn branch you'd need to
say `HEAD:refs/heads/foo` anyway before subsequent pushes would work
without the refspec.

Our workflow does require some discipline as that first push should
just be either an existing commit (when branching in an existing repo)
or a largely empty "Initial commit" for a new repository. That all
relies on a "gentlepersons's agreement" that the first push to one of
these branches doesn't require review because there's nothing really
to enforce that policy. Pushing to the non-incoming branch is
restricted to the CI user via a hook on the server for plain git or
with access permissions for gerrit.

> When you add a new branch, "bar", to be pre-reviewed before getting
> merged at the server side, you want people to push to
> "bar-incoming".  Before the very initial update to "bar-incoming"
> that pushes into "bar-incoming" and creates it, there wouldn't be
> "bar-incoming" on the remote side, would there?  So "see if
> foo-incoming exists and change the behaviour on the client end
> accordingly" may not be a strategy to pursue.

I know git has some tooling for a triangular workflow
(branch.<name>.pushRemote) I'm not sure if that can be setup to push
to a differently named branch. Some kind of branch.<name>.pushRefSpec
might help if it could support *:*_incoming.

The main thing I'm scripting on top of is Gerrit's magic refs/for/* so
even if git supported our version of a triangular workflow workflow
I'd still need something to decide when to use refs/for/foo or
refs/for/foo_incoming when dealing with Gerrit.

> If we wanted to support the "workflow" natively, the way we would do
> so would be to introduce a protocol capability that allows the
> server side to advertise:
>
>     If you want to update branch B, you are not allowed to do so
>     directly.  Instead, you are expected to push your changes to
>     update 'refs/for/B'
>
> and then "git push" on the client end would notice the capability
> and turns "git push origin B" (or, more likely, the user is on local
> branch B that is to build on the remote branch B from 'origin', and
> "git push" with no arguments would do the right thing) into such an
> update.

For the most part we're happy with using a pre-receive hook on the
server to block updates when required. We're able to put out an error
message that tells the user to push to foo_incoming.

Having some kind of config that made `git push` do the right thing
would be great as it would save the user some typing. I don't know how
much advertising from the git server this would really require (we
could easily update our reject hook to advertise some `git config`
settings).

>
> I am not suggesting that we jump to the above immediately.  But the
> reason why I am bringing it up is because The "how would I see if
> they have foo-incoming?" smells like seeking a way to implement such
> a custom capability advertisement outside Git.
>
> A few random thoughts.
>
>  - Would it be useful if we introduced the ability to advertise
>    "custom capabilities" from the receiving end of the connection,
>    that does not affect how the rest of Git behaves at all?  It
>    would be sort of the reverse of --server-option, which is a
>    mechanism to let the client to tell the other side out of band
>    information that the rest of Git is oblivious.
>
>    The other side of course needs a way to inspect what capabilities
>    are advertised.  For "--server-option", I do not think our server
>    end does anything special, but other implementations can act on
>    them.  This new thing can start the same way.
>
>  - If this is a poor-man's custom capability advertisement, perhaps
>    the server end can create a ref "refs/capabilities/incoming"
>    (whose value does not really matter) and your client side can see
>    if there is such a ref with "ls-remote"?  That may be a more
>    robust thing to do instead, perhaps, as you do not need to worry
>    about "What about a new branch 'bar'?" bootstrapping issues.
>
