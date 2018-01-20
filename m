Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9DE51F424
	for <e@80x24.org>; Sat, 20 Jan 2018 22:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756755AbeATW1F (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 17:27:05 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62833 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756712AbeATW1D (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 17:27:03 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 63924D9D54;
        Sat, 20 Jan 2018 17:27:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tdCWlWM1gJCY3i0fW6LipzDCjpI=; b=LQBjsT
        3Bh9QOUILhGpOBLZjhsu7QRZtEGXyYlYAVUrbX+eWHho//Z+RiXep/yeV2TgZBVy
        Ij4Pxx8/CNmvAh8fmSNUna9/x7wIL/jD0xEGo81RPHRnYrDf9yswZSWfGRpaBSoR
        ZBkMuyT+f3bWbfePSOjVb1ZWkuJK8lxYRFuIA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oBgyMrMrdAMfpcy2F2IAIHqp69zwwD+J
        QquZI88CKTCD6qn5Lw5wLjH7GsPFW5EYUqQcfjdB19WsDwmqu24ppoIWwNzXGR/k
        dbwO817teTX/I9xvKDIxSdTvJCB1Edy5pAheOMWA2+9ZHmyWdsJhGCH4QXIJQQ76
        bVBYVr+OtKY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5AD55D9D53;
        Sat, 20 Jan 2018 17:27:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B0981D9D52;
        Sat, 20 Jan 2018 17:27:01 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] enable core.fsyncObjectFiles by default
References: <20180117184828.31816-1-hch@lst.de>
        <xmqqd128s3wf.fsf@gitster.mtv.corp.google.com>
        <87h8rki2iu.fsf@evledraar.gmail.com>
        <CA+55aFzJ2QO0MH3vgbUd8X-dzg_65A-jKmEBMSVt8ST2bpmzSQ@mail.gmail.com>
        <20180117235220.GD6948@thunk.org>
        <CA+55aFxgg6MT5Z+Jox2xyG28g9jNJ4cL3jNZ5AgTOmUODuiBsA@mail.gmail.com>
        <20180118162721.GA26078@lst.de>
        <xmqqzi59psxt.fsf@gitster.mtv.corp.google.com>
        <20180120221445.GA4451@thunk.org>
Date:   Sat, 20 Jan 2018 14:27:00 -0800
In-Reply-To: <20180120221445.GA4451@thunk.org> (Theodore Ts'o's message of
        "Sat, 20 Jan 2018 17:14:45 -0500")
Message-ID: <xmqqefmknp3f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0921BC3C-FE31-11E7-88A9-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Theodore Ts'o <tytso@mit.edu> writes:

> ....  I've never been fond of the "git repack -A" behavior
> where it can generate huge numbers of loose files.  I'd much prefer it
> if the other objects ended up in a separate pack file, and then some
> other provision made for nuking that pack file some time later....

Yes, a "cruft pack" that holds unreachable object has been discussed
a few times recently on list, and I do agree that it is a desirable
thing to have in the longer run.

What's tricky is to devise a way to allow us to salvage objects that
are placed in a cruft pack because they are accessed recently,
proving themselves to be no longer crufts.  It could be that a good
way to resurrect them is to explode them to loose form when they are
accessed out of a cruft pack.  We need to worry about interactions
with read-only users if we go that route, but with the current
"explode unreachable to loose, touch their mtime when they are
accessed" scheme ends up ignoring accesses from read-only users that
cannot update mtime, so it might not be too bad.

