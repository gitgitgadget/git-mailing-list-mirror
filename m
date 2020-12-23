Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BE6C433DB
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 23:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A01E22287
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 23:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgLWXd4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 18:33:56 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64664 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgLWXdz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 18:33:55 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9125210C61D;
        Wed, 23 Dec 2020 18:33:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p8soRLI/N2S2oTrcq4bKaDDnYgc=; b=Q0RpZS
        GL+ktb/lhzZ9i2s2GesspTGameUB2ypzHgTovo9REVloIpS3rsJZ+pL1IyKCx7SO
        r6HUF1x/UNpLNY7VnRTet0gQolkpf/5NnuFDGHDXOyslMsqalOieN4O8YXS3BkrB
        oOy08FzL1S/A2hfqdhJskv+Mjpn43tdvJxmus=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uagQYOH4zcrJj51elPYyvkTLMpz2xg02
        UJmKkhNP56FoFZRMKzSKsn+bqk06m/MNpc04DjKQ12AIPPp9kED0SW9y2iXi31bB
        Dyf1B2mwGcKQByI2BeMjdDTJseY/b45fvYTNnUrIXUeHSF3PMBf4q4i+ABWyIQmK
        bVJ6kmgyOO4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8A92110C61C;
        Wed, 23 Dec 2020 18:33:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AE2D710C619;
        Wed, 23 Dec 2020 18:33:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mike McLean <stixmclean@googlemail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git Feature Request (Commit Message editing directly from
 interactive rebase control file)
References: <CAM0jFOfx+vxvUAqZqnxeOvGmn0F0Q6vyTKWPjtsSh1bmq__SsQ@mail.gmail.com>
        <CAM0jFOfvNFva98PNjO33HW3Y4+L1SufvEHQYzwGLHgOkfhmUDQ@mail.gmail.com>
Date:   Wed, 23 Dec 2020 15:33:09 -0800
In-Reply-To: <CAM0jFOfvNFva98PNjO33HW3Y4+L1SufvEHQYzwGLHgOkfhmUDQ@mail.gmail.com>
        (Mike McLean's message of "Wed, 23 Dec 2020 23:07:43 +0000")
Message-ID: <xmqqh7oc5c96.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 37F70FAE-4577-11EB-9EE9-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike McLean <stixmclean@googlemail.com> writes:

> I initially raised this as a FR with my git UI of choice, and was told
> that it was actually something that git itself would need to do ...
> and that the standard way to raise Feature Requests was to email this
> list.
>
> Apologies if that's not actually what I should be doing - please let
> me know if this is not an intended use.
>
> =-=-=-=-=-=-=-=-=-=
> When you do an interactive rebase, you are presented with a file
> listing all the commit hashes, their current message, and the
> command/operation to perform.

Each commit is shown only with their title, but does not show the
full message, exactly because the text is merely there to help the
user identify which commits are being shown and manipulated.

> ...
> So can we allow the user to (optionally) set the new message directly
> in that file?

I suspect that such a "feature" would encourage people to use a
single liner commit log message, that is only the title, so that
they do not have to worry about the real log message in the body.
And it does not particularly feel a good behaviour that we'd want to
encourage.  So, I dunno.
