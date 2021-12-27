Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7F6C433F5
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 12:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236753AbhL0MwI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 07:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236752AbhL0MwI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 07:52:08 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E94C06173E
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 04:52:07 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id g13so13390519ljj.10
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 04:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:to:content-language:from
         :subject:content-transfer-encoding;
        bh=oyQzG+CU+BAWxFdHR6ZuTQmmNy4j1N11t+5EAb6RluM=;
        b=W1nmFnJZesh6MQSJiX32UbCPI04L93d5g0+2y/8JuJDP3a7lbsOD3lDwGqoy0XbbFk
         WytU70IUY/HAQBQE1dOuAkKdMfDHzGWGqbHxL7SqKotwM+vvs0YpxH1ufOr8VI7K0yeo
         bIlGNF7AtDTaBuh5G9apYBKxH9qgzIkodCtvPxkKk1wIftP87IklDf0KfU8+2ubYVskV
         MZLahIft8vy/U3rPwEB8hj/AaQpyx7JXc2dBOyt9/aND3p+yN6yn0DuRFjbE1FRoLY94
         Bx6SfEg4gqgEZI1ldYs6IPgKp8jIdL4jz9e5y75nARfjNDyRCF73inAa3Zc9h4l2yk40
         rPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to
         :content-language:from:subject:content-transfer-encoding;
        bh=oyQzG+CU+BAWxFdHR6ZuTQmmNy4j1N11t+5EAb6RluM=;
        b=cTMznbsFMtNgR5fn3rtw/fl6qEBdEg5tfPwNduYyzapDfsiSZLpYx8nyFuUsh2NM/p
         8MyrTZepuOsmtbge2IWbekhesgeiU3sM6lhjuKVKKpUz1nQfDXvex4k9txfL2ziZoTea
         DoZWHEEsNXqzExNahrvM++SIpKofj2UxYfEQKCT2Qn+wXI6IXzbJUEg9w2HrDT2raO3y
         uN5oNvS4DL4FK9HIxbJnv9RgQPDyeMYQb7r3JvStTIk9md55WU3GVFJ7xPKRmIMZ3MED
         7EmF/jRMmQ1SZWps4TotPHLtkx4/YZfbq9pXhyzWg0fPYOePIvJ/5CuzEUZZz1O9TjSF
         cfrw==
X-Gm-Message-State: AOAM53032a1yvs34atJM9DGVJ4qiNhLF4Qh0kG0Z1sCnnkiKqeRwp7J9
        C/oHDXVTAwnY9zSIPkwtmB5rfxdOCBU=
X-Google-Smtp-Source: ABdhPJzKC6VaT5qeyRAeVclFGb8q6hQj3m25bIGMK0XgtkSEhv/X+KEUwbopXf8kv6YA5WLWkBglmg==
X-Received: by 2002:a05:651c:d5:: with SMTP id 21mr11236591ljr.433.1640609525844;
        Mon, 27 Dec 2021 04:52:05 -0800 (PST)
Received: from ?IPV6:2a02:2168:8729:6c00:f40:1d1:7c9a:43d6? ([2a02:2168:8729:6c00:f40:1d1:7c9a:43d6])
        by smtp.gmail.com with ESMTPSA id s19sm1623570lji.81.2021.12.27.04.52.04
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Dec 2021 04:52:05 -0800 (PST)
Message-ID: <3e1548ab-5e20-9555-bd10-d6cbf2ffbce4@gmail.com>
Date:   Mon, 27 Dec 2021 15:52:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
To:     git@vger.kernel.org
Content-Language: en-US
From:   Andrey Butirsky <butirsky@gmail.com>
Subject: request: allow passing -X <strategy-option> to git checkout <path> to
 auto-solve merge conflicts
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, stumbling upon this again and again, so decided to write finally,

while in conflicting state, the only thing we can do to auto-pick one or 
another side of conflict is passing --ours/--theirs option to git-checkout:
git checkout --ours/--theirs <path>

The problem is - it doesn't actually do a _merge_, i.e. you lose all 
non-conflicted changes.

There is no easy way to solve that currently without third-party tools.

This link illustrates it:
https://stackoverflow.com/a/68498101/1063363

Proposal:
Shell we add -X <strategy-option> to git checkout <path> to allow it do 
a merge and _actually solve_ merge conflicts?
That would be in-pair with other commands taking the option already: 
git-merge, git-rebase, (etc.?)

