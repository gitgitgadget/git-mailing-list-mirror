Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E48120248
	for <e@80x24.org>; Wed, 20 Mar 2019 12:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfCTMBr (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 08:01:47 -0400
Received: from mail.javad.com ([54.86.164.124]:55203 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbfCTMBr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 08:01:47 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 2C5A13E89D;
        Wed, 20 Mar 2019 12:01:46 +0000 (UTC)
Authentication-Results: mail.javad.com;
        dkim=pass (1024-bit key; unprotected) header.d=javad.com header.i=@javad.com header.b=c/u9APDr;
        dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1553083306;
        bh=qtM5sAAI+UBeeqqBB9yUGnrs4ixkIMqY8eGa0PkEYek=; l=1283;
        h=Received:From:To:Subject;
        b=c/u9APDrujbfLJOutnI7ivRAhmTm69TrNkAwap3jJugDgTtnrsQlOms3NbUn6w7vx
         3x3QnSpUjhhAMDeNa1+5GA8aTC28kzpVj2LIBnndqVNx1PSMoYzA7rF9qjeT4q3foP
         Gorsis4zO//hQ34b7kwWFGV0szoJMWqCi6AnYJfk=
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1h6Zui-0002PT-Jh; Wed, 20 Mar 2019 15:01:44 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "C.J. Jameson" <cjcjameson@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH] cherry-pick: set default `--mainline` parent to 1
References: <CALm+SVJR5BCHi_r7B279gKDukD4mYDQuv=K5guje73YDVmOxug@mail.gmail.com>
        <xmqq1s32w3vu.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 20 Mar 2019 15:01:44 +0300
In-Reply-To: <xmqq1s32w3vu.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 20 Mar 2019 13:45:09 +0900")
Message-ID: <871s31vjo7.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

[...]

> But I do have a very strong opinion against adding yet another
> option that takes an optional argument.  If we want to allow
> cherry-picking a merge commit just as easy as cherrry-picking a
> single-parent commit, "git cherry-pick -m merge" (assuming 'merge'
> is the tip of a branch that is a merge commit) that still requires
> the user to say "-m" is not a good improvement.  We should just
> accept "git cherry-pick merge" without any "-m" if we want to move
> in this direction, I would think.

Let's just make '-m 1' the default option indeed. No need for further
complexities.

Exactly according to what Junio has already said before. Here:

https://public-inbox.org/git/xmqqsh5gt9sm.fsf@gitster-ct.c.googlers.com

Junio wrote:

> Now, it appears, at least to me, that the world pretty much accepted
> that the first-parent worldview is often very convenient and worth
> supporting by the tool, so the next logical step might be to set
> opts->mainline to 1 by default (and allow an explicit "-m $n" from
> the command line to override it).  But that should happen after this
> patch lands---it is logically a separate step, I would think.

... and as that patch already landed...

-- Sergey
