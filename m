Return-Path: <SRS0=m/64=4N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F071DC4BA04
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 23:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C468324692
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 23:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oudvGlJV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730520AbgBYX3T (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:29:19 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55918 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729429AbgBYX3N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 18:29:13 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 30DF851D0E;
        Tue, 25 Feb 2020 18:29:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GSpTtLlV1OtdK3yohOdQ4Rz1vVU=; b=oudvGl
        JVJIj4sb2PsY/tTFUYTxIPtxYX7WSWRK3mWTw8NyGgcf0ybmrTkPHZUEf0D586/H
        ijAkS5LHWzv2c5yXgp/zZxW0alWua0EXgFAT8dacvCk4V2AacmxcP91h/q+6MJaL
        UN/a8FnqQrfpZ8789yXhgyskKr5o20R92I654=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ddh2bM4s4RoTZv0h9CqfLx2YMNVuNVyL
        tccSCmwp21EUbZJxXDfZJElc3mW9LlXoO6+XAlvF3cY4OyRSKk+sdZBbFWI4VrAI
        /8z6m7zcGrk/iH1TRnZjP+piLRR+sI9xyzCURl5wfQg0E6GOS1ZOzmtNzbhdasYU
        m9tn4KAZaI8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 293E651D0D;
        Tue, 25 Feb 2020 18:29:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8CB5651D0C;
        Tue, 25 Feb 2020 18:29:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 07/15] bugreport: add git-remote-https version
References: <20200220015858.181086-1-emilyshaffer@google.com>
        <20200220015858.181086-8-emilyshaffer@google.com>
        <xmqqr1yp9eue.fsf@gitster-ct.c.googlers.com>
        <20200220232812.GH2447@google.com>
        <xmqqo8ts7gf5.fsf@gitster-ct.c.googlers.com>
        <20200225220838.GB212281@google.com>
Date:   Tue, 25 Feb 2020 15:29:08 -0800
In-Reply-To: <20200225220838.GB212281@google.com> (Emily Shaffer's message of
        "Tue, 25 Feb 2020 14:08:38 -0800")
Message-ID: <xmqqimjukzzv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9F7BDFAE-5826-11EA-B47C-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Hm. I guess I got the opposite impression from you way back in v1. I do
> wish it had been communicated a little more clearly; it's frustrating to
> perceive a reversal after seven months of review. But that's probably on
> my own reading comprehension :)

Well, seven months is a long time for anybody to learn from repeated
reading and gained experience to form an opinion and get affected by
others' opinions.  In any case, this is one of the reasons why I try
to discourage people to have too many topics in flight before moving
on to a new and different topic---the risk of ending up with fliping
and flopping is just too high when you give people chance to forget.
Rather, I'd prefer to see something simple to land first and then
later refined.

On this particular issue, I actually do not have a preference.  As
long as the topic has a coherent position/stance, any one of

 (a) we do as much i18n as possible to help end-users, or

 (b) we stay away from i18n to ensure the reports are machine
     readable, or

 (c) somewhere in between with a clear criterion where you are
     drawing the line (e.g. "the introductory text is what we want
     the end-user to read, so it is i18ned, but the report about
     their environment are primarily for our use and we avoid
     localizing so that we can process mechanically"),

is fine.  The important point is that we choose what we do with a
solid guiding principle behind the decision.

In practice, every string in bugreport.c you have control over the
use (or non-use) of _() around it, but codepaths that you call from
existing parts of the system are likely to have their messages
localized if they are meant for Porcelain use.  So from that point
of view, (a) would be easier to arrange than (b), I suspect.

Thanks.
