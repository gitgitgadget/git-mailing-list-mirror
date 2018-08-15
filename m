Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F6121F428
	for <e@80x24.org>; Wed, 15 Aug 2018 17:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbeHOUYD (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 16:24:03 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51803 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729388AbeHOUYD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 16:24:03 -0400
Received: by mail-it0-f65.google.com with SMTP id e14-v6so2728275itf.1
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 10:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SRG1VBWfgxm1hQn5Dbpf3fBP/rB2QFNu8/kYE5WStFY=;
        b=DG1xlDe5SVD6nrnhfdc9TX4cA6K+o3eX0cVDfQoTeBSHYWOmdEEZF6Su1hyNPVAPeK
         hCQtJG5OJjOmlh4L0MpKviKgjASquQuQuAQHZ0gia8nxBKkm7c++VRy8hu/hUD6JrW6B
         IS0fNpJloCPVdwq2xe+4ql6TRfvQsVUcsc75V3zhVDSiAD71oxOhdjDi065lAPmCifXQ
         cTKkjhja3PIffHxkvzjW+9ta0o/mHl4lqePAl8FzC4crQdJY3WFt2TIWH012hVOELHCR
         1fuKtd9KZ78dweKARXwvaUJVye3+keY9VtzNtEyj3wdb/s8Gqhie4o4xOwZ7RhhYbrR+
         VTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SRG1VBWfgxm1hQn5Dbpf3fBP/rB2QFNu8/kYE5WStFY=;
        b=c/N22jwBWepsYBsih4exrkappL5xqWTXdFezl4QABLBV+zinRtV4Jqm/wTSb24ka+H
         aBl/9WoySyWwtpDahhoN4nNo7wTcY8r5t31DmrpO3sTez7M7pjAeULP1H44cCG74aHcL
         NrRWFiT5zqB7d+Fv9EHbWCZ+81YknfHdNqfJxnkn0vLULoeN141LMymewT3HvJlX/mfP
         anndylHI5sFqh75esL+JqJR4zqNV4FH8wTA4d4eg3deRQiE7kAQHaeHGohdrhlzyeMxl
         jUrgw7fWILLSGE9UxtfxWAawJN3hf4MO6IFxgWT7W/LDvEY/0tA84BO4jfR6wbwuJcaz
         NWgA==
X-Gm-Message-State: AOUpUlE4nvhcJpJIwuGG1Oh3eegRYpIjDutPkvUq7nzwf0/kjvpVp8Sb
        B7hvNqzFnUhUr+r4+qY0pePRgq3t3ATJWF/Qdbo=
X-Google-Smtp-Source: AA+uWPz2ZWsWd+ANWfO4SCqrJNuIAMUmq2TNMKkMrW+njXaRIPTiScGymBFdvQ2RLMFRuzg1aaJMKQ6+YBawKQ+ec2E=
X-Received: by 2002:a24:b101:: with SMTP id o1-v6mr18022119itf.121.1534354259601;
 Wed, 15 Aug 2018 10:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180815162308.17747-1-pclouds@gmail.com> <20180815162308.17747-2-pclouds@gmail.com>
 <xmqqpnyjilrd.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqpnyjilrd.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 15 Aug 2018 19:30:33 +0200
Message-ID: <CACsJy8CkXRc9NXRHt3a7=v04to0bMTvZo9x7zYNZWPiGDKQqdg@mail.gmail.com>
Subject: Re: [PATCH 2/2] cherry-pick: fix --quit not deleting CHERRY_PICK_HEAD
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 15, 2018 at 7:26 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
> > --quit is supposed to be --abort but without restoring HEAD. Leaving
> > CHERRY_PICK_HEAD behind could make other commands mistake that
> > cherry-pick is still ongoing (e.g. "git commit --amend" will refuse to
> > work). Clean it too.
> >
> > For abort, this job of deleting CHERRY_PICK_HEAD is on "git reset" so
> > we don't need to do anything else.
> >
> > Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
> > ---
>
> Please do not hide this bugfix behind 1/2 that is likely to require
> longer to cook than the fix itself.   And more importantly, it makes
> it impossible to merge down the fix to the maintenance track, as I
> do not think we'd want to merge 1/2 there.

Oh sorry I did not think about that. Will drop 1/2 and send 2/2 as
standalone. But for the record, I think this has been a bug since the
introduction of --quit in this command (back when it was still called
--reset).
--=20
Duy
