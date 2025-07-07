Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F4C2797AB
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 06:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751871442; cv=none; b=fNece8RDtWRlHNnC7VpA0kM+y7Op/YGuCWo3QqrWi4dAQk0CwvcxyxPGbw3oplAt23dmcATl1vMjG4W9HyCOsTXFW1KTwid4QT312i1KK0nVK+ySbE2GEujjqKgaXN/lruXOn5rfallfyfAwJOtoBYyOCQfinQsG8Pv3auXQ8ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751871442; c=relaxed/simple;
	bh=RR8UYhvvSDX9Q1JwgSVqrdM7YxjuDY5naN7s61liFD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eo20UgBIgSbiBE4VoQLUaAxHx4AKt1yRWqotHf91AvP/ogIBdSNSIhNOgIbn8jVsm8J1XUzqAkfTeFoEZeMLEG8haV3PGwiYtWPKD+u/OEd0b+7b1wy+HGhwsyAuuY9X246JLCuvhjFV++0eLQInjF33ncRngVWsnESkrj+CqA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uad/I+Yo; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uad/I+Yo"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6098ef283f0so35714a12.0
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 23:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751871439; x=1752476239; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qty3adp/TjeoC/ZlNbz1BSw6tAn/GVk6hgBiaCGpxGQ=;
        b=Uad/I+YoJvkDuP1QZ4QzIDsQ3v8UNNCvOUKQvBY5Xq11E/Hr/lbc53enYVGTjSRAZ+
         PmjPyaWccNdGZFvXnNJd30oQzt7W6ia6RmiXWQlPC+DAwkskTYwBUcjsWqDqMcUEWljF
         mox78iu1zaFpZ0ZKr/2rcUAt+4ZFfq80QfvZw3VyCUAhy7GBkQe5hzbMdNgt2cRIQfo9
         7S5hjWBXDoVpqawJ/DNJdm4agDiSrH3tUWYBh7BlAfgZXPb6H0e/GRbyzV2NPjCcf0nA
         ifiATLpC/9tbWaxOlzch77e4143rF6qPx/6eqA7f3eUfjbq67GQ1LoKy5Lie/aoPQJVk
         PwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751871439; x=1752476239;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qty3adp/TjeoC/ZlNbz1BSw6tAn/GVk6hgBiaCGpxGQ=;
        b=Eqlsfd4G9hvBwrB8m0skcfAk5S4oI1bRCc9oH1f37c96N48AMrFZE5El0v6fryH9Nm
         qe0brJu3SkKjg4/4WxzhslpUMayXviw/vkpXUIDRPDUKhQU+AkFYS9SUmbRjI2qYuJ6s
         9XYe31saWXFHyCYoCu6iP1QEf/DWe5ZaoZhzlJQ+AJ4U1u3yXAL2gJZ5SckIWMwSl1Qz
         54dnqAwoAHEs3KIbsZot7EUu4bWwqe4MDJBAX6GUgK3P4uH+ywxp99v2F02ma0UeObKO
         qm8JD5TiNoG7bVjpP+JL6bJzaMlh6KBVh8C93pzSO7FQAP5h68iVc++jQIruky7XiLJU
         3a6A==
X-Forwarded-Encrypted: i=1; AJvYcCU7rcdZ1GLlOUKaT4Qsgnh6HR2TkL9Lbo4McuAsiCtSLPd1X1jNvyKJIHnh4t7TM5zt3S8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVlwHJmIWeetipcovej4+DbczQs5B0C6CH9qozrJl5ku2MDGjR
	xlaCSF5jHQ70q14FC00qyt0qdKEa2yCNwhzp8MC3vS93d41yxzMVH6aURvO6SVUmMduc/jkzI1M
	gA3XkTJc3yXmmwL/1kq7+XHajAWCNDvFHJyLVvmde
X-Gm-Gg: ASbGncu5foR/NiYwkfmJCjDUrwTBDEaxGjQlPJ8PCKCTt901f+j7ETpTTcuhfd4PJYS
	mvgtj/xunvaytLI/u4fUU1aRVQ8PJkbSaySwlSv/wdAzhvOgptm0+nUJyfd3bTbgptdms5Gnhwz
	3IN6k3mZ1ojom10yyICrW43LGB3qFuw4ukVgDdZ7NGT/c=
