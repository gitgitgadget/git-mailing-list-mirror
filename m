Return-Path: <SRS0=Ralj=CP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E61C433E2
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 21:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 012CB207BB
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 21:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="g49A8MGT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgIFV7g (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Sep 2020 17:59:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53766 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgIFV7f (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Sep 2020 17:59:35 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0A9B86F3F7;
        Sun,  6 Sep 2020 17:59:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=DkRkdTBtg9Hk5xxb6Rl5PPAcj08=; b=g49A8MGTxB2XqfvckHRb
        sW1J6Zkiq49EvyXQT2tS/rjydpi0IHQyQb+KiGoPxCmDN24UMivbs+whzDImM3UX
        VNtlGZiCvXJZyinpGoHxda0Hj/2mcaA1fMxPB7rQvf8CDdRkmEQjM+UPbewLiOHu
        LASZ8hYhNKsCCCuRoMouxrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=g702Vn7EqI/9O+dWKKO+CnTrwuUeYQDfjywgvO69+RQdQA
        2WmIrCT0zftjyLaaHYXePWTtZAsv1mj08xI0+/r4A8fYVvC5URB7jgQVV5+rwNXo
        9gh2nkja9VZovBpu3gaqwghBJG4KNhmlsBrLkjZjaHmGeaPmyY6j22pT/TKDM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 016D86F3F6;
        Sun,  6 Sep 2020 17:59:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 808356F3F5;
        Sun,  6 Sep 2020 17:59:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Beat Bolli <dev+git@drbeat.li>, git@vger.kernel.org
Subject: Re: [PATCH] pretty: allow to override the built-in formats
References: <20200905192406.74411-1-dev+git@drbeat.li>
        <20200905195218.GA892287@generichostname>
Date:   Sun, 06 Sep 2020 14:59:32 -0700
Message-ID: <xmqqeene36t7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3EA70EF2-F08C-11EA-9367-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Hmm, I'm not sure how I feel about being able to override formats other
> than "reference".

Is the idea to introduce a parallel namespace to pretty.<name>?  I
am not sure why that is a good idea than, say a single variable that
says "to me, pretty.<name> would override even the built-in names".

I am not sure how I feel about being able to override built-in
formats in the first place, though.

After all, pretty.<name> were introduced so that user-defined ones
can be invoked with an equal ease as the built-in ones, but
overriding common understanding among the users of the tool is a
different story.
