Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B484CC74A5B
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 17:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjCWR0P (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 13:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjCWR0O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 13:26:14 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0031E36095
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 10:25:42 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id a16so17761609pjs.4
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 10:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1679592342;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7BIVPlaL4j83CTfjSGoR0TZWMX8l2Iu54h9oGKHDJxs=;
        b=V4OO3MvEFnOpRlu/TFfIkTZlBIQASBTG0FxcxSAPJDp5tS2FF7fyAzdNHIEm0c/rGy
         CgQcLE2hEV+CLDmVKuexyZQ1dYpkP1AamBACihV+/hJvX7zbPwO+lMbWLksQiHhUqnEo
         /RXHoTN5uEmahjbYqfBVJQv9J5OCGmILb7lQqrWk/dsig3bWOglG0tYboHSx6p+6G8HI
         /bWRrTYy6oUFSaHXRZFA1x5WTbRzjkb+z4WYlguwQDupMhP+QTY5Zmv2y793ha25AfEb
         Z4xZ9G/b9Vt6caA2sA9A9ktYknyNEthRBpGD9ua2G0mwNIRhzvQ1JGsVUowzZgCEvTH7
         QN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679592342;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7BIVPlaL4j83CTfjSGoR0TZWMX8l2Iu54h9oGKHDJxs=;
        b=RYnEKzXDqhh6RhoPXKeTnuf4f/H30GACmaOMiO/+J3AcIowBmot27bDTfRSl4RfqJ1
         SYiQMYW7TSvrVPNsudQFQHldrgJRPprO4WtJmmWMksnLh/DEvRR1yFqiL0aytYgRQTUm
         toMVOBTK5W58fg4eIcsdAnUoxS9UmZkeYWbRlTvLh5HKjTxkP/jHDFy0B9CKUkr029eN
         zxugWZpi6d5YSCBILFkl5FpeXmYbLi5U7mUDLJ8GyZ+1Fzb6tsTIvTsIbfzX3VVD2fUK
         EFiI10LzlG9xLKPysS0P7x8yNYG1Pu2Phtxd2LpjAGD+h47+wm5VhjIuzweo7to5crmO
         ht4g==
X-Gm-Message-State: AO0yUKV3ekp/H+4wH+ROrd9YnfZ6KEtGmRBmmoyvO/w50RKxVaTqn7rY
        S5BAQl3kiRSGvSir+zacH1TG
X-Google-Smtp-Source: AK7set8mAurHDUhvDBn7h/R2Fj9nJ/V2+bQwv3llPLEiGnMWtjOez0m9/TZM7JqCoW3bc5E1CnO9fw==
X-Received: by 2002:a17:902:f691:b0:1a1:be45:9857 with SMTP id l17-20020a170902f69100b001a1be459857mr9226184plg.1.1679592342134;
        Thu, 23 Mar 2023 10:25:42 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id j3-20020a170902c3c300b001a072be70desm12607546plj.41.2023.03.23.10.25.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 10:25:41 -0700 (PDT)
Message-ID: <29eb319d-baf0-22d5-12b4-3e8ee7323050@github.com>
Date:   Thu, 23 Mar 2023 10:25:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v7 0/2] diff-files: integrate with sparse index
Content-Language: en-US
To:     Shuqi Liang <cheskaqiqi@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>
References: <20230320205241.105476-1-cheskaqiqi@gmail.com>
 <20230322161820.3609-1-cheskaqiqi@gmail.com> <xmqqilesbbph.fsf@gitster.g>
 <CAMO4yUFshQ_bP3gXeZhfHQ3OevC+_3qKwa-iy2nNGScvRouu6Q@mail.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <CAMO4yUFshQ_bP3gXeZhfHQ3OevC+_3qKwa-iy2nNGScvRouu6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang wrote:
