Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AB831F454
	for <e@80x24.org>; Mon, 11 Nov 2019 12:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfKKMJz (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 07:09:55 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63720 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfKKMJz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 07:09:55 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 57FD292E9F;
        Mon, 11 Nov 2019 07:09:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ct1L1Lmg5OnB2K02IaVGDgvo5Z4=; b=Sv+gVN
        yFOhYVU2MsWNifjA8S92u6WATkiXkKCzCoOT+g3iJaFizbcf/vP+kLp8IodCrHrY
        sKThBHhHUS4z9H6pgNyCkHm9OfF7p7DOoBTFtFLOBMLwGU7DyF7DlHSlmnREMqoE
        iZLjKYPNnnbYskPVkRIz0OnHM+cryFao7Fsgg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NWR0SP4VpQFhqrTDf06dGjQfP3hwFA30
        3EMZ/yjdwMpOG8pLKyy26sDjPgFUOFt/WxA+9n10ONl2epPHcqnWDHHHqFHdAJ6n
        Id1sExrY/DBslLGacvlJ6pt7EYEExcUAjzHZi2TH+4Ferdd9W6KVbzhA+PTLu9bz
        JfkKLKA15nI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4FDA692E9E;
        Mon, 11 Nov 2019 07:09:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 76CE692E9A;
        Mon, 11 Nov 2019 07:09:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 1/9] Start to implement a built-in version of `git add --interactive`
References: <pull.170.v4.git.gitgitgadget@gmail.com>
        <pull.170.v5.git.1572869729.gitgitgadget@gmail.com>
        <ff59d2d0b3b8b591a806ef71b4bcfd350000b06e.1572869729.git.gitgitgadget@gmail.com>
        <xmqqh83fnfah.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1911091154550.46@tvgsbejvaqbjf.bet>
        <xmqqtv7cjj2n.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1911110949590.46@tvgsbejvaqbjf.bet>
Date:   Mon, 11 Nov 2019 21:09:48 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1911110949590.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 11 Nov 2019 10:15:00 +0100 (CET)")
Message-ID: <xmqqeeyehawj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2962F0A8-047C-11EA-85ED-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> And I agree that this sidetrack is totally irrelevant for the patch
> under discussion.
>
> I do think, however, that the discussion of "we wanted to do it the
> other way, but when we tried, it did not work" is relevant, even if I
> shortened it to "we use a different approach than previous conversions,
> because that previous approach would not work".

Regardless of the language the scripted version was written in, I
think the '--helper' approach is always the poorer choice between
the two [*1*].  It limits the modular decomposition to what suits the
original language, the impedance mismatch between the original and
target language forces us to unnatural style of inter module
communication, and the unnatural interface layer, which we know has
to be discarded at the end, must be written [*2*].

So, I'd prefer to see "because this is a better way in the longer
term" over "because the --helper approach would not work".

[Footnote]

*1* In only one case I would recommend using "--helper" approach,
    though.  When you are not expecting the developer to be able to
    come up with a better split of the program into modules than how
    the scripted version is, and you want to ensure that the
    developer have something to show when they faild to complete the
    project after N weeks.  You are a more experienced developer
    than an average GSoC student, and there is no pencils-down time,
    so the exception would not apply.

*2* In "git submodule" for example it was quite natural for the
    module that gives a list of submodules with its traits the
    program cares about to be written as a shell function that
    writes the data to its standard output.  And consuming modules
    sit at the downstream of a pipe, accepting its output.  When you
    are writing these modules both in C, you wouldn't connect them
    with pipe to carry the list of submodules, but a piecemeal
    conversion using the "--helper" approach meant that there always
    remained _some_ consumer that wants to read from the pipe, so
    long after the module lister was rewritten in C, it still needed
    to support a mode where it sends its output to the pipe, instead
    of just passing an array of structures.
