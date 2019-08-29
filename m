Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E603B1F461
	for <e@80x24.org>; Thu, 29 Aug 2019 12:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfH2M66 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 08:58:58 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37041 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbfH2M66 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 08:58:58 -0400
Received: by mail-qt1-f193.google.com with SMTP id y26so3523077qto.4
        for <git@vger.kernel.org>; Thu, 29 Aug 2019 05:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RaAbCBaOJ5zrd/U4gdjp8UpND9mqkYq8jeL302N8rE8=;
        b=s29LO5ho3LnVdtCMdTt+7i8cIper02amEJDM7MZxUYNAXwS3wmnjsGJZDcxAJYRyvP
         iBrpTikf4IAWUuZDljpyYPrje//xTwyHHVCnUcrYmcNFsOeVLtdSXhN8evj0caCZY9B7
         rP5O3OVZX1LnOeOv+ldc2ufQO/ugBVRQMqvORiQFbb/VmfKVTZY4zKyCGe9T3kpgNakE
         v+8Xv8WG/VwxgRfxvIStOZEw2BmwXeG1F+7HN1kQekQBbtklzCDhLr39GNOAdFZen2/p
         RpUInDHiQmN5NvCcPtYEhiprOtvcHCQSFf16OBJT/H7S537TUSHxDUtWlzp7e9+5bvei
         b17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RaAbCBaOJ5zrd/U4gdjp8UpND9mqkYq8jeL302N8rE8=;
        b=sfdvOOj9dkHZgrmDW6737j7RzOYPGv1GUXfono11iL+AXdpFhPxOC8zKIk6Wa8Zvcf
         Fc+T7Ld9WOEkmdReqBH2i9WhA/sZlW7ZzrVrjarGw8/Z0/pBR5NTK3+ZJ5IVKqSPvWHt
         8dxPpxbvsT8cVXmuLGPIZlUR2UF2/lW1y0GzJnhVv/a62JDdgnykLV3fjXYaXiAP7THS
         MkK7mEuC+Dz+bNfpueC3mXh4Ba670vB0bcFKS0RqkEM4yMDjHwRYvNOgksBmA6UF1IK8
         MQ9ksQ/HgAZ0ALEup1gr3Y2q/uxEZcTV9be4ocN75IVFEsJuo8HlFPszUACbfBhrYveT
         zD6g==
X-Gm-Message-State: APjAAAU7rTEHEWKmsqty4K89W5IBGbYV89S1EYWRdkjaj9LolesjEctz
        9v+UPuWyqj5xEmcZvLJPrZs=
X-Google-Smtp-Source: APXvYqwWBWgBGNC3mANLRFHiPpYi/CI4bR1fNxT19yOweLZ6ewCfNUJibrRD6UaPtCuKnkAYAG3deQ==
X-Received: by 2002:ac8:760e:: with SMTP id t14mr4769529qtq.175.1567083537388;
        Thu, 29 Aug 2019 05:58:57 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:f9f6:adc0:ae8d:8f1f? ([2001:4898:a800:1010:ab2c:adc0:ae8d:8f1f])
        by smtp.gmail.com with ESMTPSA id e14sm1328877qta.54.2019.08.29.05.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2019 05:58:56 -0700 (PDT)
Subject: Re: [PATCH 1/1] upload-pack: fix race condition in error messages
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.324.git.gitgitgadget@gmail.com>
 <5c313aba7e97cb93e7d07f6d5dfaf0febe8a2f8b.1566956608.git.gitgitgadget@gmail.com>
 <20190828093408.GD8571@szeder.dev>
 <20190828145412.GB14432@sigill.intra.peff.net>
 <20190828153944.GA29715@sigill.intra.peff.net>
 <20190828161552.GE8571@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4d5773f9-4637-d8a3-d683-82624950f319@gmail.com>
Date:   Thu, 29 Aug 2019 08:58:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190828161552.GE8571@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/28/2019 12:15 PM, SZEDER Gábor wrote:
> On Wed, Aug 28, 2019 at 11:39:44AM -0400, Jeff King wrote:
>> On Wed, Aug 28, 2019 at 10:54:12AM -0400, Jeff King wrote:
>>
>>>> Unfortunately, however, while running './t5516-fetch-push.sh -r 1,79
>>>> --stress' to try to reproduce a failure caused by those mingled
>>>> messages, the same check only failed for a different reason so far
>>>> (both on Linux and macOS (on Travis CI)):
>>>
>>> There's some hand-waving argument that this should be race-free in
>>> 014ade7484 (upload-pack: send ERR packet for non-tip objects,
>>> 2019-04-13), but I am not too surprised if there is a flaw in that
>>> logic.
>>
>> By the way, I've not been able to reproduce this locally after ~10
>> minutes of running "./t5516-fetch-push.sh -r 1,79 --stress" on my Linux
>> box. I wonder what's different.
>>
>> Are you running the tip of master?
> 
> Yeah, but this seems to be one of those "you have to be really lucky,
> even with --stress" cases.
> 
> So...  I was away for keyboard for over an hour and let it run on
> 'master', but it didn't fail.  Then I figured that I give it a try
> with Derrick's patch, because, well, why not, and then I got this
> broken pipe error in ~150 repetitions.  Run it again, same error after
> ~200 reps.  However, I didn't understand how that patch could lead to
> broken pipe, so went back to stressing master...  nothing.  So I
> started writing the reply to that patch saying that it seems to cause
> some racy failures on Linux, and was already proofreading before
> sending when the damn thing finally did fail.  Oh, well.
> 
> Then tried it on macOS, and it failed fairly quickly.  For lack of
> better options I used Travis CI's debug shell to access a mac VM, and
> could reproduce the failure both with and without the patch before it
> timeouted.

I'm running these tests under --stress now, but not seeing the error
you saw.

However, I do have a theory: the process exits before flushing the
packet line. Adding this line before exit(1) should fix it:

	packet_writer_flush(writer);

I can send this in a v2, but it would be nice if you could test this
in your environment that already demonstrated the failure.

Thanks,
-Stolee

