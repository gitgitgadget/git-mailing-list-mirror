Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E6E620372
	for <e@80x24.org>; Mon, 16 Oct 2017 01:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbdJPBuV (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Oct 2017 21:50:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50907 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751721AbdJPBuT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Oct 2017 21:50:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9222698413;
        Sun, 15 Oct 2017 21:50:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZqSp/qj0fhlJVUwORjPPd4ekQo0=; b=PquMna
        8YaoITbJVzehWPfifIHUGtHi2tIOnR0M/mvKxXjX3ZUrqEU5CX3xj6rL0Lxyw1OZ
        LWLmcgOBy976HHp5US3yOaU0qtcZnVecBDGx41RlJ/TJ4V1OlmTs5TvjQSszKYQ2
        YO7qik03wW/mb3hzxDNmHfQ2ffoyWSYxKZOFo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LZsjdjJplxTylQ3lFn9M/1rMjgmoTUEj
        I4IIBMbbgGkWyiOpuH6S2k4gcQuzOncjIOKNcY//eOd8lpXvJM+E+exLhp7L3HiQ
        HjgaOUF0XHyUaA/IkyCuGfWRCoXhl/kjJ/xdK/NgWrQoXGXpyN7eiaW0meY6isNF
        ElD30dsThiA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A4F098412;
        Sun, 15 Oct 2017 21:50:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 08ABC98411;
        Sun, 15 Oct 2017 21:50:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Kevin Daudt <me@ikke.info>, git@vger.kernel.org,
        J Wyman <jwyman@microsoft.com>
Subject: Re: [PATCH v2 2/3] for-each-ref: let upstream/push optionally remote ref name
References: <cover.1506952571.git.johannes.schindelin@gmx.de>
        <cover.1507205895.git.johannes.schindelin@gmx.de>
        <7da6c7e2563d14cb7cd7ff2637c79c51896a9788.1507205895.git.johannes.schindelin@gmx.de>
        <20171013163923.GA5598@alpha.vpn.ikke.info>
        <xmqqinfiv5u2.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1710151804060.40514@virtualbox>
Date:   Mon, 16 Oct 2017 10:50:16 +0900
In-Reply-To: <alpine.DEB.2.21.1.1710151804060.40514@virtualbox> (Johannes
        Schindelin's message of "Sun, 15 Oct 2017 18:05:35 +0200 (CEST)")
Message-ID: <xmqqk1zvuahz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C96017A-B214-11E7-B0A3-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> >> -Also respects `:remotename` to state the name of the *remote* instead of
>> >> -the ref.
>> >> +Also respects `:remotename` to state the name of the *remote* instead
>> >> +of the ref, and `:remoteref` to state the name of the *reference* as
>> >> +locally known by the remote.
>> >
>> > What does "locally known by the remote" mean in this sentence?
>> 
>> Good question.  I cannot offhand offer a better and concise
>> phrasing, but I think can explain what it wants to describe ;-).
>
> Yep, described it well.
>
> Maybe "and `:remoteref` to state the name by which the remote knows the
> *reference*"?

I dunno.  

The original and your update both seem to come from a worldview
where there is a single conceptual thing called "reference" that is
shared between our repository and the remote repository we pull from
(or push to), and the name we call it is "refs/remotes/origin/devel"
while the name they use to call it is "refs/heads/devel".  If you
subscribe to that worldview, then the updated sentence might make it
clearer than the original.

But I do not share that worldview, and I am not sure (note: I am
truly unsure---it's not like I am convinced it is a good idea but
sugarcoating my expression, at least in this case) if subscribing to
the worldview helps users' understanding.

In my view "refs/remotes/origin/devel" is a reference we use to keep
track of (or "a reference that corresponds to") the reference they
have called "refs/heads/devel" at the remote, and these are two
separate entities, so it's not like "this single thing is called
differently by us and them".

Stepping back a bit; here is how the description begins.

    upstream::
            The name of a local ref which can be considered ``upstream''
            from the displayed ref.

So 'upstream' is like 'refs/remotes/origin/devel' in the example in
the message you are responding to.  Perhaps we can make it clear in
the description, and then add :remote* modifiers are about asking
where that remote-tracking branch comes from.  For example, instead
of these "Also respects...", something like:

    For a %(upstream) that is a remote-tracking branch, the name of
    the remote repository it is copied from can be obtained with
    %(upstream:remotename).  Simiarly, the branch at the remote
    repository whose tip is copioed to this remote-tracking branch
    can be obtined with %(upstream:remoteref) as a full refname.

may reduce the chance of confusion?



