Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58F5C43334
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 15:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245663AbiFIPjz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 11:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbiFIPjx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 11:39:53 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC7B2D515B
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 08:39:52 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id h8so4161415iof.11
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 08:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ko0LryteOgjkN7CK8Wo6lrZKc33NMQGXhE0229tkzWM=;
        b=DEcNEenzvL/BJ26ir2T5Jcchm4I6VjGMXeqZf6zNCgYl3aFQwaFnndMRA2jJpr54vt
         sDT4pvAt98s4W62aHat4cVyHLy53x5BUHWV/oimDLhShGsSSXqP9kyE2mAExZl4HWZGM
         HxXDWziYg8axzaoCanE3I723TeTx2xRxpY9IHdcivVDgPuDTLqUE7RTS9+7lj7DGVnJe
         y8ZWGIrDFlQKkixOSSQq2JMIscmm8p+dxG9ykOLXE3F6IfRdy2qy+O+eB/NA2lLecM8M
         5hYXhwXAGRhFgt9aGpnV6afwBcBMWx+RMNaQkGVh6wmPjN9zrHFlzb4G0hp/nGE/sEKj
         EQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ko0LryteOgjkN7CK8Wo6lrZKc33NMQGXhE0229tkzWM=;
        b=OwhDciHq4Gbf7rQIHsAKgeWVW884UQNirE2avjkTzxJhHRuJs4hM8em049/DXaCOQ6
         dZUCj9TPYV8O1CmZRWoFJqwHCOuyNo0Ie9ZScmxY7b7ie3OoRIA/pjbIZces/XPzp76L
         wFPRT+P1HKTs3/Ew8NOqMf4hmvtfLEjfC8t8/7DyfMLInDdOePqamjYtqJ8deNAChDom
         aq7ldBcsOkj3Tf8E+12YE3EyI5Wy1Z4JBOOO8AUVUxrwTWqHG+nzzrLWPOjUC9Ku9i7C
         xPXMvaiEWsqB5wYORIBT8u3uxr4a6o2rlkQJDE3ocUC7DjhGf/WtppQ3ibl8EyzNbIS5
         ZzFA==
X-Gm-Message-State: AOAM533HVToOUl3rKIUVykIvojDYpGkE4IkD3zR6wL+pGvqXvLhSwOmO
        m8TPh499CQrloYnNvrr33wG4BuIamXv5
X-Google-Smtp-Source: ABdhPJzwamDLUDbqqoc2pUan1K4uPXYTanTAA6QYLV4/XsD00dUr6nadCFa2fcibixAkeyNVAcBKvQ==
X-Received: by 2002:a05:6638:2513:b0:32e:5298:8264 with SMTP id v19-20020a056638251300b0032e52988264mr22252912jat.178.1654789191353;
        Thu, 09 Jun 2022 08:39:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:e450:cdf5:d20:d4b1? ([2600:1700:e72:80a0:e450:cdf5:d20:d4b1])
        by smtp.gmail.com with ESMTPSA id g13-20020a056602248d00b0065abb700feasm9468898ioe.26.2022.06.09.08.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 08:39:51 -0700 (PDT)
Message-ID: <a6ff4bcf-b00b-d19e-d7a8-4a2833dd14b8@github.com>
Date:   Thu, 9 Jun 2022 11:39:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: commit-graph overflow generation chicken and egg
Content-Language: en-US
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
Cc:     git@vger.kernel.org, Abhishek Kumar <abhishekkumar8222@gmail.com>
References: <YqD5dgalb9EPnz85@coredump.intra.peff.net>
 <581c7ef2-3de4-eb8a-bfbb-d4bca3522a2d@github.com>
 <220609.86h74utg6j.gmgdl@evledraar.gmail.com>
 <YqIRD8IwUFt6T8p+@coredump.intra.peff.net>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <YqIRD8IwUFt6T8p+@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/9/2022 11:26 AM, Jeff King wrote:
> On Thu, Jun 09, 2022 at 09:49:15AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
>> It's certainly interesting to see *how* we got to this state, but just
>> so we're on the same page: I fundimentally don't think it matters to the
>> *real* bug here.
>>
>> Which is that at the very least f90fca638e9 (commit-graph: consolidate
>> fill_commit_graph_info, 2021-01-16) and e8b63005c48 (commit-graph:
>> implement generation data chunk, 2021-01-16) (CC'd author) have a bad
>> regression on earlier fixes that read-only operations of the
>> commit-graph *must not die*. I.e. the "parse" and "verify" paths of the
>> commit-graph.c code shouldn't call exit(), die() etc.
> 
> Yeah, I'd agree that this is a good philosophy to follow. The
> commit-graph data is meant to be an optimization, and we can always
> continue without it.

I agree that the die() is part of what is frustrating here, but we need
to be careful: when we recognize that the commit-graph data is erroneous
_at this stage_ we may have already made decisions based on the existence
of a commit-graph (such as "we should trust generation numbers" or "we
have parsed some of the commits using the commit-graph") and so we cannot
guarantee that the process will complete with correct results from this
point.
 
>> If you replace your graph with Jeff's corrupt one and run "git status",
>> "git log" etc. it's still emitting one verbose complaint, but it no
>> longer does so in loops (at least for these paths, but e.g. "git gc" is
>> still doing that).
>>
>> But it does get us to where we can run "git gc", and while complaining
>> too much along the way will write out a new & valid commit graph at the
>> end ("[... comments are mine"):
> 
> Yeah, getting through "git gc" is the key thing here. Then the problem
> solves itself, sometimes even automatically (via auto-gc).

Perhaps we could change the die() behavior to be a warning() plus a
reset of all commit data if we are in a mode that can handle that error.
Specifically, during a commit-graph write.

I think the current die() behavior is the safest thing to do right now
until someone has time to think through these scenarios carefully.

Thanks,
-Stolee
