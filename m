Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2424EB64D9
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 02:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjF1CFz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 22:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjF1CFx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 22:05:53 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F181FE5
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 19:05:50 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6687446eaccso4818216b3a.3
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 19:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1687917950; x=1690509950;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GMNKxMHSf1TOdF/kAzIbqtk8RvnuE0ocJuXmoxq/ROg=;
        b=IH8LLX7pGT4NwbC3lVeg2x/MoBQrqL27VzyIIJ839JUAdA0bnixKChKp1tx4kogEWo
         /p1/V1JNq3Ns6ezhyYfWRId2nRG1tR7mB5PwBSMq0zAU+0Ji7yy0TMgU/+P1C/2m0RNF
         mbh5HR2t72rBlhpfdVbFnx7Xezq9MejV9VfLfu3pnlMdHjazdcKg/mBr3VAX4s4RPL1x
         vbIRkG8kJQE+tsk6SUzrA3GUgsu8NHwLeGRskV6uNz0yZZTjK66xiPfCfl7D2RDwYI94
         CTykOeLeK6yQn5NMtwY1gDxcCESf1LL15f9GFvGQ5lgyhm1CBpaaqAkow5vYV9u2ntOE
         Nq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687917950; x=1690509950;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GMNKxMHSf1TOdF/kAzIbqtk8RvnuE0ocJuXmoxq/ROg=;
        b=dHwKDcu4aDo5YZISj6Led25aKMvTzr7zG0Azp1lHCU+q0NQBDBL23fyr0tsGFZSNWP
         gnpVEfxZdrytO2Kr2Ba2yKBfpmMV7oEsU2668gLxI4z7LKZ6PYsh7GwUym5gOFqSO4lA
         MdJIViQeTEM4DG6DE7iWP8v6s34KFEPlUoSvUsIUtj2Ofz8eued6FT82RFeYnRlYXRxo
         SM8EQpodW887GFX97Y2dY80js0PfV3P68aeEvUGYkAQV6Kc2veoBxmdIn9fc/lc8j+5u
         Vwz0B6Eb4vTIzwKZZMA4mOOJ8zOww30yU0edArLMQURHTmCyISl7lOP4s291YEOBtEVN
         hvWg==
X-Gm-Message-State: AC+VfDx4N+PgF08C0O6O0Xx5NVBLKz9yX532kJ6XGEMKiyAXf37w1BAk
        vX663PNHkpMvY8/mEjfROiet
X-Google-Smtp-Source: ACHHUZ77HN1adAAJJVOxPnNDss9+B894FXX6YuJ3aMViW4RwQEcYhDYZ6XA9rvz/1JIJWeXl7BPajQ==
X-Received: by 2002:a05:6a20:3d02:b0:121:f863:67f9 with SMTP id y2-20020a056a203d0200b00121f86367f9mr34564574pzi.18.1687917950345;
        Tue, 27 Jun 2023 19:05:50 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id iy15-20020a170903130f00b001a69dfd918dsm1270888plb.187.2023.06.27.19.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 19:05:49 -0700 (PDT)
Message-ID: <05df2971-0f26-6da3-093b-7de5d7a5dbca@github.com>
Date:   Tue, 27 Jun 2023 19:05:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 1/8] trace2: log fsync stats in trace2 rather than
 wrapper
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     nasamuffin@google.com, chooglen@google.com,
        johnathantanmy@google.com
References: <20230627195251.1973421-1-calvinwan@google.com>
 <20230627195251.1973421-2-calvinwan@google.com>
Content-Language: en-US
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20230627195251.1973421-2-calvinwan@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan wrote:
> As a library boundary, wrapper.c should not directly log trace2
> statistics, but instead provide those statistics upon
> request. Therefore, move the trace2 logging code to trace2.[ch.]. This
> also allows wrapper.c to not be dependent on trace2.h and repository.h.
> 

...

> diff --git a/trace2.h b/trace2.h
> index 4ced30c0db..689e9a4027 100644
> --- a/trace2.h
> +++ b/trace2.h
> @@ -581,4 +581,9 @@ void trace2_collect_process_info(enum trace2_process_info_reason reason);
>  
>  const char *trace2_session_id(void);
>  
> +/*
> + * Writes out trace statistics for fsync
> + */
> +void trace_git_fsync_stats(void);
> +

This function does not belong in 'trace2.h', IMO. The purpose of that file
is to contain the generic API for Trace2 (e.g., 'trace2_printf()',
'trace2_region_(enter|exit)'), whereas this function is effectively a
wrapper around a specific invocation of that API. 

You note in the commit message that "wrapper.c should not directly log
trace2 statistics" with the reasoning of "[it's] a library boundary," but I
suspect the unstated underlying reason is "because it tracks 'count_fsync_*'
in static variables." This case would be better handled, then, by replacing
the usage in 'wrapper.c' with a new Trace2 counter (API introduced in [1]).
That keeps this usage consistent with the API already established for
Trace2, rather than starting an unsustainable trend of creating ad-hoc,
per-metric wrappers in 'trace2.[c|h]'.

An added note re: the commit message - it's extremely important that
functions _anywhere in Git_ are able to use the Trace2 API directly. A
developer could reasonably want to measure performance, keep track of an
interesting metric, log when a region is entered in the larger trace,
capture error information, etc. for any function, regardless of where in
falls in the internal library organization. To that end, I think either the
commit message should be rephrased to remove that statement (if the issue is
really "we're using a static variable and we want to avoid that"), or the
libification effort should be updated to accommodate use of Trace2 anywhere
in Git. 

[1] https://lore.kernel.org/git/pull.1373.v4.git.1666618868.gitgitgadget@gmail.com/

