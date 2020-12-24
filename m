Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF9EC433E0
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 21:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 118E622C9D
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 21:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbgLXVCC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Dec 2020 16:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbgLXVCC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Dec 2020 16:02:02 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382F1C061573
        for <git@vger.kernel.org>; Thu, 24 Dec 2020 13:01:22 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id g1so2814817ilk.7
        for <git@vger.kernel.org>; Thu, 24 Dec 2020 13:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WQjr9EwdoGUm1gnsGSILCHu8LwK8XH8nUsz3gKl17wI=;
        b=cN70iyRBlR8XsqdNkGxwZFKZi7RqrsYoviHoCBtd6JupvAaBmIL5ccrgsVt3lt+Dd8
         gVGiIBGe2gY3GKC0PE8j3DtMSV10lZspNrnJx/yPweyH/N+UQISyqNwEB5v2GaPX8bHF
         N8bMRrIyiWmaL/Der8YonaeU4pPL5gKM3bONss0vsDXucY9kqiwotvp/lV8i7ek3LDJr
         sZl8ePHuJj/uv8dHB5lSB8MTc61ke8N0SGR0DGkHvietXjNPBrMMrYcwIHBcG22zA+8f
         7nGC9rLu6dHkFTKWM1/DuyQuaQZwMRC6XXfHQFkunCOmP0XbccHaljkKQoZn3KowAAIU
         bN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WQjr9EwdoGUm1gnsGSILCHu8LwK8XH8nUsz3gKl17wI=;
        b=O7S4qSlsMpG0cHtMbK4dB5xmStgf+vhqtX8I9w7Hp0Ta4MciNBA9ubycVNKejPoKAG
         gKhnVnhlD3WsUORwgvNphyGFgS7FpxYsnTWqUFDHmWI4rf3oitSPin9qmigwrodlQ44L
         le9Ox7H5ZmTpQF0gOzJQBc6YYn7f3xlhmm7wvflDvr+idUh9svvvEs8MFDD8ECTXtsTX
         uzbMlJBS+qxSQ1+mcR8yHT31LNwtry2GQ/s6OqHRpK1GzmE87WKdWPHZN3z0KWNazdZR
         QPzrSP2YUS2H3Pd9qzvur2cHdy5tF5EhMxLy2VM5biu+ri5s1TOm2CX6DNAg9Ux+qBL5
         2SMw==
X-Gm-Message-State: AOAM533nOqccM0HSpLBQRglqcFRWHLTSBWO+xk/RKPn2CaAIFg73Hhq5
        ot3BZ21knnKBaeHzlHs7m35N45BIt9iFKZvMX7s=
X-Google-Smtp-Source: ABdhPJwA/JUGQamcfFoNFLcXEpV23qLDxG3BPPqWQnzAQN3+FQJ7N6zdGKLJmfuzHHTSbEc/K9laGSA5rpNQsfqOBI4=
X-Received: by 2002:a92:444e:: with SMTP id a14mr31133458ilm.129.1608843681455;
 Thu, 24 Dec 2020 13:01:21 -0800 (PST)
MIME-Version: 1.0
References: <20201217175037.GA80608@ellen> <5fdc0e6dd79a7_f2faf208a1@natae.notmuch>
 <20201218023534.GA117762@ellen> <5fdc18a91c402_f2faf20837@natae.notmuch>
 <20201218054947.GA123376@ellen> <5fdc7a7d3a933_f4673208d0@natae.notmuch>
 <20201219001358.GA153461@ellen> <xmqq1rfmqc8g.fsf@gitster.c.googlers.com>
 <20201221042501.GA146725@ellen> <5fe033e0ec278_96932089d@natae.notmuch>
 <20201221073633.GA157132@ellen> <CAJDDKr6LrBMyfdp5Tutp29W9OqhbW4ffcP5e6PD8ruyxk3rQxA@mail.gmail.com>
 <5fe134eeaec71_11498208f9@natae.notmuch>
In-Reply-To: <5fe134eeaec71_11498208f9@natae.notmuch>
From:   David Aguilar <davvid@gmail.com>
Date:   Thu, 24 Dec 2020 13:00:45 -0800
Message-ID: <CAJDDKr7bhnbr6NZfV28rJN5JrHkO+gZCLY_LkwiCxxBp=HWfbg@mail.gmail.com>
Subject: Re: Code of conduct violation?
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Seth House <seth@eseth.com>, Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        git@sfconservancy.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 21, 2020 at 3:51 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> David Aguilar wrote:
> > Just a heads-up that Felipe has a history on this list of creating
> > long, never-ending, pointless rant threads so sometimes the best
> > course of action is to ignore him.
>
> I think this can be considered a personal attack, which goes against the
> code of conduct.


Sorry Felipe -- there is no explanation that will satisfy you and this
is not the place to try and "make a case" for what was said. The
downsides of further engagement and messages that did not need to be
exchanged has already played itself out.

Please take this apology so that you can have the last word.  I am not
going to try and convince anyone that my response was appropriate.



> The code of conduct suggests behavior like:
>
>  * Being respectful of differing viewpoints and experiences
>  * Showing empathy towards other community members
>
> It seems to me the above comment is an example of the opposite.
>
> If you feel that my feedback is pointless, then don't engage with it.
> There's no need to put aggravating labels, especially on a public
> setting. Even if most people agree with you.
>
> I tolerate your opinion, but it's just that; an opinion.
>
> I think you should treat it as such (an opinion), and not blatantly
> disregard the viewpoints of people you disagree with, and worse;
> publicly suggest others do the same.


I could try and explain that being intolerant of my and others'
viewpoints and dismissing them as being inadequately defended or
non-existent is ironic, but arguing is a pointless endeavor.  I gave
you an honest, but inappropriate, response in public because being
honest and candid is a form of empathy, but that doesn't make it okay.

I appreciate your talents and tenacity. I can't ask you to be less
abrasive.  I can't ask you to not ignore the opinions of others.  All
I can offer you is my respect and an apology.

Sorry for saying that.

Much respect to you Felipe.  In respect for you, I will politely
refrain from responding to this thread.

Sometimes the best arguments are the ones that are not made.
-- 
David
