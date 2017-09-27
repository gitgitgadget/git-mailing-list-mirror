Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8E5D202A5
	for <e@80x24.org>; Wed, 27 Sep 2017 07:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752165AbdI0H2M (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 03:28:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64729 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752122AbdI0H2L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 03:28:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 66CFBB1A36;
        Wed, 27 Sep 2017 03:28:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1ppevjm6I/d0C09sIZBSdvbJW0g=; b=YPYuhC
        abfPoEPQgIKI6u9q32e3O+1oTyYWzKKnAmJQGLw/oK0ymPMpu4jHxIxrC/+UtwtM
        KZz2BNet6eY2Xb1RD4zS7+oEujGVnPTJFt2ixnZj3mui00uYMJTCnRm3f+Ts/uWY
        yA9Nps7l5+tWQZnMxCelLkU7bzpQ7+zncdGrE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ezVWdmhwlM6LzRHqS1s5YfMOu0Q8Bprc
        M65snoYGkbbjWKMaz1LZZUmk0cwnve/J2E+VmU+hM7Jm2c0VqISBzuxO9Ckonqy5
        xfviurModwW0+GvuSg6yEoKZaK8iePZw4I/oejfJv/S5dGTkM/icVo/tkQTZQSw/
        y/DDNQC5mqI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5EE39B1A35;
        Wed, 27 Sep 2017 03:28:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C2710B1A34;
        Wed, 27 Sep 2017 03:28:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] validate_headref: NUL-terminate HEAD buffer
References: <20170927061644.gwlhxaiairiy2njp@sigill.intra.peff.net>
        <20170927061722.7ubswfgykxiawzh3@sigill.intra.peff.net>
        <xmqqefqs4o41.fsf@gitster.mtv.corp.google.com>
        <20170927071625.3dtljf5oaiaa5pjq@sigill.intra.peff.net>
Date:   Wed, 27 Sep 2017 16:28:08 +0900
In-Reply-To: <20170927071625.3dtljf5oaiaa5pjq@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 27 Sep 2017 03:16:25 -0400")
Message-ID: <xmqq60c44n3r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 69A58D68-A355-11E7-9EE5-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I had the same concern, but actually truncation is not a problem here
> (for a symlink or a symref). We are only seeing if the contents look
> vaguely correct, so really we never parse past "refs/" in either case.

Ahh, OK.

It seems that at least for this week, my reviews always show you
thought things more thoroughly than I did, which is good in a weird
sort of sense ;-)
