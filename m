Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF97F1F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 22:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751282AbcIAWiX (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 18:38:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55099 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750958AbcIAWiX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 18:38:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF0E63A395;
        Thu,  1 Sep 2016 18:38:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hizXUxYmN5VxZdWoSPlVSLocOwI=; b=qA6nbi
        U7I/qP6Z12XAIVO8NwFAPbt4Hd50Um3WeOVwTtsRCz/mD6QsQ657oCWD78yBSwla
        JmE7Of5vDCogxiF/PueawDu06bPkJ5dqWCiih3d26nMpOfnB16McBZ7ZlgDg7vb1
        Jxur70bjs27X7jRF8rsuCGNi5J8fgqdyc39gU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MBtoJUUv2PtTbKcQ8qyQiml3LjvsGPrN
        ex+v+qR/SSxmZARJiu9tuUcdEsoBa5kT36Afo/GroFj90LTlMrpXdNJz1+hDsQdd
        ozEDJT47OfdLgBjU8EEg46m94lxpKKq6taBeHTKW/EtCJ5/kmZ4w9C8M3lPBoeNE
        e4gzPAa8AJM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A68EC3A394;
        Thu,  1 Sep 2016 18:38:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 285E93A393;
        Thu,  1 Sep 2016 18:38:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Jan Keromnes <janx@linux.com>, git@vger.kernel.org,
        Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>,
        Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: `make profile-install` fails in 2.9.3
References: <CAA6PgK7C18F1WGyZMTEUAWEVsUWqiZND5Ne_0SH-rUEm8u5dNg@mail.gmail.com>
        <20160901200700.GA8254@hank>
        <20160901215810.ez47lqwmfmahyvc7@sigill.intra.peff.net>
        <xmqqh99zuuyh.fsf@gitster.mtv.corp.google.com>
        <20160901222015.wqhrerudnwddbyhz@sigill.intra.peff.net>
Date:   Thu, 01 Sep 2016 15:38:19 -0700
In-Reply-To: <20160901222015.wqhrerudnwddbyhz@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 1 Sep 2016 18:20:15 -0400")
Message-ID: <xmqq4m5zutyc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C914AA26-7094-11E6-8FA7-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yeah, I had a similar thought, but it just feels so hacky. Is there
> anything wrong with making this completely separate from the content
> update. I.e., just applying the pathspec to the index as a separate step
> and adding "+x" to each entry?
>
> This really is just a more convenient interface around "update-index
> --chmod", isn't it? We should be able to do the same thing it does.

Sure, the simplest and the most straight-forward way may look dumb,
but it would be the safest.


