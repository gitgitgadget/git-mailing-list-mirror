Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4677F2FC00E
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 23:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760569584; cv=none; b=DogJoXA4KxfsynUQeJwsWNcTJYToEdZrHrL4TnNe92IzN5l8v2yrJ0C66ZACl763IzuBKRKuEoDvoPw6Pea10M/qTbzB/Jl2+InyKrSUR/BgsGIllarvEPScD9nxCyzJyV4V3H0Hm+GC3g5WaSbVWYrPFGdxxl9ET9VNiAbPpR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760569584; c=relaxed/simple;
	bh=OFhMuJ3bW5YdOs+PRFrYN5oUu5Dia9dYEujuohqJzJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ur/9XXTfMYX/WAX30emE+EjdG1iFxJHA1SicurWj1R6GDi+AYBpPhMAxw5aJiBcA8lMiKmzJFyDhz9xytcuHTFEZFoWVFTFi0GE3rzbVnsd88Pv58s4NtYX95uP+cLl6TjqvjsPvvMYIrVmvQgkafDLASDKKXHynvBmpK5aoLrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2IU6uerq; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2IU6uerq"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-633c627d04eso3654a12.0
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 16:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760569580; x=1761174380; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MA8Akd546DUfy9CanOscMMmBFBnD5VrqmkgJhGM3BT8=;
        b=2IU6uerqpyAXzDfIAhCSuqOhfdIdvS8wVCtU7Y66DCgGPjCkI2tmSpA/SckBoV+bn1
         PSUCIcbHNfEh7Mbz0vcrLiHBbReBZu6bTYzOhmKiNlNwq7cdvwQpa7DTLBBYnM85yebC
         SLQ7B7rZI53O1Jpq975ht90gB/PnNZOVN73fj9gL8VlrKgLtYy1PNBXm1BDFfq9vuuOw
         SmbYrWz508xftk4BlO9+Q1t2gnsx7QkEu4bJv5LJj9zYtRRe5TUWPF+eLZdA+5Rg2F55
         Xe8BDL29WrMPl10DS5We8Hw37+/pCAer2YtL0XRapwwQH8lor78UFrim62XKM5zd+Ib1
         EQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760569580; x=1761174380;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MA8Akd546DUfy9CanOscMMmBFBnD5VrqmkgJhGM3BT8=;
        b=flTor0nZLjLOuhuPt6cPwHb3WJ3XpFfLJPozkU4CMdBibRGak0hMgTwM12rtFo9BHe
         XsFSJzEyXMHEsRrmYo7JPjKtMPDqqU3BCQrrA2NLqC5Z8IBmL+YIbP1LUUec628wZ7NJ
         iwM6cWuNksKUYyp9I2IV0dmGNhobXQWxB0aT+ju9oKKU29YBDUXEP4Ehm5aENYcY4R5W
         CFvXEOwYTFWUToC3DNezoPA4xgDd4R6x+f/24gXZRchlv6kJbpEl7KxVgOFJTcOGM6ie
         3yI0yUrtpMFDiFUIGIcItgMJQ8nEuk6AFky/+wBm3chySO51SM7yhlOtmYRAmNB+HHko
         cvnQ==
X-Forwarded-Encrypted: i=1; AJvYcCX++5Cjs+z+5O8JmnuXeEmaFdK8havq++7CQdVwWRI+/YR4tme6+TFQAjKyasxI6Astpb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSIhu8zmApuPdznbNVvqLSIAtUX9QxKmICw8/wbKq6awUfYbdJ
	CccmG1xfF1K8Onj8ZMCeAEzX/zx3dygS5S/490dAcaJ39xHhlduh+Ga1gIx54j256blpgrlYmyU
	Ag73eVCPIuLKpdHzDFtsz2id3Rl3NBVpa9Cv7LfiP
