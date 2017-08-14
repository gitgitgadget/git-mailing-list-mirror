Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF74520899
	for <e@80x24.org>; Mon, 14 Aug 2017 22:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752634AbdHNWYR (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 18:24:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54263 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752408AbdHNWYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 18:24:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A20F59AA8F;
        Mon, 14 Aug 2017 18:24:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EfoPMyXWzwa/vESOGapBYtWftj8=; b=lqdUyN
        jilzHfR/ut+qt3K+C+gucYExE8F2i9WUtVuWMeriDBnF47UPn1gdTK+diyBZLq0M
        EetV4mlvTfz2JQO4Fv0DOHHy2uwqDSEq3x8jFx5u4/ibXNhMWRnFOqcffaxqVZN8
        z6mciGVA7FGivZ9Ru0AI2SwA+xRtbkm5NQANA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=u2ZDgyE6vs4tOWx8AEw4zvXJ87pv5eT1
        YFDY7HbPnlOe6+c+fK47CzEBuuh6wVlaUjlkF5I6J8+30OKNET+XIvhWfMhjfw3i
        /DN7QkcZcZZwoNyl81xiGst5FhxyVdkwf6ccsweeQZiJ7qbiu94UIKEv4lcxciR6
        aM8tVNtcVGc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9ACF59AA8E;
        Mon, 14 Aug 2017 18:24:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 086199AA88;
        Mon, 14 Aug 2017 18:24:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2] doc: clarify "config --bool" behaviour with empty values
References: <914098af-00a9-fbc8-cdfe-a65918b2951b@gmail.com>
        <20170814221218.18874-1-asheiduk@gmail.com>
Date:   Mon, 14 Aug 2017 15:24:13 -0700
In-Reply-To: <20170814221218.18874-1-asheiduk@gmail.com> (Andreas Heiduk's
        message of "Tue, 15 Aug 2017 00:12:18 +0200")
Message-ID: <xmqqh8x9u6sy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E0D5884-813F-11E7-B269-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Heiduk <asheiduk@gmail.com> writes:

> `git config --bool xxx.yyy` returns `true` for `[xxx]yyy` but
> `false` for `[xxx]yyy=` or `[xxx]yyy=""`.  This is tested in
> t1300-repo-config.sh since 09bc098c2.
>
> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
> ---
>  Documentation/config.txt | 10 +++++-----
>  Documentation/git.txt    |  3 ++-
>  2 files changed, 7 insertions(+), 6 deletions(-)

This looks good to me.  Will queue.



> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index d5c9c4cab..478b9431e 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -216,15 +216,15 @@ boolean::
>         synonyms are accepted for 'true' and 'false'; these are all
>         case-insensitive.
>  
> -       true;; Boolean true can be spelled as `yes`, `on`, `true`,
> -		or `1`.  Also, a variable defined without `= <value>`
> +	true;; Boolean true literals are `yes`, `on`, `true`,
> +		and `1`.  Also, a variable defined without `= <value>`
>  		is taken as true.
>  
> -       false;; Boolean false can be spelled as `no`, `off`,
> -		`false`, or `0`.
> +	false;; Boolean false literals are `no`, `off`, `false`,
> +		`0` and the empty string.
>  +
>  When converting value to the canonical form using `--bool` type
> -specifier; 'git config' will ensure that the output is "true" or
> +specifier, 'git config' will ensure that the output is "true" or
>  "false" (spelled in lowercase).
>  
>  integer::
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 7dd5e0328..6e3a6767e 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -75,7 +75,8 @@ example the following invocations are equivalent:
>  Note that omitting the `=` in `git -c foo.bar ...` is allowed and sets
>  `foo.bar` to the boolean true value (just like `[foo]bar` would in a
>  config file). Including the equals but with an empty value (like `git -c
> -foo.bar= ...`) sets `foo.bar` to the empty string.
> +foo.bar= ...`) sets `foo.bar` to the empty string which ` git config
> +--bool` will convert to `false`.
>  
>  --exec-path[=<path>]::
>  	Path to wherever your core Git programs are installed.
