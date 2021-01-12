Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFD6C433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 23:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C35C523130
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 23:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388764AbhALXX1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 18:23:27 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52323 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387860AbhALXX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 18:23:26 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C4C0DFD03E;
        Tue, 12 Jan 2021 18:22:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HJobCsMpv7i718Juu/ozeBEJH/g=; b=E6IDgj
        q2e9CTxOy0I9I8Ng5+METkcNrns0I6uOjES1yUjPfpYlGXlZIowqvSg8vLf/Ckok
        IPMkf1KCSdPLdBl9GM0XCL8MfsmB7+HkUBOmAG7ArQ3UdF5AS7N1HKjNbF8XZedg
        z2kplnPoxAKxrygmLY0Jhlbk4gixfXiPasBjo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=V9F4hDkVbw083eEaI5h/rJgNeH3aJEWb
        IStyN+dFIfcHIJvww+Vks0D2QUB2LCDJITiPMtqV3Cd8ZN16xk5K3RXxUcrfuMXS
        wlqpsAI3qEPPGsP9xIvmXDTM+9N+KW+8WfVnKp2d7FmQlkSHJAWS+rkgr77KbYbA
        1aqq5iHrgko=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BCC5CFD03D;
        Tue, 12 Jan 2021 18:22:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ECA5DFD03B;
        Tue, 12 Jan 2021 18:22:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>,
        Nika Layzell via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nika Layzell <nika@thelayzells.com>
Subject: Re: Cc'ing the Git maintainer on GitGitGadget contributions, was
 Re: [PATCH 0/1] add--interactive: skip index refresh in reset patch mode
References: <nycvar.QRO.7.76.6.1911251543430.31080@tvgsbejvaqbjf.bet>
        <xmqqpnhfwibn.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.2101071517260.2213@tvgsbejvaqbjf.bet>
        <87wnwordzh.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2101071718470.2213@tvgsbejvaqbjf.bet>
        <xmqqft3cl9rw.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2101081534380.2213@tvgsbejvaqbjf.bet>
        <X/i7zvgMJHfOmyZG@nand.local>
        <nycvar.QRO.7.76.6.2101101306310.56@tvgsbejvaqbjf.bet>
        <xmqq8s90a6li.fsf@gitster.c.googlers.com>
        <X/ykg4rEDDpWdZN9@nand.local>
Date:   Tue, 12 Jan 2021 15:22:39 -0800
In-Reply-To: <X/ykg4rEDDpWdZN9@nand.local> (Taylor Blau's message of "Mon, 11
        Jan 2021 14:18:27 -0500")
Message-ID: <xmqqsg75zqo0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 10DEC77A-552D-11EB-9B01-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Sun, Jan 10, 2021 at 12:18:33PM -0800, Junio C Hamano wrote:
>
>> As Taylor created the above suggestion as a counter-proposal, I can
>> see that I apparently did not express what I meant very well, when I
>> said:
>
> ...or that I must have not read your email which quite clearly states
> what I was thinking of, too. ;-).

Seeing that Dscho had a negative reaction to my rendering of my
thought while showing positive one towards yours, I see that what I
wrote wasn't clear enough to be understood to at least two people.

Thanks for clearly illustrating a possible end user experience that
is desiable.
