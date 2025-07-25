Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BCD24418D
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 14:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753452891; cv=none; b=d5IQU1glBPTlNqosAyoICRYvTW6R4k72sPNlXYQ+eeDcDqIK126EZRq8Hq70qj9eDIn+qqIGjOd3E+JjiY1arP+mP/OVp2SI/Psi/Xkk91PcIMAbe/PvZzYKK87twZtTw6GWhK79yqEQ38bKyZpAYQeBO0hjJfbIEbvG085H7Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753452891; c=relaxed/simple;
	bh=Od51u5yrTYDFiJGHrdxcskf81LeJOIOVKEGaPMdvfWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=luFeAoemJ3qxFwMyOQC/CUhyVLvOTdE2T8tulVxYbZjqbdvv0EmJPao4HNEKZsDBzBuOa8RIS19zGVHvxvv3AOBRALD6hhkPyqUhj8HM9kcadm1TVmulW90ZWUotESU61fwKXA0gGMD2KQ+hTaQp8bz18fSOXrZzkiHLgCfDZP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcOtXc47; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcOtXc47"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a4e742dc97so1852958f8f.0
        for <git@vger.kernel.org>; Fri, 25 Jul 2025 07:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753452888; x=1754057688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n99Ze38sslU8aP+yyEp2ZiC8WxGt2qSrbU4Nzh//qhs=;
        b=mcOtXc47MgN8wzJJO3lXlg00+fBAzQnd4coUCT+8NukqteiYDxc+BId0RorEfszasb
         NxRMev1vCqFKyZGwSJpltMKIF09GMIaMyi1bbyx7jUe8ei//P3AiauNIs0i/64RGNJ8I
         da2LtP0N48dC0hpjAU4AspkVwtUxFH86cZyTT7SBw57WnOFIqmwuul23Kqa+PDRQzOHm
         Lf136e2O785hrb+Tzuw54ZKEUC8X/shbFWHREC1af7SrKVs9PBAaX34Qs1zLdT1Oznqt
         WhM08Hilh6n2ODmx7llC71QkMLk/gNaFC/m2xc2t5EDQaZ04ilXwo5rR0MgPtDWcBhhG
         v4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753452888; x=1754057688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n99Ze38sslU8aP+yyEp2ZiC8WxGt2qSrbU4Nzh//qhs=;
        b=mqElaFWDKa4PbUd3BvAYMOp7UYB3ct+HGipWGpLSLje/HStwupxwniOqWUSHmn8pZj
         9xZvNR5iXx0CcVY9HJMETaSkZxtwU8Ug4Tiy7aJYuH/r2+w6U6vCg/eMUcltxzBbgYOb
         JmB1cfKEWFZLoL9SlCl2KDZsjWhZ5LS0NBK+Vnh2ZIerplW6N4fX98l9yY1IIOtYz/J3
         B8D0jxw5X0PsZlCpgqtSgo7bCaBbGaCaihlBOl+jesMohMLM6VgMR2LAFCfP3fspXz1Y
         Z90mHAlwUpX2Ny28fUMcxJW7CWPBOhng0jbyraRp38iKa8dgym0X8XHnK1egQNyFH7Re
         VjFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWD3B5f7IfppxCcp1zL0avC8zWBkRX3jaQq2HCnfCES1h5Ic9lihvGhMswLimik/tBZBmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwolrlLExSMj+DHQHtpU608ptku+Lw4xxLwmgLPTN8pFXfocqWq
	c90Zug5v23n3xlfMhM+6G50PgClyAMfz3q0yGf1o4RaNHIsBGCF1hwa7YBMHTrrbDjbcM8FCXIN
	iq5FKACU04B23qYPZMxb1s/5XuguDD7Q=
X-Gm-Gg: ASbGncu56KxL/RLMrjhKVc8NwuTUdkaRPhsm+YA7P36Byxwg3JWAzYlNx/YcGWbVmXq
	+nsO1notQCfNyszXpO+Zn42/v1smCatFAlsclGZejrbQq3PF97atFyNe6aBNF4DGp03WA1PqpQB
	iWXRxmHqVFblRa7r4DmWyKrCHnBJ6NKjakKg7pJXS7g1gb40i5ldAYK3LDAv104nhiZ/7HEZMQU
	e/9EvBc
