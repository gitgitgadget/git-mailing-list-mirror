Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 918931F731
	for <e@80x24.org>; Wed,  7 Aug 2019 05:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbfHGFVY (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 01:21:24 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62863 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfHGFVY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 01:21:24 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7490B88297;
        Wed,  7 Aug 2019 01:21:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kQOiXWM0Pnbgvc+2kHifndydOi0=; b=tfl6MR
        vN2X5944ohIohN+K8IJOe1r7ePz4iku5R7RI5DW8WkIE2siVuHm80u+gi8LfDY9Z
        48KaOexO5WI7mNwpjGn7FMdx039XeLgytQgwDENe7CJHW1G7DbrPWBJ3JSRDy3xh
        tpBd4lFRHS9JSDJWJG7JgPcEaRMakgjpvaOfY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XE8m2qdrexsTCOGlOpNJYGA4TklDArQy
        UKH903u0hKKDqwjZcRAv81oBkknfjFegcDZglelE7Lpwkh6jcCNPVwBJioesKAbF
        vVWBQhfL3ZNrMCV85Ev4tzg0SsBHEo3vMc4J4Yr2SnJoPOQhIgUz1xulXttNsrzS
        tK1oQ+EPwt4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6CF6888296;
        Wed,  7 Aug 2019 01:21:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9A32A88295;
        Wed,  7 Aug 2019 01:21:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-gui: Call do_quit before destroying the main window
References: <20190804143919.10732-1-me@yadavpratyush.com>
        <b7cbe50d-879f-68b9-30b2-181c3058297f@yadavpratyush.com>
        <xmqqftmejgr1.fsf@gitster-ct.c.googlers.com>
        <549ad583-5ca1-7096-f4ce-10e8a836f7f9@yadavpratyush.com>
Date:   Tue, 06 Aug 2019 22:21:17 -0700
In-Reply-To: <549ad583-5ca1-7096-f4ce-10e8a836f7f9@yadavpratyush.com>
        (Pratyush Yadav's message of "Wed, 7 Aug 2019 00:34:51 +0530")
Message-ID: <xmqqmuglim9e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 301F2636-B8D3-11E9-9F84-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav <me@yadavpratyush.com> writes:

> I'm not too optimistic on finding someone to run this project. I asked
> on the list who the maintainer is [0], and no one came up. The repo at
> [1] also seems abandoned.

In the meantime until somebody steps up, I might run my own copy.

I need to allocate a block of time to see how stale Pat's tree is
(e.g. its mainline may have more commits than what we have pulled,
in which case we need to be extra careful---these old commits may be
something Pat found dubious and decided to wait before telling me to
pull, and we would be better off ignoring them) before I can say
anything definite, but I am hoping that there won't be too many
patches flowing to the git-gui project; anything high volume and/or
tricky tcl/tk would be beyond my capacity as an interim maintainer
to maintain the quality of the codebase of it.
