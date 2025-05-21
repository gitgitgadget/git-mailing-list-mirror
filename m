Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDDB264A88
	for <git@vger.kernel.org>; Wed, 21 May 2025 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747835090; cv=none; b=cgV3l19KFu9QT94ou/KUcvpyj4DAV2T6H787LWy8IuJMONmujtr0a0x0ADrbUqC3pMdsZBPNcq4ptXcrCo4kj1FgPvcOrnjRDk28HbiaU41lufi9zzJ1feNaOXpjUCDKwOHHQxBfSiJP2DGbj7SbZYKMOKrwlHrXj6P9Hx4DJOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747835090; c=relaxed/simple;
	bh=WRqqjRZJv0mdYBNtqa3NiaRvNlDrgyz7Abuu28Ghgls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQtiW8IEw/QD1iKSmjwVeCqaku/XKQrnnRCQmQo5V5DEy9byZp5b7H+FNB35gvhlrp10J7YmYIvRv/hRnZG6FU9f42b8xpdiLYBWnPUEuj0yHPYEgvvQr3s+nVNhzqgAVK7qFJWiYbhN10c87MqoLMB1MlCQzRzUwfM+s/VGsK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jymWC+5Q; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jymWC+5Q"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ad560321ed9so501431366b.1
        for <git@vger.kernel.org>; Wed, 21 May 2025 06:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747835087; x=1748439887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8S2URa9FkeIrZ3Po2xNCX12dKcnLTDHgOLVC2zrp+U=;
        b=jymWC+5QdOz1roVMw9PvPo1LVKN+nyZOpCx6rAy4cpAt6JABOHWZ2rbIwDwbeZTA7b
         I8GDVy3C93s7kum0NCcOUNWQSkGH2HfP1IB2wxaSXFt+HWSlA3mW5HGh+faiv0qWBJhQ
         MxYE5Uz4QYsV5jBnHn5axMTrhizWWTZjMUL4+scjxRZV9LzQCCaUyuxfhM9QxwS0/V6f
         cbeCVKkRQnBmhzCG712P6vV3ReIYK6sMvRc7uf6sDz/V+8wrnxJNh6Gdo47WtQUSeZMF
         9OXkmFAC5MHQN5a/nZA9abE53EMP2p8y8sjS5q3W0yIqA/m8uI6ivVOyAYc+J5P4+2J6
         cvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747835087; x=1748439887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8S2URa9FkeIrZ3Po2xNCX12dKcnLTDHgOLVC2zrp+U=;
        b=DMdIXIWQkoS4qN+SY2K4JEdQbhjEPFwANO8I00rs0F+La4rEOth/fG9qTMraeN/3Jo
         P0sRMpSpjWzKjBRr1xXwLHGLXzZ0wX2DD4V7xow3hGlxZhHWehz61WbtISxg9tjJjsz7
         ITnNyGL7fTrr+N6cgDr/V4FiLfzm7SuL+XA8IfMboeOakZvakjpRfeoML6mDZFVn4DgZ
         FDEj6jM+RI/XsAHH8/J2UrVeG3hfiKaK2UTYTHU5ndr6Po+8Vcpt9mk0JrH798eGh5O7
         58LTgOojGy0LYLUK7qJBMjJwcADqZ5bID+kNFBMwRALhK9Q7HE0W4uqpp9968B+eeDe0
         tyxg==
X-Gm-Message-State: AOJu0YxiP71HMYJ49XQ2nx3gmkVa4nmmXeR8UNbSu5lEXCf+mwgjE0Ss
	B6AMjkEuIpNdEr69pgxWkApkik61nfZDv9nkPM9zOGP3bBA6xFjiY2jEDgc+rWY1Z+CbTG7bUU3
	M8HwbX7QjL0fx2cT09Pw9rZPvox9kBhQ=
X-Gm-Gg: ASbGnctBehKv8lRxZwp+PpK2BW8Gv45snkgNrDSx905wNVmCS6TZNWOuwHY9AvVNV5N
	TKN3YP3oYUFfcNWf/wqxd5xXCcgABPjoLzLB6ic0J8yf+YL4gI2aqf0XeX/sHsgZIEAlOHxh/Yw
	yOdTH8SdXH/bx/nD49CLp3rmSLFRiU/SmTT+aTRPKjZxUdYfoZScexMUkOFwFaQlEfSEM=
