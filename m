Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BB079D0
	for <git@vger.kernel.org>; Tue, 28 May 2024 00:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716857258; cv=none; b=Nqv9gkktGRnJoVx2nJurue18y0Vr3ftJFZ4X5xh8WVd4LHYqjjbYP/H1+GquKd6TAXYKgTCV0cLmjO5qwM5PB0AVGdAXh+RucB2/EcMF0MFGG6cpaxe1WpmvdyOoQKSyDtF0YpAX7q4rRRFZa5Jh7xIjc+soRl6xnXmy/OmkQ0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716857258; c=relaxed/simple;
	bh=bnuSIz1bl8Xvxx2ULJ5UATLGw3XHY2i5ntGQhA2iGSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YV9qs+o29Xygo6zZuPy7zkX7ZbltwaFuaQojmBYtG3bAEuNSGqH1R0ud0pnyhpMduXk5abmUSXXfVaq/A96C3RjyDPT/suJLdmdTpd1/8yWD+3CNU8jmek2U4jSxg4GVZeuAd4ZAtxt48C9AbR7ARAdewY1pw/leQ9GfND+bSYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=innwSVSV; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="innwSVSV"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-62a08099115so2894097b3.0
        for <git@vger.kernel.org>; Mon, 27 May 2024 17:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716857255; x=1717462055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFX2twxAQ/CjJ2KTSVTAJSatjtX98VVmFyCQM5a/Io4=;
        b=innwSVSVO7LyTzClAsrFCKLSev2F4WaDCixfKvXuXO1h4zw4rY2qgqd6tKeQ2M1dr8
         NX5boTlB5gWJY71UpXtOkXt0mhzpPE5BX732Djk8GuUYIgwvrBToXrkxrD0uSTQs1GJT
         j8aRlzhajIZSIwtTUhtC2YzCsB2urZKQ4QC9mG6TfsDwklAoA+F5t8JD9h31LttkQZam
         6kgn3Jerd6sk9ySFXsJKXWcHW1L16FoejJTf09/nf2rcLsaTfgxTuejWo4gv6+5DuLGi
         OUPYtUcx2iFnd6bXvsOg9Dz1ay1zNuyn2NRV2Tvh+EDzeiwM8QbeDhkuVGxcMW1THrBS
         wFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716857255; x=1717462055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFX2twxAQ/CjJ2KTSVTAJSatjtX98VVmFyCQM5a/Io4=;
        b=U9zXZfHKz9Bsjn4BqSOtRQyDzis82bMqZ0JIfb4McnkHRyDzwK71C4tNn3F5F5q8OP
         UmilDDiI7PMD7xf6TD/fUkXVxeiJbbrDv9NArUmng0SV5rUm6GkmLHESyZgOEg4VAyDh
         C+jLPR5El09jcKzBdaZjRJXig5ZZ1taIkwGKp3YXFBevmhus2Fi9FN4bYxqECzJUMR62
         iMUDYRY1sZkR6HRZ/4upQvam4VkalNPTPSAlqSu9dXVtmbG38ZLuFzve94Z83ZK2smsY
         9OD8Yvq6b+6I/OZ7BA5v+Brg0Lhvpt58H3AA/tN8RxxdqljgMRrAKg0UNI0Pb8oFABz4
         /Tpg==
X-Forwarded-Encrypted: i=1; AJvYcCWZIEI6OK9T7Y1mGvsOYHFEGvg2fjIx5wupx6J4HaIHRPkaZ2s2AEdz4TOQVOLyjMaknYWRuFRkNDrCAC9ozty1eCvo
X-Gm-Message-State: AOJu0YzKjqwq8kfCg0IleubMXTlG+aRalkIU8xvH2mfOPeJdGsWZhx8q
	b06jWO0S771dLtWPHOX9qziuHoA54Q6C+WMYhK8GtrT8mQW38MCTcr0jehesbHOShIlIsH0zjZG
	Ixe5L9U5DTHfvi7gOgNAkIrb7+9w=
