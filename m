Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C07C433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 05:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9D6E60FED
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 05:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbhIMFgA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 01:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhIMFgA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 01:36:00 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D181C061574
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 22:34:45 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id bb10so5058180plb.2
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 22:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C4c2XkU2O4WS1+MFV7RgLNHOOQOQk37iuCVfvaab3WM=;
        b=HejxL8sUL/q4k+k8eIZyYwOjVfE1Mm6YZ7EHbipzM+BjS11dNuehWoXEFzYzJz/3XQ
         axHfT6brSi06uKjNKsfPOCZwcHBKcfCISJuwS53z/xkb10DG+wUp1LdL3wJMJzxTBalC
         G59la/VM54csgoTB1LH3BHeWH2Dj3urEHryfbKFWQ5nqhw8JNTla+i6t9MDyIsh3vFXK
         VmVD7NG2fdsTWj82zhNfEGmGJVejSoRgltp1Y9mPp7R/t6i5exyGwVyohVZDpO88UNlo
         rPN/nfU+N0DQ4qn/RpKzy8VSCj+uWpi73kpyX0b6Q5wI/Raq49TJYjD4MpqCQ9gsai65
         nv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C4c2XkU2O4WS1+MFV7RgLNHOOQOQk37iuCVfvaab3WM=;
        b=Q4zp9XT/VBbbdUqeoBJjFk07M2KUuqf81HELvjiF+Yq+rl4JU4WHnjBawrbZr75Ad/
         Bd3ksHqQr5N+bamJ+hebD97ALp/3B6OAgnDC0vIghKjJivQvB+Q+9eAff8fu6s3oMOSK
         sxI++sBahOhYHlXnFLcyhxmDIAXBIoWRmADhOyqYW+tif0b0RKIHw79858lGhgXsc5ba
         bt4Ss1u5/aiA12sub9W4r4pX3sAVx1rsqfGuc/rnnATmJ1IUoNj73kcGXEjzrQO/2u5d
         Io6lG5IBFMifX1z4yW05MfXbShRvio1sh5TLSXaxT2jbVYupTHqf5D/gSxbmDVfF1e/P
         MFDw==
X-Gm-Message-State: AOAM530MS1G/2TsqJThpxR4UDBA62bQ+mkiIV7KxsIe3Vt+6dlBA2ZNt
        dhjADCwEKjRXeYC9RVtB/LNUs55c7LdFBw==
X-Google-Smtp-Source: ABdhPJwj2Z7efPSvhV9WhEcpZGIXNB3sR6JmTzfhQuDb8qn5IlSUrWV4ROw5pkzTscffWH59sWqERA==
X-Received: by 2002:a17:902:e749:b0:13a:148d:2d32 with SMTP id p9-20020a170902e74900b0013a148d2d32mr8951104plf.51.1631511284884;
        Sun, 12 Sep 2021 22:34:44 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-56.three.co.id. [116.206.12.56])
        by smtp.gmail.com with ESMTPSA id b10sm5422355pfl.220.2021.09.12.22.34.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Sep 2021 22:34:44 -0700 (PDT)
Subject: Re: [PATCH 1/3] t0301: fixes for windows compatibility
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     lehmacdj@gmail.com
References: <20210912202830.25720-1-carenas@gmail.com>
 <20210912202830.25720-2-carenas@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <0606160d-1192-2074-b1ad-9c5d86c953d5@gmail.com>
Date:   Mon, 13 Sep 2021 12:34:41 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210912202830.25720-2-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/09/21 03.28, Carlo Marcelo Arenas Belón wrote:
> test -S is not able to detect that a file is a socket, so use
> test -f instead.
> 

Isn't test -f just check for socket as regular file?

-- 
An old man doll... just what I always wanted! - Clara
