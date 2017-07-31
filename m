Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 315E81F991
	for <e@80x24.org>; Mon, 31 Jul 2017 16:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752486AbdGaQc3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 12:32:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50112 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752313AbdGaQc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 12:32:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 36F2AA8335;
        Mon, 31 Jul 2017 12:32:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F3+bCzazcn9ZZAdSHhrZpU+u52g=; b=gOQvx6
        v6eGJzKrNmY1sGd4Di/nl3EXShktVjQTXTU6gKwpxSM0YwoXr4AbX65Yw0BmukL7
        yDzIKSH0KvfA3lRF3OIgcQnogUUsowC5G+i6aKN5C5hqYMxeaSYgBjopLOF/uKb+
        3b3knXxUIOdMSkp7fHKfLoy0h23FNNJBJy/lU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=u2UOkNrBZp1V6HgPnrDrzONOX1fGUqkx
        XXL4hXUJmnsE93W+SMqZ+EUPfJurPEjwOppjNXXrm0VE15+QpiYA+dwCiQfQjuTj
        NM04w7WlMXvht5uRjqMYfX00K5IWIQpOG6PqvW9JR1pThSVVKUPsVt6jM+yBhMAW
        cy/9ILeD3+k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2DDF9A8334;
        Mon, 31 Jul 2017 12:32:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 87003A8332;
        Mon, 31 Jul 2017 12:32:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v2 05/10] git.c: provide setup_auto_pager()
References: <cover.1499723297.git.martin.agren@gmail.com>
        <cover.1500321657.git.martin.agren@gmail.com>
        <b6ab825d3bda4b40201b0aa8e97c9fd721ed8171.1500321658.git.martin.agren@gmail.com>
        <20170731033429.dgftfeum6n3ddxua@sigill.intra.peff.net>
Date:   Mon, 31 Jul 2017 09:32:19 -0700
In-Reply-To: <20170731033429.dgftfeum6n3ddxua@sigill.intra.peff.net> (Jeff
        King's message of "Sun, 30 Jul 2017 23:34:29 -0400")
Message-ID: <xmqq7eyok1nw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D30E93E6-760D-11E7-BA54-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But thinking on it, the most plausible case is something like:
>
>   setup_auto_pager("foo", -1);
>   ...
>   /* fallback to some historical compatibility name */
>   setup_auto_pager("bar", 0);
>
> And it's important for the "-1" there to be a true punt, and not do
> anything in commit_pager_choice(). So it's probably worth documenting
> the "-1" behavior as you did here as a possible value for "def".

Thanks for reading it over. I agree that the "punt" behaviour is a
sensible one in that use case, and I also agree that it would be
good to explain it.
