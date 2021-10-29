Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A63C433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 591A260FC3
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhJ2WBU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 18:01:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63415 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbhJ2WBT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 18:01:19 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 62D56FCA3A;
        Fri, 29 Oct 2021 17:58:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Il8h0w19HAI6rXu1hqEw0qy6pjyL/ZLlkmtocy
        XqI4Y=; b=wCvvubk7jT6Jqy4l4cuWDlgJH6ukT0g5ddfYBZiSxGI+UqFLWLuqBn
        inIwQSdsFq5mZnOZ01XHl8oU/Y1IQpl6XzBZbnGy6cikV/tYSb0PNZdrSbODKQwK
        /LO3Bo+JExWRMvgTaCpggHv5pfOg6OUBp9tLCFB7eYPPz87RmhYws=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 59C26FCA39;
        Fri, 29 Oct 2021 17:58:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BF162FCA38;
        Fri, 29 Oct 2021 17:58:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, avarab@gmail.com,
        "Randall S . Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH] wrapper: remove xunsetenv()
References: <20211029212705.31721-1-carenas@gmail.com>
        <YXxpjLhiguq4HY6g@coredump.intra.peff.net>
        <YXxs4NZmpjhRkoYA@coredump.intra.peff.net>
Date:   Fri, 29 Oct 2021 14:58:48 -0700
In-Reply-To: <YXxs4NZmpjhRkoYA@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 29 Oct 2021 17:51:28 -0400")
Message-ID: <xmqqbl37ijc7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 65D88E04-3903-11EC-9C3C-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> However, according to the unsetenv() manpage:
>
>   Prior to glibc 2.2.2, unsetenv() was prototyped as returning void;
>   more recent glibc versions follow the POSIX.1-compliant prototype
>   shown in the SYNOPSIS.
>
> So it is POSIX to return an int, but that gives us at least one platform
> where unsetenv() returns void (or used to). glibc 2.2.2 is 2001-era, so
> that may be old enough that we don't care. But it makes me wonder if
> other older or obscure platforms will run into this.

Ahh, OK.  Well, we will hear from them soon enough.  It is not like
this is anything urgent.

Thanks.

