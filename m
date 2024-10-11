Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CFB19DF5B
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 16:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728664820; cv=none; b=Ld3ksvBEy03QT+Eh51fL76uYWCzxKTVBQydJ74jLSYOoPH+/OpCYchxYrcjltCjDy1Fi25tZe15pkd1aluf2r/MIqLW1RseQQmgqQGLi4dLpXkU6sHZOL1pLpbC4Puj9Zc+yN4a3wLr+ZifIu9zoE/H55bG46SVYynjzf8lGMTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728664820; c=relaxed/simple;
	bh=+NKtdI6pIh991neTKyVFJL7+EdIUJBnfBTQpZSy4gYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQjBuwegYvlGAVb2PT/TgogvRs2imMbYKyJbsrC+qzM0DPU9Bw0boUPCIlnedqhfn2lPRZHHGt7VrzSHzwLgxYQn6E2Nd8sN5yRTWBJAofkh3XTXU0ru2j8Ags7eP8j+KI7gh3nmVNTbneSp0XXQuysUaO8EgKraDg4XolDn60Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SSKfq0sB; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SSKfq0sB"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4603d3e0547so4061cf.0
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 09:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728664817; x=1729269617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZQWSEu3yllFwe4CxRRoIqzKCvq2OFExztAYZkCQZE0=;
        b=SSKfq0sBd2LIOVIaWookl2Cyr+B8ya4Svv92JiLWPz0rFpKSytztiJyoNLQCoFQv+t
         1WnWBLmjnw6LuFxqJauIMer2agKt3vFEwLJW8lyU83NtDLPKxSWWxNf3B/jiektiyabM
         XOKg29NomO2gSO1lYVSvmudEt5djO5ac+RokeUcKC8WAyr4etof2E4AjJ4dJcbd+jrDz
         Z2RPswCg3GPNunTU+Xgdx0GhaGoMp7fpvDKSDgYTZGRtFliK0pncpSn2CIsPfjhkk71r
         ulnDoun47FhJqxDZueMgQwmy5dGma9aSfLLg59+myFlWSJgV0N+PN6ccRnPpC2eZu3Ql
         qMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728664817; x=1729269617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZQWSEu3yllFwe4CxRRoIqzKCvq2OFExztAYZkCQZE0=;
        b=h1Qo65ND3JWngj62ON38rBaXwxr8fO0tmT0oDq3kAAvpq/EI06jaX4kbXc8sc4Dl1v
         sSK1ObCmkJs7zshhFy3McjvGTnuZpgk0i7L9CHsHCT/dGSO+T4k/8yq7fHGtSdGtmwgG
         Rk5ilAMRri9/sMB3ShValL4piI7FRbUqqjYCc4nHlqlzzRgazqFf8kQ2N3RRY1UFoIjJ
         zKxek39d7nCI6rWAfDwXhMJKzM/+IuTdWE7KzNjprpb25mcdVYXaVAlDqD9sYxp+ZRNW
         Oj/EbxhOaRfq+fKHm5kQSQ88n8QckPnsuoJylaD4E2iL4adX9tE6htYY/OsV1l4RuvBU
         DScw==
X-Gm-Message-State: AOJu0YyuWxUov//w8wiKgpriJtBXKNseCySbKIIuKRYmQ/sp2ew4Lfub
	o+5kaS868z47gtzFkIAw4ag5199VdZIZebA6wfmlI7sGPuk37s5USWkbreGURZhQ8v/0ak1+mVX
	Pl55RDDGxe9/SMoxw+kiy7Ko5gAGH/LNxcjCH
X-Google-Smtp-Source: AGHT+IE28S/x4e60ZxlPaiArW9/7LO5WnLALrP+jGhJewZur+KRLAohrlV6XuUvKwENnxu/IUEAh7NtgcdLehEYQQoU=
X-Received: by 2002:a05:622a:8612:b0:45f:3d5:5a7d with SMTP id
 d75a77b69052e-4604ac30a3emr4652541cf.6.1728664817342; Fri, 11 Oct 2024
 09:40:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003223546.1935471-1-emilyshaffer@google.com> <xmqqset8c0o7.fsf@gitster.g>
