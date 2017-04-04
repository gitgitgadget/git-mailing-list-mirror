Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26E591FAFB
	for <e@80x24.org>; Tue,  4 Apr 2017 02:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752560AbdDDCPg (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 22:15:36 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34126 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752410AbdDDCPf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 22:15:35 -0400
Received: by mail-pg0-f53.google.com with SMTP id 21so137737043pgg.1
        for <git@vger.kernel.org>; Mon, 03 Apr 2017 19:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=serato.com; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=bO/cDHmCKKMRWhtVG3+BevbgnU1ysTGXzUyW67E6mP4=;
        b=HZ5kTW4pU/wwUXXzpGqzNt94QIZWx9AY/zodhv2f9DajuJeiIpLHPuNEx+ZW2fJao9
         iRrOsBAxClQLsJvbIeqhT34Eck9tk8QDGWIdpcBM5CDdmX6g31bObyynYT6rp1X2xnB3
         Cek8t70/bjwrxZ0FVwjMov6O2eYryrHRGyxBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=bO/cDHmCKKMRWhtVG3+BevbgnU1ysTGXzUyW67E6mP4=;
        b=HniMVjbeinq7dJlps8FDpWK8mMADGYZWPJakXIy3R0Ur3hXEv/decGKmUMyB66fQKI
         4DtCZ46ZQnEcOpGods9If4X4tCCuojlGktR/Bjn4qRgdFvYa4hlhVaZDwhhCC1P0m9Kc
         dEf3jihhGB1y6wtGfGb5Vx39kdXwPyBdf/k4S3mdEeDqIHYt6XHbQBqL0wDcqQAc1rYf
         lQjUJOLfS7YqsPFkFsfrKEv8dSUUIp8hW4uQmo++Rf1Q8DMcQh9GdDNpLe0u0TPtnhtR
         E6dmE2paTcdp7SqEF9CLZPVviuOWdt5eejOnLf37YsnV5lkeYvHJV2be9LWKE/7HcVfn
         NSJQ==
X-Gm-Message-State: AFeK/H2gMg1Hu7fPLWAKgQK5GPqmwY8TgKWG2ouylN24oV8HTMK/kJt611PyKnfZY20eigf9
X-Received: by 10.98.156.23 with SMTP id f23mr20066618pfe.3.1491272134308;
        Mon, 03 Apr 2017 19:15:34 -0700 (PDT)
Received: from [10.200.28.236] ([114.23.233.11])
        by smtp.gmail.com with ESMTPSA id w65sm6775770pfw.67.2017.04.03.19.15.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Apr 2017 19:15:33 -0700 (PDT)
Subject: Re: Bug? git submodule update --reference doesn't use the referenced
 repository
To:     Stefan Beller <sbeller@google.com>
References: <35343b75-0aa7-3477-888b-3af5024ae7dd@serato.com>
 <CAGZ79kYKfKcVcV9ddRHNc-aQ7RpN4ToDs9i=voqXcKTm79j3KA@mail.gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Maxime Viargues <maxime.viargues@serato.com>
Message-ID: <f7c100e2-da76-57e3-1fbc-f71fd57f26eb@serato.com>
Date:   Tue, 4 Apr 2017 14:15:30 +1200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kYKfKcVcV9ddRHNc-aQ7RpN4ToDs9i=voqXcKTm79j3KA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04-Apr-17 4:32 AM, Stefan Beller wrote:
> On Sun, Apr 2, 2017 at 8:13 PM, Maxime Viargues
> <maxime.viargues@serato.com> wrote:
>> Hi there,
>>
>> I have been trying to use the --reference option to clone a big repository
>> using a local copy, but I can't manage to make it work using sub-module
>> update. I believe this is a bug, unless I missed something.
>> I am on Windows, Git 2.12.0
> which is new enough, that the new --reference code is in. :)
>
>> So the problem is as follow:
>> - I have got a repository with multiple sub-modules, say
>>      main
>>          lib1
>>              sub-module1.git
>>          lib2
>>              sub-module2.git
>> - The original repositories are in GitHub, which makes it slow
>> - I have done a normal git clone of the entire repository (not bare) and put
>> it on a file server, say \\fileserver\ref_repo\
>> (Note that the problem also happens with local copy)
>>
>> So if I do a clone to get the repo and all the submodules with...
>> git clone --reference-if-able \\fileserver\ref-repo --recursive
>> git@github.com:company/main
>> ...then it all works, all the sub-modules get cloned and the it's fast.
> great. :)
>
>> Now in my case I am working with Jenkins jobs and I need to first do a
>> clone, and then get the sub-modules, but if I do...
>> git clone --reference-if-able \\fileserver\ref-repo
>> git@github.com:company/main (so non-recursive)
>> cd main
>> git submodule update --init --reference \\fileserver\ref-repo
>> ... then this takes ages, as it would normally do without the use of
>> --reference. I suspect it's not actually using it.
> So to confirm your suspicion, can you run
>
>    GIT_TRACE=1 git clone ...
>    cd main && GIT_TRACE=1 git submodule update ...
>
> to see which child processes are spawned to deal with the submodules?
> Also to confirm, it is the "submodule update" that is taking so long for you?
Yes I confirm it's the "submodule update" which is taking a long time. 
The clone with the reference is definitely working.

