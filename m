Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638EAC433E0
	for <git@archiver.kernel.org>; Fri, 15 May 2020 22:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3690720657
	for <git@archiver.kernel.org>; Fri, 15 May 2020 22:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VEe6GQUd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgEOW5x (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 18:57:53 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59134 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgEOW5x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 18:57:53 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 18EF1CF828;
        Fri, 15 May 2020 18:57:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v+k0BPWR/4O5OA000HzIkOcz14c=; b=VEe6GQ
        UdFMXijnnTxR3blW/IJKZeEK0A17FXHL5dl1BF0cChz/TLTpDI1S4bpBm95/Yxsz
        E8Sb1tyGIwRrPkgnl1sRTmqHl6e3oaCrA2Hxv/JmulGtu6dtM2SyMosumfmpG95M
        8BInLO6jdyKrtpE4uWyzsYoNpWEQNHqOTtVj4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GTOnpXKtIMHRj+ERUpyBrS3kzJo7YgoO
        U5hjYbx6J4Wk+FxNDLN3PdW7BccS1eHM6YEynV4TKKooVNNPMSVjIHJ8uvKoQf4M
        /OXb/aMncIWz3bDvhSTo2fz9AIaszT4uiLyrIUjzKFyZsQ6bxw7qSrIJzVuBlIi4
        iraQ5cWpYCo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0FBFACF827;
        Fri, 15 May 2020 18:57:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 539A9CF823;
        Fri, 15 May 2020 18:57:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org,
        congdanhqx@gmail.com
Subject: Re: [RFC PATCH] t: move metadata into TAP test description
References: <5b373748-d986-1aec-670f-7ac1502e7052@gmail.com>
        <20200515150041.22873-1-carenas@gmail.com>
        <880ded78-21c6-9310-6c5e-422f6a63ad47@gmail.com>
        <20200515154539.GB61200@Carlos-MBP>
        <xmqqlfltm9b5.fsf@gitster.c.googlers.com>
        <20200515171428.GC61200@Carlos-MBP>
        <xmqq3681m7s4.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2005160041380.55@tvgsbejvaqbjf.bet>
Date:   Fri, 15 May 2020 15:57:45 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2005160041380.55@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sat, 16 May 2020 00:42:03 +0200 (CEST)")
Message-ID: <xmqqa728957a.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F3A5D48-96FF-11EA-ABD3-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> >> 303775a2 (t/test_lib: avoid naked bash arrays in file_lineno, 2020-05-07)
>> >> 662f9cf1 (tests: when run in Bash, annotate test failures with file name/line number, 2020-04-11)
>> >
>> > will also need:
>> >
>> >   676eb0c1ce (ci: add a problem matcher for GitHub Actions, 2020-04-11)
>>
>> Yeah, I think that is a good idea.  I suspect that leaving it there
>> won't cause problems, though---it would be just nothing is found to
>> be clicked and that's the end of it, no?
>>
>> Will add a revert to the series anyway.
>
> Yes, I'm fine with reverting this, as breaking TAP is a rather bad side
> effect.

Yup.  We can revisit it in the next cycle to find a solution that
does not break TAP, either the "a separate comment line", "machine
readable cruft at the end of the same line", or some other approach.

