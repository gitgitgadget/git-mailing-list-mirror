Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8149CC2BA16
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 08:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0FC206F5
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 08:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icQS53bJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgDGIXT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 04:23:19 -0400
Received: from mail-pj1-f46.google.com ([209.85.216.46]:50347 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgDGIXT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 04:23:19 -0400
Received: by mail-pj1-f46.google.com with SMTP id v13so430961pjb.0
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 01:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uGj82iDDIUFGCUjM7Er6JkcppBi1+WmBpywG/NIA4dE=;
        b=icQS53bJTBeegI5M7ASjrF3z00F5LfSdLKO3O30qd6n65wa+Vy9adLaO32/azqu4Ly
         0Fwp6cdJfVQDUO3KLy4slLlHR/Rgyg39ffje73ZqB+fK0SuXbdK5muaPiNitKtSI9krL
         1CLP4ApsIfZBq8ZG/9pUZWqJ93w5gtIFWiilAmO0MQA20cD15un+vaBeXK5jasuScynB
         E3rZaxJsFo/SlVRrqJhdEYw3JFfGcxU2AKg0+cj3VxYsNwW+/mZwOE+dAdX1b15X17zf
         hTrTGkG+xEP4HbThBxyRO72OS9aKLjIoTYQWY8m0RWEq++2/yxn5I4weN9R0xTvgqQo9
         RdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uGj82iDDIUFGCUjM7Er6JkcppBi1+WmBpywG/NIA4dE=;
        b=nsplVyjjzV07LqixCvXxSCfCo46E9XlilkQbKmyixdmvYxu44n4729grdpYEr6AJcn
         UAbAjjxf1inc57wAbHewdxZ/+pbwhOJRWl+fMZmhhIbkHg7ukR0pHIU/3RsDGgjR63mc
         zoVlGsFq3fveQbsoaAOTK9Zi13bmHumKOMoX2eWwt8qhC2nGP2a8Hrjvq3spBijxB38A
         +UnEyykbxV7/1swQLvlJT84v/zMqmP7ZdMEy6TlPLwgCzIOO96vJn/35hcMAGKGWxA37
         DsNSM5zwQwOmZxJPhWXl7XF3ObFtk3dFFivnNkL02tFB/mNhweysKYCYlFyuH/Ezrca7
         vx4g==
X-Gm-Message-State: AGi0Pubwt+1cwaNhUlJ2Sf6BvfDifMX6jOaf6Rid/Jj7qFDxZdPusAsD
        x7rCdvcYNlSxMormeElwFUHxCH0/Ygq0Z8wHP1M=
X-Google-Smtp-Source: APiQypIGsPq4pFz6WZRMPvOUJyqb+ctpQVi8xesBVWQ3UQPofVXylk670zLfnQhOedd+jNmxpXax+SAfHw6Id769KKM=
X-Received: by 2002:a17:90b:46c4:: with SMTP id jx4mr1415538pjb.6.1586247797747;
 Tue, 07 Apr 2020 01:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200320233528.GB19579@SDF.ORG> <nycvar.QRO.7.76.6.2003211135380.46@tvgsbejvaqbjf.bet>
 <20200321175612.GC19579@SDF.ORG> <nycvar.QRO.7.76.6.2003252008490.46@tvgsbejvaqbjf.bet>
 <20200326001821.GB8865@SDF.ORG> <nycvar.QRO.7.76.6.2003281510260.46@tvgsbejvaqbjf.bet>
 <20200328163024.GA26885@SDF.ORG> <nycvar.QRO.7.76.6.2004041417420.46@tvgsbejvaqbjf.bet>
 <20200404174116.GB11944@SDF.ORG> <CA+KXf2C0XytyNEAAdTOZAzw5YTQuv3PSjJ7RgyWqTj9MPp6BDQ@mail.gmail.com>
 <20200406152450.GA9609@SDF.ORG>
In-Reply-To: <20200406152450.GA9609@SDF.ORG>
From:   Sebastien Bruckert <sbruckert.dev@gmail.com>
Date:   Tue, 7 Apr 2020 05:16:50 -0400
Message-ID: <CA+KXf2A7L1fRC3+rmDaME186CYf4yS+-dBgy_FkEFVh887N7MA@mail.gmail.com>
Subject: Re: Feature request: rebase -i inside of rebase -i
To:     George Spelvin <lkml@sdf.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for the more detailed explanation.

> I'm very interested in your opinion, but please note that we already have
> fixup commits for amending single commits in place.

Yes sorry, I still don't know everything about git and the way it
works. But I'm working on it!

> The problem that currently has no good solution arises when I realize
> halfway through a cleanup pass that things would be a lot simpler if I
> moved A to after C. "Hey, rather than adding A and then updating it to
> take C into account, how about I just do commit C first, and then add the
> final code of A in one step?"  That is, I want to change from O-A-B-C-D to
> O-B-C-A-D, but I didn't think of it until the rebase had reached O-A-B-C-.
>
> I think of it as "quilt pop" operation, taking patches off the
> applied list and putting them back on the todo.

Hmmm so you need some way to move C before your actual commit. To make
it like a pseudo command, some kind of "git rebase --reattach C
--after A"? This seems closer to your original idea.

Or why not modify "--edit-todo" to get commits from before your actual
point? It could works like this:

Before:
```
#pick b2a96fe O
#pick acb7459 A
#pick 0dac4a4 B
edit 1f54e51 C
edit cda2a7e D
```

After:
```
#pick b2a96fe O
edit 1f54e51 C
pick acb7459 A
pick 0dac4a4 B
edit cda2a7e D
```

So that you are still at C, but keeping the changes you made before on
A and B, and going through them only if you have conflicts.

If I understand your problem correctly (I hope), the more I think
about it, the more this modified "--edit-todo" makes sense too me.
Moreover, no problem for aborting, no big conceptual change, no change
in the way rebase works. Only --edit-todo is enhanced.

It coincides with what you were saying at the beginning:

> On Fri, Mar 20, 2020 at 03:51:20PM -0700, Junio C Hamano wrote:
> > I thought that "git rebase -i" allows the todo file (i.e. list of
> > steps still to be performed) to be edited before continuing; would>
> your use case be supported by using that?
>
> Mostly, if I do it very carefully, which is why I thought it would
> be easy to add.
>
> I think I could manually add the commits to the start of the todo file,
> reset --hard to the old state, and rebase --continue.
>
> But cutting and pasting commit IDs from git log into the todo file,
> and putting fixup commits in the right place is annoyingly fiddly.
> That's exactly the sort of thing computers are good at.
