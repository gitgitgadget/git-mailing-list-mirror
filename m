Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8CD01FF7F
	for <e@80x24.org>; Sat, 10 Dec 2016 22:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752769AbcLJWJc (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 17:09:32 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52549 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752300AbcLJWJb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 17:09:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B19254AA5;
        Sat, 10 Dec 2016 17:09:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g1yes4tXz1w/f9yaRGVNZUCmNbk=; b=JdrudX
        WLvkSkQTFl8+C0sx/sgZ/9BqibZLt/IMToVf2O6DpmWvLaX9bhTupahJRJw2u5vy
        wlMs3REbjSWGFqQPE0yj4pD4uHH+4U+aJgFAHidzSIxh6fmDqHcoqChJ2Pjs9SWA
        V1mwXTMFspjEBN9Lld0U3qBVb7OJxVPXiDXxY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TTLNwodbq9QuUFMXTnMUz/WSa+KcR51I
        YEkFmJezr+20Pd7N+3W/rUwEELW0z+YEGI+L1hIsd0It5BD/mN6zW2mS7bblHRdS
        ggfo1LgbB/9KIQcp5gbEB5wNKPq6fyjMx0rvSPIBcKbcr3XLDQT7cuu+IbEEGhTs
        yZkglKAcSSc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 601A854AA4;
        Sat, 10 Dec 2016 17:09:30 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A2BE954AA1;
        Sat, 10 Dec 2016 17:09:29 -0500 (EST)
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
Date:   Sat, 10 Dec 2016 14:09:28 -0800
In-Reply-To: <1481364496.1993.14.camel@sapo.pt> (Vasco Almeida's message of
        "Sat, 10 Dec 2016 09:08:16 -0100")
Message-ID: <xmqqy3zno2qv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5256B8C2-BF25-11E6-A2D6-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> I wonder why this is important when Git errors out when
> core.commentChar is set to more than 1 characters or 0 characters.

I think it should be consistent with the way core.commentchar is
treated in the rest of the system, namely this bit from config.c:

	if (!strcmp(var, "core.commentchar")) {
		if (!value)
			return config_error_nonbool(var);
		else if (!strcasecmp(value, "auto"))
			auto_comment_line_char = 1;
		else if (value[0] && !value[1]) {
			comment_line_char = value[0];
			auto_comment_line_char = 0;
		} else
			return error("core.commentChar should only be one character");
		return 0;
	}

And I think I misread this piece of code.  

We only update comment_line_char from the default "#" when the
configured value is a single-byte character and we ignore incorrect
values in the configuration file.  So I think the patch you sent is
correct after all.
