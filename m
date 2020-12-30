Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A7AC433DB
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 14:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C20F221F8
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 14:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgL3ORL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 09:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgL3ORK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 09:17:10 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680E8C061799
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 06:16:30 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id d203so18801050oia.0
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 06:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/hTjYGsceApIE4O1Zzb7At6uLtVsWkl9DbFzE/SJntg=;
        b=azk2taUmISTzkyp9rWJVYkEezOmHJ1cPwm3jPVpYy/5vdqXmzhTeVdijjNgyRpXCY+
         RI6rtODWBK6Rnxls82WauMc7oFaXWJbdHIj3FUNygqCF5sj6afCZuRiOePc2fRqQ591o
         5Hg3A//htiGLHTmQP+ASpGXVgoBGr1zYkpDw+I5RK+klzMB3WiO+NpzVeFh4uYRWZmfA
         RW8KcvtfBMIdeaFEQejRs9f4bh2afGKf9s+sWbpDPhqaBLgve/CvaDn4qKm66MI09kfo
         JGABX+A6Vw5aLmPh5fRbiz4RqA19YfUMAlGk8jsZfWtO0sGBcWtHQOa49xfcJyJpReVd
         dHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/hTjYGsceApIE4O1Zzb7At6uLtVsWkl9DbFzE/SJntg=;
        b=pPMxB3gd9ShJr+gSm/A0lIUFYp6RNdNus+tZxDBG/Km6CrhPtMIHduO07tX99lEWrt
         pqzDNEnlPZgD7QrAqhGKRZ/3c7wIaY0fXGOZNq4mmLZirpJaoe4V9uT/Bme0yYD+05Ma
         hnVbiYRh5cSAZczYsEpiul+iUkR6oM38ZD9nDGveBd8yb6lHk71PV4ki8UGUTympgHPQ
         RWQTYPN90WItZYxFg0qIyxEo7XHLrqkQCPQe4Ijpb9C+hrhxHxGQ2FAn6nBsS9P82upB
         pD8Rb/npH6EWQnJOiSF8QajAUmzSo0awtHhbbP5R5GN3VWgFjIVvV22Vh7peIu7MqzQv
         2LIQ==
X-Gm-Message-State: AOAM530Hc8wbsNXKK3UbahRmwLSz+8Gi8TsuwiJ4rjYXc2e3afFxVv+2
        101VfhG1hK3DUF0AWgm8uKM=
X-Google-Smtp-Source: ABdhPJxWuALRzBwSkb21W/JS7Yl2Rku8ekKxo/tQx6aqx3s4SxnAGVKtbfWby4d8+Mf3OE5RUw7t0w==
X-Received: by 2002:aca:53d2:: with SMTP id h201mr5328541oib.168.1609337789590;
        Wed, 30 Dec 2020 06:16:29 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id q18sm10430718ood.35.2020.12.30.06.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Dec 2020 06:16:28 -0800 (PST)
Subject: Re: [PATCH 03/10] merge-ort: implement unique_path() helper
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.815.git.1608270687.gitgitgadget@gmail.com>
 <6ac555b3c0fe605fbbe6e304482c2e3aef321865.1608270687.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3a07f700-18fc-9f4e-3117-41e534d737b0@gmail.com>
Date:   Wed, 30 Dec 2020 09:16:28 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <6ac555b3c0fe605fbbe6e304482c2e3aef321865.1608270687.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/18/2020 12:51 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Implement unique_path(), based on the one from merge-recursive.c.  It is
> simplified, however, due to: (1) using strmaps, and (2) the fact that
> merge-ort lets the checkout codepath handle possible collisions with the
> working tree means that other code locations don't have to.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-ort.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/merge-ort.c b/merge-ort.c
> index d300a02810e..1adc27a11bc 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -343,11 +343,34 @@ static void path_msg(struct merge_options *opt,
>  	strbuf_addch(sb, '\n');
>  }
>  
> +/* add a string to a strbuf, but converting "/" to "_" */
> +static void add_flattened_path(struct strbuf *out, const char *s)
> +{
> +	size_t i = out->len;
> +	strbuf_addstr(out, s);
> +	for (; i < out->len; i++)
> +		if (out->buf[i] == '/')
> +			out->buf[i] = '_';
> +}
> +

Thank you for pointing out that you based your code on merge-recursive.c.
I see that this implementation is identical to the one there. I question
whether this causes collisions in a problematic way, when "a/b/c" and
"a_b_c" both exist in a tree.

To avoid such a problem, we'd likely need to also expand "_" to "__" or
similar. This might never actually affect any users because of the
strange filename matches _and_ we need to be in a directory/file conflict.

And maybe it's not a hole at all? If it is, we can consider patching or
at least documenting the problem.

Thanks,
-Stolee
