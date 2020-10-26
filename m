Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B02AC4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 10:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 977FB207C4
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 10:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9/1/aqq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770060AbgJZKkP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 06:40:15 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:56047 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1769191AbgJZKjL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 06:39:11 -0400
Received: by mail-wm1-f47.google.com with SMTP id a72so11093286wme.5
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 03:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ihpzf5VlpwbaKkpOO33QReYFqyojPbFRj7f0VkJGlWs=;
        b=G9/1/aqqsmf3mvCQo9iaqiqTeQjppagKjvaCZRt5UGAvAQDZDPuMDFEqXLL/86z8Og
         8doqEluzZfvC0+lKzZgSuHF0FE94Yq8kZw1mAh6fXnbReBron8pxxreCD/HgprsWNknb
         udszcjyRdvsO6e03SCDnYm+RJTb4tNtmJBNknmuXhzncSuNFtpXT9Ax8bji/8rm/rvrx
         fjrGBLHDHvXYSTGgQouPfM41Nm4XUZA51Znq+HPA9OkKm+e/mO1KrGR1rjOVLliPHyMm
         Hafb+IbypKwC96AjEvMMyB8MfAPnTb2J5aqVjfLJAdPP/xfOGsY8zlqNKkfP3VrenBBL
         4YDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ihpzf5VlpwbaKkpOO33QReYFqyojPbFRj7f0VkJGlWs=;
        b=uP6VyuViTlrS5xp7Dju1cfRxJC/J41t3dZVioYYXHYmk4rnS6MpdColzeee3inDiAu
         hhtHp9iCYhmw/Nhps5iQX6nykzFxvdr4ENdpTmxO4rchfevKtNQbLK2tQPeGQdj9nJZU
         bBQjcfl0MkbSOELXJbWARZlUpA9yZMocyWMnkh3/oos9jMEg0W0k1i0PAHVGgX3anZOQ
         /IwyxfKXdkCHj/4biBvU3PM0cf+4Ltd+Dy8MXkw63jW40Ch7LV2TGK+qdQUmVWId14QX
         55Hm0S3fuYTN/rxSZsGrkvGQxNc+/z90aukUPQGbdmqSqo71dczRKhSfHt5RKBcEe7cp
         qWQA==
X-Gm-Message-State: AOAM533GQq+te6S5oaF22Qac+sI5YuY9pLzYdYbn1PJQRnzhjWEhyjQ7
        65+OZqVTSb6S/kCqTmVvPlwGqY/QtXo=
X-Google-Smtp-Source: ABdhPJzvMns7OUN9cgNglmSi9mHz4YvZZKUwTV1VxM1Q1CuqDxLsIXL662BSWC6cphGKInW2nD1Lpg==
X-Received: by 2002:a1c:e2c4:: with SMTP id z187mr14872263wmg.38.1603708749193;
        Mon, 26 Oct 2020 03:39:09 -0700 (PDT)
Received: from [192.168.1.201] (13.45.90.146.dyn.plus.net. [146.90.45.13])
        by smtp.googlemail.com with ESMTPSA id 30sm22665028wrr.35.2020.10.26.03.39.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 03:39:08 -0700 (PDT)
Subject: Re: FR: git diff ignore option
To:     Thomas Wolff <towo@towo.net>, git@vger.kernel.org
References: <394e7906-e26b-8375-6d6b-d235f15d0c2e@towo.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <bc321532-7ce4-1480-1dca-f80f5b794506@gmail.com>
Date:   Mon, 26 Oct 2020 10:39:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <394e7906-e26b-8375-6d6b-d235f15d0c2e@towo.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas

On 24/10/2020 12:00, Thomas Wolff wrote:
> git diff is missing an ignore option, like `diff -I`,

This is being worked on at the moment - see 
https://lore.kernel.org/git/20201020064809.14297-1-michal@isc.org

Best Wishes

Phillip

> which would be 
> especially useful for translation files (.po) to check changed contents 
> and not updated line numbers:
> 
> #: sourcefile.c:/123/
> msgid "id"
> msgstr "*changed text*"
> 
> "changed text" is important to be checked, "123" is distracting
> 
> Kind regards
> Thomas

