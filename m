Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD78BC7619A
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 23:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjDLXoa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 19:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjDLXo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 19:44:28 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904C910CF
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 16:44:27 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 26so130166lfq.11
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 16:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681343066; x=1683935066;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2kHJ1nOVOe6xbc/CS7ZPavLmSbEQQ9P+K7R3vsKljlA=;
        b=p3KRr8gV/W/tC/agukA+TfGNtcoAlwuKcYC+kfqT/Foxf5E1Cy/zM5QamQzIBerRvA
         5GHjW+FqYDe0f/KApKA6szs5sGS+1LuA7B/1LuFH0CDtwshubvxpfhxDgy/GhSxqoyIK
         4WfNap7Ar8EGWMga6KUjF6n/T9xuh3K0HRXEngjjV8UjQW4tTD2fFuLEu8RKD3vjd/93
         YZKODtcNcMXsO9TVELqZIXV0LzG4j1lRF/f70xWNBgCQ1qcd1cIC1EvNR/8D8AipLFRb
         rAs60MqigUl+CO9DAWQlrLst4MT94JdG3VakjtMdmUWFjKna5W4DPnH4GCJjzvF+jn+N
         9FSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681343066; x=1683935066;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2kHJ1nOVOe6xbc/CS7ZPavLmSbEQQ9P+K7R3vsKljlA=;
        b=RgdmRP4hGRyKrWbYtVHUKMkijVBJl6iav+BZNb0/XMDFP1k4il0dQ78WhLCkBmrqmI
         P/hGWZWrpluBMDE6x0h4u0qP74JhUB6yCxmvvTxBtxKCKLK9WlQOYTGX8KgPcDumwX0r
         7azGeO93nv7eVFGZEEx+kWwX40gDGnpb8t8BeS4dHDvdfWQTQCuFZqkd4/vrj0ND56ZB
         fr8+Y0qGg5WhFGnWWkD47TbwiraN8HF55vAetAH6xOOmDgsoa/3grGomrZgEEopqbjtp
         SdD/5eiGPtvHukMmHjsSqXmkA1TVdNvIc1y3GOkGw2DXPBWBGk78oKSvvlgOqx7wQOg7
         Blpg==
X-Gm-Message-State: AAQBX9fUUL25RMZnS7AwvT6DwmOUp5CVP3BBe74G/oaFNw3MugTENfZc
        BXVMG+RMQd4K5NkbYwkdzWQ=
X-Google-Smtp-Source: AKy350aRcAnQcFCkD927QbCAHur0aAVlfgXDkUD8i+5jmDbF1SE6aWUnF1vmijR83SGge3U48T1Pdw==
X-Received: by 2002:ac2:5581:0:b0:4ec:a786:1f23 with SMTP id v1-20020ac25581000000b004eca7861f23mr139310lfg.59.1681343065650;
        Wed, 12 Apr 2023 16:44:25 -0700 (PDT)
Received: from [10.8.18.63] ([195.246.120.47])
        by smtp.gmail.com with ESMTPSA id d28-20020ac2545c000000b004a0589786ddsm31625lfn.69.2023.04.12.16.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 16:44:25 -0700 (PDT)
Message-ID: <a8b34639-60fb-8a23-d1d9-1ef4410a2ba4@gmail.com>
Date:   Thu, 13 Apr 2023 01:44:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From:   Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v3] branch, for-each-ref, tag: add option to omit empty
 lines
To:     =?UTF-8?Q?=c3=98ystein_Walle?= <oystwa@gmail.com>,
        gitster@pobox.com
Cc:     git@vger.kernel.org, peff@peff.net, phillip.wood123@gmail.com
References: <xmqqjzyoq35x.fsf@gitster.g>
 <20230407175316.6404-1-oystwa@gmail.com>
Content-Language: en-US
In-Reply-To: <20230407175316.6404-1-oystwa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A couple of drive-by nitpicks about the commit message:

On 07/04/2023 19:53, Øystein Walle wrote:
> Subject: [PATCH v3] branch, for-each-ref, tag: add option to omit empty lines
> 
> If the given format string expands to the empty string a newline is
> still printed it. This makes using the output linewise more tedious. For

It seems that a word is missing in the first sentence. Perhaps,

   s/printed it/printed for it/

?

> example, git update-ref --stdin does not accept empty lines.
> 
> Add options to branch and for-each-ref to not print these empty lines.

"git tag" is mentioned in the subject line, but not here.

> The default behavior remains the same.
> 
> Signed-off-by: Øystein Walle <oystwa@gmail.com>
> ---
> Dang, you're right. But yes, it was a near-identical patch to
> builtin/tag.c. Along with a test, of course.
> 
> I see you already applied the first of these patches so in this
> iteration there's only one.
> 
>   Documentation/git-branch.txt       |  4 ++++
>   Documentation/git-for-each-ref.txt |  4 ++++
>   Documentation/git-tag.txt          |  4 ++++
>   builtin/branch.c                   |  6 +++++-
>   builtin/for-each-ref.c             |  7 +++++--
>   builtin/tag.c                      |  6 +++++-
>   t/t3203-branch-output.sh           | 24 ++++++++++++++++++++++++
>   t/t6300-for-each-ref.sh            |  8 ++++++++
>   t/t7004-tag.sh                     | 16 ++++++++++++++++
>   9 files changed, 75 insertions(+), 4 deletions(-)
> 
