Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC7DC05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 23:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjBFXBb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 18:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjBFXB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 18:01:26 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C5E2CC51
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 15:00:52 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o13so13147173pjg.2
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 15:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hMBs1svWvXtPzUAeGtZvUs8cggwwrDwYeSp2z4hsCBo=;
        b=MBuL2A6J4maD/jXcoYMoHLGkuEiARaGOW1Doj9PRM1OgDOMOdFbMfbakOOQRYBdm6v
         1rY01zrB/b6S54EJTtoeK4Npa4kLg/LjaracKoJNcnPQId/l3bpuA1ZVO8z9d1D65N4P
         hOY3e4INzB59Qwvm9NwPkpz30E7XIV9sx+vKNUBPOfrSb3X0J3cDLsmpu8ktmt+FOzPW
         sP2ZH1KGuXGclxnZr50dokxkigPLLBadPvzhW27kx7DwivAOmWFKS7qpizcuoUps4bGs
         F29IUMt6QY/woeTca7QJE0vU0VFgC34fJK9/pI+DEFZBoa42ooYnQh3v81uono8pVYei
         U32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hMBs1svWvXtPzUAeGtZvUs8cggwwrDwYeSp2z4hsCBo=;
        b=G+Y6H+SyBfxUCH+jOK+LwiQHu0sItCZvn1iKapn38LVDGgKD3s6uO0Wfg7+W/OzXew
         mKSo4gIHHu81ECi3JcBRhtONAVWAbLh+G4shOL9kflLDwNySJhrmUsTR76HiRnkzoP3L
         43VfjGzDFfcy/MDfi3YksBFdbCr3xihU5ekfOUK7r3XdJYhiO8QYK3aN+/Y8Oevn/QyS
         /0O9na6sLId1IHuc7MQ9LmIa+lL7pA+fkjRmk9AePVIY+S5xgjRGdJXYHZXB2NlS1zON
         uyIGlbdolAnWWlui2IW7B3svR+lzXGvTnympSQqtYu/w1U29OJ0xHvdKGuBlS6ZbJmy1
         fVSw==
X-Gm-Message-State: AO0yUKXtky98Eh9qMu5HjQjt0SJ7INUBY5jjYnxGB2+xiUFFwF4d+fcu
        coP6EQUEckTc73A68MlIIXQ=
X-Google-Smtp-Source: AK7set9/yOYZPJ/px5Vas71/Qc00+YK3ftlLFD6nTynCnKHxlbn93EvGEIA4n0jAYrg/gSG1yPSqBw==
X-Received: by 2002:a17:902:d4c2:b0:196:49a9:bf26 with SMTP id o2-20020a170902d4c200b0019649a9bf26mr674201plg.15.1675724451498;
        Mon, 06 Feb 2023 15:00:51 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id s12-20020a170902b18c00b001949f21e1d2sm7357799plr.308.2023.02.06.15.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 15:00:50 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] Documentation: clarify multiple pushurls vs urls
References: <20230206195503.3113048-1-calvinwan@google.com>
        <230206.86k00u5ygg.gmgdl@evledraar.gmail.com>
        <CAFySSZCO7M8bm8Cc97x7MpZYHd0qWwRHF_YRDmw1rryF6Q7dnQ@mail.gmail.com>
Date:   Mon, 06 Feb 2023 15:00:50 -0800
In-Reply-To: <CAFySSZCO7M8bm8Cc97x7MpZYHd0qWwRHF_YRDmw1rryF6Q7dnQ@mail.gmail.com>
        (Calvin Wan's message of "Mon, 6 Feb 2023 13:12:06 -0800")
Message-ID: <xmqqfsbi2ycd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> If a user wants one url to push/fetch to, then he defines 'url'
> If a user wants to push to multiple urls, then he can either define

meaning "the user wants to push to multiple, but never wants to
fetch from the other ones"?  If so, then ...

> multiple urls or pushurls (one of the pushurls can be the same as the url).

... using multiple urls is not desirable as it becomes hard to tell
which one should be used for fetching.  

When you define additional places you want to publish to, you do not
expect to see that new definition affect where you fetch from.  In a
sense, using the first one to fetch, not the last one, gives us less
damage, for that reason.  Adding more URLs would not change where
you fetch from.

But still, I think what you gave is a good rule, regardless of the
answer to the "which among multiple non-push urls do we fetch"
question.  If we were designing this part of the system from
scratch, we probably 

 - would have forbidden multiple URLs, or
 - would allowed multiple URLs, but used the 'last one wins', or
 - would allowed multiple URLs, but and used later ones as fallback,
   only to be used when earlier ones fail.

It certainly is not a designed behaviour what we do when we have
multiple URLs, but if we haven't changed how we react to such a
configuration in the past (and I do not think we ever did), changing
the behaviour in any way this late in the game likely breaks real
users' configuration.

Thanks.
