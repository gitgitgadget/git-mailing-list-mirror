Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2037DC433E0
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 23:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D463B22B2D
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 23:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbhAWXpr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 18:45:47 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51398 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbhAWXpr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 18:45:47 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0897C9F3FF;
        Sat, 23 Jan 2021 18:45:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rETNu1XLcBnp+SBH3rCCYWuFAdQ=; b=gouGaM
        9Olyftg3gisn0mWN18LIazNzuwTmaJDoO1p5vETwO7hwh3CGphaLloOhttgXBixI
        7cmLXHSg3EWLYnwx5k0HH+NtXFQQnRHgu5pvZq4bFpP8rlR5Y2G3wFD26UVXH1F8
        s9+/ZQocooFbRGFcn0pA/HiWamZXJgzi6G0uk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DHosbiASZP14Z2uRsCKCguV2ZX+7tiLb
        IblNnBBJeURuuumla02IXK/dMvPmTFvbg3walr+YgSuUcOGHXhEZ1ubcotN83Xlx
        w84rhN28t9P9ccQ3EubUsSUp/OAINH+sdooSFJD7JFfhqgukoniKQzYMgLKlJluN
        D7Xc+8zpQ1A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DE5339F3FD;
        Sat, 23 Jan 2021 18:45:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2B8719F3FC;
        Sat, 23 Jan 2021 18:45:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jason Pyeron" <jpyeron@pdinc.us>
Cc:     <git@vger.kernel.org>,
        "'Philippe Blain'" <levraiphilippeblain@gmail.com>,
        "'Kyle Marek'" <kmarek@pdinc.us>
Subject: Re: [PATCH 1/2] revision: Denote root commits with '#'
References: <196101d6eab6$20714550$6153cff0$@pdinc.us>
        <20210117110337.429994-1-kmarek@pdinc.us>
        <20210117110337.429994-2-kmarek@pdinc.us>
        <xmqq7dobmfrq.fsf@gitster.c.googlers.com>
        <e0264a29-2112-f8c8-f066-2be445654d8e@pdinc.us>
        <xmqqwnwajbuj.fsf@gitster.c.googlers.com>
        <xmqqr1mij88k.fsf@gitster.c.googlers.com>
        <237aeef3-239f-bff4-fa17-5581092c8f51@pdinc.us>
        <xmqq1reginnq.fsf@gitster.c.googlers.com>
        <460257a2-478a-eb4c-f6fa-b1cc55384cd5@pdinc.us>
        <xmqqo8hkgl4h.fsf@gitster.c.googlers.com>
        <01fd01d6ef3e$92e43b10$b8acb130$@pdinc.us>
        <xmqq35yvff98.fsf@gitster.c.googlers.com>
        <009a01d6ef80$326572d0$97305870$@pdinc.us>
        <xmqqh7n74jdt.fsf@gitster.c.googlers.com>
        <057b01d6f1db$c46d7d50$4d4877f0$@pdinc.us>
Date:   Sat, 23 Jan 2021 15:45:01 -0800
In-Reply-To: <057b01d6f1db$c46d7d50$4d4877f0$@pdinc.us> (Jason Pyeron's
        message of "Sat, 23 Jan 2021 18:02:04 -0500")
Message-ID: <xmqq7do32p6q.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 02D700F6-5DD5-11EB-AE7B-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jason Pyeron" <jpyeron@pdinc.us> writes:

> One and the same issue. Placing an * directly above another * is the issue.

OK, I re-read the messages in the thread, and it appears that this
part from Kyle

>>>   
>>>             C
>>>            /
>>>           O---A---B
>>>                    \
>>>             X---Y---Z
>>>   
>>>   When graphing C..Z, git produces output like:
>>>   
>>>   *   0fbb0dc (HEAD -> z) Z
>>>   |\
>>>   | * 11be529 (master) B
>>>   | * 8dd1b85 A
>>>   * 851a915 Y
>>>   * 27d3ed0 (x) X
>>>   
>>>   We cannot tell from the above graph alone that X is a root and A is not.

was the only thing that argued that A and X (if the graph drawing
happend to place an unrelated commit immediately below it) should be
drawn differently so that you can tell X (root) and A (non root)
apart.

And you are saying (and it seems that you have consistently been
saying) that it is OK to draw A and X (again if other unrelated
commits were immediately drawn below them) the same way.  So I guess
all is well.  We do not have to use more 6 different symbols ("{#}"
to show commit above boundary, three more to show roots) but need to
introduce only three, if we were to go with the Solution #1 route.

It seems to me that Solution #2 is a special case of Solution #3 ;-)
They are both direct answers to the "graph drawn incorrectly can
imply ancestry that does not exist" problem.

Adding the "--decorate-roots" option that annotates the root commits
in the "git log" output can still be done, but that is an orthogonal
issue.  It does solve, together with any one of three options you
presented, the issue Kyle brought up, I would think.

Thanks.