X-Google-Smtp-Source: AGHT+IFDC5L8OFzbKNVNBY15CIiwxBRUlZXJDqmpIVxvVQfEnj/D/urhuglj5dh/OCoY3WFYeLbJTR+JulAiMwhs0lI=
X-Received: by 2002:a17:907:d02:b0:ad1:81c5:5ec9 with SMTP id
 a640c23a62f3a-ad52d42bcb3mr2131561466b.4.1747835087049; Wed, 21 May 2025
 06:44:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520193506.95199-1-ben.knoble+github@gmail.com>
 <20250520193506.95199-5-ben.knoble+github@gmail.com> <xmqqy0urggzf.fsf@gitster.g>
In-Reply-To: <xmqqy0urggzf.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Wed, 21 May 2025 09:44:34 -0400
X-Gm-Features: AX0GCFuWhLFj-75ON0dMeNII_KnMoOv7l78gwg--4kcBBBmIXSSa4P6fQiNnlow
Message-ID: <CALnO6CD=qX17v8Hyt06haR+ZjG3xFVC0-622QyXR5eryaRrb8w@mail.gmail.com>
Subject: Re: [PATCH 4/4] drop git_exec_path() from non-Git commands' PATH
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Adding Patrick to CC

On Tue, May 20, 2025 at 4:33=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "D. Ben Knoble" <ben.knoble+github@gmail.com> writes:
>
> > We setup_path() with git_exec_path() unconditionally (8e3462837b (Modif=
y
> > setup_path() to only add git_exec_path() to PATH, 2009-01-18)) when Git
> > starts; as a result, all child processes see Git's exec-path when run,
> > including editors and other programs that don't need it [1]. This can
> > cause confusion for such programs or shells, especially when they rely
> > on finding "git" in PATH to locate other nearby directories, in a
> > similar vein as a0b4507ef7 (stop putting argv[0] dirname at front of
> > PATH, 2015-04-22) solved.
>
> I can understand why we want to do this for things like editors, but
> doing this in start_command() would affect running of things like
> hook scripts (which may in turn invoke "git" commands) and command
> running on the other side of the pipe that does a local transport
> (e.g., "git fetch --upload-pack cmd"), and other commands specified
> via the configuration (e.g., "trailer.<key>.cmd") that may in turn
> invoke "git" commands, wouldn't it?

It would affect those things, yes, but I'm not sure what /effect/ that
has: doesn't adding GIT_EXEC_PATH to PATH only matter if we use the
dashed forms ("git-*" in my original message), which is long
deprecated?

Patrick pointed out in a parallel thread that it probably matters for
". git-sh-setup", but that manual explicitly describes using

    . "$(git --exec-path)/git-sh-setup"

So I would say the callers that don't do that are wrong ;)

>
> > @@ -746,7 +789,7 @@ int start_command(struct child_process *cmd)
> >       if (cmd->close_object_store)
> >               close_object_store(the_repository->objects);
> >
> > -     childenv =3D prep_childenv(cmd->env.v);
> > +     childenv =3D prep_childenv(cmd->env.v, cmd->git_cmd);
>
> Regardless of the answer to the above question, I wonder if the API
> change for this helper function should go the other direction, by
> passing the entire "child_process" structure to the function.  That
> would give prep_childenv() more information to work with to decide
> when futzing with PATH is appropriate.
>
> Yes, I am assuming that the answer to the above question is "true,
> unconditionally futzing with PATH is a bad idea" and we need this
> fix to be more focused, e.g., limit to "launch_specified_editor()".
> If that is the case, we can
>
>  - add a member "drop_git_exec_path" bit to "struct child_process";
>
>  - update selected callers, e.g., launch_specified_editor(), that
>    prepare child_process to set that bit;
>
>  - update prep_childenv() to accept the entire "struct child_process",
>    instead of cmd->env.v, and base the decision in your logic to
>    look at the cmd->drop_git_exec_path bit;
>
> perhaps.  It would give us a more surgical and focused update,
> hopefully?

Indeed, a more surgical approach is what Dscho originally suggested
(IIUC). Failing CI suggests there may be more that relies on
GIT_EXEC_PATH in PATH than I realized, so I can post an alternative
series that should only affect editors (requiring an extra patch for
contrib/git-jump, since it invokes an editor), but it is likely to be
"incomplete" in some sense:
- no Windows support (see replies to 3/4)
- won't affect all editor invocations, since those launched by a
script after retrieving "git var GIT_EDITOR" won't necessarily know to
rollback PATH.

I need to reroll anyway, so I think what I'll do is post a v2 of this
series along with a v3 that refocuses on editors? That way we have
both around for interested folks in the future.
