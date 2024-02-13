Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44EE60872
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 20:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707857744; cv=none; b=CGk4sXMjVZSjS/avZGmkXSTUevy+C9SRFc1zdFm6HWwXCk4r2Ag9KxzvqtBJS9ifsgQpw02GLRf9VzD2GXspFByMIDHyX3l6s7+AD+JAGkaTezPwPYekrIVyJGKRufUvNFKYtyWWeynr6T2ukfLtTEKrvsaFwFX2zeJApRNMAv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707857744; c=relaxed/simple;
	bh=+eUDydPUEihJ+fZM42UF1F9RVwckMWqmK+vhTt16BTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KgHQ5WPdWCHLNE4Uhy0wptga+9oDS+XdI7cgyiNfJqaIsuq86SAIEIdFGgQYi97VLsv1CEwOYf1YX2CN6jDnNcyCglCjPM+ELEbyn3jP1xGKjLbWDK/cb5E/T9JuXb1+8B8nhq9Rl+d3O0rbcsxSqUl0Vj5a72Gc+uiefE4lPmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V071c8Pn; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V071c8Pn"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51171c9f4c0so5775091e87.3
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 12:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707857741; x=1708462541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4d1X24TYcGFJk5Vpe0x+L2E0Os/1m+y6KKqFNqNrvo=;
        b=V071c8Pn/K3mVJ81emNaMVGUxHBTojz7803Jq44u0dJYH23yA9bm3EG4vL03Gpdekf
         kEirkXlMdfjkn6YNb5LEcK+MvND0gqfJukILjSveOmAu9aqC6M5h8M0qZuTaUclK9Oah
         hoRHG9vugJax5B90cwaonT12Xz7CY0dmSvKnwdnyFpcVVTs1UCICF88SLib3Gvcgtinj
         XKAHoJggDhXaZ/boTz6D7bgqdNh5/FwpsBJ/A+BFA9IwgLIwD6Ylr2ZBGF69bQkXSAPF
         uj+yJDrf5nX3ZDCSC69vmgJEJ9XnMoukhR/WKRJQrKo0nsOxmCB+yvC0Dljy/YHhaBq1
         FlAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707857741; x=1708462541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4d1X24TYcGFJk5Vpe0x+L2E0Os/1m+y6KKqFNqNrvo=;
        b=NF2uVgv3n9i1l4UApoQOf9JR1mb0/o7AhJXL8avrv6urGzL79aLK5VfUBHalg/Z2RM
         USuMPi4TIxfB7QuTBgwMGGH4Lz0npGTg71idOeL4BpTa4ejxlWFrzcwFr9pXPcuxFunX
         XgKDIBi7dOFqsXKMhJIUfOUrlH9vawqPouxYNXKJBD4VbK53Ms1AF8aGJIcgYa0w5pGi
         Jy09UW0lD1sAdSPX9/DuLsVhhoF4jXZBpeFLgDUoAXitRpwbs3hINso4XiV796cju2g4
         UKnx0TVIY7xuGR23Xc/sTyTb5i58+irrfRAIEVj+l3yT4Mz4T3De7nEFufv+rFB3cZDZ
         DQlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDBOp1mej1mheJkp8SqkIfFUic49WATBCKn8Vpv9u9QRuV3qcvzU+2C53uMC0mRxEB4jNMkzXry4Hbt+S5SiyPYvXi
X-Gm-Message-State: AOJu0YxZPu156u+4l8sO89DUVD+58OiJcB7915oMkRXJfVSS4eOn/pcr
	VYgfz7CAHoRz8UQUfgEETqHJxKvHEteas48MrSfqD5OjoQRge/Zt/jUbqCDe69MZZ7CXR3gvmTY
	SX2FD36xiG8vAOGoC7qaGJrJV0N/P0Xdz+F8=
X-Google-Smtp-Source: AGHT+IEAmuBw7nlJ+7f4ExJxoLTYzkPok5m8j2MMzn4DK9hI2DOFdoty5jTVDg9vlz7ngdw/UCzGmzveySTePoR9fsY=
X-Received: by 2002:ac2:521a:0:b0:511:8748:c3b with SMTP id
 a26-20020ac2521a000000b0051187480c3bmr433230lfl.2.1707857740339; Tue, 13 Feb
 2024 12:55:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
 <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com> <CAP8UFD3qLGua5PTA+i29N+yJH8iKVBPwUn=S606B2E+s959JFQ@mail.gmail.com>
 <owlywmr89ms9.fsf@fine.c.googlers.com>
In-Reply-To: <owlywmr89ms9.fsf@fine.c.googlers.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 13 Feb 2024 21:55:27 +0100
Message-ID: <CAP8UFD1vue6Pdh5rccibyPs179FYxRDS2-pDzOmTzF1vhTE-sg@mail.gmail.com>
Subject: Re: [PATCH v4 00/28] Enrich Trailer API
To: Linus Arver <linusa@google.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Christian Couder <chriscool@tuxfamily.org>, Junio C Hamano <gitster@pobox.com>, 
	Emily Shaffer <nasamuffin@google.com>, Josh Steadmon <steadmon@google.com>, 
	"Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 8:39=E2=80=AFPM Linus Arver <linusa@google.com> wro=
