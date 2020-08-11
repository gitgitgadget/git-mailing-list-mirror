Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E22C433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 20:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BA2420771
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 20:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="h8X/NHc3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgHKU20 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 16:28:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58999 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgHKU20 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 16:28:26 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DE5CE8476A;
        Tue, 11 Aug 2020 16:28:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p8rQ1YkAh0mvAwX8BJeZ3ESyKYs=; b=h8X/NH
        c3ErQmFk2GPDCGEJLblc/oOZ5sktHz4iLFPuI9oA9OBzwLXi4Ua2UV4OzWDbu62A
        lfy0SgKHZG8XVaf6+nJFQXQw+AOUUTfCWacDfPvMFBnW79APZFYf2CkgXkh5Svky
        9irXZuUBwwAUlafyPYEp7lvc7ruo+pWTJ2a/4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VxIlkJiqxKeVeKsmtrkJ9q7WZc5/ynYj
        N3VtnNPTtKOJNbb/ExarRy37IOHJyMFRFUiRZDEUO271aNtTdf/DOwwBLA8MIc4B
        jGvebJzl+VRSkiaEic7DXsktrXTz48WJeq3ECvgRiAOy5R3VSInz+ey6HYA5kUXC
        BvJ5dBLohRU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D6A6B84769;
        Tue, 11 Aug 2020 16:28:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 53B5A84768;
        Tue, 11 Aug 2020 16:28:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2020, #02; Mon, 10)
References: <xmqqsgcub811.fsf@gitster.c.googlers.com>
        <874kp9biho.fsf@osv.gnss.ru> <xmqq7du59eb4.fsf@gitster.c.googlers.com>
        <87364t563r.fsf@osv.gnss.ru>
Date:   Tue, 11 Aug 2020 13:28:22 -0700
In-Reply-To: <87364t563r.fsf@osv.gnss.ru> (Sergey Organov's message of "Tue,
        11 Aug 2020 22:34:48 +0300")
Message-ID: <xmqqy2ml7wrd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3406505A-DC11-11EA-9094-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> And I asked you to postpone that in <875z9v7b0k.fsf@osv.gnss.ru> for
> which I got no answer. I repeat it here for convenience:
>
> "
> For now, can we leave these patches as-is and then add additional tests
> on top, please? I'm afraid that adding them now will force me to rewrite
> current descriptions, as the result won't be minimal anymore, and I
> feel uneasy about writing commit messages for these permuted tests
> anyway.
> "

I was expecting just one case I mentioned in the first message and
nothing else, which is crucial to highlight how --first-parent's
"implication" works with explicit --diff-merges.

Full "permutated tests" was what you brought up in the discussion,
but I already said it was overkill to your response before you said
the above.  The "minimal" would be the posted patch plus a missing
"first-parent comes before --diff-merges=off" test filled in.
