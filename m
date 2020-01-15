Return-Path: <SRS0=RXbn=3E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9A7C32771
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 22:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A552081E
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 22:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PJ1bV/Tk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbgAOWxI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 17:53:08 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58052 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbgAOWxI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 17:53:08 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 45CA73CEA7;
        Wed, 15 Jan 2020 17:53:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZVC8wc+zhKsYi2wbccNuf7QUGzE=; b=PJ1bV/
        TkQ7ssaD9teqYMSlblnhOl97Yqf5UPV3En2DeGrZTllaQBrnF9gSMhPPhOkMQCx3
        lwAZhXSthQNbrjhYECiQSYsgCSBQk46ZqL2ETKCX70COZ9djWUanu4TdOw+P9+2n
        w5K6z6NuAnugilkwkwZ6VAjLJhOHMuI8sGcms=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iB9bFgLhYVpq0kcoE7SltHQh7sYMjUt7
        zasrf5yr7yYhsGWqwg8/o7bj5e0L2ARji+gmKB9VzD53QMN/n73jZzFT5KKfMQ6N
        szKnpWmbP7fKHap7Xjo4lm50pvXOlkiZWrLduTQUzDsSPRmP3tiX/wLBlJMTuwm0
        U3bMZiA413w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3AC0B3CEA6;
        Wed, 15 Jan 2020 17:53:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 876A83CEA2;
        Wed, 15 Jan 2020 17:53:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: "rebase -ri" (was Re: Problems with ra/rebase-i-more-options - should we revert it?)
References: <f2fe7437-8a48-3315-4d3f-8d51fe4bb8f1@gmail.com>
        <089637d7-b4b6-f6ba-cce1-29e22ce47521@gmail.com>
        <xmqqeew4l6qf.fsf@gitster-ct.c.googlers.com>
        <xmqq5zhgkwxx.fsf@gitster-ct.c.googlers.com>
        <xmqqy2ubjkeo.fsf@gitster-ct.c.googlers.com>
        <xmqqpnfnj9p3.fsf_-_@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.2001151458100.46@tvgsbejvaqbjf.bet>
        <xmqqftggk2oi.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 15 Jan 2020 14:53:04 -0800
In-Reply-To: <xmqqftggk2oi.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 15 Jan 2020 10:14:05 -0800")
Message-ID: <xmqqr200ib73.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CAB0A360-37E9-11EA-88E9-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> Having said that, if you ever find yourself wanting Just One Feature in
>> `--rebase-merges` that would make it worthwhile for you to think about
>> switching your patch-based workflow to a `rebase -ir`-based one, please
>> let me know, and I will try my best to accommodate.

I missed a mention of 'patch' here when I prepared my earlier reply.
I do not expect "rebase -ri" to play any role in the part of the
workflow that accepts patches from the mailing list.

The involvement of "rebase -ri" (vs Meta/Reintegrate) is purely what
happens after a topic is queued and starts to get tested with other
topics on integration branches, and no "patch based workflow" plays
any role there---it does not make any sense to base that part on
anything but merge (and possibly cherry-picking an evil merge from
an earlier round).
