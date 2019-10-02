Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6261D1F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 06:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfJBGvT (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 02:51:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58434 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfJBGvT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 02:51:19 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 258CB33E4A;
        Wed,  2 Oct 2019 02:51:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HflWw+jI0UuJaUOT+2lEpPZiqCA=; b=KzvPx5
        kxuwLA/pji0laR0qPkXwmeKAov5KJOjl80/P6nZgtln6Ag2Ckgy3TG/vIIKOdC+g
        EZbYc+iOlsGAnCeyiGQ4nd1SmXSqjOjW7k3NZX/DO79gA3elwy0yRnQdLW2vvPkx
        iLv+/cbVT+WRNpOPsrgHN5YMdWnvfgmrUUkmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=COKxdmUPsOU2wp3l/6E6gW7LgK4XZZ9d
        R2H5wC4DwlXEuRHqIYdds5pQLQqWLFgfzfxu3gObj/K4Q/Wqp2cMXEr1blbPQK1l
        0ghp2D5uLLEh8AEmKZoD0YQZR3ys+tqv3xd+TbhZxkSD+Qa+gIvxXKA/hTye8+qb
        U1tPNPt8UsM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1BFE533E49;
        Wed,  2 Oct 2019 02:51:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7BA1133E47;
        Wed,  2 Oct 2019 02:51:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Chris Zehner via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Chris Zehner <cbzehner@gmail.com>
Subject: Re: [PATCH 0/1] gitignore: ignore comments on the same line as a pattern
References: <pull.370.git.gitgitgadget@gmail.com>
Date:   Wed, 02 Oct 2019 15:51:15 +0900
In-Reply-To: <pull.370.git.gitgitgadget@gmail.com> (Chris Zehner via
        GitGitGadget's message of "Tue, 01 Oct 2019 20:13:12 -0700 (PDT)")
Message-ID: <xmqqtv8rej30.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 080B1490-E4E1-11E9-927E-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Chris Zehner via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Why make this change?
> =====================
>
> Add the ability to use # to put comments after ignore patterns. This is
> useful for documenting the reason for particular ignore patterns inclusion
> and structure.
>
> Right now a common convention in .gitignore files is to group patterns by
> similarity, using new lines beginning with one or more # characters as
> headings to explain these groupings. This works well when clarifying why
> broad classes of things are ignored, e.g. # build artifacts followed by
> several patterns.
>
> When leaving comments about a particular pattern it can be difficult to
> distinguish comments about a single patterns from comments used for file
> organization.

Not a good enough justification to break backward compatibility, I
would have to say.  If a single line is so tricky to deserve its own
comment, perhaps a group of lines can be separated with the next
group by a handful of blank lines for clarity (or the project can
adopt a convention that differentiates between comments on a group
and comments on an individual rule).
