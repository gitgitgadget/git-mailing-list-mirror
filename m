Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 494631F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 18:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395320AbfJQSHc (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 14:07:32 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55164 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388188AbfJQSHc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 14:07:32 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F2BB890A68;
        Thu, 17 Oct 2019 14:07:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jAoOZe3ttPG3v25YEcZSgNO6xHA=; b=YE9o+g
        IwoZUQ8C/1nawbyqvKYGboGBoel4IFo6XbV5wYtSzl7Z2D3itCODQ0F6n/sFbSXL
        cEBzfZGw6BDYFccg3DfGfmQKUDTbbLur15+u9y1X3XJ8I6sGB06ivvmUkzEZjYy5
        BUHq2vLL9P9q7OSyeb8UrFzWObKSVQpIAqW2s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=x9W398PY+1aQP+oy+jtmPwZNX9d+/vfJ
        I0uKNbrh9JxXc54nKv+mggr5XJj2c11+CHxS0A/4bTaky6QOlk2K2s7Uy1mXa5/H
        kkDwt8e65JBGtXzTra91DblfNt99wm/pIPGg7lLz7JZyc0G7ofrS6QjF4eowpD7X
        V57I6pEUQ70=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EB5EF90A67;
        Thu, 17 Oct 2019 14:07:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1B84690A63;
        Thu, 17 Oct 2019 14:07:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC PATCH 1/7] Makefile: alphabetically sort += lists
References: <cover.1571246693.git.liu.denton@gmail.com>
        <02a16f9bdf740841d9a4be765e72b9fa5ae5d75c.1571246693.git.liu.denton@gmail.com>
Date:   Fri, 18 Oct 2019 03:07:24 +0900
In-Reply-To: <02a16f9bdf740841d9a4be765e72b9fa5ae5d75c.1571246693.git.liu.denton@gmail.com>
        (Denton Liu's message of "Wed, 16 Oct 2019 10:26:21 -0700")
Message-ID: <xmqqimon6yar.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FA348872-F108-11E9-94E2-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> There are many += lists in the Makefile and, over time, they have gotten
> slightly out of order, alphabetically. Alphabetically sort all += lists
> to bring them back in order.
> ...

Hmm.  I like the general thrust, but ...

>  LIB_OBJS += combine-diff.o
> -LIB_OBJS += commit.o
>  LIB_OBJS += commit-graph.o
>  LIB_OBJS += commit-reach.o
> +LIB_OBJS += commit.o

... I do not particularly see this change (there may be similar
ones) desirable.  I'd find it it be much more natural to sort
"commit-anything" after "commit", and that is true with or without
the common extension ".o" added to these entries.

In short, flipping these entries because '.' sorts later than '-' is
making the result look "less sorted", at least to me.

Thanks.
