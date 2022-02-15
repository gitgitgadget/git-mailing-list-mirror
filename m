Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B522FC433EF
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 15:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239549AbiBOPDU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 10:03:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238083AbiBOPDT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 10:03:19 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2832D1EAEE
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:03:09 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id l5so923497oii.13
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LLByN5Pmajk0igACSuvPun2Iwx0O925FsGdQpHP7kiY=;
        b=cwIw8Wer+B1zmKMfwifbUOQu9m2arndevQeuBei+34gBoppvrirzsp6JJUYWGb2ujU
         9/gvSB6XcxdHPPmDjlwJ29nhr9QfKmArXXo9QENV2v+EcBGPTK/Z+5xvCK5gJn7pEMDF
         MHitOVsM7kcxAaih/JPixdl8wccddCk6fyoNEPRnbXHErR/VChcVN02oa5KIF+WOAV/z
         FEFY29rnGZJ6F7jI4N1f7CI2qpVW2vKXUtwaSUrY9Kz7qCOqOCe0bIMP2lEKgraEFqId
         rRKODFWVZgCs009TG5FUhutQOhWVNtMMW1ygzQrYJO2r1nRQyUGJ+e4MYmDtHkvAjxvr
         Hnqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LLByN5Pmajk0igACSuvPun2Iwx0O925FsGdQpHP7kiY=;
        b=VE6qU0cEeIkKonGbFfNmX1qktyA4Gm0fMrc4AxPdL886N6eeuomAcBx6+IIK48ZjrV
         C69dFM4MPnosDG4mCAJvzznwv9GIli1gcg/IPoHx+8SX9dzxxZvRGeoZgRtkrQYaDffJ
         +zHOULEvu2Dhxzmcb/BjJK/u8Y7yiuIMIpQUBwb6Pn9A3i8sJlC0PN0jAE7frHnWROVJ
         BDOB7UrvikF3ybFlBfwC/kxg5a5UEbxyDh53G9aJbLKDKGpujrcMR5OgaTqijuYrCUet
         RLJ01oVsGEHHLDaKxaevztKX2JO27qh9wuF4NMI4+YfAP4ccLJMPPY8QVC8c1Vdwc9i3
         KVUQ==
X-Gm-Message-State: AOAM533DCtFmWjF4NEENtfcswYe+1LUe7IG4+pVb6L04f5LezupFwhqw
        rh9d7KdJrYwJDZUoMFtedKUKsth51ex8
X-Google-Smtp-Source: ABdhPJxAzTVTPvGQdfz+ZQnPH0Ma68dBkRJ9prZb5SvzKW2dcTylR1OciXRAXr/ABvRdrb/wDDTGMw==
X-Received: by 2002:a05:6808:1999:: with SMTP id bj25mr1771353oib.23.1644937388148;
        Tue, 15 Feb 2022 07:03:08 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id t21sm13847635otj.26.2022.02.15.07.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 07:03:07 -0800 (PST)
Message-ID: <2c3b4204-5560-7031-c05e-3b709c85d753@github.com>
Date:   Tue, 15 Feb 2022 10:03:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 4/7] sparse-checkout: error or warn when given individual
 files
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
References: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
 <5e27cad17a7080170f476684610391bd56024f36.1644712798.git.gitgitgadget@gmail.com>
 <72d39c4a-fd16-846c-2a5e-8b9ba0c1ab07@github.com>
 <CABPp-BE8aG3R4ASngqwyvRemp5WW=O0UWWSTesJ2hoch_av_kQ@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CABPp-BE8aG3R4ASngqwyvRemp5WW=O0UWWSTesJ2hoch_av_kQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/14/2022 11:17 PM, Elijah Newren wrote:
> On Mon, Feb 14, 2022 at 7:56 AM Derrick Stolee <derrickstolee@github.com> wrote:
>>
>> On 2/12/2022 7:39 PM, Elijah Newren via GitGitGadget wrote:
>>> From: Elijah Newren <newren@gmail.com>
>>>
>>> The set and add subcommands accept multiple positional arguments.
>>> The meaning of these arguments differs slightly in the two modes:
>>>
>>> Cone mode only accepts directories.  If given a file, it would
>>> previously treat it as a directory, causing not just the file itself to
>>> be included but all sibling files as well -- likely against users'
>>> expectations.  Throw an error if the specified path is a file in the
>>> index.  Provide a --skip-checks argument to allow users to override
>>> (e.g. for the case when the given path IS a directory on another
>>> branch).
>>
>> I agree that this is likely to be an improvement for users. The
>> sparse-checkout builtin isn't integrated with the sparse index
>> yet. At least not integrated upstream: we have commits in microsoft/git
>> that we plan to send when other things in flight are merged. This
>> change likely introduces a new opportunity for the index to expand,
>> so I will keep that in mind when upstreaming.
> 
> Actually, I thought about that during development, and my presumption
> was that we would not expand the index.  We've survived a few years
> without reporting any argument errors to the user and folks seem to
> usually get things right, so while I think it adds value to report on
> likely errors, I don't think it's important for us to catch and warn
> on every potential misuse.  I think the probable errors are the ones
> where they specify a <file> that exists in both the working tree and
> index.  The remaining ones are less probable, and also possibly quite
> expensive to catch.  I'm not sure it's worth the cost to try to report
> those.

