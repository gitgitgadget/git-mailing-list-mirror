Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9707B1F461
	for <e@80x24.org>; Mon, 20 May 2019 11:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732306AbfETLFd (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 07:05:33 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45413 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731781AbfETLFd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 07:05:33 -0400
Received: by mail-qk1-f193.google.com with SMTP id j1so8470042qkk.12
        for <git@vger.kernel.org>; Mon, 20 May 2019 04:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C5CdTBVOlGAG+iNzys1HUp07zuMKMaFoiBXLzToRfFo=;
        b=feu28GhgtMTTv/bH/YMfQYRD+p1s6QvNZe83gcco94g638MQ5G9OCbuXAsw1iAlVtn
         U2Tylq5PBTSBJTjvVIsXMPLP/wXYcYtX+NDpvUwXqYdV+vDOzp9a+wfkiFTK9rnszVbE
         ctHfPGHrfaxPWg3ntz6EriZV8N9fq2c7jO9aoVLZndhD4+y/2R2MaOQYpadSG1Gj7FuA
         +LQaB+p2hzYvwDpkuRdlp3NRATztPwjTOnqeJNwu+YyAyhLt8wyt3bPhZCcZbblYLtWQ
         irGhjwGwfpCcHC81yqhvNknCp6F26uc+o+meEsKmkRUuoi4hTXrRKvV0fYGA/Le+RzZd
         jIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C5CdTBVOlGAG+iNzys1HUp07zuMKMaFoiBXLzToRfFo=;
        b=b7JDr/yVImSoibLAuSJQW0TrKgCOeH2XVo3jzRfPnNcUhGMlVXDWvNuXfwVHnqPgeY
         uVQs2/WBrwfWJbWGGduhuTs74+6XP/95Gihkh9nyYTqTFsFCJ7sdIn3u+Dn/Nt70VvuR
         TBd1Iarq3qOJ6R6hr2uzrW7B49SDw+mEw1UKs61T+8y8mdqnmKKnx1+NXdNVQcKuqJ6B
         k+hHXuc4effos2CPFm9xmrguWZQQSpFOAR3AiH+AucvehERa8fg2eLS69ZdpMOHSwVeT
         jHNHqUL4ehbKodzQ21dt8twd+Hg5GwlogEK65xiZo6dYMKyMkfaeOJU6/vjkZ6fYcsTU
         etxw==
X-Gm-Message-State: APjAAAVOOATPmRwUP4wbmNJozoSaaF/IiOloO108bBWZkqQneG5EjOaN
        FIW2D+qNTvZQ3cotihs7dfs=
X-Google-Smtp-Source: APXvYqy0cO5CTyK9fdEQxASmSJwD2+DgCJGgvLJ/szOGXQciKvvUYPCgD0rMna1NXbm8q5903ZCANw==
X-Received: by 2002:a05:620a:13fc:: with SMTP id h28mr35286855qkl.164.1558350332666;
        Mon, 20 May 2019 04:05:32 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:8824:a533:8b:9681? ([2001:4898:a800:1012:3958:a533:8b:9681])
        by smtp.gmail.com with ESMTPSA id g55sm10550202qtk.76.2019.05.20.04.05.31
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 04:05:31 -0700 (PDT)
Subject: Re: [PATCH 0/3] Close commit-graph before calling 'gc'
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de, avarab@gmail.com
References: <pull.208.git.gitgitgadget@gmail.com>
 <xmqqk1en19pp.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <42c3857c-ef26-a05d-e2d8-30a450199fe8@gmail.com>
Date:   Mon, 20 May 2019 07:05:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <xmqqk1en19pp.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/18/2019 10:04 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> This series adds close_commit_graph() to close_all_packs() and then renames 
>> close_all_packs() to close_object_store(). This name is more descriptive of
>> its larger purpose.
> 
> OK.  Somebody needs to go though all the existing callers of
> close_all_packs() to see if the above claim is true (unless you
> haven't done so, that is), but I really like the general direction.

Here is a full inventory. Most of the context can be found simply by
'git grep -B 10 -A 10 close_object_store' but some cases need reading
a helper function to know for sure.

About to call gc or repack:

* am
* clone
* fetch
* merge
* rebase
* receive-pack

Is about to delete packs or pack-garbage:

* gc
* repack

And in object.c, we are in the "raw_object_store_clear()" method.

Thanks,
-Stolee