X-Google-Smtp-Source: AGHT+IGoNagVscZSpg5jm+uND4BkzvaNX9BtgtzjUSW6oPered+8m448QeHHYgZghwUFKpwE8akHATYZa/OxadI77T8=
X-Received: by 2002:a05:6402:40d3:b0:60e:64b9:9e1c with SMTP id
 4fb4d7f45d1cf-60e712705cdmr299471a12.4.1751871439109; Sun, 06 Jul 2025
 23:57:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703113505.11889-1-drew@ddevault.org> <PN3PR01MB9597069B8CF014BFE01B53F3B84CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <DB4WQTRHWZN3.3VG20AZDK8VN@ddevault.org> <xmqqfrf8ait6.fsf@gitster.g> <xmqqfrf88s28.fsf@gitster.g>
In-Reply-To: <xmqqfrf88s28.fsf@gitster.g>
From: Martin von Zweigbergk <martinvonz@google.com>
Date: Sun, 6 Jul 2025 23:57:07 -0700
X-Gm-Features: Ac12FXzjBLhQaI-15XKCLh2FPclI4TgTbZZqWDJjtwnwkiyABcsvN25-zhA6tCM
Message-ID: <CAESOdVAGEBCYOnFGUFojRk=6s=7RHc0i2jzuOVdBd91dXsCTEQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pretty: add X-Change-ID to mail formats
To: Junio C Hamano <gitster@pobox.com>
Cc: Drew DeVault <drew@ddevault.org>, Aditya Garg <gargaditya08@live.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Andy Koppe <andy.koppe@gmail.com>, Remo Senekowitsch <remo@buenzli.dev>, 
	Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"

On Sun, 6 Jul 2025 at 22:53, Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> >> IMO the right way forward is to use a mail header.
> >
> > No.  In the change-id case, trailer is the right way to go.
> > ...
> > But after thinking thrice, we may find a set of good pieces of
> > information that should be added as new commit header ...
> > ... and there will be times when we need
> > to convey them over e-mailed workflow to allow patch recipient not
> > to lose such information.
>
> Or a third-party software may add a new commit header without
> gauging and waiting for the community consensus anyway, which may or
> may not have much structural meaning, and then we may want to extract
> that piece of information hidden in the commit header out, because
> it was not written as trailer (in which case there wouldn't have
> needed any extra effort to extract it in the first place).
>
> This part can use a bit of clarification.
>
> My endorsement below to use an extra e-mail header applies when some
> commit objects ended up with extra non-standard headers holding
> pieces of information that we want to send as part of a patch,
> whether it is a good idea or a bad idea to place that particular
> kind of information in a commit header.  And the question is "Now,
> what is the best way to transfer it over a patched e-mail?"
>
> If it were a good idea to place that particular kind of information
> in a header, that is of course an effort worth investing in.
>
> If it were a horrible idea to place it in a header, it still is
> worth investing in an effort to give ourselves a way to salvage such
> information out of the header, even though we wouldn't have needed
> such extra tool if they didn't hide it in the header.

+1

Does this also apply to commit signatures? I just created a signed
commit and checked what `git format-patch` produces. I was a bit
surprised to see that it doesn't seem to show up anywhere. Is it not
supported or did I miss some flag or config?

>
> But once a generic mechanism is written, then Git does not have to
> behave differently if an extra commit header is something a more
> recent versions of Git tools started using after the idea gained
> community consensus, or a third-party software unilaterally added
> without gauging or waiting for community consensus.  The same single
> mechanism can be used to extract the information and carry it in
> e-mails, and mailinfo can be told to extract it out.  It can be left
> up to the consumer after mailinfo disects the pieces of information
> out of the e-mail.
>
> > In such a case, I fully agree that embedding in an e-mail header
> > would be the way to go.


Is it another option to put it somewhere in the body? Could we fit
additional headers (e.g. signatures and third-party ones) somewhere
between the `---` line and the additional diff? Or how about after the
final `--` line? I haven't checked the specification. I just saw these
lines in the `git format-patch` output.

> >
> > I would suggest a lot more generic implementation to solve it once
> > and for all.  How about doing it more like this:
> >
> >    "git format-patch --extra-headers" grabs all extra headers
> >    (i.e. those that are not the bog-standard "tree", "parent",
> >    "author", "committer") and emit these
> >
> >     X-git-extra-commit-header: encoding=iso8859-1
> >     X-git-extra-commit-header: frotz=nitfol
> >
> >    next to "Subject:", etc.
