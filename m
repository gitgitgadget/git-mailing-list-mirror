Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92F371F516
	for <e@80x24.org>; Mon, 25 Jun 2018 14:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934461AbeFYOs7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 10:48:59 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:46847 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934325AbeFYOs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 10:48:58 -0400
Received: by mail-qt0-f177.google.com with SMTP id h5-v6so12129904qtm.13
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 07:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=0fvdtyPHZhBZWC7UyRdU67fAWdyb6XToj1glfmYODzA=;
        b=SelC2NynxRwKr5emq/MUe28cT3bnZmSdFmolCC3zxFrVjCa8PBDKtvyNgYi8BnGuIr
         Lo5gyUC/yFzIS4gcsMOsGA6ewnu1pC9Dc9GBcjoQQ5HKP1pzjv8ZJ8lyUYQOWtYmSjfh
         9fA+hIs11qyM/8eNIPEe8BNx6vHCU5FzqB/9es+Hda4Q7HqYIuk5divrFT6B3amSUl/m
         PaPoc5JAeZ5ji4YM604wn78PLUWnJ9WpIfWe+obBkxSy9YfZwklMjzhbXFCkhbX6QApL
         6qIEIFgOAFO48VnK7gdoVeAKzXgJSXsftJhQ4hSslcSZX3kUhmRbCztr9enQqMT5NeQC
         bz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0fvdtyPHZhBZWC7UyRdU67fAWdyb6XToj1glfmYODzA=;
        b=e3w3T7iz38uBwddmO4vBLJAXiDPACLFkQ/xknqyWOFlDK1jlyvVZt6PpAwtKgvhxSC
         XHlsHQW8tuXYDz+JIzjteEW2PEzf7W2O4z2YkIJE2skzuGLXJ9OwIk4zDQpAIXhn39Zb
         NdR322UFxX7/SI47uxnzuCQ0eZjQTSknX1wQ0hC6pxwQPL8iU3+EeONYwYE34esseBMZ
         eyG8Pn+mJzxIgkHMIwT0qThd+9BjS1KwOQzmY4C7/36IAxxcpDc7ggs+hogj1bAL1Tbv
         yKfbPhq9QAenn43Urf/odlgVw5VlCLkWRFgIEsbm5KkA0F0b8gKlHGPzhf4ys5iKlt+/
         TnbA==
X-Gm-Message-State: APt69E1+xyGBSveqbYehkKj2Eg4XyIKdMcYglI2lXY+SpkK9za/fjaKS
        eqX4TDJ/W3IPqD8O4tmpclQ=
X-Google-Smtp-Source: AAOMgpdH7DVj5I0pUjpEzS0aP/h6eEUzaSaa1RanPtPi6K0hEXU6Bq192KG86o9/aOu+GWR8Kl+z0A==
X-Received: by 2002:a0c:b52c:: with SMTP id d44-v6mr11288176qve.34.1529938137333;
        Mon, 25 Jun 2018 07:48:57 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:b18f:cf0a:3d2:5cc2? ([2001:4898:8010:0:9ac5:cf0a:3d2:5cc2])
        by smtp.gmail.com with ESMTPSA id o5-v6sm10228134qtm.60.2018.06.25.07.48.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 07:48:56 -0700 (PDT)
Subject: Re: [PATCH v6 20/21] gc: automatically write commit-graph files
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>
References: <20180606113611.87822-1-dstolee@microsoft.com>
 <20180608135548.216405-1-dstolee@microsoft.com>
 <20180608135548.216405-21-dstolee@microsoft.com>
 <20180608222414.11306-1-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <abe65bdb-92b1-2932-3d15-3ddfae7e75c3@gmail.com>
Date:   Mon, 25 Jun 2018 10:48:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180608222414.11306-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/8/2018 6:24 PM, SZEDER Gábor wrote:
>> The commit-graph file is a very helpful feature for speeding up git
>> operations. In order to make it more useful, make it possible to
>> write the commit-graph file during standard garbage collection
>> operations.
>>
>> Add a 'gc.commitGraph' config setting that triggers writing a
>> commit-graph file after any non-trivial 'git gc' command. Defaults to
>> false while the commit-graph feature matures. We specifically do not
>> want to have this on by default until the commit-graph feature is fully
>> integrated with history-modifying features like shallow clones.
> So I played around with an earlier version of this patch series a
> while ago... and as I looked into my gitconfig today I was surprised
> to have both 'core.commitGraph' and 'gc.commitGraph' config variables
> set.  When I looked into it I came across this email from Ævar:
>
>    https://public-inbox.org/git/87fu3peni2.fsf@evledraar.gmail.com/
>
>    > Other than the question if 'gc.commitGraph' and 'core.commitGraph'
>    > should be independent config variables, and the exact wording of the
>    > git-gc docs, it looks good to me.
>
>    Sans doc errors you pointed out in other places (you need to set
>    core.commitGraph so it's read at all), I think it's very useful to have
>    these split up. It's simliar to pack.useBitmaps & pack.writeBitmaps.
>
> I think the comparison with pack bitmaps makes a lot of sense and I
> have to say that I really like those 'useBitmaps' and 'writeBitmaps'
> variable names, because it's clear right away which one is which,
> without consulting the documentation.  I think having 'useCommitGraph'
> and 'writeCommitGraph' variables would be a lot better than the same
> variable name in two different sections, and I'm sure that then I
> wouldn't have been caught off guard.

Sorry for the late reply. Maybe 'gc.writeCommitGraph' makes it clear 
that the setting enables writing the commit-graph during  a 'git gc'. Is 
that more clear?

Thanks,
-Stolee
