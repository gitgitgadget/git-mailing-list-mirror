Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60641C433DB
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 13:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3157E6191F
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 13:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhCVN0p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 09:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbhCVN0j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 09:26:39 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E19C061574
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 06:26:39 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id dm8so19351338edb.2
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 06:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=4sB4oKuMK2L+P2CEg3CW9dLJurX8peiz/XPlnR27jG0=;
        b=gTp/wRkkheK2kkYWvlfhUYe9qJYQ7+Ptud/yeMliWWL38YI5Idio09npN5ZH2tps+2
         KspIN1hfx9MiUA04rvm+VSmJjEDvSzw6REwPbeyDQoX2SIJXcHdAECjSkXMq2ncGQjO0
         HPkYOV4Nl0Fk6QoVFMcZPEx4C8FOczv30V77WB7zgbuqzr4Mrg6Bc+V7bAFaf5yKLgo0
         cqdbdJe2homRQ6HfeFYgXdY1roNZHU5+zKa8GEQLso50eySytI0MOoZoPstkinAPucT8
         SFcI4iUhirVpI1VM6TnQB8qJfjHPZScdvdEgc8cGxZxYblg82EsqlQfjhAlp5KH5fMcW
         QMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=4sB4oKuMK2L+P2CEg3CW9dLJurX8peiz/XPlnR27jG0=;
        b=RXyNUMMmJxjk+q0PveBYGGi7Tg8f9MgP3JTCv+5Z1/BYmZx46w2zINxsHRhuK+Ridd
         C0mAimpGilyjSl0grIUAnj4TcxMJxwj2BU6Dom0KuqlsTaFKo2m32iVbSlS72EbTrqfb
         udRUaeBK3PCMWMW5qAtJ5vdPIUiM0QfRDF7fR+m996B2SyTNR2qzJNrLUjOi+wdyX7AY
         KoNVl8v3QMF2n7PiN6qjVdw00YdtNCqlvV/DMzpKz60aD6rTUn6JeweoD3KpkCaa3+Z4
         8tsjYrtQfFLyFvvX3hrX1YOrEEgyK7ENwYQ+D9QTNhJeFVvCLK4hR6u/eIv+RFvLSI12
         gjzA==
X-Gm-Message-State: AOAM530X8+aD5HV8UF5e37ESBW2u+sITi1cxgLRgGPLVYEiPEIzBX6Cc
        /Xp2a4FzN9BVSOtJFYUiAfY=
X-Google-Smtp-Source: ABdhPJwGw3MxBM7C0L/retTh7b9YhUpCZGbb3whZAJUBSZ/UatwwK11mrKL5v837w1ypwGQjOblZfQ==
X-Received: by 2002:a05:6402:3486:: with SMTP id v6mr25469357edc.109.1616419597610;
        Mon, 22 Mar 2021 06:26:37 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id b18sm9740375ejb.77.2021.03.22.06.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 06:26:36 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Martin Fick <mfick@codeaurora.org>
Subject: Re: Distinguishing FF vs non-FF updates in the reflog?
References: <CAFQ2z_MefCwiWdhs0buJv5Zok+nsgaOvUCcsSnfm_PP0WozZKA@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CAFQ2z_MefCwiWdhs0buJv5Zok+nsgaOvUCcsSnfm_PP0WozZKA@mail.gmail.com>
Date:   Mon, 22 Mar 2021 14:26:36 +0100
Message-ID: <87eeg7qpyr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 17 2021, Han-Wen Nienhuys wrote:

> Hi there,
>
> I'm working on some extensions to Gerrit for which it would be very
> beneficial if we could tell from the reflog if an update is a
> fast-forward or not: if we find a SHA1 in the reflog, and see there
> were only FF updates since, we can be sure that the SHA1 is reachable
> from the branch, without having to open packfiles and decode commits.
>
> For the reftable format, I think we could store this easily by
> introducing more record types. [snip].

Aside from what others have mentioned here, you're talking about the
log_type field are you not? I.e.:
https://googlers.googlesource.com/sop/jgit/+/reftable/Documentation/technic=
al/reftable.md#log-block-format

Has that "log_type =3D 0x0" tombstone proven to be a worthwhile
optimization past the stash case mention there (which is presumably not
relevant to the vast majority of Google's use-cases).

I.e. it's redundant to looking at the record and seeing if new_id =3D
ZERO_OID.

Similarly can't ff v.s. non-ff be deduced unambiguously by looking ahead
to the next record, and seeing if the current record's "old_id" matches
that of the last record's "new_id". If it does it's a FF, if not it's a
non-FF (or a create/delete).

I'm not arguing that a quicker lookup isn't needed, I'm just trying to
dig at what "beneficial" here is. The format is ordered, and the common
case is that the page we have in memory has the last record.

What sort of case are we talking about where not unpacking the log_data
segment is making a difference?

> However, the textual reflog format doesn't easily allow for this.
> However, we might add a convention, eg. have the message start with
> 'FF' or 'NFF' depending on the nature of the update.

Maybe a bit ugly, but a ".." and "..." prefix would at least be
consistent with "fetch" output. Or e.g. "commit:" and "+commit:" for ff
and non-ff (and we could make it "\t commit:" v.s. "\t+commit:"
v.s. current "\tcommit:" to distinguish all three in the current
text-based format. Per "OUTPUT" in git-fetch(1).

> [=C3=86var: snipped from earlier] Today we have 0 =3D deletion, 1 =3D upd=
ate,
> and we could add 2 =3D FF update, 3 =3D non-FF update.

I've written log table implementations (a site table in a RDBMS) for git
(one table for refs) which had:

    create, ff, non-ff, delete

I wonder if that quad-state would be useful for reftable too, with this
proposed change you'd still need to unpack the record and see if the
old_id is ZERO_OID to check if it's a creation, would you not?

I also wonder if it couldn't be:

    0 =3D deletion, 1 =3D non-ff-update, 2 =3D ff-update, 4 =3D creation

So the format wouldn't forever carry the historical wart of this not
having been considered from the beginning.

It would mean that the few current reftable users (just Google?) would
have to look at the record to see if it's *really* a non-ff-update, but
presumably they need to do so now for ff v.s. non-ff, so they're no
worse off than they are now.

Then when those users know they're on a version that distinguishes these
they can hard rely on 1 not being a "ff for sure", not a "maybe" status
for new updates. Presumably they either don't care about ancient reflog
records, or a one-off migration of rewriting the records for older
entries could be done.

Also between my [1] and this proposal we have at least a reftable v1.01
in the wild (the filename locking behavior change discussed in [1]), and
this would make it v1.02, but the only up-to-date spec is for v1.00 (and
maybe JGit has other changes I haven't tracked).

That [1] change is minor, but still, a spec change.

So just a *poke* that having some version where the spec is kept
up-to-date with that and this change if it happens would be very useful,
especially if the reftable-in-git.git lands one of these days.

1. https://lore.kernel.org/git/87k0tzulf1.fsf@evledraar.gmail.com/