In-Reply-To: <xmqqset8c0o7.fsf@gitster.g>
From: Emily Shaffer <nasamuffin@google.com>
Date: Fri, 11 Oct 2024 09:40:04 -0700
Message-ID: <CAJoAoZ=todZ6Ej9CQcF+f-C6vBZ8x-H6VX0dKhJwfvmJyGOW7w@mail.gmail.com>
Subject: Re: [RFC PATCH] promisor-remote: always JIT fetch with --refetch
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Calvin Wan <calvinwan@google.com>, 
	Han Young <hanyang.tony@bytedance.com>, Jonathan Tan <jonathantanmy@google.com>, 
	sokcevic@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for the slow response/page-context-back-in. I'll be working on
this today and try to send a different approach, but after that point,
I'm not sure when the next time I'll get a chance to work on it may
be. If I don't come up with something suitable today, it's likely that
Jonathan Tan will take over the effort from me, but I'm not sure
around when he'll be able to prioritize it.

On Sun, Oct 6, 2024 at 3:43=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Emily Shaffer <emilyshaffer@google.com> writes:
>
> > By the time we decide we need to do a partial clone fetch, we already
> > know the object is missing, even if the_repository->parsed_objects
> > thinks it exists. But --refetch bypasses the local object check, so we
> > can guarantee that a JIT fetch will fix incorrect local caching.
> > ...
> > The culprit is that we're assuming all local refs already must have
> > objects in place. Using --refetch means we ignore that assumption durin=
g
> > JIT fetch.
>
> Hmph.  The whole lazy fetch business looks more and more broken X-<.

By "lazy fetch", are you referring to the partial clone fetch, or are
you referring to the mark_complete stuff? (I know we have been having
lots of issues with the partial clone fetch at Google in the last
month or so, so excuse me disambiguating :) )

> There is a comment in the refetch code path that tells us to "perform
> a full refetch ignoring existing objects", but if an object truly
> exists, there should be no need to refetch, and it starts to smell
> more like "ignoring somebody who gives us an incorrect information
> that these objects exist".
>
> But a ref that points at a missing commit is "somebody giving a
> false information" and an option to ignore such misinformation would
> be a perfect tool fit to sweep such a breakage under the rug.
>
> But is this sufficient?  Looking at how check_exist_and_connected()
> does its work, I am not sure how it would cope with a case where an
> object that is pointed by a ref does happen to exist, but the commit
> that is referred to by the commit is missing, as it only checks the
> existence of the tips.

Is that so? mark_complete_and_common claims that it recurses through
all parents of all local refs and marks them existing, too. Looks like
it does that in fetch-pack.c:mark_recent_complete_commits(), only up
to a certain date cutoff, and doesn't do that at all if there's no
cutoff provided. I don't think I see anywhere else that it's recursing
over parents, so I'm not sure why the comment says that. In fact, I
sort of wonder if the comment is wrong; it was introduced in this[1]
series much later than this code block has existed. But then, nobody
questioned it during the series, so I can also be misreading the code
:)

>
> > diff --git a/promisor-remote.c b/promisor-remote.c
> > index 9345ae3db2..cf00e31d3b 100644
> > --- a/promisor-remote.c
> > +++ b/promisor-remote.c
> > @@ -43,7 +43,7 @@ static int fetch_objects(struct repository *repo,
> >       strvec_pushl(&child.args, "-c", "fetch.negotiationAlgorithm=3Dnoo=
p",
> >                    "fetch", remote_name, "--no-tags",
> >                    "--no-write-fetch-head", "--recurse-submodules=3Dno"=
,
> > -                  "--filter=3Dblob:none", "--stdin", NULL);
> > +                  "--filter=3Dblob:none", "--refetch", "--stdin", NULL=
);
> >       if (!git_config_get_bool("promisor.quiet", &quiet) && quiet)
> >               strvec_push(&child.args, "--quiet");
> >       if (start_command(&child))
>
> The documentation for "git fetch --refetch" says that this grabs
> everything as if we are making a fresh clone, ignoring everything we
> already have.  Which makes the change in this patch prohibitively
> expensive for asking each single object lazily from the promisor
> remote, but is that really the case?  If there is a reasonable
> safety that prevents us from doing something silly like transferring
> one clone worth of data for every single object we lazily fetch,
> perhaps this would be a workable solution (but if that is the case,
> perhaps "git fetch --refetch" documentation needs to be rephrased,
> to avoid such an impression).

Yeah, this is on me for not reading the entire documentation, just
noticing in code that it disabled this COMPLETE cache thingie. You're
right that it would be too expensive to use this way. As I said at the
top, I'll try to send one of the other alternative approaches today.

 - Emily

1: https://lore.kernel.org/git/pull.451.git.1572981981.gitgitgadget@gmail.c=
om/