X-Gm-Gg: ASbGnct5eOYXAHy+P1+8TSvBRjV+F1IP9vhnojB6+7lUl8SAkgLa8BGE5Go7kFhqYBj
	3y9zYHuS4bJ0AcP1RG9/kIVO9oU7awsaUhtZHixteP3FBm7mLkmI2z2vj127yjO/SF/lOSGGQnb
	jqum3vY/1nieMChzZljnAblzHzfpy2Cb/BVDIaWBO41B7WM45AarmJH4jSYvAFr3XrRC/9r72p9
	APP6Y5xanVrdRMAcwqc6oBobQORpZuVUvU5IuM7RfSwTi7YuaW4r1jbwxqNlh9pObHnqvz2OVQq
	/dE7QOqk+xIEB1W5zohq6Mb0vF3KJQ==
X-Google-Smtp-Source: AGHT+IFY6tuyYXeAyMWI84A3AwHMvPiI4IxrxA1U1SIN2imbUy5j45O6NcX82CRjUmiaLZh+a8S3luZ4Y4xuqhjGGhE=
X-Received: by 2002:aa7:d144:0:b0:634:90ba:2361 with SMTP id
 4fb4d7f45d1cf-63bee07418dmr136664a12.7.1760569580279; Wed, 15 Oct 2025
 16:06:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1989.git.1760566054455.gitgitgadget@gmail.com> <xmqq4irzu7st.fsf@gitster.g>
In-Reply-To: <xmqq4irzu7st.fsf@gitster.g>
From: Martin von Zweigbergk <martinvonz@google.com>
Date: Wed, 15 Oct 2025 16:06:09 -0700
X-Gm-Features: AS18NWCGH6tNdSoUL0gTz212ygMnokKpLq1Kw1DT-9dvsk2YegNq2XPSN4IR-SU
Message-ID: <CAESOdVAHt8nUQRE64RXwS4FiO1=Qy8EPamDwaPqUrHvx7bKCEQ@mail.gmail.com>
Subject: Re: [PATCH] BreakingChanges: say that `git diff X..Y` syntax will be
 removed in 3.0
To: Junio C Hamano <gitster@pobox.com>
Cc: Martin von Zweigbergk via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Martin von Zweigbergk <martinvonz@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Oct 2025 at 15:19, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Martin von Zweigbergk via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Martin von Zweigbergk <martinvonz@google.com>
> >
> > The `git diff X..Y` syntax is quite misleading because it looks like
> > it shows the diff of the commits in the X..Y range but it actually
> > shows the diff from X to Y. IMO, if that syntax is supported, it
> > should show a diff from the merge base of X and Y to Y. I hope Git 3.0
> > is a good time to remove support for the current syntax and
> > semantics. Then we can perhaps add the syntax back later with less
> > surprising semantics.
> >
> > Signed-off-by: Martin von Zweigbergk <martinvonz@google.com>
> > ---
> >     BreakingChanges: say that git diff X..Y syntax will be removed in 3.0
>
> I like it in prinicple and I do wish that we didn't do the lazy
> thing when we did the command line parser for "git diff" (we had
> revision range parser, so we just reused it instead of doing our own
> for "git diff").  But real life may bite us back.

Ah, so that's where it came from. Thanks for explaining. Speaking of
revision range parsers, teaching Git something like Mercurial's or
jj's "revsets" languages is one reason I would like to get rid of the
`git diff X..Y` syntax here. I haven't done a comprehensive analysis
but this is the only place I've noticed where we would need a breaking
change if we ever wanted to teach Git revsets. (I'm not volunteering
my time to work on such a project. I just think it would be nice if
someone did :) )

>
> In any case, a declaration that does not come with code changes that
> are protected by WITH_BREAKING_CHANGES CPP macro is a patch that is
> not quite ready to be applied.

Yeah, this was meant as a discussion starter. I assumed I had missed a
few things as I'm not very familiar with how things are done here. I'm
happy to add that WITH_BREAKING_CHANGES macro if there's a V2.
