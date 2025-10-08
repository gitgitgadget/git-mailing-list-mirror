Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85132F1FE6
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 07:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759908171; cv=none; b=rRABN8CX5BjtZIdv2jayMREdyLY09LFA7d38XaZKw+AZHG4sQ4oBWV14tVPkgw3yag8R+uoGHlDWkLCcFORAe28ZesmYMWVF8a8hfGjBxtG9eoDT126ZV74och+x8wHJZjvfVZaaExuWp0dAHqhMTd3QHNeN5FkU/RI+D0bEVss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759908171; c=relaxed/simple;
	bh=qzTxzwSNDxXZC1B9zQ46Y9a5ppNJdNWnFJrs79Ja8N4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oG0hdY4q7HBtbqBVG7/I1i8wrG7A15d6Nn4nkWGOEmaxuOaJbnQ0Ql0FhUFOck66MTRfKsBWyCKkpZpxKaTK7U1X9GYPobBn/FdGwXzqp3ZkT2siE3W7IOgMGAGICzYi0w9PSjUTbA48fwCap0+FuGcq46h7DuplK/Wn9vzUpkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+6F+vri; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+6F+vri"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b2e0513433bso1101885166b.1
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 00:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759908168; x=1760512968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/9OD7YgdCCTNdLSA4996mS0IWvFqZ6eYd0OpM/P0AY=;
        b=Z+6F+vriQmTTRS7l6rK9l06Hp5b/3Z+7srjN0TGkV2sCUnLory5yEu5g2DNb4X/e91
         Jd8QAvbrMPbWBUCbyS4knwy91hic0tqnfDv4z/l15euLBXQ0pl/SPkWL4y34JeUymJG/
         3zmZPsuVw+sDz02q8lvLN6X14k1iLnz3aM+clxm2Ki/T455kFufTW2Y18fLwKnB0Y1oY
         eU4vuqDZ2wDkekBm5LH01T7GZ5Tb2Qq/wvg6wPveiFaqxXajOLRN6e0Drx2V99lQbo0O
         od9y+fCFsEythGBeTAoMmLhjSNXJTCPcrN9xD9w4yFn5O3m7GEaMdZsrSOVrSt+zs+gu
         2ahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759908168; x=1760512968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/9OD7YgdCCTNdLSA4996mS0IWvFqZ6eYd0OpM/P0AY=;
        b=YtI5KWbzd0WySRl0VyCpTP2/Swm9t72qzj0Q09Jyq58nE9h3MopM94u/xVKg5yLEUB
         0Mds93Nll4V0QgbwpNYa/Y7MPRAaD6usTMPTgqGUFn2rnWk+8ScpQwyw0BGX7EPIHRzl
         HKqpPPbaPhmRJXiu+wUq4OqGAhJqW8UT/R2wpgB/Auxs1owIy9K+7Up5JShzpNkRG077
         PJSw9neP37nFt6l/ZUZjx9Sz++U/CoGQlq91EREdEGjrmtMj1AJcIoTflRnS97BeNkR1
         jb/7Fupxw6EZs6WhogmUPBRc1TZLdGeoWJ5ABuzzwHZh5+fortwS8N3eRy0d0n/2zjRE
         16zw==
X-Gm-Message-State: AOJu0YyRssljd/+UJCHQ+R/1FA5A4z3atGQAUcK2VfO31cpTPxvCKlW/
	7gr0vSJ1abgRlNZbfhgqsJY1z07ESAIz6A3/OpNM7ieajSnq3uX6x2tp2WcVGmFv8k6b8bau80V
	ZpFpDUYBZLpSbXw99LS+rL/7itp2ALuo=
X-Gm-Gg: ASbGncuaMuoANTm8+ICfBjp+oXJ33lAeQ9du12usF8qvNvT5iuT/hWHwupHdtO72Z3A
	5KGy4gkFMzwQ+pIzA3eQuT6GutS//GWuH+2qjiNVK0POZQEu2VhnWVstc33tjqTp+XhHEQdC6Pz
	C8uBEVstGV+ro+psZDvjC+dUCFVd+TZg4p/1M0TE7rCcfNg+hC28Asb321k/Wf2vQDPRK4fnolV
	/sUqPxGrEAZzvUcAhUCpOUv8DX7E+g=
