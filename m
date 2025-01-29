Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B004823DE
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 06:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738132356; cv=none; b=W++930L09TAV8OIJKRKf25POgyUgGihVolfgEnEyAfSfNT7dp4/Xxb8u1bqIVnVlU1WM26Z74hmlKQvtHodchq6uKpMUEWQP+go+vhQCsc5GXPrt3qMKF8vOzLSadiehbg0+OkWEccH9iyOEaFNkPINlIL7S6h8RQJWSYJcAkfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738132356; c=relaxed/simple;
	bh=4znraXDvrlh0/pTO5D0kZR0N1KHD1HpLTdL9f3etc44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HGW1qZ23ujWJ/IyO+VVUmdEPV3nlyfjoNG0e+/mfXQwqiDzb2HpeejY36V40ZJLSTJT687HfiXoBJbUWnCYVaxAZcKBV2vFXlS2Jv2efUAiAEHvnTbWfHRKCH2Ta6Et0BP7ZQwCaRoE3KjcB6pkJB8hReH9EKSmsJmx5JmaJTQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yt5UcL/0; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yt5UcL/0"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5401bd6cdb4so7038612e87.2
        for <git@vger.kernel.org>; Tue, 28 Jan 2025 22:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738132352; x=1738737152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOxL/GU+cbX9VNn7WDtPbBpAD6TX4ktIFGcEoQK2V2U=;
        b=Yt5UcL/0WBmNZzw+pnXhUEs1p8nWn3ZSKmQ9j+oRCKEhNRvBBZXafFMQ4QUAuFywuD
         S6QPlVKxVrrJAXgAaHuCmK+Y6QMehV4/4UYqWDdielg7sP/i9BAE3pe3fpKeohV2YwTF
         E8+AVgZpO2cmcGvKckmFHoI+wQgvbqP1gDOPHHh4lrsMxXOzGfw3Nc2V9s+jxHcYP2jB
         M8Pl7VBo07scfF6esr/UPRN+PVaM4WEU+ySzrxVsFiVtG1KbxeAKetX4ez0IHgZ8FbIT
         dvrT8l6qdTvmor8QWfSNvm0X7xhZQ+VUSJfgFS39LrCTFGn/v3I9SdWWrJxGVNxsF7oy
         Zytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738132352; x=1738737152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOxL/GU+cbX9VNn7WDtPbBpAD6TX4ktIFGcEoQK2V2U=;
        b=ju8o1b2dTg8wPuZMrcz33gQA3HF6CRslIzjZ2vl251q5DZDCcjIVw1azu0+SUmZWFU
         Mw5rQeGB+qVIiYgHfQAi0rqu4HMC/iJxHonMiWhMZFxVp9zexgE6p3SNrKHnRoAuoWsY
         f7aH2P2vPDeqt0iBAZ2K7zipH3V7w9tdkZrOqnKu9frMNgKOwZUbdSinPo9asxDfsy/l
         Z5IE0iORfi+Qnaw8pZDGH6cx4t23KE73vJq2mwP2CFdiyJG0PjpkoKG9Foy62jBbEggU
         NbR/7SmlPWnrfwMT48O/ShFaPM9UejShXbf5dTThpNSAlG3K0qs10Py9WVM+NAZQyYQf
         r/9g==
X-Gm-Message-State: AOJu0YxalxKGl+FlmU6orLa2iB/WCJFBZx+wvTc1utDb4BS0+Ca7lVvv
	UyPfIQVuMa+Ix1Hkv0SWw1na9l3jUp8VHixF4kmnXTd8f/rQe6lPgzrsinpNmw+3H0+/xeogXGd
	MyUAIAZZTmoZhy9CmUWh0SWcoJU0=
X-Gm-Gg: ASbGnctkVVK2L2myD3mCRFS5X1XyTXvArHUsOPOabiS+AQ0TLIc4hktnGOtUBr+Bdm4
	FEM05Rq+W/46LHMVv2YoHrUhiQ2MlMVJDHKz2vNXG4O9+EYuAekH16Xze4WjUdOcQHjhD1DiCo5
	A=
