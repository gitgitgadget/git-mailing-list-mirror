Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576251F3D4F
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 17:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736270987; cv=none; b=B+R4WcUpn8ZnMvnuOYYF9t6kwtAGoZ6kI2DDkItH8IE0ZBF/5918RAm/cPdYBXSew5jtxPS8JogxoDDPSwK3WlvoUhMI/qQG++ld/Hmw/YV3/9AUUuuuzqyRd9YxVY2swn/qpqt9HEtWPbpSBtDPeYBzKW1whHseVMZJZH3Hd84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736270987; c=relaxed/simple;
	bh=IMs0mAVFP9WDUi7Qy8SibK0DbHLPcsO3s886Jz1iz7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BCKKJV6P8sJjDlTVylHDMPGaS+oVyfuu63Ij9gIA5n9e8sdxFH2koBUqa8I09yVx2DJeQTXhtyZ9LGBpnG+lcr+t132KnwuK9SLqDRFLEWcQJEtPcj5z85rhkSZNOAmxQP704QmEx8fwDl2lMnFudWoEXbxLsPp/vPIffCgkG6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdnrF8Ox; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdnrF8Ox"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21669fd5c7cso236856895ad.3
        for <git@vger.kernel.org>; Tue, 07 Jan 2025 09:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736270983; x=1736875783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yE63QbqFyox0ga6l3tO8y+7SMl0uSaLfOMIwRRdZTlc=;
        b=EdnrF8OxAZ3qK7PBqi1V40Ibm55FY8gJJxwzmDMvOyzt/u8/yUJ7dUmW3KqLeFPOxL
         ERizC/t2Nd3rD6zh49yElMvpB+3eKItIO2jho5zSyAZqnNqsp1yGwKE7SOQzwXM0idlF
         YTzbStUeL0VD6aABWMm4FYiVHf9B3s6eYcRB3YPt4pH3a4k4AFpr22TJZmhtVV7Lq1CC
         y/yJxMbmgRRL9aeSQAFp0amLb9YsyUHToL/dww4rR8pRweheG3IL37OQZRkUSx4FVqHn
         PnHPDgXGPt1TZhGMvnQwmHyGF3nG/bJ5MAFB2is8DjAXjQMAwwAQjzNPcj8Rpd7atjcM
         Tjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736270983; x=1736875783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yE63QbqFyox0ga6l3tO8y+7SMl0uSaLfOMIwRRdZTlc=;
        b=GbUjFguVPks9SxsSEKMBzTM4MQkNnPiyUaAeCQaOLmQIhi51qQGMHaX0zM24OPvx8F
         MH2jjO2w+RZvsMuHKKKvT4CJ2dgOCODLALOmnVShhf7DL5GMNDEYjlVy1ReyWe7QsY1Y
         FOnBK3vxUvZbhuc6mrNDiMmrOZ4gOBJEwzMq+/lOyD+QZQEkaTA6poJrK6Z6SfZ1GvY9
         G3WBSOOtf1kD0B2blKTm2COPT9HaDM0WFbX0K1HKQ2Eubp7dOtP+6gVBBvi4PhEL3PuY
         fOVpOPLqkA8q0dsQO/vnaTFiMn+OeRrdxF3PeX+/djLLlCWTZu+J8ulpcYz1Yp3vU25K
         ry9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4kzpt6JaVn70pbd5NR/UCbmJQznxn0XQWnPpGGXT86spTCOnBLY9nAYFdUaAeFSf37+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtPDduxMPA67PGfDLYwPg1wc3+aR+9MjPaFvafbiHi/YyLgCKN
	wx1gLoQdVq4z3rMa9wFNQcKLPM7dp65A+y2O9IKsgqYvs0JE9RSJ5iO9AEK7+6kBuSjdaUPi26y
	B2glTpT+A4ICA6SaEQ5twH9vtbMg=
X-Gm-Gg: ASbGnctBLSTf/ATR1jC8XUN9RP2q8vPnZuQ94lowwb5mdYSx+Zyn4Ht8lvEEQCY4ClU
	12C7ybxICOZ5xtBBcpupZc6+MLSvegLWvpMKiCt8sTvu6AGOzctz+5dA=
X-Google-Smtp-Source: AGHT+IFpLmU4/eiTwAUWmxkDVF0my0ZpNvJ87pjuW9dh2isuHAKWrHlJh34TI5azwk5FY8DefSNzEJbhGbuXdeL7zZE=
X-Received: by 2002:a05:6a21:2d04:b0:1e1:b224:74c0 with SMTP id
 adf61e73a8af0-1e5e0815ee4mr100859013637.38.1736270983514; Tue, 07 Jan 2025
 09:29:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1838.v2.git.1735380461980.gitgitgadget@gmail.com>
 <pull.1838.v3.git.1735928035056.gitgitgadget@gmail.com> <xmqqbjwnra9u.fsf@gitster.g>
 <CAG=Um+1ch1sKC0H8MJoFv=6iSK3pvA=03AKXmvhm5DG=H8T1rw@mail.gmail.com>
