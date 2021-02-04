Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD95C433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 00:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32D0064E40
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 00:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbhBDABo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 19:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbhBDABm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 19:01:42 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9E2C061573
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 16:01:02 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 63so1730385oty.0
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 16:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qQCRFygkjJ6llF0FnLdytNejGFXSUoHD+V6OgJW5DqI=;
        b=YD93ismPj+OAPTMB5pCSjEVtKN53sDgMIRVUpeRA7wHWRnAFYDURR8YgABMhqeX8tl
         58yRf7iPt1id2PjFk/m5hzXhsjpC5LNtjgPoWz3Yq8RWmdRJs0iTKHG8fCYDODJKboUv
         w/5Lh6joWaMFLWbLpe9I5xBctn79LlyG1TnLB6jPyOG8FxfCGvJKMWMzQxJNwpdIH6s4
         dVWEBNCzYD9FjjxiYP0nkQTKDPS1L9cP9wRD7RSTIKdBOD+SFpT4KMFGSLjfoaPqVELX
         oemkTLe3zJkv7P0HJgCJEVlSS0OPugUGZ2AsLHrysB9V3bB1UFP44vgFv5LMnSRpslp3
         MjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qQCRFygkjJ6llF0FnLdytNejGFXSUoHD+V6OgJW5DqI=;
        b=ZVClL2yHRngilYfsjbdbbnWlOUPohGhNJXPo1DHDxtQWQtUijY6PT02T2wnX3cUuqg
         dBerhrLDUX34SEoFJbETbgpHjM9EIF2roONrBBjIsOnkA8f72KIHKh8bW8QVwhpsYqXH
         RYS+fMTHqdcP/pkDiat/T+NdFHt2bu36SvCxEPaI1BmSDkmC679Veqz9RRVeUIoo6IWo
         yqD4aMZNPbwHSQB418+kY5JG8THMD0s1HcOLti6aNknTBDsXJwmaI67lsCQ2OvxTCGrS
         cV7cx2jc1wMC2ofZfgNGUMCvNK0Rg5FVSJBXt92xbcx0jbGwkLWg3coCKrLALw0uSjM6
         004w==
X-Gm-Message-State: AOAM532nXK/h7wL2M/XryZSeAHNT8IPzyyWzcIurlIpRQAqarZn4IiAR
        vNGtQD7FNurip0Ndz9K0Mf6wWOoOUvWIhCq/pDMhcvyva/0=
X-Google-Smtp-Source: ABdhPJxxF9GEqK0KTunAeF3swiwgpkmMRaHK6AOijkWMx+NrmyaqsPvWGoPkvlNRJkz2jk3yHquEkBvMiGl0/yo+yAU=
X-Received: by 2002:a9d:741a:: with SMTP id n26mr3721003otk.210.1612396862066;
 Wed, 03 Feb 2021 16:01:02 -0800 (PST)
MIME-Version: 1.0
References: <20210124170405.30583-1-charvi077@gmail.com> <20210129182050.26143-1-charvi077@gmail.com>
 <20210129182050.26143-7-charvi077@gmail.com> <CAPig+cQeBE7m8wf1e_soVrpvL3==u50MPyb90NwWLnFiUz1Byw@mail.gmail.com>
 <CAPSFM5fZHZDnmRD2GzwPVKwBjogKD=GJbC7e=6aQSbu_iXBdNw@mail.gmail.com> <CAPig+cRxmFr_Sbwdf4OFMr8Vp1q6O6J7AbgYAD5cgdD--hgDuw@mail.gmail.com>
In-Reply-To: <CAPig+cRxmFr_Sbwdf4OFMr8Vp1q6O6J7AbgYAD5cgdD--hgDuw@mail.gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Thu, 4 Feb 2021 05:30:50 +0530
Message-ID: <CAPSFM5fLi-U3zVcXFip_kgchHSXiEUF9nngO2nSf31kAEBkq1w@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] rebase -i: add fixup [-C | -c] command
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 3 Feb 2021 at 10:35, Eric Sunshine <sunshine@sunshineco.com> wrote:

> > >     return command == TODO_FIXUP &&
> > >         (flag == TODO_REPLACE_FIXUP_MSG ||
> > >         flag == TODO_EDIT_FIXUP_MSG);
> >
> > I admit it resulted in a bit of confusion. Here, its true that flag is always
> > going to be specific enum item( as command can be merge -c, fixup -c, or
> > fixup -C ) and I combined the bag of bits to denote
> > the specific enum item. So, maybe we can go with the first method?
>
> Sounds fine. It would clarify the intent.
>

(Apology for confusion) After, looking again at the source code, as we are using
the flag element of  the structure todo_item of in sequencer.h. So, I
think right
way is to let it be in binary only and change type from 'enum todo_item_flag' to
'unsigned' , as you suggested below (better than first method) :

Otherwise, if `flag` will actually be a bag of bits, then the argument
should be declared as such:

    static int check_fixup_flag(enum todo_command command,
        unsigned flag)

> > Agree, here it's checking if the command is fixup and the flag value (
> > which implies either user has given command fixup -c or fixup -C )
> > So, I wonder if we can write is_fixup_flag() ?
>
> Reasonable.
>
[...]
> > I agree, this [tolower(bol[1]) == 'c'] is actually doing all the
> > magic, but I am not
> > sure if we should change it or not ? As in the source code just after
> > this code we
> > are checking in a similar way for the 'merge' command. So, maybe implementing
> > in a similar way is easier to read ?
>
> Keeping it similar to nearby code makes sense.

Thanks for confirming!

Thanks and Regards,
Charvi