X-Google-Smtp-Source: AGHT+IH7mFVlyf46cFrP9JhGtqPEO3cByhz2oZgldqhkyHxiZvbxSgDHpcqQSYXSt1hF8fp64qeQ496Za7IOKa8N24Y=
X-Received: by 2002:a05:6000:2889:b0:3b6:1360:e456 with SMTP id
 ffacd0b85a97d-3b77665fd07mr2183543f8f.22.1753452887833; Fri, 25 Jul 2025
 07:14:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAVFnNkdgXuUk6ziu5FkB=sAHzEOyiynQpQJFox_p_ZL9VGRfg@mail.gmail.com>
 <xmqqwm7xxn4a.fsf@gitster.g> <184ec60f-9431-43c1-bce3-405bb6b7f959@gmail.com>
In-Reply-To: <184ec60f-9431-43c1-bce3-405bb6b7f959@gmail.com>
From: Cameron Steffen <cam.steffen94@gmail.com>
Date: Fri, 25 Jul 2025 09:14:36 -0500
X-Gm-Features: Ac12FXzUtWBoiUuKLv7H0Xc-M5RcOtow_3hZtMDFKQoZLgwS4jWfvNw6pq8TmSQ
Message-ID: <CAAVFnN=q5nCD3K1jppVcq7qB9P5WX0M070jqR_rey2hzBt0ERA@mail.gmail.com>
Subject: Re: Show skipped commit message after rebase conflict?
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Kristoffer Haugsbakk <code@khaugsbakk.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

There is already a message that prints in the case where a commit is
automatically skipped if the changes are already applied.

> warning: skipped previously applied commit <hash>

Potentially we could use the very same message.

On Fri, Jul 25, 2025 at 9:02=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> On 24/07/2025 23:03, Junio C Hamano wrote:
> > Cameron Steffen <cam.steffen94@gmail.com> writes:
> >
> >> Sometimes I run into a conflict in a rebase and I end up resolving the
> >> conflict by removing all the changes. Then when I run `git rebase
> >> --continue`, the current commit is skipped and the rebase continues
> >> normally. Would it be possible to emit a message showing that the
> >> commit was skipped in this case? It isn't very obvious to me in my
> >> workflow that that is what occurred.
> >
> > I do not know what level of verbosity is needed to grab attention by
> > the end user, but something like this might be a good starting
> > point?
> >
> > Totally untested, and there may be implications (like, control
> > passes this point in different situations where the messages is not
> > warranted).
>
> I haven't tested it but I suspect this prints the warning when
> continuing after a "break" command or a failed "exec" command. That is
> probably a good place to issue such a message but we'd want to check
> whether rebase_path_message() exists before printing the message. I
> think we could also read REBASE_HEAD to find out which commit we're
> skipping if we wanted to make the message a bit more informative.
>
> It would mean that "rebase --skip" also prints this warning but I think
> that is sensible if we're doing it for "rebase --continue" after
> removing all the uncommitted changes from the worktree.
>
> Thanks
>
> Phillip
>
> > I'll pick a few people from
> >
> >      git shortlog --since=3D2.years --no-merges sequencer.c
> >
> > based on their contribution to the file (not counting the internal
> > implementation changes) and Cc them to see if they have ideas.
> >
> > Thanks.
> >
> >   sequencer.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git c/sequencer.c w/sequencer.c
> > index 67e4310edc..677d6105dd 100644
> > --- c/sequencer.c
> > +++ w/sequencer.c
> > @@ -5369,6 +5369,8 @@ static int commit_staged_changes(struct repositor=
y *r,
> >                       goto out;
> >               }
> >
> > +             warning(_("omitting a step that has become empty"));
> > +
> >               if (!final_fixup) {
> >                       ret =3D 0;
> >                       goto out;
> >
>
