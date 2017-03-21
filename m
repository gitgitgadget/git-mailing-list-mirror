Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94BB32095D
	for <e@80x24.org>; Tue, 21 Mar 2017 19:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933751AbdCUS77 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 14:59:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53435 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933868AbdCUS75 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 14:59:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A15E65B4C;
        Tue, 21 Mar 2017 14:59:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=z3/DqB+XWBOT
        OW3esqtXbi9JguM=; b=gfEPzzyscvgXt3wT4NXcySZScS8Y0FOwXnZGGKgDO/iJ
        ZbfdHlvMjlh/O4r4e9Pi44VH8kBVaoAvJH2FYogkcj7IH7Uk3SR13J3Qllrw02GI
        PX/hiWFUYDpUpEC42wJyXJVAJwcSsN7kKJewTKzFOL49WHdv55rAbCeJt54Xl9A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=uJ6sdg
        YGQs1BXS34e8swW0TDIolx5yprqRNrU8S73y12IdEIyzVa8PaqZUoopnoflJYwgT
        J9tCZYoat7hy8ojhxWqZZwqt59Yo7OG0G8jYjQDpUGQMocGNBKMcvbFriSeDFFFb
        KXA/tns4KDSN96VrvRYvCINSyGMSXaIqnvNcg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7257D65B4B;
        Tue, 21 Mar 2017 14:59:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CB2C165B49;
        Tue, 21 Mar 2017 14:59:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 15/16] tag: implicitly supply --list given the -n option
References: <20170321125901.10652-1-avarab@gmail.com>
        <20170321125901.10652-16-avarab@gmail.com>
Date:   Tue, 21 Mar 2017 11:59:53 -0700
In-Reply-To: <20170321125901.10652-16-avarab@gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 21 Mar 2017 12:59:00 +0000")
Message-ID: <xmqq37e6piae.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 922101BE-0E68-11E7-B1A2-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the "tag" command to treat the "-n" invocation as a list-like
> option in addition to --contains, --points-at etc.
>
> Most of the work for this was done in my earlier "tag: Implicitly
> supply --list given another list-like option" commit, but I've split
> off this patch since it's more contentious. Now these will be
> synonymous:
>
>     git tag -n 100
>     git tag -n --list 100

Hmph.  I would understand if these meant the same thing:

    git tag -l -n 100
    git tag -l -n=3D100
    git tag -l -n100

with or without "-l".  And accepting any of the above three without "-l"
instead of rejecting is a very good change, I would think.

I however do not understand how accepting this:
   =20
    git tag -n --list 100

would be a good thing, as "100" an optional parameter to the "-n"
option.

> Whereas before the former would die. This doesn't technically
> introduce any more ambiguity than the aforementioned change applied to
> th other list-like options, but it does introduce the possibility for
> more confusion, since instead of the latter of these dying:
>
>     git tag -n100
>     git tag -n 100
>
> It now works entirely differently, i.e. invokes list mode with a
> filter for "100" as a pattern. I.e. it's synonymous with:
>
>     git tag -n --list 100

Ahhh, yuck.  OK, so in "git tag -n --list 100", 100 does not have
anything to do with the -n option.  It is a pattern and -n specifies
"just one line" by default.

Oh, boy, that is confusing.  While it is very logical.

Still I think it is OK as I can see why people who wanted to have
'-n' in the first place may want

    git tag -n -l <pattern>

Thanks.