In-Reply-To: <CAG=Um+1ch1sKC0H8MJoFv=6iSK3pvA=03AKXmvhm5DG=H8T1rw@mail.gmail.com>
From: Shubham Kanodia <shubham.kanodia10@gmail.com>
Date: Tue, 7 Jan 2025 22:59:07 +0530
X-Gm-Features: AbW1kvZW_DWpKOiTMZ_1LpJxJm_QD2drEWQRFmI1-8CzGhdeQRQxZfgCaQESXdw
Message-ID: <CAG=Um+1tD+taKyN35x6q8ynjgrp+nVPBbuff5FUm6HUp3qe+fw@mail.gmail.com>
Subject: Re: [PATCH v3] maintenance: add prune-remote-refs task
To: Junio C Hamano <gitster@pobox.com>
Cc: Shubham Kanodia via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 4, 2025 at 1:23=E2=80=AFAM Shubham Kanodia
<shubham.kanodia10@gmail.com> wrote:
>
>
>
> On Sat, 4 Jan 2025 at 12:32=E2=80=AFAM, Junio C Hamano <gitster@pobox.com=
> wrote:
>>
>> "Shubham Kanodia via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>> > From: Shubham Kanodia <shubham.kanodia10@gmail.com>
>> >
>> > Remote-tracking refs can accumulate in local repositories even as bran=
ches
>> > are deleted on remotes, impacting git performance negatively. Existing
>> > alternatives to keep refs pruned have a few issues:
>> >
>> >   1. Running `git fetch` with either `--prune` or `fetch.prune=3Dtrue`
>> >      set, with the default refspec to copy all their branches into
>> >      our remote-tracking branches, will prune stale refs, but also
>> >      pulls in new branches from remote.  That is undesirable if the
>> >      user wants to only work with a selected few remote branches.
>> >
>> >   2. `git remote prune` cleans up refs without adding to the
>> >      existing list but requires periodic user intervention.
>> >
>> > Add a new maintenance task 'prune-remote-refs' that runs 'git remote
>> > prune' for each configured remote daily.  Leave the task disabled by
>> > default, as it may be unexpected to see their remote-tracking
>> > branches to disappear while they are not watching for unsuspecting
>> > users.
>>
>> There is no description on how and why the prefetch job has been
>> modified here.
>>
>> I haven't formed a strong opinion on the "should we keep going after
>> the first failure?" question yet, and if this topic is modifying the
>> way how the prefetch operates, the patch(es) should be CC'ed to the
>> author of that feature (The author of 28cb5e66 (maintenance: add
>> prefetch task, 2020-09-25) CC'ed).
>>
>> If it turns out to be a good idea to do so, I would expect the topic
>> to consist of at least two patches:
>>
>>  - [PATCH 1/2] to argue that it is a bug that the prefetch job stops
>>    at the first failed remote, and change its behaviour to prefetch
>>    from all remotes and then report a failure if the prefetch failed
>>    for any remote.  With some additional tests to check the updated
>>    behaviour.
>>
>>  - [PATCH 2/2] to argue the need for periodic `remote prune`, and do
>>    the part of this patch that relates to that new feature.
>>
>> > +struct remote_cb_data {
>> > +     struct maintenance_run_opts *maintenance_opts;
>> > +     struct string_list failed_remotes;
>> > +};
>> > +
>> > +static void report_failed_remotes(struct string_list *failed_remotes,
>> > +                               const char *action_name)
>> > +{
>> > +     if (failed_remotes->nr) {
>> > +             int i;
>> > +             struct strbuf msg =3D STRBUF_INIT;
>> > +             strbuf_addf(&msg, _("failed to %s the following remotes:=
 "),
>> > +                         action_name);
>> > +             for (i =3D 0; i < failed_remotes->nr; i++) {
>> > +                     if (i)
>> > +                             strbuf_addstr(&msg, ", ");
>> > +                     strbuf_addstr(&msg, failed_remotes->items[i].str=
ing);
>> > +             }
>> > +             error("%s", msg.buf);
>> > +             strbuf_release(&msg);
>> > +     }
>> > +}
>>
>> A few comments:
>>
>>  - The message pretends to be _("localizable"), but the sentence
>>    logo inserts action_name that is not translated.  If the
>>    operation failed only for a single remote, "following remotes" is
>>    grammatically incorrect.
>>
>>  - Would it be useful to force this message to a single line, with
>>    multiple remote names concatenated with ","?  Computer output of
>>    a listing often is more useful without "," if it is meant to be
>>    consumable for cut-and-paste users.
>>
>> Overall, I am fairly negative on the report this helper tries to
>> give the users.  Because we are going to do the operation on all
>> remotes anyway, wouldn't we have let the underlying operations (like
>> "git fetch" or "git remore prune") already issue error messages to
>> the user?  Do we need this extra reporting on top at all?
>>
>> Thanks.
>
>
>
> If it=E2=80=99s fine, I=E2=80=99d like to discuss the change to process a=
ll remotes separately from the initial change I submitted.
>
> I took an attempt at it in my last patch, but I don=E2=80=99t know if I=
=E2=80=99m really going to have the time to iterate on it as it looks more =
involved.
>
> In any case the implementation isn=E2=80=99t any worse off than the curre=
nt maintenance command.
>
> Also, as a new contributor I=E2=80=99m unsure of recalling / patching a c=
hange that=E2=80=99s already in seen at the moment unless it is an unworkab=
le solution.
>
> Thanks again.
> Shubham K

Noticed an update on What's Cooking =E2=80=94

> * sk/maintenance-remote-prune (2025-01-03) 1 commit
> - maintenance: add prune-remote-refs task
>  A new periodic maintenance task to run "git remote prune" has been
 introduced.
> Expecting a reroll.

Junio, what do you think about my previous suggestion =E2=80=94 do you thin=
k
that changing the remote behaviours is a blocker for this change to
make its way to master?
