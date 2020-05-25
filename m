Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1074AC433E0
	for <git@archiver.kernel.org>; Mon, 25 May 2020 18:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88C4920723
	for <git@archiver.kernel.org>; Mon, 25 May 2020 18:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="K6GAnAEK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389725AbgEYShj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 14:37:39 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63549 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgEYShj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 May 2020 14:37:39 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 84E52B87F6;
        Mon, 25 May 2020 14:37:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=64rN3A8RvYsQTrCybDq2hurS/zU=; b=K6GAnA
        EKDzTQweFRj+SrdoPz99hTRezzcSTeeisx9jnRZhvPO7Hzk+2GxsQFmjnQfYKX/U
        72kCtW5ZcYr1zHjPK75gD00YkxVnJfZa5SCnhEUg/uRpZskjSi4ja2eSPfoVAC7Q
        FWcCPQkZnOGUkrXuIq2B2/uw1MUFFisdu1Y4g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=i5d8ALRTnXfbMRarRKtcf0FMzmKbBUsf
        FtdAVFrD0OiZ5u7VGCo+JDpfmqd+zRse43tDxJrzrebxOyDzud/DUDpF3f8nC+wh
        2GVGaBAq4THD2FCUagQ3XcJwSSiH8bKnqH6iYKY8bPQmmXhlk1ow4KnzS5Q/TqhT
        xCaMh4qdgWU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7CA8EB87F5;
        Mon, 25 May 2020 14:37:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 97CEBB87F0;
        Mon, 25 May 2020 14:37:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Jeff King <peff@peff.net>, Andreas Schwab <schwab@linux-m68k.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: Fetching 24 Linux commits = 1.2 GiB
References: <b7f5bfb9-61fb-2552-4399-b744428728e4@suse.cz>
        <20200415135627.vx75hsphbpmgrquv@chatter.i7.local>
        <xmqq1roo947y.fsf@gitster.c.googlers.com> <87sgfvq967.fsf@igel.home>
        <20200520194019.GA340985@coredump.intra.peff.net>
        <20200525182205.7hcffndaro2pgink@wunner.de>
Date:   Mon, 25 May 2020 11:37:31 -0700
In-Reply-To: <20200525182205.7hcffndaro2pgink@wunner.de> (Lukas Wunner's
        message of "Mon, 25 May 2020 20:22:05 +0200")
Message-ID: <xmqq4ks3q2s4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CCDB5B74-9EB6-11EA-A708-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lukas Wunner <lukas@wunner.de> writes:

> On Wed, May 20, 2020 at 03:40:19PM -0400, Jeff King wrote:
>> The "too big fetch" issue has since been fixed in "master", as well as
>> reverting the switch to the v2 protocol (which I think is just
>> belt-and-suspenders; AFAIK there are no known issues after the fix).
>> Both will be in v2.27. I don't see anything on "maint", but they _could_
>> be part of an eventual v2.26.3.
>> 
>> The fix was merged in 0b07eecf6e (Merge branch 'jt/v2-fetch-nego-fix',
>> 2020-05-01) for reference.
>
> Please consider cutting a v2.26.3 release with this fix at your
> earliest convenience.  The waste of bandwidth is mind-boggling.
> (> 1 GByte whenever fetching from a kernel remote.)

In the meantime, v2.27.0 rc2 will be out tomorrow.  Please consider
helping us polish it by testing that version.

Thanks.
