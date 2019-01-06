Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91FE7211B4
	for <e@80x24.org>; Sun,  6 Jan 2019 14:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfAFOlX (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Jan 2019 09:41:23 -0500
Received: from mail.javad.com ([54.86.164.124]:35606 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbfAFOlX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jan 2019 09:41:23 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id E25B43EA01;
        Sun,  6 Jan 2019 14:41:21 +0000 (UTC)
Authentication-Results: mail.javad.com;
        dkim=pass (1024-bit key; unprotected) header.d=javad.com header.i=@javad.com header.b=Yq3fyvRs;
        dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1546785682;
        bh=rCF4cD099hdtDmipF53c4IJPTDuNPXkvFvIWHao/NEM=; l=1066;
        h=Received:From:To:Subject;
        b=Yq3fyvRsHSIyKtVW9VDQWF94s9vhASUW9rcGtJh7efiyXK/Q0UpTz0O85g4KAcPLm
         MKwCaWjtIMsauaWjwzEcGO9mjFARf+UfgS6HxokgD4octcky+3atWN2NbntzCCVGUL
         g0HyYccPx6YBaN0lwBk56FvwazwDsZQPeL2BRNmI=
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1gg9c8-0005Mu-FD; Sun, 06 Jan 2019 17:41:20 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 3/4] t3502: validate '-m 1' argument is now accepted for non-merge commits
References: <cover.1544762343.git.sorganov@gmail.com>
        <ccfe8ae38301b6ee1b0924fbf00eb5d20242ea5d.1544764226.git.sorganov@gmail.com>
        <20190103172221.GB4673@szeder.dev>
Date:   Sun, 06 Jan 2019 17:41:20 +0300
In-Reply-To: <20190103172221.GB4673@szeder.dev> ("SZEDER \=\?utf-8\?Q\?G\=C3\=A1\?\=
 \=\?utf-8\?Q\?bor\=22's\?\= message of
        "Thu, 3 Jan 2019 18:22:21 +0100")
Message-ID: <87ftu5etm7.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> On Fri, Dec 14, 2018 at 07:53:51AM +0300, Sergey Organov wrote:
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>

[...]

>>  
>> @@ -84,12 +84,12 @@ test_expect_success 'cherry pick a merge relative to nonexistent parent should f
>>  
>>  '
>>  
>> -test_expect_success 'revert a non-merge with -m should fail' '
>> +test_expect_success 'revert explicit first parent of a non-merge' '
>>  
>>  	git reset --hard &&
>>  	git checkout c^0 &&
>> -	test_must_fail git revert -m 1 b &&
>> -	git diff --exit-code c
>> +	git revert -m 1 b &&
>> +	git diff --exit-code a
>
> You need disambiguaion here, otherwise this test fails on
> case-insensitive file systems:
>
>   ++git diff --exit-code a
>   fatal: ambiguous argument 'a': both revision and filename
>   Use '--' to separate paths from revisions, like this:
>   'git <command> [<revision>...] -- [<file>...]'
>   error: last command exited with $?=128
>   not ok 8 - revert explicit first parent of a non-merge

Good catch, -- thanks a lot!

-- Sergey
