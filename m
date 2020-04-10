Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACA7C2BA2B
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 11:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C312208E4
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 11:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kQzYZMpF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgDJLOr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 07:14:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59544 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgDJLOr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 07:14:47 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B98E6C69D7;
        Fri, 10 Apr 2020 07:14:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LIahu0u7lQokfxV3mGwSpNi6miU=; b=kQzYZM
        pFM2CQBoCesTQD65UEhDQuaoYAXTNbTXfVzn0bdzHqaErwTDau48bqIoMrSPp7Ze
        eYE0DBdKKk3McEMgfyg/K+ZBKdl1nFfccnoDu3b8ox6o7MF9T4nzgZLSSezWj6Ta
        Qt+5QRTu05kDCgEH5anfkmkgVErCN/yJh/jnk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=r5h4pcyBmMDr2LUuqWG8bnegx6Fqeksu
        SC3a85aqg/yB0pVZM6pKUqqZMFuAioopguto69q3jK8bd2xhz3Ab0RpM8k48Hv5H
        wQygr5WdDABtfS7M6EqTIyercgqiafSpm1f8gTBfJNuv7L25nLGxRSkIDDesk/ve
        14h5aRNLBKY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B2776C69D6;
        Fri, 10 Apr 2020 07:14:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0C996C69D5;
        Fri, 10 Apr 2020 07:14:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/3] Make the tests that test core.hideDotFiles more robust
References: <pull.603.git.1586374474512.gitgitgadget@gmail.com>
        <pull.603.v2.git.1586516583.gitgitgadget@gmail.com>
Date:   Fri, 10 Apr 2020 04:14:41 -0700
In-Reply-To: <pull.603.v2.git.1586516583.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Fri, 10 Apr 2020 11:03:00
        +0000")
Message-ID: <xmqq5ze7lhi6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7A601438-7B1C-11EA-9013-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Junio, I'm sorry that I did not get to send v2 yesterday, and that you spent
> time on the two add-on patches even after I finalized this second iteration
> (but I was first waiting for the PR build to pass and while that happened, I
> got stuck in meeting after meeting).

Heh, mails cross all the time, so there is not much to be sorry, and
it is not a race, and it's not much of an issue who sent an
equivalent patch to the list first ;-)

A few issues I noticed that are not worth pointing out inline with
the patches are

 [1/3] The "consolidate" is a bit uneven.  It keeps the 'windows'
       (lowercase) to pretend to be a pure code movement, while
       adding the "prereq or die" that makes it an impure code
       movement.  If I were doing this, this step would be pure code
       movement, and [3/3] would have the "prereq or die" as its
       main theme, i.e. make sure it is hard to misuse.  [3/3] would
       also do "s/windows/Windows/" as "while at it".

 [2/3] The test numbers on the title is no longer relevant, and I
       would suggest retitling this step.  No matter which test uses
       it currently, or any new uses added in the future to other
       tests, with this patch the helper is more robust, and it was
       the point of [1/3].
 
Thanks.
