Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C08C520365
	for <e@80x24.org>; Tue,  3 Oct 2017 10:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751846AbdJCKi3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 06:38:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57201 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751761AbdJCKi1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 06:38:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 966B29019C;
        Tue,  3 Oct 2017 06:38:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=LxjPDog0yVBodkVu9uSQn1DFqc8=; b=SACbvLI6118Si53HHeYy
        rxH3biyTzvpXamUj7oImfQP70G7ILsU0LBmaOU+0SFz1qnBPo2wseLLQ/3J7smKS
        asGFxM8nP96fXmZutmOU93SbPHSiXp2+4o1P/0TTBzIrFMsouWX2CZULRO6u33sU
        KNJ6MpOmC4EVtnw5+CljKCw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=Il3d51wCmEvhV/JJ4ABh3dRKsEXAZJJ7oh/SwkNrFOHAIw
        +Ri74ruXg/WhWhzfcDCeCH386Wj94G7/1n72H6Ofr76WpN4U9QdXPqESwNpmIrZo
        Kq9CCfOYF2Hv6BJanKV1JKJNZZkURqjBR4NxvoqKSjfbFLdNaAP999DLkw+Kw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8E65E9019B;
        Tue,  3 Oct 2017 06:38:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0ACD89019A;
        Tue,  3 Oct 2017 06:38:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Toni Uebernickel <tuebernickel@gmail.com>, git@vger.kernel.org,
        Tsvi Mostovicz <ttmost@gmail.com>
Subject: Re: Updated to v2.14.2 on macOS; git add --patch broken
References: <86D0A377-8AFD-460D-A90E-6327C6934DFC@gmail.com>
        <20171002230017.GT19555@aiede.mtv.corp.google.com>
        <xmqqpoa5kp0c.fsf@gitster.mtv.corp.google.com>
        <xmqqinfxklw7.fsf@gitster.mtv.corp.google.com>
        <20171003061515.72l35fpvcf63vsf6@sigill.intra.peff.net>
        <xmqqinfwiu5n.fsf@gitster.mtv.corp.google.com>
        <20171003071622.el6zqibfyrjc2mra@sigill.intra.peff.net>
        <xmqqefqkiq8v.fsf@gitster.mtv.corp.google.com>
        <20171003084506.lwmnrym4oyf66icz@sigill.intra.peff.net>
        <xmqq4lrgip7u.fsf@gitster.mtv.corp.google.com>
        <20171003091049.jb46pyi3obtwkzsa@sigill.intra.peff.net>
Date:   Tue, 03 Oct 2017 19:38:24 +0900
Message-ID: <xmqqpoa4h5y7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FCBD88BE-A826-11E7-A805-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Oct 03, 2017 at 05:56:53PM +0900, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > Note that I'm arguing that it's a foot-gun even without scripts in the
>> > picture at all. Forget about plumbing versus porcelain. If you set
>> > color.ui to "always", you're going to get unexpected and confusing
>> > results from time to time.
>> 
>> Really? 
>> 
>> I would think you would consistently get ANSI colored output in any
>> medium, even in files that you would later "cat" or "less -R" to
>> view.  Is that unexpected?  Those who set "always" (I am not among
>> them, of course) would expect that, I would think.
>
> Those cases might be expected. But color when piping to grep or sed are
> not. I guess you can lump those under "well, they should be using
> plumbing, of course" but I don't think that's very realistic. People do
> ad-hoc pipes in their shells all the time (well, I assume so; I
> certainly do).

That's an argument to say color.ui=always is not a useful thing to
use and Git is wrong to offer such a nonsense option.  I agree with
both of them.

But it is a different matter that plumbing commands are now doing
the "color" thing without being asked.  Reading the configuration
that is meant for human interaction adds insult to injury.  I think
the earlier "everybody is colored by default" that forgot to make
sure the change does not affect plumbing was the main culprit, and
we were merely lucky that thanks to the auto-detection of "auto" we
did not break scripts.

Having said all that, unless we revert the entire series (and
possibly other things that happened after the series was merged on
'master' that assumes that now default_config would read the
color.ui thing), we won't be able to get back to the state before
the "add -p" regression, it seems.  As -rc freeze period for the
next cycle is approaching fast, I wanted to make sure that we have a
plan to address the regression (which does not have to solve what
the reverted commit tried to solve).  If you think we can get a
workable code in 2.14.x and 'master' that essentially castrates
"always" and makes it the same as "auto" in several days tops, then
I'd prefer such a solution, as honoring "color.ui=always" does not
feel all that important.
