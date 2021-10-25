Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4595C433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 09:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D5DE60FBF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 09:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbhJYJVu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 05:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhJYJVr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 05:21:47 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3511CC061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 02:19:22 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id c4so10290029pgv.11
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 02:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MZO4zdquil6HWsp1aMcclXRun3fssjXSBXpbEQkdz48=;
        b=oyWJxYVlHiCGrusI4LMqjlBZePA/SGDXwn26rrxLda1UdbX92dVZGsR2QENsfQH9W6
         6QEaAQbkPlxw8Y8lfRGZnufCbZry5ULx7Om5waprgnLFDYbDxMJCxW90/1IiO5Ad+6qX
         7oY9zjdHieCvLMs2IzHTRizOueyeQYrl7H9Bza4NbRoktwWQ0G2s/I5G9gxFwh5HSFcv
         5ZNiXdlilbA1nEgVqJ7bA4gJ6jzlWQ3p2SNrVmDM+yIj4eWy96GZ719gUKR64KZsCIuN
         cqDHo+Rv6aqyzSocnU84a19VSSnziJQEXYCDfL2Z51WI+KF1Xj88GUBuQBGghM7hMZc4
         7PHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MZO4zdquil6HWsp1aMcclXRun3fssjXSBXpbEQkdz48=;
        b=mZsQMWT8zFsYOOzMFJgvBiYD6PsU+Qgw2b2nn+2DkHeo4v+kVJGur2ahoP2q1F0j2j
         9OPhU0kzP7YjjX0h6Rt8WPNz/42yZ6dPp38JTtik2mgBX5yWZ9NAzVnFJfS/FKQiC4O/
         3LXoOQpCa9XVckSzheydTOBSKyJColYOQxm8f4XsFdn60yHLI3ogrTojh59xO7/r0BMN
         E42kJJPUDRWCCS598kOsfa8yFfdKJm8RwbhNMC1A137T/z6eNhzfzFdotDzfN0JqDWqk
         TZ/D1r/6kJnwpz5bRyNpzU+zk7rJyKY9sBb2MWEGepGkeh7tkMsRvLoovRAuRU7hG2bN
         hwJA==
X-Gm-Message-State: AOAM530r+nzJo4orPr3F+pgmj9EN/DGoZmNjCBfu+wwCIy34NG9fxwgQ
        6A/qySCwmR9TjjaKlwAPlhw=
X-Google-Smtp-Source: ABdhPJwedRxXks4QCzMtrGT8/W/Im2LNK8lm120ZDp74US1nIh6NtgD2a//81vPhMWoyGy4C4vZxjA==
X-Received: by 2002:a62:14ca:0:b0:47b:edb2:bfc6 with SMTP id 193-20020a6214ca000000b0047bedb2bfc6mr5927743pfu.5.1635153561990;
        Mon, 25 Oct 2021 02:19:21 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-86.three.co.id. [180.214.233.86])
        by smtp.gmail.com with ESMTPSA id u11sm19376869pfg.2.2021.10.25.02.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 02:19:21 -0700 (PDT)
Message-ID: <481447f9-7222-d9fc-269f-2de50299fb09@gmail.com>
Date:   Mon, 25 Oct 2021 16:19:18 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 0/3] Documentation: change "folder" to "directory"
Content-Language: en-US
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        "Dr . Adam Nielsen" <admin@in-ici.net>,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
References: <cover.1635094161.git.martin.agren@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <cover.1635094161.git.martin.agren@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/10/21 00.09, Martin Ågren wrote:
> It is my understanding that we prefer "directory" over "folder" when
> discussing the file system concept. (Whereas "folder" is commonly used
> for the GUI view of such a directory, or for an IMAP folder.)
> 
> I stumbled on a mention of the ".git folder" when going through the
> doc-diff between v2.33.0 and 9d530dc002 ("The fourteenth batch",
> 2021-10-18), and started looking around. This series is the outcome.
> 
> Based on master.
> 
> Martin Ågren (3):
>    git-multi-pack-index.txt: change "folder" to "directory"
>    gitignore.txt: change "folder" to "directory"
>    gitweb.txt: change "folder" to "directory"
> 

The same logical change over three patches, why aren't they be squashed 
into single commit?

-- 
An old man doll... just what I always wanted! - Clara
