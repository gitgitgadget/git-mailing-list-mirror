Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EC572095E
	for <e@80x24.org>; Sun, 19 Mar 2017 22:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752101AbdCSWI7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Mar 2017 18:08:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60182 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751228AbdCSWI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2017 18:08:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 34DC56ECB6;
        Sun, 19 Mar 2017 18:08:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BvjbEiW5Ozcj4ISiNWu2uMfAEA0=; b=wCM4Tq
        Iw8e1vlcE2MiBLPHCz0MtKpDUCipyBOceQUDEOpPXMpvTPMCTtIp4aV/XX/4LTub
        xko+Nh9BeDi6vYlK0b4yy4zKU2m5JP83uL6cTXEUGxyNX2rMfa4flQtCvHwv3Un7
        Sz7zXEv6VYTd584fzoGzCc1zpfGXTluuxqmvI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=A1XRgCwpzqUiJw12TEeafmAi1xVb+a7B
        5Kp0t7/HYj3EW28tGHG32kmkTquWat/nyI8PhR84vPa3Dg6+ZhhNm9bTz5/uLGWm
        z2m/KrYKaMWeLp1kzgHNQ+zW8ItZItqJ+BJjUcEQiADQXcMAdW+6zxBxqf2lTM8f
        sFHQitjPF3U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2BB666ECB5;
        Sun, 19 Mar 2017 18:08:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8CF8F6ECB4;
        Sun, 19 Mar 2017 18:08:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 0/2] diff --no-index: support symlinks and pipes
References: <20170318210038.22638-1-dennis@kaarsemaker.net>
Date:   Sun, 19 Mar 2017 15:08:54 -0700
In-Reply-To: <20170318210038.22638-1-dennis@kaarsemaker.net> (Dennis
        Kaarsemaker's message of "Sat, 18 Mar 2017 22:00:36 +0100")
Message-ID: <xmqqo9wwzzpl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A4DF8E84-0CF0-11E7-8024-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> Normal diff provides arguably better output: the diff of the output of the
> commands. This series makes it possible for git diff --no-index to follow
> symlinks and read from pipes, mimicking the behaviour of normal diff.
>
> v1: http://public-inbox.org/git/20161111201958.2175-1-dennis@kaarsemaker.net/
> v2: http://public-inbox.org/git/20170113102021.6054-1-dennis@kaarsemaker.net/
>
> Changes since v2, prompted by feedback from Junio:
>
> - A --derefence option was added and the default is no longer to dereference
>   symlinks.

I do agree that it makes sense to have --[no-]dereference options,
but I do not think it was my feedback and suggestion to make it
optional (not default) to dereference, so please do not blame me for
that choice.

