Return-Path: <SRS0=DQ4e=44=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272D3C0044D
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 18:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2123206BE
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 18:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLUNNL+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbgCKS6z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:58:55 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33830 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730734AbgCKS6y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 14:58:54 -0400
Received: by mail-ed1-f68.google.com with SMTP id i24so324928eds.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2020 11:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ycHcjslfySP1r+IhxOOlniYH5HgQa2tFJAUxV+/CrVU=;
        b=HLUNNL+MYeWOPiQhUkW5/ekZ0SBuit7W2sSZku2jR282VokCgd8E/ZAkXk0hwV2hWC
         w0rZVTWwdHE45uLIQf8DybWfN8baY5D1xgT3NaBtVUT1CIwaNbQV0SzJj5Wv8yItze5A
         QacyhK6KCBnLITX+BxXUeyYh9alWXtUS6zb949x9w1dEn47jI5x8usu4sDnWbWjnLTl6
         wLvoWP11jFb8qqS41MdwoIXgRxQSiUrwwWiDJpzDg+vZb/KlN4ugaW2/YzoFg1r5iIQ5
         2A9o8vtBU1NQZU3HrSQ/3948TL4XqCOWCpsvQtlVvJTaWeuZDNkklKSpQTQx+zrw0NwX
         TiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ycHcjslfySP1r+IhxOOlniYH5HgQa2tFJAUxV+/CrVU=;
        b=WFMipsUGEzGvPHRWSU1adE0d/4PTtUjOxW6ipZz+PhGxv3sRwb16zO8dQ3jyK1cOL/
         APrIqyy2ImlMJD+e8VM8iuWHyjw5Rhm7oXZqY0CxjNmcJUvN3DLYDS7n2ZOmnz3ZuGwP
         PG48FjpNwbXPhUb4QM7hwhhspA4FBEhLk0YYEGChGJp48cMwxgEAdRSHbzxbTRFVt2DY
         CNs0SVmCajAl/JG1FEm0OON/It3PEHw5COb+VDiFdBYT8413NncprzaVT7avBV5DU4Au
         8+/16bpeL1c92Ga0SUAyUZkOIGldSDrmwBj8lbj56BZ/B2eCH2PwQNyVhHufnaC/U2sD
         2srw==
X-Gm-Message-State: ANhLgQ0bP7VrkmmKxCnMdzxPTfbTPv9MsG4WzEpq4sWZ9WEImKuUBO3/
        Eu0CJq0/uCeXFKVUw+17hJeRlKhV8Dne2AZlLC8=
X-Google-Smtp-Source: ADFU+vuwXLhvzl9qcCxQe9pGY1gEfhVKD/2ULM6/Hrf6g574hDfMEdtPzpmTAQCz/Qvnh5Cc7Y43Zlrka8+Ov9UgYqE=
X-Received: by 2002:a50:c01c:: with SMTP id r28mr3233115edb.87.1583953131711;
 Wed, 11 Mar 2020 11:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200226101429.81327-1-mirucam@gmail.com> <20200226101429.81327-3-mirucam@gmail.com>
 <xmqqzhd5i1na.fsf@gitster-ct.c.googlers.com> <CAN7CjDDwgR=y8gyYmDzmuTW3AKvb1N=EdCtH-8Tr7T=b6cG5gQ@mail.gmail.com>
 <xmqqwo88f0do.fsf@gitster-ct.c.googlers.com> <CAN7CjDCb3Bo-reyCZBxMuxX7ecCRLo6XaZHUE5fKGnQav9g_xQ@mail.gmail.com>
 <xmqqimjh2tjq.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqimjh2tjq.fsf@gitster-ct.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 11 Mar 2020 19:58:40 +0100
Message-ID: <CAP8UFD2G-xhmRTNmicoA7vfRyttVSCU9Giribs6xykvkDZ0_8w@mail.gmail.com>
Subject: Re: [PATCH 02/10] bisect--helper: reimplement `bisect_next` and
 `bisect_auto_next` shell functions in C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Miriam R." <mirucam@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 6, 2020 at 8:06 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Miriam R." <mirucam@gmail.com> writes:
>
> > To my understanding, it looks like calling reset_revision_walk() after
> > the while() loop should be enough. Am I right or am I missing
> > something?
>
> I suspect that reset_revision_walk() may be too-big a hammer, as it
> clears everything, regardless of the reason why the flag bits were
> set.  On the other hand, the clearly strategy that uses
> clear_commit_marks() is to clear only the flag bits that were set
> during the previous revision walk from only the commits that were
> walked during the previous revision walk.
>
> I offhand do not know what flag bits on what objects that were not
> involved in the previous revision walk are still necessary at the
> point of the call made by the caller (that's a question for your
> mentors who volunteered their expertise on the program in question),
> so if there isn't any, reset_revision_walk() may be an easy way out.
> I just do not know if it clears too much to break the code that
> comes after the function returns.

process_skipped_commits(), the function that does this revision walk,
is called by bisect_skipped_commits() to print the possible first bad
commits when there are only skipped commits left to test and we
therefore cannot bisect more. This can be seen in bisect_next() which
does basically the following:

bisect_next()
{
       ...

       /* Perform all bisection computation, display and checkout */
       res = bisect_next_all(the_repository, prefix, no_checkout);

       if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
               ...
       } else if (res == BISECT_ONLY_SKIPPED_LEFT) {
               res = bisect_skipped_commits(terms);
               return res ? res : BISECT_ONLY_SKIPPED_LEFT;
       }
       return res;
}

BISECT_ONLY_SKIPPED_LEFT is an error code (-2) so bisect_next() will
always return an error in this case.

This means that the revision walk in process_skipped_commits() is very
likely to be the last revision walk performed by the command. So my
opinion is that not clearing anything at the end of that revision walk
is fine.

If we are worried about what could happen one day, when people might
be interested in actually doing another revision walk after this one,
then as we don't know what they will want to do and might be
interested in, cleaning everything with reset_revision_walk() might be
the safest thing to do and is probably cheap enough that it's ok to
use it right now.

Thanks for your review,
Christian.
