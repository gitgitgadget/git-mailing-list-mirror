Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F58C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 22:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbhKVWp2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 17:45:28 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57444 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbhKVWp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 17:45:27 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7FAB3171B43;
        Mon, 22 Nov 2021 17:42:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Xhl/hwW4joyYZfb5IFg7Elonmzww7tCBOO81SI
        AjuJY=; b=bmaD3Z5P6t838Qo4O2cWyIfzv4/Bits1XjxKTKzeCbEJeuTP4/0sMb
        0kCha4fRnEHK7BzAkF0rQMNwKUKS3QVoBWB5TBzejXr96HleRSm480sNo+OG+3A0
        hL3xltsM2kmt0i6vk/QDUXp8W6PWqGEzHL9qx5Nn1x6sfN0Slgm+Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 788BC171B42;
        Mon, 22 Nov 2021 17:42:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D7EF8171B41;
        Mon, 22 Nov 2021 17:42:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org
Subject: Re: preparing for 2.34.1
References: <xmqqr1b8gkhg.fsf@gitster.g>
        <CAPUEsphNH9pfQoHqVgJfkQCU-Li45dz4QtGtDjWu5bDV9A3PEg@mail.gmail.com>
        <nycvar.QRO.7.76.6.2111222319100.63@tvgsbejvaqbjf.bet>
Date:   Mon, 22 Nov 2021 14:42:16 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2111222319100.63@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 22 Nov 2021 23:28:22 +0100 (CET)")
Message-ID: <xmqqmtlvbynr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 724E5CA0-4BE5-11EC-9745-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The quickest workaround for this is probably to special-case the editor
> `echo`:

"GIT_EDITOR=: git cmd" would also be a common trick people would use
to bypass editor and take whatever is given as an initial template.

> However, I could imagine that other scenarios call for an editor that
> _also_ does not run in the terminal, and where also no real terminal is
> available for saving and restoring.
>
> I was tempted to suggest an `isatty(2)`, but that probably comes with its
> own problems, too.

I think isatty(2) is pretty much our synonym to "are we talking to
an end-user sitting in front of the terminal".  Mostly we use it as
a way to control the progress bars, and use of editor on terminal
would be in line with these existing uses.
