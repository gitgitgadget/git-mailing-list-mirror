Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A471CC4332F
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 10:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9195B60EE7
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 10:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237806AbhIXKUm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 06:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhIXKUj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 06:20:39 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76032C061574
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 03:19:05 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id i24so9910468wrc.9
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 03:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UP2nU1hcwhqiWup1JC1qaMmOUjDR1GgsQY3kLoVowos=;
        b=ApCgpiyoijsywjhF2iKRWBuQSZRPki7DVFfNfHbs7U/IX5vwfMDJGCEeq5ZAfsXQSR
         LGD6RPtaTuMXL206UEYSSm5WpP3Q0dS99nJmHgBfDE2WK3n03yzPp1rD1n6RnUeFbQQB
         AeahxzLGtUbw2IKAxcBNbz7dKGYr0oZNjWFyGTlZ2/e2iopGdZxrLJebpXPTtwmjC9Gs
         W4EIIhqvJzq8qU+mcZZ4hGmPetbP30KoSlb5sWaWc28bsi+08hS3xlU7Fu1ZVFPSXcw7
         8Rudx8aT+6/ESDuOAq5zmsfISMirfLKoASbFrQTYgDvUbw7bF4/2GTZjBRbNIsvoqvnf
         2IFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=UP2nU1hcwhqiWup1JC1qaMmOUjDR1GgsQY3kLoVowos=;
        b=F3VLRygDwGm/Uri2aRUrMsB30AcpeHyTDpzGJJqqOQnuKnMMu8hXY92egZWQ0BUB4f
         UR1FCwxiFofoihGpZAfkE66+oh+Upmx8WZooH01te1MaUiEUKFEzq5CZNuwjWGNs1fnu
         smSmyNRwZaP4j36me0nL0MTvIK3r48hoc80PZF2Izv6IbOH3rAINY4s9IoiFVz+0wNxo
         hpgH+9w0byYK2nhelsQh4ZNHGTbtwn58+WzYDDgTE+FlCNy6KyJjb8it1ZqxYamWqKjA
         eQTj7q+eP/MR6owyfyOX+WWGqmatNJJQfmsfYGb0NotVEYVkPWmAPuPtj6fTycZMOV74
         3wBA==
X-Gm-Message-State: AOAM532ZbYCwbz57iU67lzMIy0Yy0Yn7UmV7lY/oWyb+/tmHNzOqonvp
        r+hCfXkyMvVoiK7bDc9PE1k=
X-Google-Smtp-Source: ABdhPJz2lZCHszxDL/XeZ6mQzf8+zMEC9B9MhViz8HQohhNQNprkDnRYQzMIaZWAr1TPfRIZDgctpg==
X-Received: by 2002:a7b:cc96:: with SMTP id p22mr1189228wma.83.1632478743525;
        Fri, 24 Sep 2021 03:19:03 -0700 (PDT)
Received: from [192.168.1.201] (178.2.7.51.dyn.plus.net. [51.7.2.178])
        by smtp.googlemail.com with ESMTPSA id j19sm7676058wra.92.2021.09.24.03.19.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 03:19:03 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 8/8] hook-list.h: add a generated list of hooks, like
 config-list.h
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com>
 <patch-8.8-80aae4d5c13-20210923T095326Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <92471ff9-7573-c3e4-e9fd-63a5cbf5738f@gmail.com>
Date:   Fri, 24 Sep 2021 11:19:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <patch-8.8-80aae4d5c13-20210923T095326Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar
On 23/09/2021 11:30, Ævar Arnfjörð Bjarmason wrote:
> diff --git a/generate-hooklist.sh b/generate-hooklist.sh
> new file mode 100755
> index 00000000000..6d4e56d1a31
> --- /dev/null
> +++ b/generate-hooklist.sh
> @@ -0,0 +1,18 @@
> +#!/bin/sh
> +#
> +# Usage: ./generate-hooklist.sh >hook-list.h
> +
> +cat <<EOF
> +/* Automatically generated by generate-hooklist.sh */
> +
> +static const char *hook_name_list[] = {
> +EOF
> +
> +sed -n -e '/^~~~~*$/ {x; s/^.*$/	"&",/; p;}; x' \

POSIX does not support using a semicolon after a closing brace [1], 
grepping our code base with
	git grep 'sed .*};' '*.sh'
does not give any matches so I don't think we're using that pattern any 
where else. Replacing the semicolon with ' -e' would fix it.

Best Wishes

Phillip

[1] "Editing commands other that {...}, a, b, c, i, r, t, w, : and # can 
be followed by a <semicolon>" from 
https://pubs.opengroup.org/onlinepubs/9699919799/utilities/sed.html
