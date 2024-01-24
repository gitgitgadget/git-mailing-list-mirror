Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B0B46B4
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 03:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706066429; cv=none; b=bMEdPK5uj+0wVYTvWQIplLRe9v9CmqppHvkV/dHrUnpZRLCeGnNHuGHBC+LqWU+V2iRo/cdMR6s4cmC7PxaGOK+soM1Ckx8prJysuyN2Vrw5+Sulz1JwyL37kzA61RRPRxD7Z7xj+8cC3QteFdkMH6j2F2ZPpB1wEapFFdIhRAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706066429; c=relaxed/simple;
	bh=9cA0CjIrWnVAMHF1E+JRA3wQtnC1XT6/1nrrhnw5gjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xq9aIvQ5hxA3SoqcgQbzYRH+OtNs8r78LFsSJ0XSeJI+MydqZ56ZY2j1lFKPsSLt1zQFA4+PUNjLuvSrdhjyGDD+mq6ZlK29Bq5l50LLKKgnhHQIzNneTTIlaNFYW9tSidloiHkvHcVFBpfCYuqHfuTH1HmET7803SfBmfKLBVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6QAT7oq; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6QAT7oq"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cf206e4d56so1558171fa.3
        for <git@vger.kernel.org>; Tue, 23 Jan 2024 19:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706066425; x=1706671225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7xGeZ2b1tDn9x9XkU94+dERsnfjQ2OXVqveyow5bLo=;
        b=A6QAT7oqYJwZKRkPn/okxKSzAwq/N15sUIuNRQknj0240on8KFOQJaWgKcVLvYr1jO
         r8iZFcQFvX4A0AqRC+f4FtDYkDLTFyBNYQwP4OgygJ0+Xq1pXOU5MuW075vCitj3fXgC
         cN7r1vMTnRon2bANh/Oh7i710iyyfuXnw2ZT/Ire8lpPYzHUpriaROV+Ml6eK5rWmO6e
         NDmMwmtVQFy5TppvHkAce9coxjq7vOqdqV00GwAimAVEYYC+FLlP6kiPej6uNwK9lSic
         e3fC+rKtM22t+nRWukVmn0q+aVwR9RoidR3642Ucu6rhhH3Ojo+deI0ItV+s6WMdKsOW
         K3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706066425; x=1706671225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7xGeZ2b1tDn9x9XkU94+dERsnfjQ2OXVqveyow5bLo=;
        b=XLJ8t7nLlq2fgfrTWZzh2Uk9B95Rxnm0bGLjaNudp/vMI5Hzqx2IvU8jA4gFKlZLjA
         dRWn9Sz7ZcS2YgueOe48FuPe/kET7RQ+OmDRjlmuYYDPfLg/zplzD1twh3RQURP9Xz9q
         ATsja8WdxvvKID9duYiCnYRwKBsZjevXSHfHqUzgNCONL282rmWWgdJKPonk0BBtPFiz
         aMfUvip1xnW6BrBqSuomgG5dMDuh3PYOIIky5EPaD8qykjqkgFwiO1XJ+T0U1S6O0yJk
         Q3d4aE+KmcNy/TZ1nYrUhAiDejjm/XQOmRji92FbCTqXyesdkhzEacZh+HhXFajBW+lX
         6B5g==
X-Gm-Message-State: AOJu0YzTCbreX4K2qHOW0ZnlxVnF47Q0oL0fZ/0ANAlmlknidTvFTM0c
	aoZ/7ofhk1p/JAa0LLz5kN7AeZ9CmlxrfIaw7E98DdzZq85EEujy173Wu4D/kj1xRehI6gnwFdC
	ln7rl0vxs47cZWMuUTVE4Kg3mACA=
X-Google-Smtp-Source: AGHT+IFAKGfAm9WaN/9IlyCyUzA1Up8NLh7MeO1ndyWec4Z3LgWOrMfzRiWJ1v8TK4RVWBm1mO57cJMBTC/H7+0fO2w=
X-Received: by 2002:ac2:5e83:0:b0:510:5b0:6cc6 with SMTP id
 b3-20020ac25e83000000b0051005b06cc6mr596068lfq.94.1706066425044; Tue, 23 Jan
 2024 19:20:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705659748.git.ps@pks.im> <ae2df6316f79e372c51d59666d685e59981d2f98.1705659748.git.ps@pks.im>
 <xmqqjzo5jf79.fsf@gitster.g> <Za5HOkWM3IQIiKDJ@tanuki>
In-Reply-To: <Za5HOkWM3IQIiKDJ@tanuki>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 23 Jan 2024 19:19:00 -0800
Message-ID: <CABPp-BG1vA7B9iqLMAq8HnwgA_J6XsbSCa0dEH0PAkWQajP3Uw@mail.gmail.com>
Subject: Re: [PATCH 3/7] refs: convert AUTO_MERGE to become a normal pseudo-ref
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 2:45=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Fri, Jan 19, 2024 at 11:28:10AM -0800, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> > > In 70c70de616 (refs: complete list of special refs, 2023-12-14) we ha=
ve
> > > inrtoduced a new `is_special_ref()` function that classifies some ref=
s
> >
> > "introduced"
> >
> > > @@ -4687,10 +4685,17 @@ void merge_switch_to_result(struct merge_opti=
ons *opt,
> > >             trace2_region_leave("merge", "record_conflicted", opt->re=
po);
> > >
> > >             trace2_region_enter("merge", "write_auto_merge", opt->rep=
o);
> > > -           filename =3D git_path_auto_merge(opt->repo);
> > > -           fp =3D xfopen(filename, "w");
> > > -           fprintf(fp, "%s\n", oid_to_hex(&result->tree->object.oid)=
);
> > > -           fclose(fp);
> > > +           if (refs_update_ref(get_main_ref_store(opt->repo), "", "A=
UTO_MERGE",
> > > +                               &result->tree->object.oid, NULL, REF_=
NO_DEREF,
> > > +                               UPDATE_REFS_MSG_ON_ERR)) {
> > > +                   /* failure to function */
> > > +                   opt->priv =3D NULL;
> > > +                   result->clean =3D -1;
> > > +                   merge_finalize(opt, result);
> > > +                   trace2_region_leave("merge", "write_auto_merge",
> > > +                                       opt->repo);
> > > +                   return;
> > > +           }
> > >             trace2_region_leave("merge", "write_auto_merge", opt->rep=
o);
> > >     }
> > >     if (display_update_msgs)
> >
> > We used to ignore errors while updating AUTO_MERGE, implying that it
> > is an optional nicety that does not have to block the merge.  Now we
> > explicitly mark the resulting index unclean.  While my gut feeling
> > says that it should not matter all that much (as such a failure
> > would be rare enough that the user may want to inspect and double
> > check the situation before going forward), I am not 100% sure if the
> > change is behaviour is acceptable by everybody (cc'ed Elijah for
> > second opinion).
>
> We only ignored _some_ errors when updating AUTO_MERGE. Most notably we
> die when we fail to create the file, but we succeed in case its contents
> aren't written. This does not make much sense to me -- my expectation
> would be that we should verify either the complete operation or nothing
> of it and ignore all failures. Gracefully leaving an empty file behind
> is a weird in-between state, so I'd claim it's more or less an oversight
> that we did not perform proper error checking here.

I can confirm it was indeed just an oversight.  I like your change to
make this code more careful.
