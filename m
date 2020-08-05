Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B570FC433E1
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 20:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9542A22B42
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 20:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CkMOcgfV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgHEUNr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:13:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54834 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbgHEQX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 12:23:27 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7243074C2A;
        Wed,  5 Aug 2020 12:22:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mFi7tDS+H9jwuA3x7tgFyI1UAnY=; b=CkMOcg
        fVKiFKz8Vd4inTh3HRVe4UTiA7OHyEwDiGlH4Fz4g5EQ9gd+dDpm9DJX8sVxe/Gr
        iJ2a/D4XH9eFfvYKB0N+MzTHhk0LHFXgudtJ9JZccf6+0QPdb/kWLJMoE9cpLNxq
        8mh75Pqdm29XPCD2qBYeiSjoNASqlC8zoljWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Yp3gNlp5rrSryBYRWma3+fAs0EedbmLH
        dE3XKfo0BJpJBN9QkHRorzEJph9xakkw5a5x/KezHUO6ME/CRxmyFsTeG10fkEA1
        /tr8UqEXq3Xc+ZO8CDy8M2vj6DFb7bain0T1IwZsm/Y8YGRXiGoc0f7PqBC2GCP4
        kZfF6bcvYEg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 69F5474C29;
        Wed,  5 Aug 2020 12:22:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EE21D74C28;
        Wed,  5 Aug 2020 12:22:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: avoiding fetching specific refs from a remote
References: <CA+P7+xpokJ3Z4xZ9ibCBpBO65D1v-AD6_JknprGUsEDxEvMGGw@mail.gmail.com>
        <20200805063704.GA2690083@coredump.intra.peff.net>
Date:   Wed, 05 Aug 2020 09:22:47 -0700
In-Reply-To: <20200805063704.GA2690083@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 5 Aug 2020 02:37:04 -0400")
Message-ID: <xmqq1rkloyeg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E6952950-D737-11EA-93DE-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Essentially, because both main and master have similar names, tab
>> completion requires remembering to type one additional character than
>> I am used to.
>
> Heh, I didn't think anybody considered that implication so far; the fact
> that they were similar names has generally been considered a positive. I
> agree it would be annoying.

FWIW, I've been saying that 'maint' will become harder to type all
along ever since I heard 'main'.

https://lore.kernel.org/git/xmqqtuz9tq30.fsf@gitster.c.googlers.com/

> This is definitely a reasonable thing to want, and it has come up off
> and on over the years. One search term for the list archive is "negative
> refspecs", though it turns up a lot of useless hits when the two words
> are not directly adjacent.
>
> This old thread might be worth reading:
>
>   https://lore.kernel.org/git/20140124090104.GA396@x4/
>
> and there is even a patch in there:
>
>   https://lore.kernel.org/git/20140125013433.GA22336@sigill.intra.peff.net/
>
> but I didn't go over it carefully enough to know whether it is utter
> trash, or something that could be used as a starting point.

I think the idea is interesting.  I sometimes find negative
pathspecs quite useful, and I suspect negative refspecs would also
be.
