Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B185AC433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 17:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiI3RSg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 13:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiI3RSd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 13:18:33 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804781C2F86
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 10:18:32 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id y189so1934185iof.5
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 10:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=q2Mso9g16cnG6q7DwxJpvoiCzDnhyBHVwzySqGbqs1c=;
        b=MSQh34LNE/Tv2FZll7Jc5kVR9m0MqmEk8+3FyBtc7MGxrOdU3MtrxyWlx+sFXk9ahs
         0sBv9DQn7NaqMOXnw5RYpX37a3uE3CFTEuHdAj5Cund4jJC63VAwGFygeXffZWluls7/
         tnHEOxLvqlpMbPzFn4Q6lr7iMuONoJr2v46xocAy4T7c8vUMLHUVc1sznP757kJynXxA
         kNwbVexoXNBgSWEB+uahGkbRRz2ALU4hTAtsqGRFyzInnBBvBuj+SwI9BfFlj19sCGbx
         1/QrNJDa2JmuXY0CSAchKIMy/theLUPyZnRqmNnjLTBiOuPlkaqENiI6Ugp/L1SWGC0U
         59vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=q2Mso9g16cnG6q7DwxJpvoiCzDnhyBHVwzySqGbqs1c=;
        b=IL4sc3EbpUvH9/KKYIgtn5TGlcF/oiFene8eWydue1gEwqjdVpM+fXegX+pm8ORg6U
         EC/A+r77s2HsuAlT8VjukHwa3bmrIJ6ze7vW6X91BMNBycRyqsmgL5e6OI2iFv2/N/3F
         tL2A9RqqwxEEwVkY+Fwt8/2v0/N7tqHZNezxdmjvMbAGNHihUUn4tmt6yF3X6BSetv9k
         psz+YY5wMe2bvZ28EzxgnsvdgiRVAuPuyjjUayabjid8xM2zY85OvSVC8RoFW/TKAxsG
         rX523kwWKPfulzK9Z9nVH6oDPLR3pTHedu/XgDcpdbM69lqLOdZoI3CRe3Ngctvi/adM
         zuGA==
X-Gm-Message-State: ACrzQf1M7UIVYbatg9lu0RZuU2LwYID7YtFbni9eW9YcEd2W/KqawSAM
        p0WLtqcD4CZ8lxCQiLNqFK1D
X-Google-Smtp-Source: AMsMyM7ubCE+jheJJYSCowKj7OOJ2XRvNcxUXeK0oWOaP/OMmE4gm1UUrZjzI+wYHJSP4qb2/0+Nuw==
X-Received: by 2002:a05:6602:491:b0:672:18ce:8189 with SMTP id y17-20020a056602049100b0067218ce8189mr4451447iov.170.1664558311810;
        Fri, 30 Sep 2022 10:18:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8c53:a5aa:3322:e297? ([2600:1700:e72:80a0:8c53:a5aa:3322:e297])
        by smtp.gmail.com with ESMTPSA id o3-20020a92c043000000b002f1378de8d5sm1116849ilf.40.2022.09.30.10.18.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 10:18:31 -0700 (PDT)
Message-ID: <fc887b02-191e-912a-bd15-1dc882ddf9dc@github.com>
Date:   Fri, 30 Sep 2022 13:18:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 4/6] sequencer: avoid empty lines after 'update-ref'
 instructions
Content-Language: en-US
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20220930140948.80367-1-szeder.dev@gmail.com>
 <20220930140948.80367-5-szeder.dev@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220930140948.80367-5-szeder.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/30/2022 10:09 AM, SZEDER Gábor wrote:
> When the sequencer generates a todo list for 'git rebase
> --update-refs', it always inserts an empty line after each
> 'update-ref' instruction and after each comment line about checked out
> refs.  These empty lines are unnecessary, distracting, and waste
> valuable vertical screen real estate, especially when multiple refs
> point to the same commit:
> 
>   pick 29a79f8 two
>   pick 74bf293 three
>   # Ref refs/heads/branch3 checked out at '/tmp/test/WT'
> 
>   update-ref refs/heads/branch2
> 
>   update-ref refs/heads/branch1
> 
>   pick 5f59b82 four
> 
> Eliminate those empty lines.

After this change, I think the end result is this:

  pick 29a79f8 two
  pick 74bf293 three
  # Ref refs/heads/branch3 checked out at '/tmp/test/WT'
  update-ref refs/heads/branch2
  update-ref refs/heads/branch1
  pick 5f59b82 four

Specifically, there is no whitespace break between the last
'update-ref' command and the next 'pick' command. Since the
'update-ref' commands likely correspond to chunks of changes,
it would be nice to still have that whitespace remain. I
agree that the whitespace between the comments and previous
'update-ref' commands is wasteful, but I'd rather leave the
wasteful (and usually rare) whitespace than lose the helpful
whitespace.

There is precedent for this kind of whitespace when using
'--rebase-merges'.

If you can find a nice way to add a line of whitespace between
these lines and the next instruction type, then I fully
support this change.

Thanks,
-Stolee
