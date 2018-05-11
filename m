Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ACD71F406
	for <e@80x24.org>; Fri, 11 May 2018 12:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751610AbeEKMat (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 08:30:49 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:43275 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750777AbeEKMas (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 08:30:48 -0400
Received: by mail-qk0-f194.google.com with SMTP id h19-v6so4161130qkj.10
        for <git@vger.kernel.org>; Fri, 11 May 2018 05:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=a70G5EU4LPRbehzyvDQQRTbFRuuPkpHL1TvE4puAass=;
        b=gzQc3EjRdzoWZEizZHkazefTj/hQAgmq+475iXb1AGaMbqQQ+H+tg+qlLII/G9EYkH
         6GLJj7LlsGsdFIz+cRtfWijhEUMMQ5DGgXVYtHx7i2JUL2jI1Ci3kDKafUNA13yvq5KM
         2V+HdrNS2gGxIUgu6iYPATUxTgnbFMNTNWQphAOfqRyKBLDSJgoI3CRsVe9xs6rGg8EX
         2zvYuRu1EXTiTAfQq+jzWvtkHkiq718LRasGVAK8cm3lBagV9nbgan/Q6jguKX23Sfj5
         ijtHaV7YdWOiXBxfjO5rYdHqv81dIzKpGeEJG7uGm4mq+xMUnS6elTRZ98tVC3T5Qd47
         Bzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=a70G5EU4LPRbehzyvDQQRTbFRuuPkpHL1TvE4puAass=;
        b=bW+fs8mrqJwwJSjtYtyicpQJn6B3J702qxO64zFCw7So9uVSJz3WNdb6JCIsr9ZU//
         yc83UewMFg39Jh70Q9dRcWoSw582GDR2zbczmR4IIeEwcyJmZzPOjHCElHs4AGkFoNz/
         vd5Z/m/hO32uddRYqXy82/kH07pToK+eH+5v5AzFO4mqWTIMlXYRdO1uzvrr5C+PERdZ
         +tMnYAeXnLQPbT4Dh+xP0ULRiQtjXvfkozpM8MCGUU9GVdxE5XMbDOvz4uizJNZa15d0
         +uAx0W+ic7WBCtKjiligFcQBxZgmGj46OZwLGKG7M9G9ZqS2ME/82r0GI3xfFJHpWFN+
         meJA==
X-Gm-Message-State: ALKqPweLYlPgk4nJ6BSBJ6Cb/6PuitwauQ8tn1PTK0u2l+TBAHdkANP+
        kE6Fr3/X45qdLIFhvOTv7VY=
X-Google-Smtp-Source: AB8JxZqhRVBvPRLe12HYEJb+fY5jZa91xvvGqx7HdODzu2TbHXXoYdr9bzB1oC+YMNmeGyr6wdOA8Q==
X-Received: by 2002:ae9:d611:: with SMTP id r17-v6mr4744982qkk.65.1526041847091;
        Fri, 11 May 2018 05:30:47 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id h73-v6sm1559866qke.88.2018.05.11.05.30.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 May 2018 05:30:46 -0700 (PDT)
Subject: Re: [PATCH 00/12] Integrate commit-graph into fsck, gc, and fetch
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>
References: <20180510204557.16361-1-martin.agren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <cf443352-7840-9ff9-77af-cb4c52932fcb@gmail.com>
Date:   Fri, 11 May 2018 08:30:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180510204557.16361-1-martin.agren@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/10/2018 4:45 PM, Martin Ågren wrote:
> On 10 May 2018 at 21:22, Stefan Beller <sbeller@google.com> wrote:
>> On Thu, May 10, 2018 at 12:05 PM, Martin Ågren <martin.agren@gmail.com> wrote:
>>> I hope to find time to do some more hands-on testing of this to see that
>>> errors actually do get caught.
>> Packfiles and loose objects are primary data, which means that those
>> need a more advanced way to diagnose and repair them, so I would imagine
>> the commit graph fsck is closer to bitmaps fsck, which I would have suspected
>> to be found in t5310, but a quick read doesn't reveal many tests that are
>> checking for integrity. So I guess the test coverage here is ok, (although we
>> should always ask for more)
> Since I'm wrapping up for today, I'm posting some simple tests that I
> assembled. The last of these showcases one or two problems with the
> current error-reporting. Depending on the error, there can be *lots* of
> errors reported and there are no new-lines, so the result on stdout can
> be a wall of not-very-legible text.
>
> Some of these might not make sense. I just started going through the
> documentation on the format, causing some sort of corruption in each
> field. Maybe this can be helpful somehow.
>
> Martin
>
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 82f95eb11f..a7e48db2de 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -255,4 +255,49 @@ test_expect_success 'git fsck (checks commit-graph)' '
>   	git fsck
>   '
>   
> +# usage: corrupt_data <file> <pos> [<data>]
> +corrupt_data() {
> +	file=$1
> +	pos=$2
> +	data="${3:-\0}"
> +	printf "$data" | dd of="$file" bs=1 seek="$pos" conv=notrunc
> +}
> +
> +test_expect_success 'detect bad signature' '
> +	cd "$TRASH_DIRECTORY/full" &&
> +	cp $objdir/info/commit-graph commit-graph-backup &&
> +	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
> +	corrupt_data $objdir/info/commit-graph 0 "\0" &&
> +	test_must_fail git commit-graph verify 2>err &&
> +	grep "graph signature" err
> +'
> +
> +test_expect_success 'detect bad version number' '
> +	cd "$TRASH_DIRECTORY/full" &&
> +	cp $objdir/info/commit-graph commit-graph-backup &&
> +	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
> +	corrupt_data $objdir/info/commit-graph 4 "\02" &&
> +	test_must_fail git commit-graph verify 2>err &&
> +	grep "graph version" err
> +'
> +
> +test_expect_success 'detect bad hash version' '
> +	cd "$TRASH_DIRECTORY/full" &&
> +	cp $objdir/info/commit-graph commit-graph-backup &&
> +	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
> +	corrupt_data $objdir/info/commit-graph 5 "\02" &&
> +	test_must_fail git commit-graph verify 2>err &&
> +	grep "hash version" err
> +'
> +
> +test_expect_success 'detect too small chunk-count' '
> +	cd "$TRASH_DIRECTORY/full" &&
> +	cp $objdir/info/commit-graph commit-graph-backup &&
> +	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
> +	corrupt_data $objdir/info/commit-graph 6 "\01" &&
> +	test_must_fail git commit-graph verify 2>err &&
> +	cat err
> +'
> +
> +
>   test_done


Martin: thank you so much for these test examples, and for running them 
to find out about the newline issue. This is really helpful.
