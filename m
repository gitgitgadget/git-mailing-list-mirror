Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE14C2013A
	for <e@80x24.org>; Wed, 15 Feb 2017 20:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751452AbdBOUo5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 15:44:57 -0500
Received: from homie.mail.dreamhost.com ([208.97.132.208]:41157 "EHLO
        homiemail-a4.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750806AbdBOUo4 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Feb 2017 15:44:56 -0500
X-Greylist: delayed 484 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Feb 2017 15:44:56 EST
Received: from homiemail-a4.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a4.g.dreamhost.com (Postfix) with ESMTP id 45D0D51C091
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 12:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=bit-booster.com; h=
        mime-version:in-reply-to:references:from:date:message-id:subject
        :to:cc:content-type; s=bit-booster.com; bh=0NY8lNKms+nV36FM+q2O8
        7+gfQ8=; b=oN+VeW0rddAMQYicLK1oHRTBVrnCqh8qysxkwBA+FD43B5+1Ajb/S
        0In1R2w0pF7Ssl/6pbsvi6L/+1n78pTiU31U4Rd5snSiEPWiFo/C4Nrq35w9gn98
        c40TZLm3hhzH+bel06ssYUxiknKay7NA/egdun6mFresGtdIEG8e0k=
Received: from mail-yw0-f182.google.com (mail-yw0-f182.google.com [209.85.161.182])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sylvie@bit-booster.com)
        by homiemail-a4.g.dreamhost.com (Postfix) with ESMTPSA id 350FC51C08A
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 12:44:56 -0800 (PST)
Received: by mail-yw0-f182.google.com with SMTP id u68so88000992ywg.0
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 12:44:56 -0800 (PST)
X-Gm-Message-State: AMke39nkm+rS4KtDAeGg1YrmapxZl3oLgmxidRH3n+UlGAnMijQGqA40Qvy0Q2s0YF/OFifaNW23aoyg+67qoA==
X-Received: by 10.129.124.214 with SMTP id x205mr27033289ywc.193.1487191495580;
 Wed, 15 Feb 2017 12:44:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.56.201 with HTTP; Wed, 15 Feb 2017 12:44:55 -0800 (PST)
In-Reply-To: <CAAj3zPyz8m3nGC_897k9SJOmfqvC2VczxFyphabkDho34nuPUw@mail.gmail.com>
References: <CAAj3zPx6uP5WbA68Co0yX_yh-e5C+jze2T1hJ0NYS7hHBzgdqg@mail.gmail.com>
 <CAAj3zPyz8m3nGC_897k9SJOmfqvC2VczxFyphabkDho34nuPUw@mail.gmail.com>
From:   "G. Sylvie Davies" <sylvie@bit-booster.com>
Date:   Wed, 15 Feb 2017 12:44:55 -0800
X-Gmail-Original-Message-ID: <CAAj3zPz7swme+fXXyWhhObk8u+8TL2A_QLR-uHkMhGzAWUFCow@mail.gmail.com>
Message-ID: <CAAj3zPz7swme+fXXyWhhObk8u+8TL2A_QLR-uHkMhGzAWUFCow@mail.gmail.com>
Subject: Re: how are "untracked working tree files" even possible in this case?
To:     "G. Sylvie Davies" <sylvie@bit-booster.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 15, 2017 at 12:38 PM, G. Sylvie Davies
<sylvie@bit-booster.com> wrote:
> On Wed, Feb 15, 2017 at 12:36 PM, G. Sylvie Davies
> <sylvie@bit-booster.com> wrote:
>> Hi,
>>
>> I have a script that runs the following sequence of commands within a clone:
>>
>> -----
>> /usr/bin/git rebase --abort (took 148ms)
>> /usr/bin/git cherry-pick --abort (took 103ms)
>> /usr/bin/git clean -d -f -x (took 2007ms)
>> /usr/bin/git reflog expire --expire=now --all (took 106ms)
>> /usr/bin/git reset --hard --quiet
>> 181def85d58597dfb28729029b2ad76b9fbb09f5 -- (took 60103ms)
>> /usr/bin/git merge --squash 333def1a1513f84c1eb79e5341ed6ebca0d359a1
>> (took 1795ms)
>> Err: '/usr/bin/git merge --squash 333def1a1513f84c1eb79e5341ed6ebca0d359a1'
>> Exit=128
>> error: The following untracked working tree files would be overwritten by merge:
>> .gitignore
>>
>> [...many more files...]
>>
>> Please move or remove them before you can merge.
>> Aborting
>> -----
>>
>>
>> I don't understand how untracked working tree files are possible after
>> "git clean -d -f -x" and "git reset --hard" !
>>
>> I don't have access to this particular repo, but it's around 30GB when
>> cloned (git directory plus working tree), and around 500,000 files in
>> the working tree when checked out.  Note:  the "reset --hard" takes 60
>> seconds here.
>>
>>
>
> p.s.  environment is:  Git-2.7.4 / Bitbucket-4.10.1 /
> Linux-4.4.0-59-generic (amd64)
>
>

Also, one of the "untracked files" that shows up is called
".gitmodules".    Could submodules be causing this?   (I have no
experience with submodules).


>>
>>
>> - Sylvie
