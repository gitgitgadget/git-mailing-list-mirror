Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8253C433EF
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 16:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbiCMQH2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 12:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiCMQHZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 12:07:25 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274F91275C
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 09:06:17 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id y22so16722515eds.2
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 09:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=hjXdZ/2XDsvTi+OoC54X53ccvqGrg9v5BjZyaEJNH2U=;
        b=drQqqXZ1lswBlVpCEimB4QASLvZoLLBmQgkEZuHCfVKsjcescSDX5YT/dOmgErpfIU
         8gIA0pGHIeLTiyO7vCMVcqlZcI7po/kUJWqB6O0wZPnoEKkjpk9OszVfsOFBK95i1+AD
         pKEvDNo3tNj1brsHNEnKvEWH96vg/o2hnwVhiaSVcssMFd7fIvE3aOxICAs34DxABvtK
         msxIWr7yNDAH+57ikrl0u79rWv15WYtRoQflnd0dRrvsnfe88yInZjbI1FQ/V4I7yCiY
         NIa0oGS2ALYgT8PLed/pPrCkPxfXWc8mCe+TxAFNrns7dc2uqJK+n7vdV1THxcPahT43
         Mzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=hjXdZ/2XDsvTi+OoC54X53ccvqGrg9v5BjZyaEJNH2U=;
        b=zlxNSqWQQM3kUD2V9o2Mppvb726WWWa/gVuhVJU2Gv0qx5oarVuCcA+ww500VhwK2l
         4pba5Vu2hWOiVnodBdmMgqSOJJI4sTH3yPdngY86kXn5/egABu8NnX5jxSqt0Sr/UMx9
         1P95JSTwyjBkF6Ez29KiQlOQJdnuJShGIfBVi8s2ZNMSKY0KW2YAlOy3qsg1nx0IzomD
         i1FWz9l/mqpNWoOyLYlJReAYET1IQOemiO8PwsCvbZQfOZqEf/8EDMKtIclpBshjB1Cu
         BI1bZO4ZaBy/PmtuOk0gSWkbho8pyHZerENLoVkkPJTsNsHKfkbDkcSbUIEFLE7eYbdr
         4ORA==
X-Gm-Message-State: AOAM5320E4ONce8FcM8Zz0/Za21YPa/I8oHvw/rO2M2iy2EDQc9q8V08
        INeQSdaHmWVAeeVj+UEjLYE=
X-Google-Smtp-Source: ABdhPJxE6Hep0c1jcD+J8HFoUrPTOfEr2bmf8t8+qwhEloVj4IAeCygnuAioGgj3gMcbtEbARkEggA==
X-Received: by 2002:a05:6402:79a:b0:415:fb66:fb5e with SMTP id d26-20020a056402079a00b00415fb66fb5emr17210071edy.386.1647187575364;
        Sun, 13 Mar 2022 09:06:15 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r19-20020a17090638d300b006d6e4fc047bsm5754581ejd.11.2022.03.13.09.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 09:06:14 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nTQjW-000HOq-1B;
        Sun, 13 Mar 2022 17:06:14 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Sean Allred <allred.sean@gmail.com>
Cc:     git@vger.kernel.org, sallred@epic.com, grmason@epic.com,
        sconrad@epic.com
Subject: Re: Dealing with corporate email recycling
Date:   Sun, 13 Mar 2022 16:51:05 +0100
References: <878rtebxk0.fsf@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <878rtebxk0.fsf@gmail.com>
Message-ID: <220313.86k0cxg7m2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Mar 12 2022, Sean Allred wrote:

> We are currently replaying a 15-year SVN history into Git -- with
> contributions from thousands of developers -- and are faced with the
> challenge of corporate email recycling, departures, re-hires, and name
> changes causing identity issues.
>
> * Background
>
> As you know (also to validate my own knowledge/assumptions), a Git
> commit stores identity as a name and an email.  The only means to
> validate this information is via signing; commits are otherwise taken
> at face-value.  This seems pretty core to Git's decentralized design.
> So to identify who is responsible for a commit, you have only the two
> name+email pairs.
>
> The problem in a nutshell: names and emails change over time.  The
> simple cases can be handled by gitmailmap, but there are more
> challenging cases:
>
>   - A commit author might have had some email <one@corp.net>, but then
>     was able to 'upgrade' to <two@corp.net> after a departure.
>
>   - It's even possible that this departure might 'boomerang' and
>     return to their old job, albeit now with a different email (since
>     they forfeited <two@corp.net> upon departure).
> [...skip a bunch of details...]
> You're at the end now; thanks for reading :-)

Aside from technical solutions and twists on mailmap, you haven't
*really* described what practical problem you're facing here.

> Somewhere down the line, Ada has left, <foo@example.com> transferred to
> Roy, and he wrote the following commit:

I.e. this, sure, that can happen, but what's the negative effect of that
in practice?

I've been involved in similar migrations in the past, and the primary
way to deal with it was to mostly ignore it, especially in a corporate
setting.

I.e. sure, you'll have some edge cases here and there, but the value of
knowing who exactly authored something tend to be proportional to how
recent the commit is.

If someone wrote something 10 years ago they're probably not even
working there anymore, or if they are will long since have forgotten
what they need to know to answer any specific questions etc.

The only people who tend to look at it are developers using "git blame"
or something, and usually humans are smart enough to spot that even if
it's foo@example.com they were expecting Roy, not Ada, or the other way
around.

Side note: To the extent that I've had to deal with this (in a corporate
setting) I found myself wanting git to have the exact opposite,
i.e. some feature where we'd just hide the author for anything any work
that's >5 years old or whatever.

Not for any privacy reason, but just because some UI's wouldn't really
communicate (in a way that people actually noticed) that the relevant
work was ancient, and someone who'd since long-moved-on would get
occasional interruptions due to ancient code they wrote but weren't
equipped to currently maintain.

Or similarly, to have anything >N years old "git blame" to the team
currently maintaining that thing, not to the person.

But I digress.

Having said that I think if you do need such a back-annotated history
you should look into "git notes" and/or "git replace". I.e. you could
have some lookup system maintain a mapping from OIDs to current IDs.

I've implemented a system like that in the past (in a MySQL table, but
whatever). I'd think this use-case of perfectly annotated old history is
probably obscure enough that that's the primary thing we should steer
people towards...

>   1. As far as I know, the mailmap format is pretty well-established.
>      I don't know how additions/extensions to the format will be
>      interpreted by other tools.

It's perfectly OK to change parts of that format in
backwards-"incompatible" ways, i.e. there's enough leeway in the
existing format definition and in-the-wild readers to have new readers
pick up new information that old readers will ignore.

I.e. we simply ignore things we can't map now, so one way to do it is to
start with something that produces an invalid (but harmless) mapping to
current readers, another is to borrow a trick from "/etc/sudoers" and
(ab)use the comment syntax.
