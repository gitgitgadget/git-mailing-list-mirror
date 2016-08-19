Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC9391F859
	for <e@80x24.org>; Fri, 19 Aug 2016 16:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753120AbcHSQMM (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 12:12:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54526 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751599AbcHSQMK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 12:12:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B09ED35162;
        Fri, 19 Aug 2016 12:11:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WoyltKX304s4tmbARcfApBrXQHM=; b=JNVV5w
        hYH4JEmoUKO47+Py9LegM5x971S4YOocdTwwrhLLIRdcGsFNs5qRPboVnDbaxXp9
        5S1+EMQs58vNcVNSxsoQ1i/HEpo/uSfHh0hKyWQZikZsWTcH0Owf95z/bolabF74
        68d5jKTro0wdI09SXfNdBlkAxb5GGVlC6y6FU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bZy67E6JpjsMBUAiS48i9KnPxcrxIClV
        paf5DVWYBA3DdXQ99CwI274Y1diHqBPcO0UG912485FkQJ+ez7umjE9BAIrMDUev
        kB9fUoVszZ5rX6gEJkK8ByubEBC1BQo1tHA4lMbDoY3WO6D7LGnwiIeNY9bzszE5
        nLAqzBeVvFM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A967635161;
        Fri, 19 Aug 2016 12:11:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 31A983515E;
        Fri, 19 Aug 2016 12:11:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/4] cat-file --textconv/--filters: allow specifying the path separately
References: <cover.1471524357.git.johannes.schindelin@gmx.de>
        <787224ce9a382ddd1180a408e784ca26993e5603.1471524357.git.johannes.schindelin@gmx.de>
        <xmqqfuq26mu3.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1608191521410.4924@virtualbox>
Date:   Fri, 19 Aug 2016 09:11:28 -0700
In-Reply-To: <alpine.DEB.2.20.1608191521410.4924@virtualbox> (Johannes
        Schindelin's message of "Fri, 19 Aug 2016 16:49:23 +0200 (CEST)")
Message-ID: <xmqqy43s3fin.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96DC4F54-6627-11E6-8483-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I think I saw some code to ensure "when giving this option you need
>> that option in effect, too"; they should be tested here, too, no?
>
> No, I would rather not test for that. These conditionals are purely for
> any user's convenience, in case they specify an option that has no effect.
> They are absolutely not essential for the function introduced in this
> patch series.

I didn't say "you would want to test these, no?", did I?

I do not want to see bugreports that say "I wanted to use this new
feature and by mistake gave only --path without giving --filter; Git
should have complained.  I found a bug, hooray!" when somebody in
the future refactors the command line option parsing and breaks the
check you already have.

