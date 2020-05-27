Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AF0C433DF
	for <git@archiver.kernel.org>; Wed, 27 May 2020 15:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 424A620776
	for <git@archiver.kernel.org>; Wed, 27 May 2020 15:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zw/T+AL2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbgE0Pof (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 11:44:35 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60012 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730386AbgE0Pof (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 11:44:35 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6F5BCC9C3C;
        Wed, 27 May 2020 11:44:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9Pi4fKbCF8hF9oYTfQhlckyLeOU=; b=Zw/T+A
        L2qOaQNO10e34R4/RxhNuELNd7KlZKoY8KPVZgFuBJuTJfjuZNCkT7izF7fYZm8f
        fS/i+4SMy9zQQ/MaC0RyUuOP2UoSLYlOVqlXIUdNeza7OqfWPGPSvjGgBwFIAwEO
        ZYK0TZNZ2MSPEHE9lyBaSVycuC5UP0I+wXzHU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ftmlnP56VuOAQ+M/eHxmnTm6eEyKDjOa
        2U+q4Z8HB48vy89q2McdiUxFprrlXYvVpxAPoXsWrnkNzVEgiOuK+csVcYhryKAa
        Gu3dhq6Ndt5K5+HFk3aH8hnQsOVep31d5Rz8zTjXJEW6MFLqjMq+yVQj1KEg0tXK
        YOA2OtMuihQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 67C7DC9C3B;
        Wed, 27 May 2020 11:44:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B3794C9C39;
        Wed, 27 May 2020 11:44:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Dana Dahlstrom <dahlstrom@google.com>, git@vger.kernel.org
Subject: Re: 'HEAD' is not a commit (according to git-checkout)
References: <CACqwCQiLpZ1HFzgJw0p0KR3jXNsxkhjXmF_huzhv+qkMZmybBQ@mail.gmail.com>
        <20200521191626.GC1308489@coredump.intra.peff.net>
        <9f26099a-e77b-ede4-bee3-27382a5a0875@web.de>
        <20200523162914.GA2178752@coredump.intra.peff.net>
        <ad267e83-eea0-bb78-d88c-a37a28d04dbe@web.de>
        <xmqqimglqpga.fsf@gitster.c.googlers.com>
        <20200527065210.GC4005121@coredump.intra.peff.net>
Date:   Wed, 27 May 2020 08:44:27 -0700
In-Reply-To: <20200527065210.GC4005121@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 27 May 2020 02:52:10 -0400")
Message-ID: <xmqqimghmlgk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F467A532-A030-11EA-AFA7-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sun, May 24, 2020 at 09:15:33AM -0700, Junio C Hamano wrote:
>
>> So, should we allow a random upstream & start-point combination?  It
>> appears to me that as long as they share _some_ common ancestory, it
>> may make sense.
>
> But wouldn't just about any two tips in a repository share some common
> ancestry?

Yes, we are on the same page; the above was my round-about way to
say that it does not look useful to restrict the allowed combination
in order to give us some safety.

Thanks.

