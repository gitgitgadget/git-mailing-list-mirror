Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF13C56202
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 11:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91223206B7
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 11:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVUMoUp6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388949AbgKZLRU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 06:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388847AbgKZLRU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Nov 2020 06:17:20 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21931C0613D4
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 03:17:20 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id y24so1590672otk.3
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 03:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HTMKwVnPUXloQK40X7vb86mutMb+BHHJ1RYrU18RS5c=;
        b=IVUMoUp682sTskRK2t7BdaG5KWGy8bwD4OMG6ApK3OvEPSv6LG0RDA1KHxzjeEidZL
         3gWNY9+yEWm2FF/vdQ2rzf2h84ZW55unXWx+Kpb1bUy5aKJDSbLVAz0Ar91JbBOXPKMK
         PGN9WHZV0KyQRRoavBgtRFG9fNgt8D9rFY7QfIq5tMJDH9eTIrq3QTYx0CAk6x5dYmLu
         8DUstvp6YQpFtUUP0OY+N2zPetkwtf2y3FmNhHjqF7G5XLBqkLkVsHjItAFOdtyA02r8
         0FPhK/ZXB/i3jqT7wlAJFRKwH33xJ2eCM1kFms+O+atGEgzoguaIFqIHGHJ6WXq00dGQ
         jVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HTMKwVnPUXloQK40X7vb86mutMb+BHHJ1RYrU18RS5c=;
        b=hgeG7RAePOkYQmam9oatIJUSxgUAZedAoWdEUStyE6GBA19/J5Stt45t1qc6zA4Og8
         uHTghG+CMIHYh6YpP+LSY4LQpwGbp0sSd8ufjgezOSDa3RY8XgeUvSTOej3af/uJ/+EL
         dq3LBMRXcIDDVQEHAmKqX63QFFPQ09ltSSPer64tRuI/dCbD0yBRPv6MOXAz7tUqGet4
         Akji73Uf4Z+70FlWvDFth2fSYazIZ+oFe1J+rlKRFkaB83B2gBi11LRWztz7/9Tl9lF5
         n+c66vGOvHe8lMDxf/Z40CJOT0Hx5ac693MyIZsYyT+CNE9GY4ThQ/SusyYUTqT4F7kh
         r0mg==
X-Gm-Message-State: AOAM532n+CrwLIMXXgpZaIijXakw96XLjHeW1qlcCOnTa24lADD3jIvt
        nVo+7Wv0TkA2izG8u2Qy4V8=
X-Google-Smtp-Source: ABdhPJw2qEu78CPX8JvVkIxYw1Xvgv+SXsQh8ZvHidogBMe2xS4kQ6DRBn4A6ijYB3j2ZUtzJ4oO7w==
X-Received: by 2002:a05:6830:4d1:: with SMTP id s17mr1987087otd.5.1606389439346;
        Thu, 26 Nov 2020 03:17:19 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id z14sm3196343ooz.4.2020.11.26.03.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 03:17:18 -0800 (PST)
Subject: Re: [PATCH v3 0/8] config: add --fixed-value option
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
 <pull.796.v3.git.1606342376.gitgitgadget@gmail.com>
 <xmqq7dq9ca94.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <94cabd0e-004c-f3fc-315f-f984abce51e6@gmail.com>
Date:   Thu, 26 Nov 2020 06:17:17 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <xmqq7dq9ca94.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/25/2020 6:00 PM, Junio C Hamano wrote:

> Thanks.  The only thing that still stand out, after the first 7
> patches (queued as its own "add --fixed-value option to config"
> topic) are queued, is that the early part of the documentation,
> namely, a paragraph where it mentions value-pattern, still lives
> in the world where it can only be a regexp.
> 
> Perhaps insert the following between step 7 and 8?

This patch LGTM. Thanks!

-Stolee
 
> --- >8 ------ >8 ------ >8 ------ >8 ------ >8 ------ >8 ---
> Subject: config doc: value-pattern is not necessarily a regexp
> 
> The introductory part of the "git config --help" mentions the
> optional value-pattern argument, but give no hint that it can be
> something other than a regular expression (worse, it just says
> "POSIX regexp", which usually means BRE but the regexp the command
> takes is ERE).  Also, it needs to be documented that the '!' prefix
> to negate the match, which is only mentioned in this part of the
> document, works only with regexp and not with the --fixed-value.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-config.txt | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git c/Documentation/git-config.txt w/Documentation/git-config.txt
> index 09a1d273a9..0e9351d3cb 100644
> --- c/Documentation/git-config.txt
> +++ w/Documentation/git-config.txt
> @@ -33,10 +33,13 @@ escaped.
>  
>  Multiple lines can be added to an option by using the `--add` option.
>  If you want to update or unset an option which can occur on multiple
> -lines, a POSIX regexp `value-pattern` needs to be given.  Only the
> -existing values that match the regexp are updated or unset.  If
> -you want to handle the lines that do *not* match the regex, just
> -prepend a single exclamation mark in front (see also <<EXAMPLES>>).
> +lines, a `value-pattern` (which is an extended regular expression,
> +unless the `--fixed-value` option is given) needs to be given.  Only the
> +existing values that match the pattern are updated or unset.  If
> +you want to handle the lines that do *not* match the pattern, just
> +prepend a single exclamation mark in front (see also <<EXAMPLES>>),
> +but note that this only works when the `--fixed-value` option is not
> +in use.
>  
>  The `--type=<type>` option instructs 'git config' to ensure that incoming and
>  outgoing values are canonicalize-able under the given <type>.  If no
> 

