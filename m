Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68CE41F404
	for <e@80x24.org>; Thu, 23 Aug 2018 20:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbeHXAQB (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 20:16:01 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55834 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbeHXAQB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 20:16:01 -0400
Received: by mail-wm0-f68.google.com with SMTP id f21-v6so6433882wmc.5
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 13:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=q1Qo7V0zi4lbIx5jhLqADUrsKU0TOeHx1r8vcIHNYKQ=;
        b=stCRo+CopWNZTnqT1WgKwR5lnrvcBjHNS3KD6Jf5prda3iGMtERbNuOUX7onwtacxw
         0bvSlQT5yH8fK6w129MoHGnLsFgucfPjw7QoDNRGwBdFZfxbcuR2Uic15gAK+Jx0EWRw
         TL3N9AmD/xIuAe6dD1pDaiY2ZdcpV+WlziSF/YtuikjjMJJFOE32TaIFYh8abcXmL4mm
         AZQXDdjFulPSpoNvMcsgl3Ay7p1qOOaSp+GXviWS/ZlwREReuSNgN7LOElj/eQEkIqQm
         oprMPghtg8UmV4fd/x3iJwT5S+p2SWuamrsP+A67rGOt0XS+jfgZz4Jerb15WVuwRUTk
         E1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=q1Qo7V0zi4lbIx5jhLqADUrsKU0TOeHx1r8vcIHNYKQ=;
        b=AXymqZWARoKX4sz6Pncb9NxToiOlL2vcRSp+QTBlmmEzzJQHVrxgWRI8S2UczRtz/G
         tXj8Ln4TE0KgiocRv743/BoMZzTUazXkD0TSppPEm0FnJ5O4KE1PdFilSxOpEbP0glH5
         gjfTi8gFXclZnH50JzzbNTT9fu1FcgHS1s3bKh/XXF5+ci3Ditht50bjmpLdfFN8baBF
         qiMvpYAgzDcz6EBwWhBVMUTGhY1BygC754x9QxNV2qwrr8w6VROxykJqT3EUb48VXNer
         r70yiViysr+/Qp9S+aDKFLuMcglN41GwxMWRqj+/aBrZqwFeKcpo138172Yl4EkDQuuX
         OrHQ==
X-Gm-Message-State: APzg51B8xeinGJ4SJE18zSS72DHb5AzIzjqp2q52SBaia1e2zIwrOtti
        gUtL+KV7ayi27AU8xH3SUqg=
X-Google-Smtp-Source: ANB0VdY3I83JtJ/UIuFi84IyetWv86cLC0gSCTvJiJZUxHz1S2YAf90DjErRnUG1mTH+gzCkYQaoRg==
X-Received: by 2002:a1c:ca17:: with SMTP id a23-v6mr654809wmg.122.1535057075741;
        Thu, 23 Aug 2018 13:44:35 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m8-v6sm8292462wrf.93.2018.08.23.13.44.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 13:44:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Benoit Lecocq <benoit@openbsd.org>, kn@openbsd.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 5/5] tests: fix and add lint for non-portable grep --file
References: <20180823152502.3886-2-avarab@gmail.com>
        <20180823203604.5564-6-avarab@gmail.com>
Date:   Thu, 23 Aug 2018 13:44:34 -0700
In-Reply-To: <20180823203604.5564-6-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 23 Aug 2018 20:36:04 +0000")
Message-ID: <xmqq6000izil.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> The --file option to grep isn't in POSIX[1], but -f is[1]. Let's check
> for that in the future, and fix the portability regression in
> f237c8b6fe ("commit-graph: implement git-commit-graph write",
> 2018-04-02) that broke e.g. AIX.
>
> 1. http://pubs.opengroup.org/onlinepubs/009695399/utilities/grep.html
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---

Thanks.

>  t/check-non-portable-shell.pl | 1 +
>  t/t5318-commit-graph.sh       | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
> index 75f38298d7..b45bdac688 100755
> --- a/t/check-non-portable-shell.pl
> +++ b/t/check-non-portable-shell.pl
> @@ -43,6 +43,7 @@ sub err {
>  	/\bwc -l.*"\s*=/ and err '`"$(wc -l)"` is not portable (use test_line_count)';
>  	/\bhead\s+-c\b/ and err 'head -c is not portable (use test_copy_bytes BYTES <file >out)';
>  	/(?:\$\(seq|^\s*seq\b)/ and err 'seq is not portable (use test_seq)';
> +	/\bgrep\b.*--file\b/ and err 'grep --file FILE is not portable (use grep -f FILE)';
>  	/\bexport\s+[A-Za-z0-9_]*=/ and err '"export FOO=bar" is not portable (use FOO=bar && export FOO)';
>  	/^\s*([A-Z0-9_]+=(\w+|(["']).*?\3)\s+)+(\w+)/ and exists($func{$4}) and
>  		err '"FOO=bar shell_func" assignment extends beyond "shell_func"';
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 3c1ffad491..0c500f7ca2 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -134,7 +134,7 @@ test_expect_success 'Add one more commit' '
>  	git branch commits/8 &&
>  	ls $objdir/pack | grep idx >existing-idx &&
>  	git repack &&
> -	ls $objdir/pack| grep idx | grep -v --file=existing-idx >new-idx
> +	ls $objdir/pack| grep idx | grep -v -f existing-idx >new-idx
>  '
>  
>  # Current graph structure:
