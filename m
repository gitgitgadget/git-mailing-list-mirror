Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1052A12CDA0
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 08:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707209591; cv=none; b=E8eC96fsCUdqET9f5lWe5Bc3hh6ZULqeAWx4Qnocz5du/VYLFGs2QLQZ3Th6ZjJTfyDC+ZZxuVUIx/ZKYYrKJXwXWMD7svNU9f9hOeD45Q9pigncFXmxaZ2l1ZsaxTYFa9PRl+qWHncoQ1gcOo36utV46O1YIutGWIRmq3IRIXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707209591; c=relaxed/simple;
	bh=eymLCw8lrAGCQWk3wwy68YMNlvkn+BQfMp0fb6xaVkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f3lBujg/rMB4fyVNh0DmnbekJeopFabPZ3g6/n8PS11cxrjAwnkqKCtNgrdaDSuUxBSlRzhm53eVRkji/nJLhyjOKUOTVGKfqF6YuCbeq9hdT3F8qE89IUOKj5Icqk1AA3akS8ZVNdxAlWtJc79iLafJkNgtXW+JBGBY4EcVo80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5NgQrzd; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5NgQrzd"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-21922481a2fso2774406fac.0
        for <git@vger.kernel.org>; Tue, 06 Feb 2024 00:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707209588; x=1707814388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ynLE9hjrh625fdZ/zNL54rW88cn+rSEWuJX9ia2Wbs=;
        b=e5NgQrzdHjV1l23JTvLJyGfR0Bhb1hscwGQIJfwWymTY8zk3E3unGRcTWSMG+wBbGj
         qdieWjV5aHK0YPrgwzD5x5R0qVKucq0C2tN7ezMQk6mOMHwgoUkSMQqgU7DuwFKZq6Dv
         Vf3PTXKeL41qKvjx0ynpUpa0UqglZWCW2GVs/WwdaNavdPhxvOEsJ0SZ2Tb5Fu3gAaCL
         MmuVx63azH5TL7wJlzMW5k8NcjsrpZBiEVF8/8Q+0BEybtOdDXcTD2IVpmbLBUPuxdpI
         1e+Cn3m0/YbW2Q00Sl9W+/7f+kBQvGf/qNnAerxC7o7kUuUnhz9vukaFBcu5YbHHZI/e
         IBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707209588; x=1707814388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ynLE9hjrh625fdZ/zNL54rW88cn+rSEWuJX9ia2Wbs=;
        b=awjYvJReQaf3jDduzSuU/uISCY+yyq1DEjFTixfdS2QbbandL9iD7ZsXiorlpgpXQy
         XXHcp+xDWLKeJNU1Yg0Y6OMvCgCnTnpOe7XBq3bXbsrDyUhQgHQow9IaiRhv8hmikIU7
         6SFGLQwj1WSWT6fyDF+vb+9CghgVQwxmKiIKN7wExPm+TfhJd2CqILb9ctUVJZtrqhFh
         imdCgiXNmudXE4WqN/fRu2cK+i39iIFNW1X6TZMWemfL9pPNBcFccmxwQFyFveQsk7zd
         SUX+eZ4ZDM+DzACMbWCwIgR6ibQrzqZzd/DV0vc4iYHikLGE5P/O0ugXd+Xvs56nQP+v
         qiJA==
X-Gm-Message-State: AOJu0YzkkkV14OSkm/FZ1wUzOJbOBNOJWQ4FiyqAh9W3QH3EwLbJros7
	lxjdbPX6XvqixMfuUu5mfdAr7WzURLa+/vOzYGE3op1BNoCRj3aHKd0hsfTwIIuoiFP+5GMa+FR
	cXb3L+TA3Ed0+MB5S7UtFjPJHnxMwsCOx
X-Google-Smtp-Source: AGHT+IGlnAoc0HcS757mAKRwueteBoEpKIAiGZd2kTl5qoRO/67XbpqjsrLwY16B/VNb22JQk3yrUPROpZUnMZ/GjIo=
X-Received: by 2002:a05:6870:6113:b0:219:231c:1e34 with SMTP id
 s19-20020a056870611300b00219231c1e34mr2315062oae.15.1707209588324; Tue, 06
 Feb 2024 00:53:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240129113527.607022-1-karthik.188@gmail.com> <20240129113527.607022-5-karthik.188@gmail.com>
 <98d79d33-0d7e-4a9c-a6a3-ed9b58cd7445@gmail.com>
In-Reply-To: <98d79d33-0d7e-4a9c-a6a3-ed9b58cd7445@gmail.com>
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 6 Feb 2024 09:52:42 +0100
Message-ID: <CAOLa=ZR=_tt=ppphGMkxqj_YB5G+YkTMWGzRzcHTbrZz4ysb5w@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] for-each-ref: avoid filtering on empty pattern
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Feb 5, 2024 at 7:48=E2=80=AFPM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
>
> Hi Karthik
>
> On 29/01/2024 11:35, Karthik Nayak wrote:
> > When the user uses an empty string pattern (""), we don't match any ref=
s
> > in git-for-each-ref(1). This is because in git-for-each-ref(1), we use
> > path based matching and an empty string doesn't match any path.
> >
> > In this commit we change this behavior by making empty string pattern
> > match all references. This is done by introducing a new flag
> > `FILTER_REFS_NO_FILTER` in `ref-filter.c`, which uses the newly
> > introduced `refs_for_each_all_refs()` function to iterate over all the
> > refs in the repository.
>
> It actually iterates over all the refs in the current worktree, not all
> the refs in the repository. I have to say that I find it extremely
> unintuitive that "" behaves differently to not giving a pattern. I
> wonder if we can find a better UI here - perhaps a command line option
> to include pseudorefs?
>

As Patrick mentioned, this was discussed a while ago and we decided to
move forward with the `git for-each-ref ""` syntax.

> > Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> > ---
> >   Documentation/git-for-each-ref.txt |  3 ++-
> >   builtin/for-each-ref.c             | 21 +++++++++++++++++-
> >   ref-filter.c                       | 13 ++++++++++--
> >   ref-filter.h                       |  4 +++-
> >   t/t6302-for-each-ref-filter.sh     | 34 +++++++++++++++++++++++++++++=
+
> >   5 files changed, 70 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for=
-each-ref.txt
> > index be9543f684..b1cb482bf5 100644
> > --- a/Documentation/git-for-each-ref.txt
> > +++ b/Documentation/git-for-each-ref.txt
> > @@ -32,7 +32,8 @@ OPTIONS
> >       If one or more patterns are given, only refs are shown that
> >       match against at least one pattern, either using fnmatch(3) or
> >       literally, in the latter case matching completely or from the
> > -     beginning up to a slash.
> > +     beginning up to a slash. If an empty string is provided all refs
> > +     are printed, including HEAD and pseudorefs.
>
> I think it would be helpful to clarify that it is all the refs for the
> current worktree that are printed, not all the refs in the repository -
> we still don't have a way to iterate over the per-worktree refs from
> other worktrees
>

I agree, based on if we keep the current commits or remove them, I'll
send in a new patch or amend the current series.

Thanks!