X-Google-Smtp-Source: AGHT+IG+PhvMepmbH6ACeZFVEbhbshqF1IyhLcM994YNEaGwJiazBKCzyt6+cZ6BxNVSX0sLIZl2F2pJhcVkFAB1BrQ=
X-Received: by 2002:a05:6512:2389:b0:542:9a0a:131c with SMTP id
 2adb3069b0e04-543e4bdef4dmr521681e87.11.1738132352014; Tue, 28 Jan 2025
 22:32:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127103644.36627-1-meetsoni3017@gmail.com>
 <20250127103644.36627-3-meetsoni3017@gmail.com> <xmqq7c6grrdl.fsf@gitster.g>
In-Reply-To: <xmqq7c6grrdl.fsf@gitster.g>
From: Meet Soni <meetsoni3017@gmail.com>
Date: Wed, 29 Jan 2025 12:02:20 +0530
X-Gm-Features: AWEUYZlU4hPafNTdRbo4_TSqOxqNItvkdXpMtcou7dQu1kvwSyx2ClSTvjJT8nw
Message-ID: <CAPhwyn110E39uksCbSNYy3wRrxmG2QuuXEvPRrUT2SSTLxCKcQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] refspec: relocate query related functions
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, shubham.kanodia10@gmail.com, 
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>, Nipunn Koorapati <nipunn@dropbox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Jan 2025 at 00:55, Junio C Hamano <gitster@pobox.com> wrote:
>
> Meet Soni <meetsoni3017@gmail.com> writes:
>
> > Move the functions `query_refspecs()`, `query_refspecs_multiple()` and
> > `query_matches_negative_refspec()` from `remote.c` to `refspec.c`. Thes=
e
> > functions focus on querying refspecs, so centralizing them in `refspec.=
c`
> > improves code organization by keeping refspec-related logic in one plac=
e.
>
> I think query_matches_negative_refspec() is appropriate named (not
> that it matters much, as it becomes a mere private helper in the
> file), unlike the ones in the first patch that are suboptimally
> named.  query_refspecs() could probalby lose the plural 's' at the
> end---there is only single refspec, which is a collection of refspec
> items, involved and it makes a single query---but otherwise it also
> has an appropriate name (this matters a bit more, but not that much,
> as it was already public).
>
> query_refspecs_multiple() is not a great name, though.  It does not
> convey what is multiple.  Does it make multiple questions in one go?
> Does it ask a question that can have multiple answers?
>
I agree that the original names are ambiguous. query_refspecs_multiple()
is similar to query_refspecs(), but instead of returning the first match, i=
t
collects all matching results.

To improve clarity and consistency, I=E2=80=99d like to propose the followi=
ng
renames:
    *query_refspecs() -> find_refspec_match()
        `find` better describes its purpose than `query` and `match`
        clarifies that it=E2=80=99s looking for a single result.

    *query_refspecs_multiple() -> find_all_refspec_matches()
        Unlike the previous function, this one collects all matching result=
s
        instead of stopping at the first match. The new name highlights tha=
t
        it returns multiple matches.
Let me know what you think!

> > Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
> > ---
> >  refspec.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  refspec.h |  16 +++++++
> >  remote.c  | 122 -----------------------------------------------------
> >  remote.h  |   1 -
> >  4 files changed, 139 insertions(+), 123 deletions(-)
>
> > diff --git a/refspec.h b/refspec.h
> > index 891d50b159..d0788de782 100644
> > --- a/refspec.h
> > +++ b/refspec.h
> > @@ -30,6 +30,8 @@ struct refspec_item {
> >       char *raw;
> >  };
> >
> > +struct string_list;
> > +
> >  #define REFSPEC_FETCH 1
> >  #define REFSPEC_PUSH 0
> >
> > @@ -84,4 +86,18 @@ int omit_name_by_refspec(const char *name, struct re=
fspec *rs);
> >  int match_name_with_pattern(const char *key, const char *name,
> >                                  const char *value, char **result);
> >
> > +/*
> > + * Queries a refspec for a match and updates the query item.
> > + * Returns 0 on success, -1 if no match is found or negative refspec m=
atches.
> > + */
> > +int query_refspecs(struct refspec *rs, struct refspec_item *query);
>
> This one now has an excellent comment.  Great job.
>
> Thanks.
