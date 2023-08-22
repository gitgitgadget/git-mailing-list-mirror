Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2828EE4993
	for <git@archiver.kernel.org>; Tue, 22 Aug 2023 19:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjHVTjO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Aug 2023 15:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjHVTjM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2023 15:39:12 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A1DCD2
        for <git@vger.kernel.org>; Tue, 22 Aug 2023 12:39:11 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-58dce1f42d6so80880517b3.0
        for <git@vger.kernel.org>; Tue, 22 Aug 2023 12:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1692733150; x=1693337950;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yIHWFB90GjbvEl5GFqHNvMT7C+BXCqNsOTq1W9bL3ts=;
        b=hRzVkW7IDNU+jMc5HdmFEMwbdCKxBZI5+2X22ACvn+oD0H7yUGOlxSKRwMqichGZcY
         usoGKk9jigsqgmvov8djDZc5ZfeOwRLtvCZWsVZD85j5GF0MptnFnJfAl4ouvO7E2SmH
         VpuLQyKAo3Thja5OXDR10FFhJgGZ+sykcmPbxsaUvRlneoS5YcbY1VGZCMYwNAUDzlE7
         CG/W1EehjvEq2t3TCjpbZWnu08Vqs39EcLJO0cj5h1DAM7ldeuK0ihZSzCv7Ks6bJxT3
         3qR+OEYqKB5AOyRKe+ZdCiGT9o3LmPXAhramzbTuvEat464pWzc4F3QBMXNt9BYs3fgJ
         Zbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692733150; x=1693337950;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yIHWFB90GjbvEl5GFqHNvMT7C+BXCqNsOTq1W9bL3ts=;
        b=DSSUiv7F/1LZJS7CG9inQ2Q2I2fcTXGZxfx6XAuVr3al9KX8td1883ZYlHjCIZSBNo
         DkwdnwiSBY0NcFOmkCszZS8lxoIH+YvduEaw2bcxmMom1UW6DWvbc472wFP55P5iRdwA
         UsBGYYogcgD5tLbVpnN0/wb4OulT+62dd3JJbi22K1ApxCaF7Uw83QfFHTyiec1FuUFI
         nky8T4wz/3tX6i9zcmdlbooWog/10D3ffU4tKnz1qiKJbUd7X79/XypdIdGznIPJzRpY
         t3Xt62Qv1kBFDA5jzhiwl3kCUUbXb1zzFxNjw8UT0kUBCL2QNS6ZgTacaxakLVBLrDkY
         t0zQ==
X-Gm-Message-State: AOJu0Yxolyhw/VJ62z53rx0MYsZijcXV9UrgD93EZa+bBxS3vtrDMV2U
        GONjybWeTi8jqjlKYJNlrrLk
X-Google-Smtp-Source: AGHT+IEcKEah9zy+qF3P2fWS5wNqecOP8VkW8WnzCbJFCZMFDq9wgOBGCR/YjFWwcMFNhst/7p4rPg==
X-Received: by 2002:a81:6cd4:0:b0:579:e6e4:a165 with SMTP id h203-20020a816cd4000000b00579e6e4a165mr8883537ywc.10.1692733150557;
        Tue, 22 Aug 2023 12:39:10 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:a50f:b0d7:69b:ca4b? ([2600:1700:e72:80a0:a50f:b0d7:69b:ca4b])
        by smtp.gmail.com with ESMTPSA id l127-20020a0dc985000000b00586a09026casm2981043ywd.34.2023.08.22.12.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 12:39:10 -0700 (PDT)
Message-ID: <1550d741-009f-4c27-90a4-f1b91701cf6c@github.com>
Date:   Tue, 22 Aug 2023 15:39:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] setup: add discover_git_directory_reason()
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de
References: <pull.1569.git.1692025937.gitgitgadget@gmail.com>
 <pull.1569.v2.git.1692725056.gitgitgadget@gmail.com>
 <787af0f9744e2f18c9ab680886650278a9d2f8d0.1692725056.git.gitgitgadget@gmail.com>
 <xmqqttsqlvsd.fsf@gitster.g>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqttsqlvsd.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/22/2023 3:30 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <derrickstolee@github.com>

>> It is worth noting that GIT_DIR_NONE is not returned, so we remove this
>> option from the enum. We must be careful to keep the successful reasons
>> as positive values, so they are given explicit positive values.
>> Further, a use in scalar.c was previously impossible, so it is removed.

(Relevant bit from the message.)

>> diff --git a/scalar.c b/scalar.c
>> index 938bb73f3ce..02a38e845e1 100644
>> --- a/scalar.c
>> +++ b/scalar.c
>> @@ -686,9 +686,6 @@ static int cmd_reconfigure(int argc, const char **argv)
>>  				warning(_("removing stale scalar.repo '%s'"),
>>  					dir);
>>  			strbuf_release(&buf);
>> -		} else if (discover_git_directory(&commondir, &gitdir) < 0) {
>> -			warning_errno(_("git repository gone in '%s'"), dir);
>> -			res = -1;
>>  		} else {
>>  			git_config_clear();
>>  
> 
> In the original before this series, and also after applying [PATCH
> 3/3], the reconfiguration is a three-step process:
> 
>  - what if we cannot go to that directory?
>  - what if the directory is not a usable repository?
>  - now we are in a usable repository, let's reconfigure.
> 
> and this seems to lose the second step tentatively?  It is
> resurrected in a more enhanced form in [PATCH 3/3] so it may not be
> a huge deal, but it looks like it is not intended lossage.

I know what happened here. At some point during my edits, this line was
changed to "else if (!discover_git_directory(...))" which became an
unreachable case.

So, based on the intermediate patch that did not survive, it made sense,
but you are right that this hunk of this patch is behaving badly. Good
eye!

Thanks,
-Stolee
