Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB85C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 15:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 646EE61038
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 15:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhJ1PIm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 11:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbhJ1PId (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 11:08:33 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3709CC0613B9
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 08:06:06 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id c9so3909698qvm.5
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 08:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=I8DmEfYpp/Y5FEloZ+9R8rK95Kd/A+3nMUMg4iRKlb8=;
        b=MiJO+aiy8eCIjGWRn7sN2I6EFxF0BYNBr4C2otsEV0yP6zJG8VQFTbMGfOKXrgEgIY
         QPDhB4LC064D4RajmKhDJEglm+NTreKrBQiZdsqVxaDLZcXazS9KuM7LYR+M+ysi5U9x
         CaTH9PWRFyNkQDPl1VG5ot88Vgjvr6z0RQt3qfrhtq13oOKNWxyvbhrQrvKvkHGgZ+dh
         1zG/FLuVNFi02AdA4q3bQDDY+7BMcHFv5IWoXrl9wMe6rDdi3y4cayJ9tjkqDS9SWzhH
         yVdxxRMTLdLm5KFsDcLpUwOjNZtU8ooZ1DHR8zb+6g/fPRe3MCSbwKaefOjSD7l5XJ4o
         /LQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=I8DmEfYpp/Y5FEloZ+9R8rK95Kd/A+3nMUMg4iRKlb8=;
        b=qO4d3NPn+V2O2G+poTsAIGdj+KqP6PQGuQQZvqXyUd27HWPOIU8aslddOqn2VWAVJx
         EaLYgP4waQV9i80ACIsLg65IZyp7RXO2xzXodTkdpbxebqustty9Cj7gWa2/6hUniGTF
         uWEYLj+/Lc8MKXTonx2BfQro62wuZVdksMVWb9qYOC+yqVO/NW4S3kQ05Z2l0vO8OnQH
         KnOHso5e3v9UnYEzPjuzY5fuLakL/lzfWCd8XKSFqZO4JcHT09LGk6lu1O5EYdxfZAbT
         d/yv3me8cmh7uhJiZEFHb2GhMxf3wpI+VlGJp7/tDbV7nJ11WT+78fAe4pBxETDchhiG
         wYiQ==
X-Gm-Message-State: AOAM531OCGyjkMtdkjHDME64kksM14hhtzHjYDkrG96CBMd5J74DIMDt
        zt1VY6bXfmJy4sZ9RqNGHMM=
X-Google-Smtp-Source: ABdhPJymKt9MGDSb6voFBsLkYKMFO14ISyp/UiDRy+3nd7+OO1yvYkET89NvpKlkUIi5bx0otU6p0A==
X-Received: by 2002:a05:6214:19cf:: with SMTP id j15mr5028983qvc.40.1635433565247;
        Thu, 28 Oct 2021 08:06:05 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:c8e5:4cc4:ea23:1551? ([2600:1700:e72:80a0:c8e5:4cc4:ea23:1551])
        by smtp.gmail.com with ESMTPSA id f21sm2298658qtk.51.2021.10.28.08.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 08:06:04 -0700 (PDT)
Message-ID: <adb3e031-fe82-37ce-0967-a28aecb07035@gmail.com>
Date:   Thu, 28 Oct 2021 11:06:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v3] add, rm, mv: fix bug that prevents the update of
 non-sparse dirs
Content-Language: en-US
To:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, vdye@github.com,
        derrickstolee@github.com,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Sean Christopherson <seanjc@google.com>, l.s.r@web.de
References: <5e99c039db0b9644fb21f2ea72a464c67a74ff64.1635191000.git.matheus.bernardino@usp.br>
 <b203cc8866b1a8d8397554aa17f918878b8c1133.1635430822.git.matheus.bernardino@usp.br>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <b203cc8866b1a8d8397554aa17f918878b8c1133.1635430822.git.matheus.bernardino@usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/28/2021 10:21 AM, Matheus Tavares wrote:

> Since v2:
> - Added comment about executing only one iteration on cone mode.
> - Split for loop line for better readability.
> - Stopped loop through "path" at first element to avoid an undefined
>   behavior.

Thank you for these changes. I'm happy with this version.

-Stolee