X-Google-Smtp-Source: AGHT+IErORGkOsB8EuGTV2nITPGscJFPvi0Tvcl56rtpVhpGdids77UNEFXrU2x2LuWp8tClB+QDmVw7rF1/FDS9CjE=
X-Received: by 2002:a17:907:9628:b0:b46:abad:430f with SMTP id
 a640c23a62f3a-b50ac5d0873mr216832366b.52.1759908167742; Wed, 08 Oct 2025
 00:22:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcyalm0mh.fsf@gitster.g> <20251001140310.527097-1-christian.couder@gmail.com>
 <xmqq4isi1gpm.fsf@gitster.g> <CAP8UFD3wc-aj27Q_kFXvknJrpa-ySWbZiPmNCTMboA08=HP+xw@mail.gmail.com>
 <xmqqjz1cufcd.fsf@gitster.g>
In-Reply-To: <xmqqjz1cufcd.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 8 Oct 2025 09:22:35 +0200
X-Gm-Features: AS18NWCtWq2yJtcZwBsjhwM2xLA0VZL18Rc6lQdwHakcguFQ7HLveIFZBz332fY
Message-ID: <CAP8UFD0Nrc-ENbjhP_eBmqe9jGyAd4kmp3Bw8b18JbxdC6neVQ@mail.gmail.com>
Subject: Re: [PATCH v2] SubmittingPatches: add section about AI
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, 
	Rick Sanders <rick@sfconservancy.org>, Git at SFC <git@sfconservancy.org>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 6:20=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> >> A milder way to phrase this would be to jump directly to "we reject
> >> what the sender cannot explain when asked about it".  "How does this
> >> work?"  "Why is this a good thing to do?"  "Where did it come from?"
> >> instead of saying "looks AI generated".
> >>
> >> It would sidestep the "who decides if it looks AI generated?" question=
.
> >
> > I don't think the "who decides if it looks AI generated?" question is
> > very relevant. If someone says that a patch looks mostly AI generated
> > and gives a good argument supporting this claim, it's the same as if
> > someone gives any other good argument against the patch. In the end,
> > the community and you decide if the argument is good enough and if the
> > patch should be rejected based on that (and other arguments for and
> > against the patch of course).
>
> And then who plays the final arbiter?

You, like for any other discussion about a patch when there are
different opinions.

> One can keep insisting on a
> patch that looks to me an apparent AI slop that it was what one
> wrote oneself, but you may find it a plausible that it was a human
> creation.  Then what?

You decide if the arguments on one side are better than those on the
other side, again like for any other discussion about a patch when
there are different opinions.

Why should the process be different? It could be different if we think
that such behavior is similar to the bad behavior we talk about in our
code of conduct, but I don't think we want to go there and have some
special procedures, right?

> It is very much relevant to avoid such argument, because the point
> is irrelevant.  We are trying to avoid accepting something the
> submitter has no rights to claim theirs, and requesting them to
> explain where it came from, how it works, etc. would be a better
> test than "does it look AI generated?  to everybody?", wouldn't it?

The sender can ask the AI where it came from, how it works, etc, and
copy-paste the AI's answers. The sender could also prompt the AI or
modify its answers so that they look human generated as much as
possible. So just asking those questions might not help much in some
cases. In the end, whatever the answers to some questions, we have to
be able to decide if the suspicious content looks too much like it has
been AI generated or not.

It doesn't mean that asking those questions couldn't help in some
cases. It means that we just don't want to enter into the details of
which questions we can ask and if we should judge based on the answers
to those questions or something else. For example our code of conduct
says that we will take action "in response to any behavior that they
deem inappropriate, threatening, offensive, or harmful." It doesn't
tie us to asking some questions and taking action based on the
answers.

Thanks.
