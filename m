Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B5FC433DF
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 10:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8588320734
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 10:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Oz7lIUgC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgGQKTs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 06:19:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52822 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgGQKTr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 06:19:47 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 966F37DEE3;
        Fri, 17 Jul 2020 06:19:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=S6er19/3eEbq2UXsTxdME0CvbvY=; b=Oz7lIU
        gCILRmHSTun8jRnTUIpQSSBmDiKd70+kqJperVY2Qk86O8PNCxndgfR5pmLic0Dy
        5InpXu76Orrw5aGL68lvC9p7HsFYhzp4QMXJb49LA+ZIfCh/1r6C2G5kthnaOhUc
        BbhqeYgrN6bKxffEmJ84xKNbwbgIPaN7KuIrM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dK/+JC+9hAZHjx1WVbg55ZzWfrEgdsuQ
        O7mkyq/4xx842THvBkDEB1zkbnpNPD9GRS0gfLHLLQ+iXGTn1tTWolmQ5RTo59sj
        EnJ15w944SVomACVx9qFpUUy3rjz4LJ/1wz0336jF1sWQAmg/s0psgBtktOD+TGj
        t4t92RdQuS4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7DA317DEE0;
        Fri, 17 Jul 2020 06:19:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E4A237DEDD;
        Fri, 17 Jul 2020 06:19:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?5a2Z5LiW6b6Z?= sunshilong <sunshilong369@gmail.com>,
        Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org
Subject: Re: How can I search git log with ceratin keyword but without the other keyword?
References: <CAAvDm6Z2HcQkyinCD4hKTnqGR3gcXodhoo0YKSnbB-vDJcn3MQ@mail.gmail.com>
        <CAPUEspg=4HJL8iiNrNp9Wr9sVj5Gw_PciSezHV5iJ1w-ymdzdw@mail.gmail.com>
        <CAAvDm6avvkXrU-Q8zu7C5WFqfCbf0DN=6cPMU-rOxgmdAh1Ebw@mail.gmail.com>
        <20200716153159.GA1061124@coredump.intra.peff.net>
        <CAAvDm6Z6SA8rYYHaFT=APBSx0tM+5rHseP+fRLufgDxvEthsww@mail.gmail.com>
        <20200717063324.GB1179001@coredump.intra.peff.net>
        <xmqqd04ufutq.fsf@gitster.c.googlers.com>
Date:   Fri, 17 Jul 2020 03:19:44 -0700
In-Reply-To: <xmqqd04ufutq.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 17 Jul 2020 00:45:53 -0700")
Message-ID: <xmqq7dv2fnpb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 09077AE0-C817-11EA-8356-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> But none of that is exposed via the command-line of "git log". I think
>> it would be possible to do so, but I'm not sure how tricky it would be
>> (certainly one complication is that "--not" already means something else
>> there, but presumably we could have "--grep-and", "--grep-not", etc).
>
> Perhaps the definition of "distant future" is about 8 years ;-)
>
> https://lore.kernel.org/git/7vr4q45y65.fsf@alter.siamese.dyndns.org/

Having said that, I do not think our underlying grep machinery is
equipped to answer "find every commit whose log message has X but
not Y", even if we exposed the interface that is equivalent to that
of "git grep" to "git log".

There are two levels of boolean combination involved in running our
"grep" machinery.  The lower level is used to determine if each line
matches the criteria.  The main consumer of the "grep" machinery is
of course "git grep" and because it is line oriented, we have quite
a rich set of operations and combinations to say things like "if a
line has X and Y on it in any order, but not Z on it, then the line
is a match."  That is what "--not", "--and", "--or" (not exposed to
the "git log" interface) express and we even take "(" and ")" for
grouping, e.g. "( X --or Y ) --and --not Z".

Another level of combination is to determine if the entire document
matches.  It often happens that you want to find a document with
both X and Y in it, and "grep -e X --and -e Y" is *NOT* a way to do
so---the "--and" is a line-level combinator and tells the machinery
to find lines that have both X and Y on them.

We have a fairly ad-hoc single mechanism for boolean combination at
this level and that is the "--all-match" option, which says "Look at
the boolean expression you used to find each matching line, and
separate them at the OR operator at the top level.  Now, apply the
matching logic to all lines in a document and see if _all_ the
clauses joined by the top-level OR operators matched at least once.
If yes, then the document matches."  

That is how "git grep --all-match -e X -e Y" finds documents that
refer to both X and Y but not necessarily on the same line.

There is not much room for the line-level "--not" operator to
participate in this picture.  "git grep -e X --not -e Y" would mean
"find lines that has X, or that does not have Y", so as long as a
document has one line with X on it and one line (which can be but
does not have to be the same line) that does not have Y on it, the
variant of that search with "--all-match" in it would say "yup the
doc matches".  But that is definitely not what the user who wants to
say "if a doc has X in it, I want to see it, but I do not want to
see it if it also has Y" wants to see.