Since we start with only the files at root, if a user specifies a
directory at least two levels deep, then we don't have enough information
in the index to find that directory without parsing trees. Doing a simple
index_name_pos() call would expand the sparse index to a full one.

The checks of this kind typically follow this pattern:

	int pos = index_name_pos(index, name, strlen(name));
	if (pos >= 0)
		/* we have 'name' in the index! */
	else
		/* we don't have 'name' in the index! */

(Of course, there is some special logic for directories to see if they
exist, since 'pos' is a position within the list of files, unless it
points to a sparse directory entry.)

A different method that checks only for existence could find a sparse
directory and then search trees for the contained path. Returning a
boolean answer provides a mechanism for not expanding the index.

But we are getting sidetracked. I'll worry about this later. The
important thing is that we can solve this problem, so it shouldn't block
your feature.

>>> Non-cone mode accepts general gitignore patterns.  However, it has an
>>> O(N*M) performance baked into its design, where all N index files must
>>> be matched against all M sparse-checkout patterns with EVERY call to
>>> unpack_trees() that updates the working tree.  As such, it is important
>>> to keep the number of patterns small, and thus we should warn users to
>>> prefer passing directories and more generic glob patterns to get the
>>> paths they want instead of listing each individual file.  (The
>>> --skip-checks argument can also be used to bypass this warning.)  Also,
>>> even when users do want to specify individual files, they will often
>>> want to do so by providing a leading '/' (to avoid selecting the same
>>> filename in all subdirectories), in which case this error message would
>>> never trigger anyway.
>>
>> I think the case of "I want only one file from this directory" and "I
>> want files with the given name pattern" are the main reason to still
>> use non-cone-mode. Users with this need usually have a directory full
>> of large files, and they choose which of those large files they need
>> using sparse-checkout. The repository reorganization required to use
>> cone mode for this use is perhaps too great (or they haven't thought
>> about doing it). For this reason, I would prefer that we do not do
>> these checks when not in cone mode.
> 
> If they "only want one file from this directory", isn't the correct
> way to specify that by mentioning the path with a leading slash?
> Otherwise, they'd potentially grab files with similar names from many
> directories, right?  So, even in that usecase, we should still error
> out if they specify a <filename> rather than /<filename>.  Perhaps my
> reasoning should lead with that and I should fix up the warning
> message a bit, but I still think we should probably give a warning
> even for those who are explicitly wanting the usecase you mention.

Checking for the leading slash can be a big help to make sure users
are getting the matches they expect.

> Also, note this is a warning and not an error -- and the warning can
> be suppressed with --skip-checks.

I want to avoid surprising users with new warnings for things they
have been doing for years, especially if these tasks run as part of
a script that checks stderr output as a failure condition.

>>> +test_expect_success 'by default, cone mode will error out when passed files' '
>>> +     git -C repo sparse-checkout reapply --cone &&
>>> +     test_must_fail git -C repo sparse-checkout add .gitignore 2>error &&
>>> +
>>> +     grep ".gitignore.*is not a directory" error
>>> +'
>>> +
>>> +test_expect_success 'by default, non-cone mode will warn on individual files' '
>>> +     git -C repo sparse-checkout reapply --no-cone &&
>>> +     git -C repo sparse-checkout add .gitignore 2>warning &&
>>> +
>>> +     grep "passing directories or less specific patterns is recommended" warning
>>> +'
>>
>> So I would expect this second test to have
>>
>>         test_must_be_empty warning
>>
>> to show that no warning occurs when specifying a file in non-cone-mode.
> 
> or perhaps
> 
> grep "please specify a leading slash to select a single file" warning
> 
> ?

Right. Whatever matches the behavior we land on.

Thanks,
-Stolee
