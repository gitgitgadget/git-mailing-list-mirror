Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE2491F97E
	for <e@80x24.org>; Wed, 28 Nov 2018 03:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbeK1O7I (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 09:59:08 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57056 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbeK1O7I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 09:59:08 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9B17D1F3D6;
        Tue, 27 Nov 2018 22:58:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=IXA+eHyQ/KMQ
        BK37ssDdB1jDXgc=; b=UNO6qK4iKD+RSP65isYu1HRgvXoW1AitHlySliw/QVoY
        zkizwzasQ4MxDJQhJ1kEp1uv4kTJ8U+fkdRGSLi/4KvBkLnWJV55QLccSB6ZhIKc
        zlUa14PASoEJqpsQUIqfA1+RNQH/0Wm6ysHyD3y8t8C6VssNDkQ0tCzJTP6S0uo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=v2hGGY
        qhKkVYdIsb+0sLpQMnY0ljBcs2mWlwft1MVjyZrCftgNC46tsGYDZ1arxD/ejk31
        gRgO2sWIIr6oW+5DDWJeUO63IK6PNMf+NLmsadR6uaLqDYM+ud24/ZmbyORyLPG6
        w42ND+xQ9FtDavGAn14qrDH85gNs0indgZtME=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 91C041F3D4;
        Tue, 27 Nov 2018 22:58:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id ACB801F3D3;
        Tue, 27 Nov 2018 22:58:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Per Lundberg <per.lundberg@hibox.tv>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Steffen Jost <jost@tcs.ifi.lmu.de>,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Clemens Buchacher <drizzd@gmx.net>,
        Holger Hellmuth <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH] Introduce "precious" file concept
References: <20181111095254.30473-1-pclouds@gmail.com>
        <875zxa6xzp.fsf@evledraar.gmail.com>
        <871s7r4wuv.fsf@evledraar.gmail.com>
        <20181112232209.GK890086@genre.crustytoothpaste.net>
        <280aa9c3-0b67-c992-1a79-fc87bbc74906@hibox.tv>
        <xmqqzhtwuhpc.fsf@gitster-ct.c.googlers.com>
        <87mupuzhfx.fsf@evledraar.gmail.com>
Date:   Wed, 28 Nov 2018 12:58:51 +0900
In-Reply-To: <87mupuzhfx.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 27 Nov 2018 16:08:34 +0100")
Message-ID: <xmqqa7ltua2s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EC063AD4-F2C1-11E8-A1F0-CC883AD79A78-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> What do you think about some patch like that which retains the plumbing
> behavior for things like read-tree, doesn't introduce "precious" or
> "trashable", and just makes you specify "[checkout|merge|...] --force"
> in cases where we'd have clobbering?

Whether you like it or not, don't people's automation use tons of
invocations of "git merge", "git checkout", etc.?  You'd be breaking
them by such a change.  Other than that, if we never had Git before
and do not have to worry about existing users, I'd think it would be
a lot closer to the ideal than today's system if "checkout <tree>
foo.o" rejected overwriting "foo.o" that is not tracked in the
current index but matches an ignore pattern, and required a
"--force" option to overwrite it.

A user, during a conflict resolution, may say "I want this 'git
checkout foo/' to ignore conflicted paths in that directory, so I
would give "--force" option to it, but now "--force" also implies
that I am willing to clobber ignored paths, which means I cannot use
it".

I would think that a proper automation needs per-path hint from the
user and/or the project, not just a single-size-fits-all --force
option, and "unlike all the *.o ignored files that are expendable,
this vendor-supplied-object.o is not" is one way to give such a
per-path hint.

> This would give scripts which relied on our stable plumbing consistent
> behavior, while helping users who're using our main porcelain not to
> lose data. I could then add a --force option to the likes of read-tree
> (on by default), so you could get porcelain-like behavior with
> --no-force.

At that low level, I suspect that a single size fits all "--force"
would work even less well.

