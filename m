Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 395242092F
	for <e@80x24.org>; Sun, 22 Jan 2017 22:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750776AbdAVW6Y (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 17:58:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61972 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750704AbdAVW6X (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 17:58:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B111C63857;
        Sun, 22 Jan 2017 17:58:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XtcBLoSG1t4werKVQyDR4X00SQc=; b=izPLeB
        ED6Gbi3HXt4B/PYVgqyRIpWNLXr5kda2TQPQzptXF6zqq8bnbZJV0PPHL3KnxknM
        UuaTOP9uLt0kas5a4IfYVnxkDYjduMLfNtVVQWO+MrbPxeG8LSWzLWrGtPCUDuGx
        IruYb2UdfnpNToL401LZpbUoywWp8RepyXIRY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WoCm0x+sKwFaJppHXC+jY5avyRlS3AXa
        VC3HRF9gmiBIcX/xKqSH+bOwUd7HbCU3EUQMRfB7oys0qGvQEVd/yihAUHkxzdNa
        Ufa8xxyD6mRG7bdEM1T1dJSVr1nBlsToA/oIE4wfZQb4Vb8wZJHigBC+XxBwsfFc
        VhXsDnwY0/Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A89F163856;
        Sun, 22 Jan 2017 17:58:22 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 23C5563855;
        Sun, 22 Jan 2017 17:58:22 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] blame: add option to print tips (--tips)
References: <20170122212855.25924-1-eantoranz@gmail.com>
        <CAOc6etaQ-fDWn38YzXkGOC0fSan1vrxjVDUXS924nBXWTTrhNQ@mail.gmail.com>
Date:   Sun, 22 Jan 2017 14:58:21 -0800
In-Reply-To: <CAOc6etaQ-fDWn38YzXkGOC0fSan1vrxjVDUXS924nBXWTTrhNQ@mail.gmail.com>
        (Edmundo Carmona Antoranz's message of "Sun, 22 Jan 2017 15:39:29
        -0600")
Message-ID: <xmqq1svuvh0y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 45F48968-E0F6-11E6-8F42-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Edmundo Carmona Antoranz <eantoranz@gmail.com> writes:

> So, this is a draft of what I mean by "adding tips to blame".
>
> Example output (sample from builtin/blame.c):
> ...
> 15:32 $ ./git blame --tips -L 1934,1960 builtin/blame.c
>        cee7f245dc: git-pickaxe: blame rewritten.
> cee7f245dc builtin-pickaxe.c (Junio C Hamano           2006-10-19
> 16:00:04 -0700 1934)

This is unfortunately unreadable to guess what you wanted to
achieve, not because the lines are too wide, but because they are
line-wrapped.

> Does it look "worthy"? And if so, would it be better to think of
> something like an "aggregate" option (or something like that) that
> would include the common information as tips, something like:

What is the target audience?  If you are trying to write a script
that reads output by "git blame", you are strongly discouraged
unless you are reading from "git blame --porcelain" which is more
compact and has this information already IIRC.
