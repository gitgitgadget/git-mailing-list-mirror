Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69E2B1FC43
	for <e@80x24.org>; Fri,  6 Oct 2017 12:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751774AbdJFMOA (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 08:14:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59151 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750950AbdJFMOA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 08:14:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 43AE6AF5C8;
        Fri,  6 Oct 2017 08:13:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=31pSIOMt7/sSNNDllUFrgN7rpfQ=; b=HqYGxE
        miQPSgtgUTEmmB0gbHlJkyJKumRD/NZHkq4rko7l81hlaM0ezulUZ3iir4qZAwyX
        AZ25YCBBTgdSOkDiGPM1HT5/dlqg4GiPH9Hy8KLtTS1Ymz59kneBBh+YEpZ9HoMa
        0O1vJtxNhApOcjPkJsSevSrQI9UnVejodrsAg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=P4SB6+vOnqVUFnqDgSLV5d9Oo7YY+YOC
        gMweb+EYSse71bXuDz+lAZog4IM9A1NcZi1KX6VH+vXyea+Xb0glz3T96+KFKCgF
        MIprmplBPYSt+lWsoXfzSdOlPeOFc3rCDDc8mupjiYveQUjXuwXhJ65QhnvJtdX7
        4rCydudPtJY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3ACFFAF5C7;
        Fri,  6 Oct 2017 08:13:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ADD0DAF5C6;
        Fri,  6 Oct 2017 08:13:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     rpjday@crashcourse.ca
Cc:     git@vger.kernel.org
Subject: Re: is there a truly compelling rationale for .git/info/exclude?
References: <20171006061434.Horde.16MqZ-fejqXm6BLpL7prK1K@crashcourse.ca>
Date:   Fri, 06 Oct 2017 21:13:57 +0900
In-Reply-To: <20171006061434.Horde.16MqZ-fejqXm6BLpL7prK1K@crashcourse.ca>
        (rpjday@crashcourse.ca's message of "Fri, 06 Oct 2017 06:14:34 -0400")
Message-ID: <xmqqmv54v5h6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D4EA88A8-AA8F-11E7-9B9D-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

rpjday@crashcourse.ca writes:

>   at the other end, users are certainly welcome to add extra patterns
> to be ignored, based purely on the way they work -- perhaps based on
> their choice of editor, they might want to exclude *.swp files, or
> if working on a Mac, ignore .DS_Store, and so on, using a
> core.excludesFile setting.

This is primarily why .git/info/exclude exists.  A user who does not
use the same set of tools to work on different projects may not be
able to use ~/.gitconfig with core.excludesFile pointing at a single
place that applies to _all_ repositories the user touches.

Also, core.excludesFile came a lot later than in-project and
in-repository exclude list, IIRC.

Don't waste time by seeking a "compelling" reason.  A mere "this is
the most expedite way to gain convenience" back when something was
introduced could be an answer, and it is way too late to complain
about such a choice anyway.
