Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC438C28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 16:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEAA120A8B
	for <git@archiver.kernel.org>; Wed,  6 May 2020 16:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mlXEdaTa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbgEFQ07 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 12:26:59 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51574 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbgEFQ07 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 12:26:59 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BC877C5247;
        Wed,  6 May 2020 12:26:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ofvSSOC9Q1z4SxOubEAwKN1FDac=; b=mlXEda
        Tab5NEgtze10QuB1h5FtOu6K2wM+QtWECioRpyYc+ZW4ybEnkJ2Ow6+21qUMqcFP
        VRqAihkzPLGdEfSQnJuVShRV7dKgxgc1e3j23wMBkoc+RI/f+rgKLb4u8kTQraDJ
        LZi4tCqHseAGu5qdJMaJChhM6gxsJ5vdwxcp4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fmHC3BNvw1q9MM8FZXOoeXsQfcotZava
        uilXu1AwPaTkpDKrASYzwNcoL2HNdgnMtwGgckzlessH37MOzmjAyPx9TtOmoEyH
        poJNtHcFsqiMiHrDMYUm27nYmDrmABwxxKpn3jB6s4TvxrMyr5mVy0TwYuni9PNV
        EZxWMlRtIP0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B43D4C5246;
        Wed,  6 May 2020 12:26:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F3389C5245;
        Wed,  6 May 2020 12:26:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 1/2] CI: limit GitHub Actions to designated branches
References: <20200504150105.GB11373@coredump.intra.peff.net>
        <cover.1588607262.git.congdanhqx@gmail.com>
        <73de97dfebfccabe9f1bf32ea41aea5008a949cd.1588607262.git.congdanhqx@gmail.com>
        <20200504162311.GE12842@coredump.intra.peff.net>
        <20200504215824.GC45250@syl.local>
        <20200504233634.GB39798@coredump.intra.peff.net>
        <20200505002055.GC64230@syl.local>
        <20200505164326.GA64077@coredump.intra.peff.net>
        <xmqqo8r2b6y4.fsf@gitster.c.googlers.com>
        <20200505182418.GA66702@coredump.intra.peff.net>
        <20200505210451.GA645290@coredump.intra.peff.net>
        <xmqqlfm69il6.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2005061623520.56@tvgsbejvaqbjf.bet>
Date:   Wed, 06 May 2020 09:26:53 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2005061623520.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 6 May 2020 17:09:39 +0200 (CEST)")
Message-ID: <xmqqeerx81wy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 663A24EA-8FB6-11EA-956D-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The idea is indeed very neat. I think we can do a bit better with resource
> usage by not even bothering to check this branch out. Something along
> those lines (sorry, I really would love to have the time to test this...):

Nice.  I view the latest round of Peff's idea "allow-ref" as
"because we are spinning a VM anyway, why not just run an end-user
supplied script and let it decide?" and not as "we must have a
Turing complete flexibility so let's run a script in a VM".  In
other words, it may be overkill and we may strike a better tradeoff
by living with reduced flexibility if there is a way to avoid the
associated cost.

But doesn't this (i.e. uses: actions/github-script) still pay the
cost of spinning up a VM?  How expensive is it to check out a small
tree with a single file, whether it is ref-whitelist or allow-ref?

If the cost to check out a tree is dwarfed, it probably is not worth
pursuing the approach to use a canned "don't customize, just use"
logic in the workflow file to read a configuration file that can
only list full names of allowed refs.

Thanks.

>       - id: check-ref
>         name: check whether CI is enabled for ref
>         uses: actions/github-script@0.9.0
>         with:
>           script: |
>             const req = {
>               owner: context.repo.owner,
>               repo: context.repo.repo,
>               ref: "ci/config"
>             };
>
>             try {
>               req.tree_sha = (await github.git.getRef(req)).data.object.sha;
>               (await github.git.getTree(req))
>               .tree.filter(e => e.path == 'ref-whitelist').map(e => {
>                 req.file_sha = e.sha;
>               });
>               const list = Buffer.from((await github.git.getBlob(req)).data.content, 'base64').toString('UTF-8');
>               core.setOutput('enabled', `\n${list}`.indexOf(`\n${{github.ref}}\n`) < 0 ? 'no' : 'yes');
>             } catch (e) {
>               core.setOutput('enabled', 'yes');
>             }
>
> Ciao,
> Dscho
