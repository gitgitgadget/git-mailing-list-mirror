Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A01176FA5
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 22:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727218468; cv=none; b=MWx4/bag0TOOhQe9dahD+qsG+LwQhSkqZYTfI21yx0uqqf0XFGz6QwVzDFlu8EP+CIGW5xHZXc1OvrXL1pW6+w7+ecPiVRwwC/niraNZDdHFg8+jRvvDjpPT8OeWfuxZoLxqFibDtCyzL6k0qM40Fjy34Bwd1tqYgYYze8ysq30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727218468; c=relaxed/simple;
	bh=E0yx9FQCTdJhQWpmEPbB6KnZUo9P64PSwGeYr3uTpkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SZ03JUeM0yoGYv7R/7ndN+J+iP6EKQEINdal/S6e1krUaUA3q6CuVLCAUmnUiEVm1x3sUks2mAWrU84ThOjOpy6DQ2URT9VbntHxX54pr67x+we0choHkpKpxfBWIyMDV+ThPVxVa86ddRzYbajEBxbdvplxxBinptcNksPQMEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCvD8wy9; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCvD8wy9"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cba8340beso1903805e9.1
        for <git@vger.kernel.org>; Tue, 24 Sep 2024 15:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727218465; x=1727823265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q+1lty4txAIAH+P72gFBf+aoLTWDEJ+VV2/7oe06ln8=;
        b=aCvD8wy9GhZ8Of+Bo5IL8VEd0mIRUwQvbq4NM1yJsoWo2/WmlB+Lmq9Q3L/V7eExts
         JdQu3iS/XGrHq5eghaIt6HBBLy7g6NGJy3qBiIKej4I8vLkFE2LerF2rB/YevQLvdMs7
         cpjZZlX5mSw8zFbBfyjVPR03mQrSLo9c+TSNcFlTs60GpS84aV58edR2IQonp3FmRK/m
         W0dez2Ip7dFdjvghnetkhgWUiumVh5w5yvaeZJZL56CPulEcqy1RH3ivCc++FVhBRiY1
         vTYyvJd5kz71u3sl+SyIq9p6DbdvkZKKx+OHQA47Br5YIm6IxiQpaYQfmqGwQ1KwQmFM
         5zzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727218465; x=1727823265;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+1lty4txAIAH+P72gFBf+aoLTWDEJ+VV2/7oe06ln8=;
        b=ApqJJXhtoeywC0VBWkzztjA+ETBnHv+IH3eKC/RsOXRJzddDSvYAJVRQB9bwBpfQGf
         Za2z4vqftYU2w08EH1zpThT+KEMtnpMFA0gJ/uCO4wemIVMCTZsM/3hgDtIfB3+590MJ
         4yqygfNDbLLaMw51uVaDkS+fVo6wypODNF8BfuqrZv/43C0H20GgZstbXIrmBalb0kU9
         qD8RggwS3if48fq+NM1rOFW2dPmYwVG90yMd/UAkwWoX9EkS4gPg3QxYWhW+K4TaQtzz
         0AxvfHw9hufiPHlKIwxEy/XGqigoHalcvx0wP2mKMjf4rfntz7OCh2KNiu61en5C//Wt
         6JNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdjf4Utsb1FfbxHS8yeYPFqCKxeThhscdO2HbtsRw5r+hV2M79D411rcr42yPn+5zjjJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YweFDUvtljRy1Hq3BfX9TT59f6xjZ/F6jQ5jrgeuvyth/t4rU47
	1sZkuvBpE39sz4GpNMLMkz+HES7gAypYkB3cAP2apGczE6oLccFV
X-Google-Smtp-Source: AGHT+IEWWeQ2sDWAt+YjmvtJb5bMQqkyFwo95Mp4079LXhuWHwrzq8epHgCSSxey0GXyTuOtEt9SOw==
X-Received: by 2002:a05:600c:3c94:b0:42c:b991:98bc with SMTP id 5b1f17b1804b1-42e8f313f96mr27548165e9.0.1727218464232;
        Tue, 24 Sep 2024 15:54:24 -0700 (PDT)
