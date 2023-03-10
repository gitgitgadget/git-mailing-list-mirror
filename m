Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158CEC6FA99
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 19:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjCJT0A (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 14:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCJTZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 14:25:59 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6211340F7
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 11:25:56 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id bp19so5065283oib.4
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 11:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1678476355;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ir5abf4OVOWhTrj20MD6pU+i3vc47uethLZIMSSLxmw=;
        b=hSUWu++kZalVTKvHFaMPOTaqrCosH6QCYZS7dFPnsyZUSpGTeqc+k6iqXNIh8HN6jI
         AV5Ce9ZthdW9Xy6uziyGHVK1FNloOHra9zqnu1ERU+ms+X32SNPajf5x+siYnbVAcT6n
         b2waCrf/sJkisn7JpoblN76fGbhxa0XnfG70rtYF/Oy718t6LILrPpfYxqcHywm6JkYv
         NhFYXCWeawn2mv8j08jcjD0kmtcWxQS4P6uNMm9TISHynfxuzScXthxs4ThaBXx9F3os
         /Q/n1ez0tgaCLxSwArf2iD3HaT0C33KNtE1InQlVGs6PHzuaz7SwQi5aQlysU7lB6TY4
         9iUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678476355;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ir5abf4OVOWhTrj20MD6pU+i3vc47uethLZIMSSLxmw=;
        b=c+5btQ+8faw5SALA5McW3BiUIaw8/3wnUXq/qmHPA6tQ1Y8wN/E+w52aTdUUvwgcja
         QwTe30bl+zjPPWF58qhz+tVL5edFfsxbltPB8WJ/fmKgmX+WkgV7PtCLqQ0TrsZeToo9
         G58aUPcrTzFujS5i/hELddad+48/hnFxM6W4iWWIMjl63o2DnAMCx5Zvj+sGmMkAseuj
         rPSjoHd0kE9mg0EB5fcv4df6euEH5TzVTXw9si3TONyTCBniJI4bYUMRnUvpojJ01AHL
         g2nd0q6JUtqn+Gpp44RDMPxpbXED5L8ZgJze/WVzBv84G5awhnP/tWzu+q6OCIukmEFb
         u0eA==
X-Gm-Message-State: AO0yUKUiuoFOwh7ZxDDZXcBCJzKEWs3oAEedvwXoiL064f8s2ELKhXE2
        1j2Jw8aKnwGxve2Acz5XR7l6QcQpMyuho4guqQ==
X-Google-Smtp-Source: AK7set/gNov5Uu7vqu0OuIuq2/0FNOvq4tzr+bs7k70nmLa4sV0o+z4UOGA5Sy1s/gOnBcwJPGRi3A==
X-Received: by 2002:a05:6808:48:b0:384:4739:dddc with SMTP id v8-20020a056808004800b003844739dddcmr11875059oic.2.1678476355640;
        Fri, 10 Mar 2023 11:25:55 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:e975:8a5:5de4:4d9c? ([2600:1700:e72:80a0:e975:8a5:5de4:4d9c])
        by smtp.gmail.com with ESMTPSA id y64-20020aca3243000000b0037d8dbe4308sm197110oiy.48.2023.03.10.11.25.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 11:25:55 -0800 (PST)
Message-ID: <74656b93-8c67-ffe3-4aea-4c184345384d@github.com>
Date:   Fri, 10 Mar 2023 14:25:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 0/8] ref-filter: ahead/behind counting, faster --merged
 option
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        Jeff King <peff@peff.net>
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
 <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
 <xmqqedpw5se6.fsf@gitster.g>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqedpw5se6.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/10/2023 2:16 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>> However, '%(ahead-behind:)' computations are likely to be slow no matter
>> what without a commit-graph, so assuming an existing commit-graph file is
>> reasonable. If we find sufficient desire to have an implementation that does
>> not have this requirement, we could create a second implementation and
>> toggle to it when generation_numbers_enabled() returns false.
> 
> At that point, it might make sense to find a way to make the work
> ensure_generations_valid() had to spend cycles on not to go to
> waste.  Something like "ah, you do not have commit-graph at all, so
> let's try to create one if you can write into the repository" at the
> beginning of the function, or something?  Just thinking aloud.

This is a reasonable idea for helping users get out of a slow
situation. Let's see how often this is a problem to see if it
is worth doing that extra work in another series.

> Having read all the patches, I am very impressed and pleased, but
> are we losing anything by having the feature inside for-each-ref
> compared to a new command ahead-behind?  As far as I can tell, the
> new "for-each-ref --stdin" would still want to match refs and work
> only on refs, but there shouldn't be any reason for ahead-behind
> computation to limit to tips that are at the tip of a ref, so that
> may be one downside in this updated design.  For the intended use
> case of "let's find which branches are stale", that downside does
> not matter in practice, but for other use cases people will think
> of in the future, the limitation might matter (at which time we can
> easily resurrect the other subcommand, using the internal machinery
> we have here, so it is not a huge deal, I presume).

I think the for-each-ref implementation solves the use case we
had in mind, I think. I'll double-check to see if we ever use
exact commit IDs instead of reference names, but I think these
callers are rarely interested in an exact commit ID but instead
want the latest version of refs.

The idea of using committish tips definitely changes the
functionality boundary. You are right that we can introduce a
new builtin easily if that is necessary. Even without the
ahead-behind builtin, we are succeeding in reducing the diff
between our fork and the core project.

Thanks,
-Stolee
