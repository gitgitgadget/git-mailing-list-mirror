Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E44C2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 21:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81BC9206D9
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 21:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LKxJx/AY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbgKWV2l (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 16:28:41 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55225 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbgKWV2k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 16:28:40 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D40B28D010;
        Mon, 23 Nov 2020 16:28:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PNR4B3rW9pDUfojmt1whu7QeeWM=; b=LKxJx/
        AYjuFFydollWO124+dSWeDHN2fLwK45aGaYQ0mZPrswjTNM7/D6aCrIu8e8G5YBk
        ODD7X+ap2mgGn8rer0fuh9f+8ESdxWoe0EgDF7xoAMffwdjfcaFXnsQ7xoS8OB+P
        BJ1jW3xiNPjfp7Q46WU2Yrx2Dhg3os0BzynGw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SwVfuIG9BhKG4+lpz+tSrKbMFKkfetno
        lw82kDxiyjNFzOg+J5X3WZQ91h1Xx5qUQb3j9UTZYP8Y4FoTJf8vSfIjm4yfW1Dp
        3bpJ2BzZn+my6euTQScGPBTMBPpIxURgJI4RjdrDFPLhw4T5JUrvRN0AGSeUtSj8
        0YCHua/TIF4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC64D8D00F;
        Mon, 23 Nov 2020 16:28:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5B1EC8D00D;
        Mon, 23 Nov 2020 16:28:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] init: provide useful advice about init.defaultBranch
References: <pull.921.git.git.1606087406.gitgitgadget@gmail.com>
        <253d6706e6ab97e71ec012f6de33c75f3e980701.1606087406.git.gitgitgadget@gmail.com>
        <xmqqft51osnu.fsf@gitster.c.googlers.com>
        <xmqq4klgq10d.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2011231326150.56@tvgsbejvaqbjf.bet>
        <xmqqv9dvor27.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2011232136191.56@tvgsbejvaqbjf.bet>
Date:   Mon, 23 Nov 2020 13:28:36 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2011232136191.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 23 Nov 2020 21:46:09 +0100 (CET)")
Message-ID: <xmqqsg8zn4or.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D91D25EC-2DD2-11EB-8CE1-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hmm. I would like to believe that readers understand that setting it to
> _any_ name would suppress this warning.

Yes, and the point raised in an earlier messages was that it is not
clear that there is no recourse for those who do NOT want to choose
but still want to suppress.

> It really is much better to make `git branch -m <name>` work in this
> scenario.

Yes, if we can make it work, that is much more preferred.
