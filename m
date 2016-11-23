Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE4881FF30
	for <e@80x24.org>; Wed, 23 Nov 2016 18:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753460AbcKWSTA (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Nov 2016 13:19:00 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51961 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750776AbcKWSTA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2016 13:19:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B12F4F6F6;
        Wed, 23 Nov 2016 13:18:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OWGk//WUl7+Acr2J0El7bqJSL/w=; b=TQ0Vd7
        dipW9yTzkZ0dQnjhiWE5sJ97yLAPKig598CldqEZw01W5QA63qlbIwZaDB6aab1+
        G0yIMzdQTW+mRGsq+BxmB375gzkltsnwDwuVuDdlU7d3VIO0i1XU2QJs6iayPxqU
        +fGXOa1aN8F+lQlEUTCwRmAkXq8jlPdNDQwSo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TmpfUgkoElIxNE9c9OWNKV0TeFOIw5X+
        o4W1bEUgQAdyNE4XtFU9zxzzLv9JkQvpWRypcgdQx2zoWmwVVdDU1Twu83LKRoir
        p8qKBjpieWsh83qbWDTBa00JMzoe//AE/JacovTvVjwFVs9wuAJqaQk98acTFzrF
        bnAy1G4iXo4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 73C654F6F5;
        Wed, 23 Nov 2016 13:18:58 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EBF614F6F4;
        Wed, 23 Nov 2016 13:18:57 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] difftool: add a feature flag for the builtin vs scripted version
References: <cover.1479834051.git.johannes.schindelin@gmx.de>
        <598dcfdbeef4e15d2d439053a0423589182e5f30.1479834051.git.johannes.schindelin@gmx.de>
        <1479912693.5181.27.camel@kaarsemaker.net>
        <alpine.DEB.2.20.1611231824530.3746@virtualbox>
        <xmqqh96ym6x6.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 23 Nov 2016 10:18:56 -0800
In-Reply-To: <xmqqh96ym6x6.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 23 Nov 2016 09:40:05 -0800")
Message-ID: <xmqqd1hmm54f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4CF15006-B1A9-11E6-BA96-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Can't you route the control upon seeing "git difftool" to your
> experimental "C" difftool and check the configuration there?  Then
> you can decide to run_command() a non-builtin one depending what the
> configuration says---that way, you would incur cost of spawning Perl
> only when you need it, no?

FWIW, the approach taken by 73c2779f42 ("builtin-am: implement
skeletal builtin am", 2015-08-04) is what I had in mind when I wrote
the above.
