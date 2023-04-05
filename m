Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB669C76188
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 19:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjDET3C (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 15:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDET3A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 15:29:00 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C555251
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 12:28:59 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso4404166pjc.1
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 12:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680722939;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+j3iqStS0bmo66KZerOdoHxMqpHlmFZ0g+W+KntFqiE=;
        b=l/mN5oLRxgWjavWJgJahQbC9XE2Wz17H5lfnd/5iYufTFkT1QtdEmL9a22BuyAbpVv
         XTX61nwCtDoe5dgA17OE02YE0uho+8Hz6cMqAPPogienM43OBk3mnOtJHgCQOi3BnVc5
         rhukoYJpyNAbdGE9+EbxUZo7GictLYW9B34Fkq8zDN5kVxrZ/S+kpoY1Ft7NyuFnjfu+
         p38D3iTc0xYIPX19gwW9R3vxHU4k+m0W1eL8t7tZrJkTC+DBabAzu6mu6SwXIz639Nji
         b6Q+mAV7bO2FQaKbL/mcNgKUSE3P5oSWNzaZ8HDIjNbHrhMTtT8bFnt9oXMCNFkJfiiG
         wjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680722939;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+j3iqStS0bmo66KZerOdoHxMqpHlmFZ0g+W+KntFqiE=;
        b=nPuglLM1syhGrp5Negzm1PZf+q8C6CA0rM6egxzQr0qJbIwU7IcIsH9mRA/OwmRzZp
         So9uQSyMpeypsovx4SQlV/zPwOn40hZLaDeEkMGSWcPR1p/gj0cHt0DT/s1vXOSznODl
         PQivFzN1j7pfT9Zkymg30XoSvw8n4sq0g3bO9TpOfBpILceEX9E/+G1DWmStxaAYwOps
         SuJr4brFOiSnF0pZmTSqJqOvzSotM8x1N49a/8BtYSfuz6auTMWfqCq6+C8hduZqWuGb
         HpB1layuLunsdn5hGm9nBwSs6vT3SRUQ+sUKpcDTEHsDMQ6ez94qkC7v/e4Fa5XRKYld
         J7uA==
X-Gm-Message-State: AAQBX9fU0Exd/+h3JrkIBw4resy4YyHFVhJjbn6zNOhEv0Zu3VMCZoTA
        tTgHDHxsRIl7lVhPU3ZnOPI=
X-Google-Smtp-Source: AKy350YePDQYa1N9y2BuUl8dviFs+Rie/Ez8I3+ileP5E5mtmm2+o/tvpFGjGeEMun5MMKYY9cbRDw==
X-Received: by 2002:a17:902:e5c7:b0:19e:29bd:8411 with SMTP id u7-20020a170902e5c700b0019e29bd8411mr8488560plf.30.1680722938887;
        Wed, 05 Apr 2023 12:28:58 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id t16-20020a170902b21000b0019a997bca5csm10464562plr.121.2023.04.05.12.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 12:28:58 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Raghul Nanth A <nanth.raghul@gmail.com>, git@vger.kernel.org,
        derrickstolee@github.com
Subject: Re: [GSOC][PATCH v1] diff-index: enable diff-index
References: <20230403190538.361840-1-nanth.raghul@gmail.com>
        <91d3fd23-8120-db65-481a-e9f56017bb04@github.com>
Date:   Wed, 05 Apr 2023 12:28:58 -0700
In-Reply-To: <91d3fd23-8120-db65-481a-e9f56017bb04@github.com> (Victoria Dye's
        message of "Wed, 5 Apr 2023 10:53:20 -0700")
Message-ID: <xmqqwn2quo05.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> Raghul Nanth A wrote:
>> diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
>> index 3242cfe91a..9e74cb22b9 100755
>> --- a/t/perf/p2000-sparse-operations.sh
>> +++ b/t/perf/p2000-sparse-operations.sh
>> @@ -125,5 +125,7 @@ test_perf_on_all git checkout-index -f --all
>>  test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
>>  test_perf_on_all "git rm -f $SPARSE_CONE/a && git checkout HEAD -- $SPARSE_CONE/a"
>>  test_perf_on_all git grep --cached --sparse bogus -- "f2/f1/f1/*"
>> +test_perf_on_all git diff-index HEAD
>> +test_perf_on_all git diff-index HEAD~1
>
> What is the benefit of testing 'diff-index' with 'HEAD' *and* 'HEAD~1'? I
> wouldn't expect internal behavior in the command to change based on the
> revision, so the performance should be nearly identical. I'd much rather see
> 'diff-index --cached' and/or other options & pathspecs exercised.

Good point.  Comparing with HEAD~1 has a chance to compare _more_
paths (i.e. paths changed in the working tree plus paths changed
between the two commits), though it feels a bit too subtle if that
is what these two tests meant.

Testing with pathspec limited comparison, limiting within the cone
of interest or extending to outside the cone, does sound like a good
idea.  "diff-index --cached" to ignore working tree changes is also
an obvious thing we want to see working well.

> Seeing that 'diff-files' needed 'pathspec_needs_expanded_index', it's
> possible that this command needs similar treatment. I'm curious as to
> whether 'diff' needs it as well - the tests in 't1092' don't cover 'diff'
> with pathspecs, so it might be behaving incorrectly. If that's the case, it
> would be nice to see pathspecs handled all in one place
> ('run_diff_index()'?), if possible.

Thanks for a careful review and comment.
