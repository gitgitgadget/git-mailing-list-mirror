Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32C821F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 11:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbfJUL7h (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 07:59:37 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40336 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfJUL7g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 07:59:36 -0400
Received: by mail-qt1-f193.google.com with SMTP id o49so12723355qta.7
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 04:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nPpheCQGQnQeXXq+J3HPutpJhKABT3oJtUj+j6HtxQY=;
        b=XILC2raRsxKSPwHw2XfEtrJ4NQCAK+8Uf8turO9A0766SPzdCsLIs8/ppT6SxLIOqH
         rTfCktyVQ0cPAgdWIQ9XYnEUDiZ+2Kt43kUH1nIpxLYj+EPTKnrEruAVxeG6Cf4WDjNR
         YgVcsrY5yV7DF+39rucp3tuWAaq08vTnXqEowaKfqKs/61rlwNmS5JlnPGxls4CUOU0P
         meusRb2aeHEg7oNEkpr67FbhwUTdCFxERfHqkepDxKd7XT1Za6rIZBCr/48J2lDuNqCQ
         s7gDsmixszOK65IqpOwYPNgc0KBlwimeMhJ+DfxChEZdyh/7WxX6zEBYel0AMD5sVt7H
         MUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nPpheCQGQnQeXXq+J3HPutpJhKABT3oJtUj+j6HtxQY=;
        b=DggMyjz91x58ZjcZEXfUu6eJcNuv1SjYbiUir0rp3xUBG57FjbO0c5gXOZ1rwsWijU
         WnVVY3DQsNdLP7Z5/IYXMo3Prvzt1MoJEcMobBCRGfS94wYjuQVBx20Lk143SYVB1iTk
         qnSpVge7bY6ADSoa1RAJVG4JVe6UhmeaLdGtyH1l6XorAfaJEhNtXXwHKdqaWDsiTMg5
         z9YwoUiUcjSgCIN2hGFtikNrezKX3QbuMDjH1p6efKQ7FiIatvPwTI+jrHSWnmYFyTcu
         9btpD0I4SYRmBtRBIf992oj0ulMx0BuCUqYBwrFgEBJgA3pXCbLpdDSxDbecZsloS+D4
         ctyw==
X-Gm-Message-State: APjAAAVKRZbDpaJwaC+sxubbiShljsol9lzf3ozjppL8Hy+InEr2wcMC
        FtakOjsLXIBVmIDNCIXb1Z0=
X-Google-Smtp-Source: APXvYqxakNXs1TROXdp51FWhfakWM1jDx2ZB/WsazvyIPRak+AHBZyZ/r+T+93ZuCCW25Jq6bIHx/Q==
X-Received: by 2002:ac8:901:: with SMTP id t1mr19910627qth.47.1571659174002;
        Mon, 21 Oct 2019 04:59:34 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4018:ebea:d287:d7b3? ([2001:4898:a800:1010:f14d:ebea:d287:d7b3])
        by smtp.gmail.com with ESMTPSA id s42sm8329344qtk.60.2019.10.21.04.59.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2019 04:59:33 -0700 (PDT)
Subject: Re: [PATCH v4 15/17] sparse-checkout: update working directory
 in-process
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.316.v3.git.gitgitgadget@gmail.com>
 <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
 <9ccec3ca9a1efe038da6d69f076f32cc407bcf9f.1571147765.git.gitgitgadget@gmail.com>
 <20191018202421.GJ29845@szeder.dev> <20191018204032.GK29845@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2dd417e0-2fc6-67ca-68c5-e9afceb7e496@gmail.com>
Date:   Mon, 21 Oct 2019 07:59:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20191018204032.GK29845@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/18/2019 4:40 PM, SZEDER Gábor wrote:
> On Fri, Oct 18, 2019 at 10:24:21PM +0200, SZEDER Gábor wrote:
>> On Tue, Oct 15, 2019 at 01:56:02PM +0000, Derrick Stolee via GitGitGadget wrote:
>>> From: Derrick Stolee <dstolee@microsoft.com>
>>>
>>> The sparse-checkout builtin used 'git read-tree -mu HEAD' to update the
>>> skip-worktree bits in the index and to update the working directory.
>>> This extra process is overly complex, and prone to failure. It also
>>> requires that we write our changes to the sparse-checkout file before
>>> trying to update the index.
>>>
>>> Remove this extra process call by creating a direct call to
>>> unpack_trees() in the same way 'git read-tree -mu HEAD' does. In
>>> addition, provide an in-memory list of patterns so we can avoid
>>> reading from the sparse-checkout file. This allows us to test a
>>> proposed change to the file before writing to it.
>>
>> Starting with this patch there is an issue with locking the index:
>>
>>   $ git init
>>   Initialized empty Git repository in /home/szeder/src/git/tmp/SC/.git/
>>   $ >file
> 
>   $ git add file
> 
> Forgot to copy that command...
> 
>>   $ git commit -m initial
>>   [master (root-commit) 5d80b9c] initial
>>    1 file changed, 0 insertions(+), 0 deletions(-)
>>    create mode 100644 file
>>   $ ls .git/index.lock
>>   ls: cannot access '.git/index.lock': No such file or directory
>>   $ git sparse-checkout set nope
>>   warning: core.sparseCheckout is disabled, so changes to the sparse-checkout file will have no effect
>>   warning: run 'git sparse-checkout init' to enable the sparse-checkout feature
>>   error: Sparse checkout leaves no entry on working directory
>>   fatal: Unable to create '/home/szeder/src/git/tmp/SC/.git/index.lock':
>>   File exists.
>>
>>   Another git process seems to be running in this repository, e.g.
>>   an editor opened by 'git commit'. Please make sure all processes
>>   are terminated then try again. If it still fails, a git process
>>   may have crashed in this repository earlier:
>>   remove the file manually to continue.
>>   $ ls .git/index.lock
>>   ls: cannot access '.git/index.lock': No such file or directory
> 
> I would add that building the previous patch and running the same
> sequence of commands works, in the sense that 'git sparse-checkout
> set' writes the non-existing filename to the 'sparse-checkout' file
> and it prints the same two warnings, and doesn't (seem to) attempt to
> update the working tree and the index.

Thank you for catching this! The issue is that I was not rolling the
index back on this kind of failed update, and then trying to replay
the "old" sparse-checkout hit the existing .git/index.lock file.

Here is the test I added that breaks on the current patch, but
passes when adding a rollback_lock_file() call:

test_expect_success 'revert to old sparse-checkout on empty update' '
	git init empty-test &&
	(
		echo >file &&
		git add file &&
		git commit -m "test" &&
		test_must_fail git sparse-checkout set nothing 2>err &&
		test_i18ngrep "Sparse checkout leaves no entry on working directory" err &&
		test_i18ngrep ! ".git/index.lock" err &&
		git sparse-checkout set file
	)
'

It also has the following problem: because we are setting the
patterns in-memory, this update acts like core.sparseCheckout is
enabled, even when it is not. So, I'm finally convinced that
the 'set' command should enable the config setting if it is
called even without 'init'.

Thanks,
-Stolee

