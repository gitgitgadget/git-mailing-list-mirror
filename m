Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 508E220229
	for <e@80x24.org>; Tue,  1 Nov 2016 21:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754139AbcKAVpX (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 17:45:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62015 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754017AbcKAVpW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 17:45:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D6A54B823;
        Tue,  1 Nov 2016 17:45:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=voPRw53i8GheOkyX7jtAqHHULL8=; b=k5R00d
        Q1VlPuql2Gpr2D9h9zQUxcnFyEyW34AULRT34rl9ZEEwnAexgIjweuLVK6iKNIoN
        TfEZ82Mqiq/i2asiHGwAbcwV56g6ehJrGj8P1ubkKIh2Eeg3DkONR+zIRr3Miobo
        FxY2xwI4Uc67bgt9f3QHBQjaH7+xTHcBndYtY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H7USOXKY+WuDeWBP4jVNtD9HOQdVi0DG
        nh5aN7mGX9LV2i4E3ruzEavXQOx8IZSPD1Vjf27alzYe8ugNirrVf7+1tFdo4TSL
        TP3EqPVoJn59410jKOv+hGOVU4giF68gCxozSvDko0gcloRZO3HsmJJuwj5GELkB
        FtzkVWTptAo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 62FEE4B822;
        Tue,  1 Nov 2016 17:45:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D5D144B821;
        Tue,  1 Nov 2016 17:45:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.11.0-rc0
References: <xmqq1sywrxxl.fsf@gitster.mtv.corp.google.com>
        <20161101203637.3jr73wwpfal4brho@sigill.intra.peff.net>
        <xmqqlgx2or5p.fsf@gitster.mtv.corp.google.com>
        <20161101205916.d74n6lhgp2hexpzr@sigill.intra.peff.net>
        <xmqqh97qoqq2.fsf@gitster.mtv.corp.google.com>
        <xmqqzilinanp.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 01 Nov 2016 14:45:19 -0700
In-Reply-To: <xmqqzilinanp.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 01 Nov 2016 14:38:18 -0700")
Message-ID: <xmqqvaw6nac0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7CA495D0-A07C-11E6-A4EE-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> And here is _with_ renaming.  I think "compaction heuristics" is a
> much better phrase to call "heuristics used during the diff hunk
> compaction process" without specifying how that heuristics work
> (like taking hints in the indentation levels).  If we are to retire
> one while keeping the other, compaction-heuristics should be the
> name we give and keep for the surviving one.
>
> I have not much confidence in the conversion result, though.

I'll queue it on 'pu' for now, before I go offline for a few days,
with the following log message:

    diff: retire the original experimental "compaction" heuristics
    
    This retires the experimental "compaction" heuristics but with a
    twist.  It removes the mention of "indent" heuristics, which was a
    competing experiment, from everywhere, guts the core logic of the
    original "compaction" heuristics out and replaces it with the logic
    used by the "indent" heuristics.
    
    The externally visible effect of this change is that people who have
    been experimenting by setting diff.compactionHeuristic configuration
    or giving the command line option --compaction-heuristic will start
    getting the behaviour based on the improved heuristics that used to
    be called "indent" heuristics.
    
    Suggested-by: Jeff King <peff@peff.net>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