> On Wed, Mar 22, 2023 at 7:36 PM Junio C Hamano <gitster@pobox.com> wrote:
> 
>>> 3. Use `--stat` to ignore file creation time differences in unrefreshed
>>> index.
>>
>> I am curious about this one.  Why is this a preferred solution over
>> say "run 'update-index --refresh' before running diff-files"?
>>
>> Note that this is merely "I am curious", not "I think it is wrong".
> 
> Hi Junio
> 
> Thank you for your question, it has prompted me to consider the matter
> further =)  I think both solutions, using git diff-files --stat and using git
> update-index --refresh before git diff-files, can produce the same output but
> in different ways.

While they'll (ideally) give the same user-facing result, there is a
difference in how they exercise 'diff-files' because of how 'update-index
--refresh' will affect SKIP_WORKTREE and sparse directories.

Using the same scenario you've set up for your test, suppose I start with a
fresh copy of the 't1092' repo. In the 'sparse-index' repo copy, 'folder1/'
will be a sparse directory:

$ git ls-files -t --sparse folder1/
S folder1/

(note: "S" indicates that SKIP_WORKTREE is applied to the entry)

Now suppose I copy 'a' into 'folder1/' and run 'update-index --refresh'
then 'ls-files' again:

$ git update-index --refresh
$ git ls-files -t --sparse folder1/
S folder1/0/
H folder1/a

(note: "H" indicates that 'folder1/a' does not have SKIP_WORKTREE applied)

The sparse directory has been expanded and SKIP_WORKTREE has been removed
from the file that's now present on-disk. This was an intentional "safety"
measure added in [1] to address the growing volume of bugs and complexities
in scenarios where SKIP_WORKTREE files existed on disk.

Ultimately, the main difference between this test with & without
'update-index' is who applies those index corrections when initially reading
the index: 'update-index' or 'diff-files'. I lean towards the latter because
the former is tested (almost identically) in 'update-index modify outside
sparse definition' earlier in 't1092'.

[1] https://lore.kernel.org/git/pull.1114.v2.git.1642175983.gitgitgadget@gmail.com/

> 
> When the index file is not up-to-date, git diff-files may show differences
> between the working directory and the index that are caused by file creation
> time differences, rather than actual changes to the file contents. By using git
> diff-files --stat, which ignores file creation time differences.

More or less, yes. Internally, 'diff-files' will "see" the file creation
differences, but the '--stat' format doesn't print them.

> 
> While 'git update-index --refresh' updates the index file to match the contents
> of the working tree. By running this command before git diff-files, we can
> ensure that the index file is up-to-date and that the output of git diff-files
> accurately reflects the differences between the working directory and the index.

This isn't quite true - 'update-index' only updates the *contents* of index
entries (or, colloquially, "stage them for commit") for files explicitly
provided as arguments. Separately, though, '--refresh' updates *all* index
entries' cached 'stat' information. 

Going a bit deeper: with no arguments, 'update-index' will read the index,
do nothing to it, then write it only if something has changed. In almost all
cases, reading the index doesn't cause any changes to it, making it a no-op.
However, the removal of SKIP_WORKTREE is done on read (including a refresh
of the entry's stat information), so a even plain 'update-index' *without*
'--refresh' would write a modified index to disk. In your test, that means:

	run_on_sparse mkdir -p folder1 &&
	run_on_sparse cp a folder1/a &&
	run_on_all git update-index &&
	test_all_match git diff-files

would get you the same result as:

	run_on_sparse mkdir -p folder1 &&
	run_on_sparse cp a folder1/a &&
	run_on_all git update-index --refresh &&
	test_all_match git diff-files

> 
> Maybe using git update-index --refresh would be more direct and
> straightforward solution.
> 
> (Hi Victoria, do you have any comments?  =)

I hope the above explanation is helpful. I still think '--stat' is the best
way to test this case, but I'm interested to hear your/others' thoughts on
the matter given the additional context.

> 
> 
> Thanks
> Shuqi

