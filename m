Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2589C433DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 21:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E392D207FC
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 21:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XkDZWuhf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgHCViX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:38:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64646 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCViX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 17:38:23 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 40B00856ED;
        Mon,  3 Aug 2020 17:38:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ewqzviCbJ9PY6XkBMdsL+N3CSSc=; b=XkDZWu
        hfqvT9yYw6S5DN7h2DG9nfAjPtuHWKQv4sndoVK99YAIHlsLa41dT56l574wzVSC
        T2HrNLOfzQlUzlT+fATAqLwhzj8DLmUWP/GA6JCfjiDctZJqpntByigXgXn7Lm8L
        JF+PCc4JbZUUxU0cT/NNrDNdwKSab9xFIHWhU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m1o+pP4GP+bNI4hLQTh+FpLkyGwWDn1d
        WVuIcKpTMNZZWkfmULq/ZjOWIxD+lD6KATCk+qO3vRsioQ66zj6CBvHhqBdW4for
        Xz00PJztzMkU/Xu/cUESSzk60sQz7VwIsLVHCHDjrTQClP6DN/SGCWvR+j15f5sa
        l86+Fn9k/WQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 36C6F856EC;
        Mon,  3 Aug 2020 17:38:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AF025856EB;
        Mon,  3 Aug 2020 17:38:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Matt McCutchen <matt@mattmccutchen.net>, git@vger.kernel.org
Subject: Re: Renaming the "master" branch without breaking existing clones
References: <ec960483f5008e9948271c678d51876920ab62c9.camel@mattmccutchen.net>
        <20200803160051.GA50799@syl.lan>
        <20200803194006.GA2715275@coredump.intra.peff.net>
        <20200803204503.GB2715275@coredump.intra.peff.net>
        <xmqq1rknv3xl.fsf@gitster.c.googlers.com>
        <20200803211112.GA2720049@coredump.intra.peff.net>
Date:   Mon, 03 Aug 2020 14:38:20 -0700
In-Reply-To: <20200803211112.GA2720049@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 3 Aug 2020 17:11:12 -0400")
Message-ID: <xmqqwo2ftnoz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A68CB10A-D5D1-11EA-B6B4-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But I do think a "branch renaming" helper like this might be useful for
> projects undergoing this rename. I don't think it makes sense to have as
> a first-class Git command, but I wouldn't be opposed to carrying
> something like it in contrib/ if somebody wanted to polish it up.

Absolutely.  

I think we three are on the same page now ;-)

cf. <20200803163958.GD50799@syl.lan>
cf. <xmqqlfivwvtw.fsf@gitster.c.googlers.com>

Now one issue I am not so sure about is if the only thing that needs
adjusting is branch.*.remote + branch.*.merge.

The open-ended nature of our design means it is _possible_ to be
reasonably sure to have covered everything we do in the core part of
Git, but it is certain for us to miss third-party enhancements.

An inevitable "why not do all that when 'git branch -r -m old new'
is given?" posed by those who are not aware of the design needs to
be shot down, which is unfortunate.