Received: from gmail.com (93.red-88-14-201.dynamicip.rima-tde.net. [88.14.201.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a07e69sm1325455e9.21.2024.09.24.15.54.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 15:54:23 -0700 (PDT)
Message-ID: <6f392446-10b4-4074-a993-97ac444275f8@gmail.com>
Date: Wed, 25 Sep 2024 00:54:22 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] add-patch: edit the hunk again
To: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <21ddf64f-10c2-4087-a778-0bd2e82aef42@gmail.com>
 <4dd5a2c7-26a8-470f-b651-e1fe2d1dbcec@gmail.com>
 <2ad1f7b1-714c-4d6e-89a6-fd65271222b9@gmail.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <2ad1f7b1-714c-4d6e-89a6-fd65271222b9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Sep 23, 2024 at 10:07:08AM +0100, phillip.wood123@gmail.com wrote:

> Thanks for the re-roll. I'm still not convinced that changing this without
> keeping an easy way to get the current behavior is a good idea.

Thank you for maintaining an open attitude and helping make the change
reasonable.

> 
> On 18/09/2024 18:51, Rubén Justo wrote:
> > The "edit" option allows the user to directly modify the hunk to be
> > applied.
> > 
> > If the modified hunk returned by the user is not an applicable patch,
> > they will be given the opportunity to try again.
> > 
> > For this new attempt we give them the original hunk;  they have to
> > repeat the modification from scratch.
> > 
> > Instead, let's give them the modified patch back, so they can identify
> > and fix the problem.
> 
> It's still not clear how an inexperienced user is meant to do that.

If inexperience refers to the user not being familiar with the patch
format, I don't think it's something we should worry about.  It is
very likely that few users will attempt to (e)dit, and those who do,
inexperienced users experimenting, the normal (and sensible) path they
will follow at the slightest difficulty will probably be to abandon
patch editing and try a more accessible option, such as: cancel the
`add -p` session, edit normally, and restart the session.

If inexperience refers to users unfamiliar with the (e)dit option but
knowledgeable about the patch format, I believe they will have enough
experience to know that reconstructing a patch is a tricky task.
Again, the most likely path they will follow when encountering
difficulties will be to restart the edit (Junio's message in the
thread is an example of this).

At any rate, although I understand the concern, this series doesn't
aim to improve the mechanisms that help identify the problems in a
faulty patch.  The goal of this series is to offer (actually to
recover) the possibility for the user to make corrections.

Something I haven't mentioned before in this thread is that currently,
if the user makes a mistake while editing a patch, we don't give them
the opportunity to review their error.  We leave them in doubt.  This
happened recently to me editing a patch with context lines containing
whitespace errors and "whitespace=fix".  But that's another story that
I still need to work on [1].

So, to me, it seems sensible to let the user review the faulty patch,
even if it's only to discard it.

> 
> > If they really want to start over with a fresh patch they still can
> > say "no" to cancel the "edit" and start anew [*].
> 
> This is not very obvious to the user,

It has been so for a decade...

Keep in mind that this message will probably only be shown very _very_
rarely to users who are most likely very familiar with (e)dit.

> it would be much better to give them
> the choice when we prompt them about editing the hunk again.

That's an option I explored but abandoned.

I didn't come up with any message that I liked that wasn't literally a
long paragraph.

In the end, I gave up in favor of what I believe is a better option,
which is recovering the original intention of "no".

I'm not against the option you propose, I'm just not convinced that
what we already have, since ac083c47ea (git-add--interactive: manual
hunk editing mode, 2008-07-03), isn't intuitive enough for the
users of (e)dit.

> We've been
> giving the user the original hunk for the last six and a half years so I
> think it's a bit late to unilaterally change that now.

For me, this isn't a reason not to make the change.

> 
> > diff --git a/add-patch.c b/add-patch.c
> > index 557903310d..75b5129281 100644
> > --- a/add-patch.c
> > +++ b/add-patch.c
> > @@ -1111,7 +1111,8 @@ static void recolor_hunk(struct add_p_state *s, struct hunk *hunk)
> >   	hunk->colored_end = s->colored.len;
> >   }
> > -static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
> > +static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk,
> 
> I would add
> 				const struct hunk *backup,
> 
> here
> 
> > +			      size_t plain_len, size_t colored_len)
> >   {
> >   	size_t i;
> > @@ -1146,6 +1147,10 @@ static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
> >   				      "addp-hunk-edit.diff", NULL) < 0)
> >   		return -1;
> > +	/* Drop possible previous edits */
> > +	strbuf_setlen(&s->plain, plain_len);
> > +	strbuf_setlen(&s->colored, colored_len);
> 
> then we can restore the back up here with
> 
> 	*hunk = *backup;
> 
> That would make it clear that we're resetting the hunk and would continue to
> work if we change struct hunk in the future.
> 
> >   	/* strip out commented lines */
> >   	hunk->start = s->plain.len;
> >   	for (i = 0; i < s->buf.len; ) {
> > @@ -1157,12 +1162,13 @@ static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
> >   	}
> >   	hunk->end = s->plain.len;
> > +
> > +	recolor_hunk(s, hunk);
> > +
> 
> This means we're now forking an external process when there is no hunk to
> color. It would be better to avoid that by leaving this code where it was
> and restoring the backup hunk above.

