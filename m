Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC270C433FE
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 19:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237481AbiCITTy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 14:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238273AbiCITS0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 14:18:26 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DD81451DF
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 11:17:05 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id t8-20020a0568301e2800b005b235a56f2dso2454329otr.9
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 11:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=F72gHTTrIXY3RXHWjcLrx0RnKcCiHg5egStKddIWYNc=;
        b=LJbG5Ry1447S1lDuRG708x3XJePnqzSTncA8rEYR62A7LMywh01De4fo6xexf+YaQ8
         dsU9UQ0JTguZIiYTHKR2V8cHJGGiDA64AZ0ij0qNrvF31NErzoVJb4M9DXCv3EwjgScY
         VvM1t/egKnAmjLuSxAPoMRQTBp2KaORFnHLAdlLjaSgdr+UxIS/3aiP42ehIrd2zRcKu
         +2INyuuR0z4Nt5C2rRmh0tZQyYkMf1CswKWceRaeu0ZJvrDjIG1HNY0gAAI9uKlXOVS2
         w2xsw/YXjcC2TCc29dLu63KK6LFxmll80MQcrWtPm7jwXmNSPDzds2D1+Kj75U/B9CUQ
         D2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=F72gHTTrIXY3RXHWjcLrx0RnKcCiHg5egStKddIWYNc=;
        b=ziH5VZROog77FrNC0vDGvQepq1fkQiytUT8qw/jlNKG1LinNaHqI88Wr16hAZWau5e
         twgyVCR0oNh/ThTLiYIujguAoQ9g4Wt1FGhAkIzT2YV+v1H0UMf52SF9NN8Zv1vTd3W/
         83R9wchV5oXcn7Z8IEFJpg8OFE24aCCCT3+5CrvjpoQ+2c0GCt1uJyk3RdgvHvBtapmQ
         1F8m3AZQTeBwTk+s6kMKpzn4kvgDgudblbBEbwnbMLysCDgUlrm1FIRsa3Z6EEUS8ooo
         jOaOq/K2XcM9ETvvGIckIWzXD36DDyLCh9TQ6VBqKj3mrUiT31DJLc5JRwKJ3+h3U8Fl
         jJ5A==
X-Gm-Message-State: AOAM531iW4aCvFvdJrsDlFPCGK8rIsYwo+Ic0w71w7f/Wnd51n5PudbL
        PQMi8iU78XtJ1LAPA221XI2a
X-Google-Smtp-Source: ABdhPJyesM5i6F88pkX/qPBXcPSSOM9b50WBbI5Z5u3aEXZHEEME4cv+gm0JYuc6x0ZGQjp2zgsTEg==
X-Received: by 2002:a05:6830:3111:b0:5af:e372:53fc with SMTP id b17-20020a056830311100b005afe37253fcmr686675ots.29.1646853424194;
        Wed, 09 Mar 2022 11:17:04 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id ed22-20020a056870b79600b000da32eab691sm1294962oab.23.2022.03.09.11.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 11:17:03 -0800 (PST)
Message-ID: <bed6917e-105e-e19f-2fd9-201507fc8a26@github.com>
Date:   Wed, 9 Mar 2022 14:17:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 16/24] revisions API: have release_revisions() release
 "mailmap"
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
 <patch-16.24-1a988c96371-20220309T123321Z-avarab@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <patch-16.24-1a988c96371-20220309T123321Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/9/2022 8:16 AM, Ævar Arnfjörð Bjarmason wrote:

> @@ -1097,7 +1097,7 @@ static const char *find_author_by_nickname(const char *name)
>  	struct rev_info revs;
>  	struct commit *commit;
>  	struct strbuf buf = STRBUF_INIT;
> -	struct string_list mailmap = STRING_LIST_INIT_NODUP;
> +	struct string_list *mailmap = xmalloc(sizeof(struct string_list));
>  	const char *av[20];
>  	int ac = 0;
>  
> @@ -1108,7 +1108,8 @@ static const char *find_author_by_nickname(const char *name)
>  	av[++ac] = buf.buf;
>  	av[++ac] = NULL;
>  	setup_revisions(ac, av, &revs, NULL);
> -	revs.mailmap = &mailmap;
> +	string_list_init_nodup(mailmap);
> +	revs.mailmap = mailmap;
>  	read_mailmap(revs.mailmap);
>  
>  	if (prepare_revision_walk(&revs))
> @@ -1119,7 +1120,6 @@ static const char *find_author_by_nickname(const char *name)
>  		ctx.date_mode.type = DATE_NORMAL;
>  		strbuf_release(&buf);
>  		format_commit_message(commit, "%aN <%aE>", &buf, &ctx);
> -		clear_mailmap(&mailmap);

It seems like you can completely remove the 'mailmap' variable and
instead malloc and init revs.mailmap directly.

Thanks,
-Stolee
