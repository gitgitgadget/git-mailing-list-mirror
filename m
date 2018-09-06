Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DA421F404
	for <e@80x24.org>; Thu,  6 Sep 2018 16:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbeIFVdl (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 17:33:41 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:45801 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728643AbeIFVdl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 17:33:41 -0400
Received: by mail-ed1-f51.google.com with SMTP id p52-v6so9412984eda.12
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 09:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jrl4dO3rgR/OtkYZ87yP7fb2uwj3G8IaYE1H+jM1XTY=;
        b=LWRbP3EqVFCH9YoKSf+Nl6C1NgQnEFwHNxdf+rld7ifRKystK7hgnDVp9fg7/b0uAC
         6y7mVub21IbQBkh8Z0mfQycbnX9bl91WNXV6SFcz0kQNEqgYbQR0P5+HwCM5+V9J7Wtw
         bBPSIZ5LlI5tpLlcBlWRxnU0uCegrHL/VpimxR91XzINOzehbFS9aYe3YqRylED30O00
         OVKOaVaI5kEO9zpvlKWHFVIBs8wFyKFT3TdIjsTcAXpyoUwYG4tPYrm/EKKgStWhDhn0
         pYn1yUWs7QAklrWzDHOQo51ujLhQT6dirK/hiv7ZgLZtG4IGGPqoDJ+b22N84JIAG0PG
         nGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jrl4dO3rgR/OtkYZ87yP7fb2uwj3G8IaYE1H+jM1XTY=;
        b=UIZQm705+3VQh4H0FMCBjmJusooNJdc45v+Bjz8Gf6UrSheuar3rHHRkobBoqkKeJe
         i9jMr4zmEIBEdg+KVuMMaqCnJ9Ookdw/IHp6l6Dv+PBJiet5qhM9H549NYOB0BFebJWc
         EhcJe0jJkhbrZ309mnbiBt43DF13R7SOa/wnPZR0q850UZFmFJEJEbYOC2/FnT/qJp3L
         h7eYPNbV5JGu9bDVrG38DH+UNVtlky6JFZSdHPXfX5wv4XRvyKVBEjLaqqKnadxxVb5p
         u2tm3b10xFHKBZtfCvQAxj6ABsz/gCupzksM0wd3w3rVVXLCQfwiSz4iQ6GRkuH7GR05
         YN9A==
X-Gm-Message-State: APzg51CzwgzaE9WH7CtZLCPt8PElXoRSkszMQ59lCnIHQ1qu+6FipRBs
        XRgehJFN1C0EseRTV3dUrX5z9l2E1NE86R3I+E5J2tVpwSM=
X-Google-Smtp-Source: ANB0VdbEMUQtuvEUS+Xdfg4g4TubFjDvP1dbQXY6vkP69cWJgRjoxO0KE9r4iTDP1ub0eVokDzDzmM0G7H1J2A2B9tY=
X-Received: by 2002:a50:d9c6:: with SMTP id x6-v6mr4627663edj.63.1536253037165;
 Thu, 06 Sep 2018 09:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com> <87lgc77wc7.fsf@evledraar.gmail.com>
 <CAGZ79kae4k=uLx-oX5emxas4KrqObzQhzgir0coOSBzzpO8APw@mail.gmail.com> <87tvn2remn.fsf@evledraar.gmail.com>
In-Reply-To: <87tvn2remn.fsf@evledraar.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 6 Sep 2018 09:57:05 -0700
Message-ID: <CAGZ79kYKzrRXy+GUCpMN3jpo4MvcpGvBFvEkTjrsy85XJb0K2A@mail.gmail.com>
Subject: Re: sb/submodule-move-nested breaks t7411 under GIT_FSMONITOR_TEST
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Ben Peart <benpeart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Will debug further.
>
> I spotted this again after testing the split index (see
> https://public-inbox.org/git/87va7ireuu.fsf@evledraar.gmail.com/) and
> was testing the fsmonitor test mode as well.
>
> So gentle *poke*: Did you get anywhere with debugging this? It's still
> failing on "master" now.

I started looking into this again, help would be appreciated, as I do not
quite understand the fsmonitor part.

The error is in the setup, where we have "git mv a b"

GIT_TRACE_FSMONITOR=1 GIT_TRACE=1
GIT_FSMONITOR_TEST=$PWD/t7519/fsmonitor-all
./t7411-submodule-config.sh -d -i -v -x
++ git mv a b
trace: built-in: git mv a b
read fsmonitor extension successful
add fsmonitor
refresh fsmonitor
trace: run_command: cd '/u/git/t/trash
directory.t7411-submodule-config/super'; /u/git/t/t7519/fsmonitor-all
1 1536252819824793728
fsmonitor process '/u/git/t/t7519/fsmonitor-all' returned success
mark_fsmonitor_clean '.gitmodules'
write fsmonitor extension successful

or with more trace_printfs littered through the code
(https://github.com/stefanbeller/git/tree/submodule_fsmoitor_debug)

trace: built-in: git mv a b
read fsmonitor extension successful
add fsmonitor
refresh fsmonitor
trace: run_command: cd '/u/git/t/trash
directory.t7411-submodule-config/super'; /u/git/t/t7519/fsmonitor-all
1 1536252497951329341
fsmonitor process '/u/git/t/t7519/fsmonitor-all' returned success
need to stage .gitmodules
calling add_file_to_index


I suspect that the FSMONITOR API is handled wrongly by the part of git-mv
that writes out the .gitmodules file (if needed) and the .git/index (as needed).

Ben, do you have an idea?

Thanks,
Stefan
