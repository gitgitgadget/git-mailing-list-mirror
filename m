Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9D53211B3
	for <e@80x24.org>; Fri, 30 Nov 2018 02:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbeK3NiC (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 08:38:02 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55429 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbeK3NiC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 08:38:02 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 78E80110E4C;
        Thu, 29 Nov 2018 21:30:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=HUACHwTjUH2Q
        sLyK9RrG4xNxliw=; b=azF9ejMgruwm0UVnmakoKZg3QskddWNtSOqP+uwqpkBB
        S1y+uGR8O/07BoXCEn1jwCfUIhodYs62uh6Jy8KWffUiwBiTyXcBEASUCkg7Za4V
        ReSvHDt+wGYA9lW0aQKLwR5m0Yg8N/jiqFBiu1ypnmme0JcVF24Q20JlgySIMsI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ZKq+PA
        kQ6tPLh/tLU44qnOOOHTZ05A6eEJZqX6yQIkYwNuur2SuWVWKT5z2XfCqCf5Rwn/
        CVlzA07xocMqZP+8Gj7a8i49MPhBwKNKA51ysquTtXP/PE/5RhSoHD1HRIqIqbZH
        vorMJlfcPPIgzF/fq1a3gl7FSg29tCWDT0e8A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 71E8B110E4B;
        Thu, 29 Nov 2018 21:30:17 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E64A7110E4A;
        Thu, 29 Nov 2018 21:30:16 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] format-patch: allow for independent diff & range-diff options
References: <xmqqk1l32jo2.fsf@gitster-ct.c.googlers.com>
        <20181128201852.9782-3-avarab@gmail.com>
        <nycvar.QRO.7.76.6.1811291103190.41@tvgsbejvaqbjf.bet>
        <8736rkyy4h.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.1811291307070.41@tvgsbejvaqbjf.bet>
        <871s74yms3.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.1811291641090.41@tvgsbejvaqbjf.bet>
        <87tvjzyiph.fsf@evledraar.gmail.com>
Date:   Fri, 30 Nov 2018 11:30:15 +0900
In-Reply-To: <87tvjzyiph.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 29 Nov 2018 17:03:22 +0100")
Message-ID: <xmqq7egvmh54.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DFCF58EA-F447-11E8-A92D-063AD72159A7-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> What prevents you from using `sq_dequote_to_argv()`?
>
> I mean not just nasty in terms of implementation, yeah we could do it,
> but also a nasty UX for things like --word-diff-regex. I.e. instead of:
>
>     --range-diff-word-diff-regex=3D'[0-9"]'
>
> You need:
>
>     --range-diff-opts=3D"--word-diff-regex=3D'[0-9\"]'"
>
> Now admittedly that in itself isn't very painful *in this case*, but in
> terms of precedent I really dislike that option, i.e. git having some
> mode where I need to work to escape input to pass to another command.

In addition, sq_dequote are meant to be used on quoted string we
internally produce; I do not think we want to promise that it is
safe to use on a random string that comes from end users.

In any case, I tend to agree with the conclusion in the downthread
by Dscho that we should just clearly mark that invocations of the
"format-patch --range-diff" command with additional diff options is
an experimental feature that may not do anything sensible in the
upcoming release, and declare that the UI to pass diff options to
affect only the range-diff part may later be invented.  IOW, I am
coming a bit stronger than Dscho's suggestion in that we should not
even pretend that we aimed to make the options used for range-diff
customizable when driven from format-patch in the upcoming release,
or aimed to make --range-diff option compatible with other diff
options given to the format-patch command.

I had to delay -rc2 to see these last minute tweaks come to some
reasonable place to stop at, and I do not think we want to delay the
final any longer or destablizing it further by piling last minute
undercooked changes on top.
