Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9219C352A3
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D34D2084E
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pyEKocNK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbgBOVxL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Feb 2020 16:53:11 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46109 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgBOVxL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Feb 2020 16:53:11 -0500
Received: by mail-ot1-f66.google.com with SMTP id g64so12555304otb.13
        for <git@vger.kernel.org>; Sat, 15 Feb 2020 13:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2MNpnF8AZHJAzgT63xTwGTNcbGeG/ECrkxcRlqk/Bng=;
        b=pyEKocNKb9nOQ8rSkkOVCBy37cYgacsE7uwRY/jcoREYNY3YQWHU68vN5b9qDu//p6
         dP+3kSbYsPwW6gB19hbwUv0D7BIXHG9hKu8Ko/vx9XqezAdrQKcfo+9ssaXQP3mqcY1+
         4obbeJ2vwfzq4PrBWuQ6kqU+VzBzn7UaBvVx1VdL8nOb9PTE3r6alnj5YWJry2ZmjP85
         KOpzwYP8qjA0zvE3sUfdIBAlbnyeTZ75Fw6weFKZdSAA0SaBuUhZwOa2Fx1EuBk8WrRa
         YYPzkPfikzw305ue0iaepu8Gz8GVpOtcRsXhjgAOKd+H1qGbAivw8DboxB3RdZM2NWQW
         Wrbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2MNpnF8AZHJAzgT63xTwGTNcbGeG/ECrkxcRlqk/Bng=;
        b=aBxtO+0Rvsf2CbWb8KKK+tp54hiceGz3HIboCb+QKyDJlGOHZjm5zgNu6Bcy/23b0c
         Fd2ODftFa+sEDP31XEwk8bm87BSTOVJUc5MHxjRxRc0+1mx7K1xH637Rxa0PqBEtY+u2
         RW89TtWHv2almaKnNcou2FrjxZXEhhCwYEOHKlm3+ZTghXFazZplcybHJEH96eievnvZ
         TQCsx9ozYqcA0ZBCg2WnSH0Ma7f33A8OYWwFoxLFzkKD4mPkc1bB6HY6Vvuny9QjBDt+
         r8O53b0B5d36CbKuwnS0K+ek9FNeevyly251K32UeBXA/HxYO1fah93LLjVTU0r6NFHy
         vx+A==
X-Gm-Message-State: APjAAAWzrrsvY8BnsFhEH0/NkQtuyEtsvZtKgBHCVFO03Pnl7cZMbt3H
        deWKdb5ZZjGFpALLegv+OzrCWiAgyfLONvTDHSDltuabjrM=
X-Google-Smtp-Source: APXvYqxirdWwlQ7pmO+JhgY8M/ns2su8scS7rjnB3P6qjjbTWnenliW2xhOnJxwNEaA37qUafzlRWRoKoATi+k0T5n8=
X-Received: by 2002:a9d:7f11:: with SMTP id j17mr7554044otq.281.1581803589320;
 Sat, 15 Feb 2020 13:53:09 -0800 (PST)
MIME-Version: 1.0
References: <pull.535.git.1581620351.gitgitgadget@gmail.com>
 <d156d04ca87f9fcffb1c08a08576dddcdc64c055.1581620351.git.gitgitgadget@gmail.com>
 <xmqqsgjeqm6w.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.2002141252050.46@tvgsbejvaqbjf.bet>
 <xmqqpnehp5x4.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqpnehp5x4.fsf@gitster-ct.c.googlers.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Sun, 16 Feb 2020 03:22:48 +0530
Message-ID: <CA+CkUQ-PERGy8xJ-a=5kzbN+N9f4uVQ35Hc4Aob70gJGz++fKQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] t5509: initialized `pushee` as bare repository
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 14, 2020 at 8:33 PM Junio C Hamano <gitster@pobox.com> wrote:
> If the series is fixing two bugs, perhaps 2/3 can first fix it for a
> primary worktree case by seeing what HEAD symref for the primary
> worktree points at is the target of a push without iterating over
> all the worktrees, have the test change in 2/3 (i.e. "fixing the
> 'unborn' case revealed a wrong expectation in an existing test"),
> and a couple of new tests to see what a push from sideways would do
> to an unborn branch that is checked out in the primary worktree when
> .denyCurrentBranch is and isn't in effect.
>
> Then 3/3 can use the same logic to see if one worktree is OK with
> the proposed ref update by the push used in 2/3 (which no longer
> uses refs_resolve_unsafe()') to check for all worktrees.  The new
> tests introduced in 2/3 would be extended to see what happens when
> the unborn branch getting updated by the push happens to be checked
> out in a secondary worktree.

As far as my understanding goes, what we want is:
1) fixing `.denyCurrentBranch` for unborn branches in primary worktree. (2/3)
2) writing test (expect it to fail if `unborn` & 'non-bare' case) (2/3)
3) making `.denyCurrentBranch` respect all worktrees. (3/3)
4) extending tests written in step 2 for secondary worktrees. (3/3)

Correct me if I'm wrong.
As I'm not entirely familiar with working and structure of
`.denyCurrentBranch`. So I might need more explicit explanation.

Thanks,
Hariom
