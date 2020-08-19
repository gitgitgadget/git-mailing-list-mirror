Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35C0C433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 15:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC5752063A
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 15:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="N6s6sQ1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgHSPvn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:51:43 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54232 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbgHSPvm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 11:51:42 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1F478EED4E;
        Wed, 19 Aug 2020 11:51:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HCaeutmvndY44E0mCNch040Rcl4=; b=N6s6sQ
        1eVqe4N1THVWCOxb4joV2S9Q1cecjJ1Cwgp+OxBSTDTpv7mC0nKF5OkxTV87HdlO
        GBlaCHRGazdXniWnKLzpWtdk7SE2QjakHCtmkPcu9l044TzEFq4mr0dAvC3dcmg7
        KisW74akDvUD/Su40yvZEI1XGrH1m0ptgAUtk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=W5kXlTD11Br3M6zFFrvra7LvzOv/6j0H
        eSOoSonZZ8+ogAOFrN67M8HR8Ze2MWjG9/EQDOnrOzC57qdxkp8XHd5s7m/lAoRD
        NCfB8pGBB6O1dCVERYWzfnKUpclzi/PRY9Tg2+y7nLjw2HjbZIK/1dikVYv7o4O8
        Kig7EEEQIs4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 17A8FEED4D;
        Wed, 19 Aug 2020 11:51:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 139FDEED4C;
        Wed, 19 Aug 2020 11:51:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v8 2/5] am: stop exporting GIT_COMMITTER_DATE
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
        <20200817174004.92455-1-phillip.wood123@gmail.com>
        <20200817174004.92455-3-phillip.wood123@gmail.com>
        <xmqqtux113z6.fsf@gitster.c.googlers.com>
        <2ad142e6-5f2c-7e05-c8d3-ab6efcfc7058@gmail.com>
Date:   Wed, 19 Aug 2020 08:51:33 -0700
In-Reply-To: <2ad142e6-5f2c-7e05-c8d3-ab6efcfc7058@gmail.com> (Phillip Wood's
        message of "Wed, 19 Aug 2020 11:20:30 +0100")
Message-ID: <xmqqr1s2vdkq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DC085F1E-E233-11EA-B27D-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> For am and the sequencer fmt_ident() is in a function which is called
> from a loop and it is convenient not to have to worry about passing an
> strbuf around or allocating and freeing it on each function call

That's strbuf on caller's stack, right?  The actual string pointed
by the strbuf's buf pointer will be needed and on the heap with or
without the clean-up on top of the patch we are discussing, so I do
not think alloc/free would be in the picture when considering the
pros-and-cons.

> The callers in ident (fmt_name(), git_author_info() and
> git_committer_info()) return the string so they would need their own
> strbuf or have to be changed so the caller passed one in. There are
> quite a few callers of those functions and they seem to either
> immediately call split_ident_line() or duplicate the returned string
> (mostly the latter).
>
> So it would be a bit of work to do it but not an enormous amount
> (assuming we don't change the signature of git_author_info() etc in
> ident.c, although given the pattern of callers it might be worth doing
> that if they are mostly duplicating the returned string anyway)

I'd say that is more than "while at it" clean-up.  It would be
easier to review and slightly easier to do if done before this patch
introduces rotating strbuf, but ...

> I'm going to be off line for 10-14 days from the beginning of next week,
> I could take a look at it after that, or we could leave it for a future
> improvement - what do you think?

... I can be talked into punting it for later, at least for now.

Thanks.
