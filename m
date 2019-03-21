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
	by dcvr.yhbt.net (Postfix) with ESMTP id DF7A9202BB
	for <e@80x24.org>; Thu, 21 Mar 2019 06:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfCUGM6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 02:12:58 -0400
Received: from mail.javad.com ([54.86.164.124]:43673 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbfCUGM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 02:12:58 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id E996540E7C;
        Thu, 21 Mar 2019 06:12:56 +0000 (UTC)
Authentication-Results: mail.javad.com;
        dkim=pass (1024-bit key; unprotected) header.d=javad.com header.i=@javad.com header.b=ZY+aPC9v;
        dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1553148777;
        bh=RBzJeAXduCPUK0m7dcl5Fw2tWx4En9gQk7+pN5hoQ8g=; l=1148;
        h=Received:From:To:Subject;
        b=ZY+aPC9v4urw/ua3XUdT0uZogn7BlNYgI+FW996RfHMb85DRqgjEyVxJo0pyHxvBh
         L2++wBs2eY6EkVRKazgUEvF+/tKDrXdvmTUa/HgdwJSsJgiJCHr2O9XCVoJNEuDTO/
         7qqdiyQGPEQmv5kldJzuBQpGrYc5J1frHbS+eZdc=
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1h6qwh-0003Od-D3; Thu, 21 Mar 2019 09:12:55 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        "C.J. Jameson" <cjcjameson@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC PATCH] cherry-pick: set default `--mainline` parent to 1
References: <CALm+SVJR5BCHi_r7B279gKDukD4mYDQuv=K5guje73YDVmOxug@mail.gmail.com>
        <xmqq1s32w3vu.fsf@gitster-ct.c.googlers.com>
        <871s31vjo7.fsf@javad.com>
        <CABPp-BEe56GFM_2g7EyXmSrULFwRAvSPBomQ66jEQmCs=HhWpg@mail.gmail.com>
        <xmqqd0mlt1h1.fsf@gitster-ct.c.googlers.com>
        <xmqq4l7wuddk.fsf@gitster-ct.c.googlers.com>
        <87pnqklr8a.fsf@javad.com>
        <xmqqlg18srrp.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 21 Mar 2019 09:12:55 +0300
In-Reply-To: <xmqqlg18srrp.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 21 Mar 2019 14:47:22 +0900")
Message-ID: <878sx8lpqw.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>>> To put it a bit differently, I share with you that picking merges
>>> should be deliberate and it is safer to make sure allowing it only
>>> when the told us that s/he knows the commit being picked is a merge,
>>
>> Something like "--[no-]ban-merges" then [*], having "--ban-merges" as
>> default?
>>
>>> but when we started allowing "-m 1" for non-merge commits in the
>>> current world where cherry-pick can work on a range, the ship has
>>> already sailed.
>>
>> Except that it could be a different ship, provided we've got
>> "--ban-merges". Having "-m 1" as default stops to be an issue, and
>> explicit "-m 1" could then imply --no-ban-merges, that could be in turn
>> overwritten by explicit "--ban-merges", if necessary.
>
> The same effect can be had by just reverting "let's allow -m1 for
> single-parent commit", can't it?  That is a far simpler solution, I
> would say.

Those one didn't introduce the issue currently at hand, as we still
don't allow merges by default, so why do we need to rewind it?

-- Sergey
