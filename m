Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 922451FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 19:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754982AbcH2TE7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 15:04:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55482 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753023AbcH2TE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 15:04:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E2AA392AD;
        Mon, 29 Aug 2016 15:04:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gsQwgtch7IJbQl05oxfgtQgTus4=; b=qb7kuT
        MRFXouSkgV7DoEdyQq9SbqI5+dpv6yyTJx2j40tCtiwQB1sE6eFmkFYYIXrlyn74
        8ofJ7hrwza0Q51zm43/Lac2ZQQd46UdMvCCcVVUpgVpZ9N7FYYCNBSWlcZBkLFHy
        C7QYYOcqcn3XnzAi9U8M2FQ3Jb3JZaSiNMXkU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LpNKoICG/5L+3Ctnzrth0HrLgR8D6a3y
        L6vsABq/FUh9MSGGV0O8wEKFznpaDqPCFfvdZnqFGlPD3yxY38WN1PqfQ1DtJGGJ
        L9bidB0FDttz4LVksK3l61Sjk1uvJa+4erUOhZYcruVYYzuNqW/jkfyCdOYScAs9
        A+yj1Xt9df8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5417A392AA;
        Mon, 29 Aug 2016 15:04:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AF58F392A8;
        Mon, 29 Aug 2016 15:04:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v13 00/14] libify apply and use lib in am, part 3
References: <20160827184547.4365-1-chriscool@tuxfamily.org>
Date:   Mon, 29 Aug 2016 12:04:35 -0700
In-Reply-To: <20160827184547.4365-1-chriscool@tuxfamily.org> (Christian
        Couder's message of "Sat, 27 Aug 2016 20:45:33 +0200")
Message-ID: <xmqq7fazbdmk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6E7937B0-6E1B-11E6-9002-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Highlevel view of the patches in the series
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> This is "part 3" of the full patch series. I am resending only the
> last 14 patches of the full series as "part 3", because I don't want
> to resend the first 27 patches of v10 nearly as is.

Just to make sure, you are sending the first 11 of these 14 exactly
as-is, right?  I didn't spot anything different other than 12 and 13
that replaced the "alternate index" step from the previous round.

