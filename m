Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35325C2D0E4
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 00:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D50E02151B
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 00:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="d2clJn3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgKYAbC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 19:31:02 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62286 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgKYAbA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 19:31:00 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EE1ACF4163;
        Tue, 24 Nov 2020 19:30:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NzmHc6EmdgxCQRBI8Y4YnFe3nj8=; b=d2clJn
        3MqVyPQi1YT6/fjzTJFwuLcjtT1/27EW/jI/RMxrSyYxzO/pxWjjKLCYzC6GTc9B
        49gdB7FAKBraSw5I84JyHWeyL4fiKVTyw6ff7niwYVaQfsQQ87k4Z8YHztKtrsxQ
        I3nIMk+IClUXj1hiwWdqJLdbpIPgvOEGZHi8k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SHKVbD5c0U9Ix89UUt9BDfzROUx8Hsvv
        uV9FNK10NypXde7CDf/0ExNCHiit8XFBnbxOtXsNSr4/Z0VNcktGQd79ySvCqZ6q
        zUmoUTgpU5n8+HXyIiZOTCjtpurvHig3if+nUJeKNYqDzsm2b0lbFKZPjRNfRPEJ
        aqOU3U1q9IA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E5B92F4162;
        Tue, 24 Nov 2020 19:30:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 31126F4160;
        Tue, 24 Nov 2020 19:30:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>, Git <git@vger.kernel.org>,
        Brandon Williams <bwilliams.eng@gmail.com>
Subject: Re: [PATCH] refspec: make @ a valid refspec
References: <20201122164641.2091160-1-felipe.contreras@gmail.com>
        <X7y5Wxu1eY4k6753@coredump.intra.peff.net>
        <xmqqlfeqjzi1.fsf@gitster.c.googlers.com>
        <CAMP44s0PwJ8qEuCCpavshpm0GqV8p37rF8McR2=gdCk2kj+JiQ@mail.gmail.com>
        <xmqqo8jmgyrd.fsf@gitster.c.googlers.com>
        <CA+P7+xr8_s0Fq_TGjDjHEPpGJ8Br5x7omY1fsg0HjcXjutyRkg@mail.gmail.com>
        <xmqqk0uagxei.fsf@gitster.c.googlers.com>
        <CA+P7+xp_iTnkdbWoDSRZustvjk5BRJOPD=snae8D1Fe_uXqO7g@mail.gmail.com>
Date:   Tue, 24 Nov 2020 16:30:54 -0800
In-Reply-To: <CA+P7+xp_iTnkdbWoDSRZustvjk5BRJOPD=snae8D1Fe_uXqO7g@mail.gmail.com>
        (Jacob Keller's message of "Tue, 24 Nov 2020 15:47:05 -0800")
Message-ID: <xmqqft4ygtvl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7B93C276-2EB5-11EB-8221-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> Of course I agree that "@ == HEAD" can't be used to go *backwards*
> through that logic at all. But if you're moving forwards through it,
> then "@" on its own can make sense as HEAD, but only as an implication
> of "the most recent version of the current branch can't be anything
> else"

I'd rather put the lame excuses behind and accept that we ended up
with an ugly and illogical synonym that ;-)

And making it consistently available in places where HEAD is
accepted is a good thing.  Depending on the keyboard, it may be
easy to type, too.