te:
>
> Christian Couder <christian.couder@gmail.com> writes:

> > I took a look at all of them, and I think that this series should be
> > split into 4 or more series.
>
> This sounds fine to me. IIRC this means for the 2nd, 3rd+ series I have
> to remember to say "this series builds on top of the other topic
> branches '...'" in the cover letter. Now that I've written this out I
> will hopefully not forget to do this...
>
> Or, I suppose I could just introduce the 1st sub-series, wait for that
> to get queued to next, then (re)introduce the 2nd sub-series, etc, in
> order. Hmm. I think this will be simpler.

Yeah, sure.

> > Also it seems to me that many patches towards the end of this series
> > should be split.
>
> In hindsight, I fully agree.
>
> Aside: I am delighted with the quality of reviews on this project. It's
> not something I am used to, so please bear with me while I try to break
> old habits.

Sure no worries.

> Thanks.

[...]

> > I am a bit sad that this series doesn't introduce unit tests using the
> > new test framework in C yet. I understand that this series is mostly a
> > big refactoring and maybe it's better to introduce unit tests only
> > when the refactoring is finished though.
>
> This was my original goal as well, and still is.
>
> > Anyway I hope the next series will introduce such tests.
>
> I will see which API functions are stable enough, and add tests
> accordingly (in a patch series sooner than later).
>
> Probably the "biggest" (?) thing that is coming from the larger series
> is the introduction of a complete separation between parsing (without
> any modification of the input) and formatting. The parser/formatter is
> a large chunk of the trailer implementation, so I would expect unit
> tests for those bits to have to wait until those improvements are merged
> into "next".

Ok.

> >> Thanks to the aggressive refactoring in this series, I've been able to
> >> identify and fix several bugs in our existing implementation. Those fi=
xes
> >> build on top of this series but were not included here, in order to ke=
ep
> >> this series small. Below is a "shortlog" of those fixes I have locally=
:
> >>
> >>  * "trailer: trailer replacement should not change its position" (If w=
e
> >>    found a trailer we'd like to replace, preserve its position relativ=
e to
> >>    the other trailers found in the trailer block, instead of always mo=
ving
> >>    it to the beginning or end of the entire trailer block.)
> >
> > I believe there was a reason why it was done this way. I don't
> > remember what it was though.
>
> Noted. I'll see what I can find in our commit history.
>
> >>  * "interpret-trailers: preserve trailers coming from the input" (Some=
times,
> >>    the parsed trailers from the input will be formatted differently
> >>    depending on whether we provide --only-trailers or not. Make the tr=
ailers
> >>    that were not modified and which are coming directly from the input=
 get
> >>    formatted the same way, regardless of this flag.)
> >
> > It could be a feature to be able to normalize trailers in a certain way=
.
>
> True. But doing such normalization silently is undocumented behavior,
> and we should provide explicit flags for this sort of thing. Adding such
> flags might be the right thing to do (let's discuss more when this patch
> gets proposed). FWIW the behavior I observed is that this normalization
> only happens for *some* trailers that have configuration options, not
> all trailers in the input. So it's a special kind of (limited)
> normalization.

Perhaps because we consider that having some configuration means that
the user consistently expects things in a certain way.

> >>  * "interpret-trailers: fail if given unrecognized arguments" (E.g., f=
or
> >>    "--where", only accept recognized WHERE_* enum values. If we get
> >>    something unrecognized, fail with an error instead of silently doin=
g
> >>    nothing. Ditto for "--if-exists" and "--if-missing".)
> >
> > It's possible that there was a reason why it was done this way.
> >
> > I think you might want to take a look at the discussions on the
> > mailing list when "interpret-trailers" was developed. There were a lot
> > of discussions over a long time, and there were a lot of requests and
> > suggestions about what it should do.
>
> I confess I haven't looked too deeply into the original threads
> surrounding the introduction of "interpret-trailers". But all of the
> changes which I categorize as bugfixes above have a theme of
> undocumented modifications.
>
> While working on this (and the larger) series around trailers, I only
> looked into some (not all) of the discussions on the mailing list in
> this area. Instead, I deferred to
> Documentation/git-interpret-trailers.txt as the official (authoritative)
> source of truth. This is partly why I first started out on this project
> last year by making improvements to that doc. And, this is why seeing so
> many edge cases where we perform such undocumented modifications smelled
> more like bugs to me than features.
>
> That being said, I cannot disagree with your position that the so-called
> bugfixes I've reported above could be misguided (and should rather be
> just updates to missing documentation). Let's not try to decide that
> here, but instead later when I get to introduce those changes on the
> list, one at a time. Thanks.

Yeah, it might seem like undocumented features are bad, and I agree
that reading original discussions can be tiring. But if the latter
makes it possible to fix undocumented features by just properly
documenting them, then I think it might just be the best thing to do.
Ok not to decide about it now though.
