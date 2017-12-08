Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 895B81FC34
	for <e@80x24.org>; Fri,  8 Dec 2017 20:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752919AbdLHU6L (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 15:58:11 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53870 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750908AbdLHU6K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 15:58:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D7DD2ACD90;
        Fri,  8 Dec 2017 15:58:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y8o856PPJPdcBbV8YvjTNchTaJg=; b=PhbYJ4
        G52BEWtfZ5tSXCsc25SxCUWVA/Yv+PQfSrkHko1wE/iKf0MzNJPfLrr04PTEO1wy
        VmGOOGBoJ1fibmrNdZ7GruHq8J5s2UhRm5UmLu0U9Q5tcPuk1aJE/ycSCcGrUorP
        4/2vqvcKgjxOBgeoaa866vKlZl/kZo5rFLkGo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sxuMMu4wVTnaH5DOHI0tBLLwgrczuyFT
        +jEug0RLa+I1CN0QscRyoWBDMqhgZXsnIMjUS1Ik5z34R7ltyjtDvT0H6v3Y/7Wo
        ixPylayBTtveRKaqCuw+wQBcoHfAJ3DNc8ei0B36Vm6sOD0mSZpRo0NjTRmk1ET9
        Bog53+oWQSE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CF864ACD8F;
        Fri,  8 Dec 2017 15:58:09 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 472D8ACD8E;
        Fri,  8 Dec 2017 15:58:09 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2017, #02; Thu, 7)
References: <xmqqfu8me7ot.fsf@gitster.mtv.corp.google.com>
        <20171208054934.GA17893@tor.lan>
        <alpine.DEB.2.21.1.1712081227080.4318@virtualbox>
Date:   Fri, 08 Dec 2017 12:58:08 -0800
In-Reply-To: <alpine.DEB.2.21.1.1712081227080.4318@virtualbox> (Johannes
        Schindelin's message of "Fri, 8 Dec 2017 12:38:20 +0100 (CET)")
Message-ID: <xmqqmv2t6iov.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7EF22350-DC5A-11E7-8F6D-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> We might want to consider using a saner Continuous Testing workflow, to
> avoid re-testing (and re-finding) breakages in individual patch series
> just because completely unrelated patch got updated.
>
> I mean, yes, it seemed like a good idea a long time ago to have One Branch
> that contains All The Patch Series Currently Cooking, back when our most
> reliable (because only) test facilities were poor humans.
>
> But we see how many more subtle bugs are spotted nowadays where Git's
> source code is tested automatically on a growing number of Operating
> System/CPU architecture "coordinates", and it is probably time to save
> some human resources.
>
> How about testing the individual branches instead?

We would benefit from both, so not "instead", but "in addition"
would make more sense.

Even if a topic passes a test in isolation, the job of the developer
who originally did that topic does not end there, as the topic may
break in presence of other topics in flight when tested together
with them, and because a project is a team effort, we expect those
familiar with the topics involved in such a breakage to all
participate in diagnosing and fixing.  

Ideally, in addition to the tips of these integration branches, and
in addition to the tips of topics, it would be nicer if we can test
individual new commits.  When we see the tip of 'pu' updated from A
to B, then

    git rev-list --no-merges A..B

would give us all individual non-merge commits that have been added,
and assuming that we have already tested commits back when the tip
was at A, these are the only commits that needs testing to see what
is broken in the new round.

I do not know how easy it is to arrange something like that, though.
What we currently run with Travis lets us limit the number of jobs
to the number of tentative integration branches; a scheme like that
would require quite a lot more test cycles, triggered by a single
pushout.

(Unscientific numbers)

    $ git rev-list --count --no-merges pu@{48.hours}..pu@{24.hours}
    10
    $ git rev-list --count --no-merges pu@{24.hours}..pu
    37

