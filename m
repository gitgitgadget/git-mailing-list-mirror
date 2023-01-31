Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B31C636CC
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 12:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjAaMmb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 07:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjAaMm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 07:42:28 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8314DE2E
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 04:42:27 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id bg12so6051911oib.5
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 04:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+skPc/v4ySct9ZmbnNmGFXh7Mk69LmWYKYFN135PDBo=;
        b=KpCckEMlPROe2r4HrXBWGMTCeJDuOeJFpmxXoNBzw/EBIyEim8fNlA9IvuzqsBGiwA
         3QR6U7yN7fVUuGNlS+Ka6Tq2Rr0zTsKiNkFJM8EqM9XeB1wLHB8c8QtB0V8wCJrXG57V
         POWtBO1ETuKRaidbYVKhvHYkrYsxZQ2UvWx/q11Hc6Sck+UTxhwcPS/DkM8yaPtYPnfI
         Ts9PeyPQUuN5LQ8HcjErkh7J/gJbzNPsEe5LnFQ5OxnxkVGrbCDyXDzWcEXJ5QI3uWvS
         tBg3ebC8bppJlTCcFUIcSRq8WvyPa+8mc0g6EM+e/TDp2wbLhB/yvaRIYyPBTgP67blY
         ssNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+skPc/v4ySct9ZmbnNmGFXh7Mk69LmWYKYFN135PDBo=;
        b=RiyT7n4BecyYqRz465CviYcRYnd/0Y2rI4LNh6tQxYUTEQjpv5f3YUqFiI5ALA8/uf
         SxyX7x/wZ8w+hVKU10rTBlO+mA0j1T5mnqALDBuT/I+d8fksxJUiD2TLWTas9fPYeHSz
         6pru+S3V7iuHaqk5gyfVhftpejje2Vx/G0S6mwwaSqIta51mZhRmx67Swf/+I5VrnW3M
         MKl1BH3qcKBLHMDZaVRlndwud8axzgDTZb3Hqcjo62EUiVM15P1DuDOa5j6wLxdW1CzJ
         f76JUPtgp51v/m1Knr7bjT+rOk/t04DFQISrIsRkH/lFDZunJfbEAkzczTgjsTF6cp4e
         BpDA==
X-Gm-Message-State: AO0yUKWdZE7v2NMLQwaTdqWOUx70yUMxQfoVHCJhHqKILOjotdKJjtDR
        Um70jFX99RB8ukGlE1qYLKWQ6U2Z+WVTVhw=
X-Google-Smtp-Source: AK7set/B9Ch77ct65QSJugbXa1RMd46X1dgEPcxZEHma+19AFxV2b7DruOwWL2dltIS0RYmhbI8YzQ==
X-Received: by 2002:a05:6808:494:b0:378:80af:c109 with SMTP id z20-20020a056808049400b0037880afc109mr1202050oid.35.1675168946991;
        Tue, 31 Jan 2023 04:42:26 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:9142:cc1d:32ed:d329? ([2600:1700:e72:80a0:9142:cc1d:32ed:d329])
        by smtp.gmail.com with ESMTPSA id f14-20020a9d6c0e000000b0068bdfa56717sm855299otq.36.2023.01.31.04.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 04:42:26 -0800 (PST)
Message-ID: <c71f1ca3-e7e8-db0e-44aa-90a1c0d7193f@github.com>
Date:   Tue, 31 Jan 2023 07:42:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: What's cooking in git.git (Jan 2023, #07; Mon, 30)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqedrb1uvy.fsf@gitster.g>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqedrb1uvy.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/30/2023 6:10 PM, Junio C Hamano wrote:

> * ds/scalar-ignore-cron-error (2023-01-27) 3 commits
>  - scalar: only warn when background maintenance fails
>  - t921*: test scalar behavior starting maintenance
>  - t: allow 'scalar' in test_must_fail
> 
>  Allow "scalar" to warn but continue when its periodic maintenance
>  feature cannot be enabled.
> 
>  Will merge to 'next'.
>  source: <pull.1473.git.1674849963.gitgitgadget@gmail.com>

I was intending to re-roll, and prepared the --no-src option,
but these three patches are fine on their own, so I'm happy
for them to merge to 'next' and I can do the --no-src on its
own.

Thanks,
-Stolee
