Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 843351F404
	for <e@80x24.org>; Thu, 19 Apr 2018 04:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751957AbeDSEqV (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 00:46:21 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:36835 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751184AbeDSEqU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 00:46:20 -0400
Received: by mail-wr0-f177.google.com with SMTP id q13-v6so10242961wre.3
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 21:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=efDOb/0JiqdGAAAKE0mWkLBTJQ28b34oDqgEdd59zhs=;
        b=p6hNsL4i3Yw1KOIYxeYQoI0QK2skP73LR22GxHjDxnCM74Bz7GJCNh4CnhiMEO5MPb
         JUt0MYLqIo+XfmqbB/feoumr9a/J5VMvnndpDqr0BcymdlOPp3Nk0kMmVeYszeO5GAFv
         IbMoR/qlsZxEKTcxIQmq36Y+EJdTkGnhWTCdV3Mwy3mkqrALphpqpSg9xO2xT0fDTsWG
         mZNi04epQjqiJ6zKyawrbuECJD5WV1OP+ll4if5GLBDx1T2ou/lPfQvY2VQXHszMzDI4
         Sv+McSTOn6Def86ozda6pFCY4PbUa9QVIEZZDA3sGjOcsVSFWk7fmyy/m4qdcCMLxkaP
         Bl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=efDOb/0JiqdGAAAKE0mWkLBTJQ28b34oDqgEdd59zhs=;
        b=nGQvvmH3UDfzac472Y7cHC5GxwXqBUHB3Uzmh3LF1fwdqcMhxpjLqoGvPWvcJ5onBs
         Be319aCWJH/nTSjxHsgU+PSyMFXQnaUHC6hQQrjLAjHiAt0DWA9pGINB6wUqVWol+BwY
         7sfV5CIyrj1jbonTxe0cJNoVHF00S0qE5Wy7PL5YfbcNfYnbZLc9/bTMF/RnXvTnIP+3
         /ZSRxA15ARhIcaeMfNqX/x8ToybYp+Lvo7h2P7jJ9g8fM9YjoYhOVPYdlfYJLCyf3IJ6
         zj0aKS/zby92d93UjE8wJL164roG+6oekf+vsgn0zJpjF/WYVClsgxponO5RACIvATeW
         JYCw==
X-Gm-Message-State: ALQs6tBjRCJp91kfheSs9QMPUV/TbjfT6WRalb3jBflQNBhQh79uJs2q
        qeI9n73mrFJhNCbVwWzujoI=
X-Google-Smtp-Source: AIpwx4/UiOvLwbgkZmjgZwdlpZIwl6BKrZhVeILqMsK2mL7s419SZUvIPbp2xgdj4WqQqUt9tBJxzw==
X-Received: by 2002:adf:8346:: with SMTP id 64-v6mr3448611wrd.151.1524113178675;
        Wed, 18 Apr 2018 21:46:18 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id i141sm4807202wmd.6.2018.04.18.21.46.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Apr 2018 21:46:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "Jeff King" <peff@peff.net>, Junio C Hamano <junio@pobox.com>,
        demerphq <demerphq@gmail.com>
Subject: Re: [RFC WIP PATCH] merge: implement -s theirs -X N
References: <87sh7sdtc1.fsf@evledraar.gmail.com>
Date:   Thu, 19 Apr 2018 13:46:17 +0900
In-Reply-To: <87sh7sdtc1.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 19 Apr 2018 00:48:30 +0200")
Message-ID: <xmqqpo2verc6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> We have a -s ours, but not a -s theirs. This is a WIP patch to implement
> that. It works, but I haven't dealt with this part of the internal API
> before, comments most welcome.
>
> The purpose of this is that I'm working with a rollout tool that is
> capable of doing hotfixes on top of old commits on "master".
>
> It does this by cherry-picking a commit from origin/master, and then
> merges it with origin/master & pushes it back, before finally reset
> --hard to the cherry-pick & rolling out.
>
> The reason it's doing this is to maintain the guarantee that all rolled
> out commits are reachable from "master", and to handle the more general
> case where original work is made during a hotfix, we don't want to then
> do a subsequent "normal" rollout and miss the fix.

This question has nothing to do with your "-s theirs" but let me see
if I got the above correctly.  Suppose you have a deployed branch
(say, "prod"), all developments happen on "master" elsewhere that
can be seen as "origin/master", so you may have a few fixes that is
not yet in "prod" you would want to cherry-pick from origin/master.

    $ git checkout prod
    $ git cherry-pick origin/master~2
    $ git cherry-pick origin/master

Let's say that "master" had a fix at HEAD~2, HEAD~1 is a feature
enhancement that is not yet ready for "prod", and HEAD is another
fix.  Up to this point you successfully back-ported the fixes to
"prod".

Then you do merge the tip into "master", i.e.

    $ git checkout origin/master && git merge -s ours prod
    $ git push origin HEAD:master
    $ git checkout prod

to make sure that the "master" at the source of truth knows that
it already has what our "prod" with these two cherry-picks have.

Is that what is going on here?

I am just wondering what would and should happen to the non-fix
commit in the middle in the above example.  Perhaps your workflow
automatically does the right thing to it, perhaps not.


[Footnote]

Obviously you can do this the other way around if you had "-s
theirs", i.e. instead of the last two lines from the above sequence,
you could do

    $ git merge -s nth -X 2 origin/master
    $ git push origin HEAD:master
    $ git reset --hard HEAD@{1}

but it is not all that interesting (at least to me) either way, as a
larger issue with the above I'd imagine people would see is that
even temporarily you would expose "master" material in that working
tree you usually have "prod" checkout.  That would irritate those
who consider that "push to deploy" aka "live site is actually a
working tree" is sensible more than the lack of "-s theirs" I would
think.
