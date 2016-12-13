Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66145203EC
	for <e@80x24.org>; Tue, 13 Dec 2016 18:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934758AbcLMSQJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 13:16:09 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60639 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933746AbcLMSQF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 13:16:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A17D54FEA;
        Tue, 13 Dec 2016 13:15:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GWcg8YQDMoi5EYsNu8IwylnZw4o=; b=kTczd/
        surOc2KXuleLS8+Xd68z/PWWZZsQuTbg8TSYtxFQyGkmkUu7cFYfzFlXZHKSG1T3
        omiwgV48GtaD8DmzKVpVHzR758qImdZYCZlgttwsXnBCG1cx09pr2oNeeqJnuTYe
        0AYmi4flsQqCNR4ZkYrK9h8HxfPP6A3fubs9M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NTVa2CUzRYHJPSLGFvZXE4+wAx6W6e+j
        hCjBezbjdEnKjlND0qQv5/riTRhLRETwpf4sjcwxKTX59SVjPoE1PRmPskysAt98
        59zbA2wPFt0eKeg8ZdPEZAGo1VdcCZa3p9Vzo9NmJrj2IlsG1iADvN6tDyYLBrnX
        dYrAe6u8hkU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 72A1054FE8;
        Tue, 13 Dec 2016 13:15:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E7F6A54FE7;
        Tue, 13 Dec 2016 13:15:14 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v6 01/16] Git.pm: add subroutines for commenting lines
References: <20161111124541.8216-1-vascomalmeida@sapo.pt>
        <20161111124541.8216-2-vascomalmeida@sapo.pt>
        <1479823833.1956.7.camel@sapo.pt>
        <xmqqoa17quls.fsf@gitster.mtv.corp.google.com>
        <1481303956.4934.8.camel@sapo.pt>
        <alpine.DEB.2.20.1612091832310.23160@virtualbox>
        <xmqqk2b8rbbb.fsf@gitster.mtv.corp.google.com>
        <1481364496.1993.14.camel@sapo.pt>
        <xmqqy3zno2qv.fsf@gitster.mtv.corp.google.com>
        <1481627820.2041.21.camel@sapo.pt>
Date:   Tue, 13 Dec 2016 10:15:13 -0800
In-Reply-To: <1481627820.2041.21.camel@sapo.pt> (Vasco Almeida's message of
        "Tue, 13 Dec 2016 10:17:00 -0100")
Message-ID: <xmqqinqn4rwu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 184F8A40-C160-11E6-BC8C-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

>> We only update comment_line_char from the default "#" when the
>> configured value is a single-byte character and we ignore incorrect
>> values in the configuration file. So I think the patch you sent is
>> correct after all.
>
> I am still not sure what version do we prefer.
>
> Check whether core.commentchar is a single character. If not, use '#'
> as the $comment_line_char.

This, plus special casing "auto".

Picking the first byte is inconsistent with the current practice
(the paragraph you quoted above), I think.
