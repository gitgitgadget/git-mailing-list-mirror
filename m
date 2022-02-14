Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3FBC433F5
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 08:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242452AbiBNIyC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 03:54:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbiBNIyB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 03:54:01 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432705F8F7
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 00:53:54 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id r18-20020a05683001d200b005ac516aa180so4077038ota.6
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 00:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Ubi2ngIM9psKQMqQrGPqpX/N7TPH4Ax1Tgx/wRNsW0=;
        b=Qkg5pUZM9mV5HWhQSZUJL2nLg5bQzDxJM0pzbXEFKFowfnmXEBZIQ5asCa1IOMvTUE
         w9MBphGHXNgWKTCDGadJp/aM7w4iSFcGWQKH2cXWRMidti4Qfgopf68FsUJ9FQ0FKF+c
         ukJwl8m1psc/eyjx94uFXiMQJY8znLkzig10BnmF2Pr8BzSLm7+wi5/pGg6AtKNc5mSv
         gZf+1a+WD3OIgbzGEk5Li5ayNtHEPvwInYZgt9uvQNX87r5hsIGd+P9GJkEkwvYnejwY
         YlZUG3+aSR+irtK8lc8AUEUjiV+TR1RlIxuE8YkBiW9sOnUwkPVuiVcmvroo4gQnwNBT
         W23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Ubi2ngIM9psKQMqQrGPqpX/N7TPH4Ax1Tgx/wRNsW0=;
        b=JeiUa/KMCpwQJy9Zb2ghgJfJE6iZDriVzdiKUogyQpfnGoHUx/r1PMMZMiucoeR8UU
         fbhnKxCOBkHeHh3T6f4rfrLcESD/h9IcsyjItbUkuRT1TDDBBr1cu/OP0WuN5NJMOL4A
         xlyJEsC7KHPRVXCb7Z2yvyWfOpjMruEFFclVzAY+zMTTho+zML2GZZi7ro7HXkrcPPIj
         YXRqYH15zLJYMlCFPbYeebIoFh4hKy+y26dEP8QZLwH0AD3gTeHRWVv67r4k4LkrRY3I
         33G7TMSrryV+2Iyl8pwWSq8Ppw2YbJysdqQJ7+09sRfRlFYQfYVNn82ryGHA8R/px34J
         RWow==
X-Gm-Message-State: AOAM533Z6lUxXlI2KLw/q/0KQnic1nV4pws3THjk4gL60t2/Y+qjJgud
        +a9kXy1aTng8p92N5niOV2jxL5pJAFRhifUGzgxCbYYipx8QAg==
X-Google-Smtp-Source: ABdhPJzB9f90wPj4btaxisIx4VzxbUm41bg84Abs/Pnil3Z+U6YY1vA48L/h19G/nAqvwOe/so0VWd9BZ5ISeRrce14=
X-Received: by 2002:a05:6830:2303:: with SMTP id u3mr2171090ote.26.1644828833606;
 Mon, 14 Feb 2022 00:53:53 -0800 (PST)
MIME-Version: 1.0
References: <20220121102109.433457-1-shaoxuan.yuan02@gmail.com>
 <20220121102109.433457-2-shaoxuan.yuan02@gmail.com> <Yer/oEZK6TBFSsde@nand.local>
 <xmqqr190g6gd.fsf@gitster.g> <CAJyCBORHE2+UMKYFfKArgK68fAT=pKVabVmfifzg--rHAFkaqg@mail.gmail.com>
 <xmqqo83fw5yc.fsf@gitster.g> <CAJyCBOTBcvgAcSaQ4xs-V=M-im_Umf3ymsWzCAGEmrj6b38pEA@mail.gmail.com>
 <xmqqv8xmvdoa.fsf@gitster.g> <CAJyCBOR7KbRxuXJUJ2TrffAjj=rwB3H-Ys9tVUuWGjUKf_LHsw@mail.gmail.com>
 <CAP8UFD3=kd8ACA8PPHyV7fCYLuJSb4Qj2OSdBFJ3RHtnwbGO2A@mail.gmail.com>
In-Reply-To: <CAP8UFD3=kd8ACA8PPHyV7fCYLuJSb4Qj2OSdBFJ3RHtnwbGO2A@mail.gmail.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Mon, 14 Feb 2022 16:53:41 +0800
Message-ID: <CAJyCBOTg+5m6s6Nw+ma4Y7RgMe_0GmjyN_f+BBeEc-BhzJi_Qw@mail.gmail.com>
Subject: Re: [GSoC] [PATCH 1/1] t0001: replace "test [-d|-f]" with
 test_path_is_* functions
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 14, 2022 at 4:45 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Mon, Feb 14, 2022 at 9:32 AM Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> wrote:
> > On Fri, Feb 11, 2022 at 1:23 AM Junio C Hamano <gitster@pobox.com> wrote:
> > > FWIW, I have the posted patch plus the following SQUASH??? fix-up
> >
> > I'm not so sure what does "SQUASH???" mean especially the three
> > question marks, i.e. is it just an incidental text or a commit message
> > convention?
>
> It means that you might want to squash the fix-up commit or a similar
> commit into your commit (or one of your commits in case of a
> commit/patch series), and then resubmit a new version.
>
> > Is it for the convenience of grepping through the
> > "git log" outputs (cause I found the commit 50d631c71c right away by
> > grepping through the "git log" output)?
>
> It is for convenience that it's named "SQUASH???" as everyone (who is
> familiar with the mailing list) then knows what needs to be done on
> the proposed commit(s).

Yeah, now I see :)

> > > parked in the 'seen' branch.  As the script is quiescent right now,
> > > I do not mind merging it down, now we spent more time on it ;-)
>
> Alternatively as Junio says he is ok with merging that down, you might
> just accept his offer and he will squash the "SQUASH???" commit for
> you before merging the result into the "next" branch.

Yeah, I saw the squashed version in the latest "What's cooking in git.git".
Thanks for the help and suggestions :)

-- 
Thanks & Regards,
Shaoxuan
