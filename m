Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D92C20437
	for <e@80x24.org>; Sat, 14 Oct 2017 03:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753586AbdJNDCB (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 23:02:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55834 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753530AbdJNDBs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 23:01:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 55E9B9EA4A;
        Fri, 13 Oct 2017 23:01:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m7Dyx3xTct/yTdWeFoHGOQxTGow=; b=nXYk1E
        huvFxjQEbCniUsNXSCP5cQw374Lz65zo55MNLj0wulngsNa21vl7fR8QsWzNCTYb
        tFFV0Ks44DVOFqY8wvfu6GPPjX2Pyyre9cSPtqIouZocvMRzZ5uskP8Bx7bBvK4i
        pg+g/Qa1Ls9AgUvMlNOT0df6m+3LVUoMHXGAA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vmkXqiz6CG6IGufdofa8Ckl3nJ3lUVw6
        vvrL922ZKY8SvHfsVfcMsW/Q9DnIwne7MyGzX68FjxFTmBAMRmkNRF+QYGaDxg+d
        lE0PDssaC7lPTkRLBQm/B8YzSEP5Eyr1yk4dCtB7GFrc/5BaI1x/wBT/tolLhMEo
        l+5hjUddTXk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C2DD9EA48;
        Fri, 13 Oct 2017 23:01:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C4A6D9EA47;
        Fri, 13 Oct 2017 23:01:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] color: downgrade "always" to "auto" only for on-disk configuration
References: <xmqqr2uao2vy.fsf@gitster.mtv.corp.google.com>
        <20171012021007.7441-1-gitster@pobox.com>
        <20171012021007.7441-2-gitster@pobox.com>
        <20171012123153.i265nun6pklw7kjg@sigill.intra.peff.net>
        <xmqqinfjykm2.fsf@gitster.mtv.corp.google.com>
        <20171013014721.d4vesqv4v5j7tmk2@sigill.intra.peff.net>
        <xmqqzi8vvht6.fsf@gitster.mtv.corp.google.com>
        <20171013130638.dgc6kawy5mvrbasz@sigill.intra.peff.net>
Date:   Sat, 14 Oct 2017 12:01:46 +0900
In-Reply-To: <20171013130638.dgc6kawy5mvrbasz@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 13 Oct 2017 09:06:38 -0400")
Message-ID: <xmqqshemtoth.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 04AA3596-B08C-11E7-ACFE-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> All of the regressions people have actually _noticed_ stem from my
> 136c8c8b8f in v2.14.2. So I think it is a viable option to try to go
> back to the pre-v2.14.2 state. I.e.:
> ...
> That takes us back to the pre-regression state. The ancient bug from
> 4c7f1819 still exists, but that would be OK for v2.15. We'd probably
> want to bump the -rc cycle a bit to give more confidence that (2) caught
> everything.

Yes, I think that is the approach I was pushing initially with the
jc/ref-filter-colors-fix topic that was later retracted; the result
of your 4-patch series more or less matches that one, modulo that I
didn't treat for-each-ref as a plumbing.  I do share the worry that
it is hard to make sure that these post-revert adjustment caught
everything; after all, that was a major part of the reason why my
earlier attempt was retracted.  I still think this is the _right_
direction to go in, even though it is harder to get right.

> Post-release, we would either:
> ...
> But we could punt on that part until after the release. The only thing
> we'd need to decide on now is that first set of reversions. What I
> really _don't_ want to do is ship v2.15 with "always works like auto"
> and then flip that back in v2.16.

True.  Let's see what others think.  I know Jonathan is running
the fork at $work with "downgrade always to auto" patches, and while
I think both approaches would probably work well in practice, I have
preference for this "harder but right" approach, so I'd want to see
different views discussed on the list before we decide.

Thanks.
