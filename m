Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BD1C433B4
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 08:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11F45610CC
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 08:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhDRIVg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Apr 2021 04:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhDRIVf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Apr 2021 04:21:35 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0833C06174A
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 01:21:07 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id w23so32475435ejb.9
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 01:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C7CIM+stjwgsORbpKt3BNIJRuW806VGqRIutXK3tkkI=;
        b=ZjRLCb7DWXKM9hugjUQtCA/r2q9Dj9InlWO2G1vFEPwIej4uteequnaJ0jN6cklCIP
         2VQIfSlyQ/tjPD4O8CSZn25USpJi59OTtWB1NPxbOWWA9HbdCzuau+VZvlmbzuvv4mVr
         kpr3et7KJJFa+C9+4i2TQ1QxxRiSleGp7Rkia4VKzWPiKVniTQY0x3cjRLr57T00d1dM
         +wcaCvo6uE81d/6tB4jb/GNW0pVhdXR0/VDWAMfP8Z8ex5hhAXzCTCfMPphQO9SwqF3Z
         3wHq2WLPfbPfQYYVMN846LGt2M1tKvQQqEtikxoNpqq1xKIy3MvKa8nkpnsCsol/viK/
         EPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C7CIM+stjwgsORbpKt3BNIJRuW806VGqRIutXK3tkkI=;
        b=UrMryJhYfoxU/swdwOQjk4CXu6U7qx6nMzItY81j370TQCByGPOsernrrvEyn+HlXG
         sy26MkqdnhpZiv+kF7dB7rj4LTcjlyMlLqwKV40F/2yVPki9XwDnsEIywZLnMChLg9/p
         DXJY2l8mE6rb7wyKdOel0h0OoyOTF0SBalgMPg6rz8JMw0ecOpuaAI288XK9TG6ULqxS
         rpEjyKrd9wZpk7jQ8O9/7VISbaY8QVlB0InATJhX8l4t2EPaEGD8C200pD12KzhAo7Wf
         nEcoQLrFIKchJwKXqA2UBxO8exyGFi6gde7t+YR8XTPVV7HC4qySD3/Udh1cxQWfAnY9
         Cwpg==
X-Gm-Message-State: AOAM533nN5rigc31cS91TVLVWCcWlQ5kjQom6+AJSso6I6EIwkHIi4tv
        4Q5oWLbrjkrfJdgeYv/xG7nrow2sfD4=
X-Google-Smtp-Source: ABdhPJxjGzh0x3S81YCk3xGoEE4Wqno553mfjUOILGZIa1ekrdUC17cRqqk8F2JlmODv7lEW+2drfg==
X-Received: by 2002:a17:906:4b59:: with SMTP id j25mr16166344ejv.313.1618734066568;
        Sun, 18 Apr 2021 01:21:06 -0700 (PDT)
Received: from szeder.dev (78-131-14-48.pool.digikabel.hu. [78.131.14.48])
        by smtp.gmail.com with ESMTPSA id nc39sm7469507ejc.41.2021.04.18.01.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 01:21:06 -0700 (PDT)
Date:   Sun, 18 Apr 2021 10:21:04 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG?] 'git describe seen'?
Message-ID: <20210418082104.GT2947267@szeder.dev>
References: <xmqq1rb8bhl4.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1rb8bhl4.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 17, 2021 at 04:45:59PM -0700, Junio C Hamano wrote:
> This does not seem a new problem at all, as v2.10.0 thru more recent
> versions of "git describe" seem to give me the same answer.
> 
> Anyway, I am seeing a curious symptom.
> 
> $ git rev-list --count v2.31.0..seen
> 716
> $ git rev-list --count v2.31.1..seen
> 687
> 
> The above means that 'seen' is closer to v2.31.1 than v2.31.0; there
> are fewer commits that are not in v2.31.1 that are in 'seen', than
> commits that are not in v2.31.0 that are in 'seen'.  
> 
> That is naturally expected.
> 
> $ git rev-list --count v2.31.0..v2.31.1
> 29
> 
> And that difference of 29 matches the difference, which is 716 - 687.
> 
> But here is what is puzzling.
> 
> $ git describe seen
> v2.31.0-716-g7b65b53281
> 
> $ git rev-list --first-parent master..seen |
>   while read v
>   do
> 	d=$(git describe $v)
> 	echo $v $d
> 	case "$d" in v2.31.1-*) break ;; esac
>   done
> 7b65b53281ae06ee25dd47dead4062125eb54427 v2.31.0-716-g7b65b53281
> eec14f0fec886c909a29d63a94537df5a62be618 v2.31.0-714-geec14f0fec
> ...
> 103835562c64abef2319995716230f92092f87af v2.31.0-569-g103835562c
> d4324831d9152b16e091646e22a6e03423a59c93 v2.31.1-516-gd4324831d9
> 
> Is there something tricky about the topic merged at 10383556 (Merge
> branch 'jh/rfc-builtin-fsmonitor' into seen, 2021-04-17) to confuse
> the counting done in "git describe"?

Subsequent merges with identical timestamps can easily confuse 'git
describe', I wonder whether this is another symptom of the issue
reported at:

  https://public-inbox.org/git/20191008123156.GG11529@szeder.dev/