X-Google-Smtp-Source: AGHT+IG0WiUhj58h8ui5Kjh3Hn/uVDcahcKpww3pSp3mribZiF/kY1IKod39CLNB7r18/hOGX0NGp25OPn0V6VjKUE0=
X-Received: by 2002:a0d:d894:0:b0:614:2687:5e18 with SMTP id
 00721157ae682-62a08f3c4b2mr96061187b3.48.1716857254938; Mon, 27 May 2024
 17:47:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq5xwa1pfl.fsf@gitster.g> <20240525122514.2608-1-ash@kambanaria.org>
 <xmqqzfsb86le.fsf@gitster.g>
In-Reply-To: <xmqqzfsb86le.fsf@gitster.g>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Tue, 28 May 2024 08:47:23 +0800
Message-ID: <CANYiYbHigLbVumfqOF6zMWkRKnthUr-NsOPzPBiv_Q-iaOYZBg@mail.gmail.com>
Subject: Re: [PATCH 2 0/1] Allowing localized substitution hints in parse-options
To: Junio C Hamano <gitster@pobox.com>
Cc: Alexander Shopov <ash@kambanaria.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 2:14=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Alexander Shopov <ash@kambanaria.org> writes:
>
> > I hope this time patch submit is better.
> > Requests for changes from previous review should be handled.
> >
> > parse-options.c contains functions and macros to print messages with
> > terms optionally enclosed in chars promting substitution to users such =
as:
> >
> >   blah-blah-blah <TERM>
> >
> > Since languages using different alphabets or writing systems can transl=
ate
> > the term in an obvious manner to prompt the user to substitute them, I =
expose
> > these character to the translators so the messages can use the same sty=
le as
> > elsewhere in git.
>
> Most of the above explanation, starting from "parse-options.c
> contains... " should replace the proposed log message of the main
> patch [1/1], I would think.  Very clearly written.

Typically for a topic with only one commit, it's not necessary to
provide a cover letter but provide details in the commit log instead.

>
> The explanation after "such as:" needs improvement, though.  Are you
> trying to highlight that an explanation is spelled with dashes
> between words format?  Are you trying to highlight that the used
> term is capitalized?  Are you trying to highlight that the term
> comes after explanation?  The answer is none of the above, but it is
> not easy for readers to guess.
>
> One way to make it easier to follow would be to use a more realistic
> example.  The whole proposed log message may become like so:
>
>     parse-options.c API can show help text for an option that takes
>     an argument.  For the "--author" option that takes a name, for
>     example, the program may define the option like so:
>
>         OPT_STRING(0, "author", &au, N_("author"), N_("override author"))=
,
>
>     When the command is run with "-h" (short help) option, the above
>     definition is shown as:
>
>         --[no-]author <author>    override author
>
>     As the program does not accept translated option names, the
>     first part of the above, "--[no-]author", is given as-is, but
>     the string "author" in a pair of "<>", and the explanation
>     "override author" may be translated into user's language.
>
>     The user's language may use a convention to mark a replaceable
>     part of the command line (called a "placeholder string")
>     differently from enclosing it inside a pair of "<>", but the
>     implementation in parse-options.c hardcodes "<%s>".

I guess the reason some people don't like the markers of placeholders
(such as "<" and ">" characters) is that such characters have special
meanings (used as IO redirection) in shell programming and they can be
replaced with safer characters for languages other than English.

>
>     Allow translators to specify the presentation of a placeholder
>     string for their languages by overriding the "<%s>".
>
> > Comments to the translators are shorter than before but hopefully they =
are
> > not cryptic.
>
> What is cryptic here is what "than before" refers to---compared
> what?
>
>   ... goes and looks ...
>
> Ah, this is an updated patch for an earlier attempt
>
>   https://lore.kernel.org/git/20240421191458.5411-1-ash@kambanaria.org/
>
> Thanks for sticking with this topic.  Very much appreciated.
>
>
