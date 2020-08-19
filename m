Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5106FC433DF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 18:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C82A20786
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 18:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lK1Jp0V4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgHSSDg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:03:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56704 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgHSSDe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 14:03:34 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5AEB28506B;
        Wed, 19 Aug 2020 14:03:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Igm5XnUQJhybi1MvoRQDgGm0b2Q=; b=lK1Jp0
        V4vNwNEK5dRbFjhDlpmq9RVvCdk9y5QmgaUp6IP5n4KHiQH+tHdeXZivAxMkBgDD
        o3XMpZJZN7hUbV/5FZwumujK7UgY5dZhLxhmvDnpqeLvgZZrSh02ih/zNEmbbGf4
        DEIIHLyaNHjV/HtlolwGNPGKd1Ko4OshOa5sc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=B6fAIS/7b8Zdlz1ynK8oYfyLs/RBsM6q
        mc6Y6+dLQwQJtcY2G8aquzKXn3+qHGvQHdycn7wM9SEpuJLzWXJEKxmEPuo6eRDs
        a0XNur4jRsyONOuD6THN1vgh+5aM9I3Q9JJihZoy+XVbL80s9jMQRHxlfwuEbdC3
        r74g84YEgk8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 520388506A;
        Wed, 19 Aug 2020 14:03:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B7EC985069;
        Wed, 19 Aug 2020 14:03:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lukas Straub <lukasstraub2@web.de>
Cc:     git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 0/2] Allow adding .git files and directories
References: <cover.1597853634.git.lukasstraub2@web.de>
Date:   Wed, 19 Aug 2020 11:03:30 -0700
In-Reply-To: <cover.1597853634.git.lukasstraub2@web.de> (Lukas Straub's
        message of "Wed, 19 Aug 2020 18:43:31 +0200")
Message-ID: <xmqqr1s2tswd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4ABD376A-E246-11EA-A933-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lukas Straub <lukasstraub2@web.de> writes:

> These patches allow this and work well in a quick test. Of course some tests
> fail because with this the handling of nested git repos changed.

In other words, this breaks the workflow existing users rely on,
right?  I do not know if such a behaviour ever needs to exist even
as an opt-in feature, but it definitely feels wrong to make the
behaviour these patches introduce the default.

Thanks.
