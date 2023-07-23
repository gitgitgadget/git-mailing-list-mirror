Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD89C001DC
	for <git@archiver.kernel.org>; Sun, 23 Jul 2023 10:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjGWKBj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Jul 2023 06:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGWKBi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jul 2023 06:01:38 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898A310FD
        for <git@vger.kernel.org>; Sun, 23 Jul 2023 03:01:33 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31716932093so2306117f8f.3
        for <git@vger.kernel.org>; Sun, 23 Jul 2023 03:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690106491; x=1690711291;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4Cf2RYS/VyykF9n2pw3w5oHUvzC57XybMSDsg4hZkOE=;
        b=Z/0oPITE/LqgwvT/CxvCtofsAt5BoImGkqX/s9sGhXgLcqT5LXyfZU/LBGRVOoe2UV
         AYn85v5JjIba7trzaZ6pxs5QkKAKAmk0DvitAz5Z8A5dJH8r7IeXygNhh+WT7C79oSKe
         JnpbD9S9fMkJyPTQwcbZsU6A/KEqyHAzEcIjuoC7nbNFe+A1Z2bzcRhWpq1CQ5TczRew
         wKvA1vXi8bXFT+qXclW00DQhFCn16Eo/qLFwe1Frb/MsQlo1efNNQ7VmYzZ/3mSvQco3
         yWXodWLA7m7dlFKQKkVm1QCc4MTvJEnnSYF49KGSH/IAlYFjHmztVi4Jd/0zpZ9sbJsN
         Oc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690106491; x=1690711291;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Cf2RYS/VyykF9n2pw3w5oHUvzC57XybMSDsg4hZkOE=;
        b=esAbLJEBbTkfXFxGzv5DgTwSRSxaZ67w986ljr5ZROgPUOqN/TTio//SDsyK+i/07p
         ak+kT6njtjydMTY+TFDUONGQ9B3xtkUG36KOIzxf/J3PA6zwFJjS25xcLh5S0K3hWpG4
         bCBJZt4TeTSyjG9F+n/b9EOut60ddIeWhptJtVqnugi9fvsgHplCM1gGvKiPdDuvA1wY
         2+rPdlm/VU3p9L7XtXFZlbSmTjMNPsCwY8jVjJYQzB537kghgHRVoDxQ2nuuIb6m9fiH
         r/jNgF+obTaF2SeF+UXJs014HkE2pzXWf8Nx5NiN2w3/+qPZtoL8pI7D/rR881GkMerL
         dcVA==
X-Gm-Message-State: ABy/qLbXwm7S8XXNpdhfsW0hcaqqk/fCXq1ygXTGqCNRdCoPcbr6incF
        liCkZ/gPQh05lw5chXU2FLU=
X-Google-Smtp-Source: APBJJlHs74TQFZIh3ZAdr3Ec2gZFwL4uurzDuWgGZ5OiaO/IOgERLANKCNdsZrStyAb9IV+gL6swvg==
X-Received: by 2002:adf:eed1:0:b0:315:9021:6dc3 with SMTP id a17-20020adfeed1000000b0031590216dc3mr4677075wrp.27.1690106490729;
        Sun, 23 Jul 2023 03:01:30 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.235.211])
        by smtp.gmail.com with ESMTPSA id e14-20020a5d594e000000b003142eb75724sm9227051wri.24.2023.07.23.03.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jul 2023 03:01:30 -0700 (PDT)
Message-ID: <a373a659-a232-77cb-a177-a517b1f228f4@gmail.com>
Date:   Sun, 23 Jul 2023 11:01:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Lost files after git stash && git stash pop
Content-Language: en-US
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Till Friebe <friebetill@gmail.com>
Cc:     git@vger.kernel.org
References: <5260C6A0-C53C-4F6D-B899-6AD8601F8458@gmail.com>
 <20230722214433.3xfoebf7my5wsihf@tb-raspi4>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230722214433.3xfoebf7my5wsihf@tb-raspi4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/07/2023 22:44, Torsten Bögershausen wrote:
> On Fri, Jul 21, 2023 at 07:31:53PM +0200, Till Friebe wrote:
>> Thank you for filling out a Git bug report!
>> Please answer the following questions to help us understand your issue.
>>
>> What did you do before the bug happened? (Steps to reproduce your issue)
>> ```
>> git init
>> mkdir README
>> touch README/README
>> git add .
>> git commit -m "Init project"
>> echo "Test" > README/README
>> mv README/README README2
>> rmdir README
>> mv README2 README
>> git stash
>> git stash pop
>> ```
>>
>> What did you expect to happen? (Expected behavior)
>> I expected that after the `git stash pop` the README file would be back.
>>
>> What happened instead? (Actual behavior)
>> This README with "Test" file was deleted and I lost 5 hours of work.
> 
> That is always sad to hear, when work is lost.

Indeed it is. Thanks Till for providing an easy reproducer.

> However, I personally wonder if this is a bug or not.

I think whenever git overwrites an untracked file without the user 
passing some option indicating that they want to do so it is a bug. For 
example "git checkout" refuses to overwrite untracked files by default. 
Sadly this seems to be a known bug in do_push_stash() where we are using 
"git reset --hard" to remove the stashed changes from the working copy. 
This was documented in 94b7f1563a (Comment important codepaths regarding 
nuking untracked files/dirs, 2021-09-27). The stash implementation does 
a lot of necessary forking of subprocesses, in this case I think it 
would be better to call unpack_trees() directly with 
UNPACK_RESET_PROTECT_UNTRACKED.

Best Wishes

Phillip

> First, Git is told to track a file called README/README
> Then the file is removed, without telling Git.
> And a new, unkown file appers on disk (which collides with the name
> of the directory)
> 
> Using this sequence could have told Git, what is going on:
> git mv README/README README2
> rmdir README
> git mv README2 README
> 
> (a temporary branch may be checked out, with the option
>   to merge-squash the final result)
> 
> 
> An other alternative could be to tell `git stash` to care
> about untracked file(s):
> 
> git stash -u
> git stash pop
> 
> Which will refuse to apply the stash.
> 
> A third alternative could be to keep the file inside an
> editor, to have the content still available.
> 
> However, it would/could be nice, if files are not simply deleted,
> but saved into a "lost+found" folder, or a wastebasket kind of thing.
> 
> But which files ?
> Those that are untracked ?
> They may be important (local config files, passwords, help scripts, ...)
> or not (.o files from a C compiler).
> 
> In some older discussions they had been named "precious" files.
> But, as far as I remember, there was no easy solution.
> In that sense I don't have a better answer.
> Others may have.
> 
> Thanks for reporting, it make me read [1] and come to the conclusion
> that it is sometimes safer to checkout out a temporary branch, commit
> everything and clean up later, rather than relying too much on
> `git stash`
> 
> 
> <https://stackoverflow.com/questions/835501/how-do-you-stash-an-untracked-file>
>>
>> What's different between what you expected and what actually happened?
>> The file doesn't exist anymore and I can't recover it.
>>
>> Anything else you want to add:
>> This is just a reproducible example.
>>
