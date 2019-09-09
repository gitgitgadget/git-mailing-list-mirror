Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D50B01F461
	for <e@80x24.org>; Mon,  9 Sep 2019 17:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbfIIRhX (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 13:37:23 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53971 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbfIIRhX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 13:37:23 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DCB76925BF;
        Mon,  9 Sep 2019 13:37:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zeQ9tEQew5HZJa88+ph9/IBCHOo=; b=jG8lze
        jweJssKtahEZXs52uuZIgBpvGI41CcMxIPYH5E5pYHYhrjPL4ndKoDwCsOVb8MZp
        WrVOsTQODDMzwcGH2SYQ/IPaHDa7mJ7BWiY5CjWbgPgOM430WnbyIdVoGpCnl1LH
        nptCaY1mqNKLl3KMbKz8LQoZKQxbUe9qxZ93k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ff8BvbgwffKPtg44IzJ96S+8tXVCJhln
        3dSRvJ/4frDB5QvxfWKdLfrNJYx/hdHfkNDBUx6CdXuZGwPIpNwJOCn1Xe9EKN9e
        Iga8tNuVTiu8+piNwkxU633+BagUbj/KkZNaX6m23WiArs43KMxKzgnfSTgqfVwq
        GsKeLbJE+Bg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D4E14925BE;
        Mon,  9 Sep 2019 13:37:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0C776925BD;
        Mon,  9 Sep 2019 13:37:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH] Documentation: fix build with Asciidoctor 2
References: <20190906232947.GJ11334@genre.crustytoothpaste.net>
        <20190907170746.273984-1-sandals@crustytoothpaste.net>
        <20190908104833.GE15641@sigill.intra.peff.net>
        <20190908171807.GL11334@genre.crustytoothpaste.net>
        <20190908212122.GA8514@sigill.intra.peff.net>
        <20190908222423.GN11334@genre.crustytoothpaste.net>
Date:   Mon, 09 Sep 2019 10:37:14 -0700
In-Reply-To: <20190908222423.GN11334@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 8 Sep 2019 22:24:24 +0000")
Message-ID: <xmqqr24pl6b9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 77A088BE-D328-11E9-95B1-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> There are a couple ways around this.
>
> 1. We can force xmlto to use the DocBook 5 stylesheets with the "-x"
> flag, but we have to know where they are.  Debian and Fedora have them
> in different places, so we'd need a knob to figure out where they are.
>
> 2. We can force xmlto to use a custom stylesheet with "-x" that merely
> imports the DocBook 5 stylesheets using a URL.  If the user has the
> DocBook 5 stylesheets installed and XML catalogs configured (the default
> on Linux distributions), then everything will just work and the system
> will resolve it to the local copy.  If, however, things are not properly
> configured, this will result in multiple network downloads for each
> manual page.
>
> 3. We can give up on xmlto and do things ourselves.  This has the same
> problem as option 1, since we need to learn how to find the stylesheets.
>
> 4. We can send a patch to xmlto to make it use the proper stylesheets
> for DocBook 5 and hope upstream does a release and everyone upgrades
> shortly.  Since xmlto is not at all active upstream, this seems like it
> may be an imprudent choice.
>
> 5. We can send a patch to the DocBook stylesheets and have them include
> both the namespaced and unnamespaced versions of the element names in
> both sets of stylesheets and hope everyone upgrades.
>
> My personal preference is #2; I think that seems like the best choice
> forward.  XML catalogs are well understood and well configured on Linux
> distributions.  Homebrew supports them adequately, but you have to add
> an environment variable to your shell configuration to enable them.  Of
> course, if you're doing _anything_ with XML, you'll have them enabled.

Sounds sensible and well reasoned.
