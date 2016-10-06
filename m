Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51CD1207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 17:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942171AbcJFRRJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 13:17:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57181 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934430AbcJFRRI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 13:17:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A98043FF8;
        Thu,  6 Oct 2016 13:17:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=URILIkMVFcIjNE2044qEIFL1Rq4=; b=pHTuBU
        Q9pKEsYPx8EeWNs7uK88+95JzhiSLXlAHV3Z8oy3l799qQYImk0ZEdy+UM2dAPnc
        BUJdj9boRHZlQpG5Z73Cx7aiEBBHt3SLu/zAMbGeMVbdV2V4nzWjtlIIxjurLySK
        ssOALBo/Vp/QOSO1KRbJ1Q9HZlH3WonGaCmWg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RD9L6zrVX6pMtZgVr+STIec6Nt5mSU1g
        BOyTsKN9nscYCQgrYvMFJUDBG+JtvQRICpDLfDzRPXHne0Qcn1C+0HxgnBwMAuWB
        B+bLBrE+zUxQQpqql3dG1rxQj5t3lBHpTvH0PyjvYNUZTtHwoorh7mYwHph3abID
        HLKLqKzP9lk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C9F543FF7;
        Thu,  6 Oct 2016 13:17:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DD37C43FF6;
        Thu,  6 Oct 2016 13:17:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Jakub =?utf-8?Q?Nar=C4=99b?= =?utf-8?Q?ski?= <jnareb@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v8 00/11] Git filter protocol
References: <C2C9761E-986F-473D-BFB7-CBEF900D9FA3@gmail.com>
        <f7a4f828-bb1d-0ffa-e369-3b4fa476d9e5@web.de>
        <xmqqk2duhcdm.fsf@gitster.mtv.corp.google.com>
        <1A8A9127-4DF9-44AD-9497-F8A630AB1193@gmail.com>
        <xmqq60pee6rp.fsf@gitster.mtv.corp.google.com>
        <C53500E8-7352-4AAC-9F53-40CCFA7F1418@gmail.com>
        <15ff438f-ec58-e649-b927-b1de4751cc45@gmail.com>
        <E9946E9F-6EE5-492B-B122-9078CEB88044@gmail.com>
        <f7f9ca4c-229c-390a-beb0-a58e0d3d66b3@gmail.com>
        <5C30800A-C821-4B39-BEB7-7D55D86BD7EA@gmail.com>
        <20161006160104.nhpxhfhketr4rb4h@sigill.intra.peff.net>
Date:   Thu, 06 Oct 2016 10:17:03 -0700
In-Reply-To: <20161006160104.nhpxhfhketr4rb4h@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 6 Oct 2016 12:01:04 -0400")
Message-ID: <xmqq37k9mm7k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B497020A-8BE8-11E6-AD42-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I am not sure if I have followed all of this discussion, but I am of the
> opinion that Git should not be doing any timeouts at all.
> ...
> If this is debugging output of the form "now I am calling wait() on all
> of the filters", without respect to any timeout, that sounds reasonable.
> Though I would argue that run-command should simply trace_printf()
> any processes it is waiting for, which covers _any_ process, not just
> the filters. That seems like a good match for the rest of the GIT_TRACE
> output, which describes how and when we spawn the sub-processes.

Yup, I agree that having trace_printf() report the wait for any
process is the cleanest way to go.  As you guessed the reason why
Lars is bringing up "now we are waiting for this filter" is because
I suggested it as a way to encourage users to file bugs when they
see a hung Git.  Originally Lars wanted to have a timeout on wait
and after the timeout wanted to kill the process, and because I
really did not want such a random "you are too slow to die, so I'll
send a signal to you and exit myself without making sure you died"
there, I suggested that if we were to have a timeout, that would be
to timeout the wait only to have a chance to tell the user "we are
stuck waiting on this thing" (and then go back to wait), as it would
either be a buggy filter (i.e. the users need to debug their own
filter code) or a buggy use of wait on Git side (i.e. we would want
to hear about such bugs from them).

Without such a "wait with timeout so that we can tell the user", we
can still respond to "my 'git checkout' hangs forever" with "try
running with GIT_TRACE" as you outlined above, so I do not think we
need the timeout.

Thanks for straightening us out.


