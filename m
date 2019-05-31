Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D0731F462
	for <e@80x24.org>; Fri, 31 May 2019 16:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfEaQaM (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 12:30:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57375 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfEaQaM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 12:30:12 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BDEF415CBFB;
        Fri, 31 May 2019 12:30:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xsDxTLeRdpsN6Gq0hgyVBeNhzyA=; b=PmiFHa
        apByGyqkD3vwWA06SL7d85Oz9LUd1iYg8pd8Zx5dLcVMcTvndvrZ1fZRwMc5eh9c
        Iif9uuAVKU2GVlV6t3hcxMepG0xoqfucNJdgewxmD56z0kbQLcNrjqfx+/dHA1je
        sv9LR1hG6C2i8TXO5YQDEgFtN9otsq+sDzr+s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M7KNX+g80T0/WnSMgNU9OJVTCfGkbnJx
        6lEPXnqPgUWVcx5keJcKvdlxzTvxogMQnho//4x6PGf3vAhIWcIUBAyF9R5PX2kB
        Hgu94qz69leIeiVF6yEe6rPUpm12pj5Imwrc6cuA+X2gb8tDLC0N+640I3NurH4+
        w5oDwFGV0O4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A448315CBFA;
        Fri, 31 May 2019 12:30:09 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 672CB15CBF6;
        Fri, 31 May 2019 12:30:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Dr. Adam Nielsen" <admin@in-ici.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] make slash-rules more readable
References: <20190531074426.6810-1-admin@in-ici.net>
Date:   Fri, 31 May 2019 09:30:06 -0700
In-Reply-To: <20190531074426.6810-1-admin@in-ici.net> (Adam Nielsen's message
        of "Fri, 31 May 2019 09:44:26 +0200")
Message-ID: <xmqqh89awprl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5AA87606-83C1-11E9-862B-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Dr. Adam Nielsen" <admin@in-ici.net> writes:

> gitignore.txt: make slash-rules more readable
>
> Remove meta-rule in a paragraph for trailing-slash.
> Be precise whenever a trailing slash would make a 
> difference. Improve paragraph for pattern without slash. 
> Remove rule for leading slash because its now redundant. 
> Instead, add examples for leading slash and asterix in 
> example section.
>
> Signed-off-by: Dr. Adam Nielsen <admin@in-ici.net>
>
> ---
>  Documentation/gitignore.txt | 71 ++++++++++++++++++++++++++-----------
>  1 file changed, 50 insertions(+), 21 deletions(-)

I think the updated text is readable, except for one nit.

Specifically, if you took my suggestion in an earlier review to
explicitly say that leading slash is merely a workaround for a
string without slash to anchor the pattern to the directory and
it should be treated as if it does not exist otherwise, then ...

> + - The pattern `doc/frotz` and `/doc/frotz` have the same effect
> +   in any `.gitignore` file. Both pattern contain a non-trailing
> +   slash and thus match relative to the location of the
> +   `.gitignore` file.

... this paragraph wouldn't have been necessary.  

Besides, one extra reason why these two have the same effect is not
given in the updated text to explain away "To which substring of
path 'doc/frotz' does that leading slash in /doc/frotz match?"

The updated text does not seem to explain that the leading slash is
merely to pretend that the pattern "contains a slash so it does not
apply in a subdirectory" and for the purpose of pattern matching the
slash does not participate in the textual match, which seems to have
been lost in the updated patch, relative to the suggestions raised
in the review of earlier rounds.

The updated description on trailing slash as type specifier
(i.e. directory-only) is much easier to follow compared to the
earlier rounds of this patch, I would think.

Thanks.
