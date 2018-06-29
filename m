Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97A451F516
	for <e@80x24.org>; Fri, 29 Jun 2018 23:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934254AbeF2XVT (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 19:21:19 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:45517 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933987AbeF2XVS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 19:21:18 -0400
Received: by mail-yw0-f193.google.com with SMTP id v190-v6so4338752ywa.12
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 16:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3+LCHqfWR/8UjYldGEZ7S9YRVTgKGDMfyB8qiU+Q3VY=;
        b=EMuzXCnxs7I8dtelDKEcAMV7BOuSI+IxjTUwcAKNByj3cTvecd8iX9K2e27Q0inT5t
         NlvY+MQbNRgtYSn90bp22tbyUqUeSzt//lzyw074+AQ4KsB7tIhzL+ee/CY+k5M8o0gC
         VxBVvYAVwQsYWwgcjRm/zXxrArgHdkvLmSBdTl7qsTZkA9Qk1+oUx65E3iGUYyZP6Xe4
         KkzsEIQaam8/cAtwFemMF13jH/HJXZn5v7RkhCm7YJousJP7hz/oDNDDZ1Mp+5opu5ai
         yZUDc/Oe1wKtf9NLi7Tg7LGr1Oh27U/1ugr6DbqUDEWnhwq1FfGrQ2jYmtXd1uOnutHp
         9yDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3+LCHqfWR/8UjYldGEZ7S9YRVTgKGDMfyB8qiU+Q3VY=;
        b=pCUvN/tQ17gEVWejXQ9kh4It5tK7sdiyUWfHXPFFwThv4jMjKagNdTSHMwnY4UZt4K
         PpHY0I9T35e0cpi4BedagZ29lVcnfizSkn8hHQBqt45TfmnQQlPKr7iadf3trfVqGgWs
         qpoaEQdeSHmUjhZmZSfQ1DiGhVwhJXAjjwAC/e1tARzUekJsG/NaLKzX+lOjm8Kxe9pb
         QVfMRh2EleqD1Hzv3Kd+TuUX6ZU+CL6anehv1BpueU5q9WEgpIJuVh8p+PohZ4PF1hT5
         OGD5EMZC5MmvFkVvusD1tv2HYxTI5KPAWhhjZi+gQDIo6K2FqM6tA1Dev4VCO5klKTjv
         ZH9A==
X-Gm-Message-State: APt69E2JJ6BJcdv5+5O5IzgRNV4t1eGDzziYdNkJy6+ubBKcfYOACbYN
        Tt2s47/MS9nkp/7xBT/0er5+zy6be8kx+OGNuvqCvA==
X-Google-Smtp-Source: AAOMgpctYvW2+BcqP8ap0la9wx9F8HrTKCY4USojNJnDmKfQAdkhdOQx8gKXVGmAZ4I9LfsH/ua5BcMf119jMZMsGB0=
X-Received: by 2002:a0d:f442:: with SMTP id d63-v6mr8251062ywf.238.1530314477768;
 Fri, 29 Jun 2018 16:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180629161223.229661-1-dstolee@microsoft.com> <20180629161223.229661-14-dstolee@microsoft.com>
In-Reply-To: <20180629161223.229661-14-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 29 Jun 2018 16:21:06 -0700
Message-ID: <CAGZ79kbVvto1uV0Rk2UbqLTeL2s21efdcwkEfEPZG+3pD5gwXg@mail.gmail.com>
Subject: Re: [RFC PATCH 13/13] commit-reach: use can_all_from_reach
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick,
On Fri, Jun 29, 2018 at 9:13 AM Derrick Stolee <dstolee@microsoft.com> wrote:
>
> The is_descendant_of method previously used in_merge_bases() to check if
> the commit can reach any of the commits in the provided list. This had
> two performance problems:
>
> 1. The performance is quadratic in worst-case.
>
> 2. A single in_merge_bases() call requires walking beyond the target
>    commit in order to find the full set of boundary commits that may be
>    merge-bases.
>
> The can_all_from_reach method avoids this quadratic behavior and can
> limit the search beyond the target commits using generation numbers. It
> requires a small prototype adjustment to stop using commit-date as a
> cutoff, as that optimization is no longer appropriate here.
>
> Performance was meausured on a copy of the Linux repository using the
> 'test-tool reach is_descendant_of' command using this input:
>
> A:v4.9
> X:v4.10
> X:v4.11
> X:v4.12
> X:v4.13
> X:v4.14
> X:v4.15
> X:v4.16
> X:v4.17
> X.v3.0
>
> Note that this input is tailored to demonstrate the quadratic nature of
> the previous method, as it will compute merge-bases for v4.9 versus all
> of the later versions before checking against v4.1.
>
> Before: 0.31 s
>  After: 0.27 s
>
> Since we previously used the is_descendant_of method in the ref_newer
> method, we also measured performance there using
> 'test-tool reach ref_newer':
>
> Before: 0.12 s
>  After: 0.11 s
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>
> One thing I know is missing from this commit is a special-case to use
> the old logic when there is no commit-graph present. The
> can_all_from_reach() algorithm can be worse when we do not have good
> generation number cutoffs. In the previous case of
> can_all_from_reach_with_flags(), we already had an established pattern
> of using commit date as a cutoff, so the generation number is only a
> second cutoff and the algorithm cannot walk more commits than before.

I like this series,
Thanks for writing it!
Stefan
