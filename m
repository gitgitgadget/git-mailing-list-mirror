Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB511C77B75
	for <git@archiver.kernel.org>; Sat,  6 May 2023 14:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbjEFOn4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 10:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbjEFOny (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 10:43:54 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEFA1E998
        for <git@vger.kernel.org>; Sat,  6 May 2023 07:43:42 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-61aecee26feso13111456d6.2
        for <git@vger.kernel.org>; Sat, 06 May 2023 07:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683384222; x=1685976222;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p8f06sV1Y7WtDhBDfji6tjj/lGJQyqYRArbd5Ijx7vg=;
        b=HnmL5oM7Umi4TskTK6dne5tCZ92nFwMU5Yed6NYQD6zXMEK0QjAUKmSAsSNnMzsdD7
         QV2qI8g2M1FEKoiZZ3WNo0pB4XjUqB2kg9ZIhAVKWzbbHsBcIW/WPu7IzcNdRRdU7a28
         Y7YSTcqpgLadO3NgVVJaYSmgSqE5gCT+rF1HoK1xeYyYB0Y74KB1et4uSqL0SeROJIbn
         Lc6mRTXCGrFhziuPnKtFGyNJwYBXS18YLosnNDNo6rAULWK6vX8MQC+byfWqePfNk7A5
         mdREnuljS+ajSNPQFJQugJMWMnxDRrnYmu9PzRNctVOLhWx6gVUoKSOEih8CQ+0MnHJJ
         Fk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683384222; x=1685976222;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p8f06sV1Y7WtDhBDfji6tjj/lGJQyqYRArbd5Ijx7vg=;
        b=HaGUDF7WIpIDMN83O666iPLG+GE4WQaZWVcMiLOcZ97sIgqIS6iYfcIamE3AUyMiH9
         IK9BqKbKgaKQj/7CD1WBW66igi1ONla9c73VnXKUvFHLTOjTzGfOlagN4ktnvTgarXuS
         Fu7jD/z5PvHsogSL2lNNQEFwOqhcQeUKEslYMe2lghzW7LWb54/LYgDgbg7h6MUzwGvb
         HWL+sDGhMAtz4Eg/kF1W+aZ6VfYaXAL0W3kPXAV6VbybJowqrVsOkltRtL01xWxJPZhw
         caFJQ3gPtIPPH6y0i6pL7tF7EBNF5FF4iv6zokkj7R8sgmig5b/y242J3BZRPKsu00rp
         twag==
X-Gm-Message-State: AC+VfDwMUoynCVL7JL3xfPtqTWaYZALtEhKWB5/dhhG/XZ+fbKwXpR6o
        Mi7zq2atpsUlHaM1mDq1PPE=
X-Google-Smtp-Source: ACHHUZ5R3vckGeZv8KG5+5MnUl2RCCxux6A5B2s+kivYiWbvy97sRNLqGKXwkVQT4gHt7T6JPXsXeQ==
X-Received: by 2002:ad4:5d6a:0:b0:61a:ec71:ed9a with SMTP id fn10-20020ad45d6a000000b0061aec71ed9amr7605750qvb.30.1683384221538;
        Sat, 06 May 2023 07:43:41 -0700 (PDT)
Received: from ?IPV6:2605:2a00:9005:dead::beef? ([2605:2a00:9005:dead::beef])
        by smtp.gmail.com with ESMTPSA id m3-20020a0cdb83000000b0061b77fde8b5sm1409640qvk.56.2023.05.06.07.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 07:43:41 -0700 (PDT)
Message-ID: <a611877f-c515-033c-e015-f3952b520c08@gmail.com>
Date:   Sat, 6 May 2023 10:43:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To:     Dan Stromberg <strombrg@gmail.com>, git@vger.kernel.org
References: <CAOvKW55oWs+atYyy-cTb=H0VhJx-V+M7_7FsqjdJ_jU9bR+8LA@mail.gmail.com>
Content-Language: en-US
From:   Thomas Guyot <tguyot@gmail.com>
Subject: Re: Weird merge records
In-Reply-To: <CAOvKW55oWs+atYyy-cTb=H0VhJx-V+M7_7FsqjdJ_jU9bR+8LA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 2023-04-28 11:34, Dan Stromberg wrote:
> I suspect the merge records may be coming from this small bit of shell
> script I've been using to pull from the master repo into my personal
> repo:
>      git fetch upstream
>      git checkout "$branch"
>      git config pull.rebase false
>      git pull upstream "$branch"
>      git push origin "$branch"
>
> Does that snippet look responsible? If yes, how might I change it to
> stop creating all those merge records? If no, any guesses what else
> might be causing it?

It is, indeed. This is IMHO something the developers should do 
themselves, in particular the pull may fail on conflicts and you don't 
seem to stop when it does.

First of all, that line:

git config pull.rebase false


You shouldn't change the user's config - you can instead use 
command-line switches with git-pull to force the desired behavior. In 
this case (which is also the default if there is no pull.rebase config) 
it will merge with the remote (and that merge will be a fast-forward if 
you have no added commits).

If you have local commits that aren't on the tip of the remote branch 
(i.e. someone else committed to the branch) you really have only two 
options here, merge or rebase (there is a new preserve option I think 
that I'm not familiar with, seems like rebase but preserving local 
merges). Rebase is the way to avoid merge commits, but conflicts can be 
painful to resolve if you have many commits to push.

Also note the first fetch is redundant, pull already does a fetch.

So you could change your script to:

     git checkout "$branch"
     git pull --rebase upstream "$branch" || exit 1
     git push origin "$branch"


In the case the pull fails, you will be left with conflicts to resolve - 
the instructions should be printed on screen and also shown in git-status.

Regards,

--
Thomas