Running git submodule update with  "GIT_TRACE=1", here is a snippet of 
what I get:

10:14:44.924684 git.c:596               trace: exec: 'git-submodule' 
'update' '--init' '--reference' 
'\\fileserver\Builds\reference_repos\main-repo'
10:14:44.925684 run-command.c:369       trace: run_command: 
'git-submodule' 'update' '--init' '--reference' 
'\\fileserver\Builds\reference_repos\main-repo'
10:14:45.146488 git.c:596               trace: exec: 
'git-sh-i18n--envsubst' '--variables' 'usage: $dashless $USAGE'
10:14:45.146488 run-command.c:369       trace: run_command: 
'git-sh-i18n--envsubst' '--variables' 'usage: $dashless $USAGE'
10:14:45.231548 git.c:596               trace: exec: 
'git-sh-i18n--envsubst' 'usage: $dashless $USAGE'
10:14:45.231548 run-command.c:369       trace: run_command: 
'git-sh-i18n--envsubst' 'usage: $dashless $USAGE'
10:14:45.357059 git.c:371               trace: built-in: git 'rev-parse' 
'--git-dir'
10:14:45.427806 git.c:371               trace: built-in: git 'rev-parse' 
'--git-path' 'objects'
10:14:45.487348 git.c:371               trace: built-in: git 'rev-parse' 
'-q' '--git-dir'
10:14:45.593794 git.c:371               trace: built-in: git 'rev-parse' 
'--show-prefix'
10:14:45.643162 git.c:371               trace: built-in: git 'rev-parse' 
'--show-toplevel'
10:14:45.700201 git.c:371               trace: built-in: git 
'submodule--helper' 'init'
10:14:45.986024 git.c:371               trace: built-in: git 
'submodule--helper' 'update-clone' 
'--reference=\\fileserver\Builds\reference_repos\main-repo'
10:14:45.988024 run-command.c:1155      run_processes_parallel: 
preparing to run up to 1 tasks
10:14:45.988024 run-command.c:369       trace: run_command: 
'submodule--helper' 'clone' '--path' 'lib1/lib1_source' '--name' 
'lib1/lib1_source' '--url' 'git@github.com:company/main-repo-lib1.git' 
'--reference' '\\fileserver\Builds\reference_repos\main-repo'
10:15:06.204872 run-command.c:369       trace: run_command: 
'submodule--helper' 'clone' '--path' 'lib2/lib2_source' '--name' 
'lib2/lib2_source' '--url' 'git@github.com:company/main-repo-lib2.git' 
'--reference' '\\fileserver\Builds\reference_repos\main-repo'
10:14:46.025555 git.c:371               trace: built-in: git 
'submodule--helper' 'clone' '--path' 'lib1/lib1_source' '--name' 
'lib1/lib1_source' '--url' 'git@github.com:company/main-repo-lib1.git' 
'--reference' '\\fileserver\Builds\reference_repos\main-repo'
10:14:46.027555 run-command.c:369       trace: run_command: 'clone' 
'--no-checkout' '--reference' 
'\\fileserver\Builds\reference_repos\main-repo' '--separate-git-dir' 
'D:/tmp2/git_clone_tests/main-repo/.git/modules/lib1/lib1_source' 
'git@github.com:company/main-repo-lib1.git' 
'D:/tmp2/git_clone_tests/main-repo/lib1/lib1_source'
10:14:46.061305 git.c:371               trace: built-in: git 'clone' 
'--no-checkout' '--reference' 
'\\fileserver\Builds\reference_repos\main-repo' '--separate-git-dir' 
'D:/tmp2/git_clone_tests/main-repo/.git/modules/lib1/lib1_source' 
'git@github.com:company/main-repo-lib1.git' 
'D:/tmp2/git_clone_tests/main-repo/lib1/lib1_source'
10:14:46.115339 run-command.c:369       trace: run_command: 'ssh' 
'git@github.com' 'git-upload-pack '\''company/main-repo-lib1.git'\'''
Cloning into 'D:/tmp2/git_clone_tests/main-repo/lib1/lib1_source'...
10:14:48.962590 run-command.c:369       trace: run_command: 
'git-upload-pack '\''//fileserver/Builds/reference_repos/main-repo/.git'\'''
10:14:49.103908 run-command.c:369       trace: run_command: 
'git-upload-pack '\''D:/GitHub/main-repo/.git'\'''
10:14:49.184477 run-command.c:369       trace: run_command: 
'git-upload-pack '\''//fileserver/Builds/reference_repos/main-repo/.git'\'''
10:14:49.322365 run-command.c:369       trace: run_command: 
'git-upload-pack '\''D:/GitHub/main-repo/.git'\'''
10:14:52.281044 run-command.c:369       trace: run_command: 'index-pack' 
'--stdin' '--fix-thin' '--keep=fetch-pack 5764 on WIN-1198' 
'--check-self-contained-and-connected'
10:14:52.315569 git.c:371               trace: built-in: git 
'index-pack' '--stdin' '--fix-thin' '--keep=fetch-pack 5764 on WIN-1198' 
'--check-self-contained-and-connected'
10:15:06.119340 run-command.c:369       trace: run_command: 'rev-list' 
'--objects' '--stdin' '--not' '--all' '--quiet'
10:15:06.170876 git.c:371               trace: built-in: git 'rev-list' 
'--objects' '--stdin' '--not' '--all' '--quiet'
10:15:13.072336 run-command.c:369       trace: run_command: 
'submodule--helper' 'clone' '--path' 'lib3/lib3_source' '--name' 
'lib3/lib3_source' '--url' 'git@github.com:company/main-repo-lib3' 
'--reference' '\\fileserver\Builds\reference_repos\main-repo'
10:15:06.238893 git.c:371               trace: built-in: git 
'submodule--helper' 'clone' '--path' 'lib2/lib2_source' '--name' 
'lib2/lib2_source' '--url' 'git@github.com:company/main-repo-lib2.git' 
'--reference' '\\fileserver\Builds\reference_repos\main-repo'
10:15:06.239894 run-command.c:369       trace: run_command: 'clone' 
'--no-checkout' '--reference' 
'\\fileserver\Builds\reference_repos\main-repo' '--separate-git-dir' 
'D:/tmp2/git_clone_tests/main-repo/.git/modules/lib2/lib2_source' 
'git@github.com:company/main-repo-lib2.git' 
'D:/tmp2/git_clone_tests/main-repo/lib2/lib2_source'
10:15:06.273418 git.c:371               trace: built-in: git 'clone' 
'--no-checkout' '--reference' 
'\\fileserver\Builds\reference_repos\main-repo' '--separate-git-dir' 
'D:/tmp2/git_clone_tests/main-repo/.git/modules/lib2/lib2_source' 
'git@github.com:company/main-repo-lib2.git' 
'D:/tmp2/git_clone_tests/main-repo/lib2/lib2_source'
10:15:06.309945 run-command.c:369       trace: run_command: 'ssh' 
'git@github.com' 'git-upload-pack '\''company/main-repo-lib2.git'\'''
Cloning into 'D:/tmp2/git_clone_tests/main-repo/lib2/lib2_source'...
10:15:08.210491 run-command.c:369       trace: run_command: 
'git-upload-pack '\''//fileserver/Builds/reference_repos/main-repo/.git'\'''
10:15:08.370561 run-command.c:369       trace: run_command: 
'git-upload-pack '\''D:/GitHub/main-repo/.git'\'''
10:15:08.451234 run-command.c:369       trace: run_command: 
'git-upload-pack '\''//fileserver/Builds/reference_repos/main-repo/.git'\'''
10:15:08.589129 run-command.c:369       trace: run_command: 
'git-upload-pack '\''D:/GitHub/main-repo/.git'\'''
10:15:11.533328 run-command.c:369       trace: run_command: 'index-pack' 
'--stdin' '--fix-thin' '--keep=fetch-pack 9308 on WIN-1198' 
'--check-self-contained-and-connected'
10:15:11.575862 git.c:371               trace: built-in: git 
'index-pack' '--stdin' '--fix-thin' '--keep=fetch-pack 9308 on WIN-1198' 
'--check-self-contained-and-connected'
10:15:12.986776 run-command.c:369       trace: run_command: 'rev-list' 
'--objects' '--stdin' '--not' '--all' '--quiet'
10:15:13.039314 git.c:371               trace: built-in: git 'rev-list' 
'--objects' '--stdin' '--not' '--all' '--quiet'
10:15:49.633796 run-command.c:369       trace: run_command: 
'submodule--helper' 'clone' '--path' 'lib4/lib4_source' '--name' 
'lib4/lib4_source' '--url' 'git@github.com:company/main-repo-lib4.git' 
'--reference' '\\fileserver\Builds\reference_repos\main-repo'
10:15:13.106441 git.c:371               trace: built-in: git 
'submodule--helper' 'clone' '--path' 'lib3/lib3_source' '--name' 
'lib3/lib3_source' '--url' 'git@github.com:company/main-repo-lib3' 
'--reference' '\\fileserver\Builds\reference_repos\main-repo'
10:15:13.107441 run-command.c:369       trace: run_command: 'clone' 
'--no-checkout' '--reference' 
'\\fileserver\Builds\reference_repos\main-repo' '--separate-git-dir' 
'D:/tmp2/git_clone_tests/main-repo/.git/modules/lib3/lib3_source' 
'git@github.com:company/main-repo-lib3' 
'D:/tmp2/git_clone_tests/main-repo/lib3/lib3_source'
10:15:13.141464 git.c:371               trace: built-in: git 'clone' 
'--no-checkout' '--reference' 
'\\fileserver\Builds\reference_repos\main-repo' '--separate-git-dir' 
'D:/tmp2/git_clone_tests/main-repo/.git/modules/lib3/lib3_source' 
'git@github.com:company/main-repo-lib3' 
'D:/tmp2/git_clone_tests/main-repo/lib3/lib3_source'
10:15:13.174486 run-command.c:369       trace: run_command: 'ssh' 
'git@github.com' 'git-upload-pack '\''company/main-repo-lib3'\'''
...
>
>> The git clone documentation mentions that the reference is then passed to
>> the sub-module clone commands, so I would expect "git clone --recursive" to
>> work the same as "git submodule update", as far as --reference is concerned.
> Oh, there we have an opportunity to improve the man page (or the code).
>
>      git clone --reference --recursive ...
>
> will set the config variables
>
>      git config submodule.alternateLocation superproject
>      git config submodule.alternateErrorStrategy die (or "info" for
> --reference-if-able)
>
> and the clone for the submodules (that are an independent process, just
> run after the clone of the superproject is done) will pickup these
> config variables
> and act accordingly.
>
> If you only run
>
>      git clone --reference ...
>
> then these variables are not set. Probably they should be set such
> that the later
> invocation of "git submodule update --int" will behave the same as the git-clone
> of the superproject did.
>
> So as a workaround for you to get up to speed again, you can just set
> these config
> variables yourself before running the "submodule update --init" and it
> should work.
Ok I'll try that.
>> I noticed for a single module, doing a...
>> git submodule update --init --reference
>> \\fileserver\ref-repo\lib1\sub-module1 -- lib1/sub-module1
>> ...i.e. adding the sub-module path to the reference path, works. Which kind
>> of make sense but then how do you do to apply it to all the sub-modules?
>> (without writing a script to do that)
> I think that functionality is broken as it takes the same reference
> for all submodules,
> such that you need to go through the submodules one by one and give the
> submodule specific reference location.
I actually made a script to run it on each submodule, which works but is 
still quite slow as it cannot be parallelized (git doesn't like multiple 
submodule updates running concurrently).
>
>> If someone can confirm the problem or explain me what I am dong wrong that
>> would be great.
>>
>> Maxime
> Stefan
Thanks for you quick answer

Maxime
