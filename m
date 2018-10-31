Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2668E1F453
	for <e@80x24.org>; Wed, 31 Oct 2018 13:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbeJaWzr (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 18:55:47 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40688 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729426AbeJaWzr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 18:55:47 -0400
Received: by mail-qt1-f196.google.com with SMTP id k12so11865879qtf.7
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 06:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=6xEoWqHdU5I8laaWKZo2hbxDS+xonpFkigCcZ0I25S8=;
        b=Y8MB0Wmcw43gO41XXzvx7iW7THVEqFVhw62TFIhw8Qbu+RQfHHFx39+ZW38iq/KdG7
         6pucp5iYcjcPLno8CSKNrtW4/NiZKAu4ABRPEfgj6cze+1KWhMwoDr84anVExcEdrmUP
         vKD7x5Zmwz/48gJO2HWAwu0OO9/lWC9++pmBJte/k/8zOMYczlDrDtx/syM67GwckESr
         GAMVyCwRMx6J16wpYIbS3/XFVbZqQF1yzYdwtJB48UPkFuSlJxTcpR6e68ufMPK33rWc
         dpQYf3Lcovrv7sZ80cX0tUBiUaGxOvwFrq9s4KibanP68VhU93ZlNPs5O8/TJ2LJWsvM
         UJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6xEoWqHdU5I8laaWKZo2hbxDS+xonpFkigCcZ0I25S8=;
        b=KLM3vx+a8f6xN9sH6zTIlhuw/j+nDVfM/P2KsdDbEaKyaZtG1gg3ckibMtNcWJqlz6
         szCWoYfMwcBdp3FOWEuL4U0RL/O+rJPqO7qFUOPYGjyvjL5iiryzMrndKeAKBn67eIHa
         M/u7/ONSt+YaxNKF39v2s6MUQ3LR8kXjvaVkIPWm/VJoEclemwJE3ArA2w2j2qPbrDm/
         xnkKl7l0ITq+QSMPH+29grL5d3PDB1MdadkWj05AZW7ppA2n7WifOQI+VFXalVl86h/G
         ReueeyuwTzGqBcMyRfbYAvJu0saHcU5xH9nHwDf0Zsem/5LjRKVK+Kqsi2LAkgmQlcab
         ZOGw==
X-Gm-Message-State: AGRZ1gJ2iN3D6b50H9ADF4Z9z6xeCyGtFtzhm1FtXkeQDtsBLfk4pDZx
        8lWH8JYxElkThbiPc1n9mqE=
X-Google-Smtp-Source: AJdET5fRRj0OhSfUcO5ufuh2dEJOSJKiqcNRW+HWAxN7vsvG2NsjXhdRFYHlBw2IXiqeeeu6m6bjAw==
X-Received: by 2002:ac8:278d:: with SMTP id w13-v6mr2734777qtw.149.1540994256501;
        Wed, 31 Oct 2018 06:57:36 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:1547:f48:38e6:a522? ([2001:4898:8010:0:fe7c:f48:38e6:a522])
        by smtp.gmail.com with ESMTPSA id e8-v6sm18011352qkj.0.2018.10.31.06.57.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 06:57:35 -0700 (PDT)
Subject: Re: [PATCH v3 4/8] merge-recursive: new function for better colliding
 conflict resolutions
From:   Derrick Stolee <stolee@gmail.com>
To:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com
References: <20181014020537.17991-1-newren@gmail.com>
 <20181019193111.12051-1-newren@gmail.com>
 <20181019193111.12051-5-newren@gmail.com>
 <0b84c95b-38bc-e39e-a033-81eb3e7b8202@gmail.com>
Message-ID: <95a236fd-a757-81ad-34aa-b26b3c3b6e85@gmail.com>
Date:   Wed, 31 Oct 2018 09:57:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <0b84c95b-38bc-e39e-a033-81eb3e7b8202@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/31/2018 9:53 AM, Derrick Stolee wrote:
> On 10/19/2018 3:31 PM, Elijah Newren wrote:
>> +#if 0 // #if-0-ing avoids unused function warning; will make live in 
>> next commit
>> +static int handle_file_collision(struct merge_options *o,
>> +                 const char *collide_path,
>> +                 const char *prev_path1,
>> +                 const char *prev_path2,
>> +                 const char *branch1, const char *branch2,
>> +                 const struct object_id *a_oid,
>> +                 unsigned int a_mode,
>> +                 const struct object_id *b_oid,
>> +                 unsigned int b_mode)
>> +{
>> +    struct merge_file_info mfi;
>> +    struct diff_filespec null, a, b;
>> +    char *alt_path = NULL;
>> +    const char *update_path = collide_path;
>> +
>> +    /*
>> +     * In the recursive case, we just opt to undo renames
>> +     */
>> +    if (o->call_depth && (prev_path1 || prev_path2)) {
>> +        /* Put first file (a_oid, a_mode) in its original spot */
>> +        if (prev_path1) {
>> +            if (update_file(o, 1, a_oid, a_mode, prev_path1))
>> +                return -1;
>> +        } else {
>> +            if (update_file(o, 1, a_oid, a_mode, collide_path))
>
> The latest test coverage report [1] shows this if statement is never 
> run, so
> it appears that every call to this method in the test suite has either
> o->call_depth positive, prev_path1 non-NULL, or both prev_path1 and 
> prev_path2
> NULL.
>
> Is there a way we can add a test case that calls this method with 
> o->call_depth
> positive, prev_path1 NULL, and prev_path2 non-NULL?
>
>> +                return -1;
>> +        }
>> +
>> +        /* Put second file (b_oid, b_mode) in its original spot */
>> +        if (prev_path2) {
>> +            if (update_file(o, 1, b_oid, b_mode, prev_path2))
>
> Since this line is covered, we _do_ call the method with prev_path2 
> non-NULL, but
> prev_path1 must be non-NULL in all cases.
>
> I may have found a reason why this doesn't happen in one of the 
> callers you introduced.
> I'm going to comment on PATCH 8/8 to see if that is the case.

Nevermind on the PATCH 8/8 situation. I thought I saw you pass (a->path, 
NULL) and
(b->path, NULL) into the (prev_path1, prev_path2) pairs, but in each 
case the non-NULL
parameter is actually for 'collide_path'.

It is still interesting if we can hit this case. Perhaps we need a 
different kind of
conflict, like (rename, delete) [but I struggle to make sense of how to 
do that].

Thanks,
-Stolee
