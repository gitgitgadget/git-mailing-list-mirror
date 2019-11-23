Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4170C432C3
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 01:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2472070E
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 01:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IFrJe9UY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfKWBcg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 20:32:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50537 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfKWBcf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 20:32:35 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E95D19AE9;
        Fri, 22 Nov 2019 20:32:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aYHJ6c8Zjeq0mcwbcKX8CpfDB80=; b=IFrJe9
        UYX7vVRdCCG4onXpfWCOFY6iXLY4IQAqDjapJco7vMw8cFv6jHY1uUFh5Yf20vWz
        Y7+1AsPMK8mUVM5GfubtOlDY5oRbGUAI2bHCj0kE/4+1BO1ypQSuH8pwTLpJbz+O
        W5c0Ww/u4MT0Csgqlag1So8TbpVnIZi1dE+XE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cLjdJ5rhFRdAbk5Gu/fbvuTZ4YoZjqdR
        KReTfdPucA1e0LOo/o9ZaKO7t+/YB4CsVFkW/0OmIyerN2W+UTNPleKQnOfcAdgr
        qhefggEj9SvgiXuKgcOoYzNnZaFUBNA1BcLkNt8w3GsNUfnpubWM0kKDbU8Kh1Ma
        h27sCojkptA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3673619AE8;
        Fri, 22 Nov 2019 20:32:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9800B19AE7;
        Fri, 22 Nov 2019 20:32:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 02/22] apply-one-time-sed.sh: modernize style
References: <cover.1574296987.git.liu.denton@gmail.com>
        <cover.1574449072.git.liu.denton@gmail.com>
        <1fddaab7011dae7cdd15dee83a94b021085f6703.1574449072.git.liu.denton@gmail.com>
Date:   Sat, 23 Nov 2019 10:32:31 +0900
In-Reply-To: <1fddaab7011dae7cdd15dee83a94b021085f6703.1574449072.git.liu.denton@gmail.com>
        (Denton Liu's message of "Fri, 22 Nov 2019 10:59:47 -0800")
Message-ID: <xmqqk17r2x8w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1ECC9DF6-0D91-11EA-AAD9-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Convert `[ ... ]` to use `test`.
>
> Move the `then`s onto their own lines so that it conforms with the
> general test style.
>
> Instead of redirecting input into sed, allow it to open its own input.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  t/lib-httpd/apply-one-time-sed.sh | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

This one is new in this round.  As a conversion to match the style
guidelines, it looks OK, but the original feels a bit substandard in
other ways, e.g. I would have said "if one-time-sed is a file",
instead of "if one-time-sed exists as any kind of filesystem
entity", and used "cmp -s out out_modified" instead of "diff", which
is an overkill if you want to merely learn if two things are equal.

Wait.  If we are to see if A and B are the same, and show A when
they are the same and otherwise show B, wouldn't it be much simpler
to do without comparison and always show B unconditionally instead?

What am I missing?

Ah, there is one extra command in the "else" clause that we cannot
see in the post-context.  So, sorry for the noise---don't wait ;-)

But all the other things before the "Wait" still stands.

Thanks.

> diff --git a/t/lib-httpd/apply-one-time-sed.sh b/t/lib-httpd/apply-one-time-sed.sh
> index fcef728925..3e9a615311 100644
> --- a/t/lib-httpd/apply-one-time-sed.sh
> +++ b/t/lib-httpd/apply-one-time-sed.sh
> @@ -7,11 +7,13 @@
>  #
>  # This can be used to simulate the effects of the repository changing in
>  # between HTTP request-response pairs.
> -if [ -e one-time-sed ]; then
> +if test -e one-time-sed
> +then
>  	"$GIT_EXEC_PATH/git-http-backend" >out
> -	sed "$(cat one-time-sed)" <out >out_modified
> +	sed "$(cat one-time-sed)" out >out_modified
>  
> -	if diff out out_modified >/dev/null; then
> +	if diff out out_modified >/dev/null
> +	then
>  		cat out
>  	else
>  		cat out_modified
