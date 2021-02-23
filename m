Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD8AC433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 19:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F48D64EE8
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 19:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbhBWTff (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 14:35:35 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60955 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234067AbhBWTfW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 14:35:22 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ADC4910D9E1;
        Tue, 23 Feb 2021 14:34:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LawK01yx6OTBAck2Y5OnZ5/PGVk=; b=GWEuvB
        /vTLQMAoIUxJGJN3Dzuxxou/M7h6rXLVG7KORwxBnbItOM1EFx31aWz4Urzt0YFO
        YHwZJkFqk633WmO9jv9fP3R/3NopqGO8l0pZV4l11bxdVeOfpGeaWh8o/yyx4RHC
        XdXnGaKtJaakWmLqxUz1idr1DGLuIOkPerLAc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TzfSaLMV903xtK4mkD/LQ2CTNKDHFIZk
        PpVFrRNTUGM1s6ohXP9R7EYy9QNrbbzlw81JnxTf7qwPgjox4JVmX8ZIdChKhH+n
        pxZbO8Q0fOus6f8G8mNUZ+2su4IzNJja/N5TKJVXUWpwPZYAa2Dnav7Qg0mssOXm
        FYUnVWiWjuw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A5B7B10D9E0;
        Tue, 23 Feb 2021 14:34:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id ED7F010D9DF;
        Tue, 23 Feb 2021 14:34:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Utku Gultopu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Utku Gultopu <ugultopu@gmail.com>
Subject: Re: [PATCH v2] doc: `--date` in `git-commit` accepts approxidates
References: <pull.969.git.git.1614101746491.gitgitgadget@gmail.com>
        <pull.969.v2.git.git.1614106322760.gitgitgadget@gmail.com>
        <YDVSICgBwPLtDNu4@coredump.intra.peff.net>
Date:   Tue, 23 Feb 2021 11:34:36 -0800
In-Reply-To: <YDVSICgBwPLtDNu4@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 23 Feb 2021 14:06:08 -0500")
Message-ID: <xmqqpn0q1stv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A8474CA-760E-11EB-8794-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Feb 23, 2021 at 06:52:02PM +0000, Utku Gultopu via GitGitGadget wrote:
>
>> +ifdef::git-commit[]
>> +In addition to recognizing all date formats above, the `--date` option
>> +will also try to make sense of other, more human-centric date formats,
>> +such as relative dates like "yesterday" or "last Friday at noon". For
>> +further details on what kind of formats are accepted, please refer to
>> +the `approxidate_careful` function in `date.c` file in Git source code.
>> +endif::git-commit[]
>
> OK. This is still referring to `approxidate_careful`, which may not be
> meaningful to most users. But at least it makes a best effort at a
> hand-waving definition before then. :)
>
> I'd probably omit the final sentence entirely (as it may simply confuse
> people who don't know how to find Git's source), but I'm OK with it
> either way.

I am not happy with reference to approxidate_careful that has no
place in end-user facing documentation.  I think the one you
suggested struck a better balance.
