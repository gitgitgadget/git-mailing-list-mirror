Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84297C77B78
	for <git@archiver.kernel.org>; Wed,  3 May 2023 16:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjECQhn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 12:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjECQhl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 12:37:41 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0204EEC
        for <git@vger.kernel.org>; Wed,  3 May 2023 09:37:40 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ab0c697c2bso22001705ad.1
        for <git@vger.kernel.org>; Wed, 03 May 2023 09:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1683131860; x=1685723860;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=giY0NG3M9JyprZ5SbzjAC9sGk9zZhMkpDKBFbKUoIL0=;
        b=aKxcE3Xgvfi8OmHv5L/o2BrjmicFg4JlSbls2MnKYKIJpoVxw13xMdgiEmneukQB4Z
         rpfmDPoj9vPLJw9yElhCTettxe+pdyF4+j1rxbKqB0NJ6bd4GEZ/8iKfEd7BpVdAUImR
         VW+4ojHuBpMXbuBdc8G5B3Db+PQHtI0vKs6rh9oA/8Brgq55S2o/dwZNIAf/gSua/El7
         CFprDzeyO6/OC9HLIcjwqcr6O9hWaCazjpJzmuuX/nLiJFFKh9BquouZf4+1aMWB3zLS
         WJFwPOt+OCm/2kOGJHeqwMG0kVFfWxwrFBtJ4gu5dOdDjlxnnVWoTohw0UuOSvfogooC
         N97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683131860; x=1685723860;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=giY0NG3M9JyprZ5SbzjAC9sGk9zZhMkpDKBFbKUoIL0=;
        b=mGqfBtug9Ldq5BENcf2ewFUi3b1bLhIy2C1q3pp8t7lJ57qy7UiwEBuMefIs3/j2RV
         fcLrgXjpWzXmcxArevfsPvYih1EOb57Q4bDJD7Sr5M7x5LW/Q1LhQIciGwL44MB2T2L7
         epzG5FhwrUda1rLsUbZWootDZfqgRnwtJ9Is0ooIN427OoQQQpNmmC74lgJALEw9WuNj
         r1dPX+5EYAsgHJB/rPv79OHrXcShO/fjcBbwT1DjyeC9M0HlX4/m9OpIreZxqR4qkt+x
         dKQsW1KDcieDagyAgao2QJMERlFSHMCtmu9eZ5PYPCvvb2fmOKUiQbeMRidyXvv06r/2
         SPtA==
X-Gm-Message-State: AC+VfDwURWuAGEM6bhgDEjjIkQbLyV3AHMiAwD0krepvr6lffiGfvDed
        ugl99subnsZ5mKyeHB+djmzOuDwesQsTBBqMrQ==
X-Google-Smtp-Source: ACHHUZ7/+fQB+II+eZQJhrG19v2fyLXipc75FGWYSNuiK5ZHPA7eWO0ZZgZozah2bsHHtxrcYouXGw==
X-Received: by 2002:a17:902:7889:b0:1a9:b637:4332 with SMTP id q9-20020a170902788900b001a9b6374332mr484704pll.69.1683131859719;
        Wed, 03 May 2023 09:37:39 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id t8-20020a170902e84800b001aaefe48b93sm6447046plg.295.2023.05.03.09.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 09:37:39 -0700 (PDT)
Message-ID: <2fa835b8-1c9b-67d3-aa4a-70a978b5f20d@github.com>
Date:   Wed, 3 May 2023 09:37:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH v9 1/2] t1092: add tests for `git diff-files`
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Shuqi Liang <cheskaqiqi@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com
References: <20230423010721.1402736-1-cheskaqiqi@gmail.com>
 <20230502172335.478312-1-cheskaqiqi@gmail.com>
 <20230502172335.478312-2-cheskaqiqi@gmail.com> <xmqqjzxqzgbi.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqqjzxqzgbi.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Shuqi Liang <cheskaqiqi@gmail.com> writes:
> 
>> +test_expect_success 'diff-files with pathspec outside sparse definition' '
>> +	init_repos &&
>> +
>> +	test_sparse_match test_must_fail git diff-files folder2/a &&
> 
> In "sparse" directories at this point of test, "folder2" is outside
> the cone(s) of interest and is not instantiated.  The reason why
> the command fails is because the command line parsing that is
> generic to all users of the revision machinery requires you to have
> a disambiguating double-dash before such a pathspec that tries to
> match a path that does not exist in the working tree and is not
> specific to "diff-files".
> 
> I wonder how interesting and useful this test is.  Without
> accompanying test that uses disambiguating double-dash properly,
> e.g. "git diff-files -- folder2", I doubt it is very much useful.

I agree, this test isn't helpful as-is. With the '--', 'diff-files'
shouldn't fail, so in the interest of avoiding unexpected regressions in the
future (masked by 'test_must_fail'), I think this test should be updated as
you described. 

>> +	# file present on-disk without modifications
>> +	# use `--stat` to ignore file creation time differences in
>> +	# unrefreshed index
>> +	test_all_match git diff-files --stat &&
>> +	test_all_match git diff-files --stat folder1/a &&
>> +	test_all_match git diff-files --stat "folder*/a" &&
> 
> Because in all three repositories, "folder1/a" exists in the working
> tree, the "you need to disambiguate" error like the first test
> (whose utility I questioned) would not trigger.
> 
> What does this demonstrate, though?  That instantiating a file on
> the working tree, even outside the cone(s) of interest in a sparsely
> checked out working tree, makes it part of the interesting set
> automatically?  As there is no difference between the indexed
> contents and what is in the working tree, we cannot tell from this
> test if that is the case (not a complaint, just an observation).

This was meant [1] to check whether there are any issues expanding the index
(specifically, the 'folder1/' sparse directory) before comparing to the 
now-on-disk 'folder1/a'. 

However...

[1] https://lore.kernel.org/git/b537d855-edb7-4f67-de08-d651868247a5@github.com/

> 
> But ...
> 
>> +	# file present on-disk with modifications
>> +	run_on_all ../edit-contents folder1/a &&
>> +	test_all_match git diff-files &&
>> +	test_all_match git diff-files folder1/a &&
>> +	test_all_match git diff-files "folder*/a"
> 
> ... it is shown by doing the same test with modified contents?
> 
> For consistency with the earlier "the same contents" test, we should
> use "--stat" here, too.  Or even "--stat -p".
> 
> Alternatively, we could refresh the index before running diff-files
> (here and also before the earlier "the same contents" test), I
> guess.

...to your point, we probably don't need both the "unmodified folder1/a
diff-files" *and* "modified folder1/a diff-files" tests. In fact, the empty
output of "unmodified folder1/a" could be caused by either "this file is
unmodified" or "this file isn't in the index", so the test might pass even
if there's an issue with index expansion. That isn't a problem in the
"modified folder1/a" case, since we're expecting to see - and comparing the
contents of - a diff.

I think we can drop the 'diff-files --stat' tests and go straight to the
'run_on_all ../edit-contents folder1/a'. Adding '--' here to disambiguate
the pathspecs might be nice as well.

> 
>> +'
>> +
>>  test_done
> 
> Thanks.

Thanks for the detailed review, apologies for missing these issues earlier.