I don't see that external process. ¿?

After reviewing the code in the previous iteration, based on your
comments, I concluded that `recolor_hunk()` makes more sense before
the "return 0".  Even if we end up discarding this series.  I think.

> 
> >   	if (hunk->end == hunk->start)
> >   		/* The user aborted editing by deleting everything */
> >   		return 0;
> > -	recolor_hunk(s, hunk);
> > -
> >
> >   		/*
> >   		 * TRANSLATORS: do not translate [y/n]
> > @@ -1289,8 +1290,14 @@ static int edit_hunk_loop(struct add_p_state *s,
> >   					"Edit again (saying \"no\" discards!) "
> >   					"[y/n]? "));
> 
> I think we should make this a three-way choice so the user can choose to
> keep their changes or start from a valid hunk.

As I said above, I don't object to this, but I'm not convinced it's
necessary.

> 
> >   		if (res < 1)
> > -			return -1;
> > +			break;
> >   	}
> > +
> > +	/* Drop a possible edit */
> > +	strbuf_setlen(&s->plain, plain_len);
> > +	strbuf_setlen(&s->colored, colored_len);
> > +	*hunk = backup;
> > +	return -1;
> >   }
> >   static int apply_for_checkout(struct add_p_state *s, struct strbuf *diff,
> > diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> > index 718438ffc7..f3206a317b 100755
> > --- a/t/t3701-add-interactive.sh
> > +++ b/t/t3701-add-interactive.sh
> > @@ -165,6 +165,19 @@ test_expect_success 'dummy edit works' '
> >   	diff_cmp expected diff
> >   '
> > +test_expect_success 'editing again works' '
> > +	git reset &&
> > +	write_script "fake_editor.sh" <<-\EOF &&
> > +	grep been-here "$1" >output
> > +	echo been-here >"$1"
> > +	EOF
> > +	(
> > +		test_set_editor "$(pwd)/fake_editor.sh" &&
> > +		test_write_lines e y | GIT_TRACE=1 git add -p
> 
> This is still missing "n q". Apart from that the test is looking good.

I've been resisting the idea of "completeness", because I think "e y"
should also be fine.  But I'm not going to resist anymore here :-),
since I don't think the test has much more value without "n q".  So
I'll add it.
