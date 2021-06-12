Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,BODY_SINGLE_WORD,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39580C48BE6
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 01:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1069761184
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 01:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhFLBX6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 21:23:58 -0400
Received: from mail-pj1-f52.google.com ([209.85.216.52]:40782 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhFLBX5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 21:23:57 -0400
Received: by mail-pj1-f52.google.com with SMTP id mp5-20020a17090b1905b029016dd057935fso6792807pjb.5
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 18:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=7zPquDCtZyzOA5PY0kmGl8Aq5WV/QI7GoaYVVezsWQc=;
        b=kPEHsyTGX/JLk5Ya4ShnmZT3mqRZR7TtbCLvP3ptR+TjORicqYN1qaNpcmwMiDdkeV
         xWXuHJTiPRZNovrmJKhQD/3gSqDTA9c8uJjhOhF8OXH1wGgPcMFMEOAjn20NZFsRIntT
         H77sa2Dx01GudkF1IG0AnszdNQgWzEZFpR9tgaffpOiRS45G9iVKCC/bbbahOpDCrLxP
         eMC4t/vDXvt4wRWRV4PRdlxZJKKZj3L3YMXjcmDR+Gz8qEnNIn/KV6nLSeQoUWK3WbVy
         4oO6OCV32/7FVXNKOzOaMyIckpNfbDeX6V5w0bH7x3KIPVICjy5sFPFTt3bCCr/KDvbX
         OfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7zPquDCtZyzOA5PY0kmGl8Aq5WV/QI7GoaYVVezsWQc=;
        b=YkemgL0pnNzRo4IaKldoL8JJt/Q20iJzpenRr6Kiu/eKTEOU3fFKR7xWsxbhGvQGFv
         uBoruLaQ5k1uFxUlf+h+nm09Mag9/AMsFHvhz3O3xkn0z8DYLv9M1gtsID3yLhJBox9D
         ZIzGhuJPisUqJpn89KiG+l+6Sw83xgm4qKDL5bul3NR33UtNQ3weYTlBVw9rIBdAZNy+
         aqBGqB4SlvhZYtKKjZ0hnFCxvIWbpAVHSe8QTDpl0ioOGJJv6DkJZbvYZh48EnPpaMSd
         /9Vkz2n7Ry1hG6oiDyEEzCteqTHEWkZi0bs0N7pSvizccrDF35xE/sUSlKqxWCTJZNzD
         37Jg==
X-Gm-Message-State: AOAM533E/GQ/uN/NM4zZMfTxUW9UAoVmTclT+fORN+79sanb3pHO3mtg
        7CxkRvwSrvUoYhsnrAWXTzMAlAIsPqS3Rw==
X-Google-Smtp-Source: ABdhPJzNZmzlUf1sPAA3whUUAydB+sun791utl6EhMjN6X96L0acv0LsmRmjt+EGQ4ygu6vBjkOK9Q==
X-Received: by 2002:a17:902:b482:b029:114:7531:a52e with SMTP id y2-20020a170902b482b02901147531a52emr6365968plr.70.1623460843893;
        Fri, 11 Jun 2021 18:20:43 -0700 (PDT)
Received: from [192.168.43.80] (subs09b-223-255-225-226.three.co.id. [223.255.225.226])
        by smtp.gmail.com with ESMTPSA id o186sm6161088pfb.59.2021.06.11.18.20.42
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 18:20:43 -0700 (PDT)
Subject: Re: [suggestion] support non-negative float number in git-repack
 --max-pack-size
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Git Users <git@vger.kernel.org>
References: <776cb2f9-5fef-4486-5aef-f3ee62fcda7e@gmail.com>
Message-ID: <c8723ccc-7167-796f-59ed-2cdaadccdc6f@gmail.com>
Date:   Sat, 12 Jun 2021 08:20:41 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <776cb2f9-5fef-4486-5aef-f3ee62fcda7e@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ping
